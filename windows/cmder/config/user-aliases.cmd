;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here

;= Richard Frost's Aliases
;= www.richardfrost.info
;============================
;= Alias Management
;============================
aliases_orig=DOSKEY /MACROS
aliases=cat "%CMDER_ROOT%\config\aliases" | less
reload_aliases=DOSKEY /MACROFILE="%CMDER_ROOT%\config\aliases"
unalias=alias /d $1

;============================
;= General Aliases
;============================
cd=cd /D $*
clear=cls
history=cat "%CMDER_ROOT%\config\.history"
la=ls -alF --show-control-chars --color=auto $*
ll=ls -l --show-control-chars --color $*
ls=ls --show-control-chars -F --color $*
pwd=cd
ssh-copy-id=cat ~/.ssh/id_rsa.pub | ssh $* "[ ! -d ~/.ssh ] && mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys && sort -u ~/.ssh/authorized_keys -o ~/.ssh/authorized_keys"
uptime=net statistics workstation | findstr "since"
vi=vim $*
~=cd /D %HOMEPATH%

;============================
;= Git Aliases
;============================
gs=git status
gd=git diff $*
gl=git pull
gp=git push
gf=git fetch $*
ga=git add $*
gadd=git add -A
gau=git add --update
gc=git commit -v
gca=git commit -v -a
gr=git reset
greset=git reset HEAD *
glog=git log --oneline --all --graph --decorate $*
glogp=git log --pretty=format:"%h %s" --graph

;= Git Branches
gbranches=git branch -a
gbranch=git checkout -b $* && git push -u origin $*
gb=git branch $*
gco=git checkout $1

;= Git Stash
gsl=git stash list
gds=git dif stash $*
gssave=git stash save
gspop=git stash pop
gsapply=git stash apply stash@{$1}
gsdrop=git stash drop stash@{$1}

;============================
;= Program Aliases
;============================
e.=explorer .
s="%SUBLIME%" $*
s.="%SUBLIME%" .

;============================
;= Personal Aliases
;============================
c=cd /d d:\code\$*
pub_key=cat ~/.ssh/id_rsa.pub
edoras=ssh -A phermium@phlurry.homenet.org -p 3022
