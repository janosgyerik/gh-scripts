#!/usr/bin/env python

import argparse
from github import Github


def main():
    parser = argparse.ArgumentParser(description='list followers of specified user')
    parser.add_argument('user', nargs=1)

    args = parser.parse_args()

    g = Github()
    user = g.get_user(args.user[0])
    followers = sorted([x.login for x in user.get_followers()])
    for follower in followers:
        print(follower)


if __name__ == '__main__':
    main()
