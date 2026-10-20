#!/bin/bash

BACKUP_DIR="/tmp/ceph-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p $BACKUP_DIR

echo "Creating Ceph configuration backup..."

# Backup cluster configuration
kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- ceph config dump > $BACKUP_DIR/ceph-config.txt

# Backup auth keys
kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- ceph auth list > $BACKUP_DIR/ceph-auth.txt

# Backup pool information
kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- ceph osd pool ls detail > $BACKUP_DIR/ceph-pools.txt

# Backup Kubernetes resources
kubectl get cephcluster -n rook-ceph -o yaml > $BACKUP_DIR/cephcluster.yaml
kubectl get cephfilesystem -n rook-ceph -o yaml > $BACKUP_DIR/cephfilesystem.yaml
kubectl get storageclass -o yaml > $BACKUP_DIR/storageclasses.yaml

echo "Backup completed in: $BACKUP_DIR"
tar -czf $BACKUP_DIR.tar.gz -C /tmp $(basename $BACKUP_DIR)
echo "Compressed backup: $BACKUP_DIR.tar.gz"
