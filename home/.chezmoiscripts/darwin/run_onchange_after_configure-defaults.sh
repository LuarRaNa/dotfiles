#!/bin/bash

set -eufo pipefail

defaults write NSGlobalDomain NSUserKeyEquivalents '{"Bottom" = "@~^\U2193"; "Center" = "@~^c"; "Fill" = "@~^f"; "Left" = "@~^\U2190"; "Right" = "@~^\U2192"; "Top" = "@~^\U2191";}'
