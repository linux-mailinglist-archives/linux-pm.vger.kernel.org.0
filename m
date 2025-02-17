Return-Path: <linux-pm+bounces-22220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82A9A38759
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 16:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DA93B0D8D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33821CA0A;
	Mon, 17 Feb 2025 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="u5GBh37i"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A9F1494DF;
	Mon, 17 Feb 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805410; cv=none; b=GuDnm/fnjcw3ZT1x7vMnNPe8WKbV8Y3MgvGxB2FeYKjNNwEyAup0H9ZCxBzr9UUmC/GqyXUUdnIRQwwrqUvjn00Cn3IIK5tEJlpxarFtBMY75PaY4AAT/nHPaWl9xhTNCT7mfGIRqBHQgGGWYJS6eUwXO71UxySB3q7uEPCV/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805410; c=relaxed/simple;
	bh=xEKSOtTnAiPDQJOAO2X3YkyL+PFlVtMu6g+OFLLm2c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7IbSYtyLUROKjjrAMPh6OoKolsZ6xiZgGHLs6sszJgNy8TOIROyOt9cKg34lUo677lPlTk+yM4vAvBTaQwl9ZRPvDek4Xj1LemFceDVBHuT45YWl7in4ON1xPxxrBcV6S1t3OT+7JpTgNVCTb0Mrs5L4OOxcHybHrEeCcptU+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=u5GBh37i; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Txz96/4Sl4rBd7uviNnz8xd+7RCmzNGbJ9ktTRMFtxc=; b=u5GBh37ipv+FTMsdDxrAyFy1fN
	mwnJ0gNKeFgjL0vesl6CjN+m0MhRP4iZHG0D8aegTavibjanfEUZCxmU97P6EZhRXMmvdXz/3MPuz
	EOyqejKxScrWvqEfp+PgVC4xqSxysbEbOvsDO5ZuEvF2VDvm+H/ZUgN1yaKeBVlpUtHem/zFBsJEa
	E8l2Bw87K3u7M/8dolR5hsw6zmuwHgyP8LGJvtLm0KlKeIsuJlwc+JHWGqB+id8n3kZwpzSzXrkFg
	k5zxm0ToiZ6lS4EfO52Y+1YTPcCAbHszO/OTErX38MDFPZlb3BpWvKfAKICmP6+syj2p0QJjmzVqn
	1MBewvmQ==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tk2r6-0004Sp-N4; Mon, 17 Feb 2025 16:16:20 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Steven Price <steven.price@arm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v7 4/7] pmdomain: rockchip: Add smc call to inform firmware
Date: Mon, 17 Feb 2025 16:16:19 +0100
Message-ID: <2579724.BzM5BlMlMQ@diego>
In-Reply-To: <d543a0a7-8e14-483a-bc2b-783dc3aa33e2@arm.com>
References:
 <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <1738736156-119203-5-git-send-email-shawn.lin@rock-chips.com>
 <d543a0a7-8e14-483a-bc2b-783dc3aa33e2@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Steven,

Am Montag, 17. Februar 2025, 15:47:21 MEZ schrieb Steven Price:
> On 05/02/2025 06:15, Shawn Lin wrote:
> > Inform firmware to keep the power domain on or off.
> > 
> > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> 
> This patch is causing my Firefly RK3288 to fail to boot, it hangs 
> shortly after reaching user space, but the bootup messages include the 
> suspicious line "Bad mode in prefetch abort handler detected".
> I suspect the firmware on this board doesn't support this new SMC 
> correctly. Reverting this patch on top of linux-next gets everything 
> working again.

Is your board actually running some trusted firmware?

Stock rk3288 never had tf-a / psci [0], I did work on that for a while,
but don't think that ever took off.

I'm wondering who the smcc call is calling, but don't know about
about smcc stuff.


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/rockchip/rk3288.dtsi#n63


> --->8----
> [    0.000000] Booting Linux on physical CPU 0x500
> [    0.000000] Linux version 6.14.0-rc2-00003-g58ebba35ddab (root@d016c5e5f311) (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP Mon Feb 17 14:31:50 UTC 2025
> [    0.000000] CPU: ARMv7 Processor [410fc0d1] revision 1 (ARMv7), cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt: Machine model: Firefly-RK3288
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] cma: Reserved 64 MiB at 0x7c000000 on node -1
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] OF: reserved mem: 0xfe000000..0xfeffffff (16384 KiB) map non-reusable dma-unusable@fe000000
> [    0.000000] percpu: Embedded 13 pages/cpu s22924 r8192 d22132 u53248
> [    0.000000] Kernel command line: console=ttyS2,115200 root=/dev/nfs nfsroot=10.1.194.64:/export/root-fs,vers=4,tcp ip=dhcp rw rootwait consoleblank=0 drm.edid_firmware=edid/1920x1080.bin video=HDMI-A-1:1920x1080@60e
> [    0.000000] printk: log buffer data + meta data: 131072 + 409600 = 540672 bytes
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 524288
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=4.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000001] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
> [    0.000020] Switching to timer-based delay loop, resolution 41ns
> [    0.007182] Console: colour dummy device 80x30
> [    0.007249] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
> [    0.007265] CPU: Testing write buffer coherency: ok
> [    0.007314] CPU0: Spectre v2: using BPIALL workaround
> [    0.007323] pid_max: default: 32768 minimum: 301
> [    0.007525] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> [    0.007546] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> [    0.008530] CPU0: thread -1, cpu 0, socket 5, mpidr 80000500
> [    0.008573] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [    0.049973] Setting up static identity map for 0x300000 - 0x3000ac
> [    0.052124] rcu: Hierarchical SRCU implementation.
> [    0.052132] rcu: 	Max phase no-delay instances is 1000.
> [    0.052525] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
> [    0.058613] smp: Bringing up secondary CPUs ...
> [    0.061339] CPU1: thread -1, cpu 1, socket 5, mpidr 80000501
> [    0.061405] CPU1: Spectre v2: using BPIALL workaround
> [    0.071234] CPU2: thread -1, cpu 2, socket 5, mpidr 80000502
> [    0.071301] CPU2: Spectre v2: using BPIALL workaround
> [    0.081203] CPU3: thread -1, cpu 3, socket 5, mpidr 80000503
> [    0.081274] CPU3: Spectre v2: using BPIALL workaround
> [    0.081441] smp: Brought up 1 node, 4 CPUs
> [    0.081456] SMP: Total of 4 processors activated (192.00 BogoMIPS).
> [    0.081468] CPU: All CPU(s) started in SVC mode.
> [    0.082346] Memory: 1984728K/2097152K available (14336K kernel code, 1751K rwdata, 5996K rodata, 2048K init, 401K bss, 43316K reserved, 65536K cma-reserved, 1245184K highmem)
> [    0.082910] devtmpfs: initialized
> [    0.094474] VFP support v0.3: implementor 41 architecture 3 part 30 variant d rev 0
> [    0.094737] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.094761] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
> [    0.096678] pinctrl core: initialized pinctrl subsystem
> [    0.101837] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.104238] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.107471] thermal_sys: Registered thermal governor 'step_wise'
> [    0.107540] cpuidle: using governor menu
> [    0.108146] No ATAGs?
> [    0.108328] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
> [    0.108343] hw-breakpoint: maximum watchpoint size is 4 bytes.
> [    0.111736] Serial: AMBA PL011 UART driver
> [    0.138517] /vop@ff940000: Fixed dependency cycle(s) with /hdmi@ff980000
> [    0.138625] /vop@ff930000: Fixed dependency cycle(s) with /hdmi@ff980000
> [    0.138714] /hdmi@ff980000: Fixed dependency cycle(s) with /vop@ff940000
> [    0.138798] /hdmi@ff980000: Fixed dependency cycle(s) with /vop@ff930000
> [    0.155803] gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.156421] rockchip-gpio ff750000.gpio: probed /pinctrl/gpio@ff750000
> [    0.156974] gpio gpiochip1: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.157292] rockchip-gpio ff780000.gpio: probed /pinctrl/gpio@ff780000
> [    0.157816] gpio gpiochip2: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.158121] rockchip-gpio ff790000.gpio: probed /pinctrl/gpio@ff790000
> [    0.158660] gpio gpiochip3: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.158965] rockchip-gpio ff7a0000.gpio: probed /pinctrl/gpio@ff7a0000
> [    0.159599] gpio gpiochip4: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.159900] rockchip-gpio ff7b0000.gpio: probed /pinctrl/gpio@ff7b0000
> [    0.160479] gpio gpiochip5: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.160790] rockchip-gpio ff7c0000.gpio: probed /pinctrl/gpio@ff7c0000
> [    0.161328] gpio gpiochip6: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.161630] rockchip-gpio ff7d0000.gpio: probed /pinctrl/gpio@ff7d0000
> [    0.162257] gpio gpiochip7: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.162559] rockchip-gpio ff7e0000.gpio: probed /pinctrl/gpio@ff7e0000
> [    0.163094] gpio gpiochip8: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.163386] rockchip-gpio ff7f0000.gpio: probed /pinctrl/gpio@ff7f0000
> [    0.184558] iommu: Default domain type: Translated
> [    0.184568] iommu: DMA domain TLB invalidation policy: strict mode
> [    0.185666] SCSI subsystem initialized
> [    0.186174] usbcore: registered new interface driver usbfs
> [    0.186216] usbcore: registered new interface driver hub
> [    0.186262] usbcore: registered new device driver usb
> [    0.188627] pps_core: LinuxPPS API ver. 1 registered
> [    0.188635] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.188658] PTP clock support registered
> [    0.189025] scmi_core: SCMI protocol bus registered
> [    0.192356] vgaarb: loaded
> [    0.192849] clocksource: Switched to clocksource arch_sys_counter
> [    0.206469] NET: Registered PF_INET protocol family
> [    0.206734] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.208938] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
> [    0.208971] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.208989] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
> [    0.209069] TCP bind hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    0.209442] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.209549] UDP hash table entries: 512 (order: 2, 28672 bytes, linear)
> [    0.209627] UDP-Lite hash table entries: 512 (order: 2, 28672 bytes, linear)
> [    0.209844] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.210463] RPC: Registered named UNIX socket transport module.
> [    0.210473] RPC: Registered udp transport module.
> [    0.210479] RPC: Registered tcp transport module.
> [    0.210484] RPC: Registered tcp-with-tls transport module.
> [    0.210490] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.210502] PCI: CLS 0 bytes, default 64
> [    0.212035] Initialise system trusted keyrings
> [    0.212309] workingset: timestamp_bits=30 max_order=19 bucket_order=0
> [    0.212748] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.213168] NFS: Registering the id_resolver key type
> [    0.213242] Key type id_resolver registered
> [    0.213250] Key type id_legacy registered
> [    0.213285] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> [    0.213294] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
> [    0.213459] Key type asymmetric registered
> [    0.213469] Asymmetric key parser 'x509' registered
> [    0.213617] bounce: pool size: 64 pages
> [    0.213674] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
> [    0.213685] io scheduler mq-deadline registered
> [    0.213693] io scheduler kyber registered
> [    0.213723] io scheduler bfq registered
> [    0.251225] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.276738] dma-pl330 ff250000.dma-controller: Loaded driver for PL330 DMAC-241330
> [    0.276757] dma-pl330 ff250000.dma-controller: 	DBUFF-128x8bytes Num_Chans-8 Num_Peri-20 Num_Events-16
> [    0.277847] dma-pl330 ffb20000.dma-controller: Loaded driver for PL330 DMAC-241330
> [    0.277863] dma-pl330 ffb20000.dma-controller: 	DBUFF-64x8bytes Num_Chans-5 Num_Peri-6 Num_Events-10
> [    0.380654] Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
> [    0.385944] ff180000.serial: ttyS0 at MMIO 0xff180000 (irq = 43, base_baud = 1500000) is a 16550A
> [    0.387722] ff190000.serial: ttyS1 at MMIO 0xff190000 (irq = 44, base_baud = 1500000) is a 16550A
> [    0.389508] ff690000.serial: ttyS2 at MMIO 0xff690000 (irq = 45, base_baud = 1500000) is a 16550A
> [    0.389677] printk: legacy console [ttyS2] enabled
> [    1.453889] ff1b0000.serial: ttyS3 at MMIO 0xff1b0000 (irq = 46, base_baud = 1500000) is a 16550A
> [    1.468928] msm_serial: driver initialized
> [    1.474377] SuperH (H)SCI(F) driver initialized
> [    1.480100] STMicroelectronics ASC driver initialized
> [    1.486009] STM32 USART driver initialized
> [    1.499288] rockchip-vop ff930000.vop: Adding to iommu group 0
> [    1.506338] rockchip-vop ff940000.vop: Adding to iommu group 1
> [    1.516530] Bad mode in prefetch abort handler detected
> [    1.522386] Internal error: Oops - bad mode: 0 [#1] SMP ARM
> [    1.528615] Modules linked in:
> [    1.532038] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.14.0-rc2-00003-g58ebba35ddab #1
> [    1.541973] Hardware name: Rockchip (Device Tree)
> [    1.547234] Workqueue: pm genpd_power_off_work_fn
> [    1.552511] PC is at 0x3e2c0be8
> [    1.556025] LR is at rockchip_pd_power+0x1c0/0x780
> [    1.561391] pc : [<3e2c0be8>]    lr : [<c091d8e0>]    psr: 600001d6
> [    1.568401] sp : f0851e10  ip : f0851e68  fp : 00989682
> [    1.573037] rockchip-drm display-subsystem: bound ff930000.vop (ops 0xc12df8c8)
> [    1.574245] r10: c1a05d0b  r9 : f0851e8c  r8 : c228340c
> [    1.582864] rockchip-drm display-subsystem: bound ff940000.vop (ops 0xc12df8c8)
> [    1.588250] r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
> [    1.596498] dwhdmi-rockchip ff980000.hdmi: Looking up avdd-0v9-supply from device node /hdmi@ff980000
> [    1.603712] r3 : 00000100  r2 : 00000008  r1 : 000000ff  r0 : 82000003
> [    1.603723] Flags: nZCv  IRQs off  FIQs off  Mode MON_32  ISA ARM  Segment none
> [    1.614060] dwhdmi-rockchip ff980000.hdmi: Looking up avdd-0v9-supply property in node /hdmi@ff980000 failed
> [    1.621327] Control: 10c5387d  Table: 0020406a  DAC: c211c040
> [    1.629520] dwhdmi-rockchip ff980000.hdmi: supply avdd-0v9 not found, using dummy regulator
> [    1.640473] Register r0 information: non-paged memory
> [    1.640489] Register r1 information:
> [    1.646930] regulator-dummy: Failed to create debugfs directory
> [    1.656235]  non-paged memory
> [    1.656242] Register r2 information: non-paged memory
> [    1.656252] Register r3 information: non-paged memory
> [    1.656262] Register r4 information: NULL pointer
> [    1.656272] Register r5 information:
> [    1.662015] dwhdmi-rockchip ff980000.hdmi: Looking up avdd-1v8-supply from device node /hdmi@ff980000
> [    1.665899]  NULL pointer
> [    1.665905] Register r6 information: NULL pointer
> [    1.665915] Register r7 information: NULL pointer
> [    1.672547] dwhdmi-rockchip ff980000.hdmi: Looking up avdd-1v8-supply property in node /hdmi@ff980000 failed
> [    1.675830] Register r8 information: slab kmalloc-192 start c22833c0 pointer offset 76
> [    1.681495] dwhdmi-rockchip ff980000.hdmi: supply avdd-1v8 not found, using dummy regulator
> [    1.687127]  size 192
> [    1.687137] Register r9 information: 2-page vmalloc region starting at 0xf0850000 allocated at kernel_clone+0xa4/0x334
> [    1.692409] regulator-dummy: Failed to create debugfs directory
> [    1.696385] Register r10 information: non-slab/vmalloc memory
> [    1.696398] Register r11 information: non-paged memory
> [    1.782501] Register r12 information: 2-page vmalloc region starting at 0xf0850000 allocated at kernel_clone+0xa4/0x334
> [    1.794591] Process kworker/0:1 (pid: 10, stack limit = 0x(ptrval))
> [    1.801605] Stack: (0xf0851e10 to 0xf0852000)
> [    1.806484] 1e00:                                     82000003 000000ff 00000008 00000100
> [    1.815640] 1e20: 00000000 00000000 00000000 00000000 c228340c f0851e8c c1a05d0b 00989682
> [    1.824785] 1e40: f0851e68 f0851e10 c091d8e0 3e2c0be8 600001d6 ffffffff c211c040 00000000
> [    1.833928] 1e60: 00000000 c2283400 00000000 00000000 00000000 00000000 f0851e8c 00000000
> [    1.843081] 1e80: 00000000 c20d6600 c20d4c80 00000000 00000000 00000000 00000000 c44237e1
> [    1.852234] 1ea0: 00000000 00000001 c211c040 c211c304 00000000 c211c2ac c211c2ac c1a05d0b
> [    1.861385] 1ec0: 00000000 c091effc c1a05228 c20d4c80 00000000 c211c040 00000000 00000000
> [    1.870538] 1ee0: 00000000 c211c2ac c211c2ac c0921cac c211c2bc c211c040 c200c500 eefa0740
> [    1.879682] 1f00: 00400000 c200c505 c20d4c80 c0921e40 c2052800 c211c2bc c200c500 c037461c
> [    1.888834] 1f20: 2d657000 c20d4c80 eefa0740 c1a03d40 eefa0760 c2052800 eefa0740 c2052800
> [    1.897987] 1f40: eefa0740 c1a03d40 eefa0760 61c88647 c205282c c03756b0 f0849eb0 c037544c
> [    1.907131] 1f60: c2052800 00000001 c2052a80 c20d4c80 f0849eb0 c037544c c2052800 00000000
> [    1.916283] 1f80: 00000000 c037d3d8 00000000 c44237e1 c2051d40 c037d2e0 00000000 00000000
> [    1.925435] 1fa0: 00000000 00000000 00000000 c03001ac 00000000 00000000 00000000 00000000
> [    1.934585] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.943737] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [    1.952883] Call trace: 
> [    1.952898]  rockchip_pd_power from 0x0
> [    1.960016] Code: bad PC value
> [    1.963433] ---[ end trace 0000000000000000 ]---
> [    1.968598] note: kworker/0:1[10] exited with irqs disabled
> [    1.984567] brd: module loaded
> [    1.993499] loop: module loaded
> [    2.017474] CAN device driver interface
> [    2.023718] bgmac_bcma: Broadcom 47xx GBit MAC driver loaded
> [    2.032360] e1000e: Intel(R) PRO/1000 Network Driver
> [    2.037940] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    2.044619] igb: Intel(R) Gigabit Ethernet Network Driver
> [    2.050659] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    2.065398] pegasus: Pegasus/Pegasus II USB Ethernet driver
> [    2.071667] usbcore: registered new interface driver pegasus
> [    2.078047] usbcore: registered new interface driver asix
> [    2.084133] usbcore: registered new interface driver ax88179_178a
> [    2.090984] usbcore: registered new interface driver cdc_ether
> [    2.097578] usbcore: registered new interface driver smsc75xx
> [    2.104062] usbcore: registered new interface driver smsc95xx
> [    2.110534] usbcore: registered new interface driver net1080
> [    2.116919] usbcore: registered new interface driver cdc_subset
> [    2.123594] usbcore: registered new interface driver zaurus
> [    2.129864] usbcore: registered new interface driver cdc_ncm
> [    2.136245] usbcore: registered new interface driver r8153_ecm
> [    2.146400] dwc2 ff540000.usb: Looking up vusb_d-supply from device node /usb@ff540000
> [    2.155311] dwc2 ff540000.usb: Looking up vusb_d-supply property in node /usb@ff540000 failed
> [    2.164883] dwc2 ff540000.usb: supply vusb_d not found, using dummy regulator
> [    2.172901] regulator-dummy: Failed to create debugfs directory
> [    2.179619] dwc2 ff540000.usb: Looking up vusb_a-supply from device node /usb@ff540000
> [    2.188514] dwc2 ff540000.usb: Looking up vusb_a-supply property in node /usb@ff540000 failed
> [    2.198081] dwc2 ff540000.usb: supply vusb_a not found, using dummy regulator
> [    2.206094] regulator-dummy: Failed to create debugfs directory
> [    2.212726] dwc2 ff540000.usb: Looking up vbus-supply from device node /usb@ff540000
> [    2.221432] dwc2 ff540000.usb: Looking up vbus-supply property in node /usb@ff540000 failed
> [    2.283304] dwc2 ff540000.usb: DWC OTG Controller
> [    2.288603] dwc2 ff540000.usb: new USB bus registered, assigned bus number 1
> [    2.296558] dwc2 ff540000.usb: irq 50, io mem 0xff540000
> [    2.303573] hub 1-0:1.0: USB hub found
> [    2.307826] hub 1-0:1.0: 1 port detected
> [    2.313014] dwc2 ff580000.usb: Looking up vusb_d-supply from device node /usb@ff580000
> [    2.321889] dwc2 ff580000.usb: Looking up vusb_d-supply property in node /usb@ff580000 failed
> [    2.331489] dwc2 ff580000.usb: supply vusb_d not found, using dummy regulator
> [    2.339533] regulator-dummy: Failed to create debugfs directory
> [    2.346273] dwc2 ff580000.usb: Looking up vusb_a-supply from device node /usb@ff580000
> [    2.355188] dwc2 ff580000.usb: Looking up vusb_a-supply property in node /usb@ff580000 failed
> [    2.364767] dwc2 ff580000.usb: supply vusb_a not found, using dummy regulator
> [    2.372754] regulator-dummy: Failed to create debugfs directory
> [    2.379419] dwc2 ff580000.usb: Looking up vbus-supply from device node /usb@ff580000
> [    2.388124] dwc2 ff580000.usb: Looking up vbus-supply property in node /usb@ff580000 failed
> [    2.522921] dwc2 ff580000.usb: EPs: 10, dedicated fifos, 972 entries in SPRAM
> [    2.531750] dwc2 ff580000.usb: DWC OTG Controller
> [    2.537080] dwc2 ff580000.usb: new USB bus registered, assigned bus number 2
> [    2.545014] dwc2 ff580000.usb: irq 51, io mem 0xff580000
> [    2.551854] hub 2-0:1.0: USB hub found
> [    2.556146] hub 2-0:1.0: 1 port detected
> [    2.565931] usbcore: registered new interface driver usb-storage
> [    2.582373] i2c_dev: i2c /dev entries driver
> [    2.594260] /i2c@ff650000/act8846@5a: Fixed dependency cycle(s) with /i2c@ff650000/act8846@5a/regulators/REG4
> [    2.606532] regulator regulator.2: Looking up vp1-supply from device node /i2c@ff650000/act8846@5a/regulators/REG1
> [    2.617808] fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
> [    2.618082] fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1] Detected!
> [    2.618123] regulator regulator.3: Looking up vin-supply from device node /i2c@ff650000/syr828@41
> [    2.618163] vdd_gpu: supplied by vcc_sys
> [    2.618186] regulator regulator.2: Looking up vp1-supply property in node /i2c@ff650000/act8846@5a/regulators/REG1 failed
> [    2.618222] act8865 0-005a: Looking up vp1-supply from device node /i2c@ff650000/act8846@5a
> [    2.625879] regulator regulator.4: Looking up vin-supply from device node /i2c@ff650000/syr827@40
> [    2.633584] vcc_sys: could not add device link regulator.3: -ENOENT
> [    2.638056] dw_wdt ff800000.watchdog: No valid TOPs array specified
> [    2.648483] cpu cpu0: Looking up cpu0-supply from device node /cpus/cpu@500
> [    2.660165] vcc_sys: Failed to create debugfs directory
> [    2.660825] vdd_gpu: 850 <--> 1350 mV at 1000 mV 2147483647 mW budge, enabled
> [    2.662861] vcc_ddr: supplied by vcc_sys
> [    2.662879] vcc_sys: could not add device link regulator.2: -ENOENT
> [    2.662891] vcc_sys: Failed to create debugfs directory
> [    2.662930] vdd_cpu: supplied by vcc_sys
> [    2.662945] vcc_sys: could not add device link regulator.4: -ENOENT
> [    2.662956] vcc_sys: Failed to create debugfs directory
> [    2.663751] vcc_ddr: 1200 mV 2147483647 mW budge, enabled
> [    2.664223] vcc_ddr: Failed to create debugfs directory
> [    2.664321] regulator regulator.5: Looking up vp2-supply from device node /i2c@ff650000/act8846@5a/regulators/REG2
> [    2.664359] regulator regulator.5: Looking up vp2-supply property in node /i2c@ff650000/act8846@5a/regulators/REG2 failed
> [    2.664389] act8865 0-005a: Looking up vp2-supply from device node /i2c@ff650000/act8846@5a
> [    2.664417] vcc_io: supplied by vcc_sys
> [    2.664430] vcc_sys: could not add device link regulator.5: -ENOENT
> [    2.664442] vcc_sys: Failed to create debugfs directory
> [    2.665099] vcc_io: 3300 mV 2147483647 mW budge, enabled
> [    2.665574] vcc_io: Failed to create debugfs directory
> [    2.665662] regulator regulator.6: Looking up vp3-supply from device node /i2c@ff650000/act8846@5a/regulators/REG3
> [    2.665700] regulator regulator.6: Looking up vp3-supply property in node /i2c@ff650000/act8846@5a/regulators/REG3 failed
> [    2.665730] act8865 0-005a: Looking up vp3-supply from device node /i2c@ff650000/act8846@5a
> [    2.665757] vdd_log: supplied by vcc_sys
> [    2.665770] vcc_sys: could not add device link regulator.6: -ENOENT
> [    2.665781] vcc_sys: Failed to create debugfs directory
> [    2.665968] vdd_cpu: 850 <--> 1350 mV at 1000 mV 2147483647 mW budge, enabled
> [    2.666465] vdd_cpu: Failed to create debugfs directory
> [    2.666860] vdd_log: 1100 mV 2147483647 mW budge, enabled
> [    2.667151] vdd_log: Failed to create debugfs directory
> [    2.667249] regulator regulator.7: Looking up vp4-supply from device node /i2c@ff650000/act8846@5a/regulators/REG4
> [    2.667287] regulator regulator.7: Looking up vp4-supply property in node /i2c@ff650000/act8846@5a/regulators/REG4 failed
> [    2.667317] act8865 0-005a: Looking up vp4-supply from device node /i2c@ff650000/act8846@5a
> [    2.667344] vcc_20: supplied by vcc_sys
> [    2.667356] vcc_sys: could not add device link regulator.7: -ENOENT
> [    2.667368] vcc_sys: Failed to create debugfs directory
> [    2.667831] vcc_20: 2000 mV 2147483647 mW budge, enabled
> [    2.668118] vcc_20: Failed to create debugfs directory
> [    2.668213] regulator regulator.8: Looking up inl1-supply from device node /i2c@ff650000/act8846@5a/regulators/REG5
> [    2.668250] regulator regulator.8: Looking up inl1-supply property in node /i2c@ff650000/act8846@5a/regulators/REG5 failed
> [    2.668280] act8865 0-005a: Looking up inl1-supply from device node /i2c@ff650000/act8846@5a
> [    2.668306] vccio_sd: supplied by vcc_sys
> [    2.668319] vcc_sys: could not add device link regulator.8: -ENOENT
> [    2.668331] vcc_sys: Failed to create debugfs directory
> [    2.668797] vccio_sd: 3300 mV 2147483647 mW budge, enabled
> [    2.669077] vccio_sd: Failed to create debugfs directory
> [    2.669172] regulator regulator.9: Looking up inl1-supply from device node /i2c@ff650000/act8846@5a/regulators/REG6
> [    2.669208] regulator regulator.9: Looking up inl1-supply property in node /i2c@ff650000/act8846@5a/regulators/REG6 failed
> [    2.669238] act8865 0-005a: Looking up inl1-supply from device node /i2c@ff650000/act8846@5a
> [    2.669265] vdd10_lcd: supplied by vcc_sys
> [    2.669278] vcc_sys: could not add device link regulator.9: -ENOENT
> [    2.669289] vcc_sys: Failed to create debugfs directory
> [    2.669588] vdd_cpu: Failed to create debugfs directory
> [    2.669868] vdd10_lcd: 1000 mV 2147483647 mW budge, enabled
> [    2.670159] vdd10_lcd: Failed to create debugfs directory
> [    2.670402] vcca_18: Bringing 3300000uV into 1800000-1800000uV
> [    2.671256] vcca_18: 1800 mV 2147483647 mW budge, disabled
> [    2.671533] vcca_18: Failed to create debugfs directory
> [    2.671553] regulator regulator.10: Looking up inl1-supply from device node /i2c@ff650000/act8846@5a/regulators/REG7
> [    2.671587] regulator regulator.10: Looking up inl1-supply property in node /i2c@ff650000/act8846@5a/regulators/REG7 failed
> [    2.671618] act8865 0-005a: Looking up inl1-supply from device node /i2c@ff650000/act8846@5a
> [    2.671644] vcca_18: supplied by vcc_sys
> [    2.671663] vcc_sys: Failed to create debugfs directory
> [    2.672059] vcca_33: 3300 mV 2147483647 mW budge, disabled
> [    2.672349] vcca_33: Failed to create debugfs directory
> [    2.672368] regulator regulator.11: Looking up inl2-supply from device node /i2c@ff650000/act8846@5a/regulators/REG8
> [    2.672403] regulator regulator.11: Looking up inl2-supply property in node /i2c@ff650000/act8846@5a/regulators/REG8 failed
> [    2.672433] act8865 0-005a: Looking up inl2-supply from device node /i2c@ff650000/act8846@5a
> [    2.672459] vcca_33: supplied by vcc_sys
> [    2.672477] vcc_sys: Failed to create debugfs directory
> [    2.672879] vcc_lan: 3300 mV 2147483647 mW budge, enabled
> [    2.673160] vcc_lan: Failed to create debugfs directory
> [    2.673181] regulator regulator.12: Looking up inl2-supply from device node /i2c@ff650000/act8846@5a/regulators/REG9
> [    2.673216] regulator regulator.12: Looking up inl2-supply property in node /i2c@ff650000/act8846@5a/regulators/REG9 failed
> [    2.673246] act8865 0-005a: Looking up inl2-supply from device node /i2c@ff650000/act8846@5a
> [    2.673272] vcc_lan: supplied by vcc_sys
> [    2.673291] vcc_sys: Failed to create debugfs directory
> [    2.673384] regulator regulator.13: Looking up inl3-supply from device node /i2c@ff650000/act8846@5a/regulators/REG10
> [    2.673419] regulator regulator.13: Looking up inl3-supply property in node /i2c@ff650000/act8846@5a/regulators/REG10 failed
> [    2.673448] act8865 0-005a: Looking up inl3-supply from device node /i2c@ff650000/act8846@5a
> [    2.673475] vdd_10: supplied by vcc_20
> [    2.673486] vcc_20: could not add device link regulator.13: -ENOENT
> [    2.673498] vcc_20: Failed to create debugfs directory
> [    2.674106] vdd_10: 1000 mV 2147483647 mW budge, enabled
> [    2.674394] vdd_10: Failed to create debugfs directory
> [    2.674502] regulator regulator.14: Looking up inl3-supply from device node /i2c@ff650000/act8846@5a/regulators/REG11
> [    2.674539] regulator regulator.14: Looking up inl3-supply property in node /i2c@ff650000/act8846@5a/regulators/REG11 failed
> [    2.674569] act8865 0-005a: Looking up inl3-supply from device node /i2c@ff650000/act8846@5a
> [    2.674598] vcc_18: supplied by vcc_20
> [    2.674611] vcc_20: could not add device link regulator.14: -ENOENT
> [    2.674622] vcc_20: Failed to create debugfs directory
> [    2.675230] vcc_18: 1800 mV 2147483647 mW budge, enabled
> [    2.675514] vcc_18: Failed to create debugfs directory
> [    2.675621] regulator regulator.15: Looking up inl3-supply from device node /i2c@ff650000/act8846@5a/regulators/REG12
> [    2.675658] regulator regulator.15: Looking up inl3-supply property in node /i2c@ff650000/act8846@5a/regulators/REG12 failed
> [    2.675688] act8865 0-005a: Looking up inl3-supply from device node /i2c@ff650000/act8846@5a
> [    2.675717] vcc18_lcd: supplied by vcc_20
> [    2.675730] vcc_20: could not add device link regulator.15: -ENOENT
> [    2.675741] vcc_20: Failed to create debugfs directory
> [    2.676459] vcc18_lcd: 1800 mV 2147483647 mW budge, enabled
> [    2.676749] vcc18_lcd: Failed to create debugfs directory
> [    2.679822] vdd_gpu: Failed to create debugfs directory
> [    2.688423] cpufreq: cpufreq_online: CPU0: Running at unlisted initial frequency: 500000 kHz, changing to: 600000 kHz
> [    3.475177] sdhci: Secure Digital Host Controller Interface driver
> [    3.482091] sdhci: Copyright(c) Pierre Ossman
> [    3.488013] Synopsys Designware Multimedia Card Interface Driver
> [    3.495568] sdhci-pltfm: SDHCI platform and OF driver helper
> [    3.503194] dwmmc_rockchip ff0d0000.mmc: IDMAC supports 32-bit address mode.
> [    3.504232] usbcore: registered new interface driver usbhid
> [    3.517302] usbhid: USB HID core driver
> [    3.523947] dwmmc_rockchip ff0d0000.mmc: Using internal DMA controller.
> [    3.524011] hw perfevents: enabled with armv7_cortex_a12 PMU driver, 7 (8000003f) counters available
> [    3.531334] dwmmc_rockchip ff0d0000.mmc: Version ID is 270a
> [    3.542498] NET: Registered PF_INET6 protocol family
> [    3.547774] dwmmc_rockchip ff0d0000.mmc: DW MMC controller at irq 59,32 bit host data width,256 deep fifo
> [    3.553833] Segment Routing with IPv6
> [    3.564050] dwmmc_rockchip ff0d0000.mmc: Looking up vmmc-supply from device node /mmc@ff0d0000
> [    3.568120] In-situ OAM (IOAM) with IPv6
> [    3.577728] vcc_sys: Failed to create debugfs directory
> [    3.582130] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    3.587967] dwmmc_rockchip ff0d0000.mmc: Looking up vqmmc-supply from device node /mmc@ff0d0000
> [    3.594797] NET: Registered PF_PACKET protocol family
> [    3.604277] vcc_18: Failed to create debugfs directory
> [    3.609905] can: controller area network core
> [    3.615803] dwmmc_rockchip ff0d0000.mmc: Looking up vqmmc2-supply from device node /mmc@ff0d0000
> [    3.620519] NET: Registered PF_CAN protocol family
> [    3.630328] dwmmc_rockchip ff0d0000.mmc: Looking up vqmmc2-supply property in node /mmc@ff0d0000 failed
> [    3.635677] can: raw protocol
> [    3.646187] dwmmc_rockchip ff0d0000.mmc: Failed getting OCR mask: 0
> [    3.649469] can: broadcast manager protocol
> [    3.656493] mmc_host mmc0: card is non-removable.
> [    3.661134] can: netlink gateway - max_hops=1
> [    3.666415] dwmmc_rockchip ff0d0000.mmc: could not set regulator OCR (-22)
> [    3.671434] Key type dns_resolver registered
> [    3.678925] dwmmc_rockchip ff0d0000.mmc: failed to enable vmmc regulator
> [    3.691271] ThumbEE CPU extension supported.
> [    3.691975] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> [    3.696051] Registering SWP/SWPB emulation handler
> [    3.715354] Loading compiled-in X.509 certificates
> [    3.729815] vcc_sd: 3300 mV 2147483647 mW budge, disabled
> [    3.735933] vcc_sd: Failed to create debugfs directory
> [    3.735989] rockchip-drm display-subsystem: bound ff930000.vop (ops 0xc12df8c8)
> [    3.736133] vcc_flash: will resolve supply early: vin
> [    3.736138] regulator regulator.17: Looking up vin-supply from device node /flash-regulator
> [    3.736150] vcc_flash: supplied by vcc_io
> [    3.736155] vcc_io: could not add device link regulator.17: -ENOENT
> [    3.736158] vcc_io: Failed to create debugfs directory
> [    3.736293] vcc_flash: 1800 mV 2147483647 mW budge, enabled
> [    3.736335] vcc_flash: Failed to create debugfs directory
> [    3.736344] regulator regulator.16: Looking up vin-supply from device node /sdmmc-regulator
> [    3.736352] vcc_sd: supplied by vcc_io
> [    3.736358] vcc_io: Failed to create debugfs directory
> [    3.736484] reg-fixed-voltage flash-regulator: vcc_flash supplying 1800000uV
> [    3.736645] regulator regulator.18: Looking up vin-supply from device node /usb-regulator
> [    3.736655] vcc_5v: supplied by vcc_sys
> [    3.736659] vcc_sys: could not add device link regulator.18: -ENOENT
> [    3.736662] vcc_sys: Failed to create debugfs directory
> [    3.736668] vcc_5v: 5000 mV 2147483647 mW budge, enabled
> [    3.736707] vcc_5v: Failed to create debugfs directory
> [    3.736714] reg-fixed-voltage usb-regulator: vcc_5v supplying 5000000uV
> [    3.736925] regulator regulator.19: Looking up vin-supply from device node /usb-host-regulator
> [    3.736949] vcc_host_5v: supplied by vcc_5v
> [    3.736953] vcc_5v: could not add device link regulator.19: -ENOENT
> [    3.736956] vcc_5v: Failed to create debugfs directory
> [    3.736964] vcc_host_5v: 5000 mV 2147483647 mW budge, enabled
> [    3.737000] vcc_host_5v: Failed to create debugfs directory
> [    3.737008] reg-fixed-voltage usb-host-regulator: vcc_host_5v supplying 5000000uV
> [    3.737192] regulator regulator.20: Looking up vin-supply from device node /usb-otg-regulator
> [    3.737204] vcc_otg_5v: supplied by vcc_5v
> [    3.737208] vcc_5v: could not add device link regulator.20: -ENOENT
> [    3.737212] vcc_5v: Failed to create debugfs directory
> [    3.737219] vcc_otg_5v: 5000 mV 2147483647 mW budge, enabled
> [    3.737260] vcc_otg_5v: Failed to create debugfs directory
> [    3.737268] reg-fixed-voltage usb-otg-regulator: vcc_otg_5v supplying 5000000uV
> [    3.737452] regulator regulator.21: Looking up vin-supply from device node /vcc28-dvp-regulator
> [    3.737461] vcc28_dvp: supplied by vcc_io
> [    3.737465] vcc_io: could not add device link regulator.21: -ENOENT
> [    3.737469] vcc_io: Failed to create debugfs directory
> [    3.737600] vcc28_dvp: 2800 mV 2147483647 mW budge, enabled
> [    3.737638] vcc28_dvp: Failed to create debugfs directory
> [    3.737646] reg-fixed-voltage vcc28-dvp-regulator: vcc28_dvp supplying 2800000uV
> [    3.741681] reg-fixed-voltage sdmmc-regulator: vcc_sd supplying 3300000uV
> [    3.750062] rockchip-drm display-subsystem: bound ff940000.vop (ops 0xc12df8c8)
> [    4.025404] dwhdmi-rockchip ff980000.hdmi: Looking up avdd-0v9-supply from device node /hdmi@ff980000
> [    4.035722] dwhdmi-rockchip ff980000.hdmi: Looking up avdd-0v9-supply property in node /hdmi@ff980000 failed
> [    4.046720] dwhdmi-rockchip ff980000.hdmi: supply avdd-0v9 not found, using dummy regulator
> [    4.056060] regulator-dummy: Failed to create debugfs directory
> [    4.062700] dwhdmi-rockchip ff980000.hdmi: Looking up avdd-1v8-supply from device node /hdmi@ff980000
> [    4.073015] dwhdmi-rockchip ff980000.hdmi: Looking up avdd-1v8-supply property in node /hdmi@ff980000 failed
> [    4.084011] dwhdmi-rockchip ff980000.hdmi: supply avdd-1v8 not found, using dummy regulator
> [    4.093348] regulator-dummy: Failed to create debugfs directory
> [    4.100008] dwhdmi-rockchip ff980000.hdmi: Detected HDMI TX controller v2.00a with HDCP (DWC MHL PHY)
> [    4.110972] [drm] forcing HDMI-A-1 connector on
> [    4.116055] rockchip-drm display-subsystem: bound ff980000.hdmi (ops 0xc12e33b4)
> [    4.124604] [drm] Initialized rockchip 1.0.0 for display-subsystem on minor 0
> [    4.204228] Console: switching to colour frame buffer device 240x67
> [    4.228647] rockchip-drm display-subsystem: [drm] fb0: rockchipdrmfb frame buffer device
> [    4.238760] rk_gmac-dwmac ff290000.ethernet: IRQ eth_lpi not found
> [    4.245687] rk_gmac-dwmac ff290000.ethernet: IRQ sfty not found
> [    4.252323] rk_gmac-dwmac ff290000.ethernet: Deprecated MDIO bus assumption used
> [    4.260615] rk_gmac-dwmac ff290000.ethernet: PTP uses main clock
> [    4.267347] rk_gmac-dwmac ff290000.ethernet: Looking up phy-supply from device node /ethernet@ff290000
> [    4.277773] vcc_lan: Failed to create debugfs directory
> [    4.283659] rk_gmac-dwmac ff290000.ethernet: clock input or output? (input).
> [    4.291534] rk_gmac-dwmac ff290000.ethernet: TX delay(0x30).
> [    4.297862] rk_gmac-dwmac ff290000.ethernet: RX delay(0x10).
> [    4.304192] rk_gmac-dwmac ff290000.ethernet: integrated PHY? (no).
> [    4.311110] rk_gmac-dwmac ff290000.ethernet: clock input from PHY
> [    4.322924] rk_gmac-dwmac ff290000.ethernet: init for RGMII
> [    4.329380] rk_gmac-dwmac ff290000.ethernet: User ID: 0x10, Synopsys ID: 0x35
> [    4.337367] rk_gmac-dwmac ff290000.ethernet: 	DWMAC1000
> [    4.343216] rk_gmac-dwmac ff290000.ethernet: DMA HW capability register supported
> [    4.351575] rk_gmac-dwmac ff290000.ethernet: RX Checksum Offload Engine supported
> [    4.359932] rk_gmac-dwmac ff290000.ethernet: COE Type 2
> [    4.365769] rk_gmac-dwmac ff290000.ethernet: TX Checksum insertion supported
> [    4.373647] rk_gmac-dwmac ff290000.ethernet: Wake-Up On Lan supported
> [    4.380867] rk_gmac-dwmac ff290000.ethernet: Normal descriptors
> [    4.387475] rk_gmac-dwmac ff290000.ethernet: Ring mode enabled
> [    4.393993] rk_gmac-dwmac ff290000.ethernet: Enable RX Mitigation via HW Watchdog Timer
> [    5.452460] RTL8211E Gigabit Ethernet stmmac-0:00: attached PHY driver (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
> [    5.463749] RTL8211E Gigabit Ethernet stmmac-0:01: attached PHY driver (mii_bus:phy_addr=stmmac-0:01, irq=POLL)
> [    5.479861] dwmmc_rockchip ff0c0000.mmc: IDMAC supports 32-bit address mode.
> [    5.483070] dovdd_1v8: will resolve supply early: vin
> [    5.483274] dwmmc_rockchip ff0f0000.mmc: IDMAC supports 32-bit address mode.
> [    5.488086] input: gpio-keys as /devices/platform/gpio-keys/input/input0
> [    5.493420] regulator regulator.22: Looking up vin-supply from device node /dovdd-1v8-regulator
> [    5.518548] dovdd_1v8: supplied by vcc28_dvp
> [    5.523334] vcc28_dvp: could not add device link regulator.22: -ENOENT
> [    5.530626] vcc28_dvp: Failed to create debugfs directory
> [    5.536669] dovdd_1v8: 1800 mV 2147483647 mW budge, enabled
> [    5.542956] dovdd_1v8: Failed to create debugfs directory
> [    5.548993] reg-fixed-voltage dovdd-1v8-regulator: dovdd_1v8 supplying 1800000uV
> [    5.557364] dwmmc_rockchip ff0f0000.mmc: Using internal DMA controller.
> [    5.557729] rockchip-iodomain ff770000.syscon:io-domains: Looking up lcdc-supply from device node /syscon@ff770000/io-domains
> [    5.564771] dwmmc_rockchip ff0f0000.mmc: Version ID is 270a
> [    5.577421] vcc_io: Failed to create debugfs directory
> [    5.583646] dwmmc_rockchip ff0f0000.mmc: DW MMC controller at irq 68,32 bit host data width,256 deep fifo
> [    5.589655] rockchip-iodomain ff770000.syscon:io-domains: Looking up dvp-supply from device node /syscon@ff770000/io-domains
> [    5.600082] dwmmc_rockchip ff0f0000.mmc: Looking up vmmc-supply from device node /mmc@ff0f0000
> [    5.612638] dovdd_1v8: Failed to create debugfs directory
> [    5.622225] vcc_io: Failed to create debugfs directory
> [    5.634029] dwmmc_rockchip ff0c0000.mmc: Using internal DMA controller.
> [    5.634124] rockchip-iodomain ff770000.syscon:io-domains: Looking up flash0-supply from device node /syscon@ff770000/io-domains
> [    5.634144] dwmmc_rockchip ff0f0000.mmc: Looking up vqmmc-supply from device node /mmc@ff0f0000
> [    5.634159] vcc_flash: Failed to create debugfs directory
> [    5.634187] dwmmc_rockchip ff0f0000.mmc: Looking up vqmmc2-supply from device node /mmc@ff0f0000
> [    5.634195] dwmmc_rockchip ff0f0000.mmc: Looking up vqmmc2-supply property in node /mmc@ff0f0000 failed
> [    5.634245] mmc_host mmc1: card is non-removable.
> [    5.641421] dwmmc_rockchip ff0c0000.mmc: Version ID is 270a
> [    5.654270] vcc_flash: Failed to create debugfs directory
> [    5.663992] dwmmc_rockchip ff0c0000.mmc: DW MMC controller at irq 67,32 bit host data width,256 deep fifo
> [    5.670041] rockchip-iodomain ff770000.syscon:io-domains: Looking up flash1-supply from device node /syscon@ff770000/io-domains
> [    5.679855] dwmmc_rockchip ff0c0000.mmc: Looking up vmmc-supply from device node /mmc@ff0c0000
> [    5.682548] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> [    5.690334] vcc_lan: Failed to create debugfs directory
> [    5.695600] vcc_sd: Failed to create debugfs directory
> [    5.701981] rockchip-iodomain ff770000.syscon:io-domains: Looking up wifi-supply from device node /syscon@ff770000/io-domains
> [    5.707867] dwmmc_rockchip ff0c0000.mmc: Looking up vqmmc-supply from device node /mmc@ff0c0000
> [    5.718555] vcc_18: Failed to create debugfs directory
> [    5.731371] vccio_sd: Failed to create debugfs directory
> [    5.751351] dwmmc_rockchip ff0c0000.mmc: Looking up vqmmc2-supply from device node /mmc@ff0c0000
> [    5.757431] rockchip-iodomain ff770000.syscon:io-domains: Looking up bb-supply from device node /syscon@ff770000/io-domains
> [    5.762891] dwmmc_rockchip ff0c0000.mmc: Looking up vqmmc2-supply property in node /mmc@ff0c0000 failed
> [    5.857337] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
> [    5.868409] mmc1: new high speed MMC card at address 0001
> [    5.873562] vcc_io: Failed to create debugfs directory
> [    5.874913] mmcblk1: mmc1:0001 AGND3R 14.6 GiB
> [    5.880562] rockchip-iodomain ff770000.syscon:io-domains: Looking up audio-supply from device node /syscon@ff770000/io-domains
> [    5.892854] mmc_host mmc2: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> [    5.897919] vcca_33: Failed to create debugfs directory
> [    5.914229] rockchip-iodomain ff770000.syscon:io-domains: Looking up sdcard-supply from device node /syscon@ff770000/io-domains
> [    5.914357] mmcblk1boot0: mmc1:0001 AGND3R 4.00 MiB
> [    5.927108] vccio_sd: Failed to create debugfs directory
> [    5.933361] mmcblk1boot1: mmc1:0001 AGND3R 4.00 MiB
> [    5.938787] rockchip-iodomain ff770000.syscon:io-domains: Looking up gpio30-supply from device node /syscon@ff770000/io-domains
> [    5.944582] mmcblk1rpmb: mmc1:0001 AGND3R 4.00 MiB, chardev (238:0)
> [    5.956784] vcc_io: Failed to create debugfs directory
> [    5.969763] rockchip-iodomain ff770000.syscon:io-domains: Looking up gpio1830-supply from device node /syscon@ff770000/io-domains
> [    5.982806] vcc_io: Failed to create debugfs directory
> [    5.989703] rk_gmac-dwmac ff290000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> [    5.999827] rk_gmac-dwmac ff290000.ethernet eth0: PHY [stmmac-0:00] driver [RTL8211E Gigabit Ethernet] (irq=POLL)
> [    6.022592] rk_gmac-dwmac ff290000.ethernet eth0: No Safety Features support found
> [    6.031060] rk_gmac-dwmac ff290000.ethernet eth0: PTP not supported by HW
> [    6.038849] rk_gmac-dwmac ff290000.ethernet eth0: configuring for phy/rgmii link mode
> [    6.064639] mmc_host mmc2: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
> [    6.075574] mmc2: new high speed SDHC card at address 0007
> [    6.082195] mmcblk2: mmc2:0007 SD08G 7.42 GiB
> [    6.088223]  mmcblk2: p1 p2
> [    8.164449] rk_gmac-dwmac ff290000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
> [    8.202822] Sending DHCP requests ., OK
> [    8.247120] IP-Config: Got DHCP answer from 10.1.194.1, my address is 10.1.194.22
> [    8.255491] IP-Config: Complete:
> [    8.259089]      device=eth0, hwaddr=0e:3c:67:4e:4f:6f, ipaddr=10.1.194.22, mask=255.255.254.0, gw=10.1.194.1
> [    8.270174]      host=10.1.194.22, domain=cambridge.arm.com, nis-domain=(none)
> [    8.278245]      bootserver=10.1.109.185, rootserver=10.1.194.64, rootpath=
> [    8.278249]      nameserver0=10.1.2.23, nameserver1=10.1.2.24, nameserver2=10.58.2.36
> [    8.294781]      ntpserver0=10.58.96.12, ntpserver1=10.123.17.134, ntpserver2=10.6.22.12
> [    8.303951] clk: Disabling unused clocks
> [    8.308549] PM: genpd: Disabling unused power domains
> [    8.314414] dw-apb-uart ff690000.serial: forbid DMA for kernel console
> [    8.356595] VFS: Mounted root (nfs4 filesystem) on device 0:16.
> [    8.363690] devtmpfs: mounted
> [    8.368079] Freeing unused kernel image (initmem) memory: 2048K
> [    8.374846] Run /sbin/init as init process
> [    8.379418]   with arguments:
> [    8.382726]     /sbin/init
> [    8.385754]   with environment:
> [    8.389257]     HOME=/
> [    8.391884]     TERM=linux
> [    9.182289] systemd[1]: System time before build time, advancing clock.
> [    9.200137] systemd[1]: Failed to look up module alias 'autofs4': Function not implemented
> [    9.236387] systemd[1]: systemd 247.3-7+deb11u1 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
> [    9.262460] systemd[1]: Detected architecture arm.
> 
> Welcome to Debian GNU/Linux 11 (bullseye)!
> 
> 
> > Changes in v7: None
> > Changes in v6: None
> > Changes in v5:
> > - fix a compile warning
> > 
> > Changes in v4: None
> > Changes in v3: None
> > Changes in v2: None
> > 
> >  drivers/pmdomain/rockchip/pm-domains.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> > index cb0f938..49842f1 100644
> > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > @@ -5,6 +5,7 @@
> >   * Copyright (c) 2015 ROCKCHIP, Co. Ltd.
> >   */
> >  
> > +#include <linux/arm-smccc.h>
> >  #include <linux/io.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/err.h>
> > @@ -20,6 +21,7 @@
> >  #include <linux/regmap.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <soc/rockchip/pm_domains.h>
> > +#include <soc/rockchip/rockchip_sip.h>
> >  #include <dt-bindings/power/px30-power.h>
> >  #include <dt-bindings/power/rockchip,rv1126-power.h>
> >  #include <dt-bindings/power/rk3036-power.h>
> > @@ -540,6 +542,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
> >  	struct generic_pm_domain *genpd = &pd->genpd;
> >  	u32 pd_pwr_offset = pd->info->pwr_offset;
> >  	bool is_on, is_mem_on = false;
> > +	struct arm_smccc_res res;
> >  
> >  	if (pd->info->pwr_mask == 0)
> >  		return;
> > @@ -567,6 +570,11 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
> >  			genpd->name, is_on);
> >  		return;
> >  	}
> > +
> > +	/* Inform firmware to keep this pd on or off */
> > +	arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
> > +			pmu->info->pwr_offset + pd_pwr_offset,
> > +			pd->info->pwr_mask, on, 0, 0, 0, &res);
> >  }
> >  
> >  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
> 
> 





