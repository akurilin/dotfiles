SESSION=nvim

tmux new-session -s "$SESSION" -d

tmux send -t "$SESSION":1 'cd ~/code/dotfiles' ENTER
tmux send -t "$SESSION":1 'nvim init.vim' ENTER
tmux rename-window -t "$SESSION":1 dotfiles

tmux new-window -t "$SESSION":2 -c ~/code/megarepo/haskell
tmux send -t "$SESSION":2 'nvim' ENTER
tmux rename-window -t "$SESSION":2 haskell

tmux new-window -t "$SESSION":3 -c ~/code/megarepo/frontend
tmux send -t "$SESSION":3 'nvim' ENTER
tmux rename-window -t "$SESSION":3 frontend

tmux attach-session -t "$SESSION":2
