data=$1
if [ -z "$data" ];then echo "Usage: bash task.dimensions.sh data_name";exit 1;fi;
echo "param:" $data

bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 25;echo "task 1 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 2 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 75;echo "task 3 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 100;echo "task 4 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 125;echo "task 5 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 150;echo "task 6 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 175;echo "task 7 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 200;echo "task 8 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 225;echo "task 9 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 250;echo "task 10 completed"
#bash run.sh --input data/$data/edges --num-walks 5 --walk-length 25 --p 1 --q 1 --dimensions 500;echo "task 10 completed"
#bash run.sh --input data/$data/edges --num-walks 5 --walk-length 25 --p 1 --q 1 --dimensions 550;echo "task 11 completed"
#bash run.sh --input data/$data/edges --num-walks 5 --walk-length 25 --p 1 --q 1 --dimensions 600;echo "task 12 completed"
#bash run.sh --input data/$data/edges --num-walks 5 --walk-length 25 --p 1 --q 1 --dimensions 650;echo "task 13 completed"
#bash run.sh --input data/$data/edges --num-walks 5 --walk-length 25 --p 1 --q 1 --dimensions 700;echo "task 14 completed"
#bash run.sh --input data/$data/edges --num-walks 5 --walk-length 25 --p 1 --q 1 --dimensions 750;echo "task 15 completed"
#bash run.sh --input data/$data/edges --num-walks 5 --walk-length 25 --p 1 --q 1 --dimensions 800;echo "task 16 completed"
