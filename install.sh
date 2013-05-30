#!/bin/bash
profile=$HOME/.profile
bashrc=$HOME/.bashrc
screenrc=$HOME/.screenrc
dircolors=$HOME/.dir_colors
vimrc=$HOME/.vimrc
ssh=$HOME/.ssh
gitconf=$HOME/.gitconfig

dotfiles=$HOME/Dropbox/.dotfiles

echo
echo Updating common files:
echo
# BASHRC
echo -ne -- linking "$bashrc"...
[[ -f $bashrc && ! -h $bashrc ]] && mv $bashrc ${bashrc}_bk;[[ ! -L $bashrc ]] && ln -s ${dotfiles}/.bashrc $bashrc
echo done

# SCREENRC
echo -ne -- linking "$screenrc"...
[[ -f $screenrc && ! -h $screenrc ]] && mv $screenrc ${screenrc}_bk;[[ ! -L $screenrc ]] && ln -s ${dotfiles}/.screenrc $screenrc
echo done

# VIMRC
echo -ne -- linking "$vimrc"...
[[ -f $vimrc && ! -h $vimrc ]] && mv $vimrc ${vimrc}_bk;[[ ! -L $vimrc ]] && ln -s ${dotfiles}/.vimrc $vimrc
echo done

# SSH
echo -ne -- linking "$ssh"...
[[ -f $ssh && ! -h $ssh ]] && mv $ssh ${ssh}_bk;[[ ! -L $ssh ]] && ln -s ${dotfiles}/.ssh $ssh
echo done

# GITCONFIG
echo -ne -- linking "$gitconf"...
[[ -f $gitconf && ! -h $gitconf ]] && mv $gitconf ${gitconf}_bk;[[ ! -L $gitconf ]] && ln -s ${dotfiles}/.gitconfig $gitconf
echo done

# PROFILE and DIR_COLORS - different OSs 
echo
if [[ "$OSTYPE" =~ ^darwin ]]; then
    echo Updating OSX files:
    echo
    echo -ne -- linking "$profile" and "dircolors"...
    [[ -f $profile && ! -h $profile ]] && mv $profile ${profile}_bk;[[ ! -L $profile ]] && ln -s ${dotfiles}/.profile $profile
    [[ -f $dircolors && ! -h $dircolors ]] && mv $dircolors ${dircolors}_bk;[[ ! -L $dircolors ]] && ln -s ${dotfiles}/.dir_colors $dircolors
    echo done
fi

if [[ "$OSTYPE" =~ ^linux ]]; then
    echo Updating Linux files:
    echo
    echo -ne -- linking "$profile" and "dircolors"...
    [[ -f $profile && ! -h $profile ]] && mv $profile ${profile}_bk;[[ ! -L $profile ]] && ln -s ${dotfiles}/.profile_linux $profile
    [[ -f $dircolors && ! -h $dircolors ]] && mv $dircolors ${dircolors}_bk;[[ ! -L $dircolors ]] && ln -s ${dotfiles}/.dir_colors_linux $dircolors
    echo done
fi
echo
