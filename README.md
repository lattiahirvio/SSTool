# SSTool
This is a simple SS tool written in BASh and Python. 

## Usage
The tool is simple to use. There are two possible ways to retrieve the information the tool gathers. The 1st way is a bit more complicated.

### First way, aka discord webhooks
First, you have to make 2 discord webhooks. They can be made for the same channel, but preferably for different channels. A Guide on how to make a discord webhook can be found at [Discord's own website](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks) 

After you've made the webhooks, you'll need to make the command you'll run. In any case, the target machine should have Git installed, as that is how we will download the tool.

The base for your command should be like this:
```bash
git clone https://github.com/lattiahirvio/SSTool.git && cd SSTool && sudo sudo -E ./tool.sh -w "INSERT WEBHOOK HERE" -fw "INSERT SECOND WEBHOOK HERE" -u $USER
```

So for example, it could look like this (don't worry, the webhooks aren't real):
```bash
git clone https://github.com/lattiahirvio/SSTool.git && cd SSTool && sudo -E ./tool.sh -w "https://discord.com/api/webhooks/1221241219028357241/s8z4PSn-1LTAyNxmZfJ8SU8LFtHo8Cnuu6WHkB-dYb3-jUWfS9mwyDfdUQdh_NQuovbF" -fw "https://discord.com/api/webhooks/1221241301119537252/MIqNr8jRxT0kgzHr1mjCTTV72qIv0e9G9YhTjPNk6vqr2SQjCRZnohDg8GXXa7Hfcvuh" -u $USER
```

### The second way
The Second way is arguably a lot easier, but lacks a few features, such as sending the mods to your discord channel.

This way uses file.io to deliver the info to you, and as such doesn't require any setup on your part.
All you have to do, is run this command:
```bash
git clone https://github.com/lattiahirvio/SSTool.git && cd SSTool && sudo -E ./tool.sh -f -u $USER
```

## Features
The Tool has quite a lot of features, which are listed below:
- Checks for the most common Injection clients for Linux, such as Phantom and Doomsday
- Checks for mod deletions after game launch
- General information gathering, such as distro, bash history, disk size
- Generic JavaAgent check
- Sending the mods to a webhook
- Virtual Machine checks
- VPN Checks
- WinE Checks
- Generic string checks
- Executed processes

## Contributing
Any contributions are welcome, and pull requests will be merged as they come in. If you find falses, please report them in the "issues" section.
To Contribute to the project, create a fork, and when your modifications are ready, open a pull request.

## Credits
Huge credits to the following projects:
- [TuxTool](https://github.com/RuneGaming/TuxTool) Originally by [RuneGaming](https://github.com/RuneGaming), and a [better and more up to date fork](https://github.com/Briiqn/TuxTool) by [Briiqn](https://github.com/Briiqn)
- [777](https://github.com/RRancio/777/tree/main) by Rancio
