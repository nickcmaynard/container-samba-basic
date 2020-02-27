```
oc new-project samba-poc
oc process -f template.yml | oc create -f -
```