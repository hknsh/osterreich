#!/bin/bash
set -ouex pipefail

ostree container commit
bootc container lint