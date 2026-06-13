## Quick Install

Download and append the script directly to your shell profile.


### Bash
```bash
curl -s https://raw.githubusercontent.com/elahiaswat/aswh/main/scripts.sh >> ~/.bashrc && source ~/.bashrc
```

### Zsh
```bash
curl -s https://raw.githubusercontent.com/elahiaswat/aswh/main/scripts.sh >> ~/.zshrc && source ~/.zshrc
```

### Manual Setup

You can also download and add to your ~/.zshrc or bashrc profile

```bash
nano ~/.bashrc

or

nano ~/.zshrc
```

Then manually paste the content of scripts.sh

## Usage

### catfile
Looks for exact matches inside a file and opens directly at that point with nano

```bash
catfile path/to/file word #looks for 'word' inside path/to/file
```

### lstoday
Lists all files/dir created today. Use -r for recursive search inside folders.

```bash
lstoday #lists all files/dir changed today

lstoday -r #lists all files/dir changed today with content inside folders
```

### cdir
Create a new dir and cd into it

```bash
cdir aswh #creates a new dir aswh and cd into it
```

