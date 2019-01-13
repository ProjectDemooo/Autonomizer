This is the prototype of Autonomizer

We will provide a complete guide to autonomize an application.

Videos

Flappy bird:

Training:
https://drive.google.com/open?id=1bIp5mKc-cf-GePKPeDSqGygmMs5xUzEY

Testing with internal data model (4 hr):
https://drive.google.com/open?id=1XpcJh2aBwueIeqPU233_DL2vJxjsDWoI

Testing with raw image model (24 hr):
https://drive.google.com/open?id=1t-nKOteNSXnit6kmSMNTs3GlsQYz7pc8

Mario:

Training:
https://drive.google.com/open?id=1YrMg5BVQwlvLfNQTp8jtlw2_DmZh1XSn

Testing with internal data model (7 hr):
https://drive.google.com/open?id=1GJTXUXPUgAZTjhkfMc3rQfChuOYYNsF0

Testing with raw image model (24 hr):
https://drive.google.com/open?id=1Fhl5Qo13bGBNeH7zAwvNLzq51uRUPc2w

Software Coverage testing:
https://drive.google.com/open?id=15h4qglIEfz2W21DDZk00AZgjkTEqddOV

Found bug 1:
https://drive.google.com/open?id=17_nzkUF1qutD41bvw-7yq1SGK9BSzXzf

Found bug 2:
https://drive.google.com/open?id=1Qk-Fn8s0UUfQk8wpaZtJCt5YozOX6Ots

NES-Arkanoid:

Training:
https://drive.google.com/open?id=1pLWjGfJptER7jWeosWvEdnglyUU5dytV

Testing with internal data model (12 hr):
https://drive.google.com/open?id=1OB9L4lCjFsNddPyJvWkFTwXIifrIoVfG

Testing with raw image model (24 hr):
https://drive.google.com/open?id=1NwhYYaJjd5r1IDgb06EugnvNZ5cbWZhj

Testing with raw image model (48 hr):
https://drive.google.com/open?id=1VVX6w5uq4cf2wnSOb4bBtjIX3NFh_Gq9

KVM:
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
