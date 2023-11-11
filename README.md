# perl-chain-generator

Basic text generation in perl using markov chains to train and generate text
Usage: chain.pl training/filepath.txt wordcount verbosity

## Training Files
In order to generate text, the model needs to train on some text. A good source of free, public domain text is [Project Gutenberg](https://www.gutenberg.org/) or wikipedia. The script tries to normalize text, but you may still find some anomolies. 

## Example Uses

Example to train on walden.txt and generate 100 words with some meta-info printed 

```
chain.pl corpus/walden.txt 100 1
``` 

Example to train on alice.txt and generate 200 words with verbosity of 0 - wordcount defaults to 200 and verbosity to 0

```
chain.pl corpus/alice.txt
``` 

## Example Outputs

