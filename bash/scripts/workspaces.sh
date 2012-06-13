#! /bin/bash

if [[ -z $bash_users ]] 
then
	bash_users=()
fi

if [[ -z $bash_workspaces ]] 
then
	bash_workspaces=( Public Private )
fi

for user in "${bash_users[@]}"
do
	log_info "Installing workspaces for: $user"

	user_home="$(user_get_home $user)" 
	user_group="$(user_get_primary_group $user)"

	template "$user_home/.profile.d/workspaces.sh" <<-FILE
		src "workspaces.sh.esh" 
		owner $user
		group $user_group
	FILE

	for workspace in "${bash_workspaces[@]}"
	do
		directory "$user_home/Desktop/Workspaces/$workspace" 
	done
done
