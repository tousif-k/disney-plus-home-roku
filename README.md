# Tousif's Disney+ Home Channel (Roku)
---

How to side-load this channel to your Roku device:
---

1. Clone the repo or [download the latest zip file release](https://github.com/tousif-k/disney-plus-home-roku/releases)


2. Refer to [the official Roku Developers guide](https://developer.roku.com/en-ca/docs/developer-program/getting-started/developer-setup.md) on side-loading Roku apps

- Activate Developer Mode
  - Use your Roku remote or Roku remote app and press home three times, up twice, and then right, left, right, left, right.
  - Write down the URL of your Roku device that is displayed on the screen and then enable the Development Application Installer.
  - Read and accept the Developer Tools License Agreement, which enables you to build apps with the Roku SDK and other developer tools.
  - Enter a password for your Roku device (note that passwords are case sensitive). Once you submit the password, your Roku device reboots. When the device finishes rebooting, it is activated in developer mode and ready for sideloading apps.
- Side-load the app
  - In your web browser, enter the URL of your Roku device.
  - Log in to your Roku device. In the User Name field, enter "rokudev", and then enter the password you created when you enabled developer mode.
  - The Development Application Installer in the Roku plug-in opens. You use this tool to sideload apps on your Roku device. See Roku plug-in tools for more information on the other utilities available in the Roku plug-in.
  - **Upload the *disney-home.zip* file found in the dist/ directory or from the releases page** to the Development Application Installer
  - My Disney+ Home Page Channel should launch on your Roku Device


Features
---

- Navigate Disney+ shows laid out in sets of rows in a grid layout
- At a glance information giving Title, Year of Release, and runtime length (for non-serials)
- Select to expand on more details giving Viewer Advisory Ratings, and option to view a short preview clip if available

API Used:
https://cd-static.bamgrid.com/dp-117731241344/home.json



