0. Setup
  - Check support:
    - egrep -c '(svm|vmx)' /proc/cpuinfo
      - Result: Not zero means CPU supports hardware virtualization
  - Install
    - sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker virt-manager
  - Validate installation
    - kvm-ok
      - Result: Following message shows that kvm can be used 
        INFO: /dev/kvm exists
        KVM acceleration can be used

  - Create VM:
    - virt-manager
      - domain name: ubuntu16
      - Network mode: NAT
      - snapshot name: snap (will be used later using command line)

1. Start VM
  - virsh start ubuntu16

2. Shutdown VM
  - virsh destroy ubuntu16

3. Create snapshot
  - virsh snapshot-create-as --domain ubuntu16 --name snap

4. Revert snapshot 
  - virsh snapshot-revert --domain ubuntu16 --snapshotname snap

5. Delete snapshot
  - virsh snapshot-delete ubuntu16 snap
