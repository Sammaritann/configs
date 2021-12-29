recording_warning=""
recording_pid=$(pgrep wf-recorder)
if [[ $? -eq 0 ]]; then
	recording_warning="Recording"
fi

volume=$(pactl get-sink-volume @DEFAULT_SINK@)
if [[ $(pactl get-sink-mute @DEFAULT_SINK@) =~ "yes" ]]; then
	volume="MUTED"
else
	volume="Volume:"$(echo $(pactl get-sink-volume @DEFAULT_SINK@) | perl -pe 's/.*?([0-9]{1,3}%).*/\1/')
fi

date_formatted=$(date +'%Y-%m-%d %H:%M:%S')

echo $recording_warning \| $volume \| $date_formatted

