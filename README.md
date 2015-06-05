# vagrant-workspace
Vagrant Workspace for projects

Generates a vagrant development workspace including a projects folder.
Use projects to host working projects.

A user will be created in the system setup for development with Vim.

The username for the user is denoted by the 'args' variable in Vagrantfile - update this variable for the username you prefer.

The provision creates an openssh key as 'username' and a putty key as 'username.putty' in the /keys/ folder. This should allow flexibility for connection from windows or unix machines.
