docker stop server-cicd
docker rm server-cicd

PIPE_PATH=$(pwd)/exec-cicd-pipe

rm -rf $PIPE_PATH