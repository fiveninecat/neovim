# neovim

Configuration files and scripts for Neovim

**FIRST**

If using Fedora:
- Install dnf packages `gcc`, `gcc-c++`, `git`, and `neovim` as needed with `sudo dnf install {package_name}`

**SECOND**

Configure Neovim:
- Clone the Neovim Git repo to home directory:
    - Navigate to home directory with `cd`
    - Clone the repo with `git clone https://github.com/fiveninecat/neovim.git`
- Once the Neovim Git repo has been cloned, run the primary config script:
    - Run *neovim_user.sh* as regular user with `bash neovim_user.sh`
- Launch Neovim without opening any particular file with `nvim`
    - This allows nvim-treesitter to download initial configuration files?
    - Once nvim-treesitter has downloaded all initial configuration files, close neovim without saving so no actual file is created
