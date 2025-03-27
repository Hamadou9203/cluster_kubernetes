dans ce projet nous creons une infrastructure sur AWS avec terraform (1 bastion , 1 serveur ansible, 1 master et 2 worker) afin de deployer kuberetes avec des playbook ansible 

```
.
├── README.md
├── bastion_node.yaml
├── files
│   ├── config.toml
│   └── crictl.yml
├── hosts.yaml
├── infra_terraform
│   ├── app
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   └── variable.tf
│   ├── modules
│   │   ├── ec2_modules
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variable.tf
│   │   ├── natgw_modules
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variable.tf
│   │   ├── sg_modules
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variable.tf
│   │   ├── subnet_modules
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variables.tf
│   │   └── vpc_modules
│   │       ├── main.tf
│   │       ├── output.tf
│   │       └── variables.tf
│   └── out
│       └── info-ec2.txt
└── kube_node.yml
```


installation du network calico
```
kubectl create -f https://docs.projectcalico.org/manifests/calico.yaml
```



```
ubuntu@ip-10-31-2-151:~$ k get node
NAME               STATUS   ROLES           AGE     VERSION
ip-10-31-101-148   Ready    control-plane   28m     v1.31.1
ip-10-31-102-251   Ready    <none>          4m17s   v1.31.1
ip-10-31-102-76    Ready    <none>          2m1s    v1.31.1
```

tests
```
ubuntu@ip-10-31-2-151:~$ k get pods
NAME                     READY   STATUS    RESTARTS   AGE
nginx-676b6c5bbc-5r2dj   1/1     Running   0          7s
```
