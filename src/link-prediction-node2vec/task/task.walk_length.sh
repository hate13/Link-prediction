data=$1
if [ -z "$data" ];then echo "Usage: bash task.walk_length.sh data_name";exit 1;fi;
echo "param:" $data

bash run.sh --input data/$data/edges --num-walks 8 --walk-length 5 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 1 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 10 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 2 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 15 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 3 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 20 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 4 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 5 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 30 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 6 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 35 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 7 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 40 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 8 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 35 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 9 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 50 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 10 completed"
