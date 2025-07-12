# österreich.

Universal Blue's Aurora-dx image with some touch-ups.

It is named after [Kunimitsu Takahashi's](https://x.com/isadora_duncan_) solo project, [österreich](https://soundcloud.com/onlyifyoucallme).

As stated before, it uses Aurora-dx as base, providing Fedora Kinoite (KDE Plasma) with Developer Experience tools. **It doesn't come with NVIDIA drivers.**

## How to Rebase to this image.

To switch an existing `bootc`-compatible system to this image:
```bash
sudo bootc switch ghcr.io/hknsh/osterreich:latest
```

Then reboot. You can check status with: `sudo bootc status`.

## Acknowledgements.

A huge thanks to [**fptbb**](https://github.com/fptbb/fp-os) and everyone who inspired his project. 

## License.

This project is licensed under the Apache License 2.0. Check [LICENSE](LICENSE) file for details.