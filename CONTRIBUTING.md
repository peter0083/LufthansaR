# Contributing

## Introduction
The _LufthansaR_ package is developed under Github only. All contributions to the package must be made through a pull request with one of the project maintainers assigned. In this manner, no more than one maintainer is spending time trying to address the issue. Maintainers are welcome to forward the issue to another maintainer under their discretion. If the contribution is not code, a Git issue may be raised.

Making contribution implies your agreement with the [code of conduct](CONDUCT.md)

## How to Contribute Code
External code contributions can be made by forking the repository, making changes to said forked repository and making a pull request. One project maintainer of your choosing must be assigned to review the pull request to check its quality and test its compatibility. The maintainer at their discretion can forward the request to another maintainer so choose only one maintainer.

## Instructions for Maintainers
Maintainers should change code in branches apart from the master, and on the main repository. For main contributors, forks are discouraged so that it is easy to view the development of the project from the perspective of adding features. Small aesthetic changes can be pushed to the main branch to speed up workflow. Changes of code should ideally be seen in the context of the branch from which they came.

For maintainers, this means using the feature branch workflow:

| Action | Commands |
| --- | --- |
| From master branch, | `git checkout master` |
| Get updates | `git pull` |
| Create a new feature branch | `git checkout -b new-feature` |
| Make edits | |
| Stage files for commit | `git add <files>` |
| Commit | `git commit -m "Commit message"` |
| Push the branch (with its changes)| `git push -u origin new-feature` |

Sometimes, we want to make small related changes / corrections to a file that is associated with a branch. In this case, we can make changes to the branch without having to create a new one. To make additional changes to the branch, we may update it

| Action | Commands |
| --- | --- |
| Check out the feature | `git checkout feature-branch` |
| Pull potential updates | `git pull` |
| Make edits | |
| Stage files for commit | `git add <files>` |
| Commit | `git commit -m "Commit message"` |
| Push the branch (with its changes)| `git push` |

To incorporate the changes to the master branch, make a pull request from the branch to the master on Github and assign another maintainer to review the code.

## Developers
Amy Goldlist, Jomar Sastrillo , Hatice Cavusoglu, Peter Lin

## Bibliography
This document is copied almost verbatim from [hypeR Contributing](https://github.com/UBC-MDS/hypeR/blob/master/CONTRIBUTING.md).
