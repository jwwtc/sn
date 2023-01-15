#! /bin/bash

[ -z "$EDITOR" ] && EDITOR=nano

# Function to create a new social network.
create() {
    if [ -d ".git" ]; then
        echo "There is a social network here already."
    else
        git init --quiet && echo "Created social network!"
        git add . 1>/dev/null 2>/dev/null
        git commit -m "Created social network." --quiet
    fi
}

# Function to join a social network.
join() {
    (git clone "$1" --quiet 1>/dev/null 2>/dev/null &&
    echo "Joined the network") ||
    echo "Either the network does not exist or it is already here."
}

# Function to update the posts.
pull() {
    git pull origin master --allow-unrelated-histories --quiet ||
    (git config pull.rebase false && 
    git pull origin master --allow-unrelated-histories --quiet) ||
    echo "You must connect to the server first (sn connect) with an existing network."
}

# Function to show a list of existing posts.
log() {
    (echo -e "These are the existing posts:\n" &&
    git log --pretty=format:"%h %s %an") ||
    echo "No network here."
}

# Function to show a specific post.
show() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git show "$1" 2>/dev/null || 
        echo "There is no post with this name."
    else
        echo "No network here."
    fi
}

# Function to connect to the server.
connect() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git remote add origin https://github.com/jwwtc/sn.git 2>/dev/null ||
        echo "Already connected."
    else
        echo "No network here."
    fi
}

# Function to post a new story.
post() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        input_string="$*"
        echo "$input_string" >> ./archive/stories.txt
        git add ./archive/stories.txt 1>/dev/null 2>/dev/null ||
        git commit -m "Added new story: $input_string" --quiet
        git push origin master --quiet && 
        echo "Posted a new story!"
    else
        echo "No network here."
    fi
}

# Function to like a specific post.
like() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if git rev-list -n 1 "$1" &> /dev/null; then
            echo "$(git config user.name) liked $1" >> ./archive/likes.txt
            git add ./archive/likes.txt
            git commit -m "Liked post: $1" --quiet
            git push origin master --quiet
        else
            echo "There is no post with this name."
        fi
    else
        echo "No network here."
    fi
}

# Function to push locally made changes.
push() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git add . 1>/dev/null 2>/dev/null
        git commit -m "latest commit" --quiet
        git push origin master --quiet
    else
        echo "No network here."
    fi
}

# Function to show the network's members.
members() {
    (git log --pretty=format:"%an" | sort | uniq) ||
    echo "No network here."
}

# Function to see the posts of a specific member.
follow() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if git log --author="$1" --pretty=format:"%h %s"; then
            echo -e "\n     These are the user's posts. \n"
        else
            echo "There is no member with this name."
        fi
    else
        echo "No network here."
    fi
}

# Main case statement to handle user input.

case $1 in
    "create")
        create
        ;;
    "join")
        join "$2"
        ;;
    "pull")
        pull
        ;;
    "log")
        log
        ;;
    "show")
        show "$2"
        ;;
    "connect")
        connect
        ;;
    "post")
        post "$2"
        ;;
    "like")
        like "$2"
        ;;
    "push")
        push
        ;;
    "members")
        members
        ;;
    "follow")
        follow "$2"
        ;;
    *)
    echo "Invalid command. Use one of the available options (shown in the man page)."
esac
