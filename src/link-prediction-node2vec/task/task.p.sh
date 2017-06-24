data=$1
if [ -z "$data" ];then echo "Usage: bash task.p.sh data_name";exit 1;fi;
echo "param:" $data

bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 0.5 --q 1 --window-size 10 --dimensions 50;echo "task 1 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p   1 --q 1 --window-size 10 --dimensions 50;echo "task 2 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 1.5 --q 1 --window-size 10 --dimensions 50;echo "task 3 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p   2 --q 1 --window-size 10 --dimensions 50;echo "task 4 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 2.5 --q 1 --window-size 10 --dimensions 50;echo "task 5 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p   3 --q 1 --window-size 10 --dimensions 50;echo "task 6 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 3.5 --q 1 --window-size 10 --dimensions 50;echo "task 7 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p   4 --q 1 --window-size 10 --dimensions 50;echo "task 8 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 4.5 --q 1 --window-size 10 --dimensions 50;echo "task 9 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p   5 --q 1 --window-size 10 --dimensions 50;echo "task 10 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 5.5 --q 1 --window-size 10 --dimensions 50;echo "task 11 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p   6 --q 1 --window-size 10 --dimensions 50;echo "task 12 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 6.5 --q 1 --window-size 10 --dimensions 50;echo "task 13 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p   7 --q 1 --window-size 10 --dimensions 50;echo "task 14 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p 7.5 --q 1 --window-size 10 --dimensions 50;echo "task 15 completed"
bash run.sh --input data/$data/edges --num-walks 8 --walk-length 25 --p   8 --q 1 --window-size 10 --dimensions 50;echo "task 16 completed"


