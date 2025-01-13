Return-Path: <linux-pm+bounces-20387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C45A0C3C7
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 22:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3327A4A87
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B61D2F42;
	Mon, 13 Jan 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="Qx3mUrAq"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C81D318B
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736803926; cv=none; b=m5q/7PCMZiH1xj7ELp+8cM3hvoakWGmV8dSTazoxvlVyoXILUsm5On7LTbjZ2m2z6pU+bFmlJTMl2qHgKvLstXDpTC9J2rDgd+4b//O6S0yV57l2XX+204tcyaj6ONep49xaU0Dj8lmsVXQDBFBqwtcQ6Ho/JORvcV1LILUwj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736803926; c=relaxed/simple;
	bh=U4n15XwskLqRH1UMJ9MkTn6xb5d35tyz8+D91TXlGxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPOuuHMHflj0R+XyusFFq7mFxFzgoMo7Q+ZP651GmWbMBU0iG8TtwHI/J7Sr94C7TBCAWNt/MW9EZ6JfKsgbrKJPQhynU3CAk0EPfSeRnhVOKpJNY4LPWDCk8PhmW6pBrIPDAbElEdyUvU4MAfAGFAmFdXGfaETKygYTX0jlFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=Qx3mUrAq; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Mon, 13 Jan 2025 22:31:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1736803915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRA8Q2TNtDg5lR7tPOJkBX2vhFbc74cVJh/kOKXAEjQ=;
	b=Qx3mUrAqc9MSMin5VEDLtKdwvEMpM1y/wjCaUO6oPg12Qz6NagyCAyMEAFYp3fyfp6dero
	/5lRvAGfcldexZbiZavVkYpqOEWXdyqBjqsOzy6EYBZqmKMrPtHVC5nU7Zk0ptyUlv7jpe
	JHkCjNERbPqiG40hE8asyBzlEPIsk9UDeGQzhDba3ROqQmLgBRpsIaLV9omm4Yng2CjYhD
	XDmcA8YYKyvZw1sa6fEvOUGqtB6Z+Qnt/TDrqsDcvaQoZzQcmgy7QI7VO3k4zxv1Sl1+Yr
	uMeOnX78J65Klf973e0iLkurLCg/FuIrm5ok2+wnCIoWFAp7QQCZ0I9GOjGdpQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com
Cc: kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4WGSMdF6seQm9GV@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4WFjBVHpndct7br@desktop0a>
X-Migadu-Flow: FLOW_OUT

[    0.000000] Linux version 6.13.0-rc7_ricci (ricci@desktop0a) (gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC @0
[    0.000000] Command line: root=UUID=71b5e20d-efaa-4c09-b189-73cd6255e8ce ro loglevel=4 oops=panic panic=-1 crashkernel=512M
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
[    0.000001] kvm-clock: using sched offset of 1104952863542 cycles
[    0.000003] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000008] tsc: Detected 1704.004 MHz processor
[    0.001228] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001233] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001240] last_pfn = 0x140000 max_arch_pfn = 0x400000000
[    0.001276] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.001281] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001326] x2apic: enabled by BIOS, switching to x2apic ops
[    0.001331] last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
[    0.009990] found SMP MP-table at [mem 0x000f5470-0x000f547f]
[    0.010711] RAMDISK: [mem 0x13f428000-0x13fff8fff]
[    0.010717] ACPI: Early table checksum verification disabled
[    0.010721] ACPI: RSDP 0x00000000000F5270 000014 (v00 BOCHS )
[    0.010727] ACPI: RSDT 0x00000000BFFE22E6 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010737] ACPI: FACP 0x00000000BFFE219A 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010747] ACPI: DSDT 0x00000000BFFE0040 00215A (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010754] ACPI: FACS 0x00000000BFFE0000 000040
[    0.010761] ACPI: APIC 0x00000000BFFE220E 000078 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010767] ACPI: HPET 0x00000000BFFE2286 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010773] ACPI: WAET 0x00000000BFFE22BE 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010779] ACPI: Reserving FACP table memory at [mem 0xbffe219a-0xbffe220d]
[    0.010781] ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe2199]
[    0.010783] ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
[    0.010785] ACPI: Reserving APIC table memory at [mem 0xbffe220e-0xbffe2285]
[    0.010787] ACPI: Reserving HPET table memory at [mem 0xbffe2286-0xbffe22bd]
[    0.010789] ACPI: Reserving WAET table memory at [mem 0xbffe22be-0xbffe22e5]
[    0.010880] APIC: Switched APIC routing to: cluster x2apic
[    0.011341] No NUMA configuration found
[    0.011342] Faking a node at [mem 0x0000000000000000-0x000000013fffffff]
[    0.011348] NODE_DATA(0) allocated [mem 0x13fffaac0-0x13fffffff]
[    0.011357] crashkernel reserved: 0x000000009f000000 - 0x00000000bf000000 (512 MB)
[    0.011375] Zone ranges:
[    0.011377]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.011380]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.011383]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.011386]   Device   empty
[    0.011388] Movable zone start for each node
[    0.011389] Early memory node ranges
[    0.011390]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.011393]   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
[    0.011395]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.011398] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
[    0.011408] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.011524] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.038831] On node 0, zone Normal: 32 pages in unavailable ranges
[    0.174654] kasan: KernelAddressSanitizer initialized
[    0.175038] ACPI: PM-Timer IO Port: 0x608
[    0.175054] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.175092] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.175098] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.175101] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.175103] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.175105] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.175107] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.175114] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.175117] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.175125] CPU topo: Max. logical packages:   1
[    0.175127] CPU topo: Max. logical dies:       1
[    0.175128] CPU topo: Max. dies per package:   1
[    0.175132] CPU topo: Max. threads per core:   1
[    0.175134] CPU topo: Num. cores per package:     1
[    0.175135] CPU topo: Num. threads per package:   1
[    0.175136] CPU topo: Allowing 1 present CPUs plus 0 hotplug CPUs
[    0.175156] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
[    0.175178] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.175181] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.175183] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.175185] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.175187] PM: hibernation: Registered nosave memory: [mem 0xbffe0000-0xbfffffff]
[    0.175188] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfeffbfff]
[    0.175190] PM: hibernation: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.175191] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.175193] PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.175195] PM: hibernation: Registered nosave memory: [mem 0x13fffa000-0x13fffafff]
[    0.175197] PM: hibernation: Registered nosave memory: [mem 0x13fffa000-0x13fffafff]
[    0.175200] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.175202] Booting paravirtualized kernel on KVM
[    0.175204] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.190021] setup_percpu: NR_CPUS:256 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
[    0.190335] percpu: Embedded 82 pages/cpu s299008 r8192 d28672 u2097152
[    0.190343] pcpu-alloc: s299008 r8192 d28672 u2097152 alloc=1*2097152
[    0.190347] pcpu-alloc: [0] 0
[    0.190377] kvm-guest: PV spinlocks disabled, no host support
[    0.190378] Kernel command line: root=UUID=71b5e20d-efaa-4c09-b189-73cd6255e8ce ro loglevel=4 oops=panic panic=-1 crashkernel=512M
[    0.190460] printk: log buffer data + meta data: 524288 + 1835008 = 2359296 bytes
[    0.190931] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.191143] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.191211] Fallback order for Node 0: 0
[    0.191216] Built 1 zonelists, mobility grouping on.  Total pages: 1048446
[    0.191218] Policy zone: Normal
[    0.191507] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.191510] stackdepot: allocating hash table via alloc_large_system_hash
[    0.191513] stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
[    0.193337] software IO TLB: area num 1.
[    0.280119] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.280154] Kernel/User page tables isolation: enabled
[    0.280222] ftrace: allocating 43881 entries in 172 pages
[    0.336813] ftrace: allocated 172 pages with 4 groups
[    0.337805] Dynamic Preempt: voluntary
[    0.337987] rcu: Preemptible hierarchical RCU implementation.
[    0.337989] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=1.
[    0.337992] 	Trampoline variant of Tasks RCU enabled.
[    0.337993] 	Rude variant of Tasks RCU enabled.
[    0.337994] 	Tracing variant of Tasks RCU enabled.
[    0.337995] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.337996] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.338015] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=1.
[    0.338020] RCU Tasks Rude: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=1.
[    0.338024] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=1.
[    0.355017] NR_IRQS: 16640, nr_irqs: 256, preallocated irqs: 16
[    0.355353] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.355530] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.356064] Console: colour dummy device 80x25
[    0.356068] printk: legacy console [tty0] enabled
[    0.356167] ACPI: Core revision 20240827
[    0.356482] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.356693] APIC: Switch to symmetric I/O mode setup
[    0.357294] APIC: Switched APIC routing to: physical x2apic
[    0.358992] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.359025] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x188fedbb01f, max_idle_ns: 440795266478 ns
[    0.359033] Calibrating delay loop (skipped) preset value.. 3408.00 BogoMIPS (lpj=1704004)
[    0.359218] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.359221] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.359227] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.359231] Spectre V2 : Mitigation: Retpolines
[    0.359233] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.359235] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.359237] Speculative Store Bypass: Vulnerable
[    0.359241] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.359243] MMIO Stale Data: Unknown: No mitigations
[    0.359246] x86/fpu: x87 FPU will use FXSAVE
[    0.399416] Freeing SMP alternatives memory: 36K
[    0.399428] pid_max: default: 32768 minimum: 301
[    0.399593] LSM: initializing lsm=capability,landlock,yama
[    0.399703] landlock: Up and running.
[    0.399706] Yama: becoming mindful.
[    0.399856] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.399867] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.503030] smpboot: CPU0: Intel QEMU Virtual CPU version 2.5+ (family: 0xf, model: 0x6b, stepping: 0x1)
[    0.503030] Performance Events: unsupported Netburst CPU model 107 no PMU driver, software events only.
[    0.503030] signal: max sigframe size: 1440
[    0.503030] rcu: Hierarchical SRCU implementation.
[    0.503030] rcu: 	Max phase no-delay instances is 400.
[    0.505051] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.505112] smp: Bringing up secondary CPUs ...
[    0.505124] smp: Brought up 1 node, 1 CPU
[    0.505127] smpboot: Total of 1 processors activated (3408.00 BogoMIPS)
[    0.505369] Memory: 2871904K/4193784K available (40960K kernel code, 12803K rwdata, 15276K rodata, 6108K init, 5024K bss, 1317628K reserved, 0K cma-reserved)
[    0.505844] devtmpfs: initialized
[    0.505993] x86/mm: Memory block size: 128MB
[    0.513220] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.513230] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.513422] pinctrl core: initialized pinctrl subsystem
[    0.514134] PM: RTC time: 18:32:17, date: 2025-01-13
[    0.515291] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.516055] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.516327] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.516603] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.516667] audit: initializing netlink subsys (disabled)
[    0.516768] audit: type=2000 audit(1736793137.133:1): state=initialized audit_enabled=0 res=1
[    0.517434] thermal_sys: Registered thermal governor 'bang_bang'
[    0.517437] thermal_sys: Registered thermal governor 'step_wise'
[    0.517440] thermal_sys: Registered thermal governor 'user_space'
[    0.517442] thermal_sys: Registered thermal governor 'power_allocator'
[    0.517479] cpuidle: using governor ladder
[    0.517487] cpuidle: using governor menu
[    0.517636] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.518034] PCI: Using configuration type 1 for base access
[    0.518218] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.549220] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.549224] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.554632] ACPI: Added _OSI(Module Device)
[    0.554637] ACPI: Added _OSI(Processor Device)
[    0.554639] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.554641] ACPI: Added _OSI(Processor Aggregator Device)
[    0.594533] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.598589] ACPI: Interpreter enabled
[    0.598678] ACPI: PM: (supports S0 S3 S4 S5)
[    0.598681] ACPI: Using IOAPIC for interrupt routing
[    0.598911] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.598915] PCI: Using E820 reservations for host bridge windows
[    0.600213] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.642478] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.642503] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.642508] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.642682] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    0.647629] acpiphp: Slot [3] registered
[    0.647793] acpiphp: Slot [4] registered
[    0.647961] acpiphp: Slot [5] registered
[    0.648133] acpiphp: Slot [6] registered
[    0.648296] acpiphp: Slot [7] registered
[    0.648456] acpiphp: Slot [8] registered
[    0.648617] acpiphp: Slot [9] registered
[    0.648782] acpiphp: Slot [10] registered
[    0.648948] acpiphp: Slot [11] registered
[    0.649118] acpiphp: Slot [12] registered
[    0.649280] acpiphp: Slot [13] registered
[    0.649443] acpiphp: Slot [14] registered
[    0.649603] acpiphp: Slot [15] registered
[    0.649772] acpiphp: Slot [16] registered
[    0.649940] acpiphp: Slot [17] registered
[    0.650114] acpiphp: Slot [18] registered
[    0.650276] acpiphp: Slot [19] registered
[    0.650436] acpiphp: Slot [20] registered
[    0.650595] acpiphp: Slot [21] registered
[    0.650761] acpiphp: Slot [22] registered
[    0.650928] acpiphp: Slot [23] registered
[    0.651098] acpiphp: Slot [24] registered
[    0.651259] acpiphp: Slot [25] registered
[    0.651423] acpiphp: Slot [26] registered
[    0.651584] acpiphp: Slot [27] registered
[    0.651743] acpiphp: Slot [28] registered
[    0.651909] acpiphp: Slot [29] registered
[    0.652080] acpiphp: Slot [30] registered
[    0.652244] acpiphp: Slot [31] registered
[    0.652336] PCI host bridge to bus 0000:00
[    0.652420] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.652428] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.652435] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.652441] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.652448] pci_bus 0000:00: root bus resource [mem 0x140000000-0x1bfffffff window]
[    0.652455] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.652520] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
[    0.653989] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 conventional PCI endpoint
[    0.655532] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 conventional PCI endpoint
[    0.657681] pci 0000:00:01.1: BAR 4 [io  0xc080-0xc08f]
[    0.658773] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    0.658778] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    0.658781] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    0.658784] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    0.659916] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
[    0.660417] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.660430] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.661556] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000 conventional PCI endpoint
[    0.663077] pci 0000:00:02.0: BAR 0 [mem 0xfd000000-0xfdffffff pref]
[    0.665459] pci 0000:00:02.0: BAR 2 [mem 0xfebf0000-0xfebf0fff]
[    0.671074] pci 0000:00:02.0: ROM [mem 0xfebe0000-0xfebeffff pref]
[    0.671332] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.673105] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000 conventional PCI endpoint
[    0.674034] pci 0000:00:03.0: BAR 0 [mem 0xfebc0000-0xfebdffff]
[    0.674676] pci 0000:00:03.0: BAR 1 [io  0xc000-0xc03f]
[    0.678521] pci 0000:00:03.0: ROM [mem 0xfeb80000-0xfebbffff pref]
[    0.698069] pci 0000:00:04.0: [1af4:1009] type 00 class 0x000200 conventional PCI endpoint
[    0.699034] pci 0000:00:04.0: BAR 0 [io  0xc040-0xc07f]
[    0.700034] pci 0000:00:04.0: BAR 1 [mem 0xfebf1000-0xfebf1fff]
[    0.704034] pci 0000:00:04.0: BAR 4 [mem 0xfe000000-0xfe003fff 64bit pref]
[    0.727209] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.727214] ACPI: PCI: Interrupt link LNKA disabled
[    0.728570] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.728574] ACPI: PCI: Interrupt link LNKB disabled
[    0.729978] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.731325] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.731329] ACPI: PCI: Interrupt link LNKD disabled
[    0.731887] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.734848] iommu: Default domain type: Translated
[    0.734852] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.735703] pps_core: LinuxPPS API ver. 1 registered
[    0.735707] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.735728] PTP clock support registered
[    0.735773] EDAC MC: Ver: 3.0.0
[    0.737744] NetLabel: Initializing
[    0.737747] NetLabel:  domain hash size = 128
[    0.737750] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.737878] NetLabel:  unlabeled traffic allowed by default
[    0.737883] mctp: management component transport protocol core
[    0.737887] NET: Registered PF_MCTP protocol family
[    0.737947] PCI: Using ACPI for IRQ routing
[    0.737952] PCI: pci_cache_line_size set to 64 bytes
[    0.738094] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.738106] e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
[    0.738114] e820: reserve RAM buffer [mem 0x13fffa0f0-0x13fffffff]
[    0.738371] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.738376] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.738379] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.738384] vgaarb: loaded
[    0.738583] hpet: 3 channels of 0 reserved for per-cpu timers
[    0.738603] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.738612] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.741164] clocksource: Switched to clocksource kvm-clock
[    0.746898] VFS: Disk quotas dquot_6.6.0
[    0.746928] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.747259] pnp: PnP ACPI init
[    0.748935] pnp 00:02: [dma 2]
[    0.752172] pnp: PnP ACPI: found 6 devices
[    0.765678] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.765999] NET: Registered PF_INET protocol family
[    0.766149] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.767773] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.767811] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.767868] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.768041] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.768153] TCP: Hash tables configured (established 32768 bind 32768)
[    0.768446] MPTCP token hash table entries: 4096 (order: 4, 98304 bytes, linear)
[    0.768511] UDP hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.768556] UDP-Lite hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.768795] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.768833] NET: Registered PF_XDP protocol family
[    0.768864] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.768870] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.768873] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.768877] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    0.768880] pci_bus 0000:00: resource 8 [mem 0x140000000-0x1bfffffff window]
[    0.769211] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.769298] PCI: CLS 0 bytes, default 64
[    0.769330] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.769333] software IO TLB: mapped [mem 0x000000009b000000-0x000000009f000000] (64MB)
[    0.769383] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x188fedbb01f, max_idle_ns: 440795266478 ns
[    0.769951] Unpacking initramfs...
[    0.772987] Initialise system trusted keyrings
[    0.773117] workingset: timestamp_bits=40 max_order=20 bucket_order=0
[    0.773157] zbud: loaded
[    0.811724] Key type asymmetric registered
[    0.811733] Asymmetric key parser 'x509' registered
[    0.811836] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.811966] io scheduler mq-deadline registered
[    0.811970] io scheduler kyber registered
[    0.812013] io scheduler bfq registered
[    0.812235] ledtrig-cpu: registered to indicate activity on CPUs
[    0.812473] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.814740] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.890098] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.900425] e1000e: Intel(R) PRO/1000 Network Driver
[    0.900429] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.900740] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.903048] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.903074] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.903656] mousedev: PS/2 mouse device common for all mice
[    0.904276] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.904684] rtc_cmos 00:05: RTC can wake from S4
[    0.907294] rtc_cmos 00:05: registered as rtc0
[    0.907367] rtc_cmos 00:05: setting system clock to 2025-01-13T18:32:17 UTC (1736793137)
[    0.907568] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    0.907628] intel_pstate: CPU model not supported
[    0.941915] NET: Registered PF_INET6 protocol family
[    1.247725] Freeing initrd memory: 12100K
[    1.262446] Segment Routing with IPv6
[    1.262451] RPL Segment Routing with IPv6
[    1.262524] In-situ OAM (IOAM) with IPv6
[    1.262599] NET: Registered PF_PACKET protocol family
[    1.263270] IPI shorthand broadcast: enabled
[    1.283571] sched_clock: Marking stable (1280004259, 2668647)->(1301105239, -18432333)
[    1.284273] registered taskstats version 1
[    1.284961] Loading compiled-in X.509 certificates
[    1.307317] Demotion targets for Node 0: null
[    1.307563] Key type .fscrypt registered
[    1.307567] Key type fscrypt-provisioning registered
[    1.309806] PM:   Magic number: 9:333:544
[    1.325951] clk: Disabling unused clocks
[    1.333925] Freeing unused decrypted memory: 2036K
[    1.335767] Freeing unused kernel image (initmem) memory: 6108K
[    1.335854] Write protecting the kernel read-only data: 57344k
[    1.336447] Freeing unused kernel image (rodata/data gap) memory: 1108K
[    1.399028] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.399047] x86/mm: Checking user space page tables
[    1.458713] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.458755] Run /init as init process
[    1.458760]   with arguments:
[    1.458763]     /init
[    1.458765]   with environment:
[    1.458767]     HOME=/
[    1.458769]     TERM=linux
[    1.591589] dracut: modprobe: FATAL: Module btrfs not found in directory /lib/modules/6.13.0-rc7_ricci
[    1.719659] systemd-udevd[214]: starting version 3.2.14
[    1.724040] udevd[215]: starting eudev-3.2.14
[    1.960127] SCSI subsystem initialized
[    2.061053] libata version 3.00 loaded.
[    2.066551] ata_piix 0000:00:01.1: version 2.13
[    2.094143] scsi host0: ata_piix
[    2.096869] scsi host1: ata_piix
[    2.097470] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc080 irq 14 lpm-pol 0
[    2.097475] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc088 irq 15 lpm-pol 0
[    2.109891] ACPI: bus type drm_connector registered
[    2.255229] ata1: found unknown device (class 0)
[    2.255634] ata2: found unknown device (class 0)
[    2.256501] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    2.256749] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    2.256754] ata1.00: 41943040 sectors, multi 16: LBA48
[    2.258084] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    2.260602] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    2.290274] sd 0:0:0:0: [sda] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[    2.290310] sd 0:0:0:0: [sda] Write Protect is off
[    2.290320] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.290357] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.290422] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    2.297851]  sda: sda1 sda2
[    2.298479] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.310188] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
[    2.310540] [drm] Found bochs VGA, ID 0xb0c5.
[    2.310544] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
[    2.316420] [drm] Initialized bochs-drm 1.0.0 for 0000:00:02.0 on minor 0
[    2.332188] fbcon: bochs-drmdrmfb (fb0) is primary device
[    2.332193] fbcon: Deferring console take-over
[    2.332197] bochs-drm 0000:00:02.0: [drm] fb0: bochs-drmdrmfb frame buffer device
[    2.663954] EXT4-fs (sda1): orphan cleanup on readonly fs
[    2.665592] EXT4-fs (sda1): mounted filesystem 71b5e20d-efaa-4c09-b189-73cd6255e8ce ro with ordered data mode. Quota mode: none.
[    2.720631] dracut: Remounting /dev/disk/by-uuid/71b5e20d-efaa-4c09-b189-73cd6255e8ce with -o defaults,noatime,ro
[    2.726863] EXT4-fs (sda1): re-mounted 71b5e20d-efaa-4c09-b189-73cd6255e8ce ro. Quota mode: none.
[    2.767954] dracut: Mounted root filesystem /dev/sda1
[    2.845932] dracut: Switching root
[    2.865035] fbcon: Taking over console
[    2.879942] Console: switching to colour frame buffer device 160x50
[    3.159014] fuse: init (API version 7.41)
[    3.187347] loop: module loaded
[    3.198504] tun: Universal TUN/TAP device driver, 1.6
[    3.212115] PPP generic driver version 2.4.2
[    3.256483] device-mapper: uevent: version 1.0.3
[    3.257063] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    3.275838] hid: raw HID events driver (C) Jiri Kosina
[    3.306786] VFIO - User Level meta-driver version: 0.3
[    3.347183] NET: Registered PF_VSOCK protocol family
[    3.420376] udevd[432]: starting version 3.2.14
[    3.448364] udevd[433]: starting eudev-3.2.14
[    3.608515] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    3.619303] ACPI: button: Power Button [PWRF]
[    3.698496] parport_pc 00:03: reported by Plug and Play ACPI
[    3.701605] Linux agpgart interface v0.103
[    3.708417] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
[    3.710424] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[    3.710642] i2c i2c-0: Memory type 0x07 not supported yet, not instantiating SPD
[    3.721645] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    3.751590] e1000: Intel(R) PRO/1000 Network Driver
[    3.751596] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    3.804621] ACPI: _SB_.LNKC: Enabled at IRQ 11
[    4.030301] ppdev: user-space parallel port driver
[    4.285919] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    4.285938] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    4.290533] e1000 0000:00:03.0 ens3: renamed from eth0
[    4.356435] EXT4-fs (sda1): re-mounted 71b5e20d-efaa-4c09-b189-73cd6255e8ce ro. Quota mode: none.
[    4.444698] EXT4-fs (sda1): re-mounted 71b5e20d-efaa-4c09-b189-73cd6255e8ce r/w. Quota mode: none.
[    4.457320] Adding 4194300k swap on /dev/sda2.  Priority:-2 extents:1 across:4194300k
[    6.032481] udevd[515]: starting version 3.2.14
[    6.050504] udevd[515]: starting eudev-3.2.14
[    6.064032] 8021q: 802.1Q VLAN Support v1.8
[    6.227186] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    6.235058] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.235496] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    6.237579] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    6.237600] cfg80211: failed to load regulatory.db
[    6.271099] 8021q: adding VLAN 0 to HW filter on device ens3
[    6.271592] e1000: ens3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   60.323547] PM: hibernation: hibernation entry
[   60.334412] Filesystems sync: 0.010 seconds
[   60.334499] Freezing user space processes
[   60.335725] Freezing user space processes completed (elapsed 0.001 seconds)
[   60.335735] OOM killer disabled.
[   60.335812] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[   60.335817] PM: hibernation: Marking nosave pages: [mem 0x0009f000-0x000fffff]
[   60.335822] PM: hibernation: Marking nosave pages: [mem 0xbffe0000-0xffffffff]
[   60.338902] PM: hibernation: Marking nosave pages: [mem 0x13fffa000-0x13fffafff]
[   60.338906] PM: hibernation: Marking nosave pages: [mem 0x13fffa000-0x13fffafff]
[   60.338908] PM: hibernation: Basic memory bitmaps created
[   60.338915] PM: hibernation: Preallocating image memory
[   62.349109] PM: hibernation: Allocated 369227 pages for snapshot
[   62.349118] PM: hibernation: Allocated 1476908 kbytes in 2.01 seconds (734.78 MB/s)
[   62.349128] Freezing remaining freezable tasks
[   62.350614] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   62.350780] printk: Suspending console(s) (use no_console_suspend to debug)
[   62.392195] Disabling non-boot CPUs ...
[   62.392881] PM: hibernation: Creating image:
[   62.489719] PM: hibernation: Need to copy 368767 pages
[   62.489723] PM: hibernation: Normal pages needed: 368767 + 1024, available pages: 679042
[   88.485216] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000940: 0000 [#1] PREEMPT SMP KASAN PTI
[   88.485233] KASAN: probably user-memory-access in range [0x0000000000004a00-0x0000000000004a07]
[   88.485240] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 6.13.0-rc7_ricci #1
[   88.485245] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   88.485252] RIP: 0010:next_zone (mm/mmzone.c:20 mm/mmzone.c:37)
[ 88.485270] Code: 73 10 48 05 c0 06 00 00 48 83 c4 08 5b c3 cc cc cc cc 48 8d bb 00 4a 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 9d 00 00 00 8b 8b 00 4a 00 00
All code
========
   0:	73 10                	jae    0x12
   2:	48 05 c0 06 00 00    	add    $0x6c0,%rax
   8:	48 83 c4 08          	add    $0x8,%rsp
   c:	5b                   	pop    %rbx
   d:	c3                   	ret
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	48 8d bb 00 4a 00 00 	lea    0x4a00(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df 
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax		<-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e 9d 00 00 00    	jle    0xd7
  3a:	8b 8b 00 4a 00 00    	mov    0x4a00(%rbx),%ecx

Code starting with the faulting instruction
===========================================
   0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4:	84 c0                	test   %al,%al
   6:	74 08                	je     0x10
   8:	3c 03                	cmp    $0x3,%al
   a:	0f 8e 9d 00 00 00    	jle    0xad
  10:	8b 8b 00 4a 00 00    	mov    0x4a00(%rbx),%ecx
[   88.485275] RSP: 0018:ffffffffa4807ce8 EFLAGS: 00010002
[   88.485279] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11027fff565
[   88.485281] RDX: 0000000000000940 RSI: ffffffffa3a89b80 RDI: 0000000000004a00
[   88.485283] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed10234c82c8
[   88.485285] R10: ffff88811a641647 R11: ffff88811a635e30 R12: 0000000000000000
[   88.485287] R13: 1ffffffff4839048 R14: 0000000000000000 R15: 000000000000003d
[   88.485290] FS:  0000000000000000(0000) GS:ffff88811a600000(0000) knlGS:0000000000000000
[   88.485292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   88.485294] CR2: 000055e8c586c300 CR3: 0000000106eb0000 CR4: 00000000000006f0
[   88.485299] Call Trace:
[   88.485301]  <TASK>
[   88.485306] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460)
[   88.485313] ? exc_general_protection (arch/x86/kernel/traps.c:751 arch/x86/kernel/traps.c:693)
[   88.485319] ? asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:617)
[   88.485324] ? next_zone (mm/mmzone.c:20 mm/mmzone.c:37)
[   88.485336] ? calc_load_nohz_start (kernel/sched/loadavg.c:251 (discriminator 2))
[   88.485341] need_update (mm/vmstat.c:2032 (discriminator 2))
[   88.485366] quiet_vmstat (mm/vmstat.c:2065 (discriminator 2))
[   88.485369] tick_nohz_stop_tick (./include/linux/hrtimer.h:135 kernel/time/tick-sched.c:1044)
[   88.485373] ? __pfx_tick_nohz_stop_tick (kernel/time/tick-sched.c:970)
[   88.485376] ? tick_nohz_next_event (kernel/time/tick-sched.c:952 (discriminator 2))
[   88.485379] ? __pfx_tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:51)
[   88.485396] tick_nohz_idle_stop_tick (kernel/time/tick-sched.c:1229)
[   88.485399] do_idle (kernel/sched/idle.c:185 kernel/sched/idle.c:325)
[   88.485403] ? __pfx_do_idle (kernel/sched/idle.c:253)
[   88.485406] cpu_startup_entry (kernel/sched/idle.c:422)
[   88.485409] rest_init (init/main.c:720)
[   88.485413] ? acpi_subsystem_init (drivers/acpi/bus.c:1314)
[   88.485417] start_kernel (init/main.c:1000)
[   88.485422] x86_64_start_reservations (arch/x86/kernel/head64.c:495)
[   88.485426] x86_64_start_kernel (??:?)
[   88.485432] common_startup_64 (arch/x86/kernel/head_64.S:415)
[   88.485437]  </TASK>
[   88.485439] Modules linked in: cfg80211 8021q garp stp mrp llc ppdev evdev input_leds intel_agp e1000 mac_hid intel_gtt pcspkr i2c_piix4 agpgart i2c_smbus parport_pc parport tiny_power_button button rfkill vhost_vsock vmw_vsock_virtio_transport_common vsock vhost_net vhost vhost_iotlb tap vfio_iommu_type1 vfio iommufd uhid hid dm_mod uinput userio ppp_generic slhc tun loop cuse fuse ext4 crc32c_generic crc16 mbcache jbd2 bochs drm_client_lib drm_shmem_helper sd_mod drm_kms_helper ata_generic pata_acpi ata_piix libata drm scsi_mod serio_raw scsi_common qemu_fw_cfg

