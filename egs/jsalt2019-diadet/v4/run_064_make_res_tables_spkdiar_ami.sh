#!/bin/bash
# Copyright      2018   Johns Hopkins University (Author: Jesus Villalba)
#
# Apache 2.0.
#
. ./cmd.sh
. ./path.sh
set -e

config_file=default_config.sh

. parse_options.sh || exit 1;
. $config_file

score_dir=exp/diarization/$nnet_name/${be_diar_name}
name="$nnet_name $be_diar_name"

score_adapt_dir=exp/diarization/$nnet_name/${be_diar_ami_name}
name_adapt="$nnet_name $be_diar_ami_name"

#energy VAD
local/make_table_line_spkdiar_jsalt19_ami.sh --print-header true "$name e-vad" $score_dir
local/make_table_line_spkdiar_jsalt19_ami.sh "$name_adapt e-vad" $score_adapt_dir

echo ""

#energy VAD of enhanced data
local/make_table_line_spkdiar_jsalt19_ami_enhanced.sh --print-header true "$name e-vad" $score_dir
local/make_table_line_spkdiar_jsalt19_ami_enhanced.sh "$name_adapt e-vad" $score_adapt_dir

echo ""

#GT VAD
local/make_table_line_spkdiar_jsalt19_ami.sh --print-header true --use-gtvad true "$name" $score_dir
local/make_table_line_spkdiar_jsalt19_ami.sh --use-gtvad true "$name_adapt" $score_adapt_dir

echo ""

#GT VAD of enhanced data
local/make_table_line_spkdiar_jsalt19_ami_enhanced.sh --print-header true --use-gtvad true "$name" $score_dir
local/make_table_line_spkdiar_jsalt19_ami_enhanced.sh --use-gtvad true "$name_adapt" $score_adapt_dir
exit
