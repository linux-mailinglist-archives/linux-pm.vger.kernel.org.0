Return-Path: <linux-pm+bounces-24596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AA5A753A0
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 01:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E282A1714D3
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 00:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF70079C4;
	Sat, 29 Mar 2025 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="Kj+Iimw3"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED51367
	for <linux-pm@vger.kernel.org>; Sat, 29 Mar 2025 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743207304; cv=none; b=dErgiCz1wsxc3N0tB0K22P4C0o7n7r8Z+YH5oLe+U2CgSh6D2UydLGhtFQU9qZyoHHA48affUIxgMGZ/sDizLM2lBowlOnOHcGSbFO9W+iQKd9NlyGOtW0dMXqnLdRrYiQPDPfjQ9skapaTSrHTXHEr59JLYYS6leZa+0tyAysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743207304; c=relaxed/simple;
	bh=n8GszMAg4a11hiRIFr18JzxhdnksZHeLzNhtm3Z611s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCih0y27LG0J7hTfZZ1vwdu5Lj2hKsdNeAVPXWFO8JwSENkxmbEU4J96sRh9Vqsu7zHGGz6a3aFa1SBBx/DylVkb28GPHM/emXF4OdN5TIpoDJY/UQVwWGPYyn+c6MFDv253z53d+3y/cI1dF6uPMZ6KiBc4ZhHAxOn4Up7N578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=Kj+Iimw3; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Sat, 29 Mar 2025 01:14:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743207298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8Jk106p3G2d/TF5qNiNH7K30Re+D1270gW4FaqkWao=;
	b=Kj+Iimw3J0v0v9Cz+Ll7PTHAM9zvpQXDJ3Rm0HYxwxrmxLo8V1ptmoVYeeQX8027Gd+TAL
	Z/JDk+H0+IcZrcKlC8Kk/OzK72nJzJ0zyjKTp24MsCrrBgeftTaOcBEirte1Al9lAXKGZ1
	a8EY04kk3gtznJQl1Rit86YrkKx5wa/noy65vrndLkTeJH23QPGo4MiMM7avvdUrEFoVqR
	VAyslGbRqAgmlkZ5gvCHCwHzx8MV3quLlVTpd7v+zHy+zWeYXGXpwU17BaOmjpdTXBw9UW
	k76/Oi+VGEzAdQ7666UR2rWFQzTBQ0Dm0RwDKYvvxHKCbpwcQgY3gN5tnj9y/g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Dave Young <dyoung@redhat.com>, bhe@redhat.com
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z-c7f-xIckXkYnX1@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-c7V2hptt9U9UCl@desktop0a>
X-Migadu-Flow: FLOW_OUT

[    0.000000] Linux version 6.14.0 (ricci@desktop0a) (gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC @0
[    0.000000] Command line: root=UUID=71b5e20d-efaa-4c09-b189-73cd6255e8ce ro loglevel=4 oops=panic panic=30 crashkernel=512M
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
[    0.000000] random: crng init done
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x13fffa0f0-0x13fffa0ff] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000bffdffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000013fffa0ef] usable
[    0.000000] reserve setup_data: [mem 0x000000013fffa0f0-0x000000013fffa0ff] usable
[    0.000000] reserve setup_data: [mem 0x000000013fffa100-0x000000013fffffff] usable
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 146676925254 cycles
[    0.000002] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000004] tsc: Detected 1704.004 MHz processor
[    0.000761] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000763] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000767] last_pfn = 0x140000 max_arch_pfn = 0x400000000
[    0.000801] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.000804] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000848] last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
[    0.007220] found SMP MP-table at [mem 0x000f5480-0x000f548f]
[    0.007348] RAMDISK: [mem 0x13ce50000-0x13d5fffff]
[    0.007351] ACPI: Early table checksum verification disabled
[    0.007354] ACPI: RSDP 0x00000000000F5280 000014 (v00 BOCHS )
[    0.007357] ACPI: RSDT 0x00000000BFFE22F2 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.007362] ACPI: FACP 0x00000000BFFE21A6 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.007367] ACPI: DSDT 0x00000000BFFE0040 002166 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.007370] ACPI: FACS 0x00000000BFFE0000 000040
[    0.007373] ACPI: APIC 0x00000000BFFE221A 000078 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.007376] ACPI: HPET 0x00000000BFFE2292 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.007378] ACPI: WAET 0x00000000BFFE22CA 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.007380] ACPI: Reserving FACP table memory at [mem 0xbffe21a6-0xbffe2219]
[    0.007381] ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe21a5]
[    0.007382] ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
[    0.007383] ACPI: Reserving APIC table memory at [mem 0xbffe221a-0xbffe2291]
[    0.007383] ACPI: Reserving HPET table memory at [mem 0xbffe2292-0xbffe22c9]
[    0.007384] ACPI: Reserving WAET table memory at [mem 0xbffe22ca-0xbffe22f1]
[    0.007664] No NUMA configuration found
[    0.007665] Faking a node at [mem 0x0000000000000000-0x000000013fffffff]
[    0.007668] NODE_DATA(0) allocated [mem 0x13fffc940-0x13fffffff]
[    0.007672] crashkernel reserved: 0x000000009f000000 - 0x00000000bf000000 (512 MB)
[    0.007697] Zone ranges:
[    0.007697]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007699]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007700]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.007701] Movable zone start for each node
[    0.007702] Early memory node ranges
[    0.007702]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.007703]   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
[    0.007704]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.007705] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
[    0.007713] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007752] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.014967] On node 0, zone Normal: 32 pages in unavailable ranges
[    0.015326] ACPI: PM-Timer IO Port: 0x608
[    0.015335] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.015367] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.015370] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.015371] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.015372] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.015373] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.015374] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.015377] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.015378] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.015384] CPU topo: Max. logical packages:   1
[    0.015385] CPU topo: Max. logical dies:       1
[    0.015386] CPU topo: Max. dies per package:   1
[    0.015389] CPU topo: Max. threads per core:   1
[    0.015390] CPU topo: Num. cores per package:     1
[    0.015390] CPU topo: Num. threads per package:   1
[    0.015391] CPU topo: Allowing 1 present CPUs plus 0 hotplug CPUs
[    0.015402] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
[    0.015414] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.015416] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.015417] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.015417] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.015418] PM: hibernation: Registered nosave memory: [mem 0xbffe0000-0xbfffffff]
[    0.015419] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfeffbfff]
[    0.015419] PM: hibernation: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.015420] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.015420] PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.015421] PM: hibernation: Registered nosave memory: [mem 0x13fffa000-0x13fffafff]
[    0.015422] PM: hibernation: Registered nosave memory: [mem 0x13fffa000-0x13fffafff]
[    0.015423] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.015424] Booting paravirtualized kernel on KVM
[    0.015425] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.021116] setup_percpu: NR_CPUS:64 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
[    0.021345] percpu: Embedded 56 pages/cpu s191320 r8192 d29864 u2097152
[    0.021349] pcpu-alloc: s191320 r8192 d29864 u2097152 alloc=1*2097152
[    0.021351] pcpu-alloc: [0] 0
[    0.021368] Kernel command line: root=UUID=71b5e20d-efaa-4c09-b189-73cd6255e8ce ro loglevel=4 oops=panic panic=30 crashkernel=512M
[    0.021405] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes
[    0.021867] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.022076] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.022105] Fallback order for Node 0: 0
[    0.022107] Built 1 zonelists, mobility grouping on.  Total pages: 1048446
[    0.022108] Policy zone: Normal
[    0.022109] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.022112] software IO TLB: area num 1.
[    0.044924] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.044933] Kernel/User page tables isolation: enabled
[    0.045735] Dynamic Preempt: voluntary
[    0.045749] rcu: Preemptible hierarchical RCU implementation.
[    0.045749] rcu: 	RCU event tracing is enabled.
[    0.045750] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
[    0.045751] 	Trampoline variant of Tasks RCU enabled.
[    0.045751] 	Tracing variant of Tasks RCU enabled.
[    0.045752] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.045752] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.045755] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=1.
[    0.045757] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=1.
[    0.048930] NR_IRQS: 4352, nr_irqs: 256, preallocated irqs: 16
[    0.049119] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.054304] Console: colour VGA+ 80x25
[    0.054306] printk: legacy console [tty0] enabled
[    0.054328] ACPI: Core revision 20240827
[    0.054447] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.054565] APIC: Switch to symmetric I/O mode setup
[    0.055984] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.056013] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x188fedbb01f, max_idle_ns: 440795266478 ns
[    0.056018] Calibrating delay loop (skipped) preset value.. 3408.00 BogoMIPS (lpj=1704004)
[    0.056186] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.056187] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.056190] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.056192] Spectre V2 : Mitigation: Retpolines
[    0.056193] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.056194] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.056194] Speculative Store Bypass: Vulnerable
[    0.056195] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.056196] MMIO Stale Data: Unknown: No mitigations
[    0.056198] x86/fpu: x87 FPU will use FXSAVE
[    0.081715] Freeing SMP alternatives memory: 48K
[    0.081720] pid_max: default: 32768 minimum: 301
[    0.081737] LSM: initializing lsm=capability,selinux
[    0.081753] SELinux:  Initializing.
[    0.081862] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.081869] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.184288] smpboot: CPU0: Intel QEMU Virtual CPU version 2.5+ (family: 0xf, model: 0x6b, stepping: 0x1)
[    0.184453] Performance Events: unsupported Netburst CPU model 107 no PMU driver, software events only.
[    0.184507] signal: max sigframe size: 1440
[    0.184530] rcu: Hierarchical SRCU implementation.
[    0.184531] rcu: 	Max phase no-delay instances is 400.
[    0.184680] smp: Bringing up secondary CPUs ...
[    0.184685] smp: Brought up 1 node, 1 CPU
[    0.184687] smpboot: Total of 1 processors activated (3408.00 BogoMIPS)
[    0.184751] Memory: 3479420K/4193784K available (18039K kernel code, 2861K rwdata, 7132K rodata, 2832K init, 932K bss, 710008K reserved, 0K cma-reserved)
[    0.184885] devtmpfs: initialized
[    0.185015] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.185015] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.185015] PM: RTC time: 22:36:43, date: 2025-03-28
[    0.185015] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.185015] audit: initializing netlink subsys (disabled)
[    0.185039] audit: type=2000 audit(1743201403.349:1): state=initialized audit_enabled=0 res=1
[    0.185091] thermal_sys: Registered thermal governor 'step_wise'
[    0.185097] cpuidle: using governor menu
[    0.185232] PCI: Using configuration type 1 for base access
[    0.185294] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.187070] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.187072] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.187145] ACPI: Added _OSI(Module Device)
[    0.187147] ACPI: Added _OSI(Processor Device)
[    0.187147] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.187148] ACPI: Added _OSI(Processor Aggregator Device)
[    0.187638] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.189162] ACPI: Interpreter enabled
[    0.189171] ACPI: PM: (supports S0 S3 S4 S5)
[    0.189172] ACPI: Using IOAPIC for interrupt routing
[    0.189180] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.189181] PCI: Using E820 reservations for host bridge windows
[    0.189245] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.191751] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.191757] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.191759] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.191764] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    0.191863] PCI host bridge to bus 0000:00
[    0.191865] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.191867] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.191868] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.191869] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.191871] pci_bus 0000:00: root bus resource [mem 0x140000000-0x1bfffffff window]
[    0.191872] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.191919] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
[    0.193214] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 conventional PCI endpoint
[    0.193717] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 conventional PCI endpoint
[    0.194444] pci 0000:00:01.1: BAR 4 [io  0xc040-0xc04f]
[    0.194486] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    0.194488] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    0.194489] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    0.194490] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    0.196189] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
[    0.196569] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.196579] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.196812] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000 conventional PCI endpoint
[    0.197809] pci 0000:00:02.0: BAR 0 [mem 0xfd000000-0xfdffffff pref]
[    0.197856] pci 0000:00:02.0: BAR 2 [mem 0xfebf0000-0xfebf0fff]
[    0.198034] pci 0000:00:02.0: ROM [mem 0xfebe0000-0xfebeffff pref]
[    0.200169] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.200543] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000 conventional PCI endpoint
[    0.201690] pci 0000:00:03.0: BAR 0 [mem 0xfebc0000-0xfebdffff]
[    0.201705] pci 0000:00:03.0: BAR 1 [io  0xc000-0xc03f]
[    0.201748] pci 0000:00:03.0: ROM [mem 0xfeb80000-0xfebbffff pref]
[    0.204421] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.204426] ACPI: PCI: Interrupt link LNKA disabled
[    0.204526] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.204527] ACPI: PCI: Interrupt link LNKB disabled
[    0.204619] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.204708] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.204709] ACPI: PCI: Interrupt link LNKD disabled
[    0.204771] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.206119] iommu: Default domain type: Translated
[    0.206126] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.206303] SCSI subsystem initialized
[    0.208735] libata version 3.00 loaded.
[    0.208783] ACPI: bus type USB registered
[    0.208804] usbcore: registered new interface driver usbfs
[    0.208817] usbcore: registered new interface driver hub
[    0.208821] usbcore: registered new device driver usb
[    0.208881] pps_core: LinuxPPS API ver. 1 registered
[    0.208884] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.208887] PTP clock support registered
[    0.208984] Advanced Linux Sound Architecture Driver Initialized.
[    0.209240] NetLabel: Initializing
[    0.209241] NetLabel:  domain hash size = 128
[    0.209244] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.209265] NetLabel:  unlabeled traffic allowed by default
[    0.209363] PCI: Using ACPI for IRQ routing
[    0.209367] PCI: pci_cache_line_size set to 64 bytes
[    0.209486] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.209492] e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
[    0.209493] e820: reserve RAM buffer [mem 0x13fffa0f0-0x13fffffff]
[    0.209537] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.209541] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.209542] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.209544] vgaarb: loaded
[    0.209729] hpet: 3 channels of 0 reserved for per-cpu timers
[    0.209767] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.209779] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.214347] clocksource: Switched to clocksource kvm-clock
[    0.314528] VFS: Disk quotas dquot_6.6.0
[    0.314540] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.314617] pnp: PnP ACPI init
[    0.314708] pnp 00:02: [dma 2]
[    0.314877] pnp: PnP ACPI: found 6 devices
[    0.320298] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.320354] NET: Registered PF_INET protocol family
[    0.320434] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.321215] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.321220] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.321225] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.321252] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.321371] TCP: Hash tables configured (established 32768 bind 32768)
[    0.321403] UDP hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.321423] UDP-Lite hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.321476] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.321587] RPC: Registered named UNIX socket transport module.
[    0.321590] RPC: Registered udp transport module.
[    0.321591] RPC: Registered tcp transport module.
[    0.321591] RPC: Registered tcp-with-tls transport module.
[    0.321592] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.321859] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.321862] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.321863] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.321864] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    0.321866] pci_bus 0000:00: resource 8 [mem 0x140000000-0x1bfffffff window]
[    0.321915] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.321977] PCI: CLS 0 bytes, default 64
[    0.322081] Unpacking initramfs...
[    0.322953] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.322957] software IO TLB: mapped [mem 0x000000009b000000-0x000000009f000000] (64MB)
[    0.322998] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x188fedbb01f, max_idle_ns: 440795266478 ns
[    0.323241] Initialise system trusted keyrings
[    0.323276] workingset: timestamp_bits=56 max_order=20 bucket_order=0
[    0.323396] NFS: Registering the id_resolver key type
[    0.323403] Key type id_resolver registered
[    0.323404] Key type id_legacy registered
[    0.323435] 9p: Installing v9fs 9p2000 file system support
[    0.345094] Key type asymmetric registered
[    0.345099] Asymmetric key parser 'x509' registered
[    0.345116] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.345141] io scheduler mq-deadline registered
[    0.345142] io scheduler kyber registered
[    0.345240] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.345928] ACPI: button: Power Button [PWRF]
[    0.346086] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.346262] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.346965] Non-volatile memory driver v1.3
[    0.346967] Linux agpgart interface v0.103
[    0.347025] ACPI: bus type drm_connector registered
[    0.348518] loop: module loaded
[    0.348590] ata_piix 0000:00:01.1: version 2.13
[    0.350259] scsi host0: ata_piix
[    0.350317] scsi host1: ata_piix
[    0.350336] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14 lpm-pol 0
[    0.350341] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15 lpm-pol 0
[    0.350514] e100: Intel(R) PRO/100 Network Driver
[    0.350517] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.350524] e1000: Intel(R) PRO/1000 Network Driver
[    0.350524] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.351991] ACPI: _SB_.LNKC: Enabled at IRQ 11
[    0.504226] ata1: found unknown device (class 0)
[    0.506054] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    0.506057] ata1.00: 41943040 sectors, multi 16: LBA48
[    0.506677] ata2: found unknown device (class 0)
[    0.507217] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    0.511957] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    0.512959] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[    0.513027] sd 0:0:0:0: [sda] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[    0.513032] sd 0:0:0:0: [sda] Write Protect is off
[    0.513033] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.513037] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.513044] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    0.515074] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    0.517351]  sda: sda1 sda2
[    0.517406] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.527110] Freeing initrd memory: 7872K
[    0.531612] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    0.531624] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.540451] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    0.540595] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    0.751948] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    0.751957] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    0.751975] e1000e: Intel(R) PRO/1000 Network Driver
[    0.751978] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.751989] sky2: driver version 1.30
[    0.752083] usbcore: registered new interface driver usblp
[    0.752092] usbcore: registered new interface driver usb-storage
[    0.752139] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.752925] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.752934] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.753279] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.754940] rtc_cmos 00:05: RTC can wake from S4
[    0.756423] rtc_cmos 00:05: registered as rtc0
[    0.756488] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    0.756586] device-mapper: ioctl: 4.49.0-ioctl (2025-01-17) initialised: dm-devel@lists.linux.dev
[    0.756596] intel_pstate: CPU model not supported
[    0.756610] hid: raw HID events driver (C) Jiri Kosina
[    0.756695] usbcore: registered new interface driver usbhid
[    0.756696] usbhid: USB HID core driver
[    0.757103] Initializing XFRM netlink socket
[    0.757124] NET: Registered PF_INET6 protocol family
[    0.757344] Segment Routing with IPv6
[    0.757352] In-situ OAM (IOAM) with IPv6
[    0.757387] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.757484] NET: Registered PF_PACKET protocol family
[    0.757542] 9pnet: Installing 9P2000 support
[    0.757573] Key type dns_resolver registered
[    0.757702] IPI shorthand broadcast: enabled
[    0.759376] sched_clock: Marking stable (753005282, 5891666)->(763048437, -4151489)
[    0.759450] registered taskstats version 1
[    0.759453] Loading compiled-in X.509 certificates
[    0.760320] Demotion targets for Node 0: null
[    0.760365] PM:   Magic number: 1:4:655
[    0.760400] printk: legacy console [netcon0] enabled
[    0.760404] netconsole: network logging started
[    0.760440] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    0.761635] modprobe (50) used greatest stack depth: 13352 bytes left
[    0.762581] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    0.762720] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    0.762751] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    0.762755] cfg80211: failed to load regulatory.db
[    0.762765] ALSA device list:
[    0.762770]   No soundcards found.
[    0.764082] Freeing unused kernel image (initmem) memory: 2832K
[    0.764158] Write protecting the kernel read-only data: 26624k
[    0.764451] Freeing unused kernel image (text/rodata gap) memory: 392K
[    0.765095] Freeing unused kernel image (rodata/data gap) memory: 1060K
[    0.808307] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.808352] x86/mm: Checking user space page tables
[    0.850268] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.850277] Run /init as init process
[    0.850280]   with arguments:
[    0.850281]     /init
[    0.850281]   with environment:
[    0.850282]     HOME=/
[    0.850283]     TERM=linux
[    0.878888] dracut: modprobe: FATAL: Module btrfs not found in directory /lib/modules/6.14.0
[    0.907742] systemd-udevd[202]: starting version 3.2.14
[    0.909149] udevd[203]: starting eudev-3.2.14
[    0.954835] e1000 0000:00:03.0 enp0s3: renamed from eth0
[    1.169132] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[    1.369860] EXT4-fs (sda1): orphan cleanup on readonly fs
[    1.370295] EXT4-fs (sda1): mounted filesystem 71b5e20d-efaa-4c09-b189-73cd6255e8ce ro with ordered data mode. Quota mode: none.
[    1.370446] mount (256) used greatest stack depth: 13312 bytes left
[    1.385093] dracut: Remounting /dev/disk/by-uuid/71b5e20d-efaa-4c09-b189-73cd6255e8ce with -o defaults,noatime,ro
[    1.388018] EXT4-fs (sda1): re-mounted 71b5e20d-efaa-4c09-b189-73cd6255e8ce ro. Quota mode: none.
[    1.397312] dracut: Mounted root filesystem /dev/sda1
[    1.405486] systemd-udevd (218) used greatest stack depth: 13264 bytes left
[    1.414667] dracut: Switching root
[    1.481594] mount (343) used greatest stack depth: 13192 bytes left
[    1.509465] udevd[364]: starting version 3.2.14
[    1.525360] udevd (364) used greatest stack depth: 13104 bytes left
[    1.525867] udevd[365]: starting eudev-3.2.14
[    1.672015] EXT4-fs (sda1): re-mounted 71b5e20d-efaa-4c09-b189-73cd6255e8ce ro. Quota mode: none.
[    1.729254] EXT4-fs (sda1): re-mounted 71b5e20d-efaa-4c09-b189-73cd6255e8ce r/w. Quota mode: none.
[    1.734973] Adding 4194300k swap on /dev/sda2.  Priority:-2 extents:1 across:4194300k
[    1.759375] seedrng (402) used greatest stack depth: 12672 bytes left
[    1.767539] ip (403) used greatest stack depth: 12432 bytes left
[    2.118646] udevd[447]: starting version 3.2.14
[    2.133109] udevd[447]: starting eudev-3.2.14
[    2.161495] e1000: enp0s3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   25.478654] PM: hibernation: hibernation entry
[   25.498813] Filesystems sync: 0.013 seconds
[   25.498887] Freezing user space processes
[   25.500058] Freezing user space processes completed (elapsed 0.001 seconds)
[   25.500061] OOM killer disabled.
[   25.501509] PM: hibernation: Preallocating image memory
[   25.583911] PM: hibernation: Allocated 198680 pages for snapshot
[   25.583915] PM: hibernation: Allocated 794720 kbytes in 0.08 seconds (9934.00 MB/s)
[   25.583918] Freezing remaining freezable tasks
[   25.585078] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   25.585157] printk: Suspending console(s) (use no_console_suspend to debug)
[   25.625084] Disabling non-boot CPUs ...
[   25.625889] PM: hibernation: Creating image:
[   25.685879] PM: hibernation: Need to copy 196220 pages
[   41.601473] OOM killer enabled.
[   41.601475] Restarting tasks ... done.
[   41.606737] PM: hibernation: hibernation exit
[   41.726129] ata1: found unknown device (class 0)
[   41.726524] ata2: found unknown device (class 0)
[   41.727563] sd 0:0:0:0: [sda] Starting disk
[   42.574201] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   42.574680] #PF: supervisor read access in kernel mode
[   42.575001] #PF: error_code(0x0000) - not-present page
[   42.575324] PGD 0 P4D 0
[   42.575556] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[   42.575860] CPU: 0 UID: 0 PID: 535 Comm: dhcpcd Kdump: loaded Not tainted 6.14.0 #1
[   42.576333] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   42.576926] RIP: 0010:pcpu_alloc_noprof (??:?) 
[ 42.577242] Code: 39 c6 0f 8f 0b 01 00 00 44 89 7c 24 40 48 8b 05 f6 f3 40 01 4c 89 74 24 20 4c 63 ce 49 c1 e1 04 4a 8d 0c 08 4d 89 cf 48 8b 19 <4c> 8b 33 48 39 d9 0f 84 c4 00 00 00 89 34 24 eb 34 89 c1 4c 89 e2
All code
========
   0:	39 c6                	cmp    %eax,%esi
   2:	0f 8f 0b 01 00 00    	jg     0x113
   8:	44 89 7c 24 40       	mov    %r15d,0x40(%rsp)
   d:	48 8b 05 f6 f3 40 01 	mov    0x140f3f6(%rip),%rax        # 0x140f40a
  14:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
  19:	4c 63 ce             	movslq %esi,%r9
  1c:	49 c1 e1 04          	shl    $0x4,%r9
  20:	4a 8d 0c 08          	lea    (%rax,%r9,1),%rcx
  24:	4d 89 cf             	mov    %r9,%r15
  27:	48 8b 19             	mov    (%rcx),%rbx
  2a:*	4c 8b 33             	mov    (%rbx),%r14		<-- trapping instruction
  2d:	48 39 d9             	cmp    %rbx,%rcx
  30:	0f 84 c4 00 00 00    	je     0xfa
  36:	89 34 24             	mov    %esi,(%rsp)
  39:	eb 34                	jmp    0x6f
  3b:	89 c1                	mov    %eax,%ecx
  3d:	4c 89 e2             	mov    %r12,%rdx

Code starting with the faulting instruction
===========================================
   0:	4c 8b 33             	mov    (%rbx),%r14
   3:	48 39 d9             	cmp    %rbx,%rcx
   6:	0f 84 c4 00 00 00    	je     0xd0
   c:	89 34 24             	mov    %esi,(%rsp)
   f:	eb 34                	jmp    0x45
  11:	89 c1                	mov    %eax,%ecx
  13:	4c 89 e2             	mov    %r12,%rdx
[   42.578146] RSP: 0018:ffffa083804b7de8 EFLAGS: 00010002
[   42.578466] RAX: ffff8bc0bfffa5c0 RBX: 0000000000000000 RCX: ffff8bc0bfffa5e0
[   42.578848] RDX: 0000000000000001 RSI: 0000000000000002 RDI: ffffffff9d77bb04
[   42.579232] RBP: 0000000000000004 R08: 000000010004e063 R09: 0000000000000020
[   42.579613] R10: 0000000000000000 R11: 000000004dd19067 R12: 0000000000000002
[   42.579994] R13: 0000000000000000 R14: 0000000000000202 R15: 0000000000000020
[   42.580382] FS:  00007f52ed1a3740(0000) GS:ffff8bc0bfa00000(0000) knlGS:0000000000000000
[   42.580867] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.581211] CR2: 0000000000000000 CR3: 0000000102398000 CR4: 00000000000006f0
[   42.581595] Call Trace:
[   42.581823]  <TASK>
[   42.582040] ? __die (??:?) 
[   42.582498] ? page_fault_oops (fault.c:?) 
[   42.582784] ? search_extable (??:?) 
[   42.583061] ? pcpu_alloc_noprof (??:?) 
[   42.583354] ? search_module_extables (??:?) 
[   42.583652] ? exc_page_fault (??:?) 
[   42.583930] ? asm_exc_page_fault (??:?) 
[   42.584221] ? pcpu_alloc_noprof (??:?) 
[   42.584509] ? pcpu_alloc_noprof (??:?) 
[   42.584796] mm_init.isra.0 (fork.c:?) 
[   42.585070] alloc_bprm (exec.c:?) 
[   42.585335] do_execveat_common.isra.0 (exec.c:?) 
[   42.585638] __x64_sys_execve (??:?) 
[   42.585912] do_syscall_64 (??:?) 
[   42.586185] entry_SYSCALL_64_after_hwframe (??:?) 
[   42.586500] RIP: 0033:0x7f52ed27bbd7
[ 42.586766] Code: eb cf e8 fc e9 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 05 e9 53 10 00 48 8b 10 e9 01 00 00 00 90 b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 21 52 10 00 f7 d8 64 89 01 48
All code
========
   0:	eb cf                	jmp    0xffffffffffffffd1
   2:	e8 fc e9 03 00       	call   0x3ea03
   7:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   e:	00 00 00 
  11:	66 90                	xchg   %ax,%ax
  13:	48 8b 05 e9 53 10 00 	mov    0x1053e9(%rip),%rax        # 0x105403
  1a:	48 8b 10             	mov    (%rax),%rdx
  1d:	e9 01 00 00 00       	jmp    0x23
  22:	90                   	nop
  23:	b8 3b 00 00 00       	mov    $0x3b,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 21 52 10 00 	mov    0x105221(%rip),%rcx        # 0x10525b
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 21 52 10 00 	mov    0x105221(%rip),%rcx        # 0x105231
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[   42.587811] RSP: 002b:00007f52ed175e68 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[   42.588313] RAX: ffffffffffffffda RBX: 00007ffec82864f0 RCX: 00007f52ed27bbd7
[   42.588683] RDX: 00005581792386d0 RSI: 00007ffec82866a0 RDI: 000055816c62b6a3
[   42.589052] RBP: 00007f52ed175ff0 R08: 0000000000000000 R09: 0000000000000000
[   42.589468] R10: 0000000000000008 R11: 0000000000000202 R12: 00007ffec8286220
[   42.589838] R13: 0000000000000040 R14: 0000000000000001 R15: 00007f52ed175f20
[   42.590487]  </TASK>
[   42.590705] Modules linked in:
[   42.590949] CR2: 0000000000000000

