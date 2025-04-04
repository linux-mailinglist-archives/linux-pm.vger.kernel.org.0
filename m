Return-Path: <linux-pm+bounces-24827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E463A7C4A7
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 22:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F583460437
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DF2221DA2;
	Fri,  4 Apr 2025 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="IyCgIhgh"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3222172D;
	Fri,  4 Apr 2025 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743796849; cv=none; b=ifDs1VHoroTLB40ABnmeD4jYLPEwgKRLjgNBa46ggltIpc1c7YtC4/fc6saw9VsbN/qnItrMhe+QrC42dJTPHQxGN6sA6MMwOO5GkWC9KUZIMPFvCdwQwqqgdXewPP7rFkIGoXUZnKDfig8SITvGioM93mBNAJ+Hg6s/MdtSdFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743796849; c=relaxed/simple;
	bh=IyzE497D+o2Kr3MUPmAOZJkoPKrMEXFOVcacKaeLwdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsHMdkqKg6tLdIC4XCOaS0WPoR8oPofEqnYPHEl35YTNTQs5NZvLwZkoDiKCEcOoyBWp3cCv6bOvfysGhe3eQnFnROyqnUwaZcBSFmGUzBTwx0E/zZJHU+aucMNfYwiH7L8BUEb9K/wZ8MQCCKgas24NKb4fLZEAyjT2cpMLzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=IyCgIhgh; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Fri, 4 Apr 2025 22:00:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743796842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHxKusojwTrsCmol8p0363RvOSpxdoXK507OI6WFk8w=;
	b=IyCgIhghm03JL/rjR7nCZg516czNRWEWNfirI7/Tt9RZeF3+02Y+nPM9ww5TUIVa8VWMZf
	wAkpQ+OJdmXY10EX6+AxJ1Y5AdVa38cOH2Z71f6FZY6/1dwgkYzPAsPsKwZ3zhgusD2ftz
	5uqnHxpPLSP2G73oiM2f+zvf6ypfKygoUyFerBQfbQ+RyZuAXA+EhRulOVN1wCNH8MCFMA
	C1rxxSJwBrSkHBOeLT/KwWk6jnUhGYm2+ux2uEyr1Fvk8WBKZFo6Mpw4UxDs563pNjlwMb
	3V7qVQCUgtRj4WqWCxc7eZ1qSjkSEGogX47Qhbx9AUvY4gdnLSvnQgJceNGtxQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: msizanoen <msizanoen@qtmlabs.xyz>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z_A6YhaRaN7Zj2_b@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4WGSMdF6seQm9GV@desktop0a>
 <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
 <Z-8E-LLs1dFWfn6J@desktop0a>
 <691be719-7d4c-4cb1-87d6-cca7834547fe@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691be719-7d4c-4cb1-87d6-cca7834547fe@qtmlabs.xyz>
X-Migadu-Flow: FLOW_OUT

On 2025-04-04 09:54 +0700, msizanoen wrote:
> Can you send the dmesg logs for this case (6.13 + mentioned patch series
> backported as target kernel, using kexec_load)?
> 
> On 4/4/25 05:00, Roberto Ricci wrote:
> > On 2025-04-01 19:59 +0700, msizanoen wrote:
> > > [snip]
> > > It seems like `e820__register_nosave_regions` is erroneously marking some
> > > kernel memory as nosave in the presence of sub-page e820 regions. In theory
> > > backporting
> > > https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/ should
> > > be sufficient to avoid this but a fix for the actual root cause is
> > > preferred.
> > When using kexec_file_load, this patch series fixes the issue not only
> > in theory but also in practice.
> > But the issue with kexec_load (see
> > https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
> > ), which might be related, is not fixed.

This is after kexec, before hibernation (which won't resume):

[    0.000000] Linux version 6.13.0_ricci+ (ricci@desktop0a) (gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC @0
[    0.000000] Command line: root=UUID=71b5e20d-efaa-4c09-b189-73cd6255e8ce ro loglevel=4 oops=panic panic=30
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000400-0x000000000009fbff] usable
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
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 845191456675 cycles
[    0.000002] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000004] tsc: Detected 1704.000 MHz processor
[    0.000744] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000746] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000750] last_pfn = 0x140000 max_arch_pfn = 0x400000000
[    0.000787] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.000790] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000835] last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
[    0.006857] found SMP MP-table at [mem 0x000f5470-0x000f547f]
[    0.006927] RAMDISK: [mem 0x13ce51000-0x13d5fffff]
[    0.006931] ACPI: Early table checksum verification disabled
[    0.006933] ACPI: RSDP 0x00000000000F5270 000014 (v00 BOCHS )
[    0.006937] ACPI: RSDT 0x00000000BFFE22F8 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006942] ACPI: FACP 0x00000000BFFE21AC 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006946] ACPI: DSDT 0x00000000BFFE0040 00216C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006949] ACPI: FACS 0x00000000BFFE0000 000040
[    0.006952] ACPI: APIC 0x00000000BFFE2220 000078 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006954] ACPI: HPET 0x00000000BFFE2298 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006957] ACPI: WAET 0x00000000BFFE22D0 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.006959] ACPI: Reserving FACP table memory at [mem 0xbffe21ac-0xbffe221f]
[    0.006960] ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe21ab]
[    0.006961] ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
[    0.006961] ACPI: Reserving APIC table memory at [mem 0xbffe2220-0xbffe2297]
[    0.006962] ACPI: Reserving HPET table memory at [mem 0xbffe2298-0xbffe22cf]
[    0.006963] ACPI: Reserving WAET table memory at [mem 0xbffe22d0-0xbffe22f7]
[    0.007240] No NUMA configuration found
[    0.007241] Faking a node at [mem 0x0000000000000000-0x000000013fffffff]
[    0.007244] NODE_DATA(0) allocated [mem 0x13fff9940-0x13fffcfff]
[    0.007254] Zone ranges:
[    0.007255]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007256]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007257]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.007259] Movable zone start for each node
[    0.007259] Early memory node ranges
[    0.007259]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.007261]   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
[    0.007262]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.007262] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
[    0.007268] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007290] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.014413] On node 0, zone Normal: 32 pages in unavailable ranges
[    0.014801] ACPI: PM-Timer IO Port: 0x608
[    0.014810] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.014841] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.014844] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.014846] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.014847] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.014848] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.014849] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.014852] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.014853] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.014859] CPU topo: Max. logical packages:   1
[    0.014860] CPU topo: Max. logical dies:       1
[    0.014860] CPU topo: Max. dies per package:   1
[    0.014864] CPU topo: Max. threads per core:   1
[    0.014864] CPU topo: Num. cores per package:     1
[    0.014865] CPU topo: Num. threads per package:   1
[    0.014865] CPU topo: Allowing 1 present CPUs plus 0 hotplug CPUs
[    0.014876] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
[    0.014895] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.014897] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.014897] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.014898] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.014899] PM: hibernation: Registered nosave memory: [mem 0xbffe0000-0xbfffffff]
[    0.014899] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfeffbfff]
[    0.014900] PM: hibernation: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.014901] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.014901] PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.014902] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.014903] Booting paravirtualized kernel on KVM
[    0.014904] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.020371] setup_percpu: NR_CPUS:64 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
[    0.020610] percpu: Embedded 56 pages/cpu s191320 r8192 d29864 u2097152
[    0.020614] pcpu-alloc: s191320 r8192 d29864 u2097152 alloc=1*2097152
[    0.020615] pcpu-alloc: [0] 0 
[    0.020631] Kernel command line: root=UUID=71b5e20d-efaa-4c09-b189-73cd6255e8ce ro loglevel=4 oops=panic panic=30
[    0.020661] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes
[    0.021076] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.021294] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.021321] Fallback order for Node 0: 0 
[    0.021323] Built 1 zonelists, mobility grouping on.  Total pages: 1048446
[    0.021324] Policy zone: Normal
[    0.021325] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.021328] software IO TLB: area num 1.
[    0.043961] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.043970] Kernel/User page tables isolation: enabled
[    0.044757] Dynamic Preempt: voluntary
[    0.044771] rcu: Preemptible hierarchical RCU implementation.
[    0.044772] rcu: 	RCU event tracing is enabled.
[    0.044772] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
[    0.044773] 	Trampoline variant of Tasks RCU enabled.
[    0.044774] 	Tracing variant of Tasks RCU enabled.
[    0.044774] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.044775] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.044778] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=1.
[    0.044779] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=1.
[    0.047923] NR_IRQS: 4352, nr_irqs: 256, preallocated irqs: 16
[    0.048112] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.054450] Console: colour VGA+ 80x25
[    0.054454] printk: legacy console [tty0] enabled
[    0.054477] ACPI: Core revision 20240827
[    0.054599] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.054720] APIC: Switch to symmetric I/O mode setup
[    0.056218] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.056246] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x188fe9e6a4a, max_idle_ns: 440795223879 ns
[    0.056251] Calibrating delay loop (skipped) preset value.. 3408.00 BogoMIPS (lpj=1704000)
[    0.056409] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.056410] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.056414] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.056416] Spectre V2 : Mitigation: Retpolines
[    0.056416] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.056417] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.056418] Speculative Store Bypass: Vulnerable
[    0.056419] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.056420] MMIO Stale Data: Unknown: No mitigations
[    0.056421] x86/fpu: x87 FPU will use FXSAVE
[    0.080722] Freeing SMP alternatives memory: 48K
[    0.080731] pid_max: default: 32768 minimum: 301
[    0.080746] LSM: initializing lsm=capability,selinux
[    0.080762] SELinux:  Initializing.
[    0.080887] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.080894] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.183123] smpboot: CPU0: Intel QEMU Virtual CPU version 2.5+ (family: 0xf, model: 0x6b, stepping: 0x1)
[    0.183249] Performance Events: unsupported Netburst CPU model 107 no PMU driver, software events only.
[    0.183249] signal: max sigframe size: 1440
[    0.183249] rcu: Hierarchical SRCU implementation.
[    0.183249] rcu: 	Max phase no-delay instances is 400.
[    0.183249] smp: Bringing up secondary CPUs ...
[    0.183249] smp: Brought up 1 node, 1 CPU
[    0.183249] smpboot: Total of 1 processors activated (3408.00 BogoMIPS)
[    0.183249] Memory: 4003712K/4193784K available (18432K kernel code, 2858K rwdata, 7076K rodata, 2788K init, 1008K bss, 185720K reserved, 0K cma-reserved)
[    0.183249] devtmpfs: initialized
[    0.183249] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.183249] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.183249] PM: RTC time: 19:54:11, date: 2025-04-04
[    0.183249] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.183249] audit: initializing netlink subsys (disabled)
[    0.183249] audit: type=2000 audit(1743796451.138:1): state=initialized audit_enabled=0 res=1
[    0.183249] thermal_sys: Registered thermal governor 'step_wise'
[    0.183249] thermal_sys: Registered thermal governor 'user_space'
[    0.183249] cpuidle: using governor menu
[    0.183414] PCI: Using configuration type 1 for base access
[    0.183474] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.184363] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.184365] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.185316] ACPI: Added _OSI(Module Device)
[    0.185317] ACPI: Added _OSI(Processor Device)
[    0.185318] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.185319] ACPI: Added _OSI(Processor Aggregator Device)
[    0.185851] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.186375] ACPI: Interpreter enabled
[    0.186383] ACPI: PM: (supports S0 S3 S4 S5)
[    0.186384] ACPI: Using IOAPIC for interrupt routing
[    0.186392] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.186393] PCI: Using E820 reservations for host bridge windows
[    0.186463] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.188952] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.188956] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.188958] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.188964] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    0.189053] PCI host bridge to bus 0000:00
[    0.189055] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.189057] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.189058] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.189060] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.189061] pci_bus 0000:00: root bus resource [mem 0x140000000-0x1bfffffff window]
[    0.189062] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.189109] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
[    0.191472] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 conventional PCI endpoint
[    0.192089] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 conventional PCI endpoint
[    0.194496] pci 0000:00:01.1: BAR 4 [io  0xc080-0xc08f]
[    0.195522] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    0.195524] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    0.195526] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    0.195527] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    0.199922] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
[    0.200432] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.200443] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.200658] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000 conventional PCI endpoint
[    0.202270] pci 0000:00:02.0: BAR 0 [mem 0xfd000000-0xfdffffff pref]
[    0.204281] pci 0000:00:02.0: BAR 2 [mem 0xfebf0000-0xfebf0fff]
[    0.209314] pci 0000:00:02.0: ROM [mem 0xfebe0000-0xfebeffff pref]
[    0.218519] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.218845] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000 conventional PCI endpoint
[    0.219618] pci 0000:00:03.0: BAR 0 [mem 0xfebc0000-0xfebdffff]
[    0.220251] pci 0000:00:03.0: BAR 1 [io  0xc000-0xc03f]
[    0.224252] pci 0000:00:03.0: ROM [mem 0xfeb80000-0xfebbffff pref]
[    0.231594] pci 0000:00:04.0: [1af4:1009] type 00 class 0x000200 conventional PCI endpoint
[    0.232251] pci 0000:00:04.0: BAR 0 [io  0xc040-0xc07f]
[    0.233067] pci 0000:00:04.0: BAR 1 [mem 0xfebf1000-0xfebf1fff]
[    0.235614] pci 0000:00:04.0: BAR 4 [mem 0xfe000000-0xfe003fff 64bit pref]
[    0.242909] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.242912] ACPI: PCI: Interrupt link LNKA disabled
[    0.243011] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.243012] ACPI: PCI: Interrupt link LNKB disabled
[    0.243105] ACPI: PCI: Interrupt link LNKC configured for IRQ 10
[    0.243196] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.244903] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.245165] iommu: Default domain type: Translated
[    0.245168] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.245305] SCSI subsystem initialized
[    0.245480] libata version 3.00 loaded.
[    0.245507] ACPI: bus type USB registered
[    0.245521] usbcore: registered new interface driver usbfs
[    0.245529] usbcore: registered new interface driver hub
[    0.245532] usbcore: registered new device driver usb
[    0.245542] pps_core: LinuxPPS API ver. 1 registered
[    0.245543] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.245545] PTP clock support registered
[    0.245614] Advanced Linux Sound Architecture Driver Initialized.
[    0.245826] NetLabel: Initializing
[    0.245827] NetLabel:  domain hash size = 128
[    0.245828] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.245846] NetLabel:  unlabeled traffic allowed by default
[    0.245944] PCI: Using ACPI for IRQ routing
[    0.245946] PCI: pci_cache_line_size set to 64 bytes
[    0.246072] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.246074] e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
[    0.246110] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.246112] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.246113] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.246115] vgaarb: loaded
[    0.246159] hpet: 3 channels of 0 reserved for per-cpu timers
[    0.246171] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.246175] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.252266] clocksource: Switched to clocksource kvm-clock
[    0.252354] VFS: Disk quotas dquot_6.6.0
[    0.252367] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.252463] pnp: PnP ACPI init
[    0.252544] pnp 00:02: [dma 2]
[    0.252701] pnp: PnP ACPI: found 6 devices
[    0.258246] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.262437] NET: Registered PF_INET protocol family
[    0.262516] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.264478] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.264484] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.264486] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.264514] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.264636] TCP: Hash tables configured (established 32768 bind 32768)
[    0.264665] UDP hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.264684] UDP-Lite hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.264733] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.264821] RPC: Registered named UNIX socket transport module.
[    0.264822] RPC: Registered udp transport module.
[    0.264823] RPC: Registered tcp transport module.
[    0.264823] RPC: Registered tcp-with-tls transport module.
[    0.264824] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.265087] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.265090] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.265091] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.265093] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    0.265094] pci_bus 0000:00: resource 8 [mem 0x140000000-0x1bfffffff window]
[    0.265144] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.265214] PCI: CLS 0 bytes, default 64
[    0.265321] Unpacking initramfs...
[    0.267472] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.267475] software IO TLB: mapped [mem 0x00000000bbfe0000-0x00000000bffe0000] (64MB)
[    0.267502] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x188fe9e6a4a, max_idle_ns: 440795223879 ns
[    0.399154] Initialise system trusted keyrings
[    0.399193] workingset: timestamp_bits=56 max_order=20 bucket_order=0
[    0.399294] NFS: Registering the id_resolver key type
[    0.399298] Key type id_resolver registered
[    0.399299] Key type id_legacy registered
[    0.399367] 9p: Installing v9fs 9p2000 file system support
[    0.423162] Key type asymmetric registered
[    0.423166] Asymmetric key parser 'x509' registered
[    0.423178] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.423197] io scheduler mq-deadline registered
[    0.423198] io scheduler kyber registered
[    0.423278] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.423355] ACPI: button: Power Button [PWRF]
[    0.423919] ACPI: \_SB_.LNKD: Enabled at IRQ 11
[    0.426239] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.426439] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.427456] Non-volatile memory driver v1.3
[    0.427458] Linux agpgart interface v0.103
[    0.427519] ACPI: bus type drm_connector registered
[    0.429366] loop: module loaded
[    0.429431] ata_piix 0000:00:01.1: version 2.13
[    0.431376] scsi host0: ata_piix
[    0.431453] scsi host1: ata_piix
[    0.431475] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc080 irq 14 lpm-pol 0
[    0.431477] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc088 irq 15 lpm-pol 0
[    0.432129] e100: Intel(R) PRO/100 Network Driver
[    0.432131] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.432157] e1000: Intel(R) PRO/1000 Network Driver
[    0.432158] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.432703] ACPI: \_SB_.LNKC: Enabled at IRQ 10
[    0.473024] Freeing initrd memory: 7868K
[    0.587950] ata1: found unknown device (class 0)
[    0.588347] ata2: found unknown device (class 0)
[    0.589191] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    0.589453] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    0.589455] ata1.00: 41943040 sectors, multi 16: LBA48 
[    0.590475] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    0.590579] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[    0.590642] sd 0:0:0:0: [sda] 41943040 512-byte logical blocks: (21.5 GB/20.0 GiB)
[    0.590649] sd 0:0:0:0: [sda] Write Protect is off
[    0.590650] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.590655] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.590662] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    0.591057] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    0.596814]  sda: sda1 sda2
[    0.596868] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.617948] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    0.617957] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.626394] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    0.626423] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    0.768092] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    0.768103] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    0.768121] e1000e: Intel(R) PRO/1000 Network Driver
[    0.768122] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.768131] sky2: driver version 1.30
[    0.768234] usbcore: registered new interface driver usblp
[    0.768241] usbcore: registered new interface driver usb-storage
[    0.768267] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.769030] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.769038] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.769614] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.770195] rtc_cmos 00:05: RTC can wake from S4
[    0.771215] rtc_cmos 00:05: registered as rtc0
[    0.771282] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    0.771373] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    0.771381] intel_pstate: CPU model not supported
[    0.771398] hid: raw HID events driver (C) Jiri Kosina
[    0.771478] usbcore: registered new interface driver usbhid
[    0.771479] usbhid: USB HID core driver
[    0.771829] Initializing XFRM netlink socket
[    0.771846] NET: Registered PF_INET6 protocol family
[    0.773373] Segment Routing with IPv6
[    0.773381] In-situ OAM (IOAM) with IPv6
[    0.773422] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.773518] NET: Registered PF_PACKET protocol family
[    0.773542] 9pnet: Installing 9P2000 support
[    0.774479] Key type dns_resolver registered
[    0.774948] IPI shorthand broadcast: enabled
[    0.776649] sched_clock: Marking stable (769005525, 7132439)->(779498288, -3360324)
[    0.776706] registered taskstats version 1
[    0.776708] Loading compiled-in X.509 certificates
[    0.777558] Demotion targets for Node 0: null
[    0.777595] PM:   Magic number: 5:195:950
[    0.777609] tty tty7: hash matches
[    0.777622] printk: legacy console [netcon0] enabled
[    0.777623] netconsole: network logging started
[    0.777657] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    0.778817] modprobe (49) used greatest stack depth: 13352 bytes left
[    0.779720] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    0.779862] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    0.779892] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    0.779896] cfg80211: failed to load regulatory.db
[    0.779905] ALSA device list:
[    0.779907]   No soundcards found.
[    0.780247] Freeing unused kernel image (initmem) memory: 2788K
[    0.780297] Write protecting the kernel read-only data: 26624k
[    0.780545] Freeing unused kernel image (rodata/data gap) memory: 1116K
[    0.822784] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.822794] x86/mm: Checking user space page tables
[    0.863502] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.863508] Run /init as init process
[    0.863509]   with arguments:
[    0.863509]     /init
[    0.863510]   with environment:
[    0.863511]     HOME=/
[    0.863511]     TERM=linux
[    0.891531] dracut: modprobe: FATAL: Module btrfs not found in directory /lib/modules/6.13.0_ricci+
[    0.919721] systemd-udevd[201]: starting version 3.2.14
[    0.921089] udevd[202]: starting eudev-3.2.14
[    0.964889] e1000 0000:00:03.0 enp0s3: renamed from eth0
[    1.185307] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[    1.382155] EXT4-fs (sda1): orphan cleanup on readonly fs
[    1.382585] EXT4-fs (sda1): mounted filesystem 71b5e20d-efaa-4c09-b189-73cd6255e8ce ro with ordered data mode. Quota mode: none.
[    1.382736] mount (255) used greatest stack depth: 13312 bytes left
[    1.391798] findmnt (276) used greatest stack depth: 13208 bytes left
[    1.396015] dracut: Remounting /dev/disk/by-uuid/71b5e20d-efaa-4c09-b189-73cd6255e8ce with -o defaults,noatime,ro
[    1.399219] EXT4-fs (sda1): re-mounted 71b5e20d-efaa-4c09-b189-73cd6255e8ce ro. Quota mode: none.
[    1.408575] dracut: Mounted root filesystem /dev/sda1
[    1.429000] dracut: Switching root
[    1.507282] udevd[363]: starting version 3.2.14
[    1.523979] udevd (363) used greatest stack depth: 13104 bytes left
[    1.524411] udevd[364]: starting eudev-3.2.14
[    1.671245] EXT4-fs (sda1): re-mounted 71b5e20d-efaa-4c09-b189-73cd6255e8ce ro. Quota mode: none.
[    1.729208] EXT4-fs (sda1): re-mounted 71b5e20d-efaa-4c09-b189-73cd6255e8ce r/w. Quota mode: none.
[    1.735473] Adding 4194300k swap on /dev/sda2.  Priority:-2 extents:1 across:4194300k 
[    1.751610] seedrng (401) used greatest stack depth: 12672 bytes left
[    1.824694] udevd[445]: starting version 3.2.14
[    1.833890] udevd[445]: starting eudev-3.2.14
[    1.866863] e1000: enp0s3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX

