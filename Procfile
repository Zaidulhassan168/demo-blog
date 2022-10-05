web: [[ "$ANYCABLE_DEPLOYMENT" == "true" ]] && bundle exec anycable --server-command="anycable-go" || bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
