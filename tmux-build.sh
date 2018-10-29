SESSION=build

# TODO: if this command fails we'll want to run the Okta thing and THEN run the rest of the file, need to test that first
# IF $(AWS_PROFILE=freckle aws ecr get-login --registry-ids 853032795538 --no-include-email) FAILS
# THEN RUN OKTA THING
# THEN RUN THE ABOVE AGAIN

tmux new-session -s "$SESSION" -c ~/code/megarepo -d

# tmux send -t "$SESSION":1 'cd ~/code/megarepo' ENTER
tmux send -t "$SESSION":1 'docker-compose up' ENTER
tmux rename-window -t "$SESSION":1 ops

# give docker a few seconds to get up and running
sleep 15

tmux new-window -t "$SESSION":2 -c ~/code/megarepo
tmux send -t "$SESSION":2 '(cd haskell/backend/fancy-api && ./run-devel)' ENTER
tmux rename-window -t "$SESSION":2 haskell

# TODO: figure out how to streamline whether I want to run teacher or student watcher
tmux new-window -t "$SESSION":3 -c ~/code/megarepo
tmux rename-window -t "$SESSION":3 frontend

tmux new-window -t "$SESSION":4
tmux rename-window -t "$SESSION":4 psql
tmux send -t "$SESSION":4 'docker exec -it megarepo_postgres_1 psql -U postgres -d classroom_dev' ENTER

tmux new-window -t "$SESSION":5 -c ~/code/megarepo/sql
tmux rename-window -t "$SESSION":5 sql

tmux attach-session -t "$SESSION":1
