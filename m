Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAF95FC79
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGDR1H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 13:27:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:49452 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfGDR1H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 13:27:07 -0400
Received: by mail-io1-f69.google.com with SMTP id x24so7043890ioh.16
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2019 10:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+ckv+0WrhaxeQEbpu2q6SqXs3H2kbCnAmk6iBaEMyWw=;
        b=E87JYiejfTAW5QVU6ZE2Z6RWUNX8Z94XNqS9uOdsSJUU/JNv9/FiXTkf7VeA0Az6T8
         99EqcTNG5qCH1wBs0/f93V7sXkC8tJqN/8Zh0B20tijYq+/LDsiOA83QhznxHBS23mgW
         DZqg5ksgtXOIK8o+uBgAFt5nXenyo1b4u1ZK+puIwM95CXnrWifpuiCPGVCxxsPHbg9r
         7sbMn0tPV8eh4OdyesPDBr/JMik3qj7gTOFSi6eExrBpSCYRQ7HmPSXo3Gt4JZeX5U6R
         3hSXsxxekLzZJsLGmE7dZk1PDLv3XRAywL3AXgVjgsvwZEyK0ciHKS1rGuD0KNlNcmxj
         8+YA==
X-Gm-Message-State: APjAAAWVOuWeRuUHBX8zH9V4+De7R1f5N8uG4Ds773HpON8gcXX+ZC/c
        Otq6qXz4DTfld/Fq5Mkqu33YAFyi/KDZVCbbAPfrXsFAjtrS
X-Google-Smtp-Source: APXvYqz8ZrYmHBoJ7K1X4y40/57uf0jHTqxK+KQ22g/HRFhgoURCRzfc4BWiUfuNVTW7Padn5GCiDvzExistCXpwAL3kst5ZymF0
MIME-Version: 1.0
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr3058779jan.90.1562261224936;
 Thu, 04 Jul 2019 10:27:04 -0700 (PDT)
Date:   Thu, 04 Jul 2019 10:27:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bf6c3058cde49a7@google.com>
Subject: linux-next boot error: WARNING in corrupted
From:   syzbot <syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    16c474c9 Add linux-next specific files for 20190704
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f8b463a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=983f02aae1ef31b6
dashboard link: https://syzkaller.appspot.com/bug?extid=de771ae9390dffed7266
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com

smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.30GHz (family: 0x6, model: 0x3f,  
stepping: 0x0)
Performance Events: unsupported p6 CPU model 63 no PMU driver, software  
events only.
rcu: Hierarchical SRCU implementation.
NMI watchdog: Perf NMI watchdog permanently disabled
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
MDS CPU bug present and SMT on, data leak possible. See  
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for  
more details.
smp: Brought up 2 nodes, 2 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 2 processors activated (9200.00 BogoMIPS)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:  
19112604462750000 ns
futex hash table entries: 512 (order: 4, 65536 bytes, vmalloc)
xor: automatically using best checksumming function   avx
PM: RTC time: 12:27:33, date: 2019-07-04
NET: Registered protocol family 16
audit: initializing netlink subsys (disabled)
cpuidle: using governor menu
ACPI: bus type PCI registered
dca service started, version 1.12.1
PCI: Using configuration type 1 for base access
WARNING: workqueue cpumask: online intersect > possible intersect
HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
cryptd: max_cpu_qlen set to 1000
raid6: avx2x4   gen() 12091 MB/s
raid6: avx2x4   xor()  6705 MB/s
raid6: avx2x2   gen()  7359 MB/s
raid6: avx2x2   xor()  3820 MB/s
raid6: avx2x1   gen()  3746 MB/s
raid6: avx2x1   xor()  2047 MB/s
raid6: sse2x4   gen()  6209 MB/s
raid6: sse2x4   xor()  3539 MB/s
raid6: sse2x2   gen()  3607 MB/s
raid6: sse2x2   xor()  2014 MB/s
raid6: sse2x1   gen()  1877 MB/s
raid6: sse2x1   xor()  1038 MB/s
raid6: using algorithm avx2x4 gen() 12091 MB/s
raid6: .... xor() 6705 MB/s, rmw enabled
raid6: using avx2x2 recovery algorithm
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
ACPI: 2 ACPI AML tables successfully acquired and loaded
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and  
report a bug
ACPI: Enabled 16 GPEs in block 00 to 0F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended  
PCI configuration space under this bridge.
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
pci 0000:00:01.0: [8086:7110] type 00 class 0x060100
pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000
pci 0000:00:03.0: reg 0x10: [io  0xc000-0xc03f]
pci 0000:00:03.0: reg 0x14: [mem 0xfebfe000-0xfebfe07f]
pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000
pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
pci 0000:00:04.0: reg 0x14: [mem 0xfebff000-0xfebff07f]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
vgaarb: loaded
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
mc: Linux media interface: v0.10
videodev: Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti  
<giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Advanced Linux Sound Architecture Driver Initialized.
PCI: Using ACPI for IRQ routing
Bluetooth: Core ver 2.22
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
NET: Registered protocol family 8
NET: Registered protocol family 20
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
nfc: nfc_init: NFC Core ver 0.1
NET: Registered protocol family 39
clocksource: Switched to clocksource kvm-clock
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
FS-Cache: Loaded
*** VALIDATE hugetlbfs ***
CacheFiles: Loaded
TOMOYO: 2.6.0
Mandatory Access Control activated.
AppArmor: AppArmor Filesystem Enabled
pnp: PnP ACPI init
pnp: PnP ACPI: found 7 devices
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns:  
2085701024 ns
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes,  
vmalloc)
TCP established hash table entries: 65536 (order: 7, 524288 bytes, vmalloc)
TCP bind hash table entries: 65536 (order: 10, 4194304 bytes, vmalloc)
TCP: Hash tables configured (established 65536 bind 65536)
UDP hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NET: Registered protocol family 44
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
PCI: CLS 0 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0xaa800000-0xae800000] (64MB)
RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl  
timer
kvm: already loaded the other module
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x212735223b2,  
max_idle_ns: 440795277976 ns
clocksource: Switched to clocksource tsc
mce: Machine check injector initialized
check: Scanning for low memory corruption every 60 seconds
Initialise system trusted keyrings
workingset: timestamp_bits=40 max_order=21 bucket_order=0
zbud: loaded
DLM installed
squashfs: version 4.0 (2009/01/31) Phillip Lougher
FS-Cache: Netfs 'nfs' registered for caching
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ntfs: driver 2.1.32 [Flags: R/W].
fuse: init (API version 7.31)
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with ACLs, security attributes, realtime, no debug enabled
9p: Installing v9fs 9p2000 file system support
FS-Cache: Netfs '9p' registered for caching
gfs2: GFS2 installed
FS-Cache: Netfs 'ceph' registered for caching
ceph: loaded (mds proto 32)
NET: Registered protocol family 38
async_tx: api initialized (async)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Asymmetric key parser 'pkcs8' registered
Key type pkcs7_test registered
Asymmetric key parser 'tpm_parser' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: Sleep Button [SLPF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
PCI Interrupt Link [LNKC] enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
PCI Interrupt Link [LNKD] enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
HDLC line discipline maxframe=4096
N_HDLC line discipline registered.
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
usbcore: registered new interface driver udl
brd: module loaded
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
loop: module loaded
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
debugfs: File 'sched' already present!
zram: Added device: zram0
debugfs: File 'sched' already present!
null: module loaded
nfcsim 0.2 initialized
Loading iSCSI transport class v2.0-870.
scsi host0: Virtio SCSI HBA
st: Version 20160209, fixed bufsize 32768, s/g segs 256
slram: not enough parameters.
ftl_cs: FTL header not found.
debugfs: File 'sched' already present!
Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
eql: Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller  
(davem@redhat.com)
MACsec IEEE 802.1AE
tun: Universal TUN/TAP device driver, 1.6
vcan: Virtual CAN interface driver
vxcan: Virtual CAN Tunnel driver
slcan: serial line CAN interface driver
slcan: 10 dynamic interface channels.
CAN device driver interface
enic: Cisco VIC Ethernet NIC Driver, ver 2.3.0.53
e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
mkiss: AX.25 Multikiss, Hans Albas PE1AYX
AX.25: 6pack driver, Revision: 0.3.0
AX.25: bpqether driver version 004
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
PPTP driver version 0.8.5
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit  
encapsulation enabled).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
hdlc: HDLC support module revision 1.22
x25_asy: X.25 async: version 0.00 ALPHA (dynamic channels, max=256)
DLCI driver v0.35, 4 Jan 1997, mike.mclagan@linux.org.
LAPB Ethernet driver version 0.02
usbcore: registered new interface driver rndis_wlan
mac80211_hwsim: initializing netlink
mac802154_hwsim mac802154_hwsim: Added 2 mac802154 hwsim hardware radios
VMware vmxnet3 virtual NIC driver - version 1.4.17.0-k-NAPI
pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
usbcore: registered new interface driver rtl8150
usbcore: registered new interface driver r8152
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver dm9601
usbcore: registered new interface driver smsc75xx
usbcore: registered new interface driver smsc95xx
usbcore: registered new interface driver net1080
usbcore: registered new interface driver rndis_host
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbcore: registered new interface driver MOSCHIP usb-ethernet driver
usbcore: registered new interface driver cdc_ncm
usbcore: registered new interface driver cdc_mbim
VFIO - User Level meta-driver version: 0.3
aoe: AoE v85 initialised.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
uhci_hcd: USB Universal Host Controller Interface driver
usbcore: registered new interface driver cdc_acm
cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
usbcore: registered new interface driver usblp
usbcore: registered new interface driver cdc_wdm
usbcore: registered new interface driver uas
usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver ums-realtek
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial support registered for generic
usbcore: registered new interface driver ch341
usbserial: USB Serial support registered for ch341-uart
usbcore: registered new interface driver cp210x
usbserial: USB Serial support registered for cp210x
usbcore: registered new interface driver ftdi_sio
usbserial: USB Serial support registered for FTDI USB Serial Device
usbcore: registered new interface driver keyspan
usbserial: USB Serial support registered for Keyspan - (without firmware)
usbserial: USB Serial support registered for Keyspan 1 port adapter
usbserial: USB Serial support registered for Keyspan 2 port adapter
usbserial: USB Serial support registered for Keyspan 4 port adapter
usbcore: registered new interface driver option
usbserial: USB Serial support registered for GSM modem (1-port)
usbcore: registered new interface driver oti6858
usbserial: USB Serial support registered for oti6858
usbcore: registered new interface driver pl2303
usbserial: USB Serial support registered for pl2303
usbcore: registered new interface driver qcserial
usbserial: USB Serial support registered for Qualcomm USB modem
usbcore: registered new interface driver sierra
usbserial: USB Serial support registered for Sierra USB modem
usbcore: registered new interface driver usb_serial_simple
usbserial: USB Serial support registered for carelink
usbserial: USB Serial support registered for zio
usbserial: USB Serial support registered for funsoft
usbserial: USB Serial support registered for flashloader
usbserial: USB Serial support registered for google
usbserial: USB Serial support registered for libtransistor
usbserial: USB Serial support registered for vivopay
usbserial: USB Serial support registered for moto_modem
usbserial: USB Serial support registered for motorola_tetra
usbserial: USB Serial support registered for novatel_gps
usbserial: USB Serial support registered for hp4x
usbserial: USB Serial support registered for suunto
usbserial: USB Serial support registered for siemens_mpi
udc-core: couldn't find an available UDC - added [g_multi] to list of  
pending drivers
vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 1
vhci_hcd: created sysfs vhci_hcd.0
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: USB/IP Virtual Host Controller
usb usb1: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb1: SerialNumber: vhci_hcd.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 2
usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: USB/IP Virtual Host Controller
usb usb2: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb2: SerialNumber: vhci_hcd.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.1: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.1: new USB bus registered, assigned bus number 3
usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: USB/IP Virtual Host Controller
usb usb3: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb3: SerialNumber: vhci_hcd.1
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.1: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.1: new USB bus registered, assigned bus number 4
usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: USB/IP Virtual Host Controller
usb usb4: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb4: SerialNumber: vhci_hcd.1
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.2: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.2: new USB bus registered, assigned bus number 5
usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: USB/IP Virtual Host Controller
usb usb5: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb5: SerialNumber: vhci_hcd.2
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.2: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.2: new USB bus registered, assigned bus number 6
usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: USB/IP Virtual Host Controller
usb usb6: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb6: SerialNumber: vhci_hcd.2
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.3: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.3: new USB bus registered, assigned bus number 7
usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: USB/IP Virtual Host Controller
usb usb7: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb7: SerialNumber: vhci_hcd.3
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.3: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.3: new USB bus registered, assigned bus number 8
usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb8: Product: USB/IP Virtual Host Controller
usb usb8: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb8: SerialNumber: vhci_hcd.3
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.4: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.4: new USB bus registered, assigned bus number 9
usb usb9: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb9: Product: USB/IP Virtual Host Controller
usb usb9: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb9: SerialNumber: vhci_hcd.4
hub 9-0:1.0: USB hub found
hub 9-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.4: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.4: new USB bus registered, assigned bus number 10
usb usb10: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb10: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb10: Product: USB/IP Virtual Host Controller
usb usb10: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb10: SerialNumber: vhci_hcd.4
hub 10-0:1.0: USB hub found
hub 10-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.5: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.5: new USB bus registered, assigned bus number 11
usb usb11: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb11: Product: USB/IP Virtual Host Controller
usb usb11: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb11: SerialNumber: vhci_hcd.5
hub 11-0:1.0: USB hub found
hub 11-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.5: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.5: new USB bus registered, assigned bus number 12
usb usb12: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb12: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb12: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb12: Product: USB/IP Virtual Host Controller
usb usb12: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb12: SerialNumber: vhci_hcd.5
hub 12-0:1.0: USB hub found
hub 12-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.6: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.6: new USB bus registered, assigned bus number 13
usb usb13: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb13: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb13: Product: USB/IP Virtual Host Controller
usb usb13: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb13: SerialNumber: vhci_hcd.6
hub 13-0:1.0: USB hub found
hub 13-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.6: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.6: new USB bus registered, assigned bus number 14
usb usb14: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb14: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb14: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb14: Product: USB/IP Virtual Host Controller
usb usb14: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb14: SerialNumber: vhci_hcd.6
hub 14-0:1.0: USB hub found
hub 14-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.7: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.7: new USB bus registered, assigned bus number 15
usb usb15: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb15: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb15: Product: USB/IP Virtual Host Controller
usb usb15: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb15: SerialNumber: vhci_hcd.7
hub 15-0:1.0: USB hub found
hub 15-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.7: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.7: new USB bus registered, assigned bus number 16
usb usb16: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb16: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb16: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb16: Product: USB/IP Virtual Host Controller
usb usb16: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb16: SerialNumber: vhci_hcd.7
hub 16-0:1.0: USB hub found
hub 16-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.8: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.8: new USB bus registered, assigned bus number 17
usb usb17: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb17: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb17: Product: USB/IP Virtual Host Controller
usb usb17: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb17: SerialNumber: vhci_hcd.8
hub 17-0:1.0: USB hub found
hub 17-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.8: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.8: new USB bus registered, assigned bus number 18
usb usb18: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb18: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb18: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb18: Product: USB/IP Virtual Host Controller
usb usb18: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb18: SerialNumber: vhci_hcd.8
hub 18-0:1.0: USB hub found
hub 18-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.9: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.9: new USB bus registered, assigned bus number 19
usb usb19: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb19: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb19: Product: USB/IP Virtual Host Controller
usb usb19: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb19: SerialNumber: vhci_hcd.9
hub 19-0:1.0: USB hub found
hub 19-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.9: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.9: new USB bus registered, assigned bus number 20
usb usb20: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb20: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb20: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb20: Product: USB/IP Virtual Host Controller
usb usb20: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb20: SerialNumber: vhci_hcd.9
hub 20-0:1.0: USB hub found
hub 20-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.10: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.10: new USB bus registered, assigned bus number 21
usb usb21: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb21: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb21: Product: USB/IP Virtual Host Controller
usb usb21: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb21: SerialNumber: vhci_hcd.10
hub 21-0:1.0: USB hub found
hub 21-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.10: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.10: new USB bus registered, assigned bus number 22
usb usb22: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb22: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb22: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb22: Product: USB/IP Virtual Host Controller
usb usb22: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb22: SerialNumber: vhci_hcd.10
hub 22-0:1.0: USB hub found
hub 22-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.11: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.11: new USB bus registered, assigned bus number 23
usb usb23: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb23: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb23: Product: USB/IP Virtual Host Controller
usb usb23: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb23: SerialNumber: vhci_hcd.11
hub 23-0:1.0: USB hub found
hub 23-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.11: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.11: new USB bus registered, assigned bus number 24
usb usb24: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb24: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb24: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb24: Product: USB/IP Virtual Host Controller
usb usb24: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb24: SerialNumber: vhci_hcd.11
hub 24-0:1.0: USB hub found
hub 24-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.12: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.12: new USB bus registered, assigned bus number 25
usb usb25: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb25: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb25: Product: USB/IP Virtual Host Controller
usb usb25: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb25: SerialNumber: vhci_hcd.12
hub 25-0:1.0: USB hub found
hub 25-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.12: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.12: new USB bus registered, assigned bus number 26
usb usb26: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb26: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb26: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb26: Product: USB/IP Virtual Host Controller
usb usb26: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb26: SerialNumber: vhci_hcd.12
hub 26-0:1.0: USB hub found
hub 26-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.13: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.13: new USB bus registered, assigned bus number 27
usb usb27: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb27: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb27: Product: USB/IP Virtual Host Controller
usb usb27: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb27: SerialNumber: vhci_hcd.13
hub 27-0:1.0: USB hub found
hub 27-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.13: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.13: new USB bus registered, assigned bus number 28
usb usb28: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb28: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb28: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb28: Product: USB/IP Virtual Host Controller
usb usb28: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb28: SerialNumber: vhci_hcd.13
hub 28-0:1.0: USB hub found
hub 28-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.14: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.14: new USB bus registered, assigned bus number 29
usb usb29: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb29: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb29: Product: USB/IP Virtual Host Controller
usb usb29: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb29: SerialNumber: vhci_hcd.14
hub 29-0:1.0: USB hub found
hub 29-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.14: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.14: new USB bus registered, assigned bus number 30
usb usb30: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb30: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb30: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb30: Product: USB/IP Virtual Host Controller
usb usb30: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb30: SerialNumber: vhci_hcd.14
hub 30-0:1.0: USB hub found
hub 30-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.15: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.15: new USB bus registered, assigned bus number 31
usb usb31: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.02
usb usb31: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb31: Product: USB/IP Virtual Host Controller
usb usb31: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb31: SerialNumber: vhci_hcd.15
hub 31-0:1.0: USB hub found
hub 31-0:1.0: 8 ports detected
vhci_hcd vhci_hcd.15: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.15: new USB bus registered, assigned bus number 32
usb usb32: We don't know the algorithms for LPM for this host, disabling  
LPM.
usb usb32: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice=  
5.02
usb usb32: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb32: Product: USB/IP Virtual Host Controller
usb usb32: Manufacturer: Linux 5.2.0-rc7-next-20190704 vhci_hcd
usb usb32: SerialNumber: vhci_hcd.15
hub 32-0:1.0: USB hub found
hub 32-0:1.0: 8 ports detected
usbcore: registered new device driver usbip-host
using random self ethernet address
using random host ethernet address
Mass Storage Function, version: 2009/09/11
LUN: removable file: (no medium)
no file given for LUN0
g_multi usbip-vudc.0: failed to start g_multi: -22
usbip-vudc: probe of usbip-vudc.0 failed with error -22
i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
i8042: Warning: Keylock active
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
rtc_cmos 00:00: RTC can wake from S4
rtc_cmos 00:00: registered as rtc0
rtc_cmos 00:00: alarms up to one day, 114 bytes nvram
i2c /dev entries driver
piix4_smbus 0000:00:01.3: SMBus base address uninitialized - upgrade BIOS  
or use force_addr=0xaddr
i2c-parport-light: adapter type unspecified
usbcore: registered new interface driver RobotFuzz Open Source InterFace,  
OSIF
usbcore: registered new interface driver i2c-tiny-usb
IR NEC protocol handler initialized
IR RC5(x/sz) protocol handler initialized
IR RC6 protocol handler initialized
IR JVC protocol handler initialized
IR Sony protocol handler initialized
IR SANYO protocol handler initialized
IR Sharp protocol handler initialized
IR MCE Keyboard/mouse protocol handler initialized
IR XMP protocol handler initialized
vimc vimc.0: bound vimc-sensor.0.auto (ops vimc_sen_comp_ops)
vimc vimc.0: bound vimc-sensor.1.auto (ops vimc_sen_comp_ops)
vimc vimc.0: bound vimc-debayer.2.auto (ops vimc_deb_comp_ops)
vimc vimc.0: bound vimc-debayer.3.auto (ops vimc_deb_comp_ops)
vimc vimc.0: bound vimc-capture.4.auto (ops vimc_cap_comp_ops)
vimc vimc.0: bound vimc-capture.5.auto (ops vimc_cap_comp_ops)
vimc vimc.0: bound vimc-sensor.6.auto (ops vimc_sen_comp_ops)
vimc vimc.0: bound vimc-scaler.7.auto (ops vimc_sca_comp_ops)
vimc vimc.0: bound vimc-capture.8.auto (ops vimc_cap_comp_ops)
vivid-000: using single planar format API
vivid-000: CEC adapter cec0 registered for HDMI input 0
vivid-000: V4L2 capture device registered as video3
vivid-000: CEC adapter cec1 registered for HDMI output 0
vivid-000: V4L2 output device registered as video4
vivid-000: V4L2 capture device registered as vbi0, supports raw and sliced  
VBI
vivid-000: V4L2 output device registered as vbi1, supports raw and sliced  
VBI
vivid-000: V4L2 capture device registered as swradio0
vivid-000: V4L2 receiver device registered as radio0
vivid-000: V4L2 transmitter device registered as radio1
vivid-001: using multiplanar format API
vivid-001: CEC adapter cec2 registered for HDMI input 0
vivid-001: V4L2 capture device registered as video5
vivid-001: CEC adapter cec3 registered for HDMI output 0
vivid-001: V4L2 output device registered as video6
vivid-001: V4L2 capture device registered as vbi2, supports raw and sliced  
VBI
vivid-001: V4L2 output device registered as vbi3, supports raw and sliced  
VBI
vivid-001: V4L2 capture device registered as swradio1
vivid-001: V4L2 receiver device registered as radio2
vivid-001: V4L2 transmitter device registered as radio3
vivid-002: using single planar format API
vivid-002: CEC adapter cec4 registered for HDMI input 0
vivid-002: V4L2 capture device registered as video7
vivid-002: CEC adapter cec5 registered for HDMI output 0
vivid-002: V4L2 output device registered as video8
vivid-002: V4L2 capture device registered as vbi4, supports raw and sliced  
VBI
vivid-002: V4L2 output device registered as vbi5, supports raw and sliced  
VBI
vivid-002: V4L2 capture device registered as swradio2
vivid-002: V4L2 receiver device registered as radio4
vivid-002: V4L2 transmitter device registered as radio5
vivid-003: using multiplanar format API
vivid-003: CEC adapter cec6 registered for HDMI input 0
vivid-003: V4L2 capture device registered as video9
vivid-003: CEC adapter cec7 registered for HDMI output 0
vivid-003: V4L2 output device registered as video10
vivid-003: V4L2 capture device registered as vbi6, supports raw and sliced  
VBI
vivid-003: V4L2 output device registered as vbi7, supports raw and sliced  
VBI
vivid-003: V4L2 capture device registered as swradio3
vivid-003: V4L2 receiver device registered as radio6
vivid-003: V4L2 transmitter device registered as radio7
vivid-004: using single planar format API
vivid-004: CEC adapter cec8 registered for HDMI input 0
vivid-004: V4L2 capture device registered as video11
vivid-004: CEC adapter cec9 registered for HDMI output 0
vivid-004: V4L2 output device registered as video12
vivid-004: V4L2 capture device registered as vbi8, supports raw and sliced  
VBI
vivid-004: V4L2 output device registered as vbi9, supports raw and sliced  
VBI
vivid-004: V4L2 capture device registered as swradio4
vivid-004: V4L2 receiver device registered as radio8
vivid-004: V4L2 transmitter device registered as radio9
vivid-005: using multiplanar format API
vivid-005: CEC adapter cec10 registered for HDMI input 0
vivid-005: V4L2 capture device registered as video13
vivid-005: CEC adapter cec11 registered for HDMI output 0
vivid-005: V4L2 output device registered as video14
vivid-005: V4L2 capture device registered as vbi10, supports raw and sliced  
VBI
vivid-005: V4L2 output device registered as vbi11, supports raw and sliced  
VBI
vivid-005: V4L2 capture device registered as swradio5
vivid-005: V4L2 receiver device registered as radio10
vivid-005: V4L2 transmitter device registered as radio11
vivid-006: using single planar format API
vivid-006: CEC adapter cec12 registered for HDMI input 0
vivid-006: V4L2 capture device registered as video15
vivid-006: CEC adapter cec13 registered for HDMI output 0
vivid-006: V4L2 output device registered as video16
vivid-006: V4L2 capture device registered as vbi12, supports raw and sliced  
VBI
vivid-006: V4L2 output device registered as vbi13, supports raw and sliced  
VBI
vivid-006: V4L2 capture device registered as swradio6
vivid-006: V4L2 receiver device registered as radio12
vivid-006: V4L2 transmitter device registered as radio13
vivid-007: using multiplanar format API
vivid-007: CEC adapter cec14 registered for HDMI input 0
vivid-007: V4L2 capture device registered as video17
vivid-007: CEC adapter cec15 registered for HDMI output 0
vivid-007: V4L2 output device registered as video18
vivid-007: V4L2 capture device registered as vbi14, supports raw and sliced  
VBI
vivid-007: V4L2 output device registered as vbi15, supports raw and sliced  
VBI
vivid-007: V4L2 capture device registered as swradio7
vivid-007: V4L2 receiver device registered as radio14
vivid-007: V4L2 transmitter device registered as radio15
vivid-008: using single planar format API
vivid-008: CEC adapter cec16 registered for HDMI input 0
vivid-008: V4L2 capture device registered as video19
vivid-008: CEC adapter cec17 registered for HDMI output 0
vivid-008: V4L2 output device registered as video20
vivid-008: V4L2 capture device registered as vbi16, supports raw and sliced  
VBI
vivid-008: V4L2 output device registered as vbi17, supports raw and sliced  
VBI
vivid-008: V4L2 capture device registered as swradio8
vivid-008: V4L2 receiver device registered as radio16
vivid-008: V4L2 transmitter device registered as radio17
vivid-009: using multiplanar format API
vivid-009: CEC adapter cec18 registered for HDMI input 0
vivid-009: V4L2 capture device registered as video21
vivid-009: CEC adapter cec19 registered for HDMI output 0
vivid-009: V4L2 output device registered as video22
vivid-009: V4L2 capture device registered as vbi18, supports raw and sliced  
VBI
vivid-009: V4L2 output device registered as vbi19, supports raw and sliced  
VBI
vivid-009: V4L2 capture device registered as swradio9
vivid-009: V4L2 receiver device registered as radio18
vivid-009: V4L2 transmitter device registered as radio19
vivid-010: using single planar format API
vivid-010: CEC adapter cec20 registered for HDMI input 0
vivid-010: V4L2 capture device registered as video23
vivid-010: CEC adapter cec21 registered for HDMI output 0
vivid-010: V4L2 output device registered as video24
vivid-010: V4L2 capture device registered as vbi20, supports raw and sliced  
VBI
vivid-010: V4L2 output device registered as vbi21, supports raw and sliced  
VBI
vivid-010: V4L2 capture device registered as swradio10
vivid-010: V4L2 receiver device registered as radio20
vivid-010: V4L2 transmitter device registered as radio21
vivid-011: using multiplanar format API
vivid-011: CEC adapter cec22 registered for HDMI input 0
vivid-011: V4L2 capture device registered as video25
vivid-011: CEC adapter cec23 registered for HDMI output 0
vivid-011: V4L2 output device registered as video26
vivid-011: V4L2 capture device registered as vbi22, supports raw and sliced  
VBI
vivid-011: V4L2 output device registered as vbi23, supports raw and sliced  
VBI
vivid-011: V4L2 capture device registered as swradio11
vivid-011: V4L2 receiver device registered as radio22
vivid-011: V4L2 transmitter device registered as radio23
vivid-012: using single planar format API
vivid-012: CEC adapter cec24 registered for HDMI input 0
vivid-012: V4L2 capture device registered as video27
vivid-012: CEC adapter cec25 registered for HDMI output 0
vivid-012: V4L2 output device registered as video28
vivid-012: V4L2 capture device registered as vbi24, supports raw and sliced  
VBI
vivid-012: V4L2 output device registered as vbi25, supports raw and sliced  
VBI
vivid-012: V4L2 capture device registered as swradio12
vivid-012: V4L2 receiver device registered as radio24
vivid-012: V4L2 transmitter device registered as radio25
vivid-013: using multiplanar format API
vivid-013: CEC adapter cec26 registered for HDMI input 0
vivid-013: V4L2 capture device registered as video29
vivid-013: CEC adapter cec27 registered for HDMI output 0
vivid-013: V4L2 output device registered as video30
vivid-013: V4L2 capture device registered as vbi26, supports raw and sliced  
VBI
vivid-013: V4L2 output device registered as vbi27, supports raw and sliced  
VBI
vivid-013: V4L2 capture device registered as swradio13
vivid-013: V4L2 receiver device registered as radio26
vivid-013: V4L2 transmitter device registered as radio27
vivid-014: using single planar format API
vivid-014: CEC adapter cec28 registered for HDMI input 0
vivid-014: V4L2 capture device registered as video31
vivid-014: CEC adapter cec29 registered for HDMI output 0
vivid-014: V4L2 output device registered as video32
vivid-014: V4L2 capture device registered as vbi28, supports raw and sliced  
VBI
vivid-014: V4L2 output device registered as vbi29, supports raw and sliced  
VBI
vivid-014: V4L2 capture device registered as swradio14
vivid-014: V4L2 receiver device registered as radio28
vivid-014: V4L2 transmitter device registered as radio29
vivid-015: using multiplanar format API
vivid-015: CEC adapter cec30 registered for HDMI input 0
vivid-015: V4L2 capture device registered as video33
vivid-015: CEC adapter cec31 registered for HDMI output 0
vivid-015: V4L2 output device registered as video34
vivid-015: V4L2 capture device registered as vbi30, supports raw and sliced  
VBI
vivid-015: V4L2 output device registered as vbi31, supports raw and sliced  
VBI
vivid-015: V4L2 capture device registered as swradio15
vivid-015: V4L2 receiver device registered as radio30
vivid-015: V4L2 transmitter device registered as radio31
vim2m vim2m.0: Device registered as /dev/video35
vicodec vicodec.0: Device 'stateful-encoder' registered as /dev/video36
vicodec vicodec.0: Device 'stateful-decoder' registered as /dev/video37
vicodec vicodec.0: Device 'stateless-decoder' registered as /dev/video38
usbcore: registered new interface driver uvcvideo
USB Video Class driver (1.1.1)
gspca_main: v2.14.0 registered
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
iTCO_vendor_support: vendor-support=0
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.40.0-ioctl (2019-01-18) initialised:  
dm-devel@redhat.com
device-mapper: multipath round-robin: version 1.2.0 loaded
device-mapper: multipath queue-length: version 0.2.0 loaded
device-mapper: multipath service-time: version 0.3.0 loaded
device-mapper: raid: Loading target version 1.14.0
Bluetooth: HCI UART driver ver 2.3
Bluetooth: HCI UART protocol H4 registered
Bluetooth: HCI UART protocol BCSP registered
Bluetooth: HCI UART protocol LL registered
Bluetooth: HCI UART protocol Three-wire (H5) registered
Bluetooth: HCI UART protocol QCA registered
Bluetooth: HCI UART protocol AG6XX registered
Bluetooth: HCI UART protocol Marvell registered
usbcore: registered new interface driver bfusb
usbcore: registered new interface driver btusb
CAPI 2.0 started up with major 68 (middleware)
Modular ISDN core version 1.1.29
NET: Registered protocol family 34
DSP module 2.0
mISDN_dsp: DSP clocks every 80 samples. This equals 1 jiffies.
mISDN: Layer-1-over-IP driver Rev. 2.00
0 virtual devices registered
intel_pstate: CPU model not supported
usnic_verbs: Cisco VIC (USNIC) Verbs Driver v1.0.3 (December 19, 2013)
usnic_verbs:usnic_uiom_init:566:
IOMMU required but not present or enabled.  USNIC QPs will not function w/o  
enabling IOMMU
usnic_verbs:usnic_ib_init:661:
Unable to initialize umem with err -1
iscsi: registered transport (iser)
OPA Virtual Network Driver - v1.0
hidraw: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
NET: Registered protocol family 40
ashmem: initialized
erofs: initializing erofs 1.0pre1
erofs: successfully to initialize erofs
usbcore: registered new interface driver snd-usb-audio
drop_monitor: Initializing network drop monitor service
NET: Registered protocol family 26
GACT probability on
Mirror/redirect action on
Simple TC action Loaded
netem: version 1.3
u32 classifier
     Performance counters on
     input device check on
     Actions configured
nf_conntrack_irc: failed to register helpers
nf_conntrack_sane: failed to register helpers
nf_conntrack_sip: failed to register helpers
xt_time: kernel timezone is -0000
IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
IPVS: Connection hash table configured (size=4096, memory=64Kbytes)
IPVS: ipvs loaded.
IPVS: [rr] scheduler registered.
IPVS: [wrr] scheduler registered.
IPVS: [lc] scheduler registered.
IPVS: [wlc] scheduler registered.
IPVS: [fo] scheduler registered.
IPVS: [ovf] scheduler registered.
IPVS: [lblc] scheduler registered.
IPVS: [lblcr] scheduler registered.
IPVS: [dh] scheduler registered.
IPVS: [sh] scheduler registered.
IPVS: [mh] scheduler registered.
IPVS: [sed] scheduler registered.
IPVS: [nq] scheduler registered.
IPVS: ftp: loaded support on port[0] = 21
IPVS: [sip] pe registered.
ipip: IPv4 and MPLS over IPv4 tunneling driver
gre: GRE over IPv4 demultiplexor driver
ip_gre: GRE over IPv4 tunneling driver
IPv4 over IPsec tunneling driver
ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
Initializing XFRM netlink socket
IPsec XFRM device driver
NET: Registered protocol family 10
Segment Routing with IPv6
mip6: Mobile IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
ip6_gre: GRE over IPv6 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
NET: Registered protocol family 9
X25: Linux Version 0.2
NET: Registered protocol family 6
NET: Registered protocol family 11
NET: Registered protocol family 3
can: controller area network core (rev 20170425 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20170425)
can: broadcast manager protocol (rev 20170425 t)
can: netlink gateway (rev 20170425) max_hops=1
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
Bluetooth: CMTP (CAPI Emulation) ver 1.0
Bluetooth: CMTP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
Bluetooth: HIDP socket layer initialized
RPC: Registered rdma transport module.
RPC: Registered rdma backchannel transport module.
NET: Registered protocol family 33
Key type rxrpc registered
Key type rxrpc_s registered
NET: Registered protocol family 41
lec:lane_module_init: lec.c: initialized
mpoa:atm_mpoa_init: mpc.c: initialized
l2tp_core: L2TP core driver, V2.0
l2tp_ppp: PPPoL2TP kernel driver, V2.0
l2tp_ip: L2TP IP encapsulation support (L2TPv3)
l2tp_netlink: L2TP netlink interface
l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
8021q: 802.1Q VLAN Support v1.8
DCCP: Activated CCID 2 (TCP-like)
DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
sctp: Hash tables configured (bind 64/64)
NET: Registered protocol family 21
Registered RDS/infiniband transport
Registered RDS/tcp transport
tipc: Activated (version 2.0.0)
NET: Registered protocol family 30
tipc: Started in single node mode
NET: Registered protocol family 43
9pnet: Installing 9P2000 support
NET: Registered protocol family 37
NET: Registered protocol family 36
Key type dns_resolver registered
Key type ceph registered
libceph: loaded (mon/osd proto 15/24)
batman_adv: B.A.T.M.A.N. advanced 2019.3 (compatibility version 15) loaded
openvswitch: Open vSwitch switching datapath
mpls_gso: MPLS GSO support
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
sched_clock: Marking stable (11023009686, 22427228)->(11169299490,  
-123862576)
registered taskstats version 1
Loading compiled-in X.509 certificates
zswap: loaded using pool lzo/zbud
Btrfs loaded, crc32c=crc32c-intel
Key type big_key registered
Key type encrypted registered
AppArmor: AppArmor sha1 policy hashing enabled
ima: No TPM chip found, activating TPM-bypass!
ima: Allocated hash algorithm: sha256
No architecture policies found
evm: Initialising EVM extended attributes:
evm: security.selinux
evm: security.SMACK64
evm: security.SMACK64EXEC
evm: security.SMACK64TRANSMUTE
evm: security.SMACK64MMAP
evm: security.apparmor
evm: security.ima
evm: security.capability
evm: HMAC attrs: 0x1
PM:   Magic number: 11:503:480
usb usb18-port1: hash matches
usb usb17-port2: hash matches
bdi 31:0: hash matches
printk: console [netcon0] enabled
netconsole: network logging started
gtp: GTP module loaded (pdp ctx size 104 bytes)
------------[ cut here ]------------
__dev_pm_qos_remove_request() called for unknown object
WARNING: CPU: 1 PID: 1 at drivers/base/power/qos.c:486  
__dev_pm_qos_remove_request+0x3d3/0x4d0 drivers/base/power/qos.c:486


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
