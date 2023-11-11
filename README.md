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

### Alice in Wonderland

The following was generated after the model trained on the first couple of chapters of Alice in Wonderland, consisting of 10284 unique trigrams. Note: this was the first output, no editing.


    beg for its dinner, and all dripping wet, cross, and I don't know the meaning of half those long words,"One side of what sort it was) scratching and scrambling about in the pictures of him), while the Dodo said,"You'd better not do that again!"And who is Dinah, and one foot up the other, trying to explain it is, it must make me grow large again, for the moment she appeared; but she did not get dry again:"O Mouse, sharply and very soon.

    So she was now about two feet high.

    Alice was not a bit,"for I know what 'it' means."Would you like cats."

    "How cheerfully he seems to grin, How neatly spread his claws, And have grown most uncommonly fat; Yet you turned a back-somersault in at the stick, and she soon made out that she wanted much to know when the race was over.

    "Well, I only knew how to speak, and some of

### Kafka

The following was generated after the model trained on a selection of text by Kafka consisting of 57271 unique trigrams.

    liars I've just been speaking, and when he suddenly turned round to see whether you know, and the left. Gregor is ill, or they would not need to but as long as possible and with a present from me, what are we to do a bit by a security guard, identifiable mainly by his feeling slightly unwell, an organisation that employs policemen who can it really not my job so much area it was his affair and the collection of samples was still leant far out towards the woman and the rest of him and then, after saying a few words with Miss B├╝rstner, that made her unable to pay attention to anything else of the usher to catch it. The violin went silent, the one called Willem."Of course it never occurred to him at his uncle even while the doors. K. noticed a small symptom of proceedings which are carried out thoroughly without lasting too long because of my fault, your uncle who's going to and fro while she herself remained standing quite close to it. And now one of the windows were

## Grimms Fairytales

The following was generated after the model trained on a large text of Grimms fair tales, consisting of 82360 unique tri-grams.

    again let anything go in peace, and that you may not be able to deck his table with his heavy hoofs, has been cutting with my own people, to make him into his eyes. When the queen living in the end of one of these lucky beings was neighbour Hans. What good thing do you come back in the air came too, the young man and his country in the yard-measure over your ears. Just let twelve spinning-wheels.'All that he had been at the third horse as he could go no farther.'Then the young man and a stately king came and wept bitterly for her, he went up to the gardener, and I want to kill her at the shoe, and commanded that his road homewards.

    As soon as the sun looked much too small for her.

    As he took him out of his life.''It is not the true one that is hanging on a spirited chestnut-horse.'The man journeyed on till he found nothing but what could he do ?

## Walden

The following was generated after the model trained on the entire text of Walden, consisting of 112,226 unique trigrams.

    goat, wolf, and spend an hour, as, if only to be helped? I have relations to men; like pygmies we fight with cranes; it opened its seams so that you could kill time without injuring eternity.

    I do not mean that exactly, which was my bed, in the last cutting, or shall we transgress them at this time. I did not hear the pot boil, and obtains them for him, that, in a tempestuous night, if for that will be thought to be taken from time to time, robbing the nests of field-sparrow, the 23d of March, after the woodchopper. It is not just at our elbows. The moon will not engage that my townsmen, nor following pack pursuing their Act├ªon. And yet my house, about the village.

    I have also a small space was two or three,-not to step into the most significant and vital experiences; you think that the shadows of some inveterate cavillers, I saw from my door, in calm weather, with

## Combined

The following output was generated after the model was trained on a combination of the above examples - resulting in a text with 251,275 unique trigrams.

    common light, so that it led into a deep valley, made to flow down the hornet, with his hands about like that?"

    I have skill at it-I never was such a one as quickly as possible to see who was watching his uncle,"he advised me.

    One summer's morning a little for himself and forgetting all about a month; and he grows big, and under her chin raised a corner. Thereupon the wild man, of your foolish chatter,'said he to his mother-" Ye are all the wealth of the very hue and cry:"'Miss Alice! It is seemingly instantaneous at last. The wedding-feast, Mr. Samsa, indicating the greatest fear, and the soldier ran on before the king, however, had been saved was set on edge?

    How long shall we sit in the same manner.

    If the forest to get this terrible, painful beating."Gregor, one of those in office becoming deeply corrupt when everything seemed under threat. But the sparrow.


