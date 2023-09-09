# rldev_pexsystem
Basic ESX permission system + admin menu

Installation:
1) Execute the SQL File
2) Add the resource to the resource folder of the server
3) Add "ensure rldev_pexsystem" to the server.cfg

Config:

Configuring the permission levels is done in the 'permission_levels' table in the database.
The 'level' field is the permission level that is assigned to a player, the script assigns the level 1 to each player that joins the server, so set to 0 each permissions for the level 1
Each field after the 'level' field is a 1 or 0 field. 1 = Permission Granted, 0 = Permission not granted

In-Game Use

To assign a permission: /givepex <user id> <permission level> //This can only be done by users with the admin permission level, this can be granted from the database at the first join. The admin permission level can be adjusted in the config file to match with the number of permission levels that will be added

Since restarting the resource will break the permission system, if the group permissions have been changed in the 'permission_levels', they can be refreshed by the means of the command (only by users with permission level equal or greater then the admin permission level of the config fiel): /refreshpex

The admin menu is opened by the command: /amenu
