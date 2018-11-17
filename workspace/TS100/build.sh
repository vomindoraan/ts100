#!/bin/bash
TRANS_DIR="../../Translation Editor"

python "$TRANS_DIR/make_translation.py" "$TRANS_DIR"

make clean

for model in "TS100" "TS80"; do
    for f in "$TRANS_DIR"/translation_*.json; do
        lang_json=${f#*_}     # Remove ".../translation_"
        lang=${lang_json%.*}  # Remove ".json"
        lang=${lang^^}        # Convert to uppercase

        # Build firmware
        make -j16 model="$model" lang="$lang"
        rm -rf Objects/src
    done
done
