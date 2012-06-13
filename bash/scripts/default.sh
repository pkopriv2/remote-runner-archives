#! /bin/bash

archive_file "/etc/profile" <<-FILE
	src "profile"
FILE

directory "/etc/profile.d" 

archive_file "/etc/profile.d/history.sh" <<-FILE
	src "profile.d/history.sh"
FILE

archive_file "/etc/profile.d/dircolors.sh" <<-FILE
	src "profile.d/dircolors.sh"
FILE

bash_users=${bash_users:-()}
for user in "${bash_users[@]}"
do
	log_info "Setting up bash for [$user]"

	user_home="$(user_get_home $user)" 
	user_group="$(user_get_primary_group $user)"

	archive_file "$user_home/.profile" <<-FILE
		src ".profile"
		owner $user
		group $user_group
	FILE
	
	archive_file "$user_home/.bash_profile" <<-FILE
		src ".bash_profile"
		owner $user
		group $user_group
	FILE

	directory "$user_home/.profile.d" <<-DIR
		owner $user
		group $user_group
	DIR
done
