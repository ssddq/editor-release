This repository generates a binary and associated Nix flake from <https://github.com/ssddq/editor>. 

**Warning.** Since builds are triggered automatically, this repository is unlikely to be actively monitored. It is entirely possible that the generated executable is deeply flawed in some way, either due to errors in the source code in the `editor` repository, or pipeline failures. *Please do not use this as more than a demo.*

Because the executable is linked against Vulkan libraries provided by a Nix shell, it may not be equally easy to run on all Linux distributions. It will likely be the easiest to run this on NixOS, where all you need to do is:

        nix run github:ssddq/editor-release

If you see something about `IOT` or a segfault, make sure that you have drivers for your GPU (e.g. `amdgpu`, `mesa`) and `vulkan-loader` installed at the system level (i.e. in `/etc/nixos/configuration.nix` or equivalent).

On other Linux distributions, you can try simply downloading and running the release binary, but I don't have any reason to believe this would work. In the event that it doesn't, you have two options:

* You can still run `nix run github:ssddq/editor` using the Nix package manager, but you will need a wrapper like [NixGL](https://github.com/guibou/nixGL).

* You can download the binary under releases and manually patch the interpreter. For example, on Arch Linux you can just run `ldd editor` to see which libraries you're missing, install those and then run:

        patchelf --remove-rpath editor
        patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 editor
        chmod +x editor

  As intimidating as this may sound, I personally prefer this second approach.
