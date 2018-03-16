ListNet
=======

Implementation of the listwise Learning to Rank algorithm described in the paper by Zhe Cao, Tao Qin, Tie-Yan Liu, Ming-Feng Tsai, and Hang Li "Learning to rank: from pairwise approach to listwise approach"

http://doi.acm.org/10.1145/1273496.1273513

Installation
------------

ListNet requires GNU Octave and the packages the octave-general and octave-parallel

Running ListNet
---------------

Training:

$ cd src
$ ./train.m ../sample/sample_training_data.m ../sample/sample_model.m

Prediction:

$ ./predict.m ../sample/sample_model.m ../sample/sample_test_data.m

Cross-validation:

$ ./crossvalidation.m ../sample/sample_test_data.m ../sample/sample_model.m 
