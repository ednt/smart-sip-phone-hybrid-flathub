# smart-sip-phone-hybrid-flathub

Flathub source repository for **Smart-SIP-Phone** (`eu.acall.smart-sip-phone-hybrid`).

**Do not edit this repository manually.** It is populated by
`build/build_flatpak.bash` in the
[smart-sip-phone-stack](https://github.com/ednt/smart-sip-phone-stack) project.

## Layout

| Path | Origin |
|------|--------|
| `eu.acall.smart-sip-phone-hybrid.yml` | Rendered Flathub manifest (curl + sha256 release archive) |
| `smart-sip-phone-launch.sh`, desktop, metainfo | Stack `build/flatpak/smart-sip-phone-hybrid/` (git) |
| `alsa-config/` | Stack `build/flatpak/smart-sip-phone-hybrid/alsa-config/` |
| Release tarball (`Smart-SIP-Phone-Hybrid`, `Icon512.png`, `extra-libs/`) | GitHub Release asset |

## Build locally (verify)

```bash
git clone https://github.com/ednt/smart-sip-phone-hybrid-flathub.git
cd smart-sip-phone-hybrid-flathub
git checkout vX.Y.Z
flatpak-builder --force-clean --install-deps-from=flathub \
  _flatpak-build _flatpak-repo eu.acall.smart-sip-phone-hybrid.yml
```

The manifest downloads the versioned release archive from GitHub Releases.
