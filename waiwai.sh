#/bin/bash -i
set -e
if [ $# -eq 1 ]
then
    branch=$1
else
    branch=master
fi

#for i in 1 2 3; do ssh isu$i -- "git fetch origin $branch && git checkout $branch && git pull origin $branch"; done

for i in 1 2 3; do ssh isu$i -- "git fetch origin $branch"; done
for i in 1 2 3; do ssh isu$i -- "git checkout $branch 2>/dev/null || git checkout -b $branch"; done
for i in 1 2 3; do ssh isu$i -- "git reset --hard origin/$branch"; done

echo "----------pull $branch complete.----------"

for i in 1 2 3; do echo "- isu$i build..."; ssh isu$i -- "source ~/bashrc2 && cd ~/webapp/go; make"; done

for i in 1 2 3; do ssh isu$i -- "sudo systemctl stop isucholar.go.service"; done
for i in 1 2 3; do ssh isu$i -- "sudo systemctl start isucholar.go.service"; done
for i in 1 2 3; do ssh isu$i -- "sudo systemctl restart nginx"; done

