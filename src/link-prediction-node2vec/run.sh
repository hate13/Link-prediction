#!/bin/bash
#
# For example: bash run.sh --input data/facebook/edges --num-walks 10 --walk-length 30 --dimensions 128 --p 0.2 --q 0.8

# output path
outpath=output

echo "params:$@"
input=`echo "$@" | awk '{print $2}'`

# compile
echo "compiling..."
g++ src/preprocess.c -o $outpath/preprocess && g++ src/predict.c -o $outpath/predict
if [ $? -ne 0 ];then exit 1;fi

# preprocess: randomly remove about 50% edges
$outpath/preprocess $input $outpath/nodes $outpath/training.data $outpath/testing.data

# node2vec: random walk
echo "learning..."
python src/main.py --input $outpath/training.data  `for i in $* ; do echo $i; done` --output $outpath/vector.out
if [ $? -ne 0 ];then exit 1;fi

# do job with vector
echo "predicting..."
auc=`$outpath/predict $outpath/nodes $input $outpath/testing.data $outpath/vector.out`
echo "`for i in $* ; do echo -n "$i "; done` $auc" >> log
echo $auc

rm $outpath/preprocess
rm $outpath/predict
