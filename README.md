# smart-sip-phone-hybrid-flathub

Flathub source repository for **Smart-SIP-Phone** (`eu.acall.smart-sip-phone-hybrid`).

**Do not edit this repository manually.** It is populated automatically by
the build scripts from acall Technologie GmbH.

## Setup
```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
git clone https://github.com/ednt/smart-sip-phone-hybrid-flathub.git
cd smart-sip-phone-hybrid-flathub
```

## Optional: checkout specific release
```bash
git checkout vX.Y.Z-flathub.N
```

## Validierung (Flathub-CI)

Im Stack-Repo vor Ship oder Flathub-PR:

```bash
./build/validate_flatpak.bash              # AppStream + Manifest lint
./build/validate_flatpak.bash --full       # zusätzlich Build + repo lint
./build/validate_flatpak.bash --ship-repo  # gegen GitHub Ship-Repo main
```

Entspricht [Flathub Submission](https://docs.flathub.org/docs/for-app-authors/submission) und
[flatpak-builder-lint](https://docs.flathub.org/docs/for-app-authors/linter).

## Build

```bash
flatpak-builder \
  --force-clean \
  --install-deps-from=flathub \
  --repo=_flatpak-repo \
  _flatpak-build \
  eu.acall.smart-sip-phone-hybrid.yml
```

### Bundle

```bash
flatpak build-bundle \
  --runtime-repo=https://dl.flathub.org/repo/flathub.flatpakrepo \
  _flatpak-repo \
  smart-sip-phone-hybrid.flatpak \
  eu.acall.smart-sip-phone-hybrid
```

### Install

```bash
flatpak install --user smart-sip-phone-hybrid.flatpak
```

### Run
```bash
flatpak run eu.acall.smart-sip-phone-hybrid
```
