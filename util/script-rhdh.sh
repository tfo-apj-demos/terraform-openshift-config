oc get packagemanifests rhdh


# get current channel
oc get packagemanifests rhdh -o jsonpath="{range .status.channels[*]}Channel: {.name} currentCSV: {.currentCSV}{'\n'}{end}"