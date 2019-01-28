#!/bin/sh

set -e

gcloud auth activate-service-account --key-file=/keyFile

echo "checking for exiting gke cluster"
clusterDescribeCmd="gcloud container clusters describe $name --project $projectId"

# handle opts
if [ "$zone" != " " ]; then
  clusterDescribeCmd=$(printf "%s --zone %s" "$clusterDescribeCmd" "$zone")
fi
if [ "$region" != " " ]; then
  clusterDescribeCmd=$(printf "%s --region %s" "$clusterDescribeCmd" "$region")
fi

if eval "$clusterDescribeCmd" >/dev/null 2>&1
then
  echo "found exiting gke cluster"
  exit
else
  echo "existing gke cluster not found"
fi

echo "creating gke cluster..."
clusterCreateCmd="gcloud container clusters create $name"
clusterCreateCmd=$(printf "%s --project %s" "$clusterCreateCmd" "$projectId")
clusterCreateCmd=$(printf "%s --disk-size %s" "$clusterCreateCmd" "$diskSize")
clusterCreateCmd=$(printf "%s --disk-type %s" "$clusterCreateCmd" "$diskType")
clusterCreateCmd=$(printf "%s --network %s" "$clusterCreateCmd" "$network")
clusterCreateCmd=$(printf "%s --num-nodes %s" "$clusterCreateCmd" "$numNodes")
clusterCreateCmd=$(printf "%s --machine-type %s" "$clusterCreateCmd" "$machineType")
clusterCreateCmd=$(printf "%s --max-nodes %s" "$clusterCreateCmd" "$maxNodes")
clusterCreateCmd=$(printf "%s --min-nodes %s" "$clusterCreateCmd" "$minNodes")

# handle opts
if [ "$async" = "true" ]; then
  clusterCreateCmd=$(printf "%s --async" "$clusterCreateCmd")
fi
if [ "$clusterVersion" != " " ]; then
  clusterCreateCmd=$(printf "%s --cluster-version %s" "$clusterCreateCmd" "$clusterVersion")
fi
if [ "$enableAutoscaling" = "true" ]; then
  clusterCreateCmd=$(printf "%s --enable-autoscaling" "$clusterCreateCmd")
fi
if [ "$enableAutorepair" = "true" ]; then
  clusterCreateCmd=$(printf "%s --enable-autorepair" "$clusterCreateCmd")
else
  clusterCreateCmd=$(printf "%s --no-enable-autorepair" "$clusterCreateCmd")
fi
if [ "$enableAutoupgrade" = "true" ]; then
  clusterCreateCmd=$(printf "%s --enable-autoupgrade" "$clusterCreateCmd")
fi
if [ "$enableCloudLogging" = "false" ]; then
  clusterCreateCmd=$(printf "%s --no-enable-cloud-logging" "$clusterCreateCmd")
fi
if [ "$enableCloudMonitoring" = "false" ]; then
  clusterCreateCmd=$(printf "%s --no-enable-cloud-monitoring" "$clusterCreateCmd")
fi
if [ "$enableIpAlias" = "true" ]; then
  clusterCreateCmd=$(printf "%s --enable-ip-alias" "$clusterCreateCmd")
fi
if [ "$enableNetworkPolicy" = "true" ]; then
  clusterCreateCmd=$(printf "%s --enable-network-policy" "$clusterCreateCmd")
fi
if [ "$enableKubernetesAlpha" = "true" ]; then
  clusterCreateCmd=$(printf "%s --enable-kubernetes-alpha" "$clusterCreateCmd")
fi
if [ "$enableMasterAuthorizedNetworks" = "true" ]; then
  clusterCreateCmd=$(printf "%s --enable-master-authorized-networks" "$clusterCreateCmd")
fi
if [ "$enablePrivateEndpoint" = "true" ]; then
  clusterCreateCmd=$(printf "%s --enable-private-endpoint" "$clusterCreateCmd")
fi
if [ "$enablePrivateNodes" = "true" ]; then
  clusterCreateCmd=$(printf "%s --enable-private-nodes" "$clusterCreateCmd")
fi
if [ "$masterAuthorizedNetworks" != " " ]; then
  clusterCreateCmd=$(printf "%s --master-authorized-networks %s" "$clusterCreateCmd" "$masterAuthorizedNetworks")
fi
if [ "$masterIpv4Cidr" != " " ]; then
  clusterCreateCmd=$(printf "%s --master-ipv4-cidr %s" "$clusterCreateCmd" "$masterIpv4Cidr")
fi
if [ "$nodeLocations" != " " ]; then
  clusterCreateCmd=$(printf "%s --node-locations %s" "$clusterCreateCmd" "$nodeLocations")
fi
if [ "$preemptible" = "true" ]; then
  clusterCreateCmd=$(printf "%s --preemptible" "$clusterCreateCmd")
fi
if [ "$region" != " " ]; then
  clusterCreateCmd=$(printf "%s --region %s" "$clusterCreateCmd" "$region")
fi
if [ "$subnetwork" != " " ]; then
  clusterCreateCmd=$(printf "%s --subnetwork %s" "$clusterCreateCmd" "$subnetwork")
fi
if [ "$zone" != " " ]; then
  clusterCreateCmd=$(printf "%s --zone %s" "$clusterCreateCmd" "$zone")
fi

eval "$clusterCreateCmd"