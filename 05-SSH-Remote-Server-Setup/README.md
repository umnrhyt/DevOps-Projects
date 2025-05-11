# SSH Remote Server Setup Projects

## Step 1: Register and Set Up a Remote Linux Server
- Choose a provider: DigitalOcean, AWS or another
- Launch an instance:
  - For DigitalOcean, create a droplet
  - For AWS, launch an EC2 dashboard with a Linux-based AMI
- Record your server's public IP address

## Step 2: Generate Two New SSH Key Pairs
```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/key1
ssh-keygen -t rsa -b 4096 -f ~/.ssh/key2
```
- Follow the prompts and specify different filenames for the keys (e.g., key1 and key2).
- This generates private keys (key1, key2) and public keys (key1.pub, key2.pub).

## Step 3: Add the Public Keys to the Server
- Connect to your server using the default key pair or credentials provided by the provider.
- Once logged in, add the public keys to the ~/.ssh/auth_keys file
```
mkdir -p ~/.ssh
echo "<content of key1.pub>" >> ~/.ssh/auth_keys
echo "<content of key2.pub>" >> ~/.ssh/auth_keys
chmod 600 ~/.ssh/auth_keys
chmod 700 ~/.ssh
```
- Test that the public keys are added by attempting to SSH into the server using the new keys.

## Step 4: Test SSH Connections
```
ssh -i ~/.ssh/key1 user@<server-ip>
ssh -i ~/.ssh/key2 user@<server-ip>
```
- Replace `<path-to-private-key>` with the actual file paths to the private keys

## Step 5: Set Up SSH config for easier access
- Create a configuration file in your local machine's ~/.ssh/ directory:
```
vim ~/.ssh/config
```
- Add the following configuration
```
Host server-alias-1
    HostName <server-ip>
    User user
    IdentityFile ~/.ssh/key1

Host server-alias-2
    HostName <server-ip>
    User user
    IdentityFile ~/.ssh/key2
```
- Save/Close the file, then test the connection using
```
ssh server-alias-1
ssh server-alias-2
```
## Step 6: Install and Configure [Fail2Ban](https://github.com/fail2ban/fail2ban)
1. Connect to your instance
```
ssh <name>
```
2. Install fail2ban
```
sudo apt update
sudo apt install fail2ban -y
```
3. Start/Enable fail2ban
```
sudo systemctl start fail2ban
sudo systemctl enable fail2ban
```
4. Configure Fail2Ban
- Create a local configuration file
```
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```
- Open/Modify `/etc/fail2ban/jail.local` to enable SSH protection
```
[sshd]
enabled = true
port = ssh
logpath = /var/log/auth.log
maxretry = 3
bantime = 500
```
5. Restart the Fail2Ban service
```
sudo systemctl restart fail2ban
sudo systemctl enable fail2ban
```

### Outcome
You should now be able to:
1. SSH into your server using either of the two SSH keys.
2. Simplify the SSH command using ~/.ssh/config.
3. Have Fail2Ban installed and configured to provide basic protection against brute-force attacks.