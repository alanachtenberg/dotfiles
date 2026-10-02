# Manual Application Installations (Linux)

Some applications cannot be installed cleanly via Homebrew on Linux or standard `apt` repositories on Debian/Ubuntu, or require manual setup. This document covers instructions for those tools on Linux.

---

## 1. JetBrains Toolbox
JetBrains Toolbox is not packaged in official Debian/Ubuntu `apt` repositories or Linuxbrew.

Please refer to the official JetBrains documentation for the latest installation instructions and prerequisites (including FUSE requirements):
👉 **[JetBrains Toolbox App Installation Guide](https://www.jetbrains.com/help/toolbox-app/installation.html)**

1. Download the official Linux archive from [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/).
2. Follow the instructions in the link above to extract and run the application.
3. Sign in to your JetBrains account and install your preferred IDEs (IntelliJ IDEA, WebStorm, PyCharm, etc.).

---

## 2. Ghostty Terminal
Ghostty is natively available in the official `apt` repositories on Ubuntu 26.04 and newer (`sudo apt install ghostty`). On Ubuntu 24.04 LTS, Debian, or other derivatives, use one of the following:

### Option A: Community PPA (Ubuntu)
```bash
sudo add-apt-repository -y ppa:mkasberg/ghostty-ubuntu
sudo apt-get update
sudo apt-get install -y ghostty
```

### Option B: Snap Store
```bash
sudo snap install ghostty --classic
```

### Option C: Official Releases
Consult the [Ghostty Installation Documentation](https://ghostty.org/docs/install) for deb packages and build instructions.
