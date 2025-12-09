Return-Path: <linux-pm+bounces-39349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B5CB0194
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 14:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEED53079EA0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE54221545;
	Tue,  9 Dec 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="H/elLKTg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A7211A14
	for <linux-pm@vger.kernel.org>; Tue,  9 Dec 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288054; cv=none; b=C5S7V9jIltjQ4FCJ/gdJHuCI+IzQDR3IgGVLNatzE70AFfqX+5qwFUwNFeB8zbVC+jM7OVhhyIri+Lip4D4dyit3mrphIZ2nro0NpvMcG+VVwJK4vr3wWkpAjPBAfY9+0CGZMWppcpX19FVRlLmAGqRMeFiXuuiymYjaz126x08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288054; c=relaxed/simple;
	bh=LZ133vyXSZEAqWdeC7Au2e8EMEIbqS9+ALeo8jdMbm0=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Message-Id; b=as/RMWGyM2aok0M2+f745LDhpD5ZX17zjmjph34kffkMCm+OhEkLtRX3jynulxsw7M3ieNVGOG1NHkeP3Ghk3aecV05umRnRLKX4pNmbLTOM4hVWz0k/hUDND4hBFmrkAEK+c6mjXS8H6b/f24bWSt4tyOR+ApOluumwXeqDQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=H/elLKTg; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 0D20811F27;
	Tue, 09 Dec 2025 14:47:29 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id A9m_OK4Aaza5; Tue,  9 Dec 2025 14:47:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1765288047;
	bh=ifq6YpOW2qYyaPVPS2F171yEGpRcdxKD17CjkGGIg6s=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=H/elLKTg8l0ZE6ZUErJc1sSc7Fq+tDiJUfwXDEVv0m8Bcf/OAvt3w9HUfN7FH5S0s
	 qXLwkUmMCJbp0jEBMcGA3VrzGCJaPZlOLoPuqSPHVP2TWZfsUZvSvA627i40Iq13sb
	 n84Aatip7IuX63v42horfOrhN9TYpyt7ghg1aKNupnR0QTqFW0hWDBywYH/debsypu
	 HmyHMNoitAy2/WsyF0D6QyffoloGcHHZ0pD3k9zFyMXBxKl8LImbMyw1T0qoSVAGg+
	 8OVt7G8aFtYYGKQEMwZCA9Dax8DbX0fVfxRP6Vd7ZtTzcrYjdw8H5af3RZVVkZtiYG
	 1oQRK3RhAyK7Q==
Received: from [10.0.2.49] (unknown [80.188.199.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 495AC11CFD;
	Tue, 09 Dec 2025 14:47:27 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: arm:xlnx,zynq-7000: missing CPU freq in /sys after 6.18.0-g8f7aa3d3c732 from 2025-12-04
Date: Tue, 9 Dec 2025 14:47:26 +0100
User-Agent: KMail/1.9.10
Cc: Michal Simek <michal.simek@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org,
 Pavel Hronek <hronepa1@fel.cvut.cz>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <202512081758.02574.pisa@fel.cvut.cz> <6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz>
In-Reply-To: <6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uhCOpNbSBANuPWc"
Message-Id: <202512091447.26580.pisa@fel.cvut.cz>

--Boundary-00=_uhCOpNbSBANuPWc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Viresh Kumar,

thanks for fast response.

On Tuesday 09 of December 2025 06:37:02 Viresh Kumar wrote:
> On 08-12-25, 17:58, Pavel Pisa wrote:
...
> > and we experience problem that attempt to set performance
> > scaling governor though
> >
> >   /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> >   /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
> >
...
> Try reverting:
>
> commit 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with
> of_machine_get_match_data()")
>
> Also if you can provide your boot logs, it could be useful. Either the
> probing of the cpufreq driver isn't attempted, or it just fails somewhere
> now.

The cpufreq is back after the revert.

I am attaching logs from failing mainline, then with
revert applied and their diff. At our standard debug
level, there is only single line interesting in the diff

+cpufreq: cpufreq_policy_online: CPU0: Running at unlisted initial frequency: 666666 kHz, changing to: 666667 kHz

The rest are some timing perturbations (lines swapped etc.)
and at the end mismatch in dtbocfg with test kernel.
But we have run whole round successfully when the revert patch
has been added into test automation system.

The /sys with the revert patch applied shows next
cpufreq entries (only some subentries shown)

/sys/devices/platform/cpufreq-dt
  driver -> ../../../bus/platform/drivers/cpufreq-dt
  driver_override (null)
  modalias platform:cpufreq-dt
  subsystem -> ../../../bus/platform
/sys/devices/system/cpu/cpufreq
  boost 0
  ondemand
  policy0
    affected_cpus 0 1
    related_cpus  0 1
    scaling_governor ondemand
    scaling_available_governors ondemand performance schedutil
/sys/devices/system/cpu/cpu0/cpufreq -> ../cpufreq/policy0
/sys/devices/system/cpu/cpu1/cpufreq -> ../cpufreq/policy0
/sys/bus/platform/devices/cpufreq-dt
  modalias  platform:cpufreq-dt
/sys/bus/platform/drivers/cpufreq-dt
/sys/bus/platform/drivers/cpufreq-dt/cpufreq-dt
/sys/module/cpufreq

So the all seems normal from my understanding.

The device-tree is slightly modified zynq-microzed.dts,

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/xilinx/zynq-microzed.dts

the console is switched to the UART0 which is routed
over galvanic insulator and break to reset cicuitry to
the FTDI device on baseboard. System is connected to
OrangePi testbed controller with test system power
supply control etc. 

If you have some patch to test or some suggestion
for some testing with more debugging options
switch on, then I will be happy to test that
as my time between teaching and other duties
allows.

Best wishes and thanks for help again,

                Pavel

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

--Boundary-00=_uhCOpNbSBANuPWc
Content-Type: application/x-gzip;
  name="boot-mainline.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="boot-mainline.log.gz"

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

--Boundary-00=_uhCOpNbSBANuPWc
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="boot-with-revert.log.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="boot-with-revert.log.diff"

--- boot-mainline.log	2025-12-09 10:25:58.444776512 +0100
+++ boot-with-revert.log	2025-12-09 10:26:14.148777077 +0100
@@ -1,5 +1,5 @@
 Booting Linux on physical CPU 0x0
-Linux version 6.18.0-dut (hronepa1@can-tester) (arm-linux-gnueabihf-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP Tue Dec  9 04:21:45 CET 2025
+Linux version 6.18.0+ (hronepa1@can-tester) (arm-linux-gnueabihf-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #2 SMP Tue Dec  9 10:01:18 CET 2025
 CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d
 CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
 OF: fdt: Machine model: Avnet MicroZed board
@@ -163,8 +163,8 @@
 9p: Installing v9fs 9p2000 file system support
 xor: measuring software checksum speed
    arm4regs        :  1074 MB/sec
-   8regs           :   818 MB/sec
-   32regs          :   815 MB/sec
+   8regs           :   815 MB/sec
+   32regs          :   816 MB/sec
    neon            :   769 MB/sec
 xor: using function: arm4regs (1074 MB/sec)
 Key type asymmetric registered
@@ -209,6 +209,7 @@
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 1 port detected
 i2c_dev: i2c /dev entries driver
+cpufreq: cpufreq_policy_online: CPU0: Running at unlisted initial frequency: 666666 kHz, changing to: 666667 kHz
 Xilinx Zynq CpuIdle Driver started
 sdhci: Secure Digital Host Controller Interface driver
 sdhci: Copyright(c) Pierre Ossman
@@ -220,27 +221,27 @@
 usbhid: USB HID core driver
 armv7-pmu f8891000.pmu: hw perfevents: no interrupt-affinity property, guessing.
 hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 (8000003f) counters available
-NET: Registered PF_INET6 protocol family
 mmc0: SDHCI controller on e0100000.mmc [e0100000.mmc] using ADMA
+NET: Registered PF_INET6 protocol family
 Segment Routing with IPv6
 In-situ OAM (IOAM) with IPv6
 sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
 NET: Registered PF_PACKET protocol family
 can: controller area network core
 NET: Registered PF_CAN protocol family
+mmc0: new high speed SDHC card at address aaaa
 can: raw protocol
 can: broadcast manager protocol
 can: netlink gateway - max_hops=1
 9pnet: Installing 9P2000 support
 Key type dns_resolver registered
 ThumbEE CPU extension supported.
+mmcblk0: mmc0:aaaa SB16G 14.8 GiB
 Registering SWP/SWPB emulation handler
+ mmcblk0: p1 p2
 Loading compiled-in X.509 certificates
 Btrfs loaded, zoned=no, fsverity=no
 of-fpga-region fpga-full: FPGA Region probed
-mmc0: new high speed SDHC card at address aaaa
-mmcblk0: mmc0:aaaa SB16G 14.8 GiB
- mmcblk0: p1 p2
 macb e000b000.ethernet eth0: PHY [e000b000.ethernet-ffffffff:00] driver [Marvell 88E1510] (irq=POLL)
 macb e000b000.ethernet eth0: configuring for phy/rgmii-id link mode
 macb e000b000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
@@ -307,31 +308,15 @@
 systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
 systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
 systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
+systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
+systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
 systemd[1]: Started systemd-journald.service - Journal Service.
 systemd-journald[179]: Received client request to flush runtime journal.
 random: crng init done
 macb e000b000.ethernet end0: renamed from eth0 (while UP)
-dtbocfg: loading out-of-tree module taints kernel.
-dtbocfg: 0.1.0
-dtbocfg: OK
-fpga_manager fpga0: writing system.bit.bin to Xilinx Zynq FPGA Manager
-OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-full/firmware-name
-OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/CTU_CAN_FD_0
-OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/CTU_CAN_FD_1
-OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/CTU_CAN_FD_2
-OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/CTU_CAN_FD_3
-OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/can_crossbar_0
-ctucanfd 43c30000.CTU_CAN_FD can2: ctu_can_fd device registered
-ctucanfd 43c30000.CTU_CAN_FD can2: ctucan_err_interrupt: ISR = 0x00000010, rxerr 0, txerr 0, error type 0, pos 31, ALC id_field 0, bit 0
-ctucanfd 43c30000.CTU_CAN_FD can2: state changes from CAN_STATE_STOPPED to CAN_STATE_ERROR_ACTIVE
-ctucanfd 43c70000.CTU_CAN_FD can3: ctu_can_fd device registered
-ctucanfd 43c70000.CTU_CAN_FD can3: ctucan_err_interrupt: ISR = 0x00000010, rxerr 0, txerr 0, error type 0, pos 31, ALC id_field 0, bit 0
-ctucanfd 43c70000.CTU_CAN_FD can3: state changes from CAN_STATE_STOPPED to CAN_STATE_ERROR_ACTIVE
-ctucanfd 43bf0000.CTU_CAN_FD can4: ctu_can_fd device registered
-ctucanfd 43bf0000.CTU_CAN_FD can4: ctucan_err_interrupt: ISR = 0x00000010, rxerr 0, txerr 0, error type 0, pos 31, ALC id_field 0, bit 0
-ctucanfd 43bf0000.CTU_CAN_FD can4: state changes from CAN_STATE_STOPPED to CAN_STATE_ERROR_ACTIVE
-ctucanfd 43bb0000.CTU_CAN_FD can5: ctu_can_fd device registered
-ctucanfd 43bb0000.CTU_CAN_FD can5: ctucan_err_interrupt: ISR = 0x00000010, rxerr 0, txerr 0, error type 0, pos 31, ALC id_field 0, bit 0
-ctucanfd 43bb0000.CTU_CAN_FD can5: state changes from CAN_STATE_STOPPED to CAN_STATE_ERROR_ACTIVE
+module dtbocfg: .gnu.linkonce.this_module section size must match the kernel's built struct module size at run time
+8<--- cut here ---
+Unhandled fault: external abort on non-linefetch (0x818) at 0xb6fae000
+[b6fae000] *pgd=30226831
 systemd-journald[179]: Oldest entry in /var/log/journal/fde1c56518324c06a97facd0c2f87076/system.journal is older than the configured file retention duration (1month), suggesting rotation.
 systemd-journald[179]: /var/log/journal/fde1c56518324c06a97facd0c2f87076/system.journal: Journal header limits reached or header out-of-date, rotating.

--Boundary-00=_uhCOpNbSBANuPWc
Content-Type: application/x-gzip;
  name="boot-with-revert.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="boot-with-revert.log.gz"

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
dokpaINaAAA=

--Boundary-00=_uhCOpNbSBANuPWc--

