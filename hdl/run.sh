#!/usr/bin/env bash

poetry run pytest &&
# poetry run verify &&
# sby -f verify_packetizer.sby --prefix artifacts/ &&
poetry run build &&
./split_modules.pl