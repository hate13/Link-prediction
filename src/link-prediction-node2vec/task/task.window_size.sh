data=$1
if [ -z "$data" ];then echo "Usage: bash task.window_size.sh data_name";exit 1;fi;
echo "param:" $data

bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 1;echo "task 1 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 2;echo "task 2 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 3;echo "task 3 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 4;echo "task 4 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 5;echo "task 5 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 6;echo "task 6 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 7;echo "task 7 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 8;echo "task 8 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 9;echo "task 9 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 10;echo "task 10 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 11;echo "task 11 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 12;echo "task 12 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 13;echo "task 13 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 14;echo "task 14 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --dimensions 50 --window-size 15;echo "task 15 completed"
