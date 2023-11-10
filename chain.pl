use strict;
use warnings;
# Basic text generation in perl using markov chains to train and generate text
# Usage: chain.pl training/filepath.txt wordcount verbosity
#
# Example to train on walden.txt and generate 200 words with some meta-info printed 
# chain.pl corpus/walden.txt 100 1
# 
# wordcount defaults to 200 and verbosity to 0

# define some colors for pretty printing
my $green   = "\033[0;32m";
my $white   = "\033[0;37m";
my $red     = "\033[0;31m";

# parse input arguments 
my ($input_filename, $output_wcount, $verbosity) = @ARGV;
die("Must specify input file as first argument.") unless $input_filename;
$verbosity = 0 unless $verbosity;
$output_wcount = 200 unless $output_wcount;

#run the request and print output
my $text = train_and_gen($input_filename, $output_wcount);
print("$red ---START OF OUTPUT ON NEXT LINE---\n$white") if $verbosity > 0;
print($text);
print("\n$red ---END OF OUTPUT ON PREVIOUS LINE---\n$white") if $verbosity > 0;

# will first train on input file and then generate requested word count of text
sub train_and_gen{
    print($green);
    my $fname = shift;
    my $wcount = shift;
    my @file_lines = get_file_contents($fname);
    my %ngrams = train_ngrams(3, \@file_lines);
    print_ngrams(%ngrams) if $verbosity > 1;
    my $unique_count = %ngrams;
    print("Made $unique_count unique ngrams\n")  if $verbosity > 0;
    my %matrix = make_bigram_transitions(%ngrams);
    print("Completed transitions\nGenerating text...\n")  if $verbosity > 0;
    print_transitions(%matrix)  if $verbosity > 1;

    my $text_out = gen_text(\%matrix, $wcount);
    $text_out = condition_output($text_out);
    
    return $text_out;
}

# normalizes text before output.
sub condition_output{
    my $t = shift @_;
    $t =~ s/ ([,.!?:;] )/$1/g;
    $t =~ s/ (["'\-]) /$1/g;
    $t =~ s/<br\/>/\n\n/g;
    return $t;
}

# core generation function - words on passed in weighted transition matrix
sub gen_text{
    my $trans_matrix = shift @_;
    my $count = shift @_;
    
    my @grams = keys %$trans_matrix;
    my $from_words = $grams[rand @grams];
    my $text = $from_words;
    
    for(1..$count){
        my $next_word = get_weighted_transition($from_words, $trans_matrix);
        if($next_word){
            $text = "$text $next_word";
            my @fields = split(" ", $from_words);
            $from_words = "$fields[1] $next_word";
        }
        else{
            $from_words = $grams[rand @grams];
            $text = "$text $from_words";    
        }
    }
    
    return $text;
}

# utility function to print out the ngram hash
sub print_ngrams{
    my (%grams) = @_;
    for( keys %grams){
        my $hkey = $_;
        for my $gram (@{$grams{$hkey}{'grams'}}){
            print("<$gram>");
        }
        print( " - ", $grams{$hkey}{'total_count'});
        print("\n");
    }
}

#utility function to print out the weighted transition matrix
sub print_transitions{
    my (%trans_matrix) = @_;
    for( keys %trans_matrix){
        my $tkey = $_;
        print( "BIGRAM: $tkey\n" );
        print( "-Total: ", $trans_matrix{$tkey}{'total_count'},"\n");
        my @weights = @{$trans_matrix{$tkey}{'weights'}};
        my @transitions = @{$trans_matrix{$tkey}{'transitions'}};
        my $len = @weights;
        for(my $i=0; $i<$len; $i++){
            print("---|", $transitions[$i], " - ", $weights[$i], "\n");
        }
    }
}

sub choose_weighted
{
    my @weights = @{$_[0]};
    my $acc = 0;
    my @acc_arr;

    foreach (@weights){
        $acc += $_;
        push(@acc_arr, $acc);
    }
    my $rand_val = $acc * rand;
    my $i = 0;
    ++$i while ($acc_arr[$i] <= $rand_val);

    return $i;
}

sub get_weighted_transition{
    my $gram = shift(@_);
    my $trans_matrix = shift(@_);
    return unless(exists $trans_matrix->{$gram});
    
    my $len = @{$trans_matrix->{$gram}{'weights'}};
    return unless($len);
    
    my $i = choose_weighted($trans_matrix->{$gram}{'weights'});
    return $trans_matrix->{$gram}{'transitions'}[$i];
}


sub make_bigram_transitions{
    my (%grams) = @_;
    my %trans_matrix = ();

    for(keys %grams){
        my $gkey = $_;
        my @grams_array = @{$grams{$gkey}{'grams'}}; 
        my @trans_from = ($grams_array[0], $grams_array[1]);
        my $trans_key = join(" ", @trans_from);
        my $trans_to = $grams_array[2];
      
        # first time we've seen this n-gram
        unless(exists($trans_matrix{$trans_key})){
            my %this_transition = (
                from_array => \@trans_from,
                total_count => 0
            );
            $trans_matrix{$trans_key} = \%this_transition;
        }

        #print($trans_matrix{$trans_key}{$trans_to}, "\n");
        unless(exists($trans_matrix{$trans_key}{$trans_to})){
            $trans_matrix{$trans_key}{$trans_to} = 0;
        }
        
        # increment the total times this has been seen
        $trans_matrix{$trans_key}{$trans_to} += $grams{$gkey}{'total_count'};
        $trans_matrix{$trans_key}{'total_count'}+=$grams{$gkey}{'total_count'};

    }

    for(keys %trans_matrix){
        my $mkey = $_;
        my @weights = ();
        my @transitions = ();
        #get the weights and transition for this bigram
        for(keys %{$trans_matrix{$mkey}}){
            my $tkey = $_;
            if($tkey ne "total_count" && $tkey ne "from_array"){
                my $percent = $trans_matrix{$mkey}{$tkey}/$trans_matrix{$mkey}{'total_count'};
                $trans_matrix{$mkey}{$tkey} = $percent;
                push(@weights, $percent);
                push(@transitions, $tkey);

            }
        }
        #now add these as members of our matrix
        $trans_matrix{$mkey}{'weights'} = \@weights;
        $trans_matrix{$mkey}{'transitions'} = \@transitions;
        my $wlen = @weights;
        unless($wlen){
            print("$mkey doesnt exist!!\n");
        }
    }
    return %trans_matrix;
}

sub train_ngrams{
    my $n = shift; 
    my $lines = shift;
    
    my %ngrams = ();
    my @buffer = ();

    for my $line (@$lines){
        
        # condition the line for parsing
        chomp $line;
        #normalize quotes
        $line =~ s/\n/ /g;
        $line =~ s/(“)/"/g;
        $line =~ s/(”)/"/g;
        $line =~ s/(’)/'/g;
        $line =~ s/(‘)/'/g;
        $line =~ s/(—)/-/g;
        #make sentence structure be tokens
        $line =~ s/([,.!?\-;:"])/ $1 /g;
        #normalize spaces
        $line =~ s/ +/ /;

        if($line eq ""){
            $line = "<br/>";
        }

        #go through each word
        for (split(" ", $line)){
            my $word = $_;
            push(@buffer, $word);

            if( @buffer >= $n){
                #make unique key from words
                my $hash_key = join("-", @buffer);
                
                if(exists($ngrams{$hash_key})){
                    $ngrams{$hash_key}{"total_count"}++;
                }
                else{
                    #then initialize it
                    my @grams_array = @buffer;
                    my %this_gram = (total_count => 1,
                                        grams => \@grams_array
                    );
                    $ngrams{$hash_key} = \%this_gram;
                }

                #pop first element 
                shift(@buffer);
            }
        }
        
    }
    return %ngrams;
}

sub get_file_contents{
    my $fname = shift @_;
    my @lines = ();

    open(FH, "<", $fname ) or die $!;
    while(<FH>){
        push(@lines, $_);
    }
    close(FH);
    return @lines;
}

