# sn - A Command-Line Social Network based on Git.

## Description

sn is a shell script for creating and interacting with decentralized social networks. It leverages the functionality of the Git version control system to allow for offline usage and data storage.

## Setup

```
git clone https://github.com/jwwtc/sn.git
export PATH="$PATH:/`pwd`/sn/"
```

## Features

- `sn create`: Create a new social network.
- `sn join [link]`: Join an existing social network.
- `sn pull`: Pull in new posts and likes.
- `sn log`: Show a list of existing posts in the network.
- `sn show [post]`: Show a specific post in the network.
- `sn connect [link]`: Connect to a server.
- `sn post "[text]"`: Post a new story to the network.
- `sn like [post]`: Like a specific post.
- `sn push`: Push locally made changes back to the server.
- `sn members`: Show the netowrk's members.
- `sn follow [user]`: Follow the posts of a specific member.

## License

This project is licensed under the [MIT License](https://github.com/jwwtc/sn/blob/master/LICENSE).

## Acknowledgments

- [Git](https://git-scm.com/) - Distributed version control system
