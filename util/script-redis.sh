oc get packagemanifests redis-enterprise-operator-cert

# get current channel
oc get packagemanifests redis-enterprise-operator-cert -o jsonpath="{range .status.channels[*]}Channel: {.name} currentCSV: {.currentCSV}{'\n'}{end}"
#Channel: production currentCSV: redis-enterprise-operator.v7.4.6-2.0
