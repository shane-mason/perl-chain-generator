# perl-chain-generator

Basic text generation in perl using markov chains to train and generate text
Usage: chain.pl training/filepath.txt wordcount verbosity

Example to train on walden.txt and generate 200 words with some meta-info printed 

chain.pl corpus/walden.txt 100 1
 
wordcount defaults to 200 and verbosity to 0