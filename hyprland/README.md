## Fixing NVIDIA slowdown with hybrid graphics
Follow https://wiki.hypr.land/Configuring/Multi-GPU/#creating-consistent-device-paths-for-specific-cards
Make sure to run the script twice (dedicated + integrated).
What worked for me:
```
# ~/.config/uwsm/env-hyprland
export AQ_FORCE_LINEAR_BLIT=0
export AQ_DRM_DEVICES="/dev/dri/nvidia-gpu:/dev/dri/amd-igpu"
```
