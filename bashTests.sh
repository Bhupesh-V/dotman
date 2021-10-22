for v in 3 4 5; do
  docker run -v "$PWD:/mnt" "bash:$v" \
    bash dotman.sh
done
