oc get packagemanifests vault-secrets-operator -o yaml
oc get packagemanifests vault-secrets-operator -o jsonpath="{range .status.channels[*]}Channel: {.name} currentCSV: {.currentCSV}{'\n'}{end}"
# Channel: stable currentCSV: vault-secrets-operator.v0.8.1

oc get packagemanifests vault-secrets-operator -o jsonpath={.status.catalogSource}
# certified-operators

oc get packagemanifests vault-secrets-operator -o jsonpath={.status.catalogSourceNamespace}
# openshift-marketplace

