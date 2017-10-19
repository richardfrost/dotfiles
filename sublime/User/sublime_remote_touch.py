# Skeduna Zeus Plugin - Remote Touch
#   Because Zeus can't detect changes on a shared VM folder,
#   We 'vagrant ssh' to the machine and touch the file if it
#   is contained in the path inside 'needle' below.

# Setup:
#   1. Copy the plugin (remote_touch.py) to your Sublime Text User folder
#     1. Windows: `%AppData%\Sublime Text 3\Packages\User`
#     2. Mac: `~/Library/Application Support/Sublime Text 3/Packages/User`
#     3. Linux: `~/.config/sublime-text-3/Packages/User`
#   2. Set variables in plugin:
#     1. `needle`
#     2. `ssh_dest` (Optional)
#     3. `dest_project_root` (Optional)
#   3. Run `vagrant ssh-config` inside the project folder (lemma)
#   4. Copy the output of the command to:
#     1. Windows: `%UserProfile%\.ssh\config`
#     2. Mac: `~/.ssh/config`
#     3. Linux: `~/.ssh/config`
#   5. Change first line from 'Host default' to 'Host vagrant' inside the config file from above
#   6. Windows: Ensure that the ssh binary is in your system's path (be able to open CMD and run `ssh`)
#   7. You should now be able to ssh to the vagrant box with `ssh vagrant@vagrant`
#   8. Restart Sublime Text and start coding! May Zues smile upon your work!
import sublime, sublime_plugin, subprocess

class RemoteTouch(sublime_plugin.EventListener):
    def on_post_save_async(self, view):
        # Variables (See step 2)
        needle = "D:\\Git\\Skeduna\\lemma";
        ssh_dest = "vagrant@vagrant";
        dest_project_root = "/skeduna/lemma";

        file_name = view.file_name();
        if needle in file_name:
            project_root = view.window().folders()[0];
            relative_path = file_name.replace(project_root, "");
            relative_path = relative_path.replace('\\', '/');
            command = "ssh -t " + ssh_dest + " 'touch " + dest_project_root + relative_path + "'";
            print("[RemoteTouch] Command: " + command);
            # os.system(command); # Sublime Text 2
            subprocess.Popen(command, shell=True); # Sublime Text 3
