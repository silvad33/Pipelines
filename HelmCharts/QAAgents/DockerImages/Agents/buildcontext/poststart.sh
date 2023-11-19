cleanup() {
  if [ -e config.sh ]; then
    # If the agent has some running jobs, the configuration removal process will fail.
    # So, give it some time to finish the job.
    while true; do
      /myagent/config.sh remove --unattended --auth pat --token $ADO_PAT && break
      echo "Retrying in 30 seconds..."
      sleep 30
    done
  fi
}

trap 'cleanup; exit 0' EXIT
trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

echo "nonroot" | su nonroot -c "/myagent/config.sh --unattended --url $ADO_ORG_URL --auth pat --token $ADO_PAT --pool \"$AGENT_POOL\" --agent $(hostname) & wait $!"

cd /myagent/
chmod +x ./run-docker.sh

echo "nonroot" | su nonroot -c "./run-docker.sh \"$@\" & wait $!"