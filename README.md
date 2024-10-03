# VS Code Perl Dev Container

## Introduction

This is a customized VS Code Dev container definition to provide a basic friendly
environment to Perl development.

## Requirements

- Dev Containers extension installed.
- Docker installed.

## How to use it

If you has just cloned a repository and the project already has a empty 
.devcontainer folder, it's probably already using the submodule. In this case,
you should run two commands to initialize you local git configuration:

```
git submodule init && git submodule update
```

If you project doesn't have a .devcontainer folder yet, add this git repository 
as a submodule into you Perl project using the cli below:

```
git submodule add git@github.com:samueldc/vscode-perl-dev-container-otrs.git .devcontainer
```

Then, you should click on the Dev Containers extension icon in the VS Code status
bar (the same icon used for Remote Connection) and choose 'Reopen in container'.

To update the submodule from time to time, use the cli below:

```
git submodule update --remote .devcontainer
```

## Usefull links

- [VS Code Dev Containers documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Github official Dev Containers organization](https://github.com/devcontainers)
- [JSON reference](https://containers.dev/implementors/json_reference/)