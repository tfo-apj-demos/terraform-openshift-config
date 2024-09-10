oc get packagemanifests ansible-automation-platform-operator -o yaml



oc get packagemanifests ansible-automation-platform-operator -o jsonpath="{range .status.channels[*]}Channel: {.name} currentCSV: {.currentCSV}{'\n'}{end}"


#Channel: stable-2.4-cluster-scoped currentCSV: aap-operator.v2.4.0-0.1725257213

oc get packagemanifests ansible-automation-platform-operator -o jsonpath={.status.catalogSource}
#redhat-operator


oc get packagemanifests ansible-automation-platform-operator -o jsonpath={.status.catalogSourceNamespace}
#openshift-marketplace



#get crd
 oc get crd automationhubs.automationhub.ansible.com -o yaml > hub.txt 