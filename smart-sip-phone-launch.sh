#!/bin/sh
set -e

PROGRAM_NAME="Smart-SIP-Phone-Hybrid"

# Flatpak sets XDG_DATA_HOME to ~/.var/app/<id>/data but leaves HOME at the host
# home directory. PureBasic maps ProgramData to $HOME/.local/share on Linux, so
# point HOME at the per-app sandbox and keep data under .local/share there.
if [ -n "${FLATPAK_ID:-}" ]; then
  SANDBOX_HOME="${XDG_DATA_HOME%/data}"
  export HOME="$SANDBOX_HOME"
  APP_DATA_DIR="${HOME}/.local/share/${PROGRAM_NAME}"
  LEGACY_DATA_DIR="${XDG_DATA_HOME}/${PROGRAM_NAME}"
  if [ -d "$LEGACY_DATA_DIR" ]; then
    mkdir -p "$APP_DATA_DIR"
    cp -an "$LEGACY_DATA_DIR"/. "$APP_DATA_DIR"/ 2>/dev/null || true
  fi
else
  APP_DATA_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/${PROGRAM_NAME}"
fi

mkdir -p "$APP_DATA_DIR"
touch "${APP_DATA_DIR}/extract_on_next_start"
export WEBKIT_DISABLE_DMABUF_RENDERER="${WEBKIT_DISABLE_DMABUF_RENDERER:-1}"
export GDK_BACKEND="${GDK_BACKEND:-x11}"
export PATH="/app/bin:${PATH}"
export LD_LIBRARY_PATH="/app/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"

# PipeWire/PulseAudio: Host-Sockets fuer ALSA (aplay/arecord) und pw-mon (Geraete hotplug)
runtime_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
if [ -S "${runtime_dir}/pulse/native" ]; then
  export PULSE_SERVER="unix:${runtime_dir}/pulse/native"
fi
if [ -d "${runtime_dir}/pipewire-0" ]; then
  export PIPEWIRE_RUNTIME_DIR="${runtime_dir}/pipewire-0"
fi
export ALSA_CONFIG_PATH="${ALSA_CONFIG_PATH:-/usr/share/alsa/alsa-flatpak.conf}"
unset ALSA_CONFIG_DIR

exec /app/bin/"${PROGRAM_NAME}" "$@"
