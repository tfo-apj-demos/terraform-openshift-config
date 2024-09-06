# get packagemanifests openshift operators crunch data postgres - certified
oc get packagemanifests crunchy-postgres-operator 
oc get packagemanifests crunchy-postgres-operator -o yaml

# get current channel
oc get packagemanifests crunchy-postgres-operator -o jsonpath="{range .status.channels[*]}Channel: {.name} currentCSV: {.currentCSV}{'\n'}{end}"
#output:Channel: v5 currentCSV: postgresoperator.v5.6.1

# Get catalog source
oc get packagemanifests crunchy-postgres-operator -o jsonpath={.status.catalogSource}
#output: certified-operators% 

#Get catalog source namespace
oc get packagemanifests crunchy-postgres-operator -o jsonpath={.status.catalogSourceNamespace}
#output: openshift-marketplace%

# Create a subscription yaml file
cat <<EOF > subscription.yaml
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: crunchy-postgres-operator
  namespace: postgres-operator
spec:   
    channel: v5
    name: crunchy-postgres-operator
    source: certified-operators
    sourceNamespace: openshift-marketplace
EOF

kubectl create namespace postgres-operator

