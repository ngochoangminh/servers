docker stop server-cicd
docker rm server-cicd

# Set up pipe for communicating from the REST service to host docker
PIPE_PATH=$(pwd)/exec-cicd-pipe

echo "exit" > $PIPE_PATH

OUTPUT_PATH=$(pwd)/exec-cicd-pipe-output.log
rm -rf $PIPE_PATH

mkfifo $PIPE_PATH
ls -l $PIPE_PATH
prw-r--r-- 1 root root 0 $PIPE_PATH

docker run -d -v $(pwd):/app -w /app -p 8976:8000 --name server-cicd tiangolo/uvicorn-gunicorn-fastapi bash -c "uvicorn main:app --port 8000 --host 0.0.0.0 --reload"

echo "Running event listeners"
echo "=================START LISTENING==================" >> $OUTPUT_PATH
while true; 
command=$(cat $PIPE_PATH)
if [ "$command" == "exit" ]; then
    break
fi

echo "Executing $command" >> $OUTPUT_PATH
do eval "$command" >> $OUTPUT_PATH
echo "Finished executing $command"  >> $OUTPUT_PATH
done

echo "=================END LISTENING==================" >> $OUTPUT_PATH