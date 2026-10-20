#!/bin/bash

echo "=== Ceph Cluster Health ==="
kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- ceph status

echo -e "\n=== Pool Statistics ==="
kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- ceph df

echo -e "\n=== OSD Performance ==="
kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- ceph osd perf

echo -e "\n=== PG Statistics ==="
kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- ceph pg stat

echo -e "\n=== Storage Utilization ==="
kubectl get pv
kubectl get pvc --all-namespaces

echo -e "\n=== Pod Storage Usage ==="
kubectl top pods --all-namespaces --containers
