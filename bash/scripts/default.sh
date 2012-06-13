#! /bin/bash

archive_file "/etc/profile" <<-FILE
	src "etc_profile
FILE

directory "/etc/profile.d"

archive_file "/etc/profile.d/history.sh" <<-FILE
	src "profile.d/history.sh"
FILE


bash_users=${bash_users:-()}
for user in "${bash_users[@]}"
do
	group="$(user_get_primary_group $user)"

	archive_file "$(user_get_home $user)" <<-FILE
		src ".profile"
		owner $user
		group 
	FILE

	directory "~/.profile.d" <<-DIR
		owner $user
		group $group
		permissions "755"
	DIR
done
