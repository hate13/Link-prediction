data=$1
if [ -z "$data" ];then echo "Usage: bash task.pq.sh data_name";exit 1;fi;
echo "param:" $data

bash run.sh --input data/$data/edges --num-walks 1 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 1 completed"
bash run.sh --input data/$data/edges --num-walks 2 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 2 completed"
bash run.sh --input data/$data/edges --num-walks 3 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 3 completed"
bash run.sh --input data/$data/edges --num-walks 4 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 4 completed"
bash run.sh --input data/$data/edges --num-walks 5 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 5 completed"
bash run.sh --input data/$data/edges --num-walks 6 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 6 completed"
bash run.sh --input data/$data/edges --num-walks 7 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 7 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 8 completed"
bash run.sh --input data/$data/edges --num-walks 9 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 9 completed"
bash run.sh --input data/$data/edges --num-walks 10 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 10 completed"
bash run.sh --input data/$data/edges --num-walks 11 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 11 completed"
bash run.sh --input data/$data/edges --num-walks 12 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 12 completed"
bash run.sh --input data/$data/edges --num-walks 13 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 13 completed"
bash run.sh --input data/$data/edges --num-walks 14 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 14 completed"
bash run.sh --input data/$data/edges --num-walks 15 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 15 completed"
bash run.sh --input data/$data/edges --num-walks 16 --walk-length 25 --p 1 --q 1 --window-size 10 --dimensions 50;echo "task 16 completed"
