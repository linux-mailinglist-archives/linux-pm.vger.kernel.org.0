Return-Path: <linux-pm+bounces-33014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731CAB33D49
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 12:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC611882168
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872EE1F4CBC;
	Mon, 25 Aug 2025 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4XXHsR5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFD1F461D
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119337; cv=none; b=bC0copB2QDvbKBrAdThCcElU/A64yaTkAHw4Y51aXzx8ox0sqtj5XR/y9N4SpsV/+vAKEvJJtRzK8TcoJAl1AUOcdRcL6bplNnlFAJ1LIM8xHmoNRjUiqwUyaELQ+91D+5MD2GruT1y6mD8erNkO6QYDntTpsCC9QPRt1Hxd6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119337; c=relaxed/simple;
	bh=YhmEuzvydCPv2nyAla2UFutm4x/KY5Nwn8wPPJAHi3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE0sELaiK9/q6r/FNsNsXQ6ZTWXWsfFGEHGMLwLf7VM941iCwWth4m6OYZRpw2RwlgZ5s8e+pWgFvK7DjjZD6YD3UfpJw8M8WIfbGfJQigVDg959PCDNTKgeoJwrtoTI0O4HdwCpIu9TFYS5uUg06KWakJl5a+xEtq67y3dwcP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4XXHsR5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756119315; x=1787655315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YhmEuzvydCPv2nyAla2UFutm4x/KY5Nwn8wPPJAHi3c=;
  b=h4XXHsR5LuF+QHeqFgIWy5HTftMzLe+v5unrl4mGHMK4h2gVZQpb9ZZn
   W2pnVXZ6qphnnICxcpgj1Y/MhgVfuPX8X7Violq5GR8IPxxK8fyp6BfbC
   F+FcqEthZAVB+D8HaBIQT7D9O2C3bNFc4u7F6y9a8d0XW7BcO8pv8+zrA
   mu+VI52ajbBpUn/oT26Y+oQAG4QNmoK36rROXQmsGHJPShG1PATogDIcA
   o61Wt820Z96oMyx7fvqmkEeLp4STyuxBYkma41cgllnHCZqPtA5SjN/tO
   981zMx7z5LIyF2QHAvt2Ti7PKHLM5ef+F9sss/oDReBK/KJRAe+gB4zdZ
   A==;
X-CSE-ConnectionGUID: uqlu1Y04ST2KztCa1F39yg==
X-CSE-MsgGUID: MdJVhbBIR3GgUliq+Za7sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="60959028"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60959028"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 03:55:13 -0700
X-CSE-ConnectionGUID: PvHsMTyHQpiBfuhqIwqYZA==
X-CSE-MsgGUID: K1SA2NQ7ThWp1IRMvVQeSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169458839"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 25 Aug 2025 03:55:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 5FCAA94; Mon, 25 Aug 2025 12:55:09 +0200 (CEST)
Date: Mon, 25 Aug 2025 12:55:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Zha Qipeng <qipeng.zha@intel.com>, Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: Pkg%pcX values do not add up to 100
Message-ID: <20250825105509.GQ476609@black.igk.intel.com>
References: <774d9a96-0120-4009-8fd7-78387267b194@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <774d9a96-0120-4009-8fd7-78387267b194@molgen.mpg.de>

Hi,

I'm not an expert here but if some of the CPUs are not in any of the power
saving states then they should not be counted.

On Sun, Aug 24, 2025 at 11:04:41PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Intel Kaby Lake laptop Dell XPS 13 9360 with Debian sid/unstable with
> Linux 6.17.0-rc2-00053-gb19a97d57c15 and *linux-cpupower* 6.12.38-1 running
> `turbostat`, the Pkg%pcX values do not add up to 100.
> 
> ```
> $ lsmod | grep pmc
> intel_pmc_bxt          16384  1 iTCO_wdt
> intel_pmc_core        126976  0
> pmt_telemetry          20480  1 intel_pmc_core
> intel_pmc_ssram_telemetry    16384  1 intel_pmc_core
> intel_vsec             24576  2 intel_pmc_ssram_telemetry,pmt_telemetry
> $ sudo dmesg | grep pmc
> [   17.420395] intel_pmc_core INT33A1:00:  initialized
> $ sudo turbostat
> turbostat version 2024.07.26 - Len Brown <lenb@kernel.org>
> Kernel command line: BOOT_IMAGE=/vmlinuz-6.17.0-rc2-00053-gb19a97d57c15
> root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer
> mem_sleep_default=deep log_buf_len=16M cryptomgr.notests
> usbcore.quirks=0cf3:e300:e,04f3:2234:e,0c45:670c:e
> CPUID(0): GenuineIntel 0x16 CPUID levels
> CPUID(1): family:model:stepping 0x6:8e:9 (6:142:9) microcode 0xf6
> CPUID(0x80000000): max_extended_levels: 0x80000008
> CPUID(1): SSE3 MONITOR - EIST TM2 TSC MSR ACPI-TM HT TM
> CPUID(6): APERF, TURBO, DTS, PTM, HWP, HWPnotify, HWPwindow, HWPepp,
> No-HWPpkg, EPB
> cpu0: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT PREFETCH TURBO)
> CPUID(7): SGX No-Hybrid
> cpu0: MSR_IA32_FEATURE_CONTROL: 0x00040005 (Locked SGX)
> CPUID(0x15): eax_crystal: 2 ebx_tsc: 242 ecx_crystal_hz: 0
> TSC: 2904 MHz (24000000 Hz * 242 / 2 / 1000000)
> CPUID(0x16): base_mhz: 2900 max_mhz: 3500 bus_mhz: 100
> cpu0: MSR_PLATFORM_INFO: 0x4043df1011d00
> 4 * 100.0 = 400.0 MHz max efficiency frequency
> 29 * 100.0 = 2900.0 MHz base frequency
> cpu0: MSR_TURBO_RATIO_LIMIT: 0x23232323
> 35 * 100.0 = 3500.0 MHz max turbo 4 active cores
> 35 * 100.0 = 3500.0 MHz max turbo 3 active cores
> 35 * 100.0 = 3500.0 MHz max turbo 2 active cores
> 35 * 100.0 = 3500.0 MHz max turbo 1 active cores
> cpu0: MSR_CONFIG_TDP_NOMINAL: 0x0000001b (base_ratio=27)
> cpu0: MSR_CONFIG_TDP_LEVEL_1: 0x0008003c (PKG_MIN_PWR_LVL1=0
> PKG_MAX_PWR_LVL1=0 LVL1_RATIO=8 PKG_TDP_LVL1=60)
> cpu0: MSR_CONFIG_TDP_LEVEL_2: 0x001d00c8 (PKG_MIN_PWR_LVL2=0
> PKG_MAX_PWR_LVL2=0 LVL2_RATIO=29 PKG_TDP_LVL2=200)
> cpu0: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=0)
> cpu0: MSR_TURBO_ACTIVATION_RATIO: 0x0000001a (MAX_NON_TURBO_RATIO=26 lock=0)
> cpu0: cpufreq driver: intel_pstate
> cpu0: cpufreq governor: powersave
> cpufreq intel_pstate no_turbo: 0
> cpu0: MSR_MISC_PWR_MGMT: 0x00401cc0 (ENable-EIST_Coordination DISable-EPB
> DISable-OOB)
> cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
> cpu0: MSR_HWP_CAPABILITIES: 0x01081b23 (high 35 guar 27 eff 8 low 1)
> cpu0: MSR_HWP_REQUEST: 0xc0000404 (min 4 max 4 des 0 epp 0xc0 window 0x0 pkg
> 0x0)
> cpu0: MSR_HWP_INTERRUPT: 0x00000001 (EN_Guaranteed_Perf_Change,
> Dis_Excursion_Min)
> cpu0: MSR_HWP_STATUS: 0x00000000 (No-Guaranteed_Perf_Change,
> No-Excursion_Min)
> cpu0: EPB: 8 (custom)
> cpu0: MSR_IA32_POWER_CTL: 0x0024005f (C1E auto-promotion: ENabled)
> cpu0: MSR_PKG_CST_CONFIG_CONTROL: 0x1e008008 (UNdemote-C3, UNdemote-C1,
> demote-C3, demote-C1, locked, pkg-cstate-limit=8 (unlimited))
> /dev/cpu_dma_latency: 2000000000 usec (default)
> current_driver: intel_idle
> current_governor: menu
> current_governor_ro: menu
> cpu0: POLL: CPUIDLE CORE POLL IDLE
> cpu0: C1: MWAIT 0x00
> cpu0: C1E: MWAIT 0x01
> cpu0: C3: MWAIT 0x10
> cpu0: C6: MWAIT 0x20
> cpu0: C7s: MWAIT 0x33
> cpu0: C8: MWAIT 0x40
> cpu0: C9: MWAIT 0x50
> cpu0: C10: MWAIT 0x60
> cpu0: MSR_PKGC3_IRTL: 0x0000884e (valid, 79872 ns)
> cpu0: MSR_PKGC6_IRTL: 0x00008876 (valid, 120832 ns)
> cpu0: MSR_PKGC7_IRTL: 0x00008894 (valid, 151552 ns)
> cpu0: MSR_PKGC8_IRTL: 0x000088fa (valid, 256000 ns)
> cpu0: MSR_PKGC9_IRTL: 0x0000894c (valid, 339968 ns)
> cpu0: MSR_PKGC10_IRTL: 0x00008bf2 (valid, 1034240 ns)
> RAPL: 17476 sec. Joule Counter Range, at 15 Watts
> cpu0: MSR_RAPL_POWER_UNIT: 0x000a0e03 (0.125000 Watts, 0.000061 Joules,
> 0.000977 sec.)
> cpu0: MSR_PKG_POWER_INFO: 0x00000078 (15 W TDP, RAPL 0 - 0 W, 0.000000 sec.)
> cpu0: MSR_PKG_POWER_LIMIT: 0x4280e800dd8088 (UNlocked)
> cpu0: PKG Limit #1: ENabled (17.000 Watts, 28.000000 sec, clamp ENabled)
> cpu0: PKG Limit #2: ENabled (29.000 Watts, 0.002441* sec, clamp DISabled)
> cpu0: MSR_VR_CURRENT_CONFIG: 0x00000000
> cpu0: PKG Limit #4: 0.000000 Watts (UNlocked)
> cpu0: MSR_DRAM_POWER_LIMIT: 0x5400de00000000 (UNlocked)
> cpu0: DRAM Limit: DISabled (0.000 Watts, 0.000977 sec, clamp DISabled)
> cpu0: MSR_PP0_POLICY: 0
> cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
> cpu0: Cores Limit: DISabled (0.000 Watts, 0.000977 sec, clamp DISabled)
> cpu0: MSR_PP1_POLICY: 0
> cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
> cpu0: GFX Limit: DISabled (0.000 Watts, 0.000977 sec, clamp DISabled)
> cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x02640000 (98 C) (100 default - 2
> offset)
> cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x883b0800 (41 C)
> cpu0: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x00000003 (100 C, 100 C)
> cpu0: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch L2-Prefetch-pair
> L1-Prefetch L1-IP-Prefetch)
> Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IPC	IRQ	SMI	POLL	C1	C1E	C3	C6	C7s
> C8	C9	C10	POLL%	C1%	C1E%	C3%	C6%	C7s%	C8%	C9%	C10%	CPU%c1	CPU%c3	CPU%c6
> CPU%c7	CoreTmp	CoreThr	PkgTmp	GFX%rc6	GFXMHz	GFXAMHz	Totl%C0	Any%C0
> GFX%C0	CPUGFX%	Pkg%pc2	Pkg%pc3	Pkg%pc6Pkg%pc7	Pkg%pc8	Pkg%pc9	Pk%pc10
> CPU%LPI	SYS%LPI	PkgWatt	CorWatt	GFXWatt	RAMWatt	PKG_%	RAM_%
> -	-	163	20.74	784	2904	0.81	8954	0	9	41	338	577	2977	0	5865	3	491	0.00
> 0.02	0.45	1.33	12.46	0.00	54.56	0.00	10.56	19.63	1.37	16.52	41.74	38	0
> 40	76.42	300	300	76.59	64.71	22.53	12.88	8.84	0.88	4.39	0.00	10.20	0.00
> 0.00	0.00	0.00	1.64	0.42	0.09	0.85	0.00	0.00
> 0	0	142	18.04	790	2904	0.64	4786	0	1	15	168	262	1711	0	1704	0	24	0.00
> 0.06	1.06	2.82	28.11	0.00	48.80	0.00	1.33	17.64	2.28	24.34	37.70	38	0	40
> 76.43	300	300	76.59	64.72	22.53	12.88	8.84	0.88	4.39	0.00	10.20	0.00
> 0.00	0.00	0.00	1.64	0.42	0.09	0.85	0.00	0.00
> 0	2	128	16.53	776	2904	0.82	1330	0	2	8	63	102	357	0	1290	0	224	0.00	0.00
> 0.39	0.90	5.86	0.00	56.41	0.00	19.98	19.16
> 1	1	221	28.14	786	2904	0.87	1473	0	2	6	52	127	514	0	1442	3	81	0.00	0.00
> 0.14	0.94	8.57	0.00	55.99	0.00	6.29	16.92	0.47	8.71	45.77	38	0
> 1	3	158	20.23	783	2904	0.86	1365	0	4	12	55	86	395	0	1429	0	162	0.00	0.00
> 0.21	0.66	7.28	0.00	57.04	0.00	14.63	24.83
> ```
> 
> From the first line:
> 
> Pkg%pc2	Pkg%pc3	Pkg%pc6	Pkg%pc7	Pkg%pc8	Pkg%pc9	Pk%pc10
> 8.84	0.88	4.39	0.00	10.20	0.00	0.00
> 
> This adds up to around 25 %. Is this expected? Please find the output of
> `dmesg` attached.
> 
> 
> Kind regards,
> 
> Paul

> [    0.000000] Linux version 6.17.0-rc2-00053-gb19a97d57c15 (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.3.0-5) 14.3.0, GNU ld (GNU Binutils for Debian) 2.45) #119 SMP PREEMPT_DYNAMIC Wed Aug 20 08:09:34 CEST 2025
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.17.0-rc2-00053-gb19a97d57c15 root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep log_buf_len=16M cryptomgr.notests usbcore.quirks=0cf3:e300:e,04f3:2234:e,0c45:670c:e
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000556aafff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000556ab000-0x00000000556abfff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000556ac000-0x00000000556acfff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000556ad000-0x0000000064df3fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000064df4000-0x000000006517ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000065180000-0x00000000651c3fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000651c4000-0x000000006f871fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000006f872000-0x000000006fffefff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000006ffff000-0x000000006fffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000070000000-0x0000000077ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000078000000-0x00000000785fffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000078600000-0x000000007c7fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004817fffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] APIC: Static calls initialized
> [    0.000000] efi: EFI v2.4 by American Megatrends
> [    0.000000] efi: ACPI=0x6518d000 ACPI 2.0=0x6518d000 SMBIOS=0xf0000 SMBIOS 3.0=0xf0020 TPMFinalLog=0x6f812000 ESRT=0x6fc86698 MEMATTR=0x62675018 INITRD=0x5577dd98 TPMEventLog=0x65188018 
> [    0.000000] efi: Remove mem36: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
> [    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
> [    0.000000] efi: Not removing mem37: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
> [    0.000000] efi: Not removing mem38: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
> [    0.000000] efi: Not removing mem39: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
> [    0.000000] efi: Remove mem40: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
> [    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
> [    0.000000] SMBIOS 3.0.0 present.
> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> [    0.000000] DMI: Memory slots populated: 2/2
> [    0.000000] tsc: Detected 2900.000 MHz processor
> [    0.000000] tsc: Detected 2899.886 MHz TSC
> [    0.000702] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000704] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000710] last_pfn = 0x481800 max_arch_pfn = 0x400000000
> [    0.000713] MTRR map: 4 entries (3 fixed + 1 variable; max 23), built from 10 variable MTRRs
> [    0.000715] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.001005] last_pfn = 0x78600 max_arch_pfn = 0x400000000
> [    0.007356] esrt: Reserving ESRT space from 0x000000006fc86698 to 0x000000006fc866d0.
> [    0.007361] Using GB pages for direct mapping
> [    0.019621] printk: log buffer data + meta data: 16777216 + 58720256 = 75497472 bytes
> [    0.019623] printk: early log buf free: 127328(97%)
> [    0.019624] Secure boot disabled
> [    0.019624] RAMDISK: [mem 0x514e5000-0x5254ffff]
> [    0.019628] ACPI: Early table checksum verification disabled
> [    0.019631] ACPI: RSDP 0x000000006518D000 000024 (v02 DELL  )
> [    0.019635] ACPI: XSDT 0x000000006518D0C8 00010C (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.019639] ACPI: FACP 0x00000000651B2A48 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
> [    0.019644] ACPI: DSDT 0x000000006518D260 0257E7 (v02 DELL   CBX3     01072009 INTL 20160422)
> [    0.019646] ACPI: FACS 0x000000006F86F180 000040
> [    0.019648] ACPI: APIC 0x00000000651B2B58 000084 (v03 DELL   CBX3     01072009 AMI  00010013)
> [    0.019650] ACPI: FPDT 0x00000000651B2BE0 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.019652] ACPI: FIDT 0x00000000651B2C28 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.019654] ACPI: MCFG 0x00000000651B2CD8 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
> [    0.019656] ACPI: HPET 0x00000000651B2D18 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
> [    0.019658] ACPI: SSDT 0x00000000651B2D50 000359 (v01 SataRe SataTabl 00001000 INTL 20160422)
> [    0.019660] ACPI: BOOT 0x00000000651B30B0 000028 (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.019662] ACPI: SSDT 0x00000000651B30D8 0012CF (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
> [    0.019664] ACPI: HPET 0x00000000651B43A8 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
> [    0.019666] ACPI: SSDT 0x00000000651B43E0 000D84 (v02 INTEL  xh_rvp07 00000000 INTL 20160422)
> [    0.019668] ACPI: UEFI 0x00000000651B5168 000042 (v01                 00000000      00000000)
> [    0.019670] ACPI: SSDT 0x00000000651B51B0 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
> [    0.019672] ACPI: LPIT 0x00000000651B6090 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
> [    0.019674] ACPI: WSMT 0x00000000651B6128 000028 (v01 DELL   CBX3     00000000 MSFT 0000005F)
> [    0.019676] ACPI: SSDT 0x00000000651B6150 000161 (v02 INTEL  HdaDsp   00000000 INTL 20160422)
> [    0.019678] ACPI: SSDT 0x00000000651B62B8 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
> [    0.019680] ACPI: SSDT 0x00000000651B6558 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
> [    0.019682] ACPI: SSDT 0x00000000651B9560 0000DB (v02 INTEL  TbtTypeC 00000000 INTL 20160422)
> [    0.019684] ACPI: DBGP 0x00000000651B9640 000034 (v01 INTEL           00000002 MSFT 0000005F)
> [    0.019686] ACPI: DBG2 0x00000000651B9678 000054 (v00 INTEL           00000002 MSFT 0000005F)
> [    0.019688] ACPI: SSDT 0x00000000651B96D0 0007DD (v02 INTEL  UsbCTabl 00001000 INTL 20160422)
> [    0.019690] ACPI: SSDT 0x00000000651B9EB0 0084F1 (v02 DptfTa DptfTabl 00001000 INTL 20160422)
> [    0.019692] ACPI: SLIC 0x00000000651C23A8 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
> [    0.019694] ACPI: NHLT 0x00000000651C2520 00002D (v00 INTEL  EDK2     00000002      01000013)
> [    0.019700] ACPI: BGRT 0x00000000651C2550 000038 (v00                 01072009 AMI  00010013)
> [    0.019703] ACPI: TPM2 0x00000000651C2588 000034 (v03        Tpm2Tabl 00000001 AMI  00000000)
> [    0.019705] ACPI: ASF! 0x00000000651C25C0 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
> [    0.019707] ACPI: DMAR 0x00000000651C2660 0000F0 (v01 INTEL  KBL      00000001 INTL 00000001)
> [    0.019708] ACPI: Reserving FACP table memory at [mem 0x651b2a48-0x651b2b53]
> [    0.019710] ACPI: Reserving DSDT table memory at [mem 0x6518d260-0x651b2a46]
> [    0.019710] ACPI: Reserving FACS table memory at [mem 0x6f86f180-0x6f86f1bf]
> [    0.019711] ACPI: Reserving APIC table memory at [mem 0x651b2b58-0x651b2bdb]
> [    0.019712] ACPI: Reserving FPDT table memory at [mem 0x651b2be0-0x651b2c23]
> [    0.019712] ACPI: Reserving FIDT table memory at [mem 0x651b2c28-0x651b2cd3]
> [    0.019713] ACPI: Reserving MCFG table memory at [mem 0x651b2cd8-0x651b2d13]
> [    0.019713] ACPI: Reserving HPET table memory at [mem 0x651b2d18-0x651b2d4f]
> [    0.019714] ACPI: Reserving SSDT table memory at [mem 0x651b2d50-0x651b30a8]
> [    0.019714] ACPI: Reserving BOOT table memory at [mem 0x651b30b0-0x651b30d7]
> [    0.019715] ACPI: Reserving SSDT table memory at [mem 0x651b30d8-0x651b43a6]
> [    0.019716] ACPI: Reserving HPET table memory at [mem 0x651b43a8-0x651b43df]
> [    0.019716] ACPI: Reserving SSDT table memory at [mem 0x651b43e0-0x651b5163]
> [    0.019717] ACPI: Reserving UEFI table memory at [mem 0x651b5168-0x651b51a9]
> [    0.019717] ACPI: Reserving SSDT table memory at [mem 0x651b51b0-0x651b608d]
> [    0.019718] ACPI: Reserving LPIT table memory at [mem 0x651b6090-0x651b6123]
> [    0.019718] ACPI: Reserving WSMT table memory at [mem 0x651b6128-0x651b614f]
> [    0.019719] ACPI: Reserving SSDT table memory at [mem 0x651b6150-0x651b62b0]
> [    0.019720] ACPI: Reserving SSDT table memory at [mem 0x651b62b8-0x651b6556]
> [    0.019720] ACPI: Reserving SSDT table memory at [mem 0x651b6558-0x651b9559]
> [    0.019721] ACPI: Reserving SSDT table memory at [mem 0x651b9560-0x651b963a]
> [    0.019721] ACPI: Reserving DBGP table memory at [mem 0x651b9640-0x651b9673]
> [    0.019722] ACPI: Reserving DBG2 table memory at [mem 0x651b9678-0x651b96cb]
> [    0.019722] ACPI: Reserving SSDT table memory at [mem 0x651b96d0-0x651b9eac]
> [    0.019723] ACPI: Reserving SSDT table memory at [mem 0x651b9eb0-0x651c23a0]
> [    0.019724] ACPI: Reserving SLIC table memory at [mem 0x651c23a8-0x651c251d]
> [    0.019724] ACPI: Reserving NHLT table memory at [mem 0x651c2520-0x651c254c]
> [    0.019725] ACPI: Reserving BGRT table memory at [mem 0x651c2550-0x651c2587]
> [    0.019725] ACPI: Reserving TPM2 table memory at [mem 0x651c2588-0x651c25bb]
> [    0.019726] ACPI: Reserving ASF! table memory at [mem 0x651c25c0-0x651c265f]
> [    0.019727] ACPI: Reserving DMAR table memory at [mem 0x651c2660-0x651c274f]
> [    0.019844] No NUMA configuration found
> [    0.019844] Faking a node at [mem 0x0000000000000000-0x00000004817fffff]
> [    0.019853] NODE_DATA(0) allocated [mem 0x47cfd5540-0x47cffffff]
> [    0.020051] Zone ranges:
> [    0.020052]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.020053]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.020055]   Normal   [mem 0x0000000100000000-0x00000004817fffff]
> [    0.020056]   Device   empty
> [    0.020056] Movable zone start for each node
> [    0.020058] Early memory node ranges
> [    0.020058]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
> [    0.020060]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
> [    0.020060]   node   0: [mem 0x0000000000100000-0x00000000556aafff]
> [    0.020061]   node   0: [mem 0x00000000556ad000-0x0000000064df3fff]
> [    0.020062]   node   0: [mem 0x000000006ffff000-0x000000006fffffff]
> [    0.020062]   node   0: [mem 0x0000000078000000-0x00000000785fffff]
> [    0.020063]   node   0: [mem 0x0000000100000000-0x00000004817fffff]
> [    0.020065] Initmem setup node 0 [mem 0x0000000000001000-0x00000004817fffff]
> [    0.020070] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.020071] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.020092] On node 0, zone DMA: 98 pages in unavailable ranges
> [    0.022632] On node 0, zone DMA32: 2 pages in unavailable ranges
> [    0.022955] On node 0, zone DMA32: 45579 pages in unavailable ranges
> [    0.023399] On node 0, zone Normal: 31232 pages in unavailable ranges
> [    0.023597] On node 0, zone Normal: 26624 pages in unavailable ranges
> [    0.023605] Reserving Intel graphics memory at [mem 0x7a800000-0x7c7fffff]
> [    0.023795] ACPI: PM-Timer IO Port: 0x1808
> [    0.023800] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.023801] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.023802] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.023802] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.023829] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> [    0.023831] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.023832] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.023835] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.023836] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.023843] e820: update [mem 0x6225f000-0x623ebfff] usable ==> reserved
> [    0.023850] TSC deadline timer available
> [    0.023854] CPU topo: Max. logical packages:   1
> [    0.023854] CPU topo: Max. logical dies:       1
> [    0.023855] CPU topo: Max. dies per package:   1
> [    0.023858] CPU topo: Max. threads per core:   2
> [    0.023858] CPU topo: Num. cores per package:     2
> [    0.023859] CPU topo: Num. threads per package:   4
> [    0.023859] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
> [    0.023878] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.023880] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
> [    0.023882] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x000fffff]
> [    0.023883] PM: hibernation: Registered nosave memory: [mem 0x556ab000-0x556acfff]
> [    0.023884] PM: hibernation: Registered nosave memory: [mem 0x6225f000-0x623ebfff]
> [    0.023886] PM: hibernation: Registered nosave memory: [mem 0x64df4000-0x6fffefff]
> [    0.023887] PM: hibernation: Registered nosave memory: [mem 0x70000000-0x77ffffff]
> [    0.023889] PM: hibernation: Registered nosave memory: [mem 0x78600000-0xffffffff]
> [    0.023890] [mem 0x7c800000-0xfdffffff] available for PCI devices
> [    0.023891] Booting paravirtualized kernel on bare hardware
> [    0.023893] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.028368] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> [    0.028646] percpu: Embedded 75 pages/cpu s270336 r8192 d28672 u524288
> [    0.028653] pcpu-alloc: s270336 r8192 d28672 u524288 alloc=1*2097152
> [    0.028654] pcpu-alloc: [0] 0 1 2 3 
> [    0.028672] Kernel command line: BOOT_IMAGE=/vmlinuz-6.17.0-rc2-00053-gb19a97d57c15 root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep log_buf_len=16M cryptomgr.notests usbcore.quirks=0cf3:e300:e,04f3:2234:e,0c45:670c:e
> [    0.028749] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-6.17.0-rc2-00053-gb19a97d57c15", will be passed to user space.
> [    0.028782] random: crng init done
> [    0.030270] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.031031] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.031084] software IO TLB: area num 4.
> [    0.043485] Fallback order for Node 0: 0 
> [    0.043488] Built 1 zonelists, mobility grouping on.  Total pages: 4090767
> [    0.043489] Policy zone: Normal
> [    0.043496] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> [    0.049539] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.049541] kmemleak: Kernel memory leak detector disabled
> [    0.057071] ftrace: allocating 43857 entries in 172 pages
> [    0.057073] ftrace: allocated 172 pages with 4 groups
> [    0.057795] Dynamic Preempt: voluntary
> [    0.057829] rcu: Preemptible hierarchical RCU implementation.
> [    0.057830] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
> [    0.057831] 	Trampoline variant of Tasks RCU enabled.
> [    0.057831] 	Rude variant of Tasks RCU enabled.
> [    0.057832] 	Tracing variant of Tasks RCU enabled.
> [    0.057832] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.057833] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.057840] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
> [    0.057842] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
> [    0.057843] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
> [    0.061936] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
> [    0.062148] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.062318] Console: colour dummy device 80x25
> [    0.062321] printk: legacy console [tty0] enabled
> [    0.062363] ACPI: Core revision 20250404
> [    0.062513] hpet: HPET dysfunctional in PC10. Force disabled.
> [    0.062566] APIC: Switch to symmetric I/O mode setup
> [    0.062569] DMAR: Host address width 39
> [    0.062570] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> [    0.062577] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> [    0.062579] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> [    0.062582] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> [    0.062584] DMAR: RMRR base: 0x00000064ec2000 end: 0x00000064ee1fff
> [    0.062585] DMAR: RMRR base: 0x0000007a000000 end: 0x0000007c7fffff
> [    0.062586] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
> [    0.062587] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
> [    0.062589] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> [    0.062590] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> [    0.062591] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> [    0.064215] DMAR-IR: Enabled IRQ remapping in x2apic mode
> [    0.064217] x2apic enabled
> [    0.064272] APIC: Switched APIC routing to: cluster x2apic
> [    0.068165] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x29ccd767b87, max_idle_ns: 440795223720 ns
> [    0.068170] Calibrating delay loop (skipped), value calculated using timer frequency.. 5799.77 BogoMIPS (lpj=11599544)
> [    0.068202] CPU0: Thermal monitoring enabled (TM1)
> [    0.068240] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    0.068241] Last level dTLB entries: 4KB 64, 2MB 32, 4MB 32, 1GB 4
> [    0.068245] process: using mwait in idle threads
> [    0.068248] mitigations: Enabled attack vectors: SMT mitigations: off
> [    0.068251] Speculative Store Bypass: Vulnerable
> [    0.068252] SRBDS: Vulnerable
> [    0.068254] Spectre V2 : Vulnerable
> [    0.068255] RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable to RETBleed attacks, data leaks possible!
> [    0.068259] RETBleed: Vulnerable
> [    0.068259] Spectre V2 : User space: Vulnerable
> [    0.068261] MDS: Vulnerable
> [    0.068261] MMIO Stale Data: Vulnerable
> [    0.068262] Spectre V1 : Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers
> [    0.068269] GDS: Vulnerable
> [    0.068273] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.068275] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.068275] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.068276] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> [    0.068277] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> [    0.068278] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.068279] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> [    0.068280] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> [    0.068281] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> [    0.072168] Freeing SMP alternatives memory: 40K
> [    0.072168] pid_max: default: 32768 minimum: 301
> [    0.072168] LSM: initializing lsm=capability,landlock,apparmor,bpf
> [    0.072168] landlock: Up and running.
> [    0.072168] AppArmor: AppArmor initialized
> [    0.072168] LSM support for eBPF active
> [    0.072168] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.072168] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.072168] smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz (family: 0x6, model: 0x8e, stepping: 0x9)
> [    0.072168] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.072168] ... version:                4
> [    0.072168] ... bit width:              48
> [    0.072168] ... generic registers:      4
> [    0.072168] ... value mask:             0000ffffffffffff
> [    0.072168] ... max period:             00007fffffffffff
> [    0.072168] ... fixed-purpose events:   3
> [    0.072168] ... event mask:             000000070000000f
> [    0.072168] signal: max sigframe size: 1616
> [    0.072168] Estimated ratio of average max frequency by base frequency (times 1024): 1235
> [    0.072168] rcu: Hierarchical SRCU implementation.
> [    0.072168] rcu: 	Max phase no-delay instances is 1000.
> [    0.072168] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
> [    0.072168] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.072168] smp: Bringing up secondary CPUs ...
> [    0.072168] smpboot: x86: Booting SMP configuration:
> [    0.072168] .... node  #0, CPUs:      #1 #2 #3
> [    0.072168] smp: Brought up 1 node, 4 CPUs
> [    0.072168] smpboot: Total of 4 processors activated (23199.08 BogoMIPS)
> [    0.092200] node 0 deferred pages initialised in 24ms
> [    0.092206] Memory: 15861792K/16363068K available (14482K kernel code, 2592K rwdata, 10124K rodata, 2916K init, 6164K bss, 490364K reserved, 0K cma-reserved)
> [    0.092623] devtmpfs: initialized
> [    0.092623] x86/mm: Memory block size: 128MB
> [    0.093447] ACPI: PM: Registering ACPI NVS region [mem 0x556ab000-0x556abfff] (4096 bytes)
> [    0.093447] ACPI: PM: Registering ACPI NVS region [mem 0x651c4000-0x6f871fff] (174776320 bytes)
> [    0.096873] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.096873] posixtimers hash table entries: 2048 (order: 3, 32768 bytes, linear)
> [    0.096873] futex hash table entries: 1024 (65536 bytes on 1 NUMA nodes, total 64 KiB, linear).
> [    0.096873] pinctrl core: initialized pinctrl subsystem
> [    0.096873] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.096935] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
> [    0.097043] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.097168] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.097182] audit: initializing netlink subsys (disabled)
> [    0.097201] audit: type=2000 audit(1755711357.000:1): state=initialized audit_enabled=0 res=1
> [    0.097201] thermal_sys: Registered thermal governor 'fair_share'
> [    0.097201] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.097201] thermal_sys: Registered thermal governor 'step_wise'
> [    0.097201] thermal_sys: Registered thermal governor 'user_space'
> [    0.097201] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.097201] cpuidle: using governor ladder
> [    0.097201] cpuidle: using governor menu
> [    0.097201] Simple Boot Flag at 0x47 set to 0x80
> [    0.097201] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.097201] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.097201] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
> [    0.097201] PCI: Using configuration type 1 for base access
> [    0.097201] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.097201] HugeTLB: allocation took 0ms with hugepage_allocation_threads=1
> [    0.097201] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.097201] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> [    0.097201] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.097201] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.097201] ACPI: Added _OSI(Module Device)
> [    0.097201] ACPI: Added _OSI(Processor Device)
> [    0.097201] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.138994] ACPI: 11 ACPI AML tables successfully acquired and loaded
> [    0.141345] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.148938] ACPI: Dynamic OEM Table Load:
> [    0.148944] ACPI: SSDT 0xFFFF9CFB81CAF400 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
> [    0.149794] ACPI: Dynamic OEM Table Load:
> [    0.149799] ACPI: SSDT 0xFFFF9CFB81861800 0006F6 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
> [    0.149801] ACPI: Dynamic OEM Table Load:
> [    0.149801] ACPI: SSDT 0xFFFF9CFB81860000 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
> [    0.150385] ACPI: Dynamic OEM Table Load:
> [    0.150390] ACPI: SSDT 0xFFFF9CFB81D29E00 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
> [    0.152945] ACPI: EC: EC started
> [    0.152946] ACPI: EC: interrupt blocked
> [    0.158105] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
> [    0.158108] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC used to handle transactions
> [    0.158110] ACPI: Interpreter enabled
> [    0.158147] ACPI: PM: (supports S0 S3 S4 S5)
> [    0.158148] ACPI: Using IOAPIC for interrupt routing
> [    0.158186] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.158187] PCI: Using E820 reservations for host bridge windows
> [    0.158728] ACPI: Enabled 8 GPEs in block 00 to 7F
> [    0.162009] ACPI: \_SB_.PCI0.RP09.PXSX.WRST: New power resource
> [    0.162283] ACPI: \_SB_.PCI0.RP10.PXSX.WRST: New power resource
> [    0.162554] ACPI: \_SB_.PCI0.RP11.PXSX.WRST: New power resource
> [    0.162825] ACPI: \_SB_.PCI0.RP12.PXSX.WRST: New power resource
> [    0.163092] ACPI: \_SB_.PCI0.RP13.PXSX.WRST: New power resource
> [    0.163360] ACPI: \_SB_.PCI0.RP01.PXSX.WRST: New power resource
> [    0.164021] ACPI: \_SB_.PCI0.RP02.PXSX.WRST: New power resource
> [    0.164296] ACPI: \_SB_.PCI0.RP03.PXSX.WRST: New power resource
> [    0.164565] ACPI: \_SB_.PCI0.RP04.PXSX.WRST: New power resource
> [    0.164833] ACPI: \_SB_.PCI0.RP05.PXSX.WRST: New power resource
> [    0.165101] ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New power resource
> [    0.165372] ACPI: \_SB_.PCI0.RP07.PXSX.WRST: New power resource
> [    0.165641] ACPI: \_SB_.PCI0.RP08.PXSX.WRST: New power resource
> [    0.165909] ACPI: \_SB_.PCI0.RP17.PXSX.WRST: New power resource
> [    0.168176] ACPI: \_SB_.PCI0.RP18.PXSX.WRST: New power resource
> [    0.168176] ACPI: \_SB_.PCI0.RP19.PXSX.WRST: New power resource
> [    0.168176] ACPI: \_SB_.PCI0.RP20.PXSX.WRST: New power resource
> [    0.168176] ACPI: \_SB_.PCI0.RP14.PXSX.WRST: New power resource
> [    0.168176] ACPI: \_SB_.PCI0.RP15.PXSX.WRST: New power resource
> [    0.168399] ACPI: \_SB_.PCI0.RP16.PXSX.WRST: New power resource
> [    0.189541] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> [    0.189547] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.189710] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME]
> [    0.190011] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability LTR]
> [    0.190012] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    0.190781] PCI host bridge to bus 0000:00
> [    0.190784] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.190786] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.190788] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
> [    0.190790] pci_bus 0000:00: root bus resource [mem 0x7c800000-0xdfffffff window]
> [    0.190791] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> [    0.190792] pci_bus 0000:00: root bus resource [bus 00-fe]
> [    0.190807] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000 conventional PCI endpoint
> [    0.190881] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
> [    0.190895] pci 0000:00:02.0: BAR 0 [mem 0xdb000000-0xdbffffff 64bit]
> [    0.190897] pci 0000:00:02.0: BAR 2 [mem 0x90000000-0x9fffffff 64bit pref]
> [    0.190898] pci 0000:00:02.0: BAR 4 [io  0xf000-0xf03f]
> [    0.190909] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.191041] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000 conventional PCI endpoint
> [    0.191057] pci 0000:00:04.0: BAR 0 [mem 0xdc420000-0xdc427fff 64bit]
> [    0.191303] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330 conventional PCI endpoint
> [    0.191335] pci 0000:00:14.0: BAR 0 [mem 0xdc410000-0xdc41ffff 64bit]
> [    0.191368] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.191845] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000 conventional PCI endpoint
> [    0.191876] pci 0000:00:14.2: BAR 0 [mem 0xdc434000-0xdc434fff 64bit]
> [    0.192005] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000 conventional PCI endpoint
> [    0.192059] pci 0000:00:15.0: BAR 0 [mem 0xdc433000-0xdc433fff 64bit]
> [    0.192371] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000 conventional PCI endpoint
> [    0.192411] pci 0000:00:15.1: BAR 0 [mem 0xdc432000-0xdc432fff 64bit]
> [    0.192693] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000 conventional PCI endpoint
> [    0.192723] pci 0000:00:16.0: BAR 0 [mem 0xdc431000-0xdc431fff 64bit]
> [    0.192752] pci 0000:00:16.0: PME# supported from D3hot
> [    0.193063] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root Port
> [    0.193081] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
> [    0.193086] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [    0.193094] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    0.193144] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.193548] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400 PCIe Root Port
> [    0.193563] pci 0000:00:1c.4: PCI bridge to [bus 3a]
> [    0.193568] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
> [    0.193618] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    0.194012] pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060400 PCIe Root Port
> [    0.194029] pci 0000:00:1c.5: PCI bridge to [bus 3b]
> [    0.194033] pci 0000:00:1c.5:   bridge window [mem 0xdc300000-0xdc3fffff]
> [    0.194083] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
> [    0.194479] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400 PCIe Root Port
> [    0.194496] pci 0000:00:1d.0: PCI bridge to [bus 3c]
> [    0.194500] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
> [    0.194550] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.194971] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100 conventional PCI endpoint
> [    0.195240] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000 conventional PCI endpoint
> [    0.195276] pci 0000:00:1f.2: BAR 0 [mem 0xdc42c000-0xdc42ffff]
> [    0.195466] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040380 conventional PCI endpoint
> [    0.195509] pci 0000:00:1f.3: BAR 0 [mem 0xdc428000-0xdc42bfff 64bit]
> [    0.195515] pci 0000:00:1f.3: BAR 4 [mem 0xdc400000-0xdc40ffff 64bit]
> [    0.195554] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> [    0.196123] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500 conventional PCI endpoint
> [    0.196254] pci 0000:00:1f.4: BAR 0 [mem 0xdc430000-0xdc4300ff 64bit]
> [    0.196265] pci 0000:00:1f.4: BAR 4 [io  0xf040-0xf05f]
> [    0.196545] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
> [    0.196984] pci 0000:3a:00.0: [168c:003e] type 00 class 0x028000 PCIe Endpoint
> [    0.197427] pci 0000:3a:00.0: BAR 0 [mem 0xdc000000-0xdc1fffff 64bit]
> [    0.198406] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
> [    0.199770] pci 0000:00:1c.4: PCI bridge to [bus 3a]
> [    0.199869] pci 0000:3b:00.0: [10ec:525a] type 00 class 0xff0000 PCIe Endpoint
> [    0.199915] pci 0000:3b:00.0: BAR 1 [mem 0xdc300000-0xdc300fff]
> [    0.199998] pci 0000:3b:00.0: supports D1 D2
> [    0.199999] pci 0000:3b:00.0: PME# supported from D1 D2 D3hot D3cold
> [    0.200343] pci 0000:00:1c.5: PCI bridge to [bus 3b]
> [    0.200439] pci 0000:3c:00.0: [1c5c:1284] type 00 class 0x010802 PCIe Endpoint
> [    0.200479] pci 0000:3c:00.0: BAR 0 [mem 0xdc200000-0xdc203fff 64bit]
> [    0.200561] pci 0000:3c:00.0: PME# supported from D0 D1 D3hot
> [    0.200882] pci 0000:00:1d.0: PCI bridge to [bus 3c]
> [    0.203913] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
> [    0.203913] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> [    0.203913] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> [    0.203913] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> [    0.203913] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
> [    0.203913] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
> [    0.203913] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
> [    0.203913] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
> [    0.212353] ACPI: EC: interrupt unblocked
> [    0.212355] ACPI: EC: event unblocked
> [    0.212361] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
> [    0.212362] ACPI: EC: GPE=0x14
> [    0.212363] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC initialization complete
> [    0.212365] ACPI: \_SB_.PCI0.LPCB.ECDV: EC: Used to handle transactions and events
> [    0.212458] iommu: Default domain type: Translated
> [    0.212458] iommu: DMA domain TLB invalidation policy: lazy mode
> [    0.212601] pps_core: LinuxPPS API ver. 1 registered
> [    0.212603] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.212607] PTP clock support registered
> [    0.212619] EDAC MC: Ver: 3.0.0
> [    0.212850] efivars: Registered efivars operations
> [    0.212850] NetLabel: Initializing
> [    0.212850] NetLabel:  domain hash size = 128
> [    0.212850] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.212850] NetLabel:  unlabeled traffic allowed by default
> [    0.212850] PCI: Using ACPI for IRQ routing
> [    0.238751] PCI: pci_cache_line_size set to 64 bytes
> [    0.239093] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
> [    0.239095] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
> [    0.239096] e820: reserve RAM buffer [mem 0x556ab000-0x57ffffff]
> [    0.239098] e820: reserve RAM buffer [mem 0x6225f000-0x63ffffff]
> [    0.239099] e820: reserve RAM buffer [mem 0x64df4000-0x67ffffff]
> [    0.239100] e820: reserve RAM buffer [mem 0x78600000-0x7bffffff]
> [    0.239100] e820: reserve RAM buffer [mem 0x481800000-0x483ffffff]
> [    0.240178] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.240178] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.240178] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.240181] vgaarb: loaded
> [    0.240275] clocksource: Switched to clocksource tsc-early
> [    0.240421] VFS: Disk quotas dquot_6.6.0
> [    0.240428] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.240444] AppArmor: AppArmor Filesystem Enabled
> [    0.240444] pnp: PnP ACPI init
> [    0.240652] system 00:00: [io  0x0680-0x069f] has been reserved
> [    0.240655] system 00:00: [io  0xffff] has been reserved
> [    0.240656] system 00:00: [io  0xffff] has been reserved
> [    0.240658] system 00:00: [io  0xffff] has been reserved
> [    0.240659] system 00:00: [io  0x1800-0x18fe] could not be reserved
> [    0.240660] system 00:00: [io  0x164e-0x164f] has been reserved
> [    0.241120] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
> [    0.241122] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.241124] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.241125] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
> [    0.241127] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.241128] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reserved
> [    0.241130] system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    0.241131] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
> [    0.241133] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reserved
> [    0.241135] system 00:04: [mem 0xdffe0000-0xdfffffff] has been reserved
> [    0.241173] system 00:05: [mem 0xfd000000-0xfdabffff] has been reserved
> [    0.241175] system 00:05: [mem 0xfdad0000-0xfdadffff] has been reserved
> [    0.241176] system 00:05: [mem 0xfdb00000-0xfdffffff] has been reserved
> [    0.241178] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reserved
> [    0.241179] system 00:05: [mem 0xfe036000-0xfe03bfff] has been reserved
> [    0.241181] system 00:05: [mem 0xfe03d000-0xfe3fffff] has been reserved
> [    0.241182] system 00:05: [mem 0xfe410000-0xfe7fffff] has been reserved
> [    0.241444] system 00:06: [io  0xff00-0xfffe] has been reserved
> [    0.242419] system 00:07: [mem 0xfe029000-0xfe029fff] has been reserved
> [    0.242421] system 00:07: [mem 0xfe028000-0xfe028fff] has been reserved
> [    0.246285] pnp: PnP ACPI: found 8 devices
> [    0.252095] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.252143] NET: Registered PF_INET protocol family
> [    0.252266] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.263565] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    0.263586] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.263660] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.263857] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
> [    0.264052] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.264120] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
> [    0.264188] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
> [    0.264253] UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, linear)
> [    0.264326] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.264333] NET: Registered PF_XDP protocol family
> [    0.264342] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01-39] add_size 1000
> [    0.264360] pci 0000:00:1c.0: bridge window [io  0x2000-0x2fff]: assigned
> [    0.264362] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
> [    0.264365] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
> [    0.264368] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [    0.264370] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    0.264375] pci 0000:00:1c.4: PCI bridge to [bus 3a]
> [    0.264378] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
> [    0.264383] pci 0000:00:1c.5: PCI bridge to [bus 3b]
> [    0.264385] pci 0000:00:1c.5:   bridge window [mem 0xdc300000-0xdc3fffff]
> [    0.264390] pci 0000:00:1d.0: PCI bridge to [bus 3c]
> [    0.264393] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
> [    0.264398] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.264399] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.264400] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000dffff window]
> [    0.264401] pci_bus 0000:00: resource 7 [mem 0x7c800000-0xdfffffff window]
> [    0.264403] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
> [    0.264404] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
> [    0.264405] pci_bus 0000:01: resource 1 [mem 0xc4000000-0xda0fffff]
> [    0.264406] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    0.264407] pci_bus 0000:3a: resource 1 [mem 0xdc000000-0xdc1fffff]
> [    0.264408] pci_bus 0000:3b: resource 1 [mem 0xdc300000-0xdc3fffff]
> [    0.264409] pci_bus 0000:3c: resource 1 [mem 0xdc200000-0xdc2fffff]
> [    0.264958] PCI: CLS 0 bytes, default 64
> [    0.265000] pci 0000:00:1f.1: [8086:9d20] type 00 class 0x058000 conventional PCI endpoint
> [    0.265138] pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
> [    0.265268] DMAR: ACPI device "device:79" under DMAR at fed91000 as 00:15.0
> [    0.265271] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:15.1
> [    0.265297] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.265298] software IO TLB: mapped [mem 0x000000005e25f000-0x000000006225f000] (64MB)
> [    0.265342] Unpacking initramfs...
> [    0.265349] sgx: EPC section 0x70200000-0x75f7ffff
> [    0.266041] sgx: SGX disabled: SGX launch control CPU feature is not available, /dev/sgx_enclave disabled.
> [    0.266683] Initialise system trusted keyrings
> [    0.266695] Key type blacklist registered
> [    0.266846] workingset: timestamp_bits=36 max_order=22 bucket_order=0
> [    0.267158] fuse: init (API version 7.44)
> [    0.267525] Key type asymmetric registered
> [    0.267531] Asymmetric key parser 'x509' registered
> [    0.267592] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
> [    0.267652] io scheduler mq-deadline registered
> [    0.273931] Memory allocation profiling is not supported!
> [    0.281915] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.285524] thermal LNXTHERM:00: registered as thermal_zone0
> [    0.285528] ACPI: thermal: Thermal Zone [THM] (25 C)
> [    0.285752] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.286545] hpet_acpi_add: no address or irqs in _CRS
> [    0.298528] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
> [    0.305099] Freeing initrd memory: 16812K
> [    0.332423] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    0.332694] i8042: Warning: Keylock active
> [    0.334873] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.334878] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    0.334976] mousedev: PS/2 mouse device common for all mice
> [    0.335014] rtc_cmos 00:01: RTC can wake from S4
> [    0.335825] rtc_cmos 00:01: registered as rtc0
> [    0.335992] rtc_cmos 00:01: setting system clock to 2025-08-20T17:35:58 UTC (1755711358)
> [    0.336014] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
> [    0.336159] intel_pstate: Intel P-state driver initializing
> [    0.336194] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    0.337788] intel_pstate: HWP enabled
> [    0.338053] efifb: probing for efifb
> [    0.338063] efifb: framebuffer at 0x90000000, using 22500k, total 22500k
> [    0.338064] efifb: mode is 3200x1800x32, linelength=12800, pages=1
> [    0.338066] efifb: scrolling: redraw
> [    0.338066] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    0.338189] Console: switching to colour frame buffer device 200x56
> [    0.340867] fb0: EFI VGA frame buffer device
> [    0.340992] NET: Registered PF_INET6 protocol family
> [    0.341259] Segment Routing with IPv6
> [    0.341265] In-situ OAM (IOAM) with IPv6
> [    0.341280] mip6: Mobile IPv6
> [    0.341282] NET: Registered PF_PACKET protocol family
> [    0.341327] mpls_gso: MPLS GSO support
> [    0.341800] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.341826] microcode: Current revision: 0x000000f6
> [    0.341828] microcode: Updated early from: 0x000000f0
> [    0.341870] IPI shorthand broadcast: enabled
> [    0.342969] sched_clock: Marking stable (336001321, 5894112)->(353403100, -11507667)
> [    0.343070] registered taskstats version 1
> [    0.343150] Loading compiled-in X.509 certificates
> [    0.344814] Demotion targets for Node 0: null
> [    0.344869] Key type .fscrypt registered
> [    0.344870] Key type fscrypt-provisioning registered
> [    0.357198] Key type encrypted registered
> [    0.357202] AppArmor: AppArmor sha256 policy hashing enabled
> [    0.357314] RAS: Correctable Errors collector initialized.
> [    0.360327] clk: Disabling unused clocks
> [    0.361188] Freeing unused decrypted memory: 2036K
> [    0.361638] Freeing unused kernel image (initmem) memory: 2916K
> [    0.361666] Write protecting the kernel read-only data: 26624k
> [    0.362218] Freeing unused kernel image (text/rodata gap) memory: 1900K
> [    0.362265] Freeing unused kernel image (rodata/data gap) memory: 116K
> [    0.373332] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    0.373337] Run /init as init process
> [    0.373338]   with arguments:
> [    0.373340]     /init
> [    0.373341]   with environment:
> [    0.373341]     HOME=/
> [    0.373342]     TERM=linux
> [    0.373343]     BOOT_IMAGE=/vmlinuz-6.17.0-rc2-00053-gb19a97d57c15
> [    0.526764] input: Intel HID events as /devices/platform/INT33D5:00/input/input2
> [    0.527004] intel-hid INT33D5:00: platform supports 5 button array
> [    0.528541] input: Intel HID 5 button array as /devices/platform/INT33D5:00/input/input3
> [    0.529033] nvme nvme0: pci function 0000:3c:00.0
> [    0.529119] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQBC data block query control method not found
> [    0.547612] nvme nvme0: 4/0/0 default/read/poll queues
> [    0.548340] input: PC Speaker as /devices/platform/pcspkr/input/input4
> [    0.573466]  nvme0n1: p1 p2 p3 p4
> [    0.586436] input: Dell WMI hotkeys as /devices/platform/PNP0C14:01/wmi_bus/wmi_bus-PNP0C14:01/9DBB5994-A997-11DA-B012-B622A1EF5492-3/input/input5
> [    0.608365] device-mapper: uevent: version 1.0.3
> [    0.608642] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
> [    1.282185] tsc: Refined TSC clocksource calibration: 2904.008 MHz
> [    1.282205] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc0d988f1, max_idle_ns: 440795328788 ns
> [    1.282276] clocksource: Switched to clocksource tsc
> [   16.318461] PM: Image not found (code -22)
> [   16.391885] EXT4-fs (dm-0): mounted filesystem 32e29882-d94d-4a92-9ee4-4d03002bfa29 ro with ordered data mode. Quota mode: none.
> [   16.506625] systemd[1]: Inserted module 'autofs4'
> [   16.551548] systemd[1]: systemd 258~rc2-2 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
> [   16.551565] systemd[1]: Detected architecture x86-64.
> [   16.554999] systemd[1]: Hostname set to <abreu>.
> [   16.698504] systemd[1]: bpf-restrict-fs: LSM BPF program attached
> [   16.735132] systemd-sysv-generator[335]: SysV service '/etc/init.d/xl2tpd' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> [   16.735137] systemd-sysv-generator[335]: Please update package to include a native systemd unit file.
> [   16.735139] systemd-sysv-generator[335]: ! This compatibility logic is deprecated, expect removal soon. !
> [   16.874857] systemd[1]: Queued start job for default target graphical.target.
> [   16.916911] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
> [   16.918143] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
> [   16.919085] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
> [   16.919999] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
> [   16.920595] systemd[1]: Created slice user.slice - User and Session Slice.
> [   16.920760] systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
> [   16.920881] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
> [   16.921327] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
> [   16.921389] systemd[1]: Expecting device dev-disk-by\x2ddiskseq-1\x2dpart4.device - /dev/disk/by-diskseq/1-part4...
> [   16.921417] systemd[1]: Expecting device dev-disk-by\x2duuid-2d23fd4c\x2d5d03\x2d4e1a\x2d8a42\x2d0e859d1f00d8.device - /dev/disk/by-uuid/2d23fd4c-5d03-4e1a-8a42-0e859d1f00d8...
> [   16.921440] systemd[1]: Expecting device dev-disk-by\x2duuid-61be8f50\x2d69c5\x2d49a5\x2dbcad\x2d3f4521e9c7b5.device - /dev/disk/by-uuid/61be8f50-69c5-49a5-bcad-3f4521e9c7b5...
> [   16.921456] systemd[1]: Expecting device dev-disk-by\x2duuid-96BD\x2d5653.device - /dev/disk/by-uuid/96BD-5653...
> [   16.921525] systemd[1]: Reached target imports.target - Image Downloads.
> [   16.921562] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
> [   16.921631] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
> [   16.921684] systemd[1]: Reached target paths.target - Path Units.
> [   16.921733] systemd[1]: Reached target remote-fs.target - Remote File Systems.
> [   16.921763] systemd[1]: Reached target slices.target - Slice Units.
> [   16.921852] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
> [   16.925207] systemd[1]: Listening on systemd-ask-password.socket - Query the User Interactively for a Password.
> [   16.928764] systemd[1]: Listening on systemd-coredump.socket - Process Core Dump Socket.
> [   16.930976] systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
> [   16.934048] systemd[1]: Listening on systemd-factory-reset.socket - Factory Reset Management.
> [   16.934327] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
> [   16.934570] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
> [   16.934677] systemd[1]: systemd-oomd.socket - Userspace Out-Of-Memory (OOM) Killer Socket was skipped because of an unmet condition check (ConditionPathExists=/proc/pressure/memory).
> [   16.934775] systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   16.934831] systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   16.935031] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
> [   16.935192] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
> [   16.935406] systemd[1]: Listening on systemd-udevd-varlink.socket - udev Varlink Socket.
> [   16.937662] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
> [   16.939864] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
> [   16.942545] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
> [   16.946055] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
> [   16.952183] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
> [   16.955548] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
> [   16.958282] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
> [   16.963403] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
> [   16.963458] systemd[1]: modprobe@fuse.service - Load Kernel Module fuse was skipped because of an unmet condition check (ConditionKernelModuleLoaded=!fuse).
> [   16.966017] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
> [   16.966147] systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
> [   16.968426] systemd[1]: Starting systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info...
> [   16.973998] systemd[1]: Starting systemd-journald.service - Journal Service...
> [   16.982346] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
> [   16.982383] systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   16.985045] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
> [   16.985129] systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   16.990006] systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
> [   16.991059] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
> [   16.995749] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
> [   16.995861] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
> [   16.995951] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
> [   16.996037] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
> [   16.998012] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
> [   16.999017] systemd[1]: modprobe@configfs.service: Deactivated successfully.
> [   16.999255] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
> [   16.999450] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
> [   17.008200] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
> [   17.009718] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
> [   17.009781] pstore: Using crash dump compression: deflate
> [   17.014872] systemd[1]: Finished systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info.
> [   17.018184] ACPI: bus type drm_connector registered
> [   17.019757] systemd[1]: modprobe@drm.service: Deactivated successfully.
> [   17.020034] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
> [   17.023611] pstore: Registered efi_pstore as persistent store backend
> [   17.024986] systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
> [   17.026205] lp: driver loaded but no devices found
> [   17.026637] systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
> [   17.026922] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
> [   17.031122] EXT4-fs (dm-0): re-mounted 32e29882-d94d-4a92-9ee4-4d03002bfa29 r/w.
> [   17.033162] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
> [   17.033580] ppdev: user-space parallel port driver
> [   17.034087] systemd[1]: Finished systemd-udev-load-credentials.service - Load udev Rules from Credentials.
> [   17.035426] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
> [   17.035507] systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
> [   17.036751] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
> [   17.036792] systemd[1]: systemd-tpm2-setup.service - TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   17.038666] systemd-journald[349]: Collecting audit messages is disabled.
> [   17.047700] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
> [   17.047888] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
> [   17.049509] systemd[1]: Starting systemd-timesyncd.service - Network Time Synchronization...
> [   17.052027] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
> [   17.052484] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
> [   17.058075] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
> [   17.059616] systemd[1]: Finished systemd-random-seed.service - Load/Save OS Random Seed.
> [   17.069724] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
> [   17.071699] systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
> [   17.097209] systemd[1]: Started systemd-journald.service - Journal Service.
> [   17.123896] systemd-journald[349]: Received client request to flush runtime journal.
> [   17.314026] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input20
> [   17.331153] ACPI: bus type USB registered
> [   17.331204] usbcore: registered new interface driver usbfs
> [   17.331216] usbcore: registered new interface driver hub
> [   17.331232] usbcore: registered new device driver usb
> [   17.333943] ACPI: button: Lid Switch [LID0]
> [   17.334028] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input21
> [   17.334588] ACPI: button: Power Button [PBTN]
> [   17.334691] ACPI: AC: AC Adapter [AC] (off-line)
> [   17.341576] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input22
> [   17.343472] ACPI: button: Sleep Button [SBTN]
> [   17.343561] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input23
> [   17.344260] ACPI: button: Power Button [PWRF]
> [   17.389026] ACPI: battery: Slot [BAT0] (battery present)
> [   17.408362] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [   17.410542] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [   17.411692] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
> [   17.417530] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [   17.417539] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [   17.417544] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [   17.417586] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
> [   17.417591] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [   17.417595] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   17.417597] usb usb1: Product: xHCI Host Controller
> [   17.417599] usb usb1: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [   17.417601] usb usb1: SerialNumber: 0000:00:14.0
> [   17.420395] intel_pmc_core INT33A1:00:  initialized
> [   17.420488] input: Intel Virtual Buttons as /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/INT33D6:00/input/input24
> [   17.439722] hub 1-0:1.0: USB hub found
> [   17.439751] hub 1-0:1.0: 12 ports detected
> [   17.451796] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [   17.451802] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   17.451804] usb usb2: Product: xHCI Host Controller
> [   17.451806] usb usb2: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [   17.451808] usb usb2: SerialNumber: 0000:00:14.0
> [   17.455295] intel_rapl_common: Found RAPL domain package
> [   17.455299] intel_rapl_common: Found RAPL domain dram
> [   17.491445] hub 2-0:1.0: USB hub found
> [   17.491470] hub 2-0:1.0: 6 ports detected
> [   17.504372] hid: raw HID events driver (C) Jiri Kosina
> [   17.505509] Adding 8387904k swap on /dev/nvme0n1p4.  Priority:-2 extents:1 across:8387904k SS
> [   17.697937] usb 1-3: new full-speed USB device number 2 using xhci_hcd
> [   17.835058] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [   17.835064] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [   17.841226] rtsx_pci 0000:3b:00.0: enabling device (0000 -> 0002)
> [   17.843878] stackdepot: allocating hash table of 1048576 entries via kvcalloc
> [   17.846795] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> [   17.847120] stackdepot: allocating space for 8192 stack pools via kvcalloc
> [   17.847152] i915 0000:00:02.0: [drm] Found kabylake/ult (device ID 5916) integrated display version 9.00 stepping B0
> [   17.847891] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [   17.847920] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [   17.848346] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [   17.849036] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> [   17.852653] Console: switching to colour dummy device 80x25
> [   17.853156] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   17.875937] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> [   17.876183] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [   17.889002] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   17.892221] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> [   17.901253] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   17.905819] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   17.906088] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> [   17.907664] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
> [   17.924020] intel_rapl_common: Found RAPL domain package
> [   17.924025] intel_rapl_common: Found RAPL domain core
> [   17.924026] intel_rapl_common: Found RAPL domain uncore
> [   17.924028] intel_rapl_common: Found RAPL domain dram
> [   17.924030] intel_rapl_common: Found RAPL domain psys
> [   17.962755] usb 1-4: new full-speed USB device number 3 using xhci_hcd
> [   18.005535] iTCO_vendor_support: vendor-support=0
> [   18.009492] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [   18.014430] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
> [   18.023578] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [   18.025095] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input26
> [   18.031385] EXT4-fs (nvme0n1p2): mounted filesystem 2d23fd4c-5d03-4e1a-8a42-0e859d1f00d8 r/w with ordered data mode. Quota mode: none.
> [   18.050218] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
> [   18.050223] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [   18.050225] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   18.050226] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   18.050227] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [   18.050229] RAPL PMU: hw unit of domain psys 2^-14 Joules
> [   18.051618] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
> [   18.052611] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [   18.092721] ACPI: battery: new hook: Dell Primary Battery Extension
> [   18.104050] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [   18.104057] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [   18.104060] usb 1-4: Product: Touchscreen
> [   18.104063] usb 1-4: Manufacturer: ELAN
> [   18.182979] input: DLL075B:01 06CB:76AF Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input27
> [   18.184881] input: DLL075B:01 06CB:76AF Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input28
> [   18.188952] hid-generic 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
> [   18.214260] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
> [   18.217634] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
> [   18.225916] usb 1-5: new high-speed USB device number 4 using xhci_hcd
> [   18.226723] audit: type=1400 audit(1755711376.386:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="1password" pid=507 comm="apparmor_parser"
> [   18.226728] audit: type=1400 audit(1755711376.386:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=509 comm="apparmor_parser"
> [   18.226730] audit: type=1400 audit(1755711376.386:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=510 comm="apparmor_parser"
> [   18.226972] audit: type=1400 audit(1755711376.386:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="Discord" pid=508 comm="apparmor_parser"
> [   18.230451] audit: type=1400 audit(1755711376.390:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=512 comm="apparmor_parser"
> [   18.231200] audit: type=1400 audit(1755711376.390:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=513 comm="apparmor_parser"
> [   18.231639] audit: type=1400 audit(1755711376.390:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=514 comm="apparmor_parser"
> [   18.233224] audit: type=1400 audit(1755711376.390:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=515 comm="apparmor_parser"
> [   18.233731] audit: type=1400 audit(1755711376.390:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="cam" pid=516 comm="apparmor_parser"
> [   18.234640] audit: type=1400 audit(1755711376.394:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-run" pid=518 comm="apparmor_parser"
> [   18.281060] input: DLL075B:01 06CB:76AF Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input30
> [   18.281386] input: DLL075B:01 06CB:76AF Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input31
> [   18.281514] hid-multitouch 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
> [   18.348947] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
> [   18.349573] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
> [   18.386554] snd_hda_codec_alc269 hdaudioC0D0: ALC3246: picked fixup  (pin match)
> [   18.423300] snd_hda_codec_alc269 hdaudioC0D0: autoconfig for ALC3246: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   18.423308] snd_hda_codec_alc269 hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   18.423311] snd_hda_codec_alc269 hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [   18.423314] snd_hda_codec_alc269 hdaudioC0D0:    mono: mono_out=0x0
> [   18.423315] snd_hda_codec_alc269 hdaudioC0D0:    inputs:
> [   18.423318] snd_hda_codec_alc269 hdaudioC0D0:      Internal Mic=0x12
> [   18.423320] snd_hda_codec_alc269 hdaudioC0D0:      Headset Mic=0x19
> [   18.423322] snd_hda_codec_alc269 hdaudioC0D0:      Headphone Mic=0x1a
> [   18.460586] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
> [   18.460595] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
> [   18.460684] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
> [   18.477381] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [   18.477394] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [   18.477397] usb 1-5: Product: Integrated_Webcam_HD
> [   18.477400] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [   18.538947] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
> [   18.542446] mc: Linux media interface: v0.10
> [   18.550582] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input34
> [   18.553940] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input35
> [   18.554864] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input36
> [   18.556217] hid-multitouch 0003:04F3:2234.0002: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [   18.556276] usbcore: registered new interface driver usbhid
> [   18.556280] usbhid: USB HID core driver
> [   18.619083] videodev: Linux video capture interface: v2.00
> [   18.619133] Bluetooth: Core ver 2.22
> [   18.619153] NET: Registered PF_BLUETOOTH protocol family
> [   18.619155] Bluetooth: HCI device and connection manager initialized
> [   18.619159] Bluetooth: HCI socket layer initialized
> [   18.619162] Bluetooth: L2CAP socket layer initialized
> [   18.619167] Bluetooth: SCO socket layer initialized
> [   18.631118] usbcore: registered new interface driver btusb
> [   18.634021] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [   18.634027] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [   18.647958] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
> [   18.676293] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [   18.689824] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input33
> [   18.689918] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input38
> [   18.689990] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input39
> [   18.690061] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input40
> [   18.690125] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input41
> [   18.722868] ath: EEPROM regdomain: 0x6c
> [   18.722873] ath: EEPROM indicates we should expect a direct regpair map
> [   18.722875] ath: Country alpha2 being used: 00
> [   18.722877] ath: Regpair used: 0x6c
> [   18.735096] nvme nvme0: using unchecked data buffer
> [   18.750909] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
> [   18.992485] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [   19.015579] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [   19.461801] usbcore: registered new interface driver uvcvideo
> [   22.044808] rfkill: input handler disabled
> [   28.436838] rfkill: input handler enabled
> [   31.526378] rfkill: input handler disabled
> [   33.837138] SCSI subsystem initialized
> [   87.859730] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [   87.859787] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [   87.859806] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [   87.859827] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [   87.859850] pci 0000:01:00.0: enabling Extended Tags
> [   87.860288] pci 0000:01:00.0: supports D1 D2
> [   87.860292] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   87.896335] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [   87.934594] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [   87.934657] pci 0000:02:00.0: PCI bridge to [bus 03]
> [   87.934679] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [   87.934727] pci 0000:02:00.0: enabling Extended Tags
> [   87.934898] pci 0000:02:00.0: supports D1 D2
> [   87.934906] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   87.935493] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [   87.935552] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [   87.935574] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [   87.935598] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [   87.935629] pci 0000:02:01.0: enabling Extended Tags
> [   87.935806] pci 0000:02:01.0: supports D1 D2
> [   87.935813] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   87.936328] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [   87.936387] pci 0000:02:02.0: PCI bridge to [bus 39]
> [   87.936409] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [   87.936456] pci 0000:02:02.0: enabling Extended Tags
> [   87.936627] pci 0000:02:02.0: supports D1 D2
> [   87.936635] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   87.937202] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [   87.937358] pci 0000:02:00.0: PCI bridge to [bus 03]
> [   87.937558] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [   87.937813] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [   87.937984] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [   87.938023] pci 0000:39:00.0: enabling Extended Tags
> [   87.938221] pci 0000:39:00.0: supports D1 D2
> [   87.938228] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   87.938963] pci 0000:02:02.0: PCI bridge to [bus 39]
> [   87.939041] pci_bus 0000:02: Allocating resources
> [   87.939075] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [   87.939088] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [   87.939099] pci 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [   87.939113] pci 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [   87.939122] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [   87.939134] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [   87.939148] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [   87.939156] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [   87.939165] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [   87.939172] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [   87.939189] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [   87.939197] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [   87.939205] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [   87.939211] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [   87.939217] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [   87.939224] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [   87.939235] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [   87.939243] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [   87.939251] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [   87.939258] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [   87.939266] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [   87.939273] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [   87.939282] pci 0000:02:00.0: PCI bridge to [bus 03]
> [   87.939296] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [   87.939316] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [   87.939328] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [   87.939339] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [   87.939355] pci 0000:02:02.0: PCI bridge to [bus 39]
> [   87.939368] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [   87.939386] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [   87.939399] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [   87.939410] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [   87.941284] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [   87.941307] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [   87.942494] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [   87.943568] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [   87.943584] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [   87.943597] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [   87.943712] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [   87.943723] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   87.943730] usb usb3: Product: xHCI Host Controller
> [   87.943736] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [   87.943742] usb usb3: SerialNumber: 0000:39:00.0
> [   87.944279] hub 3-0:1.0: USB hub found
> [   87.944308] hub 3-0:1.0: 2 ports detected
> [   87.967886] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [   87.967904] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   87.967912] usb usb4: Product: xHCI Host Controller
> [   87.967919] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [   87.967925] usb usb4: SerialNumber: 0000:39:00.0
> [   87.969244] hub 4-0:1.0: USB hub found
> [   87.969279] hub 4-0:1.0: 2 ports detected
> [   87.976388] pci_bus 0000:02: Allocating resources
> [   87.976434] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [   87.976452] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [   87.976464] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [   87.976478] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [   87.976488] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [   87.976501] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [   87.976514] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [   87.976521] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [   87.976529] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [   87.976535] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [   87.976552] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [   87.976560] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [   87.976567] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [   87.976573] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [   87.976580] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [   87.976586] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [   87.976597] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [   87.976605] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [   87.976612] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [   87.976618] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [   87.976625] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [   87.976632] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [   88.226118] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [   88.364925] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [   88.364944] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   88.364951] usb 3-1: Product: USB2.0 Hub             
> [   88.364957] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [   88.364962] usb 3-1: SerialNumber: 000000000
> [   88.366988] hub 3-1:1.0: USB hub found
> [   88.368203] hub 3-1:1.0: 5 ports detected
> [   88.492015] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [   88.538066] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [   88.538085] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   88.538092] usb 4-1: Product: USB3.0 Hub             
> [   88.538098] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [   88.538103] usb 4-1: SerialNumber: 000000000
> [   88.541833] hub 4-1:1.0: USB hub found
> [   88.541975] hub 4-1:1.0: 4 ports detected
> [   89.105992] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [   89.244649] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [   89.244670] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   89.244679] usb 3-1.1: Product: USB2.0 Hub             
> [   89.244686] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [   89.244692] usb 3-1.1: SerialNumber: 000000000
> [   89.247673] hub 3-1.1:1.0: USB hub found
> [   89.247862] hub 3-1.1:1.0: 4 ports detected
> [   89.341250] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [   89.400934] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [   89.400953] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   89.400963] usb 4-1.1: Product: USB3.0 Hub             
> [   89.400970] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [   89.400976] usb 4-1.1: SerialNumber: 000000000
> [   89.407024] hub 4-1.1:1.0: USB hub found
> [   89.407237] hub 4-1.1:1.0: 4 ports detected
> [   89.582291] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [   89.601601] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [   89.601607] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   89.601609] usb 4-1.4: Product: Mass Storage Device
> [   89.601610] usb 4-1.4: Manufacturer: Generic
> [   89.601612] usb 4-1.4: SerialNumber: 058F84688461
> [   89.624924] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [   89.625785] scsi host0: usb-storage 4-1.4:1.0
> [   89.626043] usbcore: registered new interface driver usb-storage
> [   89.906125] usb 3-1.1.3: new high-speed USB device number 4 using xhci_hcd
> [   90.638225] usb 4-1.1.3: new SuperSpeed USB device number 5 using xhci_hcd
> [   90.655225] usb 4-1.1.3: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
> [   90.655246] usb 4-1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [   90.655254] usb 4-1.1.3: Product: USB 10/100/1000 LAN
> [   90.655261] usb 4-1.1.3: Manufacturer: Realtek
> [   90.655266] usb 4-1.1.3: SerialNumber: 000001
> [   90.730342] usbcore: registered new device driver r8152-cfgselector
> [   91.210824] usb 4-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
> [   91.247161] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [   91.248501] sd 0:0:0:0: [sda] Media removed, stopped polling
> [   91.254432] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [   91.298758] r8152-cfgselector 4-1.1.3: reset SuperSpeed USB device number 5 using xhci_hcd
> [   91.378081] r8152 4-1.1.3:1.0 eth0: v1.12.13
> [   91.378234] usbcore: registered new interface driver r8152
> [   91.413188] usbcore: registered new interface driver cdc_ether
> [   91.416717] usbcore: registered new interface driver r8153_ecm
> [   91.572585] r8152 4-1.1.3:1.0 enx00e04ceb9e75: renamed from eth0
> [   93.038192] usb 3-1.5: new high-speed USB device number 5 using xhci_hcd
> [   93.128894] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [   93.128915] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   93.128923] usb 3-1.5: Product: USB Billboard Device   
> [   93.128930] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [   93.128935] usb 3-1.5: SerialNumber: 0000000000000001
> [   94.617337] r8152 4-1.1.3:1.0 enx00e04ceb9e75: carrier on
> [  287.361810] sched: DL replenish lagged too much
> [  867.312919] warning: `telegram-deskto' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
> [ 3813.292204] usb 3-1: USB disconnect, device number 2
> [ 3813.292225] usb 3-1.1: USB disconnect, device number 3
> [ 3813.294247] usb 3-1.5: USB disconnect, device number 5
> [ 3813.415882] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [ 3813.415940] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [ 3813.418198] r8152 4-1.1.3:1.0 enx00e04ceb9e75: Stop submitting intr, status -108
> [ 3813.434276] xhci_hcd 0000:39:00.0: remove, state 1
> [ 3813.434297] usb usb4: USB disconnect, device number 1
> [ 3813.518239] usb 4-1: USB disconnect, device number 2
> [ 3813.518261] usb 4-1.1: USB disconnect, device number 3
> [ 3813.518273] r8152-cfgselector 4-1.1.3: USB disconnect, device number 5
> [ 3813.574753] usb 4-1.4: USB disconnect, device number 4
> [ 3813.640024] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [ 3813.640036] xhci_hcd 0000:39:00.0: remove, state 1
> [ 3813.640039] usb usb3: USB disconnect, device number 1
> [ 3813.642109] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [ 3813.657145] pci_bus 0000:02: Allocating resources
> [ 3813.657159] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [ 3813.657163] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [ 3813.657165] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [ 3813.657168] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [ 3813.657170] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [ 3813.657173] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [ 3813.657177] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 3813.657179] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 3813.657181] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 3813.657182] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 3813.657186] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 3813.657187] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 3813.657189] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 3813.657190] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 3813.657191] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 3813.657192] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 3813.657195] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 3813.657197] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 3813.657198] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 3813.657199] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 3813.657200] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 3813.657202] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 3813.964840] PM: suspend entry (deep)
> [ 3813.986018] Filesystems sync: 0.021 seconds
> [ 3814.018232] Freezing user space processes
> [ 3814.020659] Freezing user space processes completed (elapsed 0.002 seconds)
> [ 3814.020673] OOM killer disabled.
> [ 3814.020677] Freezing remaining freezable tasks
> [ 3814.022490] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [ 3814.022634] printk: Suspending console(s) (use no_console_suspend to debug)
> [ 3814.543840] ACPI: EC: interrupt blocked
> [ 3814.566245] ACPI: PM: Preparing to enter system sleep state S3
> [ 3814.578456] ACPI: EC: event blocked
> [ 3814.578461] ACPI: EC: EC stopped
> [ 3814.578463] ACPI: PM: Saving platform NVS memory
> [ 3814.581729] Disabling non-boot CPUs ...
> [ 3814.583845] smpboot: CPU 3 is now offline
> [ 3814.587312] smpboot: CPU 2 is now offline
> [ 3814.592239] smpboot: CPU 1 is now offline
> [ 3814.600811] ACPI: PM: Low-level resume complete
> [ 3814.600854] ACPI: EC: EC started
> [ 3814.600854] ACPI: PM: Restoring platform NVS memory
> [ 3814.602739] Enabling non-boot CPUs ...
> [ 3814.602763] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [ 3814.603481] CPU1 is up
> [ 3814.603495] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [ 3814.604239] CPU2 is up
> [ 3814.604255] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 3814.604943] CPU3 is up
> [ 3814.607850] ACPI: PM: Waking up from system sleep state S3
> [ 3814.907455] ACPI: EC: interrupt unblocked
> [ 3814.908046] pcieport 0000:01:00.0: Unable to change power state from unknown to D0, device inaccessible
> [ 3814.913385] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [ 3814.913386] pcieport 0000:02:01.0: Unable to change power state from unknown to D0, device inaccessible
> [ 3814.913389] pcieport 0000:02:02.0: Unable to change power state from unknown to D0, device inaccessible
> [ 3814.922832] ACPI: EC: event unblocked
> [ 3814.935232] nvme nvme0: 4/0/0 default/read/poll queues
> [ 3815.040649] OOM killer enabled.
> [ 3815.040651] Restarting tasks: Starting
> [ 3815.040739] pcieport 0000:02:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [ 3815.040750] usb 1-3: USB disconnect, device number 2
> [ 3815.042206] Restarting tasks: Done
> [ 3815.042223] random: crng reseeded on system resumption
> [ 3815.046464] pci_bus 0000:03: busn_res: [bus 03] is released
> [ 3815.048107] pci_bus 0000:04: busn_res: [bus 04-38] is released
> [ 3815.048383] pci_bus 0000:39: busn_res: [bus 39] is released
> [ 3815.048859] pci_bus 0000:02: busn_res: [bus 02-39] is released
> [ 3815.093966] PM: suspend exit
> [ 3815.170451] usb 1-3: new full-speed USB device number 5 using xhci_hcd
> [ 3815.222571] Process accounting resumed
> [ 3815.307617] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [ 3815.307625] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [ 3815.310878] usb 1-4: USB disconnect, device number 3
> [ 3815.311455] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [ 3815.311459] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [ 3815.502450] usb 1-4: new full-speed USB device number 6 using xhci_hcd
> [ 3815.640478] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [ 3815.640492] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [ 3815.640497] usb 1-4: Product: Touchscreen
> [ 3815.640501] usb 1-4: Manufacturer: ELAN
> [ 3815.660947] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [ 3815.661704] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0003/input/input43
> [ 3815.662964] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0003/input/input44
> [ 3815.663190] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0003/input/input45
> [ 3815.663577] hid-multitouch 0003:04F3:2234.0003: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [ 3815.663845] usb 1-5: USB disconnect, device number 4
> [ 3815.670000] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 3815.692257] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [ 3815.794510] usb 1-5: new high-speed USB device number 7 using xhci_hcd
> [ 3815.998967] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [ 3815.998975] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [ 3815.998978] usb 1-5: Product: Integrated_Webcam_HD
> [ 3815.998981] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [ 3816.006833] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [ 3830.299740] wlp58s0: authenticate with 9c:c8:fc:3d:47:9e (local address=9c:b6:d0:d1:6a:b1)
> [ 3830.299755] wlp58s0: send auth to 9c:c8:fc:3d:47:9e (try 1/3)
> [ 3830.301287] wlp58s0: authenticated
> [ 3830.302321] wlp58s0: associate with 9c:c8:fc:3d:47:9e (try 1/3)
> [ 3830.330775] wlp58s0: RX AssocResp from 9c:c8:fc:3d:47:9e (capab=0x1431 status=0 aid=1)
> [ 3830.333943] wlp58s0: associated
> [ 3830.341185] wlp58s0: Limiting TX power to 20 (20 - 0) dBm as advertised by 9c:c8:fc:3d:47:9e
> [ 3892.542061] wlp58s0: disconnect from AP 9c:c8:fc:3d:47:9e for new auth to 9c:c8:fc:3d:47:9f
> [ 3892.609877] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [ 3892.609896] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [ 3892.613380] wlp58s0: authenticated
> [ 3892.621609] wlp58s0: associate with 9c:c8:fc:3d:47:9f (try 1/3)
> [ 3892.660334] wlp58s0: RX ReassocResp from 9c:c8:fc:3d:47:9f (capab=0x1011 status=0 aid=2)
> [ 3892.663257] wlp58s0: associated
> [ 3892.749723] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 9c:c8:fc:3d:47:9f
> [ 3950.011329] wlp58s0: deauthenticating from 9c:c8:fc:3d:47:9f by local choice (Reason: 3=DEAUTH_LEAVING)
> [ 3951.656222] PM: suspend entry (deep)
> [ 3951.671431] Filesystems sync: 0.015 seconds
> [ 3951.693056] Freezing user space processes
> [ 3951.695406] Freezing user space processes completed (elapsed 0.002 seconds)
> [ 3951.695419] OOM killer disabled.
> [ 3951.695422] Freezing remaining freezable tasks
> [ 3951.697134] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [ 3951.697254] printk: Suspending console(s) (use no_console_suspend to debug)
> [ 3952.233393] ACPI: EC: interrupt blocked
> [ 3952.254574] ACPI: PM: Preparing to enter system sleep state S3
> [ 3952.264642] ACPI: EC: event blocked
> [ 3952.264646] ACPI: EC: EC stopped
> [ 3952.264648] ACPI: PM: Saving platform NVS memory
> [ 3952.267888] Disabling non-boot CPUs ...
> [ 3952.270919] smpboot: CPU 3 is now offline
> [ 3952.275973] smpboot: CPU 2 is now offline
> [ 3952.279637] smpboot: CPU 1 is now offline
> [ 3952.287599] ACPI: PM: Low-level resume complete
> [ 3952.287643] ACPI: EC: EC started
> [ 3952.287643] ACPI: PM: Restoring platform NVS memory
> [ 3952.289526] Enabling non-boot CPUs ...
> [ 3952.289550] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [ 3952.290266] CPU1 is up
> [ 3952.290281] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [ 3952.291008] CPU2 is up
> [ 3952.291023] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 3952.291705] CPU3 is up
> [ 3952.294601] ACPI: PM: Waking up from system sleep state S3
> [ 3952.325173] ACPI: EC: interrupt unblocked
> [ 3952.342513] ACPI: EC: event unblocked
> [ 3952.354998] nvme nvme0: 4/0/0 default/read/poll queues
> [ 3952.597046] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [ 3952.656362] OOM killer enabled.
> [ 3952.656365] Restarting tasks: Starting
> [ 3952.657014] usb 1-3: USB disconnect, device number 5
> [ 3952.658149] Restarting tasks: Done
> [ 3952.658173] random: crng reseeded on system resumption
> [ 3952.925139] PM: suspend exit
> [ 3953.049098] usb 1-3: new full-speed USB device number 8 using xhci_hcd
> [ 3953.186280] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [ 3953.186288] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [ 3953.187117] Process accounting resumed
> [ 3953.190699] usb 1-4: USB disconnect, device number 6
> [ 3953.191280] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [ 3953.191284] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [ 3953.389096] usb 1-4: new full-speed USB device number 9 using xhci_hcd
> [ 3953.551030] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 3953.559151] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [ 3953.559164] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [ 3953.559171] usb 1-4: Product: Touchscreen
> [ 3953.559175] usb 1-4: Manufacturer: ELAN
> [ 3953.573172] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0004/input/input48
> [ 3953.573470] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0004/input/input49
> [ 3953.573619] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0004/input/input50
> [ 3953.573900] hid-multitouch 0003:04F3:2234.0004: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [ 3953.574368] usb 1-5: USB disconnect, device number 7
> [ 3953.574812] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [ 3953.701076] usb 1-5: new high-speed USB device number 10 using xhci_hcd
> [ 3953.800636] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [ 3953.909635] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [ 3953.909654] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [ 3953.909661] usb 1-5: Product: Integrated_Webcam_HD
> [ 3953.909668] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [ 3953.917939] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [ 4373.618352] PM: suspend entry (deep)
> [ 4373.635212] Filesystems sync: 0.016 seconds
> [ 4373.657995] Freezing user space processes
> [ 4373.660364] Freezing user space processes completed (elapsed 0.002 seconds)
> [ 4373.660378] OOM killer disabled.
> [ 4373.660381] Freezing remaining freezable tasks
> [ 4373.662015] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [ 4373.662131] printk: Suspending console(s) (use no_console_suspend to debug)
> [ 4374.179185] ACPI: EC: interrupt blocked
> [ 4374.202317] ACPI: PM: Preparing to enter system sleep state S3
> [ 4374.215308] ACPI: EC: event blocked
> [ 4374.215313] ACPI: EC: EC stopped
> [ 4374.215314] ACPI: PM: Saving platform NVS memory
> [ 4374.218620] Disabling non-boot CPUs ...
> [ 4374.221613] smpboot: CPU 3 is now offline
> [ 4374.225223] smpboot: CPU 2 is now offline
> [ 4374.229424] smpboot: CPU 1 is now offline
> [ 4374.237336] ACPI: PM: Low-level resume complete
> [ 4374.237378] ACPI: EC: EC started
> [ 4374.237379] ACPI: PM: Restoring platform NVS memory
> [ 4374.239256] Enabling non-boot CPUs ...
> [ 4374.239280] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [ 4374.239978] CPU1 is up
> [ 4374.239993] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [ 4374.240747] CPU2 is up
> [ 4374.240761] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 4374.241427] CPU3 is up
> [ 4374.244331] ACPI: PM: Waking up from system sleep state S3
> [ 4374.274618] ACPI: EC: interrupt unblocked
> [ 4374.289062] ACPI: EC: event unblocked
> [ 4374.300887] nvme nvme0: 4/0/0 default/read/poll queues
> [ 4374.524249] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [ 4374.691351] atkbd_receive_byte: 122 callbacks suppressed
> [ 4374.691359] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [ 4374.691504] OOM killer enabled.
> [ 4374.691508] Restarting tasks: Starting
> [ 4374.691965] usb 1-3: USB disconnect, device number 8
> [ 4374.693405] Restarting tasks: Done
> [ 4374.693438] random: crng reseeded on system resumption
> [ 4374.889165] PM: suspend exit
> [ 4375.013644] usb 1-3: new full-speed USB device number 11 using xhci_hcd
> [ 4375.149634] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [ 4375.149642] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [ 4375.158233] Process accounting resumed
> [ 4375.164785] usb 1-4: USB disconnect, device number 9
> [ 4375.168387] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [ 4375.168393] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [ 4375.360252] usb 1-4: new full-speed USB device number 12 using xhci_hcd
> [ 4375.498099] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [ 4375.498114] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [ 4375.498120] usb 1-4: Product: Touchscreen
> [ 4375.498124] usb 1-4: Manufacturer: ELAN
> [ 4375.510708] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0005/input/input53
> [ 4375.511005] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0005/input/input54
> [ 4375.511148] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0005/input/input55
> [ 4375.511415] hid-multitouch 0003:04F3:2234.0005: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [ 4375.511680] usb 1-5: USB disconnect, device number 10
> [ 4375.525608] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 4375.550020] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [ 4375.632240] usb 1-5: new high-speed USB device number 13 using xhci_hcd
> [ 4375.751032] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [ 4375.832750] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [ 4375.832768] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [ 4375.832777] usb 1-5: Product: Integrated_Webcam_HD
> [ 4375.832783] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [ 4375.842161] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [ 4721.258830] PM: suspend entry (deep)
> [ 4721.297250] Filesystems sync: 0.038 seconds
> [ 4721.303776] Freezing user space processes
> [ 4721.305394] Freezing user space processes completed (elapsed 0.001 seconds)
> [ 4721.305398] OOM killer disabled.
> [ 4721.305399] Freezing remaining freezable tasks
> [ 4721.306724] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [ 4721.306775] printk: Suspending console(s) (use no_console_suspend to debug)
> [ 4721.841762] ACPI: EC: interrupt blocked
> [ 4721.864228] ACPI: PM: Preparing to enter system sleep state S3
> [ 4721.874418] ACPI: EC: event blocked
> [ 4721.874422] ACPI: EC: EC stopped
> [ 4721.874424] ACPI: PM: Saving platform NVS memory
> [ 4721.877668] Disabling non-boot CPUs ...
> [ 4721.880746] smpboot: CPU 3 is now offline
> [ 4721.884844] smpboot: CPU 2 is now offline
> [ 4721.887848] smpboot: CPU 1 is now offline
> [ 4721.894395] ACPI: PM: Low-level resume complete
> [ 4721.894439] ACPI: EC: EC started
> [ 4721.894440] ACPI: PM: Restoring platform NVS memory
> [ 4721.896337] Enabling non-boot CPUs ...
> [ 4721.896369] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [ 4721.897066] CPU1 is up
> [ 4721.897080] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [ 4721.897792] CPU2 is up
> [ 4721.897811] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 4721.898489] CPU3 is up
> [ 4721.901351] ACPI: PM: Waking up from system sleep state S3
> [ 4721.937051] ACPI: EC: interrupt unblocked
> [ 4721.972163] ACPI: EC: event unblocked
> [ 4721.984949] nvme nvme0: 4/0/0 default/read/poll queues
> [ 4722.095287] OOM killer enabled.
> [ 4722.095289] Restarting tasks: Starting
> [ 4722.095488] usb 1-3: USB disconnect, device number 11
> [ 4722.095929] Restarting tasks: Done
> [ 4722.095950] random: crng reseeded on system resumption
> [ 4722.218324] usb 1-3: new full-speed USB device number 14 using xhci_hcd
> [ 4722.234318] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [ 4722.355507] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [ 4722.355516] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [ 4722.589388] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [ 4722.589399] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [ 4722.590532] PM: suspend exit
> [ 4722.598826] usb 1-4: USB disconnect, device number 12
> [ 4722.805847] Process accounting resumed
> [ 4722.902324] usb 1-4: new full-speed USB device number 15 using xhci_hcd
> [ 4722.945332] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 4722.968066] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [ 4723.040085] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [ 4723.040097] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [ 4723.040099] usb 1-4: Product: Touchscreen
> [ 4723.040100] usb 1-4: Manufacturer: ELAN
> [ 4723.049499] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0006/input/input58
> [ 4723.049631] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0006/input/input59
> [ 4723.049690] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0006/input/input60
> [ 4723.049832] hid-multitouch 0003:04F3:2234.0006: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [ 4723.049966] usb 1-5: USB disconnect, device number 13
> [ 4723.170344] usb 1-5: new high-speed USB device number 16 using xhci_hcd
> [ 4723.366846] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [ 4723.366869] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [ 4723.366875] usb 1-5: Product: Integrated_Webcam_HD
> [ 4723.366879] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [ 4723.375445] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [ 4723.478543] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [ 5856.049611] PM: suspend entry (deep)
> [ 5856.060128] Filesystems sync: 0.010 seconds
> [ 5856.068204] Freezing user space processes
> [ 5856.069840] Freezing user space processes completed (elapsed 0.001 seconds)
> [ 5856.069844] OOM killer disabled.
> [ 5856.069844] Freezing remaining freezable tasks
> [ 5856.071216] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [ 5856.071267] printk: Suspending console(s) (use no_console_suspend to debug)
> [ 5856.635193] ACPI: EC: interrupt blocked
> [ 5856.656777] ACPI: PM: Preparing to enter system sleep state S3
> [ 5856.672213] ACPI: EC: event blocked
> [ 5856.672217] ACPI: EC: EC stopped
> [ 5856.672219] ACPI: PM: Saving platform NVS memory
> [ 5856.675549] Disabling non-boot CPUs ...
> [ 5856.677484] smpboot: CPU 3 is now offline
> [ 5856.681961] smpboot: CPU 2 is now offline
> [ 5856.685072] smpboot: CPU 1 is now offline
> [ 5856.692859] ACPI: PM: Low-level resume complete
> [ 5856.692904] ACPI: EC: EC started
> [ 5856.692905] ACPI: PM: Restoring platform NVS memory
> [ 5856.694787] Enabling non-boot CPUs ...
> [ 5856.694811] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [ 5856.695511] CPU1 is up
> [ 5856.695526] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [ 5856.696238] CPU2 is up
> [ 5856.696254] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 5856.696918] CPU3 is up
> [ 5856.699774] ACPI: PM: Waking up from system sleep state S3
> [ 5856.734618] ACPI: EC: interrupt unblocked
> [ 5856.749533] ACPI: EC: event unblocked
> [ 5856.761697] nvme nvme0: 4/0/0 default/read/poll queues
> [ 5856.972896] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [ 5857.032073] OOM killer enabled.
> [ 5857.032076] Restarting tasks: Starting
> [ 5857.032937] usb 1-3: USB disconnect, device number 14
> [ 5857.033623] Restarting tasks: Done
> [ 5857.033645] random: crng reseeded on system resumption
> [ 5857.243955] PM: suspend exit
> [ 5857.364956] usb 1-3: new full-speed USB device number 17 using xhci_hcd
> [ 5857.376539] Process accounting resumed
> [ 5857.516445] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [ 5857.516459] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [ 5857.519294] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [ 5857.519299] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [ 5857.519896] usb 1-4: USB disconnect, device number 15
> [ 5857.704966] usb 1-4: new full-speed USB device number 18 using xhci_hcd
> [ 5857.842477] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [ 5857.842502] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [ 5857.842517] usb 1-4: Product: Touchscreen
> [ 5857.842521] usb 1-4: Manufacturer: ELAN
> [ 5857.857197] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0007/input/input63
> [ 5857.857801] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0007/input/input64
> [ 5857.858191] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0007/input/input65
> [ 5857.858955] hid-multitouch 0003:04F3:2234.0007: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [ 5857.859473] usb 1-5: USB disconnect, device number 16
> [ 5857.874181] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 5857.898722] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [ 5857.981557] usb 1-5: new high-speed USB device number 19 using xhci_hcd
> [ 5858.178118] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [ 5858.178132] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [ 5858.178134] usb 1-5: Product: Integrated_Webcam_HD
> [ 5858.178137] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [ 5858.186184] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [ 5858.199332] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [ 5886.363511] PM: suspend entry (deep)
> [ 5886.373356] Filesystems sync: 0.009 seconds
> [ 5886.378327] Freezing user space processes
> [ 5886.379953] Freezing user space processes completed (elapsed 0.001 seconds)
> [ 5886.379957] OOM killer disabled.
> [ 5886.379958] Freezing remaining freezable tasks
> [ 5886.381244] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [ 5886.381295] printk: Suspending console(s) (use no_console_suspend to debug)
> [ 5886.896871] ACPI: EC: interrupt blocked
> [ 5886.919487] ACPI: PM: Preparing to enter system sleep state S3
> [ 5886.931851] ACPI: EC: event blocked
> [ 5886.931856] ACPI: EC: EC stopped
> [ 5886.931858] ACPI: PM: Saving platform NVS memory
> [ 5886.935516] Disabling non-boot CPUs ...
> [ 5886.937681] smpboot: CPU 3 is now offline
> [ 5886.943169] smpboot: CPU 2 is now offline
> [ 5886.947176] smpboot: CPU 1 is now offline
> [ 5886.955884] ACPI: PM: Low-level resume complete
> [ 5886.955927] ACPI: EC: EC started
> [ 5886.955927] ACPI: PM: Restoring platform NVS memory
> [ 5886.957796] Enabling non-boot CPUs ...
> [ 5886.957820] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [ 5886.958523] CPU1 is up
> [ 5886.958539] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [ 5886.959258] CPU2 is up
> [ 5886.959273] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 5886.959935] CPU3 is up
> [ 5886.962813] ACPI: PM: Waking up from system sleep state S3
> [ 5886.990869] ACPI: EC: interrupt unblocked
> [ 5887.007018] ACPI: EC: event unblocked
> [ 5887.019164] nvme nvme0: 4/0/0 default/read/poll queues
> [ 5887.123137] OOM killer enabled.
> [ 5887.123141] Restarting tasks: Starting
> [ 5887.124752] Restarting tasks: Done
> [ 5887.124788] random: crng reseeded on system resumption
> [ 5887.125647] usb 1-3: USB disconnect, device number 17
> [ 5887.244782] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [ 5887.521480] PM: suspend exit
> [ 5887.648734] usb 1-3: new full-speed USB device number 20 using xhci_hcd
> [ 5887.785913] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [ 5887.785919] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [ 5887.787891] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [ 5887.787895] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [ 5887.788016] usb 1-4: USB disconnect, device number 18
> [ 5887.802148] Process accounting resumed
> [ 5887.964762] usb 1-4: new full-speed USB device number 21 using xhci_hcd
> [ 5888.110403] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [ 5888.110417] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [ 5888.110424] usb 1-4: Product: Touchscreen
> [ 5888.110428] usb 1-4: Manufacturer: ELAN
> [ 5888.125339] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0008/input/input68
> [ 5888.125735] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0008/input/input69
> [ 5888.125957] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0008/input/input70
> [ 5888.126368] hid-multitouch 0003:04F3:2234.0008: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [ 5888.126804] usb 1-5: USB disconnect, device number 19
> [ 5888.142358] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 5888.166553] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [ 5888.256716] usb 1-5: new high-speed USB device number 22 using xhci_hcd
> [ 5888.457400] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [ 5888.457406] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [ 5888.457408] usb 1-5: Product: Integrated_Webcam_HD
> [ 5888.457410] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [ 5888.466024] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [ 5888.468727] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [ 5976.509838] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [ 5976.509855] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [ 5976.513683] wlp58s0: authenticated
> [ 5976.515992] wlp58s0: associate with 9c:c8:fc:3d:47:9f (try 1/3)
> [ 5976.548180] wlp58s0: RX AssocResp from 9c:c8:fc:3d:47:9f (capab=0x1011 status=0 aid=1)
> [ 5976.551552] wlp58s0: associated
> [ 5976.588026] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 9c:c8:fc:3d:47:9f
> [ 6531.184083] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [ 6531.184136] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [ 6531.184155] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [ 6531.184175] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [ 6531.184197] pci 0000:01:00.0: enabling Extended Tags
> [ 6531.184337] pci 0000:01:00.0: supports D1 D2
> [ 6531.184341] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 6531.184458] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [ 6531.185632] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [ 6531.185689] pci 0000:02:00.0: PCI bridge to [bus 03]
> [ 6531.185710] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [ 6531.185755] pci 0000:02:00.0: enabling Extended Tags
> [ 6531.185920] pci 0000:02:00.0: supports D1 D2
> [ 6531.185927] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 6531.186542] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [ 6531.186598] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [ 6531.186618] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [ 6531.186641] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [ 6531.186670] pci 0000:02:01.0: enabling Extended Tags
> [ 6531.186838] pci 0000:02:01.0: supports D1 D2
> [ 6531.186845] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 6531.187320] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [ 6531.187407] pci 0000:02:02.0: PCI bridge to [bus 39]
> [ 6531.187428] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [ 6531.187473] pci 0000:02:02.0: enabling Extended Tags
> [ 6531.187649] pci 0000:02:02.0: supports D1 D2
> [ 6531.187655] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 6531.189969] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [ 6531.190134] pci 0000:02:00.0: PCI bridge to [bus 03]
> [ 6531.190282] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [ 6531.190525] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [ 6531.190622] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [ 6531.190659] pci 0000:39:00.0: enabling Extended Tags
> [ 6531.190867] pci 0000:39:00.0: supports D1 D2
> [ 6531.190874] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 6531.193540] pci 0000:02:02.0: PCI bridge to [bus 39]
> [ 6531.193620] pci_bus 0000:02: Allocating resources
> [ 6531.193653] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [ 6531.193665] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [ 6531.193675] pci 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [ 6531.193688] pci 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [ 6531.193696] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [ 6531.193709] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [ 6531.193721] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 6531.193728] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 6531.193737] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 6531.193743] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 6531.193759] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 6531.193766] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 6531.193774] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 6531.193780] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 6531.193787] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 6531.193793] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 6531.193803] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 6531.193810] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 6531.193817] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 6531.193822] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 6531.193828] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 6531.193835] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 6531.193843] pci 0000:02:00.0: PCI bridge to [bus 03]
> [ 6531.193856] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [ 6531.193875] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [ 6531.193886] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [ 6531.193896] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [ 6531.193911] pci 0000:02:02.0: PCI bridge to [bus 39]
> [ 6531.193921] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [ 6531.193938] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [ 6531.193949] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [ 6531.193959] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [ 6531.196628] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [ 6531.196653] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [ 6531.197890] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [ 6531.198586] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [ 6531.198600] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [ 6531.198613] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [ 6531.203506] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [ 6531.203521] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6531.203528] usb usb3: Product: xHCI Host Controller
> [ 6531.203534] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [ 6531.203539] usb usb3: SerialNumber: 0000:39:00.0
> [ 6531.208599] hub 3-0:1.0: USB hub found
> [ 6531.211408] hub 3-0:1.0: 2 ports detected
> [ 6531.213477] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [ 6531.213491] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6531.213499] usb usb4: Product: xHCI Host Controller
> [ 6531.213505] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [ 6531.213511] usb usb4: SerialNumber: 0000:39:00.0
> [ 6531.214005] hub 4-0:1.0: USB hub found
> [ 6531.214036] hub 4-0:1.0: 2 ports detected
> [ 6531.218346] pci_bus 0000:02: Allocating resources
> [ 6531.218387] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [ 6531.218403] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [ 6531.218414] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [ 6531.218428] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [ 6531.218437] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [ 6531.218450] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [ 6531.218463] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 6531.218471] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 6531.218479] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 6531.218485] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 6531.218501] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 6531.218509] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 6531.218516] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 6531.218523] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 6531.218529] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 6531.218536] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 6531.218547] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 6531.218554] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 6531.218561] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 6531.218566] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 6531.218571] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 6531.218577] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 6531.459414] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [ 6531.602262] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [ 6531.602274] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 6531.602279] usb 3-1: Product: USB2.0 Hub             
> [ 6531.602284] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [ 6531.602288] usb 3-1: SerialNumber: 000000000
> [ 6531.606785] hub 3-1:1.0: USB hub found
> [ 6531.607768] hub 3-1:1.0: 5 ports detected
> [ 6531.731482] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [ 6531.776903] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [ 6531.776921] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 6531.776929] usb 4-1: Product: USB3.0 Hub             
> [ 6531.776934] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [ 6531.776939] usb 4-1: SerialNumber: 000000000
> [ 6531.779778] hub 4-1:1.0: USB hub found
> [ 6531.780663] hub 4-1:1.0: 4 ports detected
> [ 6532.335423] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [ 6532.474579] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [ 6532.474601] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 6532.474611] usb 3-1.1: Product: USB2.0 Hub             
> [ 6532.474620] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [ 6532.474627] usb 3-1.1: SerialNumber: 000000000
> [ 6532.478080] hub 3-1.1:1.0: USB hub found
> [ 6532.478438] hub 3-1.1:1.0: 4 ports detected
> [ 6532.572070] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [ 6532.632322] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [ 6532.632345] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 6532.632355] usb 4-1.1: Product: USB3.0 Hub             
> [ 6532.632364] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [ 6532.632372] usb 4-1.1: SerialNumber: 000000000
> [ 6532.636950] hub 4-1.1:1.0: USB hub found
> [ 6532.637119] hub 4-1.1:1.0: 4 ports detected
> [ 6532.811795] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [ 6532.831103] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [ 6532.831110] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 6532.831113] usb 4-1.4: Product: Mass Storage Device
> [ 6532.831115] usb 4-1.4: Manufacturer: Generic
> [ 6532.831116] usb 4-1.4: SerialNumber: 058F84688461
> [ 6532.833226] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [ 6532.833593] scsi host0: usb-storage 4-1.4:1.0
> [ 6533.147627] usb 3-1.1.3: new high-speed USB device number 4 using xhci_hcd
> [ 6533.879663] usb 4-1.1.3: new SuperSpeed USB device number 5 using xhci_hcd
> [ 6533.897257] usb 4-1.1.3: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
> [ 6533.897279] usb 4-1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [ 6533.897287] usb 4-1.1.3: Product: USB 10/100/1000 LAN
> [ 6533.897295] usb 4-1.1.3: Manufacturer: Realtek
> [ 6533.897300] usb 4-1.1.3: SerialNumber: 000001
> [ 6534.412258] usb 4-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
> [ 6534.444395] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [ 6534.445814] sd 0:0:0:0: [sda] Media removed, stopped polling
> [ 6534.460364] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [ 6534.499946] r8152-cfgselector 4-1.1.3: reset SuperSpeed USB device number 5 using xhci_hcd
> [ 6534.576813] r8152 4-1.1.3:1.0 eth0: v1.12.13
> [ 6534.754758] r8152 4-1.1.3:1.0 enx00e04ceb9e75: renamed from eth0
> [ 6536.247548] usb 3-1.5: new high-speed USB device number 5 using xhci_hcd
> [ 6536.337168] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [ 6536.337201] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 6536.337215] usb 3-1.5: Product: USB Billboard Device   
> [ 6536.337226] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [ 6536.337235] usb 3-1.5: SerialNumber: 0000000000000001
> [ 6537.328371] r8152 4-1.1.3:1.0 enx00e04ceb9e75: carrier on
> [ 6555.982308] wlp58s0: deauthenticating from 9c:c8:fc:3d:47:9f by local choice (Reason: 3=DEAUTH_LEAVING)
> [ 6683.064232] systemd[1]: systemd 258~rc3-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
> [ 6683.064649] systemd[1]: Detected architecture x86-64.
> [ 6683.535874] systemd[1]: bpf-restrict-fs: LSM BPF program attached
> [ 6683.587848] systemd-sysv-generator[9887]: SysV service '/etc/init.d/xl2tpd' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> [ 6683.587861] systemd-sysv-generator[9887]: Please update package to include a native systemd unit file.
> [ 6683.587864] systemd-sysv-generator[9887]: ! This compatibility logic is deprecated, expect removal soon. !
> [ 6683.868732] systemd-journald[349]: Received SIGTERM from PID 1 (systemd).
> [ 6683.868935] systemd[1]: Stopping systemd-journald.service - Journal Service...
> [ 6684.006543] systemd[1]: systemd-journald.service: Deactivated successfully.
> [ 6684.006768] systemd[1]: Stopped systemd-journald.service - Journal Service.
> [ 6684.006845] systemd[1]: systemd-journald.service: Consumed 1.723s CPU time, 25M memory peak.
> [ 6684.011446] systemd[1]: Starting systemd-journald.service - Journal Service...
> [ 6684.054195] systemd-journald[9902]: Collecting audit messages is disabled.
> [ 6684.072551] systemd[1]: Started systemd-journald.service - Journal Service.
> [ 6684.662460] systemd-sysv-generator[10036]: SysV service '/etc/init.d/xl2tpd' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> [ 6684.662467] systemd-sysv-generator[10036]: Please update package to include a native systemd unit file.
> [ 6684.662470] systemd-sysv-generator[10036]: ! This compatibility logic is deprecated, expect removal soon. !
> [ 6686.312572] systemd-sysv-generator[10188]: SysV service '/etc/init.d/xl2tpd' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> [ 6686.312578] systemd-sysv-generator[10188]: Please update package to include a native systemd unit file.
> [ 6686.312580] systemd-sysv-generator[10188]: ! This compatibility logic is deprecated, expect removal soon. !
> [ 6687.274098] systemd-sysv-generator[10332]: SysV service '/etc/init.d/xl2tpd' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> [ 6687.274103] systemd-sysv-generator[10332]: Please update package to include a native systemd unit file.
> [ 6687.274105] systemd-sysv-generator[10332]: ! This compatibility logic is deprecated, expect removal soon. !
> [ 6687.766342] systemd-sysv-generator[10471]: SysV service '/etc/init.d/xl2tpd' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> [ 6687.766347] systemd-sysv-generator[10471]: Please update package to include a native systemd unit file.
> [ 6687.766349] systemd-sysv-generator[10471]: ! This compatibility logic is deprecated, expect removal soon. !
> [ 6688.519844] systemd-sysv-generator[10619]: SysV service '/etc/init.d/xl2tpd' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> [ 6688.519851] systemd-sysv-generator[10619]: Please update package to include a native systemd unit file.
> [ 6688.519854] systemd-sysv-generator[10619]: ! This compatibility logic is deprecated, expect removal soon. !
> [ 6693.825993] systemd[1]: systemd 258~rc3-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
> [ 6693.826158] systemd[1]: Detected architecture x86-64.
> [ 6694.320934] systemd[1]: bpf-restrict-fs: LSM BPF program attached
> [ 6694.381391] systemd-sysv-generator[13261]: SysV service '/etc/init.d/xl2tpd' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> [ 6694.381399] systemd-sysv-generator[13261]: Please update package to include a native systemd unit file.
> [ 6694.381402] systemd-sysv-generator[13261]: ! This compatibility logic is deprecated, expect removal soon. !
> [ 8328.022805] rfkill: input handler enabled
> [ 8331.759269] rfkill: input handler disabled
> [ 8335.397802] rfkill: input handler enabled
> [ 8337.701792] rfkill: input handler disabled
> [ 9114.370202] rfkill: input handler enabled
> [ 9117.820836] rfkill: input handler disabled
> [ 9122.941246] rfkill: input handler enabled
> [ 9125.764113] rfkill: input handler disabled
> [ 9131.230790] usb 3-1: USB disconnect, device number 2
> [ 9131.230798] usb 3-1.1: USB disconnect, device number 3
> [ 9131.231672] usb 3-1.5: USB disconnect, device number 5
> [ 9131.286871] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [ 9131.286898] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [ 9131.286917] r8152 4-1.1.3:1.0 enx00e04ceb9e75: Stop submitting intr, status -108
> [ 9131.369549] xhci_hcd 0000:39:00.0: remove, state 1
> [ 9131.369558] usb usb4: USB disconnect, device number 1
> [ 9131.427736] usb 4-1: USB disconnect, device number 2
> [ 9131.427745] usb 4-1.1: USB disconnect, device number 3
> [ 9131.427749] r8152-cfgselector 4-1.1.3: USB disconnect, device number 5
> [ 9131.469749] usb 4-1.4: USB disconnect, device number 4
> [ 9131.507931] PM: suspend entry (deep)
> [ 9131.566798] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [ 9131.566834] xhci_hcd 0000:39:00.0: remove, state 1
> [ 9131.566848] usb usb3: USB disconnect, device number 1
> [ 9131.569382] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [ 9131.585746] pci_bus 0000:02: Allocating resources
> [ 9131.585791] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [ 9131.585810] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [ 9131.585822] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [ 9131.585838] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [ 9131.585848] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [ 9131.585861] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [ 9131.585877] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 9131.585886] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 9131.585895] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 9131.585902] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 9131.585923] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 9131.585930] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 9131.585942] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9131.585949] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 9131.585957] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9131.585963] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 9131.585976] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 9131.585984] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 9131.585993] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9131.585999] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 9131.586007] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9131.586014] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 9131.606306] Filesystems sync: 0.098 seconds
> [ 9131.652160] Freezing user space processes
> [ 9131.653945] Freezing user space processes completed (elapsed 0.001 seconds)
> [ 9131.653953] OOM killer disabled.
> [ 9131.653955] Freezing remaining freezable tasks
> [ 9131.655218] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [ 9131.655640] printk: Suspending console(s) (use no_console_suspend to debug)
> [ 9132.168440] ACPI: EC: interrupt blocked
> [ 9132.191659] ACPI: PM: Preparing to enter system sleep state S3
> [ 9132.201804] ACPI: EC: event blocked
> [ 9132.201808] ACPI: EC: EC stopped
> [ 9132.201810] ACPI: PM: Saving platform NVS memory
> [ 9132.205082] Disabling non-boot CPUs ...
> [ 9132.207141] smpboot: CPU 3 is now offline
> [ 9132.214690] smpboot: CPU 2 is now offline
> [ 9132.221448] smpboot: CPU 1 is now offline
> [ 9132.230868] ACPI: PM: Low-level resume complete
> [ 9132.230915] ACPI: EC: EC started
> [ 9132.230915] ACPI: PM: Restoring platform NVS memory
> [ 9132.232796] Enabling non-boot CPUs ...
> [ 9132.232822] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [ 9132.233537] CPU1 is up
> [ 9132.233551] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [ 9132.234283] CPU2 is up
> [ 9132.234298] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 9132.234990] CPU3 is up
> [ 9132.237874] ACPI: PM: Waking up from system sleep state S3
> [ 9132.538046] ACPI: EC: interrupt unblocked
> [ 9132.538726] pcieport 0000:01:00.0: Unable to change power state from unknown to D0, device inaccessible
> [ 9132.544291] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [ 9132.544293] pcieport 0000:02:01.0: Unable to change power state from unknown to D0, device inaccessible
> [ 9132.544294] pcieport 0000:02:02.0: Unable to change power state from unknown to D0, device inaccessible
> [ 9132.554389] ACPI: EC: event unblocked
> [ 9132.568653] nvme nvme0: 4/0/0 default/read/poll queues
> [ 9132.673858] OOM killer enabled.
> [ 9132.673860] Restarting tasks: Starting
> [ 9132.673928] pcieport 0000:02:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [ 9132.674040] pci_bus 0000:03: busn_res: [bus 03] is released
> [ 9132.674408] pci_bus 0000:04: busn_res: [bus 04-38] is released
> [ 9132.674538] usb 1-3: USB disconnect, device number 20
> [ 9132.675603] pci_bus 0000:39: busn_res: [bus 39] is released
> [ 9132.679827] Restarting tasks: Done
> [ 9132.679846] random: crng reseeded on system resumption
> [ 9132.680003] pci_bus 0000:02: busn_res: [bus 02-39] is released
> [ 9132.731446] PM: suspend exit
> [ 9132.811925] usb 1-3: new full-speed USB device number 23 using xhci_hcd
> [ 9132.857300] Process accounting resumed
> [ 9132.880317] rfkill: input handler enabled
> [ 9132.909465] rfkill: input handler disabled
> [ 9132.949168] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [ 9132.949176] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [ 9132.952819] usb 1-4: USB disconnect, device number 21
> [ 9132.953391] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [ 9132.953395] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [ 9133.143892] usb 1-4: new full-speed USB device number 24 using xhci_hcd
> [ 9133.281404] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [ 9133.281411] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [ 9133.281414] usb 1-4: Product: Touchscreen
> [ 9133.281423] usb 1-4: Manufacturer: ELAN
> [ 9133.285662] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [ 9133.293905] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0009/input/input73
> [ 9133.294153] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0009/input/input74
> [ 9133.294242] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0009/input/input75
> [ 9133.294984] hid-multitouch 0003:04F3:2234.0009: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [ 9133.295152] usb 1-5: USB disconnect, device number 22
> [ 9133.309424] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 9133.334468] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [ 9133.415904] usb 1-5: new high-speed USB device number 25 using xhci_hcd
> [ 9133.612653] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [ 9133.612662] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [ 9133.612665] usb 1-5: Product: Integrated_Webcam_HD
> [ 9133.612667] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [ 9133.625475] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [ 9287.182576] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [ 9287.182634] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [ 9287.182653] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [ 9287.182675] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [ 9287.182698] pci 0000:01:00.0: enabling Extended Tags
> [ 9287.182846] pci 0000:01:00.0: supports D1 D2
> [ 9287.182850] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 9287.182973] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [ 9287.184706] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [ 9287.184768] pci 0000:02:00.0: PCI bridge to [bus 03]
> [ 9287.184791] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [ 9287.184839] pci 0000:02:00.0: enabling Extended Tags
> [ 9287.185013] pci 0000:02:00.0: supports D1 D2
> [ 9287.185021] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 9287.185584] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [ 9287.185644] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [ 9287.185666] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [ 9287.185692] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [ 9287.185723] pci 0000:02:01.0: enabling Extended Tags
> [ 9287.185900] pci 0000:02:01.0: supports D1 D2
> [ 9287.185907] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 9287.186461] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [ 9287.186520] pci 0000:02:02.0: PCI bridge to [bus 39]
> [ 9287.186542] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [ 9287.186590] pci 0000:02:02.0: enabling Extended Tags
> [ 9287.186762] pci 0000:02:02.0: supports D1 D2
> [ 9287.186769] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 9287.187536] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [ 9287.188092] pci 0000:02:00.0: PCI bridge to [bus 03]
> [ 9287.188277] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [ 9287.188512] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [ 9287.188603] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [ 9287.188634] pci 0000:39:00.0: enabling Extended Tags
> [ 9287.188810] pci 0000:39:00.0: supports D1 D2
> [ 9287.188814] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 9287.189260] pci 0000:02:02.0: PCI bridge to [bus 39]
> [ 9287.189328] pci_bus 0000:02: Allocating resources
> [ 9287.189353] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [ 9287.189361] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [ 9287.189368] pci 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [ 9287.189377] pci 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [ 9287.189383] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [ 9287.189391] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [ 9287.189400] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 9287.189405] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 9287.189411] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 9287.189415] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 9287.189425] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 9287.189430] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 9287.189434] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9287.189438] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 9287.189442] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9287.189446] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 9287.189456] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 9287.189460] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 9287.189464] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9287.189468] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 9287.189472] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9287.189476] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 9287.189481] pci 0000:02:00.0: PCI bridge to [bus 03]
> [ 9287.189491] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [ 9287.189506] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [ 9287.189515] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [ 9287.189523] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [ 9287.189535] pci 0000:02:02.0: PCI bridge to [bus 39]
> [ 9287.189544] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [ 9287.189558] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [ 9287.189567] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [ 9287.189574] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [ 9287.191368] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [ 9287.191384] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [ 9287.192578] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [ 9287.193291] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [ 9287.193308] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [ 9287.193319] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [ 9287.193438] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [ 9287.193450] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 9287.193458] usb usb3: Product: xHCI Host Controller
> [ 9287.193465] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [ 9287.193472] usb usb3: SerialNumber: 0000:39:00.0
> [ 9287.198589] hub 3-0:1.0: USB hub found
> [ 9287.201616] hub 3-0:1.0: 2 ports detected
> [ 9287.212016] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [ 9287.212034] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 9287.212042] usb usb4: Product: xHCI Host Controller
> [ 9287.212049] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [ 9287.212055] usb usb4: SerialNumber: 0000:39:00.0
> [ 9287.212544] hub 4-0:1.0: USB hub found
> [ 9287.212576] hub 4-0:1.0: 2 ports detected
> [ 9287.216830] pci_bus 0000:02: Allocating resources
> [ 9287.216872] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [ 9287.216888] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [ 9287.216900] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [ 9287.216915] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [ 9287.216925] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [ 9287.216938] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [ 9287.216951] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 9287.216959] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 9287.216967] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [ 9287.216973] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [ 9287.216991] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 9287.216998] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 9287.217005] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9287.217011] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 9287.217018] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9287.217024] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 9287.217035] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [ 9287.217042] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [ 9287.217049] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9287.217055] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [ 9287.217061] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [ 9287.217067] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [ 9287.458397] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [ 9287.598133] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [ 9287.598149] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 9287.598156] usb 3-1: Product: USB2.0 Hub             
> [ 9287.598161] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [ 9287.598165] usb 3-1: SerialNumber: 000000000
> [ 9287.600532] hub 3-1:1.0: USB hub found
> [ 9287.600723] hub 3-1:1.0: 5 ports detected
> [ 9287.724847] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [ 9287.770905] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [ 9287.770920] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 9287.770927] usb 4-1: Product: USB3.0 Hub             
> [ 9287.770932] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [ 9287.770936] usb 4-1: SerialNumber: 000000000
> [ 9287.773375] hub 4-1:1.0: USB hub found
> [ 9287.773533] hub 4-1:1.0: 4 ports detected
> [ 9288.318415] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [ 9288.459643] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [ 9288.459659] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 9288.459665] usb 3-1.1: Product: USB2.0 Hub             
> [ 9288.459670] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [ 9288.459675] usb 3-1.1: SerialNumber: 000000000
> [ 9288.461652] hub 3-1.1:1.0: USB hub found
> [ 9288.461882] hub 3-1.1:1.0: 4 ports detected
> [ 9288.556314] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [ 9288.617766] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [ 9288.617787] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 9288.617798] usb 4-1.1: Product: USB3.0 Hub             
> [ 9288.617806] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [ 9288.617814] usb 4-1.1: SerialNumber: 000000000
> [ 9288.620760] hub 4-1.1:1.0: USB hub found
> [ 9288.620889] hub 4-1.1:1.0: 4 ports detected
> [ 9288.794579] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [ 9288.813703] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [ 9288.813712] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 9288.813715] usb 4-1.4: Product: Mass Storage Device
> [ 9288.813718] usb 4-1.4: Manufacturer: Generic
> [ 9288.813720] usb 4-1.4: SerialNumber: 058F84688461
> [ 9288.815808] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [ 9288.816032] scsi host0: usb-storage 4-1.4:1.0
> [ 9289.134460] usb 3-1.1.3: new high-speed USB device number 4 using xhci_hcd
> [ 9289.823673] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [ 9289.825065] sd 0:0:0:0: [sda] Media removed, stopped polling
> [ 9289.825458] scsi 0:0:0:1: Direct-Access     Generic- Micro SD/M2      1.08 PQ: 0 ANSI: 6
> [ 9289.826424] sd 0:0:0:1: [sdb] Media removed, stopped polling
> [ 9289.838562] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [ 9289.846632] sd 0:0:0:1: [sdb] Attached SCSI removable disk
> [ 9289.870288] usb 4-1.1.3: new SuperSpeed USB device number 5 using xhci_hcd
> [ 9289.887349] usb 4-1.1.3: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
> [ 9289.887367] usb 4-1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [ 9289.887375] usb 4-1.1.3: Product: USB 10/100/1000 LAN
> [ 9289.887380] usb 4-1.1.3: Manufacturer: Realtek
> [ 9289.887385] usb 4-1.1.3: SerialNumber: 000001
> [ 9289.970614] r8152-cfgselector 4-1.1.3: reset SuperSpeed USB device number 5 using xhci_hcd
> [ 9290.053031] r8152 4-1.1.3:1.0 eth0: v1.12.13
> [ 9290.156324] r8152 4-1.1.3:1.0 enx00e04ceb9e75: renamed from eth0
> [ 9292.294460] usb 3-1.5: new high-speed USB device number 5 using xhci_hcd
> [ 9292.384115] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [ 9292.384141] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 9292.384152] usb 3-1.5: Product: USB Billboard Device   
> [ 9292.384160] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [ 9292.384166] usb 3-1.5: SerialNumber: 0000000000000001
> [ 9293.291033] r8152 4-1.1.3:1.0 enx00e04ceb9e75: carrier on
> [ 9315.916962] r8152 4-1.1.3:1.0 enx00e04ceb9e75: carrier off
> [ 9323.946536] r8152 4-1.1.3:1.0 enx00e04ceb9e75: carrier on
> [11750.230886] perf: interrupt took too long (2516 > 2500), lowering kernel.perf_event_max_sample_rate to 79250
> [11750.241662] perf: interrupt took too long (3150 > 3145), lowering kernel.perf_event_max_sample_rate to 63500
> [11750.272226] perf: interrupt took too long (3955 > 3937), lowering kernel.perf_event_max_sample_rate to 50500
> [11750.824955] perf: interrupt took too long (5022 > 4943), lowering kernel.perf_event_max_sample_rate to 39750
> [11750.874286] perf: interrupt took too long (6278 > 6277), lowering kernel.perf_event_max_sample_rate to 31750
> [11750.921711] perf: interrupt took too long (7974 > 7847), lowering kernel.perf_event_max_sample_rate to 25000
> [11751.389900] perf: interrupt took too long (9985 > 9967), lowering kernel.perf_event_max_sample_rate to 20000
> [11752.834683] perf: interrupt took too long (12543 > 12481), lowering kernel.perf_event_max_sample_rate to 15750
> [21403.395462] usb 3-1: USB disconnect, device number 2
> [21403.395466] usb 3-1.1: USB disconnect, device number 3
> [21403.396198] usb 3-1.5: USB disconnect, device number 5
> [21403.449954] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [21403.449976] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [21403.450038] r8152 4-1.1.3:1.0 enx00e04ceb9e75: Stop submitting intr, status -108
> [21403.452568] PM: suspend entry (deep)
> [21403.505083] xhci_hcd 0000:39:00.0: remove, state 1
> [21403.505089] usb usb4: USB disconnect, device number 1
> [21403.537674] Filesystems sync: 0.085 seconds
> [21403.545887] Freezing user space processes
> [21403.547436] Freezing user space processes completed (elapsed 0.001 seconds)
> [21403.547439] OOM killer disabled.
> [21403.547440] Freezing remaining freezable tasks
> [21403.558683] usb 4-1: USB disconnect, device number 2
> [21403.558688] usb 4-1.1: USB disconnect, device number 3
> [21403.558691] r8152-cfgselector 4-1.1.3: USB disconnect, device number 5
> [21403.583615] usb 4-1.4: USB disconnect, device number 4
> [21403.694243] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [21403.694281] xhci_hcd 0000:39:00.0: remove, state 1
> [21403.694292] usb usb3: USB disconnect, device number 1
> [21403.695520] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [21403.699359] Freezing remaining freezable tasks completed (elapsed 0.151 seconds)
> [21403.707831] pci_bus 0000:02: Allocating resources
> [21403.707868] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [21403.707885] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [21403.707896] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [21403.707910] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [21403.707919] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [21403.707934] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [21403.707948] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [21403.707955] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [21403.707963] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [21403.707969] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [21403.707985] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [21403.707992] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [21403.707998] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [21403.708004] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [21403.708010] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [21403.708015] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [21403.708025] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [21403.708031] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [21403.708039] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [21403.708045] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [21403.708051] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [21403.708056] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [21403.708123] printk: Suspending console(s) (use no_console_suspend to debug)
> [21404.224075] ACPI: EC: interrupt blocked
> [21404.246806] ACPI: PM: Preparing to enter system sleep state S3
> [21404.258931] ACPI: EC: event blocked
> [21404.258936] ACPI: EC: EC stopped
> [21404.258938] ACPI: PM: Saving platform NVS memory
> [21404.262393] Disabling non-boot CPUs ...
> [21404.264539] smpboot: CPU 3 is now offline
> [21404.269105] smpboot: CPU 2 is now offline
> [21404.274752] smpboot: CPU 1 is now offline
> [21404.288214] ACPI: PM: Low-level resume complete
> [21404.288258] ACPI: EC: EC started
> [21404.288259] ACPI: PM: Restoring platform NVS memory
> [21404.290141] Enabling non-boot CPUs ...
> [21404.290164] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [21404.290884] CPU1 is up
> [21404.290898] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [21404.291650] CPU2 is up
> [21404.291667] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [21404.292358] CPU3 is up
> [21404.295230] ACPI: PM: Waking up from system sleep state S3
> [21404.591082] ACPI: EC: interrupt unblocked
> [21404.591522] pcieport 0000:01:00.0: Unable to change power state from unknown to D0, device inaccessible
> [21404.597700] pcieport 0000:02:02.0: Unable to change power state from unknown to D0, device inaccessible
> [21404.597702] pcieport 0000:02:01.0: Unable to change power state from unknown to D0, device inaccessible
> [21404.597706] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [21404.613992] ACPI: EC: event unblocked
> [21404.626616] nvme nvme0: 4/0/0 default/read/poll queues
> [21404.884927] OOM killer enabled.
> [21404.884929] Restarting tasks: Starting
> [21404.884973] usb 1-3: USB disconnect, device number 23
> [21404.885540] pcieport 0000:02:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [21404.885656] pci_bus 0000:03: busn_res: [bus 03] is released
> [21404.885735] Restarting tasks: Done
> [21404.885754] random: crng reseeded on system resumption
> [21404.888319] pci_bus 0000:04: busn_res: [bus 04-38] is released
> [21404.889238] pci_bus 0000:39: busn_res: [bus 39] is released
> [21404.889463] pci_bus 0000:02: busn_res: [bus 02-39] is released
> [21404.922821] PM: suspend exit
> [21405.006892] usb 1-3: new full-speed USB device number 26 using xhci_hcd
> [21405.057413] Process accounting resumed
> [21405.144283] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [21405.144296] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [21405.146240] usb 1-4: USB disconnect, device number 24
> [21405.147150] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [21405.147155] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [21405.330888] usb 1-4: new full-speed USB device number 27 using xhci_hcd
> [21405.338576] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [21405.468437] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [21405.468443] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [21405.468445] usb 1-4: Product: Touchscreen
> [21405.468447] usb 1-4: Manufacturer: ELAN
> [21405.477580] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.000A/input/input78
> [21405.477774] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.000A/input/input79
> [21405.477833] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.000A/input/input80
> [21405.477943] hid-multitouch 0003:04F3:2234.000A: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [21405.478051] usb 1-5: USB disconnect, device number 25
> [21405.504583] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [21405.528638] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [21405.594913] usb 1-5: new high-speed USB device number 28 using xhci_hcd
> [21405.794733] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [21405.794747] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [21405.794753] usb 1-5: Product: Integrated_Webcam_HD
> [21405.794757] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [21405.805639] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [21417.199791] wlp58s0: authenticate with 04:f0:21:af:c3:e9 (local address=9c:b6:d0:d1:6a:b1)
> [21417.199801] wlp58s0: send auth to 04:f0:21:af:c3:e9 (try 1/3)
> [21417.201830] wlp58s0: authenticated
> [21417.202946] wlp58s0: associate with 04:f0:21:af:c3:e9 (try 1/3)
> [21417.205190] wlp58s0: RX AssocResp from 04:f0:21:af:c3:e9 (capab=0x1 status=0 aid=7)
> [21417.207894] wlp58s0: associated
> [22273.486368] wlp58s0: deauthenticating from 04:f0:21:af:c3:e9 by local choice (Reason: 3=DEAUTH_LEAVING)
> [22281.213936] wlp58s0: authenticate with 04:f0:21:af:c3:e9 (local address=9c:b6:d0:d1:6a:b1)
> [22281.213942] wlp58s0: send auth to 04:f0:21:af:c3:e9 (try 1/3)
> [22281.260640] wlp58s0: authenticated
> [22281.265264] wlp58s0: associate with 04:f0:21:af:c3:e9 (try 1/3)
> [22281.267558] wlp58s0: RX AssocResp from 04:f0:21:af:c3:e9 (capab=0x1 status=0 aid=7)
> [22281.270539] wlp58s0: associated
> [23060.976967] wlp58s0: deauthenticating from 04:f0:21:af:c3:e9 by local choice (Reason: 3=DEAUTH_LEAVING)
> [23062.657605] PM: suspend entry (deep)
> [23062.671494] Filesystems sync: 0.013 seconds
> [23062.692872] Freezing user space processes
> [23062.695603] Freezing user space processes completed (elapsed 0.002 seconds)
> [23062.695617] OOM killer disabled.
> [23062.695620] Freezing remaining freezable tasks
> [23062.697620] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [23062.697752] printk: Suspending console(s) (use no_console_suspend to debug)
> [23063.243695] ACPI: EC: interrupt blocked
> [23063.264522] ACPI: PM: Preparing to enter system sleep state S3
> [23063.280054] ACPI: EC: event blocked
> [23063.280059] ACPI: EC: EC stopped
> [23063.280061] ACPI: PM: Saving platform NVS memory
> [23063.283558] Disabling non-boot CPUs ...
> [23063.285694] smpboot: CPU 3 is now offline
> [23063.290550] smpboot: CPU 2 is now offline
> [23063.296572] smpboot: CPU 1 is now offline
> [23063.302309] ACPI: PM: Low-level resume complete
> [23063.302354] ACPI: EC: EC started
> [23063.302354] ACPI: PM: Restoring platform NVS memory
> [23063.304270] Enabling non-boot CPUs ...
> [23063.304298] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [23063.305012] CPU1 is up
> [23063.305027] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [23063.305756] CPU2 is up
> [23063.305772] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [23063.306475] CPU3 is up
> [23063.309343] ACPI: PM: Waking up from system sleep state S3
> [23063.339883] ACPI: EC: interrupt unblocked
> [23063.377034] ACPI: EC: event unblocked
> [23063.389534] nvme nvme0: 4/0/0 default/read/poll queues
> [23063.600258] OOM killer enabled.
> [23063.600260] Restarting tasks: Starting
> [23063.600334] usb 1-3: USB disconnect, device number 26
> [23063.602521] Restarting tasks: Done
> [23063.602539] random: crng reseeded on system resumption
> [23063.634299] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [23063.722306] usb 1-3: new full-speed USB device number 29 using xhci_hcd
> [23063.862762] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [23063.862790] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [23064.034138] PM: suspend exit
> [23064.035319] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [23064.035331] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [23064.042745] usb 1-4: USB disconnect, device number 27
> [23064.206348] Process accounting resumed
> [23064.282308] usb 1-4: new full-speed USB device number 30 using xhci_hcd
> [23064.396009] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [23064.419743] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [23064.419749] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [23064.419751] usb 1-4: Product: Touchscreen
> [23064.419757] usb 1-4: Manufacturer: ELAN
> [23064.420040] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [23064.429259] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.000B/input/input83
> [23064.429383] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.000B/input/input84
> [23064.429449] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.000B/input/input85
> [23064.429588] hid-multitouch 0003:04F3:2234.000B: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [23064.429800] usb 1-5: USB disconnect, device number 28
> [23064.575095] usb 1-5: new high-speed USB device number 31 using xhci_hcd
> [23064.770796] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [23064.770834] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [23064.770843] usb 1-5: Product: Integrated_Webcam_HD
> [23064.770850] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [23064.781901] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [23064.811160] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [23069.798929] wlp58s0: authenticate with 0c:8e:29:38:c1:2c (local address=9c:b6:d0:d1:6a:b1)
> [23069.798945] wlp58s0: send auth to 0c:8e:29:38:c1:2c (try 1/3)
> [23069.801345] wlp58s0: authenticated
> [23069.802294] wlp58s0: associate with 0c:8e:29:38:c1:2c (try 1/3)
> [23069.816452] wlp58s0: RX AssocResp from 0c:8e:29:38:c1:2c (capab=0x1511 status=0 aid=1)
> [23069.819917] wlp58s0: associated
> [23069.854620] wlp58s0: Limiting TX power to 20 (23 - 3) dBm as advertised by 0c:8e:29:38:c1:2c
> [23070.469067] wlp58s0: Ignore NSS change to invalid 4 in VHT opmode notif from 0c:8e:29:38:c1:2c
> [23083.024452] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [23083.024536] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [23083.024566] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [23083.024600] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [23083.024636] pci 0000:01:00.0: enabling Extended Tags
> [23083.024844] pci 0000:01:00.0: supports D1 D2
> [23083.024852] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [23083.025020] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [23083.031218] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [23083.031286] pci 0000:02:00.0: PCI bridge to [bus 03]
> [23083.031310] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [23083.031362] pci 0000:02:00.0: enabling Extended Tags
> [23083.031557] pci 0000:02:00.0: supports D1 D2
> [23083.031565] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [23083.032069] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [23083.032129] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [23083.032150] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [23083.032175] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [23083.032206] pci 0000:02:01.0: enabling Extended Tags
> [23083.032391] pci 0000:02:01.0: supports D1 D2
> [23083.032396] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [23083.032836] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [23083.032894] pci 0000:02:02.0: PCI bridge to [bus 39]
> [23083.032914] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [23083.032961] pci 0000:02:02.0: enabling Extended Tags
> [23083.033138] pci 0000:02:02.0: supports D1 D2
> [23083.033143] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [23083.033603] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [23083.033745] pci 0000:02:00.0: PCI bridge to [bus 03]
> [23083.033876] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [23083.034093] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [23083.034242] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [23083.034287] pci 0000:39:00.0: enabling Extended Tags
> [23083.034550] pci 0000:39:00.0: supports D1 D2
> [23083.034558] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [23083.035368] pci 0000:02:02.0: PCI bridge to [bus 39]
> [23083.035464] pci_bus 0000:02: Allocating resources
> [23083.035506] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [23083.035521] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [23083.035534] pci 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [23083.035552] pci 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [23083.035564] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [23083.035580] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [23083.035598] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [23083.035608] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [23083.035622] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [23083.035630] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [23083.035654] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [23083.035665] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [23083.035676] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [23083.035683] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [23083.035692] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [23083.035701] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [23083.035716] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [23083.035726] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [23083.035737] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [23083.035746] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [23083.035756] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [23083.035764] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [23083.035776] pci 0000:02:00.0: PCI bridge to [bus 03]
> [23083.035794] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [23083.035821] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [23083.035836] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [23083.035849] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [23083.035870] pci 0000:02:02.0: PCI bridge to [bus 39]
> [23083.035886] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [23083.035909] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [23083.035925] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [23083.035939] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [23083.039054] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [23083.039085] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [23083.040383] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [23083.041265] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [23083.041285] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [23083.041301] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [23083.041451] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [23083.041465] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [23083.041473] usb usb3: Product: xHCI Host Controller
> [23083.041481] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [23083.041489] usb usb3: SerialNumber: 0000:39:00.0
> [23083.043576] hub 3-0:1.0: USB hub found
> [23083.043654] hub 3-0:1.0: 2 ports detected
> [23083.048953] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [23083.048986] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [23083.048997] usb usb4: Product: xHCI Host Controller
> [23083.049006] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [23083.049014] usb usb4: SerialNumber: 0000:39:00.0
> [23083.050638] hub 4-0:1.0: USB hub found
> [23083.050684] hub 4-0:1.0: 2 ports detected
> [23083.054720] pci_bus 0000:02: Allocating resources
> [23083.054772] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [23083.054793] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [23083.054810] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [23083.054829] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [23083.054842] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [23083.054860] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [23083.054879] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [23083.054889] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [23083.054901] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [23083.054910] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [23083.054934] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [23083.054945] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [23083.054956] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [23083.054964] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [23083.054973] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [23083.054981] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [23083.054996] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [23083.055005] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [23083.055016] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [23083.055024] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [23083.055032] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [23083.055040] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [23083.294212] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [23083.432647] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [23083.432672] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [23083.432680] usb 3-1: Product: USB2.0 Hub             
> [23083.432694] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [23083.432699] usb 3-1: SerialNumber: 000000000
> [23083.436529] hub 3-1:1.0: USB hub found
> [23083.436753] hub 3-1:1.0: 5 ports detected
> [23083.560799] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [23083.605590] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [23083.605614] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [23083.605626] usb 4-1: Product: USB3.0 Hub             
> [23083.605635] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [23083.605644] usb 4-1: SerialNumber: 000000000
> [23083.609073] hub 4-1:1.0: USB hub found
> [23083.609183] hub 4-1:1.0: 4 ports detected
> [23084.150198] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [23084.288673] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [23084.288700] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [23084.288707] usb 3-1.1: Product: USB2.0 Hub             
> [23084.288721] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [23084.288726] usb 3-1.1: SerialNumber: 000000000
> [23084.290636] hub 3-1.1:1.0: USB hub found
> [23084.290897] hub 3-1.1:1.0: 4 ports detected
> [23084.384738] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [23084.443918] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [23084.443942] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [23084.443948] usb 4-1.1: Product: USB3.0 Hub             
> [23084.443954] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [23084.443967] usb 4-1.1: SerialNumber: 000000000
> [23084.446866] hub 4-1.1:1.0: USB hub found
> [23084.447023] hub 4-1.1:1.0: 4 ports detected
> [23084.514199] usb 3-1.5: new high-speed USB device number 4 using xhci_hcd
> [23084.603778] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [23084.603802] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [23084.603817] usb 3-1.5: Product: USB Billboard Device   
> [23084.603823] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [23084.603827] usb 3-1.5: SerialNumber: 0000000000000001
> [23084.674479] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [23084.691970] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [23084.691996] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [23084.692013] usb 4-1.4: Product: Mass Storage Device
> [23084.692018] usb 4-1.4: Manufacturer: Generic
> [23084.692032] usb 4-1.4: SerialNumber: 058F84688461
> [23084.696618] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [23084.698925] scsi host0: usb-storage 4-1.4:1.0
> [23084.966148] usb 3-1.1.3: new high-speed USB device number 5 using xhci_hcd
> [23085.698234] usb 4-1.1.3: new SuperSpeed USB device number 5 using xhci_hcd
> [23085.715437] usb 4-1.1.3: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
> [23085.715459] usb 4-1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [23085.715466] usb 4-1.1.3: Product: USB 10/100/1000 LAN
> [23085.715480] usb 4-1.1.3: Manufacturer: Realtek
> [23085.715485] usb 4-1.1.3: SerialNumber: 000001
> [23085.720783] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [23085.723169] scsi 0:0:0:1: Direct-Access     Generic- Micro SD/M2      1.08 PQ: 0 ANSI: 6
> [23085.724259] sd 0:0:0:1: [sdb] Media removed, stopped polling
> [23085.725290] sd 0:0:0:0: [sda] Media removed, stopped polling
> [23085.747020] sd 0:0:0:1: [sdb] Attached SCSI removable disk
> [23085.756654] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [23085.792303] r8152-cfgselector 4-1.1.3: reset SuperSpeed USB device number 5 using xhci_hcd
> [23085.866423] r8152 4-1.1.3:1.0 eth0: v1.12.13
> [23086.046108] r8152 4-1.1.3:1.0 enx00e04cf4ead4: renamed from eth0
> [23103.370597] usb 4-1.3: new SuperSpeed USB device number 6 using xhci_hcd
> [23103.401604] usb 4-1.3: New USB device found, idVendor=0bda, idProduct=0409, bcdDevice= 1.41
> [23103.401609] usb 4-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [23103.401611] usb 4-1.3: Product: 4-Port USB 3.0 Hub
> [23103.401612] usb 4-1.3: Manufacturer: Generic
> [23103.453933] hub 4-1.3:1.0: USB hub found
> [23103.456182] hub 4-1.3:1.0: 2 ports detected
> [23103.518017] usb 3-1.3: new high-speed USB device number 6 using xhci_hcd
> [23103.672502] usb 3-1.3: New USB device found, idVendor=0bda, idProduct=5409, bcdDevice= 1.41
> [23103.672511] usb 3-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [23103.672514] usb 3-1.3: Product: 4-Port USB 2.0 Hub
> [23103.672517] usb 3-1.3: Manufacturer: Generic
> [23103.674567] hub 3-1.3:1.0: USB hub found
> [23103.675648] hub 3-1.3:1.0: 4 ports detected
> [23103.958003] usb 3-1.3.3: new low-speed USB device number 7 using xhci_hcd
> [23104.050946] usb 3-1.3.3: New USB device found, idVendor=1bcf, idProduct=0005, bcdDevice= 0.14
> [23104.050970] usb 3-1.3.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [23104.050978] usb 3-1.3.3: Product: USB Optical Mouse
> [23104.062952] input: USB Optical Mouse as /devices/pci0000:00/0000:00:1c.0/0000:01:00.0/0000:02:02.0/0000:39:00.0/usb3/3-1/3-1.3/3-1.3.3/3-1.3.3:1.0/0003:1BCF:0005.000C/input/input87
> [23104.063959] hid-generic 0003:1BCF:0005.000C: input,hidraw2: USB HID v1.10 Mouse [USB Optical Mouse] on usb-0000:39:00.0-1.3.3/input0
> [23104.150029] usb 3-1.3.4: new low-speed USB device number 8 using xhci_hcd
> [23104.260999] usb 3-1.3.4: New USB device found, idVendor=413c, idProduct=2113, bcdDevice= 1.08
> [23104.261017] usb 3-1.3.4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [23104.261033] usb 3-1.3.4: Product: Dell KB216 Wired Keyboard
> [23104.273923] input: Dell KB216 Wired Keyboard as /devices/pci0000:00/0000:00:1c.0/0000:01:00.0/0000:02:02.0/0000:39:00.0/usb3/3-1/3-1.3/3-1.3.4/3-1.3.4:1.0/0003:413C:2113.000D/input/input88
> [23104.362857] hid-generic 0003:413C:2113.000D: input,hidraw3: USB HID v1.11 Keyboard [Dell KB216 Wired Keyboard] on usb-0000:39:00.0-1.3.4/input0
> [23104.369307] input: Dell KB216 Wired Keyboard System Control as /devices/pci0000:00/0000:00:1c.0/0000:01:00.0/0000:02:02.0/0000:39:00.0/usb3/3-1/3-1.3/3-1.3.4/3-1.3.4:1.1/0003:413C:2113.000E/input/input89
> [23104.422759] input: Dell KB216 Wired Keyboard Consumer Control as /devices/pci0000:00/0000:00:1c.0/0000:01:00.0/0000:02:02.0/0000:39:00.0/usb3/3-1/3-1.3/3-1.3.4/3-1.3.4:1.1/0003:413C:2113.000E/input/input90
> [23104.423430] hid-generic 0003:413C:2113.000E: input,hidraw4: USB HID v1.11 Device [Dell KB216 Wired Keyboard] on usb-0000:39:00.0-1.3.4/input1
> [24453.707738] usb 1-2: new full-speed USB device number 32 using xhci_hcd
> [24453.914984] usb 1-2: New USB device found, idVendor=047f, idProduct=c037, bcdDevice= 1.45
> [24453.915009] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [24453.915017] usb 1-2: Product: Plantronics Blackwire 315.1
> [24453.915031] usb 1-2: Manufacturer: Plantronics
> [24453.915036] usb 1-2: SerialNumber: F3D422B734B3EC4CAF12EA236AFCB5EA
> [24453.992384] input: Plantronics Plantronics Blackwire 315.1 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.3/0003:047F:C037.000F/input/input91
> [24454.048420] input: Plantronics Plantronics Blackwire 315.1 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.3/0003:047F:C037.000F/input/input92
> [24454.056459] input: Plantronics Plantronics Blackwire 315.1 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.3/0003:047F:C037.000F/input/input93
> [24454.057567] hid-generic 0003:047F:C037.000F: input,hiddev1,hidraw5: USB HID v1.11 Device [Plantronics Plantronics Blackwire 315.1] on usb-0000:00:14.0-2/input3
> [24454.911771] usb 1-2: Warning! Unlikely big volume range (=9234), cval->res is probably wrong.
> [24454.911794] usb 1-2: [11] FU [Sidetone Playback Volume] ch = 1, val = 0/9234/1
> [24455.377420] usbcore: registered new interface driver snd-usb-audio
> [28713.933578] usb 1-2: USB disconnect, device number 32
> [32038.393625] usb 3-1: USB disconnect, device number 2
> [32038.393636] usb 3-1.1: USB disconnect, device number 3
> [32038.397854] usb 3-1.3: USB disconnect, device number 6
> [32038.397867] usb 3-1.3.3: USB disconnect, device number 7
> [32038.429053] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [32038.429110] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [32038.429172] r8152 4-1.1.3:1.0 enx00e04cf4ead4: Stop submitting intr, status -108
> [32038.429220] xhci_hcd 0000:39:00.0: Timeout while waiting for configure endpoint command
> [32038.429635] usb 3-1.3.4: USB disconnect, device number 8
> [32038.546939] xhci_hcd 0000:39:00.0: remove, state 1
> [32038.546960] usb usb4: USB disconnect, device number 1
> [32038.569090] usb 4-1: USB disconnect, device number 2
> [32038.569117] usb 4-1.1: USB disconnect, device number 3
> [32038.569127] r8152-cfgselector 4-1.1.3: USB disconnect, device number 5
> [32038.638207] usb 4-1.3: USB disconnect, device number 6
> [32038.638477] usb 4-1.4: USB disconnect, device number 4
> [32038.739278] usb 3-1.5: USB disconnect, device number 4
> [32038.786232] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [32038.786245] xhci_hcd 0000:39:00.0: remove, state 1
> [32038.786248] usb usb3: USB disconnect, device number 1
> [32038.791302] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [32038.826186] pci_bus 0000:02: Allocating resources
> [32038.826208] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [32038.826214] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [32038.826219] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [32038.826223] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [32038.826226] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [32038.826229] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [32038.826234] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [32038.826237] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [32038.826240] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [32038.826242] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [32038.826248] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [32038.826250] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [32038.826252] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [32038.826253] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [32038.826255] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [32038.826257] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [32038.826260] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [32038.826262] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [32038.826264] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [32038.826265] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [32038.826267] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [32038.826269] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [32043.589899] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [32043.592089] pci_bus 0000:03: busn_res: [bus 03] is released
> [32043.596701] pci_bus 0000:04: busn_res: [bus 04-38] is released
> [32043.596910] pci_bus 0000:39: busn_res: [bus 39] is released
> [32043.597370] pci_bus 0000:02: busn_res: [bus 02-39] is released
> [32050.986762] wlp58s0: deauthenticating from 0c:8e:29:38:c1:2c by local choice (Reason: 3=DEAUTH_LEAVING)
> [32054.184925] ath10k_pci 0000:3a:00.0: failed to install key for vdev 0 peer 0c:8e:29:38:c1:2c: -110
> [32054.184942] wlp58s0: failed to remove key (0, 0c:8e:29:38:c1:2c) from hardware (-110)
> [32081.308852] PM: suspend entry (deep)
> [32081.320484] Filesystems sync: 0.011 seconds
> [32081.327183] Freezing user space processes
> [32081.328856] Freezing user space processes completed (elapsed 0.001 seconds)
> [32081.328860] OOM killer disabled.
> [32081.328861] Freezing remaining freezable tasks
> [32081.330217] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [32081.330265] printk: Suspending console(s) (use no_console_suspend to debug)
> [32081.850993] ACPI: EC: interrupt blocked
> [32081.872775] ACPI: PM: Preparing to enter system sleep state S3
> [32081.883931] ACPI: EC: event blocked
> [32081.883936] ACPI: EC: EC stopped
> [32081.883938] ACPI: PM: Saving platform NVS memory
> [32081.887450] Disabling non-boot CPUs ...
> [32081.889870] smpboot: CPU 3 is now offline
> [32081.896455] smpboot: CPU 2 is now offline
> [32081.903518] smpboot: CPU 1 is now offline
> [32081.912443] ACPI: PM: Low-level resume complete
> [32081.912487] ACPI: EC: EC started
> [32081.912488] ACPI: PM: Restoring platform NVS memory
> [32081.914359] Enabling non-boot CPUs ...
> [32081.914383] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [32081.915107] CPU1 is up
> [32081.915121] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [32081.915863] CPU2 is up
> [32081.915879] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [32081.916572] CPU3 is up
> [32081.919470] ACPI: PM: Waking up from system sleep state S3
> [32081.952988] ACPI: EC: interrupt unblocked
> [32081.970809] ACPI: EC: event unblocked
> [32081.982500] nvme nvme0: 4/0/0 default/read/poll queues
> [32082.197814] OOM killer enabled.
> [32082.197816] Restarting tasks: Starting
> [32082.197930] usb 1-3: USB disconnect, device number 29
> [32082.199678] Restarting tasks: Done
> [32082.199698] random: crng reseeded on system resumption
> [32082.208877] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [32082.378988] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [32082.488669] PM: suspend exit
> [32082.608918] usb 1-3: new full-speed USB device number 33 using xhci_hcd
> [32082.622215] Process accounting resumed
> [32082.754058] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [32082.754065] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [32082.769421] usb 1-4: USB disconnect, device number 30
> [32082.769875] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [32082.769878] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [32082.964889] usb 1-4: new full-speed USB device number 34 using xhci_hcd
> [32083.102387] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [32083.102395] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [32083.102397] usb 1-4: Product: Touchscreen
> [32083.102399] usb 1-4: Manufacturer: ELAN
> [32083.116263] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0010/input/input95
> [32083.116388] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0010/input/input96
> [32083.116447] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0010/input/input97
> [32083.116575] hid-multitouch 0003:04F3:2234.0010: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [32083.118868] usb 1-5: USB disconnect, device number 31
> [32083.126973] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [32083.150616] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [32083.236872] usb 1-5: new high-speed USB device number 35 using xhci_hcd
> [32083.437392] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [32083.437399] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [32083.437402] usb 1-5: Product: Integrated_Webcam_HD
> [32083.437403] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [32083.447947] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [32083.486032] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [32088.238463] wlp58s0: authenticate with 04:f0:21:a6:7b:08 (local address=9c:b6:d0:d1:6a:b1)
> [32088.238470] wlp58s0: send auth to 04:f0:21:a6:7b:08 (try 1/3)
> [32088.247348] wlp58s0: authenticated
> [32088.248994] wlp58s0: associate with 04:f0:21:a6:7b:08 (try 1/3)
> [32088.285670] wlp58s0: RX AssocResp from 04:f0:21:a6:7b:08 (capab=0x1 status=0 aid=8)
> [32088.288554] wlp58s0: associated
> [33488.102969] wlp58s0: deauthenticating from 04:f0:21:a6:7b:08 by local choice (Reason: 3=DEAUTH_LEAVING)
> [33489.635387] PM: suspend entry (deep)
> [33489.661036] Filesystems sync: 0.025 seconds
> [33489.676906] Freezing user space processes
> [33489.679403] Freezing user space processes completed (elapsed 0.002 seconds)
> [33489.679414] OOM killer disabled.
> [33489.679417] Freezing remaining freezable tasks
> [33489.681188] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [33489.681294] printk: Suspending console(s) (use no_console_suspend to debug)
> [33490.213513] ACPI: EC: interrupt blocked
> [33490.236228] ACPI: PM: Preparing to enter system sleep state S3
> [33490.245702] ACPI: EC: event blocked
> [33490.245706] ACPI: EC: EC stopped
> [33490.245708] ACPI: PM: Saving platform NVS memory
> [33490.248747] Disabling non-boot CPUs ...
> [33490.250772] smpboot: CPU 3 is now offline
> [33490.253980] smpboot: CPU 2 is now offline
> [33490.258920] smpboot: CPU 1 is now offline
> [33490.265416] ACPI: PM: Low-level resume complete
> [33490.265461] ACPI: EC: EC started
> [33490.265462] ACPI: PM: Restoring platform NVS memory
> [33490.267364] Enabling non-boot CPUs ...
> [33490.267389] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [33490.268111] CPU1 is up
> [33490.268125] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [33490.268865] CPU2 is up
> [33490.268880] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [33490.269567] CPU3 is up
> [33490.272447] ACPI: PM: Waking up from system sleep state S3
> [33490.302356] ACPI: EC: interrupt unblocked
> [33490.320511] ACPI: EC: event unblocked
> [33490.333878] nvme nvme0: 4/0/0 default/read/poll queues
> [33490.547728] OOM killer enabled.
> [33490.547731] Restarting tasks: Starting
> [33490.548505] usb 1-3: USB disconnect, device number 33
> [33490.548535] Restarting tasks: Done
> [33490.548557] random: crng reseeded on system resumption
> [33490.566389] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [33490.884990] PM: suspend exit
> [33491.007484] Process accounting resumed
> [33491.010420] usb 1-3: new full-speed USB device number 36 using xhci_hcd
> [33491.154422] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [33491.154430] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [33491.156625] usb 1-4: USB disconnect, device number 34
> [33491.157350] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [33491.157353] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [33491.374419] usb 1-4: new full-speed USB device number 37 using xhci_hcd
> [33491.511977] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [33491.511993] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [33491.511996] usb 1-4: Product: Touchscreen
> [33491.511999] usb 1-4: Manufacturer: ELAN
> [33491.512935] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [33491.525964] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0011/input/input100
> [33491.526231] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0011/input/input101
> [33491.526352] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0011/input/input102
> [33491.526607] hid-multitouch 0003:04F3:2234.0011: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [33491.528086] usb 1-5: USB disconnect, device number 35
> [33491.536183] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [33491.650417] usb 1-5: new high-speed USB device number 38 using xhci_hcd
> [33491.779447] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [33491.848422] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [33491.848430] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [33491.848432] usb 1-5: Product: Integrated_Webcam_HD
> [33491.848434] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [33491.856367] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [33496.573748] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [33496.573761] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [33496.577853] wlp58s0: authenticated
> [33496.578418] wlp58s0: associate with 9c:c8:fc:3d:47:9f (try 1/3)
> [33496.599557] wlp58s0: RX AssocResp from 9c:c8:fc:3d:47:9f (capab=0x1011 status=0 aid=2)
> [33496.601953] wlp58s0: associated
> [33496.687434] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 9c:c8:fc:3d:47:9f
> [33519.819979] wlp58s0: deauthenticating from 9c:c8:fc:3d:47:9f by local choice (Reason: 3=DEAUTH_LEAVING)
> [33520.394168] PM: suspend entry (deep)
> [33520.434468] Filesystems sync: 0.040 seconds
> [33520.440175] Freezing user space processes
> [33520.441895] Freezing user space processes completed (elapsed 0.001 seconds)
> [33520.441900] OOM killer disabled.
> [33520.441900] Freezing remaining freezable tasks
> [33520.443273] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [33520.443324] printk: Suspending console(s) (use no_console_suspend to debug)
> [33520.946232] ACPI: EC: interrupt blocked
> [33520.968152] ACPI: PM: Preparing to enter system sleep state S3
> [33520.979313] ACPI: EC: event blocked
> [33520.979318] ACPI: EC: EC stopped
> [33520.979320] ACPI: PM: Saving platform NVS memory
> [33520.982926] Disabling non-boot CPUs ...
> [33520.985204] smpboot: CPU 3 is now offline
> [33520.991377] smpboot: CPU 2 is now offline
> [33520.995664] smpboot: CPU 1 is now offline
> [33521.005106] ACPI: PM: Low-level resume complete
> [33521.005149] ACPI: EC: EC started
> [33521.005149] ACPI: PM: Restoring platform NVS memory
> [33521.007027] Enabling non-boot CPUs ...
> [33521.007051] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [33521.007776] CPU1 is up
> [33521.007791] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [33521.008546] CPU2 is up
> [33521.008562] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [33521.009252] CPU3 is up
> [33521.012160] ACPI: PM: Waking up from system sleep state S3
> [33521.045417] ACPI: EC: interrupt unblocked
> [33521.089012] ACPI: EC: event unblocked
> [33521.103273] nvme nvme0: 4/0/0 default/read/poll queues
> [33521.318387] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [33521.321890] OOM killer enabled.
> [33521.321894] Restarting tasks: Starting
> [33521.323209] usb 1-3: USB disconnect, device number 36
> [33521.323374] Restarting tasks: Done
> [33521.323807] random: crng reseeded on system resumption
> [33521.485336] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [33521.613813] PM: suspend exit
> [33521.738500] usb 1-3: new full-speed USB device number 39 using xhci_hcd
> [33521.841331] Process accounting resumed
> [33521.879340] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [33521.879348] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [33521.881133] usb 1-4: USB disconnect, device number 37
> [33521.881570] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [33521.881574] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [33522.071969] usb 1-4: new full-speed USB device number 40 using xhci_hcd
> [33522.219945] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [33522.219953] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [33522.219956] usb 1-4: Product: Touchscreen
> [33522.219959] usb 1-4: Manufacturer: ELAN
> [33522.230189] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0012/input/input105
> [33522.230357] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0012/input/input106
> [33522.230432] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0012/input/input107
> [33522.230586] hid-multitouch 0003:04F3:2234.0012: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [33522.232687] usb 1-5: USB disconnect, device number 38
> [33522.237290] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [33522.260155] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [33522.358354] usb 1-5: new high-speed USB device number 41 using xhci_hcd
> [33522.558932] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [33522.558938] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [33522.558940] usb 1-5: Product: Integrated_Webcam_HD
> [33522.558942] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [33522.566644] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [33522.589222] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [33522.966359] usb 1-1: new low-speed USB device number 42 using xhci_hcd
> [33523.118182] usb 1-1: New USB device found, idVendor=0bf8, idProduct=101e, bcdDevice= 1.09
> [33523.118189] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [33523.118191] usb 1-1: Product: Fujitsu Keyboard
> [33523.118193] usb 1-1: Manufacturer: Fujitsu
> [33523.131525] input: Fujitsu Fujitsu Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:0BF8:101E.0013/input/input109
> [33523.235288] hid-generic 0003:0BF8:101E.0013: input,hidraw2: USB HID v1.10 Keyboard [Fujitsu Fujitsu Keyboard] on usb-0000:00:14.0-1/input0
> [33523.245353] input: Fujitsu Fujitsu Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:0BF8:101E.0014/input/input110
> [33523.298466] input: Fujitsu Fujitsu Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:0BF8:101E.0014/input/input111
> [33523.299050] hid-generic 0003:0BF8:101E.0014: input,hiddev1,hidraw3: USB HID v1.10 Device [Fujitsu Fujitsu Keyboard] on usb-0000:00:14.0-1/input1
> [33524.678354] usb 1-2: new low-speed USB device number 43 using xhci_hcd
> [33524.817892] usb 1-2: New USB device found, idVendor=046d, idProduct=c077, bcdDevice=72.00
> [33524.817914] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [33524.817928] usb 1-2: Product: USB Optical Mouse
> [33524.817932] usb 1-2: Manufacturer: Logitech
> [33524.825589] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:046D:C077.0015/input/input112
> [33524.827932] hid-generic 0003:046D:C077.0015: input,hidraw4: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:14.0-2/input0
> [33527.285026] wlp58s0: authenticate with 94:64:24:4d:d7:f0 (local address=9c:b6:d0:d1:6a:b1)
> [33527.285034] wlp58s0: send auth to 94:64:24:4d:d7:f0 (try 1/3)
> [33527.285979] wlp58s0: authenticated
> [33527.286312] wlp58s0: associate with 94:64:24:4d:d7:f0 (try 1/3)
> [33527.293564] wlp58s0: RX AssocResp from 94:64:24:4d:d7:f0 (capab=0x11 status=0 aid=3)
> [33527.296176] wlp58s0: associated
> [33529.010321] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [33529.010357] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [33529.010369] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [33529.010382] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [33529.010397] pci 0000:01:00.0: enabling Extended Tags
> [33529.010510] pci 0000:01:00.0: supports D1 D2
> [33529.010512] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [33529.010606] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [33529.012687] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [33529.012724] pci 0000:02:00.0: PCI bridge to [bus 03]
> [33529.012736] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [33529.012764] pci 0000:02:00.0: enabling Extended Tags
> [33529.012872] pci 0000:02:00.0: supports D1 D2
> [33529.012874] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [33529.013133] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [33529.013167] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [33529.013181] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [33529.013194] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [33529.013211] pci 0000:02:01.0: enabling Extended Tags
> [33529.013320] pci 0000:02:01.0: supports D1 D2
> [33529.013322] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [33529.013548] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [33529.013581] pci 0000:02:02.0: PCI bridge to [bus 39]
> [33529.013592] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [33529.013620] pci 0000:02:02.0: enabling Extended Tags
> [33529.013724] pci 0000:02:02.0: supports D1 D2
> [33529.013726] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [33529.013955] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [33529.014024] pci 0000:02:00.0: PCI bridge to [bus 03]
> [33529.014092] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [33529.014212] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [33529.014316] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [33529.014339] pci 0000:39:00.0: enabling Extended Tags
> [33529.026671] pci 0000:39:00.0: supports D1 D2
> [33529.026676] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [33529.029526] pci 0000:02:02.0: PCI bridge to [bus 39]
> [33529.029578] pci_bus 0000:02: Allocating resources
> [33529.029605] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [33529.029609] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [33529.029613] pci 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [33529.029618] pci 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [33529.029622] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [33529.029626] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [33529.029632] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [33529.029634] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [33529.029638] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [33529.029640] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [33529.029646] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [33529.029649] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [33529.029652] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [33529.029654] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [33529.029655] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [33529.029657] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [33529.029661] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [33529.029663] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [33529.029666] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [33529.029668] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [33529.029670] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [33529.029673] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [33529.029676] pci 0000:02:00.0: PCI bridge to [bus 03]
> [33529.029682] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [33529.029693] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [33529.029698] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [33529.029703] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [33529.029711] pci 0000:02:02.0: PCI bridge to [bus 39]
> [33529.029717] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [33529.029726] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [33529.029731] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [33529.029736] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [33529.030737] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [33529.030745] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [33529.031878] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [33529.032276] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [33529.032283] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [33529.032288] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [33529.032351] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [33529.032355] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [33529.032357] usb usb3: Product: xHCI Host Controller
> [33529.032360] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [33529.032362] usb usb3: SerialNumber: 0000:39:00.0
> [33529.042001] hub 3-0:1.0: USB hub found
> [33529.042018] hub 3-0:1.0: 2 ports detected
> [33529.042764] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [33529.042770] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [33529.042773] usb usb4: Product: xHCI Host Controller
> [33529.042775] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [33529.042777] usb usb4: SerialNumber: 0000:39:00.0
> [33529.045322] hub 4-0:1.0: USB hub found
> [33529.045340] hub 4-0:1.0: 2 ports detected
> [33529.048542] pci_bus 0000:02: Allocating resources
> [33529.048564] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [33529.048570] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [33529.048574] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [33529.048578] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [33529.048581] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [33529.048584] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [33529.048589] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [33529.048591] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [33529.048594] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [33529.048595] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [33529.048601] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [33529.048603] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [33529.048605] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [33529.048607] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [33529.048609] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [33529.048611] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [33529.048615] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [33529.048617] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [33529.048619] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [33529.048621] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [33529.048623] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [33529.048625] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [33529.298300] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [33529.440701] usb 3-1: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.63
> [33529.440708] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [33529.440711] usb 3-1: Product: USB2.1 Hub
> [33529.440713] usb 3-1: Manufacturer: GenesysLogic
> [33529.441999] hub 3-1:1.0: USB hub found
> [33529.442260] hub 3-1:1.0: 4 ports detected
> [33529.558456] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [33529.581427] usb 4-1: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.63
> [33529.581434] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [33529.581436] usb 4-1: Product: USB3.1 Hub
> [33529.581437] usb 4-1: Manufacturer: GenesysLogic
> [33529.583798] hub 4-1:1.0: USB hub found
> [33529.584586] hub 4-1:1.0: 4 ports detected
> [33529.754324] usb 3-1.3: new high-speed USB device number 3 using xhci_hcd
> [33529.868698] usb 3-1.3: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.63
> [33529.868706] usb 3-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [33529.868709] usb 3-1.3: Product: USB2.1 Hub
> [33529.868711] usb 3-1.3: Manufacturer: GenesysLogic
> [33529.873331] hub 3-1.3:1.0: USB hub found
> [33529.873598] hub 3-1.3:1.0: 4 ports detected
> [33529.938476] usb 4-1.3: new SuperSpeed USB device number 3 using xhci_hcd
> [33529.961515] usb 4-1.3: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.63
> [33529.961521] usb 4-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [33529.961523] usb 4-1.3: Product: USB3.1 Hub
> [33529.961524] usb 4-1.3: Manufacturer: GenesysLogic
> [33529.984482] hub 4-1.3:1.0: USB hub found
> [33529.985309] hub 4-1.3:1.0: 4 ports detected
> [33530.050286] usb 3-1.4: new high-speed USB device number 4 using xhci_hcd
> [33530.830334] usb 3-1.3.2: new high-speed USB device number 5 using xhci_hcd
> [33531.586402] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [33531.603958] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [33531.603963] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [33531.603965] usb 4-1.4: Product: Mass Storage Device
> [33531.603966] usb 4-1.4: Manufacturer: Generic
> [33531.603968] usb 4-1.4: SerialNumber: 058F84688461
> [33531.607354] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [33531.608708] scsi host0: usb-storage 4-1.4:1.0
> [33531.698299] usb 3-1.3.4: new high-speed USB device number 6 using xhci_hcd
> [33531.810588] usb 3-1.3.4: New USB device found, idVendor=1da0, idProduct=2178, bcdDevice= 1.01
> [33531.810595] usb 3-1.3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [33531.810597] usb 3-1.3.4: Product: USB2.0 Hub
> [33531.810599] usb 3-1.3.4: Manufacturer: Parade Technologies, Inc.
> [33531.811751] hub 3-1.3.4:1.0: USB hub found
> [33531.811776] hub 3-1.3.4:1.0: 4 ports detected
> [33531.882335] usb 4-1.3.2: new SuperSpeed USB device number 5 using xhci_hcd
> [33531.898791] usb 4-1.3.2: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.00
> [33531.898799] usb 4-1.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [33531.898802] usb 4-1.3.2: Product: USB 10/100/1000 LAN
> [33531.898804] usb 4-1.3.2: Manufacturer: Realtek
> [33531.898807] usb 4-1.3.2: SerialNumber: 0013000000
> [33531.982825] r8152-cfgselector 4-1.3.2: reset SuperSpeed USB device number 5 using xhci_hcd
> [33532.046885] r8152 4-1.3.2:1.0 eth0: v1.12.13
> [33532.196242] r8152 4-1.3.2:1.0 enx00e04cfc7112: renamed from eth0
> [33532.354309] usb 3-1.3.4.4: new high-speed USB device number 7 using xhci_hcd
> [33532.476208] usb 3-1.3.4.4: New USB device found, idVendor=1da0, idProduct=3188, bcdDevice= 1.01
> [33532.476213] usb 3-1.3.4.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [33532.476215] usb 3-1.3.4.4: Product: Billboard Device
> [33532.476217] usb 3-1.3.4.4: Manufacturer: Parade Tech
> [33532.627297] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [33532.628220] sd 0:0:0:0: [sda] Media removed, stopped polling
> [33532.628590] scsi 0:0:0:1: Direct-Access     Generic- Micro SD/M2      1.08 PQ: 0 ANSI: 6
> [33532.629201] sd 0:0:0:1: [sdb] Media removed, stopped polling
> [33532.642401] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [33532.642460] sd 0:0:0:1: [sdb] Attached SCSI removable disk
> [33535.434862] r8152 4-1.3.2:1.0 enx00e04cfc7112: carrier on
> [33572.006117] usb 3-1.2: new full-speed USB device number 8 using xhci_hcd
> [33572.126776] usb 3-1.2: New USB device found, idVendor=046d, idProduct=0a4d, bcdDevice= 1.19
> [33572.126802] usb 3-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [33572.126813] usb 3-1.2: Product: Logitech G430 Gaming Headset
> [33572.126821] usb 3-1.2: Manufacturer: Logitech
> [33572.322187] input: Logitech Logitech G430 Gaming Headset as /devices/pci0000:00/0000:00:1c.0/0000:01:00.0/0000:02:02.0/0000:39:00.0/usb3/3-1/3-1.2/3-1.2:1.3/0003:046D:0A4D.0016/input/input113
> [33572.378631] hid-generic 0003:046D:0A4D.0016: input,hidraw5: USB HID v1.00 Device [Logitech Logitech G430 Gaming Headset] on usb-0000:39:00.0-1.2/input3
> [33617.828545] wlp58s0: deauthenticating from 94:64:24:4d:d7:f0 by local choice (Reason: 3=DEAUTH_LEAVING)
> [52828.318025] usb 3-1.2: USB disconnect, device number 8
> [52828.318140] usb 3-1.2: Unable to submit urb #0: -19 at snd_usb_queue_pending_output_urbs
> [54069.152364] PM: suspend entry (deep)
> [54069.165649] Filesystems sync: 0.013 seconds
> [54069.181636] Freezing user space processes
> [54069.183334] Freezing user space processes completed (elapsed 0.001 seconds)
> [54069.183337] OOM killer disabled.
> [54069.183338] Freezing remaining freezable tasks
> [54069.184774] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [54069.184825] printk: Suspending console(s) (use no_console_suspend to debug)
> [54069.714786] ACPI: EC: interrupt blocked
> [54069.738027] ACPI: PM: Preparing to enter system sleep state S3
> [54069.749263] ACPI: EC: event blocked
> [54069.749268] ACPI: EC: EC stopped
> [54069.749270] ACPI: PM: Saving platform NVS memory
> [54069.752776] Disabling non-boot CPUs ...
> [54069.754940] smpboot: CPU 3 is now offline
> [54069.758820] smpboot: CPU 2 is now offline
> [54069.763437] smpboot: CPU 1 is now offline
> [54069.772236] ACPI: PM: Low-level resume complete
> [54069.772280] ACPI: EC: EC started
> [54069.772281] ACPI: PM: Restoring platform NVS memory
> [54069.774166] Enabling non-boot CPUs ...
> [54069.774191] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [54069.774923] CPU1 is up
> [54069.774938] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [54069.775691] CPU2 is up
> [54069.775707] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [54069.776407] CPU3 is up
> [54069.779274] ACPI: PM: Waking up from system sleep state S3
> [54070.085061] ACPI: EC: interrupt unblocked
> [54070.085410] pcieport 0000:01:00.0: Unable to change power state from unknown to D0, device inaccessible
> [54070.090817] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [54070.090819] pcieport 0000:02:01.0: Unable to change power state from unknown to D0, device inaccessible
> [54070.090824] pcieport 0000:02:02.0: Unable to change power state from unknown to D0, device inaccessible
> [54070.094569] xhci_hcd 0000:39:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [54070.157325] ACPI: EC: event unblocked
> [54070.157438] xhci_hcd 0000:39:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [54070.157452] xhci_hcd 0000:39:00.0: Controller not ready at resume -19
> [54070.157454] xhci_hcd 0000:39:00.0: PCI post-resume error -19!
> [54070.157455] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [54070.157468] xhci_hcd 0000:39:00.0: PM: dpm_run_callback(): pci_pm_resume returns -19
> [54070.157474] xhci_hcd 0000:39:00.0: PM: failed to resume async: error -19
> [54070.168444] nvme nvme0: 4/0/0 default/read/poll queues
> [54072.695469] OOM killer enabled.
> [54072.695473] Restarting tasks: Starting
> [54072.695541] usb 1-1: USB disconnect, device number 42
> [54072.695605] usb 3-1: USB disconnect, device number 2
> [54072.695612] usb 3-1.3: USB disconnect, device number 3
> [54072.695616] usb 3-1.3.4: USB disconnect, device number 6
> [54072.695620] usb 3-1.3.4.4: USB disconnect, device number 7
> [54072.696826] Restarting tasks: Done
> [54072.696854] random: crng reseeded on system resumption
> [54072.696984] usb 4-1: USB disconnect, device number 2
> [54072.696998] usb 4-1.3: USB disconnect, device number 3
> [54072.697003] r8152-cfgselector 4-1.3.2: USB disconnect, device number 5
> [54072.703002] xhci_hcd 0000:39:00.0: remove, state 4
> [54072.703009] usb usb4: USB disconnect, device number 1
> [54072.735601] PM: suspend exit
> [54072.787896] usb 4-1.4: USB disconnect, device number 4
> [54072.871619] Process accounting resumed
> [54072.912277] rfkill: input handler enabled
> [54072.944014] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [54072.948552] rfkill: input handler disabled
> [54073.153691] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [54073.153709] xhci_hcd 0000:39:00.0: remove, state 4
> [54073.153712] usb usb3: USB disconnect, device number 1
> [54073.176451] xhci_hcd 0000:39:00.0: Host halt failed, -19
> [54073.176457] xhci_hcd 0000:39:00.0: Host not accessible, reset failed.
> [54073.176652] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [54073.177021] pcieport 0000:02:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [54073.177164] pci_bus 0000:03: busn_res: [bus 03] is released
> [54073.177314] pci_bus 0000:04: busn_res: [bus 04-38] is released
> [54073.177555] pci_bus 0000:39: busn_res: [bus 39] is released
> [54073.177676] pci_bus 0000:02: busn_res: [bus 02-39] is released
> [54073.203135] usb 1-2: USB disconnect, device number 43
> [54073.237237] usb 1-3: USB disconnect, device number 39
> [54073.383847] usb 1-3: new full-speed USB device number 44 using xhci_hcd
> [54073.525088] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [54073.525097] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [54073.528056] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [54073.528061] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [54073.528714] usb 1-4: USB disconnect, device number 40
> [54073.735885] usb 1-4: new full-speed USB device number 45 using xhci_hcd
> [54073.873728] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [54073.873737] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [54073.873740] usb 1-4: Product: Touchscreen
> [54073.873743] usb 1-4: Manufacturer: ELAN
> [54073.884508] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0017/input/input115
> [54073.884706] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0017/input/input116
> [54073.884797] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0017/input/input117
> [54073.884992] hid-multitouch 0003:04F3:2234.0017: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [54073.885181] usb 1-5: USB disconnect, device number 41
> [54073.886308] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [54073.910492] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [54074.035877] usb 1-5: new high-speed USB device number 46 using xhci_hcd
> [54074.236517] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [54074.236524] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [54074.236527] usb 1-5: Product: Integrated_Webcam_HD
> [54074.236530] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [54074.244583] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [54083.351210] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [54083.351219] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [54083.354801] wlp58s0: authenticated
> [54083.355922] wlp58s0: associate with 9c:c8:fc:3d:47:9f (try 1/3)
> [54083.390411] wlp58s0: RX AssocResp from 9c:c8:fc:3d:47:9f (capab=0x1011 status=0 aid=2)
> [54083.393197] wlp58s0: associated
> [54083.423984] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 9c:c8:fc:3d:47:9f
> [54501.593860] wlp58s0: deauthenticating from 9c:c8:fc:3d:47:9f by local choice (Reason: 3=DEAUTH_LEAVING)
> [54503.395604] PM: suspend entry (deep)
> [54503.413359] Filesystems sync: 0.017 seconds
> [54503.419111] Freezing user space processes
> [54503.420920] Freezing user space processes completed (elapsed 0.001 seconds)
> [54503.420924] OOM killer disabled.
> [54503.420925] Freezing remaining freezable tasks
> [54503.422433] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [54503.422485] printk: Suspending console(s) (use no_console_suspend to debug)
> [54503.967084] ACPI: EC: interrupt blocked
> [54503.986824] ACPI: PM: Preparing to enter system sleep state S3
> [54503.996879] ACPI: EC: event blocked
> [54503.996884] ACPI: EC: EC stopped
> [54503.996886] ACPI: PM: Saving platform NVS memory
> [54504.000130] Disabling non-boot CPUs ...
> [54504.002126] smpboot: CPU 3 is now offline
> [54504.006616] smpboot: CPU 2 is now offline
> [54504.011293] smpboot: CPU 1 is now offline
> [54504.020539] ACPI: PM: Low-level resume complete
> [54504.020582] ACPI: EC: EC started
> [54504.020583] ACPI: PM: Restoring platform NVS memory
> [54504.022470] Enabling non-boot CPUs ...
> [54504.022493] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [54504.023221] CPU1 is up
> [54504.023236] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [54504.023979] CPU2 is up
> [54504.023994] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [54504.024691] CPU3 is up
> [54504.027579] ACPI: PM: Waking up from system sleep state S3
> [54504.060879] ACPI: EC: interrupt unblocked
> [54504.096536] ACPI: EC: event unblocked
> [54504.109035] nvme nvme0: 4/0/0 default/read/poll queues
> [54504.328013] OOM killer enabled.
> [54504.328017] Restarting tasks: Starting
> [54504.328089] usb 1-3: USB disconnect, device number 44
> [54504.329553] Restarting tasks: Done
> [54504.329606] random: crng reseeded on system resumption
> [54504.342965] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [54504.458941] usb 1-3: new full-speed USB device number 47 using xhci_hcd
> [54504.596148] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [54504.596159] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [54504.614308] PM: suspend exit
> [54504.615296] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [54504.615305] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [54504.621899] usb 1-4: USB disconnect, device number 45
> [54504.816061] rfkill: input handler enabled
> [54504.830937] usb 1-4: new full-speed USB device number 48 using xhci_hcd
> [54504.841249] rfkill: input handler disabled
> [54504.847305] Process accounting resumed
> [54504.973588] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [54505.000077] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [54505.007073] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [54505.007081] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [54505.007083] usb 1-4: Product: Touchscreen
> [54505.007085] usb 1-4: Manufacturer: ELAN
> [54505.017795] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0018/input/input120
> [54505.019200] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0018/input/input121
> [54505.019271] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0018/input/input122
> [54505.019403] hid-multitouch 0003:04F3:2234.0018: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [54505.019993] usb 1-5: USB disconnect, device number 46
> [54505.138919] usb 1-5: new high-speed USB device number 49 using xhci_hcd
> [54505.339536] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [54505.339554] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [54505.339563] usb 1-5: Product: Integrated_Webcam_HD
> [54505.339568] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [54505.348331] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [54505.631664] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [54510.408903] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [54510.408909] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [54510.411843] wlp58s0: authenticated
> [54510.414874] wlp58s0: associate with 9c:c8:fc:3d:47:9f (try 1/3)
> [54510.434995] wlp58s0: RX AssocResp from 9c:c8:fc:3d:47:9f (capab=0x1011 status=0 aid=2)
> [54510.437547] wlp58s0: associated
> [54510.446248] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 9c:c8:fc:3d:47:9f
> [54515.613787] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [54515.613836] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [54515.613854] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [54515.613872] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [54515.613891] pci 0000:01:00.0: enabling Extended Tags
> [54515.614645] pci 0000:01:00.0: supports D1 D2
> [54515.614648] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [54515.614909] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [54515.683108] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [54515.683149] pci 0000:02:00.0: PCI bridge to [bus 03]
> [54515.683162] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [54515.683194] pci 0000:02:00.0: enabling Extended Tags
> [54515.683309] pci 0000:02:00.0: supports D1 D2
> [54515.683311] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [54515.683551] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [54515.683585] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [54515.683596] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [54515.683608] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [54515.683625] pci 0000:02:01.0: enabling Extended Tags
> [54515.683737] pci 0000:02:01.0: supports D1 D2
> [54515.683738] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [54515.683945] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [54515.683979] pci 0000:02:02.0: PCI bridge to [bus 39]
> [54515.683991] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [54515.684020] pci 0000:02:02.0: enabling Extended Tags
> [54515.684128] pci 0000:02:02.0: supports D1 D2
> [54515.684129] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [54515.684338] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [54515.684402] pci 0000:02:00.0: PCI bridge to [bus 03]
> [54515.684461] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [54515.684575] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [54515.684642] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [54515.684665] pci 0000:39:00.0: enabling Extended Tags
> [54515.684804] pci 0000:39:00.0: supports D1 D2
> [54515.684805] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [54515.685099] pci 0000:02:02.0: PCI bridge to [bus 39]
> [54515.685151] pci_bus 0000:02: Allocating resources
> [54515.685168] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [54515.685172] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [54515.685176] pci 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [54515.685181] pci 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [54515.685184] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [54515.685189] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [54515.685193] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [54515.685196] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [54515.685199] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [54515.685201] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [54515.685206] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [54515.685208] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [54515.685211] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [54515.685213] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [54515.685215] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [54515.685217] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [54515.685220] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [54515.685222] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [54515.685224] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [54515.685226] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [54515.685228] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [54515.685230] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [54515.685233] pci 0000:02:00.0: PCI bridge to [bus 03]
> [54515.685239] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [54515.685251] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [54515.685256] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [54515.685261] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [54515.685270] pci 0000:02:02.0: PCI bridge to [bus 39]
> [54515.685276] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [54515.685285] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [54515.685291] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [54515.685296] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [54515.686293] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [54515.686310] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [54515.687925] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [54515.688420] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [54515.688427] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [54515.688432] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [54515.688480] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [54515.688483] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [54515.688486] usb usb3: Product: xHCI Host Controller
> [54515.688488] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [54515.688489] usb usb3: SerialNumber: 0000:39:00.0
> [54515.688644] hub 3-0:1.0: USB hub found
> [54515.688653] hub 3-0:1.0: 2 ports detected
> [54515.689190] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [54515.689194] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [54515.689197] usb usb4: Product: xHCI Host Controller
> [54515.689199] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [54515.689201] usb usb4: SerialNumber: 0000:39:00.0
> [54515.689368] hub 4-0:1.0: USB hub found
> [54515.689379] hub 4-0:1.0: 2 ports detected
> [54515.701930] pci_bus 0000:02: Allocating resources
> [54515.701951] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [54515.701957] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [54515.701962] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [54515.701965] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [54515.701968] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [54515.701972] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [54515.701976] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [54515.701978] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [54515.701981] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [54515.701983] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [54515.701988] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [54515.701990] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [54515.701992] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [54515.701993] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [54515.701995] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [54515.701996] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [54515.701999] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [54515.702001] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [54515.702003] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [54515.702004] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [54515.702006] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [54515.702007] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [54515.938864] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [54516.077049] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [54516.077068] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [54516.077075] usb 3-1: Product: USB2.0 Hub             
> [54516.077081] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [54516.077087] usb 3-1: SerialNumber: 000000000
> [54516.080083] hub 3-1:1.0: USB hub found
> [54516.082800] hub 3-1:1.0: 5 ports detected
> [54516.206426] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [54516.262027] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [54516.262046] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [54516.262054] usb 4-1: Product: USB3.0 Hub             
> [54516.262061] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [54516.262066] usb 4-1: SerialNumber: 000000000
> [54516.264712] hub 4-1:1.0: USB hub found
> [54516.264828] hub 4-1:1.0: 4 ports detected
> [54516.790779] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [54516.937269] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [54516.937276] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [54516.937279] usb 3-1.1: Product: USB2.0 Hub             
> [54516.937281] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [54516.937283] usb 3-1.1: SerialNumber: 000000000
> [54516.938406] hub 3-1.1:1.0: USB hub found
> [54516.938621] hub 3-1.1:1.0: 4 ports detected
> [54517.033147] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [54517.092355] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [54517.092362] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [54517.092364] usb 4-1.1: Product: USB3.0 Hub             
> [54517.092366] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [54517.092367] usb 4-1.1: SerialNumber: 000000000
> [54517.095303] hub 4-1.1:1.0: USB hub found
> [54517.095444] hub 4-1.1:1.0: 4 ports detected
> [54517.162770] usb 3-1.5: new high-speed USB device number 4 using xhci_hcd
> [54517.256018] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [54517.256025] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [54517.256028] usb 3-1.5: Product: USB Billboard Device   
> [54517.256030] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [54517.256033] usb 3-1.5: SerialNumber: 0000000000000001
> [54517.330831] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [54517.348627] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [54517.348632] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [54517.348635] usb 4-1.4: Product: Mass Storage Device
> [54517.348637] usb 4-1.4: Manufacturer: Generic
> [54517.348640] usb 4-1.4: SerialNumber: 058F84688461
> [54517.352237] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [54517.352382] scsi host0: usb-storage 4-1.4:1.0
> [54517.606761] usb 3-1.1.3: new high-speed USB device number 5 using xhci_hcd
> [54517.782784] usb 3-1: USB disconnect, device number 2
> [54517.782792] usb 3-1.1: USB disconnect, device number 3
> [54517.802755] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [54517.802776] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [54517.871794] usb 3-1.1-port3: couldn't allocate usb_device
> [54517.871818] usb 4-1.1-port3: couldn't allocate usb_device
> [54517.872172] usb 3-1.5: USB disconnect, device number 4
> [54517.918771] usb 4-1: USB disconnect, device number 2
> [54517.918779] usb 4-1.1: USB disconnect, device number 3
> [54517.922867] usb 4-1.4: USB disconnect, device number 4
> [54520.639576] xhci_hcd 0000:39:00.0: remove, state 1
> [54520.639591] usb usb4: USB disconnect, device number 1
> [54520.640282] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [54520.640307] xhci_hcd 0000:39:00.0: remove, state 1
> [54520.640315] usb usb3: USB disconnect, device number 1
> [54520.641243] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [54520.655044] pci_bus 0000:02: Allocating resources
> [54520.655075] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [54520.655092] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [54520.655105] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [54520.655121] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [54520.655131] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [54520.655145] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [54520.655159] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [54520.655166] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [54520.655175] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [54520.655181] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [54520.655196] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [54520.655204] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [54520.655213] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [54520.655219] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [54520.655226] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [54520.655232] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [54520.655243] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [54520.655251] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [54520.655258] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [54520.655264] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [54520.655270] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [54520.655276] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [54525.715236] snd_hda_intel 0000:00:1f.3: Unstable LPIB (251608 >= 8192); disabling LPIB delay counting
> [54525.736760] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [54525.738653] pci_bus 0000:03: busn_res: [bus 03] is released
> [54525.740073] pci_bus 0000:04: busn_res: [bus 04-38] is released
> [54525.740280] pci_bus 0000:39: busn_res: [bus 39] is released
> [54525.740459] pci_bus 0000:02: busn_res: [bus 02-39] is released
> [55384.940733] wlp58s0: deauthenticating from 9c:c8:fc:3d:47:9f by local choice (Reason: 3=DEAUTH_LEAVING)
> [55386.531182] PM: suspend entry (deep)
> [55386.555488] Filesystems sync: 0.024 seconds
> [55386.563842] Freezing user space processes
> [55386.565610] Freezing user space processes completed (elapsed 0.001 seconds)
> [55386.565614] OOM killer disabled.
> [55386.565615] Freezing remaining freezable tasks
> [55386.567071] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [55386.567121] printk: Suspending console(s) (use no_console_suspend to debug)
> [55387.090085] ACPI: EC: interrupt blocked
> [55387.111687] ACPI: PM: Preparing to enter system sleep state S3
> [55387.121674] ACPI: EC: event blocked
> [55387.121678] ACPI: EC: EC stopped
> [55387.121680] ACPI: PM: Saving platform NVS memory
> [55387.124887] Disabling non-boot CPUs ...
> [55387.128239] smpboot: CPU 3 is now offline
> [55387.133206] smpboot: CPU 2 is now offline
> [55387.137814] smpboot: CPU 1 is now offline
> [55387.144862] ACPI: PM: Low-level resume complete
> [55387.144906] ACPI: EC: EC started
> [55387.144907] ACPI: PM: Restoring platform NVS memory
> [55387.146813] Enabling non-boot CPUs ...
> [55387.146837] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [55387.147562] CPU1 is up
> [55387.147578] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [55387.148331] CPU2 is up
> [55387.148347] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [55387.149033] CPU3 is up
> [55387.151929] ACPI: PM: Waking up from system sleep state S3
> [55387.181057] ACPI: EC: interrupt unblocked
> [55387.224098] ACPI: EC: event unblocked
> [55387.236164] nvme nvme0: 4/0/0 default/read/poll queues
> [55387.459332] OOM killer enabled.
> [55387.459334] Restarting tasks: Starting
> [55387.459384] usb 1-3: USB disconnect, device number 47
> [55387.459804] Restarting tasks: Done
> [55387.459822] random: crng reseeded on system resumption
> [55387.473837] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [55387.758461] PM: suspend exit
> [55387.877843] usb 1-3: new full-speed USB device number 50 using xhci_hcd
> [55387.890095] Process accounting resumed
> [55388.042825] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [55388.042833] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [55388.047714] usb 1-4: USB disconnect, device number 48
> [55388.048366] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [55388.048371] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [55388.237840] usb 1-4: new full-speed USB device number 51 using xhci_hcd
> [55388.393833] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [55388.393842] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [55388.393846] usb 1-4: Product: Touchscreen
> [55388.393849] usb 1-4: Manufacturer: ELAN
> [55388.406318] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [55388.406487] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0019/input/input125
> [55388.406658] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0019/input/input126
> [55388.406746] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0019/input/input127
> [55388.406928] hid-multitouch 0003:04F3:2234.0019: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [55388.407085] usb 1-5: USB disconnect, device number 49
> [55388.435531] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [55388.525828] usb 1-5: new high-speed USB device number 52 using xhci_hcd
> [55388.650566] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [55388.730266] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [55388.730272] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [55388.730275] usb 1-5: Product: Integrated_Webcam_HD
> [55388.730277] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [55388.738286] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [56170.675397] PM: suspend entry (deep)
> [56170.705154] Filesystems sync: 0.029 seconds
> [56170.711512] Freezing user space processes
> [56170.713254] Freezing user space processes completed (elapsed 0.001 seconds)
> [56170.713257] OOM killer disabled.
> [56170.713258] Freezing remaining freezable tasks
> [56170.714734] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [56170.714784] printk: Suspending console(s) (use no_console_suspend to debug)
> [56171.260652] ACPI: EC: interrupt blocked
> [56171.282807] ACPI: PM: Preparing to enter system sleep state S3
> [56171.298561] ACPI: EC: event blocked
> [56171.298565] ACPI: EC: EC stopped
> [56171.298567] ACPI: PM: Saving platform NVS memory
> [56171.301788] Disabling non-boot CPUs ...
> [56171.303806] smpboot: CPU 3 is now offline
> [56171.309047] smpboot: CPU 2 is now offline
> [56171.314005] smpboot: CPU 1 is now offline
> [56171.323229] ACPI: PM: Low-level resume complete
> [56171.323273] ACPI: EC: EC started
> [56171.323274] ACPI: PM: Restoring platform NVS memory
> [56171.325168] Enabling non-boot CPUs ...
> [56171.325191] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [56171.325929] CPU1 is up
> [56171.325945] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [56171.326693] CPU2 is up
> [56171.326709] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [56171.327396] CPU3 is up
> [56171.330268] ACPI: PM: Waking up from system sleep state S3
> [56171.360521] ACPI: EC: interrupt unblocked
> [56171.395575] ACPI: EC: event unblocked
> [56171.408347] nvme nvme0: 4/0/0 default/read/poll queues
> [56171.514795] OOM killer enabled.
> [56171.514797] Restarting tasks: Starting
> [56171.514826] usb 1-3: USB disconnect, device number 50
> [56171.515313] Restarting tasks: Done
> [56171.515333] random: crng reseeded on system resumption
> [56171.649810] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [56171.816416] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [56171.964406] PM: suspend exit
> [56172.093867] usb 1-3: new full-speed USB device number 53 using xhci_hcd
> [56172.201561] Process accounting resumed
> [56172.241971] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [56172.241985] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [56172.244866] usb 1-4: USB disconnect, device number 51
> [56172.245643] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [56172.245648] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [56172.441761] usb 1-4: new full-speed USB device number 54 using xhci_hcd
> [56172.579276] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [56172.579296] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [56172.579302] usb 1-4: Product: Touchscreen
> [56172.579313] usb 1-4: Manufacturer: ELAN
> [56172.596097] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001A/input/input130
> [56172.596629] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001A/input/input131
> [56172.596905] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001A/input/input132
> [56172.597464] hid-multitouch 0003:04F3:2234.001A: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [56172.597878] usb 1-5: USB disconnect, device number 52
> [56172.607217] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [56172.631616] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [56172.717789] usb 1-5: new high-speed USB device number 55 using xhci_hcd
> [56172.900737] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [56172.914277] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [56172.914285] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [56172.914289] usb 1-5: Product: Integrated_Webcam_HD
> [56172.914292] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [56172.923790] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [56183.453491] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [56183.453519] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [56183.455581] wlp58s0: authenticated
> [56183.457646] wlp58s0: associate with 9c:c8:fc:3d:47:9f (try 1/3)
> [56183.475085] wlp58s0: RX AssocResp from 9c:c8:fc:3d:47:9f (capab=0x1011 status=0 aid=2)
> [56183.477728] wlp58s0: associated
> [56183.567837] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 9c:c8:fc:3d:47:9f
> [58669.369151] rfkill: input handler enabled
> [58674.230965] rfkill: input handler disabled
> [58679.328956] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [58679.366063] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [58679.366084] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [58679.366105] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [58679.402855] pci 0000:01:00.0: enabling Extended Tags
> [58679.404176] pci 0000:01:00.0: supports D1 D2
> [58679.404182] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [58679.404391] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [58679.413643] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [58679.413711] pci 0000:02:00.0: PCI bridge to [bus 03]
> [58679.413731] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [58679.413790] pci 0000:02:00.0: enabling Extended Tags
> [58679.414275] pci 0000:02:00.0: supports D1 D2
> [58679.414284] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [58679.415843] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [58679.415915] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [58679.415945] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [58679.415979] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [58679.416026] pci 0000:02:01.0: enabling Extended Tags
> [58679.416207] pci 0000:02:01.0: supports D1 D2
> [58679.416210] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [58679.421749] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [58679.421816] pci 0000:02:02.0: PCI bridge to [bus 39]
> [58679.421840] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [58679.421890] pci 0000:02:02.0: enabling Extended Tags
> [58679.422503] pci 0000:02:02.0: supports D1 D2
> [58679.422508] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [58679.423108] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [58679.423960] pci 0000:02:00.0: PCI bridge to [bus 03]
> [58679.424095] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [58679.424338] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [58679.424480] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [58679.424530] pci 0000:39:00.0: enabling Extended Tags
> [58679.427114] pci 0000:39:00.0: supports D1 D2
> [58679.427123] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [58679.428758] pci 0000:02:02.0: PCI bridge to [bus 39]
> [58679.428838] pci_bus 0000:02: Allocating resources
> [58679.428871] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [58679.428881] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [58679.428888] pci 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [58679.428898] pci 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [58679.428904] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [58679.428911] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [58679.428920] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [58679.428925] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [58679.428930] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [58679.428934] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [58679.428946] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [58679.428951] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [58679.428955] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [58679.428959] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [58679.428963] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [58679.428967] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [58679.428974] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [58679.428978] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [58679.428983] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [58679.428987] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [58679.428991] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [58679.428995] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [58679.429000] pci 0000:02:00.0: PCI bridge to [bus 03]
> [58679.429010] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [58679.429028] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [58679.429037] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [58679.429045] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [58679.429057] pci 0000:02:02.0: PCI bridge to [bus 39]
> [58679.429066] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [58679.429083] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [58679.429096] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [58679.429105] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [58679.431538] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [58679.431562] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [58679.432757] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [58679.434825] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [58679.434843] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [58679.434859] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [58679.434993] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [58679.435004] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [58679.435013] usb usb3: Product: xHCI Host Controller
> [58679.435019] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [58679.435026] usb usb3: SerialNumber: 0000:39:00.0
> [58679.458135] hub 3-0:1.0: USB hub found
> [58679.458666] hub 3-0:1.0: 2 ports detected
> [58679.461120] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [58679.461135] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [58679.461143] usb usb4: Product: xHCI Host Controller
> [58679.461149] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [58679.461156] usb usb4: SerialNumber: 0000:39:00.0
> [58679.461705] hub 4-0:1.0: USB hub found
> [58679.461735] hub 4-0:1.0: 2 ports detected
> [58679.464538] pci_bus 0000:02: Allocating resources
> [58679.464578] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [58679.464595] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [58679.464607] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [58679.464621] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [58679.464632] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [58679.464646] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [58679.464662] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [58679.464671] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [58679.464681] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [58679.464688] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [58679.464706] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [58679.464713] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [58679.464721] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [58679.464727] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [58679.464734] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [58679.464739] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [58679.464753] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [58679.464761] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [58679.464768] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [58679.464776] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [58679.464784] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [58679.464789] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [58679.713461] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [58679.852666] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [58679.852683] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [58679.852689] usb 3-1: Product: USB2.0 Hub             
> [58679.852694] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [58679.852698] usb 3-1: SerialNumber: 000000000
> [58679.857779] hub 3-1:1.0: USB hub found
> [58679.857933] hub 3-1:1.0: 5 ports detected
> [58679.981750] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [58680.027886] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [58680.027902] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [58680.027908] usb 4-1: Product: USB3.0 Hub             
> [58680.027913] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [58680.027917] usb 4-1: SerialNumber: 000000000
> [58680.038479] hub 4-1:1.0: USB hub found
> [58680.038734] hub 4-1:1.0: 4 ports detected
> [58680.577343] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [58680.719968] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [58680.719984] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [58680.719991] usb 3-1.1: Product: USB2.0 Hub             
> [58680.719996] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [58680.720000] usb 3-1.1: SerialNumber: 000000000
> [58680.723177] hub 3-1.1:1.0: USB hub found
> [58680.723327] hub 3-1.1:1.0: 4 ports detected
> [58680.819735] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [58680.877687] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [58680.877699] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [58680.877702] usb 4-1.1: Product: USB3.0 Hub             
> [58680.877704] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [58680.877706] usb 4-1.1: SerialNumber: 000000000
> [58680.881170] hub 4-1.1:1.0: USB hub found
> [58680.881386] hub 4-1.1:1.0: 4 ports detected
> [58681.053488] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [58681.070983] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [58681.070990] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [58681.070992] usb 4-1.4: Product: Mass Storage Device
> [58681.070994] usb 4-1.4: Manufacturer: Generic
> [58681.070996] usb 4-1.4: SerialNumber: 058F84688461
> [58681.076100] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [58681.077381] scsi host0: usb-storage 4-1.4:1.0
> [58681.389523] usb 3-1.1.3: new high-speed USB device number 4 using xhci_hcd
> [58682.121535] usb 4-1.1.3: new SuperSpeed USB device number 5 using xhci_hcd
> [58682.138448] usb 4-1.1.3: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
> [58682.138470] usb 4-1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [58682.138479] usb 4-1.1.3: Product: USB 10/100/1000 LAN
> [58682.138486] usb 4-1.1.3: Manufacturer: Realtek
> [58682.138492] usb 4-1.1.3: SerialNumber: 000001
> [58682.218217] r8152-cfgselector 4-1.1.3: reset SuperSpeed USB device number 5 using xhci_hcd
> [58682.287051] r8152 4-1.1.3:1.0 eth0: v1.12.13
> [58682.444168] r8152 4-1.1.3:1.0 enx00e04ceb9e75: renamed from eth0
> [58682.749592] usb 4-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
> [58682.786430] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [58682.787552] sd 0:0:0:0: [sda] Media removed, stopped polling
> [58682.793674] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [58684.517279] usb 3-1.5: new high-speed USB device number 5 using xhci_hcd
> [58684.606785] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [58684.606806] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [58684.606814] usb 3-1.5: Product: USB Billboard Device   
> [58684.606820] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [58684.606826] usb 3-1.5: SerialNumber: 0000000000000001
> [58684.676983] rfkill: input handler enabled
> [58685.484450] r8152 4-1.1.3:1.0 enx00e04ceb9e75: carrier on
> [58687.943861] rfkill: input handler disabled
> [58690.307453] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [58690.307461] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [58690.309141] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 2/3)
> [58690.310379] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 3/3)
> [58690.311654] wlp58s0: authentication with 9c:c8:fc:3d:47:9f timed out
> [59623.521277] rfkill: input handler enabled
> [59627.471552] rfkill: input handler disabled
> [59633.472428] rfkill: input handler enabled
> [59635.957865] rfkill: input handler disabled
> [59637.021198] usb 3-1: USB disconnect, device number 2
> [59637.021203] usb 3-1.1: USB disconnect, device number 3
> [59637.022485] usb 3-1.5: USB disconnect, device number 5
> [59637.113650] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [59637.113674] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [59637.115142] r8152 4-1.1.3:1.0 enx00e04ceb9e75: Stop submitting intr, status -108
> [59637.131570] xhci_hcd 0000:39:00.0: remove, state 1
> [59637.131578] usb usb4: USB disconnect, device number 1
> [59637.212283] usb 4-1: USB disconnect, device number 2
> [59637.212291] usb 4-1.1: USB disconnect, device number 3
> [59637.212294] r8152-cfgselector 4-1.1.3: USB disconnect, device number 5
> [59637.289750] usb 4-1.4: USB disconnect, device number 4
> [59637.428589] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [59637.428605] xhci_hcd 0000:39:00.0: remove, state 1
> [59637.428610] usb usb3: USB disconnect, device number 1
> [59637.438581] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [59637.453965] pci_bus 0000:02: Allocating resources
> [59637.453996] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [59637.454003] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [59637.454006] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [59637.454010] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [59637.454012] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [59637.454017] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [59637.454023] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59637.454026] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59637.454031] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59637.454033] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59637.454038] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59637.454040] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59637.454042] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59637.454044] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59637.454045] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59637.454047] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59637.454051] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59637.454052] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59637.454054] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59637.454055] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59637.454057] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59637.454058] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59642.211565] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [59642.213309] pci_bus 0000:03: busn_res: [bus 03] is released
> [59642.213461] pci_bus 0000:04: busn_res: [bus 04-38] is released
> [59642.213579] pci_bus 0000:39: busn_res: [bus 39] is released
> [59642.213693] pci_bus 0000:02: busn_res: [bus 02-39] is released
> [59646.786264] PM: suspend entry (deep)
> [59646.808272] Filesystems sync: 0.022 seconds
> [59646.823435] Freezing user space processes
> [59646.825400] Freezing user space processes completed (elapsed 0.001 seconds)
> [59646.825410] OOM killer disabled.
> [59646.825413] Freezing remaining freezable tasks
> [59646.826838] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [59646.826941] printk: Suspending console(s) (use no_console_suspend to debug)
> [59647.357224] ACPI: EC: interrupt blocked
> [59647.379168] ACPI: PM: Preparing to enter system sleep state S3
> [59647.388432] ACPI: EC: event blocked
> [59647.388436] ACPI: EC: EC stopped
> [59647.388437] ACPI: PM: Saving platform NVS memory
> [59647.391417] Disabling non-boot CPUs ...
> [59647.393346] smpboot: CPU 3 is now offline
> [59647.398860] smpboot: CPU 2 is now offline
> [59647.403678] smpboot: CPU 1 is now offline
> [59647.413554] ACPI: PM: Low-level resume complete
> [59647.413597] ACPI: EC: EC started
> [59647.413598] ACPI: PM: Restoring platform NVS memory
> [59647.415500] Enabling non-boot CPUs ...
> [59647.415531] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [59647.416255] CPU1 is up
> [59647.416270] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [59647.417015] CPU2 is up
> [59647.417031] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [59647.417761] CPU3 is up
> [59647.420620] ACPI: PM: Waking up from system sleep state S3
> [59647.449547] ACPI: EC: interrupt unblocked
> [59647.464491] ACPI: EC: event unblocked
> [59647.476904] nvme nvme0: 4/0/0 default/read/poll queues
> [59647.582712] OOM killer enabled.
> [59647.582715] Restarting tasks: Starting
> [59647.582771] usb 1-3: USB disconnect, device number 53
> [59647.584476] Restarting tasks: Done
> [59647.584493] random: crng reseeded on system resumption
> [59647.681362] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [59647.709302] usb 1-3: new full-speed USB device number 56 using xhci_hcd
> [59647.846495] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [59647.846504] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [59647.978040] PM: suspend exit
> [59647.980004] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [59647.980015] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [59647.988816] usb 1-4: USB disconnect, device number 54
> [59648.189396] usb 1-4: new full-speed USB device number 57 using xhci_hcd
> [59648.239260] Process accounting resumed
> [59648.326813] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [59648.326822] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [59648.326831] usb 1-4: Product: Touchscreen
> [59648.326833] usb 1-4: Manufacturer: ELAN
> [59648.336832] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [59648.340349] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001B/input/input135
> [59648.340594] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001B/input/input136
> [59648.340694] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001B/input/input137
> [59648.340890] hid-multitouch 0003:04F3:2234.001B: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [59648.341059] usb 1-5: USB disconnect, device number 55
> [59648.359014] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [59648.461313] usb 1-5: new high-speed USB device number 58 using xhci_hcd
> [59648.657822] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [59648.657838] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [59648.657841] usb 1-5: Product: Integrated_Webcam_HD
> [59648.657843] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [59648.665834] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [59648.923447] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [59723.266674] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [59723.266738] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [59723.266762] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [59723.266787] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [59723.266814] pci 0000:01:00.0: enabling Extended Tags
> [59723.267212] pci 0000:01:00.0: supports D1 D2
> [59723.267219] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [59723.267369] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [59723.269116] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [59723.269177] pci 0000:02:00.0: PCI bridge to [bus 03]
> [59723.269200] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [59723.269246] pci 0000:02:00.0: enabling Extended Tags
> [59723.269420] pci 0000:02:00.0: supports D1 D2
> [59723.269428] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [59723.270010] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [59723.270070] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [59723.270092] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [59723.270117] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [59723.270148] pci 0000:02:01.0: enabling Extended Tags
> [59723.270325] pci 0000:02:01.0: supports D1 D2
> [59723.270332] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [59723.270847] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [59723.270905] pci 0000:02:02.0: PCI bridge to [bus 39]
> [59723.270926] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [59723.270972] pci 0000:02:02.0: enabling Extended Tags
> [59723.271143] pci 0000:02:02.0: supports D1 D2
> [59723.271150] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [59723.275395] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [59723.277505] pci 0000:02:00.0: PCI bridge to [bus 03]
> [59723.279977] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [59723.280266] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [59723.280372] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [59723.280411] pci 0000:39:00.0: enabling Extended Tags
> [59723.280656] pci 0000:39:00.0: supports D1 D2
> [59723.280664] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [59723.282006] pci 0000:02:02.0: PCI bridge to [bus 39]
> [59723.282089] pci_bus 0000:02: Allocating resources
> [59723.282124] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [59723.282137] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [59723.282148] pci 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [59723.282163] pci 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [59723.282172] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [59723.282185] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [59723.282199] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59723.282206] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59723.282215] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59723.282221] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59723.282239] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59723.282247] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59723.282255] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59723.282261] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59723.282269] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59723.282276] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59723.282287] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59723.282293] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59723.282299] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59723.282305] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59723.282311] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59723.282318] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59723.282326] pci 0000:02:00.0: PCI bridge to [bus 03]
> [59723.282340] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [59723.282359] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [59723.282371] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [59723.282382] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [59723.282398] pci 0000:02:02.0: PCI bridge to [bus 39]
> [59723.282411] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [59723.282429] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [59723.282440] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [59723.282451] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [59723.286062] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [59723.286087] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [59723.287314] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [59723.292755] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [59723.292774] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [59723.292791] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [59723.292959] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [59723.292972] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [59723.292979] usb usb3: Product: xHCI Host Controller
> [59723.292986] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [59723.292993] usb usb3: SerialNumber: 0000:39:00.0
> [59723.296304] hub 3-0:1.0: USB hub found
> [59723.296340] hub 3-0:1.0: 2 ports detected
> [59723.304302] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [59723.304319] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [59723.304328] usb usb4: Product: xHCI Host Controller
> [59723.304335] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [59723.304342] usb usb4: SerialNumber: 0000:39:00.0
> [59723.308265] hub 4-0:1.0: USB hub found
> [59723.309702] hub 4-0:1.0: 2 ports detected
> [59723.314753] pci_bus 0000:02: Allocating resources
> [59723.314794] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [59723.314808] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [59723.314817] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [59723.314829] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [59723.314836] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [59723.314846] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [59723.314857] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59723.314864] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59723.314872] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59723.314877] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59723.314890] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59723.314895] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59723.314901] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59723.314905] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59723.314910] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59723.314915] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59723.314923] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59723.314928] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59723.314934] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59723.314939] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59723.314943] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59723.314948] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59723.544647] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [59723.686949] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [59723.686964] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59723.686970] usb 3-1: Product: USB2.0 Hub             
> [59723.686975] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [59723.686979] usb 3-1: SerialNumber: 000000000
> [59723.689245] hub 3-1:1.0: USB hub found
> [59723.689474] hub 3-1:1.0: 5 ports detected
> [59723.814583] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [59723.857869] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [59723.857884] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59723.857891] usb 4-1: Product: USB3.0 Hub             
> [59723.857896] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [59723.857900] usb 4-1: SerialNumber: 000000000
> [59723.860272] hub 4-1:1.0: USB hub found
> [59723.860366] hub 4-1:1.0: 4 ports detected
> [59724.412612] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [59724.555105] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [59724.555120] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59724.555128] usb 3-1.1: Product: USB2.0 Hub             
> [59724.555134] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [59724.555138] usb 3-1.1: SerialNumber: 000000000
> [59724.556915] hub 3-1.1:1.0: USB hub found
> [59724.557158] hub 3-1.1:1.0: 4 ports detected
> [59724.651119] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [59724.714030] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [59724.714048] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59724.714056] usb 4-1.1: Product: USB3.0 Hub             
> [59724.714061] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [59724.714067] usb 4-1.1: SerialNumber: 000000000
> [59724.716299] hub 4-1.1:1.0: USB hub found
> [59724.716391] hub 4-1.1:1.0: 4 ports detected
> [59724.888720] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [59724.906618] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [59724.906630] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59724.906635] usb 4-1.4: Product: Mass Storage Device
> [59724.906640] usb 4-1.4: Manufacturer: Generic
> [59724.906644] usb 4-1.4: SerialNumber: 058F84688461
> [59724.908937] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [59724.909734] scsi host0: usb-storage 4-1.4:1.0
> [59725.228629] usb 3-1.1.3: new high-speed USB device number 4 using xhci_hcd
> [59725.917638] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [59725.918853] sd 0:0:0:0: [sda] Media removed, stopped polling
> [59725.919217] scsi 0:0:0:1: Direct-Access     Generic- Micro SD/M2      1.08 PQ: 0 ANSI: 6
> [59725.920247] sd 0:0:0:1: [sdb] Media removed, stopped polling
> [59725.924895] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [59725.932952] sd 0:0:0:1: [sdb] Attached SCSI removable disk
> [59728.344651] usb 3-1.5: new high-speed USB device number 5 using xhci_hcd
> [59728.434020] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [59728.434036] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59728.434044] usb 3-1.5: Product: USB Billboard Device   
> [59728.434049] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [59728.434054] usb 3-1.5: SerialNumber: 0000000000000001
> [59743.202845] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [59743.202888] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [59743.203007] hub 3-0:1.0: activate --> -19
> [59743.203146] usb 3-1: USB disconnect, device number 2
> [59743.203160] usb 3-1.1: USB disconnect, device number 3
> [59743.204447] usb 3-1.5: USB disconnect, device number 5
> [59743.260267] xhci_hcd 0000:39:00.0: remove, state 1
> [59743.260293] usb usb4: USB disconnect, device number 1
> [59743.304464] usb 4-1: USB disconnect, device number 2
> [59743.304485] usb 4-1.1: USB disconnect, device number 3
> [59743.308440] usb 4-1.4: USB disconnect, device number 4
> [59743.459864] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [59743.459879] xhci_hcd 0000:39:00.0: remove, state 1
> [59743.459884] usb usb3: USB disconnect, device number 1
> [59743.460353] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [59743.473055] pci_bus 0000:02: Allocating resources
> [59743.473075] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [59743.473083] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [59743.473090] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [59743.473097] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [59743.473103] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [59743.473110] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [59743.473117] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59743.473121] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59743.473126] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59743.473129] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59743.473138] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59743.473142] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59743.473146] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59743.473149] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59743.473153] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59743.473156] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59743.473162] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59743.473165] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59743.473169] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59743.473172] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59743.473176] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59743.473179] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59748.344346] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [59748.344499] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [59748.344541] pci 0000:39:00.0: enabling Extended Tags
> [59748.344749] pci 0000:39:00.0: supports D1 D2
> [59748.344755] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [59748.345329] pcieport 0000:02:02.0: ASPM: current common clock configuration is inconsistent, reconfiguring
> [59748.345444] pci_bus 0000:02: Allocating resources
> [59748.345474] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [59748.345486] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [59748.345495] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [59748.345507] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [59748.345515] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [59748.345525] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [59748.345536] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59748.345543] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59748.345550] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59748.345555] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59748.345569] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59748.345575] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59748.345581] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59748.345586] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59748.345591] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59748.345595] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59748.345604] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59748.345609] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59748.345615] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59748.345620] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59748.345624] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59748.345629] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59748.346430] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [59748.346458] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [59748.347745] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [59748.348784] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [59748.348806] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [59748.348823] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [59748.349526] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [59748.349543] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [59748.349553] usb usb3: Product: xHCI Host Controller
> [59748.349560] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [59748.349568] usb usb3: SerialNumber: 0000:39:00.0
> [59748.351454] hub 3-0:1.0: USB hub found
> [59748.351503] hub 3-0:1.0: 2 ports detected
> [59748.353732] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [59748.353751] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [59748.353761] usb usb4: Product: xHCI Host Controller
> [59748.353770] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [59748.353778] usb usb4: SerialNumber: 0000:39:00.0
> [59748.356096] hub 4-0:1.0: USB hub found
> [59748.356131] hub 4-0:1.0: 2 ports detected
> [59748.600494] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [59748.738723] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [59748.738740] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59748.738746] usb 3-1: Product: USB2.0 Hub             
> [59748.738751] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [59748.738755] usb 3-1: SerialNumber: 000000000
> [59748.740997] hub 3-1:1.0: USB hub found
> [59748.741180] hub 3-1:1.0: 5 ports detected
> [59748.864322] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [59748.905654] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [59748.905687] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59748.905710] usb 4-1: Product: USB3.0 Hub             
> [59748.905729] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [59748.905736] usb 4-1: SerialNumber: 000000000
> [59748.910014] hub 4-1:1.0: USB hub found
> [59748.911708] hub 4-1:1.0: 4 ports detected
> [59749.464470] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [59749.602974] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [59749.602990] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59749.602998] usb 3-1.1: Product: USB2.0 Hub             
> [59749.603003] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [59749.603008] usb 3-1.1: SerialNumber: 000000000
> [59749.604510] hub 3-1.1:1.0: USB hub found
> [59749.604699] hub 3-1.1:1.0: 4 ports detected
> [59749.697902] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [59749.760628] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [59749.760656] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59749.760670] usb 4-1.1: Product: USB3.0 Hub             
> [59749.760680] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [59749.760691] usb 4-1.1: SerialNumber: 000000000
> [59749.763674] hub 4-1.1:1.0: USB hub found
> [59749.763902] hub 4-1.1:1.0: 4 ports detected
> [59749.936525] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [59749.955040] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [59749.955070] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59749.955088] usb 4-1.4: Product: Mass Storage Device
> [59749.955094] usb 4-1.4: Manufacturer: Generic
> [59749.955109] usb 4-1.4: SerialNumber: 058F84688461
> [59749.958086] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [59749.961996] scsi host0: usb-storage 4-1.4:1.0
> [59750.280396] usb 3-1.1.3: new high-speed USB device number 4 using xhci_hcd
> [59751.020502] usb 4-1.1.3: new SuperSpeed USB device number 5 using xhci_hcd
> [59751.037519] usb 4-1.1.3: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
> [59751.037536] usb 4-1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [59751.037543] usb 4-1.1.3: Product: USB 10/100/1000 LAN
> [59751.037549] usb 4-1.1.3: Manufacturer: Realtek
> [59751.037554] usb 4-1.1.3: SerialNumber: 000001
> [59751.108451] usb 3-1.5: new high-speed USB device number 5 using xhci_hcd
> [59751.197813] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [59751.197830] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [59751.197838] usb 3-1.5: Product: USB Billboard Device   
> [59751.197844] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [59751.197849] usb 3-1.5: SerialNumber: 0000000000000001
> [59751.504876] usb 4-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
> [59751.537315] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [59751.538419] sd 0:0:0:0: [sda] Media removed, stopped polling
> [59751.548809] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [59751.593094] r8152-cfgselector 4-1.1.3: reset SuperSpeed USB device number 5 using xhci_hcd
> [59751.668520] r8152 4-1.1.3:1.0 eth0: v1.12.13
> [59751.846493] r8152 4-1.1.3:1.0 enx00e04ceb9e75: renamed from eth0
> [59753.469174] pci_bus 0000:02: Allocating resources
> [59753.469216] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [59753.469232] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [59753.469243] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [59753.469255] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [59753.469263] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [59753.469273] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [59753.469285] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59753.469292] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59753.469299] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [59753.469304] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [59753.469317] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59753.469323] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59753.469329] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59753.469334] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59753.469339] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59753.469343] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59753.469352] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [59753.469357] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [59753.469363] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [59753.469368] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [59753.469373] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [59753.469377] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [59757.085973] r8152 4-1.1.3:1.0 enx00e04ceb9e75: carrier on
> [59969.513956] sctp: Hash tables configured (bind 256/256)
> [67524.569625] PM: hibernation: hibernation entry
> [67524.643821] Filesystems sync: 0.066 seconds
> [67524.643911] Freezing user space processes
> [67524.645747] Freezing user space processes completed (elapsed 0.001 seconds)
> [67524.645753] OOM killer disabled.
> [67524.645938] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
> [67524.645943] PM: hibernation: Marking nosave pages: [mem 0x00058000-0x00058fff]
> [67524.645945] PM: hibernation: Marking nosave pages: [mem 0x0009e000-0x000fffff]
> [67524.645949] PM: hibernation: Marking nosave pages: [mem 0x556ab000-0x556acfff]
> [67524.645951] PM: hibernation: Marking nosave pages: [mem 0x6225f000-0x623ebfff]
> [67524.645960] PM: hibernation: Marking nosave pages: [mem 0x64df4000-0x6fffefff]
> [67524.646801] PM: hibernation: Marking nosave pages: [mem 0x70000000-0x77ffffff]
> [67524.646803] PM: hibernation: Marking nosave pages: [mem 0x78600000-0xffffffff]
> [67524.647379] PM: hibernation: Basic memory bitmaps created
> [67524.647381] PM: hibernation: Preallocating image memory
> [67536.651950] PM: hibernation: Allocated 1554416 pages for snapshot
> [67536.651956] PM: hibernation: Allocated 6217664 kbytes in 12.00 seconds (518.13 MB/s)
> [67536.651959] Freezing remaining freezable tasks
> [67536.653551] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [67541.886207] printk: Suspending console(s) (use no_console_suspend to debug)
> [67542.369761] ACPI: EC: interrupt blocked
> [67542.372338] Disabling non-boot CPUs ...
> [67542.375933] smpboot: CPU 3 is now offline
> [67542.381873] smpboot: CPU 2 is now offline
> [67542.385679] smpboot: CPU 1 is now offline
> [67542.390309] PM: hibernation: Creating image:
> [67542.733819] PM: hibernation: Need to copy 1374168 pages
> [67542.733822] PM: hibernation: Normal pages needed: 1374168 + 1024, available pages: 2715750
> [67543.772379] PM: hibernation: Image created (909687 pages copied, 464481 zero pages)
> [67542.391398] Enabling non-boot CPUs ...
> [67542.391425] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [67542.392264] CPU1 is up
> [67542.392284] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [67542.393171] CPU2 is up
> [67542.393190] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [67542.394022] CPU3 is up
> [67542.396020] ACPI: EC: interrupt unblocked
> [67542.431214] nvme nvme0: 4/0/0 default/read/poll queues
> [67542.710034] PM: Using 3 thread(s) for lzo compression
> [67542.710045] PM: Compressing and saving image data (912371 pages)...
> [67542.710106] PM: Image saving progress:   0%
> [67542.711101] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [67542.722707] r8152 4-1.1.3:1.0 enx00e04ceb9e75: carrier on
> [67543.776764] PM: Image saving progress:  10%
> [67544.696791] PM: Image saving progress:  20%
> [67545.360225] PM: Image saving progress:  30%
> [67546.020919] PM: Image saving progress:  40%
> [67546.567237] PM: Image saving progress:  50%
> [67547.347586] PM: Image saving progress:  60%
> [67548.338392] PM: Image saving progress:  70%
> [67549.338403] PM: Image saving progress:  80%
> [67550.283146] PM: Image saving progress:  90%
> [67550.937095] PM: Image saving progress: 100%
> [67550.938320] PM: Image saving done
> [67550.938324] PM: hibernation: Wrote 3649484 kbytes in 8.22 seconds (443.97 MB/s)
> [67550.938331] PM: Image size after compression: 650346 kbytes
> [67550.938492] PM: S|
> [67551.188782] printk: Suspending console(s) (use no_console_suspend to debug)
> [67551.667725] ACPI: EC: interrupt blocked
> [67551.690193] ACPI: PM: Preparing to enter system sleep state S3
> [67551.698625] ACPI: EC: event blocked
> [67551.698629] ACPI: EC: EC stopped
> [67551.698630] ACPI: PM: Saving platform NVS memory
> [67551.701367] Disabling non-boot CPUs ...
> [67551.704089] smpboot: CPU 3 is now offline
> [67551.708019] smpboot: CPU 2 is now offline
> [67551.710580] smpboot: CPU 1 is now offline
> [67551.717848] ACPI: PM: Low-level resume complete
> [67551.717899] ACPI: EC: EC started
> [67551.717900] ACPI: PM: Restoring platform NVS memory
> [67551.720055] Enabling non-boot CPUs ...
> [67551.720084] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [67551.720946] CPU1 is up
> [67551.720967] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [67551.721864] CPU2 is up
> [67551.721886] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [67551.722736] CPU3 is up
> [67551.726083] ACPI: PM: Waking up from system sleep state S3
> [67552.063160] ACPI: EC: interrupt unblocked
> [67552.083796] ACPI: EC: event unblocked
> [67552.086068] xhci_hcd 0000:39:00.0: xHC error in resume, USBSTS 0x411, Reinit
> [67552.086088] usb usb3: root hub lost power or was reset
> [67552.086092] usb usb4: root hub lost power or was reset
> [67552.097088] nvme nvme0: 4/0/0 default/read/poll queues
> [67552.370896] usb 3-1: reset high-speed USB device number 2 using xhci_hcd
> [67552.635629] usb 4-1: reset SuperSpeed USB device number 2 using xhci_hcd
> [67553.210817] usb 3-1.5: reset high-speed USB device number 5 using xhci_hcd
> [67553.418872] usb 3-1.1: reset high-speed USB device number 3 using xhci_hcd
> [67553.626865] usb 4-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
> [67553.715074] usb 4-1.1: reset SuperSpeed USB device number 3 using xhci_hcd
> [67554.426880] r8152-cfgselector 4-1.1.3: reset SuperSpeed USB device number 5 using xhci_hcd
> [67554.447726] r8152 4-1.1.3:1.0: skip request firmware
> [67554.496007] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [67554.500807] PM: hibernation: Basic memory bitmaps freed
> [67554.500912] OOM killer enabled.
> [67554.500913] Restarting tasks: Starting
> [67554.501003] usb 1-3: USB disconnect, device number 56
> [67554.501834] Restarting tasks: Done
> [67554.527158] pci_bus 0000:02: Allocating resources
> [67554.527198] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [67554.527214] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [67554.527219] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [67554.527238] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [67554.527242] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [67554.527246] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [67554.527258] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [67554.527261] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [67554.527272] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [67554.527281] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [67554.527287] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [67554.527289] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [67554.527292] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [67554.527295] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [67554.527304] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [67554.527314] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [67554.527320] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [67554.527330] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [67554.527334] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [67554.527337] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [67554.527340] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [67554.527343] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [67554.532572] pci_bus 0000:02: Allocating resources
> [67554.532596] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [67554.532612] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [67554.532619] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [67554.532628] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [67554.532632] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [67554.532640] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [67554.532654] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [67554.532659] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [67554.532664] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [67554.532668] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [67554.532678] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [67554.532682] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [67554.532694] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [67554.532698] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [67554.532702] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [67554.532706] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [67554.532713] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [67554.532717] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [67554.532722] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [67554.532733] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [67554.532737] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [67554.532741] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [67554.554458] PM: hibernation: hibernation exit
> [67554.674943] usb 1-3: new full-speed USB device number 59 using xhci_hcd
> [67554.812052] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [67554.812063] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [67554.822535] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [67554.822543] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [67554.824052] usb 1-4: USB disconnect, device number 57
> [67554.923277] Process accounting resumed
> [67555.034870] usb 1-4: new full-speed USB device number 60 using xhci_hcd
> [67555.172476] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [67555.172487] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [67555.172492] usb 1-4: Product: Touchscreen
> [67555.172503] usb 1-4: Manufacturer: ELAN
> [67555.181850] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [67555.190104] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001C/input/input140
> [67555.190378] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001C/input/input141
> [67555.190508] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001C/input/input142
> [67555.190945] hid-multitouch 0003:04F3:2234.001C: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [67555.191272] usb 1-5: USB disconnect, device number 58
> [67555.204557] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [67555.310829] usb 1-5: new high-speed USB device number 61 using xhci_hcd
> [67555.523231] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [67555.523242] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [67555.523247] usb 1-5: Product: Integrated_Webcam_HD
> [67555.523250] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [67555.531957] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [67557.321281] r8152 4-1.1.3:1.0 enx00e04ceb9e75: carrier on
> [68698.952654] usb 3-1: USB disconnect, device number 2
> [68698.952676] usb 3-1.1: USB disconnect, device number 3
> [68698.955227] usb 3-1.5: USB disconnect, device number 5
> [68699.037759] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [68699.037836] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [68699.037904] r8152 4-1.1.3:1.0 enx00e04ceb9e75: Stop submitting intr, status -108
> [68699.117842] xhci_hcd 0000:39:00.0: remove, state 1
> [68699.117877] usb usb4: USB disconnect, device number 1
> [68699.180268] usb 4-1: USB disconnect, device number 2
> [68699.180302] usb 4-1.1: USB disconnect, device number 3
> [68699.180315] r8152-cfgselector 4-1.1.3: USB disconnect, device number 5
> [68699.265855] usb 4-1.4: USB disconnect, device number 4
> [68699.334246] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [68699.334297] xhci_hcd 0000:39:00.0: remove, state 1
> [68699.334312] usb usb3: USB disconnect, device number 1
> [68699.336074] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [68699.408360] pci_bus 0000:02: Allocating resources
> [68699.408410] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [68699.408441] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [68699.408457] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [68699.408488] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [68699.408500] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [68699.408528] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [68699.408557] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [68699.408568] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [68699.408581] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [68699.408589] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [68699.408621] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [68699.408632] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [68699.408652] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [68699.408661] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [68699.408670] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [68699.408689] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [68699.408704] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [68699.408714] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [68699.408735] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [68699.408744] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [68699.408753] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [68699.408772] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [68700.846777] PM: suspend entry (deep)
> [68700.874138] Filesystems sync: 0.027 seconds
> [68700.901340] Freezing user space processes
> [68700.904814] Freezing user space processes completed (elapsed 0.003 seconds)
> [68700.904838] OOM killer disabled.
> [68700.904842] Freezing remaining freezable tasks
> [68700.906895] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
> [68700.907068] printk: Suspending console(s) (use no_console_suspend to debug)
> [68701.419653] ACPI: EC: interrupt blocked
> [68701.442492] ACPI: PM: Preparing to enter system sleep state S3
> [68701.456729] ACPI: EC: event blocked
> [68701.456735] ACPI: EC: EC stopped
> [68701.456737] ACPI: PM: Saving platform NVS memory
> [68701.461294] Disabling non-boot CPUs ...
> [68701.464054] smpboot: CPU 3 is now offline
> [68701.471159] smpboot: CPU 2 is now offline
> [68701.483647] smpboot: CPU 1 is now offline
> [68701.500092] ACPI: PM: Low-level resume complete
> [68701.500135] ACPI: EC: EC started
> [68701.500136] ACPI: PM: Restoring platform NVS memory
> [68701.502016] Enabling non-boot CPUs ...
> [68701.502043] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [68701.502777] CPU1 is up
> [68701.502791] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [68701.503540] CPU2 is up
> [68701.503556] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [68701.504261] CPU3 is up
> [68701.507160] ACPI: PM: Waking up from system sleep state S3
> [68701.804452] ACPI: EC: interrupt unblocked
> [68701.804895] pcieport 0000:01:00.0: Unable to change power state from unknown to D0, device inaccessible
> [68701.810328] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [68701.810331] pcieport 0000:02:01.0: Unable to change power state from unknown to D0, device inaccessible
> [68701.810334] pcieport 0000:02:02.0: Unable to change power state from unknown to D0, device inaccessible
> [68701.826766] ACPI: EC: event unblocked
> [68701.839066] nvme nvme0: 4/0/0 default/read/poll queues
> [68702.099939] OOM killer enabled.
> [68702.099943] Restarting tasks: Starting
> [68702.100315] usb 1-3: USB disconnect, device number 59
> [68702.104735] Restarting tasks: Done
> [68702.104767] random: crng reseeded on system resumption
> [68702.104785] pcieport 0000:02:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [68702.105580] pci_bus 0000:03: busn_res: [bus 03] is released
> [68702.113279] pci_bus 0000:04: busn_res: [bus 04-38] is released
> [68702.113763] pci_bus 0000:39: busn_res: [bus 39] is released
> [68702.114077] pci_bus 0000:02: busn_res: [bus 02-39] is released
> [68702.228770] usb 1-3: new full-speed USB device number 62 using xhci_hcd
> [68702.328497] PM: suspend exit
> [68702.369951] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [68702.369959] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [68702.372901] usb 1-4: USB disconnect, device number 60
> [68702.373504] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [68702.373508] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [68702.468620] Process accounting resumed
> [68702.552036] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [68702.564713] usb 1-4: new full-speed USB device number 63 using xhci_hcd
> [68702.706180] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [68702.706188] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [68702.706191] usb 1-4: Product: Touchscreen
> [68702.706194] usb 1-4: Manufacturer: ELAN
> [68702.715923] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001D/input/input145
> [68702.716076] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001D/input/input146
> [68702.716149] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.001D/input/input147
> [68702.716301] hid-multitouch 0003:04F3:2234.001D: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [68702.716428] usb 1-5: USB disconnect, device number 61
> [68702.731549] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [68702.754467] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [68702.844706] usb 1-5: new high-speed USB device number 64 using xhci_hcd
> [68703.049616] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [68703.049624] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [68703.049627] usb 1-5: Product: Integrated_Webcam_HD
> [68703.049630] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [68703.057493] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [68730.748510] PM: suspend entry (deep)
> [68730.757552] Filesystems sync: 0.009 seconds
> [68730.763000] Freezing user space processes
> [68730.764503] Freezing user space processes completed (elapsed 0.001 seconds)
> [68730.764507] OOM killer disabled.
> [68730.764508] Freezing remaining freezable tasks
> [68730.765816] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [68730.765866] printk: Suspending console(s) (use no_console_suspend to debug)
> [68731.277010] ACPI: EC: interrupt blocked
> [68731.299051] ACPI: PM: Preparing to enter system sleep state S3
> [68731.310146] ACPI: EC: event blocked
> [68731.310150] ACPI: EC: EC stopped
> [68731.310152] ACPI: PM: Saving platform NVS memory
> [68731.313740] Disabling non-boot CPUs ...
> [68731.316026] smpboot: CPU 3 is now offline
> [68731.321978] smpboot: CPU 2 is now offline
> [68731.327601] smpboot: CPU 1 is now offline
> [68731.338672] ACPI: PM: Low-level resume complete
> [68731.338741] ACPI: EC: EC started
> [68731.338742] ACPI: PM: Restoring platform NVS memory
> [68731.341278] Enabling non-boot CPUs ...
> [68731.341314] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [68731.342351] CPU1 is up
> [68731.342377] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [68731.343462] CPU2 is up
> [68731.343477] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [68731.344491] CPU3 is up
> [68731.348545] ACPI: PM: Waking up from system sleep state S3
> [68736.447221] ACPI: EC: interrupt unblocked
> [68736.467577] ACPI: EC: event unblocked
> [68736.484957] nvme nvme0: 4/0/0 default/read/poll queues
> [68736.673065] OOM killer enabled.
> [68736.673068] Restarting tasks: Starting
> [68736.673181] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [68736.673316] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [68736.673352] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [68736.673398] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [68736.673466] pci 0000:01:00.0: enabling Extended Tags
> [68736.673645] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [68736.674574] pci 0000:01:00.0: supports D1 D2
> [68736.674577] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [68736.674801] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [68736.677274] Restarting tasks: Done
> [68736.677304] random: crng reseeded on system resumption
> [68736.696011] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [68736.696064] pci 0000:02:00.0: PCI bridge to [bus 03]
> [68736.696075] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [68736.696130] pci 0000:02:00.0: enabling Extended Tags
> [68736.696297] pci 0000:02:00.0: supports D1 D2
> [68736.696304] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [68736.696878] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [68736.696948] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [68736.696981] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [68736.697014] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [68736.697052] pci 0000:02:01.0: enabling Extended Tags
> [68736.697277] pci 0000:02:01.0: supports D1 D2
> [68736.697279] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [68736.698440] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [68736.698549] pci 0000:02:02.0: PCI bridge to [bus 39]
> [68736.698577] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [68736.698625] pci 0000:02:02.0: enabling Extended Tags
> [68736.701246] pci 0000:02:02.0: supports D1 D2
> [68736.701251] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [68736.702875] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [68736.703212] pci 0000:02:00.0: PCI bridge to [bus 03]
> [68736.703372] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [68736.703536] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [68736.703628] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [68736.703664] pci 0000:39:00.0: enabling Extended Tags
> [68736.703866] pci 0000:39:00.0: supports D1 D2
> [68736.703867] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [68736.704368] pci 0000:02:02.0: PCI bridge to [bus 39]
> [68736.704455] pci_bus 0000:02: Allocating resources
> [68736.704493] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [68736.704496] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [68736.704498] pci 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [68736.704501] pci 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [68736.704503] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [68736.704506] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [68736.704509] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [68736.704511] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [68736.704513] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [68736.704514] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [68736.704529] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [68736.704530] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [68736.704532] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [68736.704533] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [68736.704535] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [68736.704536] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [68736.704539] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [68736.704540] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [68736.704542] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [68736.704543] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [68736.704544] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [68736.704546] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [68736.704547] pci 0000:02:00.0: PCI bridge to [bus 03]
> [68736.704553] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [68736.704583] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [68736.704595] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [68736.704614] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [68736.704628] pci 0000:02:02.0: PCI bridge to [bus 39]
> [68736.704638] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [68736.704661] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [68736.704667] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [68736.704673] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [68736.711389] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [68736.711429] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [68736.712837] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [68736.714535] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [68736.714541] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [68736.714545] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [68736.714596] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [68736.714598] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [68736.714600] usb usb3: Product: xHCI Host Controller
> [68736.714601] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [68736.714603] usb usb3: SerialNumber: 0000:39:00.0
> [68736.714833] hub 3-0:1.0: USB hub found
> [68736.714841] hub 3-0:1.0: 2 ports detected
> [68736.715466] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [68736.715481] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [68736.715483] usb usb4: Product: xHCI Host Controller
> [68736.715484] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [68736.715485] usb usb4: SerialNumber: 0000:39:00.0
> [68736.715709] hub 4-0:1.0: USB hub found
> [68736.715729] hub 4-0:1.0: 2 ports detected
> [68736.717612] pci_bus 0000:02: Allocating resources
> [68736.717640] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [68736.717644] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [68736.717646] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [68736.717649] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [68736.717651] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [68736.717654] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [68736.717657] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [68736.717671] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [68736.717672] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [68736.717673] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [68736.717677] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [68736.717679] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [68736.717680] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [68736.717682] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [68736.717683] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [68736.717684] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [68736.717687] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [68736.717688] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [68736.717689] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [68736.717691] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [68736.717692] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [68736.717693] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [68736.793896] usb 1-1: new low-speed USB device number 65 using xhci_hcd
> [68736.870793] PM: suspend exit
> [68736.938641] usb 1-1: New USB device found, idVendor=0bf8, idProduct=101e, bcdDevice= 1.09
> [68736.938660] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [68736.938663] usb 1-1: Product: Fujitsu Keyboard
> [68736.938665] usb 1-1: Manufacturer: Fujitsu
> [68736.954477] input: Fujitsu Fujitsu Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:0BF8:101E.001E/input/input150
> [68736.961900] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [68737.058146] hid-generic 0003:0BF8:101E.001E: input,hidraw2: USB HID v1.10 Keyboard [Fujitsu Fujitsu Keyboard] on usb-0000:00:14.0-1/input0
> [68737.068801] input: Fujitsu Fujitsu Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:0BF8:101E.001F/input/input151
> [68737.100590] Process accounting resumed
> [68737.109266] usb 3-1: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.63
> [68737.109274] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [68737.109287] usb 3-1: Product: USB2.1 Hub
> [68737.109289] usb 3-1: Manufacturer: GenesysLogic
> [68737.111101] hub 3-1:1.0: USB hub found
> [68737.111390] hub 3-1:1.0: 4 ports detected
> [68737.126113] input: Fujitsu Fujitsu Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:0BF8:101E.001F/input/input152
> [68737.126275] hid-generic 0003:0BF8:101E.001F: input,hiddev1,hidraw3: USB HID v1.10 Device [Fujitsu Fujitsu Keyboard] on usb-0000:00:14.0-1/input1
> [68737.229899] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [68737.253096] usb 4-1: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.63
> [68737.253114] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [68737.253117] usb 4-1: Product: USB3.1 Hub
> [68737.253119] usb 4-1: Manufacturer: GenesysLogic
> [68737.253892] usb 1-2: new low-speed USB device number 66 using xhci_hcd
> [68737.259393] hub 4-1:1.0: USB hub found
> [68737.260204] hub 4-1:1.0: 4 ports detected
> [68737.401395] usb 1-2: New USB device found, idVendor=046d, idProduct=c077, bcdDevice=72.00
> [68737.401404] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [68737.401407] usb 1-2: Product: USB Optical Mouse
> [68737.401409] usb 1-2: Manufacturer: Logitech
> [68737.404592] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:046D:C077.0020/input/input153
> [68737.406033] hid-generic 0003:046D:C077.0020: input,hidraw4: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:14.0-2/input0
> [68737.406181] usb 1-3: USB disconnect, device number 62
> [68737.425909] usb 3-1.3: new high-speed USB device number 3 using xhci_hcd
> [68737.533896] usb 1-3: new full-speed USB device number 67 using xhci_hcd
> [68737.544378] usb 3-1.3: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.63
> [68737.544385] usb 3-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [68737.544388] usb 3-1.3: Product: USB2.1 Hub
> [68737.544391] usb 3-1.3: Manufacturer: GenesysLogic
> [68737.550019] hub 3-1.3:1.0: USB hub found
> [68737.550334] hub 3-1.3:1.0: 4 ports detected
> [68737.622525] usb 4-1.3: new SuperSpeed USB device number 3 using xhci_hcd
> [68737.651250] usb 4-1.3: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.63
> [68737.651268] usb 4-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [68737.651270] usb 4-1.3: Product: USB3.1 Hub
> [68737.651272] usb 4-1.3: Manufacturer: GenesysLogic
> [68737.674638] hub 4-1.3:1.0: USB hub found
> [68737.675464] hub 4-1.3:1.0: 4 ports detected
> [68737.679706] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [68737.679713] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [68737.682945] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [68737.682950] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [68737.686098] usb 1-4: USB disconnect, device number 63
> [68737.881900] usb 1-4: new full-speed USB device number 68 using xhci_hcd
> [68738.023377] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [68738.023385] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [68738.023388] usb 1-4: Product: Touchscreen
> [68738.023390] usb 1-4: Manufacturer: ELAN
> [68738.039613] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0021/input/input154
> [68738.039817] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0021/input/input155
> [68738.039912] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0021/input/input156
> [68738.040106] hid-multitouch 0003:04F3:2234.0021: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [68738.040284] usb 1-5: USB disconnect, device number 64
> [68738.042319] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [68738.068551] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [68738.161898] usb 1-5: new high-speed USB device number 69 using xhci_hcd
> [68738.369864] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [68738.369883] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [68738.369886] usb 1-5: Product: Integrated_Webcam_HD
> [68738.369888] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [68738.378803] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [68739.097942] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [68739.115533] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [68739.115540] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [68739.115543] usb 4-1.4: Product: Mass Storage Device
> [68739.115545] usb 4-1.4: Manufacturer: Generic
> [68739.115547] usb 4-1.4: SerialNumber: 058F84688461
> [68739.117788] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [68739.125870] scsi host0: usb-storage 4-1.4:1.0
> [68739.217861] usb 3-1.3.4: new high-speed USB device number 6 using xhci_hcd
> [68739.330240] usb 3-1.3.4: New USB device found, idVendor=1da0, idProduct=2178, bcdDevice= 1.01
> [68739.330256] usb 3-1.3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [68739.330259] usb 3-1.3.4: Product: USB2.0 Hub
> [68739.330261] usb 3-1.3.4: Manufacturer: Parade Technologies, Inc.
> [68739.331559] hub 3-1.3.4:1.0: USB hub found
> [68739.331591] hub 3-1.3.4:1.0: 4 ports detected
> [68739.401948] usb 4-1.3.2: new SuperSpeed USB device number 5 using xhci_hcd
> [68739.418621] usb 4-1.3.2: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.00
> [68739.418624] usb 4-1.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [68739.418625] usb 4-1.3.2: Product: USB 10/100/1000 LAN
> [68739.418626] usb 4-1.3.2: Manufacturer: Realtek
> [68739.418627] usb 4-1.3.2: SerialNumber: 0013000000
> [68739.493456] r8152-cfgselector 4-1.3.2: reset SuperSpeed USB device number 5 using xhci_hcd
> [68739.553169] r8152 4-1.3.2:1.0 eth0: v1.12.13
> [68739.636255] r8152 4-1.3.2:1.0 enx00e04cfc7112: renamed from eth0
> [68739.893842] usb 3-1.3.4.4: new high-speed USB device number 7 using xhci_hcd
> [68740.015659] usb 3-1.3.4.4: New USB device found, idVendor=1da0, idProduct=3188, bcdDevice= 1.01
> [68740.015681] usb 3-1.3.4.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [68740.015682] usb 3-1.3.4.4: Product: Billboard Device
> [68740.015683] usb 3-1.3.4.4: Manufacturer: Parade Tech
> [68740.134894] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [68740.135861] sd 0:0:0:0: [sda] Media removed, stopped polling
> [68740.136183] scsi 0:0:0:1: Direct-Access     Generic- Micro SD/M2      1.08 PQ: 0 ANSI: 6
> [68740.136757] sd 0:0:0:1: [sdb] Media removed, stopped polling
> [68740.150125] sd 0:0:0:1: [sdb] Attached SCSI removable disk
> [68740.150140] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [68743.118024] r8152 4-1.3.2:1.0 enx00e04cfc7112: carrier on
> [74209.924018] audit: type=1400 audit(1755862951.747:134): apparmor="DENIED" operation="open" class="file" profile="/usr/bin/papers" name="/sys/devices/pci0000:00/0000:00:02.0/uevent" pid=168711 comm="papers" requested_mask="r" denied_mask="r" fsuid=5272 ouid=0
> [74209.924082] audit: type=1400 audit(1755862951.747:135): apparmor="DENIED" operation="open" class="file" profile="/usr/bin/papers" name="/sys/devices/pci0000:00/0000:00:02.0/uevent" pid=168711 comm="papers" requested_mask="r" denied_mask="r" fsuid=5272 ouid=0
> [74209.924859] audit: type=1400 audit(1755862951.747:136): apparmor="DENIED" operation="open" class="file" profile="/usr/bin/papers" name="/sys/devices/pci0000:00/0000:00:02.0/uevent" pid=168711 comm="papers" requested_mask="r" denied_mask="r" fsuid=5272 ouid=0
> [74209.924898] audit: type=1400 audit(1755862951.747:137): apparmor="DENIED" operation="open" class="file" profile="/usr/bin/papers" name="/sys/devices/pci0000:00/0000:00:02.0/uevent" pid=168711 comm="papers" requested_mask="r" denied_mask="r" fsuid=5272 ouid=0
> [74209.927894] audit: type=1400 audit(1755862951.751:138): apparmor="DENIED" operation="open" class="file" profile="/usr/bin/papers" name="/sys/devices/pci0000:00/0000:00:02.0/vendor" pid=168711 comm="papers" requested_mask="r" denied_mask="r" fsuid=5272 ouid=0
> [74209.927898] audit: type=1400 audit(1755862951.751:139): apparmor="DENIED" operation="open" class="file" profile="/usr/bin/papers" name="/sys/devices/pci0000:00/0000:00:02.0/device" pid=168711 comm="papers" requested_mask="r" denied_mask="r" fsuid=5272 ouid=0
> [74209.927977] audit: type=1400 audit(1755862951.751:140): apparmor="DENIED" operation="open" class="file" profile="/usr/bin/papers" name="/sys/devices/pci0000:00/0000:00:02.0/uevent" pid=168711 comm="papers" requested_mask="r" denied_mask="r" fsuid=5272 ouid=0
> [74209.928014] audit: type=1400 audit(1755862951.751:141): apparmor="DENIED" operation="open" class="file" profile="/usr/bin/papers" name="/sys/devices/pci0000:00/0000:00:02.0/uevent" pid=168711 comm="papers" requested_mask="r" denied_mask="r" fsuid=5272 ouid=0
> [74209.930101] audit: type=1400 audit(1755862951.751:142): apparmor="DENIED" operation="open" class="file" profile="/usr/bin/papers" name="/sys/devices/pci0000:00/0000:00:02.0/vendor" pid=168711 comm="papers" requested_mask="r" denied_mask="r" fsuid=5272 ouid=0
> [74209.930112] audit: type=1400 audit(1755862951.751:143): apparmor="DENIED" operation="open" class="file" profile="/usr/bin/papers" name="/sys/devices/pci0000:00/0000:00:02.0/device" pid=168711 comm="papers" requested_mask="r" denied_mask="r" fsuid=5272 ouid=0
> [82185.805647] PM: suspend entry (deep)
> [82185.815860] Filesystems sync: 0.010 seconds
> [82185.823793] Freezing user space processes
> [82185.825473] Freezing user space processes completed (elapsed 0.001 seconds)
> [82185.825475] OOM killer disabled.
> [82185.825476] Freezing remaining freezable tasks
> [82185.826869] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [82185.826928] printk: Suspending console(s) (use no_console_suspend to debug)
> [82186.330743] ACPI: EC: interrupt blocked
> [82186.352692] ACPI: PM: Preparing to enter system sleep state S3
> [82186.359125] ACPI: EC: event blocked
> [82186.359127] ACPI: EC: EC stopped
> [82186.359127] ACPI: PM: Saving platform NVS memory
> [82186.361667] Disabling non-boot CPUs ...
> [82186.363379] smpboot: CPU 3 is now offline
> [82186.366769] smpboot: CPU 2 is now offline
> [82186.369853] smpboot: CPU 1 is now offline
> [82186.376857] ACPI: PM: Low-level resume complete
> [82186.376902] ACPI: EC: EC started
> [82186.376903] ACPI: PM: Restoring platform NVS memory
> [82186.378788] Enabling non-boot CPUs ...
> [82186.378818] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [82186.379564] CPU1 is up
> [82186.379581] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [82186.380355] CPU2 is up
> [82186.380370] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [82186.381089] CPU3 is up
> [82186.383944] ACPI: PM: Waking up from system sleep state S3
> [82186.690071] ACPI: EC: interrupt unblocked
> [82186.690619] pcieport 0000:01:00.0: Unable to change power state from unknown to D0, device inaccessible
> [82186.696321] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [82186.696322] pcieport 0000:02:01.0: Unable to change power state from unknown to D0, device inaccessible
> [82186.696325] pcieport 0000:02:02.0: Unable to change power state from unknown to D0, device inaccessible
> [82186.700108] xhci_hcd 0000:39:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [82186.762943] ACPI: EC: event unblocked
> [82186.764128] xhci_hcd 0000:39:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [82186.764162] xhci_hcd 0000:39:00.0: Controller not ready at resume -19
> [82186.764165] xhci_hcd 0000:39:00.0: PCI post-resume error -19!
> [82186.764166] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [82186.764181] xhci_hcd 0000:39:00.0: PM: dpm_run_callback(): pci_pm_resume returns -19
> [82186.764233] xhci_hcd 0000:39:00.0: PM: failed to resume async: error -19
> [82186.773938] nvme nvme0: 4/0/0 default/read/poll queues
> [82189.295431] xhci_hcd 0000:39:00.0: remove, state 4
> [82189.295441] usb usb4: USB disconnect, device number 1
> [82189.295446] usb 4-1: USB disconnect, device number 2
> [82189.295451] usb 4-1.3: USB disconnect, device number 3
> [82189.295456] r8152-cfgselector 4-1.3.2: USB disconnect, device number 5
> [82189.295536] OOM killer enabled.
> [82189.295539] Restarting tasks: Starting
> [82189.295628] usb 1-1: USB disconnect, device number 65
> [82189.295770] usb 3-1: USB disconnect, device number 2
> [82189.295775] usb 3-1.3: USB disconnect, device number 3
> [82189.295778] usb 3-1.3.4: USB disconnect, device number 6
> [82189.295782] usb 3-1.3.4.4: USB disconnect, device number 7
> [82189.297456] Restarting tasks: Done
> [82189.297497] random: crng reseeded on system resumption
> [82189.330954] PM: suspend exit
> [82189.350004] usb 4-1.4: USB disconnect, device number 4
> [82189.438681] Process accounting resumed
> [82189.502978] rfkill: input handler enabled
> [82189.526131] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [82189.564827] rfkill: input handler disabled
> [82189.682247] usb 1-2: USB disconnect, device number 66
> [82189.746932] usb 1-3: USB disconnect, device number 67
> [82189.753213] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [82189.753226] xhci_hcd 0000:39:00.0: remove, state 4
> [82189.753229] usb usb3: USB disconnect, device number 1
> [82189.753428] xhci_hcd 0000:39:00.0: Host halt failed, -19
> [82189.753432] xhci_hcd 0000:39:00.0: Host not accessible, reset failed.
> [82189.753581] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [82189.754035] pcieport 0000:02:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [82189.754137] pci_bus 0000:03: busn_res: [bus 03] is released
> [82189.754960] pci_bus 0000:04: busn_res: [bus 04-38] is released
> [82189.817789] pci_bus 0000:39: busn_res: [bus 39] is released
> [82189.819766] pci_bus 0000:02: busn_res: [bus 02-39] is released
> [82189.924332] usb 1-3: new full-speed USB device number 70 using xhci_hcd
> [82190.061642] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [82190.061650] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [82190.064676] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [82190.064681] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [82190.064749] usb 1-4: USB disconnect, device number 68
> [82190.244293] usb 1-4: new full-speed USB device number 71 using xhci_hcd
> [82190.384131] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [82190.384152] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [82190.384162] usb 1-4: Product: Touchscreen
> [82190.384169] usb 1-4: Manufacturer: ELAN
> [82190.401783] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0022/input/input159
> [82190.402319] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0022/input/input160
> [82190.402612] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0022/input/input161
> [82190.403032] hid-multitouch 0003:04F3:2234.0022: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [82190.404820] usb 1-5: USB disconnect, device number 69
> [82190.423200] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [82190.446155] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [82190.532333] usb 1-5: new high-speed USB device number 72 using xhci_hcd
> [82190.729918] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [82190.729926] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [82190.729929] usb 1-5: Product: Integrated_Webcam_HD
> [82190.729932] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [82190.738037] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [82199.179862] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [82199.179876] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [82199.181569] wlp58s0: authenticated
> [82199.184261] wlp58s0: associate with 9c:c8:fc:3d:47:9f (try 1/3)
> [82199.218223] wlp58s0: RX AssocResp from 9c:c8:fc:3d:47:9f (capab=0x1011 status=0 aid=1)
> [82199.221421] wlp58s0: associated
> [82199.311705] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 9c:c8:fc:3d:47:9f
> [83578.432598] wlp58s0: deauthenticating from 9c:c8:fc:3d:47:9f by local choice (Reason: 3=DEAUTH_LEAVING)
> [83580.196287] PM: suspend entry (deep)
> [83580.266098] Filesystems sync: 0.069 seconds
> [83580.285946] Freezing user space processes
> [83580.288924] Freezing user space processes completed (elapsed 0.002 seconds)
> [83580.288937] OOM killer disabled.
> [83580.288941] Freezing remaining freezable tasks
> [83580.290964] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
> [83580.291081] printk: Suspending console(s) (use no_console_suspend to debug)
> [83580.834517] ACPI: EC: interrupt blocked
> [83580.856311] ACPI: PM: Preparing to enter system sleep state S3
> [83580.866277] ACPI: EC: event blocked
> [83580.866281] ACPI: EC: EC stopped
> [83580.866283] ACPI: PM: Saving platform NVS memory
> [83580.869504] Disabling non-boot CPUs ...
> [83580.871571] smpboot: CPU 3 is now offline
> [83580.878562] smpboot: CPU 2 is now offline
> [83580.886368] smpboot: CPU 1 is now offline
> [83580.896411] ACPI: PM: Low-level resume complete
> [83580.896456] ACPI: EC: EC started
> [83580.896457] ACPI: PM: Restoring platform NVS memory
> [83580.898340] Enabling non-boot CPUs ...
> [83580.898364] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [83580.899103] CPU1 is up
> [83580.899118] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [83580.899876] CPU2 is up
> [83580.899892] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [83580.900616] CPU3 is up
> [83580.903490] ACPI: PM: Waking up from system sleep state S3
> [83580.934878] ACPI: EC: interrupt unblocked
> [83580.949231] ACPI: EC: event unblocked
> [83580.959782] nvme nvme0: 4/0/0 default/read/poll queues
> [83581.168425] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [83581.226887] OOM killer enabled.
> [83581.226889] Restarting tasks: Starting
> [83581.227990] usb 1-3: USB disconnect, device number 70
> [83581.228139] Restarting tasks: Done
> [83581.228158] random: crng reseeded on system resumption
> [83581.332105] atkbd_receive_byte: 17 callbacks suppressed
> [83581.332113] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [83581.445775] PM: suspend exit
> [83581.568445] usb 1-3: new full-speed USB device number 73 using xhci_hcd
> [83581.680214] Process accounting resumed
> [83581.705713] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [83581.705720] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [83581.715126] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [83581.715133] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [83581.720826] usb 1-4: USB disconnect, device number 71
> [83581.908439] usb 1-4: new full-speed USB device number 74 using xhci_hcd
> [83582.045900] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [83582.045907] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [83582.045909] usb 1-4: Product: Touchscreen
> [83582.045917] usb 1-4: Manufacturer: ELAN
> [83582.056129] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0023/input/input164
> [83582.056547] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0023/input/input165
> [83582.056654] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0023/input/input166
> [83582.056862] hid-multitouch 0003:04F3:2234.0023: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [83582.057073] usb 1-5: USB disconnect, device number 72
> [83582.069862] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [83582.094227] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [83582.176433] usb 1-5: new high-speed USB device number 75 using xhci_hcd
> [83582.373091] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [83582.373108] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [83582.373115] usb 1-5: Product: Integrated_Webcam_HD
> [83582.373122] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [83582.383305] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [83582.397976] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [83871.908452] PM: suspend entry (deep)
> [83871.917510] Filesystems sync: 0.009 seconds
> [83871.923019] Freezing user space processes
> [83871.924785] Freezing user space processes completed (elapsed 0.001 seconds)
> [83871.924789] OOM killer disabled.
> [83871.924790] Freezing remaining freezable tasks
> [83871.926176] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [83871.926226] printk: Suspending console(s) (use no_console_suspend to debug)
> [83872.455365] ACPI: EC: interrupt blocked
> [83872.478021] ACPI: PM: Preparing to enter system sleep state S3
> [83872.489118] ACPI: EC: event blocked
> [83872.489123] ACPI: EC: EC stopped
> [83872.489125] ACPI: PM: Saving platform NVS memory
> [83872.492425] Disabling non-boot CPUs ...
> [83872.495551] smpboot: CPU 3 is now offline
> [83872.507593] smpboot: CPU 2 is now offline
> [83872.516714] smpboot: CPU 1 is now offline
> [83872.527017] ACPI: PM: Low-level resume complete
> [83872.527061] ACPI: EC: EC started
> [83872.527062] ACPI: PM: Restoring platform NVS memory
> [83872.528947] Enabling non-boot CPUs ...
> [83872.528970] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [83872.529710] CPU1 is up
> [83872.529725] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [83872.530510] CPU2 is up
> [83872.530527] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [83872.531242] CPU3 is up
> [83872.534088] ACPI: PM: Waking up from system sleep state S3
> [83872.561248] ACPI: EC: interrupt unblocked
> [83872.623810] ACPI: EC: event unblocked
> [83872.636723] nvme nvme0: 4/0/0 default/read/poll queues
> [83872.878182] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [83872.937757] OOM killer enabled.
> [83872.937761] Restarting tasks: Starting
> [83872.938004] usb 1-3: USB disconnect, device number 73
> [83872.938879] Restarting tasks: Done
> [83872.938913] random: crng reseeded on system resumption
> [83873.044977] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [83873.160246] PM: suspend exit
> [83873.290757] usb 1-3: new full-speed USB device number 76 using xhci_hcd
> [83873.396935] Process accounting resumed
> [83873.461773] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [83873.461781] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [83873.463804] usb 1-4: USB disconnect, device number 74
> [83873.464475] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [83873.464480] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [83873.666323] usb 1-4: new full-speed USB device number 77 using xhci_hcd
> [83873.804043] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [83873.804060] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [83873.804075] usb 1-4: Product: Touchscreen
> [83873.804080] usb 1-4: Manufacturer: ELAN
> [83873.819249] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0024/input/input169
> [83873.819552] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0024/input/input170
> [83873.819718] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0024/input/input171
> [83873.820041] hid-multitouch 0003:04F3:2234.0024: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [83873.820482] usb 1-5: USB disconnect, device number 75
> [83873.822530] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [83873.851981] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [83873.942195] usb 1-5: new high-speed USB device number 78 using xhci_hcd
> [83874.037915] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [83874.142763] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [83874.142769] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [83874.142771] usb 1-5: Product: Integrated_Webcam_HD
> [83874.142772] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [83874.151344] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [85447.815492] usbcore: deregistering interface driver btusb
> [86530.820274] PM: suspend entry (deep)
> [86530.827688] Filesystems sync: 0.007 seconds
> [86530.835460] Freezing user space processes
> [86530.837228] Freezing user space processes completed (elapsed 0.001 seconds)
> [86530.837232] OOM killer disabled.
> [86530.837233] Freezing remaining freezable tasks
> [86530.838723] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [86530.838772] printk: Suspending console(s) (use no_console_suspend to debug)
> [86531.363827] ACPI: EC: interrupt blocked
> [86531.387044] ACPI: PM: Preparing to enter system sleep state S3
> [86531.396430] ACPI: EC: event blocked
> [86531.396434] ACPI: EC: EC stopped
> [86531.396436] ACPI: PM: Saving platform NVS memory
> [86531.399318] Disabling non-boot CPUs ...
> [86531.401289] smpboot: CPU 3 is now offline
> [86531.406230] smpboot: CPU 2 is now offline
> [86531.410476] smpboot: CPU 1 is now offline
> [86531.419909] ACPI: PM: Low-level resume complete
> [86531.419953] ACPI: EC: EC started
> [86531.419953] ACPI: PM: Restoring platform NVS memory
> [86531.421839] Enabling non-boot CPUs ...
> [86531.421864] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [86531.422595] CPU1 is up
> [86531.422610] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [86531.423472] CPU2 is up
> [86531.423487] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [86531.424194] CPU3 is up
> [86531.427039] ACPI: PM: Waking up from system sleep state S3
> [86531.454219] ACPI: EC: interrupt unblocked
> [86531.517136] ACPI: EC: event unblocked
> [86531.530881] nvme nvme0: 4/0/0 default/read/poll queues
> [86531.771251] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [86531.829793] OOM killer enabled.
> [86531.829795] Restarting tasks: Starting
> [86531.829845] usb 1-3: USB disconnect, device number 76
> [86531.830958] Restarting tasks: Done
> [86531.830985] random: crng reseeded on system resumption
> [86531.938146] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [86531.951243] usb 1-3: new full-speed USB device number 79 using xhci_hcd
> [86532.078892] PM: suspend exit
> [86532.088448] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [86532.088457] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [86532.131209] usb 1-4: USB disconnect, device number 77
> [86532.196816] Process accounting resumed
> [86532.331219] usb 1-4: new full-speed USB device number 80 using xhci_hcd
> [86532.468647] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [86532.468658] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [86532.468660] usb 1-4: Product: Touchscreen
> [86532.468662] usb 1-4: Manufacturer: ELAN
> [86532.478325] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0025/input/input174
> [86532.478463] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0025/input/input175
> [86532.478519] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0025/input/input176
> [86532.478659] hid-multitouch 0003:04F3:2234.0025: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [86532.478780] usb 1-5: USB disconnect, device number 78
> [86532.599202] usb 1-5: new high-speed USB device number 81 using xhci_hcd
> [86532.795712] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [86532.795724] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [86532.795726] usb 1-5: Product: Integrated_Webcam_HD
> [86532.795728] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [86532.804676] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [86532.927272] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [86532.987440] usbcore: registered new interface driver btusb
> [86532.988108] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [86532.988112] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [86533.346531] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [86533.368985] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [86913.078687] wlp58s0: authenticate with 90:77:ee:75:07:0f (local address=9c:b6:d0:d1:6a:b1)
> [86913.078705] wlp58s0: send auth to 90:77:ee:75:07:0f (try 1/3)
> [86913.079596] wlp58s0: authenticated
> [86913.087968] wlp58s0: associate with 90:77:ee:75:07:0f (try 1/3)
> [86913.091409] wlp58s0: RX AssocResp from 90:77:ee:75:07:0f (capab=0x101 status=0 aid=13)
> [86913.094633] wlp58s0: associated
> [86913.116116] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 90:77:ee:75:07:0f
> [86913.648634] wlp58s0: deauthenticating from 90:77:ee:75:07:0f by local choice (Reason: 3=DEAUTH_LEAVING)
> [86920.958557] wlp58s0: authenticate with 7c:ad:4f:e8:3a:8f (local address=9c:b6:d0:d1:6a:b1)
> [86920.958575] wlp58s0: send auth to 7c:ad:4f:e8:3a:8f (try 1/3)
> [86920.959454] wlp58s0: authenticated
> [86920.963885] wlp58s0: associate with 7c:ad:4f:e8:3a:8f (try 1/3)
> [86920.967102] wlp58s0: RX AssocResp from 7c:ad:4f:e8:3a:8f (capab=0x101 status=0 aid=1)
> [86920.970386] wlp58s0: associated
> [86921.043983] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 7c:ad:4f:e8:3a:8f
> [86958.175085] wlp58s0: authenticate with 7c:ad:4f:e8:3a:8f (local address=9c:b6:d0:d1:6a:b1)
> [86958.175104] wlp58s0: send auth to 7c:ad:4f:e8:3a:8f (try 1/3)
> [86958.176485] wlp58s0: send auth to 7c:ad:4f:e8:3a:8f (try 2/3)
> [86958.177677] wlp58s0: send auth to 7c:ad:4f:e8:3a:8f (try 3/3)
> [86958.178825] wlp58s0: authentication with 7c:ad:4f:e8:3a:8f timed out
> [86977.001004] wlp58s0: authenticate with 00:81:c4:91:38:0f (local address=9c:b6:d0:d1:6a:b1)
> [86977.001012] wlp58s0: send auth to 00:81:c4:91:38:0f (try 1/3)
> [86977.001591] wlp58s0: authenticated
> [86977.003335] wlp58s0: associate with 00:81:c4:91:38:0f (try 1/3)
> [86977.005419] wlp58s0: RX AssocResp from 00:81:c4:91:38:0f (capab=0x101 status=0 aid=1)
> [86977.007874] wlp58s0: associated
> [86977.083657] wlp58s0: Limiting TX power to 17 dBm as advertised by 00:81:c4:91:38:0f
> [86983.991807] wlp58s0: deauthenticating from 00:81:c4:91:38:0f by local choice (Reason: 3=DEAUTH_LEAVING)
> [86991.771224] wlp58s0: authenticate with 00:81:c4:e7:11:0f (local address=9c:b6:d0:d1:6a:b1)
> [86991.771245] wlp58s0: send auth to 00:81:c4:e7:11:0f (try 1/3)
> [86991.771879] wlp58s0: authenticated
> [86991.775297] wlp58s0: associate with 00:81:c4:e7:11:0f (try 1/3)
> [86991.777524] wlp58s0: RX AssocResp from 00:81:c4:e7:11:0f (capab=0x101 status=0 aid=1)
> [86991.780733] wlp58s0: associated
> [86991.811363] wlp58s0: Limiting TX power to 17 dBm as advertised by 00:81:c4:e7:11:0f
> [87021.047341] wlp58s0: deauthenticating from 00:81:c4:e7:11:0f by local choice (Reason: 3=DEAUTH_LEAVING)
> [87119.560239] wlp58s0: authenticate with 00:81:c4:7c:ea:bf (local address=9c:b6:d0:d1:6a:b1)
> [87119.560259] wlp58s0: send auth to 00:81:c4:7c:ea:bf (try 1/3)
> [87119.561585] wlp58s0: send auth to 00:81:c4:7c:ea:bf (try 2/3)
> [87119.562712] wlp58s0: send auth to 00:81:c4:7c:ea:bf (try 3/3)
> [87119.563826] wlp58s0: authentication with 00:81:c4:7c:ea:bf timed out
> [87120.237114] wlp58s0: authenticate with 00:81:c4:7c:cf:0f (local address=9c:b6:d0:d1:6a:b1)
> [87120.237136] wlp58s0: send auth to 00:81:c4:7c:cf:0f (try 1/3)
> [87120.237827] wlp58s0: authenticated
> [87120.246128] wlp58s0: associate with 00:81:c4:7c:cf:0f (try 1/3)
> [87120.258386] wlp58s0: RX AssocResp from 00:81:c4:7c:cf:0f (capab=0x101 status=0 aid=1)
> [87120.262288] wlp58s0: associated
> [87120.280326] wlp58s0: Limiting TX power to 17 dBm as advertised by 00:81:c4:7c:cf:0f
> [87157.295525] wlp58s0: disconnect from AP 00:81:c4:7c:cf:0f for new auth to 00:81:c4:7c:ea:bf
> [87157.389887] wlp58s0: authenticate with 00:81:c4:7c:ea:bf (local address=9c:b6:d0:d1:6a:b1)
> [87157.389897] wlp58s0: send auth to 00:81:c4:7c:ea:bf (try 1/3)
> [87157.391198] wlp58s0: authenticated
> [87157.397781] wlp58s0: associate with 00:81:c4:7c:ea:bf (try 1/3)
> [87157.399872] wlp58s0: RX ReassocResp from 00:81:c4:7c:ea:bf (capab=0x101 status=0 aid=2)
> [87157.402117] wlp58s0: associated
> [87157.438687] wlp58s0: Limiting TX power to 17 dBm as advertised by 00:81:c4:7c:ea:bf
> [87566.382856] wlp58s0: deauthenticating from 00:81:c4:7c:ea:bf by local choice (Reason: 3=DEAUTH_LEAVING)
> [87568.068700] PM: suspend entry (deep)
> [87568.113375] Filesystems sync: 0.044 seconds
> [87568.120453] Freezing user space processes
> [87568.122246] Freezing user space processes completed (elapsed 0.001 seconds)
> [87568.122250] OOM killer disabled.
> [87568.122251] Freezing remaining freezable tasks
> [87568.123704] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [87568.123751] printk: Suspending console(s) (use no_console_suspend to debug)
> [87568.634528] ACPI: EC: interrupt blocked
> [87568.654668] ACPI: PM: Preparing to enter system sleep state S3
> [87568.664777] ACPI: EC: event blocked
> [87568.664781] ACPI: EC: EC stopped
> [87568.664783] ACPI: PM: Saving platform NVS memory
> [87568.668106] Disabling non-boot CPUs ...
> [87568.670161] smpboot: CPU 3 is now offline
> [87568.676460] smpboot: CPU 2 is now offline
> [87568.684658] smpboot: CPU 1 is now offline
> [87568.693574] ACPI: PM: Low-level resume complete
> [87568.693630] ACPI: EC: EC started
> [87568.693631] ACPI: PM: Restoring platform NVS memory
> [87568.696068] Enabling non-boot CPUs ...
> [87568.696104] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [87568.697093] CPU1 is up
> [87568.697119] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [87568.698159] CPU2 is up
> [87568.698176] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [87568.699150] CPU3 is up
> [87568.703068] ACPI: PM: Waking up from system sleep state S3
> [87568.742676] ACPI: EC: interrupt unblocked
> [87568.759754] ACPI: EC: event unblocked
> [87568.773128] nvme nvme0: 4/0/0 default/read/poll queues
> [87568.989372] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [87569.052425] OOM killer enabled.
> [87569.052428] Restarting tasks: Starting
> [87569.052776] usb 1-3: USB disconnect, device number 79
> [87569.055473] Restarting tasks: Done
> [87569.055509] random: crng reseeded on system resumption
> [87569.155838] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [87569.177900] usb 1-3: new full-speed USB device number 82 using xhci_hcd
> [87569.316802] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [87569.316843] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [87569.341409] PM: suspend exit
> [87569.346729] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [87569.346743] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [87569.354271] usb 1-4: USB disconnect, device number 80
> [87569.551185] usb 1-4: new full-speed USB device number 83 using xhci_hcd
> [87569.689444] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [87569.689489] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [87569.689518] usb 1-4: Product: Touchscreen
> [87569.689531] usb 1-4: Manufacturer: ELAN
> [87569.706231] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [87569.735210] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [87569.783472] Process accounting resumed
> [87569.906394] rfkill: input handler enabled
> [87570.115301] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0026/input/input179
> [87570.220809] rfkill: input handler disabled
> [87570.274556] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [87570.357591] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0026/input/input180
> [87570.426941] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0026/input/input181
> [87570.636737] hid-multitouch 0003:04F3:2234.0026: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [87570.637520] usb 1-5: USB disconnect, device number 81
> [87571.357403] usb 1-5: new high-speed USB device number 84 using xhci_hcd
> [87571.554539] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [87571.554583] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [87571.554594] usb 1-5: Product: Integrated_Webcam_HD
> [87571.554618] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [87571.567836] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [87577.021970] wlp58s0: authenticate with 00:81:c4:f6:11:7f (local address=9c:b6:d0:d1:6a:b1)
> [87577.022010] wlp58s0: send auth to 00:81:c4:f6:11:7f (try 1/3)
> [87577.024371] wlp58s0: authenticated
> [87577.029304] wlp58s0: associate with 00:81:c4:f6:11:7f (try 1/3)
> [87577.031466] wlp58s0: RX AssocResp from 00:81:c4:f6:11:7f (capab=0x101 status=0 aid=6)
> [87577.034624] wlp58s0: associated
> [87577.085690] wlp58s0: Limiting TX power to 17 dBm as advertised by 00:81:c4:f6:11:7f
> [87616.991173] wlp58s0: deauthenticating from 00:81:c4:f6:11:7f by local choice (Reason: 3=DEAUTH_LEAVING)
> [87618.909909] PM: suspend entry (deep)
> [87618.976669] Filesystems sync: 0.066 seconds
> [87619.010758] Freezing user space processes
> [87619.014323] Freezing user space processes completed (elapsed 0.003 seconds)
> [87619.014335] OOM killer disabled.
> [87619.014338] Freezing remaining freezable tasks
> [87619.016751] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
> [87619.016970] printk: Suspending console(s) (use no_console_suspend to debug)
> [87619.562346] ACPI: EC: interrupt blocked
> [87619.583148] ACPI: PM: Preparing to enter system sleep state S3
> [87619.607987] ACPI: EC: event blocked
> [87619.607993] ACPI: EC: EC stopped
> [87619.607995] ACPI: PM: Saving platform NVS memory
> [87619.608678] ACPI Error: AE_BAD_PARAMETER, Returned by Handler for [EmbeddedControl] (20250404/evregion-301)
> 
> [87619.608727] 
>                Initialized Local Variables for Method [ECR1]:
> [87619.608731]   Local0: 00000000e0e5a03a <Obj>           Integer 0000000000000000
> 
> [87619.608766] Initialized Arguments for Method [ECR1]:  (1 arguments defined for method invocation)
> [87619.608770]   Arg0:   00000000b56b808f <Obj>           Integer 000000000000000B
> 
> [87619.608801] ACPI Error: Aborting method \_SB.PCI0.LPCB.ECDV.ECR1 due to previous error (AE_BAD_PARAMETER) (20250404/psparse-529)
> [87619.608837] ACPI Error: Aborting method \_SB.PCI0.LPCB.ECDV.ECR2 due to previous error (AE_BAD_PARAMETER) (20250404/psparse-529)
> [87619.608852] ACPI Error: Aborting method \ECRW due to previous error (AE_BAD_PARAMETER) (20250404/psparse-529)
> [87619.608904] ACPI Error: Aborting method \ECGD due to previous error (AE_BAD_PARAMETER) (20250404/psparse-529)
> [87619.608941] ACPI Error: Aborting method \NEVT due to previous error (AE_BAD_PARAMETER) (20250404/psparse-529)
> [87619.608971] ACPI Error: Aborting method \_SB.PCI0.LPCB.ECDV._Q66 due to previous error (AE_BAD_PARAMETER) (20250404/psparse-529)
> [87619.613345] Disabling non-boot CPUs ...
> [87619.616430] smpboot: CPU 3 is now offline
> [87619.627287] smpboot: CPU 2 is now offline
> [87619.632436] smpboot: CPU 1 is now offline
> [87619.639381] ACPI: PM: Low-level resume complete
> [87619.639425] ACPI: EC: EC started
> [87619.639426] ACPI: PM: Restoring platform NVS memory
> [87619.641341] Enabling non-boot CPUs ...
> [87619.641369] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [87619.642103] CPU1 is up
> [87619.642117] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [87619.642890] CPU2 is up
> [87619.642907] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [87619.643630] CPU3 is up
> [87619.646502] ACPI: PM: Waking up from system sleep state S3
> [87619.675117] ACPI: EC: interrupt unblocked
> [87619.745662] ACPI: EC: event unblocked
> [87619.758669] nvme nvme0: 4/0/0 default/read/poll queues
> [87619.999758] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [87620.063886] OOM killer enabled.
> [87620.063890] Restarting tasks: Starting
> [87620.065528] usb 1-3: USB disconnect, device number 82
> [87620.066172] Restarting tasks: Done
> [87620.066220] random: crng reseeded on system resumption
> [87620.170433] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [87620.290669] PM: suspend exit
> [87620.401147] usb 1-3: new full-speed USB device number 85 using xhci_hcd
> [87620.541061] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [87620.541075] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [87620.553097] Process accounting resumed
> [87620.565945] usb 1-4: USB disconnect, device number 83
> [87620.569452] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [87620.569456] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [87620.759770] usb 1-4: new full-speed USB device number 86 using xhci_hcd
> [87620.897419] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [87620.897428] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [87620.897431] usb 1-4: Product: Touchscreen
> [87620.897433] usb 1-4: Manufacturer: ELAN
> [87620.908730] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0027/input/input184
> [87620.908965] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0027/input/input185
> [87620.909955] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0027/input/input186
> [87620.910691] hid-multitouch 0003:04F3:2234.0027: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [87620.912167] usb 1-5: USB disconnect, device number 84
> [87620.925059] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [87620.949494] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [87621.031784] usb 1-5: new high-speed USB device number 87 using xhci_hcd
> [87621.144484] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [87621.228793] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [87621.228807] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [87621.228810] usb 1-5: Product: Integrated_Webcam_HD
> [87621.228813] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [87621.236898] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [87625.705155] wlp58s0: authenticate with 00:81:c4:f6:11:7f (local address=9c:b6:d0:d1:6a:b1)
> [87625.705172] wlp58s0: send auth to 00:81:c4:f6:11:7f (try 1/3)
> [87625.705991] wlp58s0: authenticated
> [87625.707736] wlp58s0: associate with 00:81:c4:f6:11:7f (try 1/3)
> [87625.709686] wlp58s0: RX AssocResp from 00:81:c4:f6:11:7f (capab=0x101 status=0 aid=6)
> [87625.712927] wlp58s0: associated
> [87625.775915] wlp58s0: Limiting TX power to 17 dBm as advertised by 00:81:c4:f6:11:7f
> [87987.848667] wlp58s0: deauthenticating from 00:81:c4:f6:11:7f by local choice (Reason: 3=DEAUTH_LEAVING)
> [87989.870723] PM: suspend entry (deep)
> [87989.884232] Filesystems sync: 0.013 seconds
> [87989.890455] Freezing user space processes
> [87989.892261] Freezing user space processes completed (elapsed 0.001 seconds)
> [87989.892265] OOM killer disabled.
> [87989.892266] Freezing remaining freezable tasks
> [87989.893769] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [87989.893818] printk: Suspending console(s) (use no_console_suspend to debug)
> [87990.413158] ACPI: EC: interrupt blocked
> [87990.433973] ACPI: PM: Preparing to enter system sleep state S3
> [87990.445025] ACPI: EC: event blocked
> [87990.445029] ACPI: EC: EC stopped
> [87990.445031] ACPI: PM: Saving platform NVS memory
> [87990.448221] Disabling non-boot CPUs ...
> [87990.451391] smpboot: CPU 3 is now offline
> [87990.455027] smpboot: CPU 2 is now offline
> [87990.458763] smpboot: CPU 1 is now offline
> [87990.467864] ACPI: PM: Low-level resume complete
> [87990.467920] ACPI: EC: EC started
> [87990.467921] ACPI: PM: Restoring platform NVS memory
> [87990.470377] Enabling non-boot CPUs ...
> [87990.470410] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [87990.471406] CPU1 is up
> [87990.471432] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [87990.472489] CPU2 is up
> [87990.472515] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [87990.473470] CPU3 is up
> [87990.477389] ACPI: PM: Waking up from system sleep state S3
> [87990.516101] ACPI: EC: interrupt unblocked
> [87990.533205] ACPI: EC: event unblocked
> [87990.547094] nvme nvme0: 4/0/0 default/read/poll queues
> [87990.765631] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [87990.828064] OOM killer enabled.
> [87990.828065] Restarting tasks: Starting
> [87990.828334] usb 1-3: USB disconnect, device number 85
> [87990.833596] Restarting tasks: Done
> [87990.833626] random: crng reseeded on system resumption
> [87990.930047] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [87990.953629] usb 1-3: new full-speed USB device number 88 using xhci_hcd
> [87991.046024] PM: suspend exit
> [87991.096317] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [87991.096340] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [87991.101492] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [87991.101521] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [87991.105635] usb 1-4: USB disconnect, device number 86
> [87991.301230] Process accounting resumed
> [87991.313332] usb 1-4: new full-speed USB device number 89 using xhci_hcd
> [87991.459423] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [87991.459434] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [87991.459439] usb 1-4: Product: Touchscreen
> [87991.459443] usb 1-4: Manufacturer: ELAN
> [87991.465908] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [87991.475159] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0028/input/input189
> [87991.478106] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0028/input/input190
> [87991.478442] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0028/input/input191
> [87991.479124] hid-multitouch 0003:04F3:2234.0028: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [87991.479573] usb 1-5: USB disconnect, device number 87
> [87991.491584] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [87991.629808] usb 1-5: new high-speed USB device number 90 using xhci_hcd
> [87991.853655] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [87991.853676] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [87991.853700] usb 1-5: Product: Integrated_Webcam_HD
> [87991.853708] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [87991.887587] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [87991.964271] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [88173.490398] PM: suspend entry (deep)
> [88173.506285] Filesystems sync: 0.015 seconds
> [88173.534686] Freezing user space processes
> [88173.538632] Freezing user space processes completed (elapsed 0.003 seconds)
> [88173.538663] OOM killer disabled.
> [88173.538666] Freezing remaining freezable tasks
> [88173.540851] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
> [88173.541061] printk: Suspending console(s) (use no_console_suspend to debug)
> [88174.061614] ACPI: EC: interrupt blocked
> [88174.082474] ACPI: PM: Preparing to enter system sleep state S3
> [88174.098908] ACPI: EC: event blocked
> [88174.098913] ACPI: EC: EC stopped
> [88174.098915] ACPI: PM: Saving platform NVS memory
> [88174.104404] Disabling non-boot CPUs ...
> [88174.107524] smpboot: CPU 3 is now offline
> [88174.115891] smpboot: CPU 2 is now offline
> [88174.122699] smpboot: CPU 1 is now offline
> [88174.136303] ACPI: PM: Low-level resume complete
> [88174.136347] ACPI: EC: EC started
> [88174.136348] ACPI: PM: Restoring platform NVS memory
> [88174.138231] Enabling non-boot CPUs ...
> [88174.138254] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [88174.138996] CPU1 is up
> [88174.139011] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [88174.139772] CPU2 is up
> [88174.139788] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [88174.140498] CPU3 is up
> [88174.143395] ACPI: PM: Waking up from system sleep state S3
> [88174.177259] ACPI: EC: interrupt unblocked
> [88174.194180] ACPI: EC: event unblocked
> [88174.207008] nvme nvme0: 4/0/0 default/read/poll queues
> [88174.444768] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [88174.507999] OOM killer enabled.
> [88174.508008] Restarting tasks: Starting
> [88174.509172] Restarting tasks: Done
> [88174.509207] random: crng reseeded on system resumption
> [88174.509338] usb 1-3: USB disconnect, device number 88
> [88174.717639] PM: suspend exit
> [88174.844964] usb 1-3: new full-speed USB device number 91 using xhci_hcd
> [88174.940234] Process accounting resumed
> [88174.983673] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [88174.983687] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [88174.986997] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [88174.987002] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [88174.988721] usb 1-4: USB disconnect, device number 89
> [88175.200802] usb 1-4: new full-speed USB device number 92 using xhci_hcd
> [88175.338362] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [88175.338379] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [88175.338383] usb 1-4: Product: Touchscreen
> [88175.338385] usb 1-4: Manufacturer: ELAN
> [88175.344822] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [88175.349482] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0029/input/input194
> [88175.349759] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0029/input/input195
> [88175.349953] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0029/input/input196
> [88175.350154] hid-multitouch 0003:04F3:2234.0029: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [88175.351256] usb 1-5: USB disconnect, device number 90
> [88175.371144] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [88175.468791] usb 1-5: new high-speed USB device number 93 using xhci_hcd
> [88175.624858] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [88175.665269] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [88175.665276] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [88175.665278] usb 1-5: Product: Integrated_Webcam_HD
> [88175.665281] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [88175.673427] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [88812.031445] PM: suspend entry (deep)
> [88812.047182] Filesystems sync: 0.015 seconds
> [88812.071932] Freezing user space processes
> [88812.074486] Freezing user space processes completed (elapsed 0.002 seconds)
> [88812.074498] OOM killer disabled.
> [88812.074500] Freezing remaining freezable tasks
> [88812.076513] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
> [88812.076638] printk: Suspending console(s) (use no_console_suspend to debug)
> [88812.593454] ACPI: EC: interrupt blocked
> [88812.615353] ACPI: PM: Preparing to enter system sleep state S3
> [88812.625484] ACPI: EC: event blocked
> [88812.625489] ACPI: EC: EC stopped
> [88812.625491] ACPI: PM: Saving platform NVS memory
> [88812.628743] Disabling non-boot CPUs ...
> [88812.630854] smpboot: CPU 3 is now offline
> [88812.634620] smpboot: CPU 2 is now offline
> [88812.638887] smpboot: CPU 1 is now offline
> [88812.646775] ACPI: PM: Low-level resume complete
> [88812.646818] ACPI: EC: EC started
> [88812.646819] ACPI: PM: Restoring platform NVS memory
> [88812.648704] Enabling non-boot CPUs ...
> [88812.648729] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [88812.649462] CPU1 is up
> [88812.649477] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [88812.650231] CPU2 is up
> [88812.650247] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [88812.650955] CPU3 is up
> [88812.653840] ACPI: PM: Waking up from system sleep state S3
> [88812.684010] ACPI: EC: interrupt unblocked
> [88812.730160] ACPI: EC: event unblocked
> [88812.742653] nvme nvme0: 4/0/0 default/read/poll queues
> [88812.987521] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [88813.050061] OOM killer enabled.
> [88813.050063] Restarting tasks: Starting
> [88813.050281] usb 1-3: USB disconnect, device number 91
> [88813.051293] Restarting tasks: Done
> [88813.051317] random: crng reseeded on system resumption
> [88813.313450] PM: suspend exit
> [88813.447832] usb 1-3: new full-speed USB device number 94 using xhci_hcd
> [88813.546960] Process accounting resumed
> [88813.588727] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [88813.588735] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [88813.590884] usb 1-4: USB disconnect, device number 92
> [88813.591106] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [88813.591111] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [88813.779464] usb 1-4: new full-speed USB device number 95 using xhci_hcd
> [88813.917083] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [88813.917107] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [88813.917121] usb 1-4: Product: Touchscreen
> [88813.917125] usb 1-4: Manufacturer: ELAN
> [88813.931820] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002A/input/input199
> [88813.932475] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002A/input/input200
> [88813.932911] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002A/input/input201
> [88813.933724] hid-multitouch 0003:04F3:2234.002A: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [88813.934279] usb 1-5: USB disconnect, device number 93
> [88813.953130] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [88813.977369] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [88814.055511] usb 1-5: new high-speed USB device number 96 using xhci_hcd
> [88814.157025] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [88814.254935] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [88814.254942] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [88814.254945] usb 1-5: Product: Integrated_Webcam_HD
> [88814.254947] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [88814.265935] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [88821.136959] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [88821.137027] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [88821.137052] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [88821.137077] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [88821.137106] pci 0000:01:00.0: enabling Extended Tags
> [88821.137285] pci 0000:01:00.0: supports D1 D2
> [88821.137290] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [88821.137446] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [88821.139075] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [88821.139139] pci 0000:02:00.0: PCI bridge to [bus 03]
> [88821.139160] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [88821.139210] pci 0000:02:00.0: enabling Extended Tags
> [88821.139423] pci 0000:02:00.0: supports D1 D2
> [88821.139431] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [88821.140241] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [88821.140314] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [88821.140342] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [88821.140373] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [88821.140413] pci 0000:02:01.0: enabling Extended Tags
> [88821.140634] pci 0000:02:01.0: supports D1 D2
> [88821.140642] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [88821.141309] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
> [88821.141381] pci 0000:02:02.0: PCI bridge to [bus 39]
> [88821.141409] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [88821.141464] pci 0000:02:02.0: enabling Extended Tags
> [88821.141682] pci 0000:02:02.0: supports D1 D2
> [88821.141690] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [88821.155078] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [88821.155327] pci 0000:02:00.0: PCI bridge to [bus 03]
> [88821.155806] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [88821.156141] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [88821.156261] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [88821.156311] pci 0000:39:00.0: enabling Extended Tags
> [88821.156576] pci 0000:39:00.0: supports D1 D2
> [88821.156586] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [88821.157371] pci 0000:02:02.0: PCI bridge to [bus 39]
> [88821.157467] pci_bus 0000:02: Allocating resources
> [88821.157509] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [88821.157527] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [88821.157543] pci 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [88821.157563] pci 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [88821.157576] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [88821.157594] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [88821.157613] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [88821.157623] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [88821.157634] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [88821.157642] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [88821.157663] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [88821.157674] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [88821.157685] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [88821.157694] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [88821.157703] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [88821.157712] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [88821.157728] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [88821.157738] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [88821.157749] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [88821.157758] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [88821.157768] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [88821.157777] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [88821.157788] pci 0000:02:00.0: PCI bridge to [bus 03]
> [88821.157804] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [88821.157830] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [88821.157846] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [88821.157860] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [88821.157880] pci 0000:02:02.0: PCI bridge to [bus 39]
> [88821.157895] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [88821.157919] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [88821.157934] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [88821.157947] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [88821.160844] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [88821.160875] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [88821.162158] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [88821.163137] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [88821.163158] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [88821.163174] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [88821.163328] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [88821.163344] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [88821.163354] usb usb3: Product: xHCI Host Controller
> [88821.163362] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [88821.163370] usb usb3: SerialNumber: 0000:39:00.0
> [88821.164114] hub 3-0:1.0: USB hub found
> [88821.164157] hub 3-0:1.0: 2 ports detected
> [88821.167033] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [88821.167050] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [88821.167060] usb usb4: Product: xHCI Host Controller
> [88821.167069] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [88821.167078] usb usb4: SerialNumber: 0000:39:00.0
> [88821.167718] hub 4-0:1.0: USB hub found
> [88821.167755] hub 4-0:1.0: 2 ports detected
> [88821.171308] pci_bus 0000:02: Allocating resources
> [88821.171359] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [88821.171380] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [88821.171519] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [88821.171540] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [88821.171601] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [88821.171617] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [88821.171633] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [88821.171643] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [88821.171654] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [88821.171663] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [88821.171685] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [88821.171695] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [88821.171706] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [88821.171715] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [88821.171724] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [88821.171732] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [88821.171746] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [88821.171755] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [88821.171765] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [88821.171773] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [88821.171783] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [88821.171792] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [88821.415542] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [88821.554653] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [88821.554675] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88821.554683] usb 3-1: Product: USB2.0 Hub             
> [88821.554689] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [88821.554695] usb 3-1: SerialNumber: 000000000
> [88821.561977] hub 3-1:1.0: USB hub found
> [88821.562246] hub 3-1:1.0: 5 ports detected
> [88821.689109] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [88821.734791] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [88821.734818] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88821.734831] usb 4-1: Product: USB3.0 Hub             
> [88821.734841] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [88821.734852] usb 4-1: SerialNumber: 000000000
> [88821.741491] hub 4-1:1.0: USB hub found
> [88821.741684] hub 4-1:1.0: 4 ports detected
> [88822.299413] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [88822.441907] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [88822.441914] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88822.441917] usb 3-1.1: Product: USB2.0 Hub             
> [88822.441919] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [88822.441921] usb 3-1.1: SerialNumber: 000000000
> [88822.442902] hub 3-1.1:1.0: USB hub found
> [88822.443091] hub 3-1.1:1.0: 4 ports detected
> [88822.535945] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [88822.595826] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [88822.595852] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88822.595863] usb 4-1.1: Product: USB3.0 Hub             
> [88822.595871] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [88822.595878] usb 4-1.1: SerialNumber: 000000000
> [88822.598488] hub 4-1.1:1.0: USB hub found
> [88822.598775] hub 4-1.1:1.0: 4 ports detected
> [88822.663531] usb 3-1.5: new high-speed USB device number 4 using xhci_hcd
> [88822.752814] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [88822.752840] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88822.752853] usb 3-1.5: Product: USB Billboard Device   
> [88822.752863] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [88822.752871] usb 3-1.5: SerialNumber: 0000000000000001
> [88822.823556] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [88822.841325] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [88822.841352] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88822.841365] usb 4-1.4: Product: Mass Storage Device
> [88822.841375] usb 4-1.4: Manufacturer: Generic
> [88822.841384] usb 4-1.4: SerialNumber: 058F84688461
> [88822.844293] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [88822.845012] scsi host0: usb-storage 4-1.4:1.0
> [88824.411750] usb 4-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
> [88824.448089] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [88824.451022] sd 0:0:0:0: [sda] Media removed, stopped polling
> [88824.463530] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [88883.369524] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [88883.369575] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [88883.369694] hub 3-0:1.0: activate --> -19
> [88883.370053] usb 3-1: USB disconnect, device number 2
> [88883.370068] usb 3-1.1: USB disconnect, device number 3
> [88883.375218] usb 3-1.5: USB disconnect, device number 4
> [88883.389349] xhci_hcd 0000:39:00.0: remove, state 1
> [88883.389367] usb usb4: USB disconnect, device number 1
> [88883.466917] usb 4-1: USB disconnect, device number 2
> [88883.466938] usb 4-1.1: USB disconnect, device number 3
> [88883.468006] usb 4-1.4: USB disconnect, device number 4
> [88883.555910] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [88883.555951] xhci_hcd 0000:39:00.0: remove, state 1
> [88883.555965] usb usb3: USB disconnect, device number 1
> [88883.557532] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [88883.577267] pci_bus 0000:02: Allocating resources
> [88883.577307] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [88883.577327] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [88883.577341] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [88883.577360] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [88883.577373] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [88883.577389] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [88883.577408] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [88883.577418] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [88883.577434] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [88883.577443] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [88883.577467] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [88883.577478] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [88883.577489] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [88883.577498] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [88883.577508] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [88883.577517] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [88883.577534] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [88883.577543] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [88883.577552] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [88883.577559] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [88883.577566] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [88883.577574] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [88888.519866] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [88888.519987] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [88888.520031] pci 0000:39:00.0: enabling Extended Tags
> [88888.520252] pci 0000:39:00.0: supports D1 D2
> [88888.520259] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [88888.520989] pcieport 0000:02:02.0: ASPM: current common clock configuration is inconsistent, reconfiguring
> [88888.521137] pci_bus 0000:02: Allocating resources
> [88888.521180] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [88888.521202] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [88888.521218] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [88888.521238] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [88888.521251] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [88888.521269] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [88888.521289] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [88888.521300] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [88888.521312] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [88888.521320] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [88888.521345] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [88888.521355] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [88888.521365] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [88888.521373] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [88888.521382] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [88888.521391] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [88888.521406] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [88888.521416] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [88888.521427] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [88888.521436] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [88888.521447] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [88888.521456] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [88888.523031] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [88888.523068] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [88888.524374] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [88888.525651] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [88888.525677] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [88888.525696] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [88888.526475] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [88888.526495] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [88888.526506] usb usb3: Product: xHCI Host Controller
> [88888.526515] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [88888.526524] usb usb3: SerialNumber: 0000:39:00.0
> [88888.528206] hub 3-0:1.0: USB hub found
> [88888.528272] hub 3-0:1.0: 2 ports detected
> [88888.531556] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [88888.531580] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [88888.531592] usb usb4: Product: xHCI Host Controller
> [88888.531602] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [88888.531612] usb usb4: SerialNumber: 0000:39:00.0
> [88888.536278] hub 4-0:1.0: USB hub found
> [88888.536329] hub 4-0:1.0: 2 ports detected
> [88888.783044] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [88888.928039] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [88888.928064] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88888.928077] usb 3-1: Product: USB2.0 Hub             
> [88888.928086] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [88888.928095] usb 3-1: SerialNumber: 000000000
> [88888.931219] hub 3-1:1.0: USB hub found
> [88888.931389] hub 3-1:1.0: 5 ports detected
> [88889.061403] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [88889.103933] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [88889.103961] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88889.103974] usb 4-1: Product: USB3.0 Hub             
> [88889.103983] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [88889.103992] usb 4-1: SerialNumber: 000000000
> [88889.109202] hub 4-1:1.0: USB hub found
> [88889.110072] hub 4-1:1.0: 4 ports detected
> [88889.650922] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [88889.793553] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [88889.793577] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88889.793587] usb 3-1.1: Product: USB2.0 Hub             
> [88889.793595] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [88889.793602] usb 3-1.1: SerialNumber: 000000000
> [88889.795376] hub 3-1.1:1.0: USB hub found
> [88889.795679] hub 3-1.1:1.0: 4 ports detected
> [88889.889479] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [88889.949565] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [88889.949593] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88889.949607] usb 4-1.1: Product: USB3.0 Hub             
> [88889.949616] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [88889.949625] usb 4-1.1: SerialNumber: 000000000
> [88889.955299] hub 4-1.1:1.0: USB hub found
> [88889.955579] hub 4-1.1:1.0: 4 ports detected
> [88890.135115] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [88890.158110] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [88890.158117] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88890.158119] usb 4-1.4: Product: Mass Storage Device
> [88890.158121] usb 4-1.4: Manufacturer: Generic
> [88890.158123] usb 4-1.4: SerialNumber: 058F84688461
> [88890.160137] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [88890.160322] scsi host0: usb-storage 4-1.4:1.0
> [88891.142872] usb 3-1.5: new high-speed USB device number 5 using xhci_hcd
> [88891.240710] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [88891.240741] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [88891.240758] usb 3-1.5: Product: USB Billboard Device   
> [88891.240769] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [88891.240780] usb 3-1.5: SerialNumber: 0000000000000001
> [88891.771533] usb 4-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
> [88891.808338] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [88891.809611] sd 0:0:0:0: [sda] Media removed, stopped polling
> [88891.819565] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [88893.643823] pci_bus 0000:02: Allocating resources
> [88893.643867] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [88893.643885] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [88893.643897] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [88893.643912] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [88893.643921] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [88893.643933] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [88893.643947] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [88893.643955] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [88893.643963] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [88893.643968] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [88893.643985] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [88893.643992] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [88893.643998] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [88893.644004] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [88893.644010] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [88893.644015] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [88893.644026] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [88893.644032] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [88893.644038] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [88893.644044] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [88893.644050] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [88893.644055] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [89059.124980] usb 3-1: USB disconnect, device number 2
> [89059.125000] usb 3-1.1: USB disconnect, device number 3
> [89059.127564] usb 3-1.5: USB disconnect, device number 5
> [89059.251008] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [89059.251053] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [89059.276635] xhci_hcd 0000:39:00.0: remove, state 1
> [89059.276659] usb usb4: USB disconnect, device number 1
> [89059.345382] usb 4-1: USB disconnect, device number 2
> [89059.345403] usb 4-1.1: USB disconnect, device number 3
> [89059.347207] usb 4-1.4: USB disconnect, device number 4
> [89059.409537] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [89059.409562] xhci_hcd 0000:39:00.0: remove, state 1
> [89059.409571] usb usb3: USB disconnect, device number 1
> [89059.411322] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [89059.430645] pci_bus 0000:02: Allocating resources
> [89059.430666] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [89059.430675] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [89059.430680] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [89059.430688] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [89059.430693] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [89059.430700] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [89059.430708] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [89059.430712] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [89059.430716] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [89059.430720] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [89059.430728] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [89059.430732] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [89059.430736] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [89059.430739] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [89059.430743] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [89059.430746] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [89059.430752] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [89059.430756] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [89059.430759] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [89059.430763] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [89059.430767] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [89059.430770] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [89064.369694] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
> [89064.369763] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
> [89064.369787] pci 0000:39:00.0: enabling Extended Tags
> [89064.369924] pci 0000:39:00.0: supports D1 D2
> [89064.369927] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [89064.370242] pcieport 0000:02:02.0: ASPM: current common clock configuration is inconsistent, reconfiguring
> [89064.370308] pci_bus 0000:02: Allocating resources
> [89064.370324] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [89064.370330] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [89064.370334] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [89064.370339] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [89064.370342] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [89064.370346] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [89064.370352] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [89064.370355] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [89064.370358] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [89064.370360] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [89064.370366] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [89064.370368] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [89064.370371] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [89064.370373] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [89064.370375] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [89064.370377] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [89064.370380] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [89064.370383] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [89064.370385] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [89064.370387] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [89064.370390] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [89064.370392] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [89064.370687] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [89064.370695] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [89064.371820] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [89064.372164] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [89064.372171] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [89064.372176] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [89064.372232] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
> [89064.372236] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [89064.372238] usb usb3: Product: xHCI Host Controller
> [89064.372240] usb usb3: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [89064.372242] usb usb3: SerialNumber: 0000:39:00.0
> [89064.372435] hub 3-0:1.0: USB hub found
> [89064.372447] hub 3-0:1.0: 2 ports detected
> [89064.373333] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
> [89064.373338] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [89064.373340] usb usb4: Product: xHCI Host Controller
> [89064.373343] usb usb4: Manufacturer: Linux 6.17.0-rc2-00053-gb19a97d57c15 xhci-hcd
> [89064.373345] usb usb4: SerialNumber: 0000:39:00.0
> [89064.374254] hub 4-0:1.0: USB hub found
> [89064.374447] hub 4-0:1.0: 2 ports detected
> [89064.629316] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [89064.768034] usb 3-1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 5.e3
> [89064.768050] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [89064.768056] usb 3-1: Product: USB2.0 Hub             
> [89064.768061] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [89064.768066] usb 3-1: SerialNumber: 000000000
> [89064.774324] hub 3-1:1.0: USB hub found
> [89064.774593] hub 3-1:1.0: 5 ports detected
> [89064.898068] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
> [89064.943443] usb 4-1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 5.e3
> [89064.943458] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [89064.943465] usb 4-1: Product: USB3.0 Hub             
> [89064.943470] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [89064.943474] usb 4-1: SerialNumber: 000000000
> [89064.946371] hub 4-1:1.0: USB hub found
> [89064.946589] hub 4-1:1.0: 4 ports detected
> [89065.489339] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [89065.627950] usb 3-1.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 7.b4
> [89065.627966] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [89065.627973] usb 3-1.1: Product: USB2.0 Hub             
> [89065.627978] usb 3-1.1: Manufacturer: VIA Labs, Inc.         
> [89065.627982] usb 3-1.1: SerialNumber: 000000000
> [89065.629607] hub 3-1.1:1.0: USB hub found
> [89065.629813] hub 3-1.1:1.0: 4 ports detected
> [89065.722857] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [89065.782007] usb 4-1.1: New USB device found, idVendor=2109, idProduct=0817, bcdDevice= 7.b4
> [89065.782031] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [89065.782042] usb 4-1.1: Product: USB3.0 Hub             
> [89065.782051] usb 4-1.1: Manufacturer: VIA Labs, Inc.         
> [89065.782058] usb 4-1.1: SerialNumber: 000000000
> [89065.785238] hub 4-1.1:1.0: USB hub found
> [89065.785495] hub 4-1.1:1.0: 4 ports detected
> [89065.965599] usb 4-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [89065.988227] usb 4-1.4: New USB device found, idVendor=058f, idProduct=8468, bcdDevice= 1.00
> [89065.988234] usb 4-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [89065.988237] usb 4-1.4: Product: Mass Storage Device
> [89065.988239] usb 4-1.4: Manufacturer: Generic
> [89065.988241] usb 4-1.4: SerialNumber: 058F84688461
> [89065.990340] usb-storage 4-1.4:1.0: USB Mass Storage device detected
> [89065.990526] scsi host0: usb-storage 4-1.4:1.0
> [89066.305338] usb 3-1.1.3: new high-speed USB device number 4 using xhci_hcd
> [89067.049452] usb 4-1.1.3: new SuperSpeed USB device number 5 using xhci_hcd
> [89067.066581] usb 4-1.1.3: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
> [89067.066602] usb 4-1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [89067.066610] usb 4-1.1.3: Product: USB 10/100/1000 LAN
> [89067.066616] usb 4-1.1.3: Manufacturer: Realtek
> [89067.066622] usb 4-1.1.3: SerialNumber: 000001
> [89067.141513] usb 3-1.5: new high-speed USB device number 5 using xhci_hcd
> [89067.234616] usb 3-1.5: New USB device found, idVendor=2109, idProduct=8817, bcdDevice= 0.01
> [89067.234638] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [89067.234646] usb 3-1.5: Product: USB Billboard Device   
> [89067.234653] usb 3-1.5: Manufacturer: VIA Labs, Inc.         
> [89067.234659] usb 3-1.5: SerialNumber: 0000000000000001
> [89067.549978] usb 4-1.4: reset SuperSpeed USB device number 4 using xhci_hcd
> [89067.582793] scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 6
> [89067.583990] sd 0:0:0:0: [sda] Media removed, stopped polling
> [89067.593961] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [89067.649784] r8152-cfgselector 4-1.1.3: reset SuperSpeed USB device number 5 using xhci_hcd
> [89067.743971] r8152 4-1.1.3:1.0 eth0: v1.12.13
> [89067.884811] r8152 4-1.1.3:1.0 enx00e04ceb9e75: renamed from eth0
> [89069.509329] pci_bus 0000:02: Allocating resources
> [89069.509369] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [89069.509384] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [89069.509394] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [89069.509406] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [89069.509414] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [89069.509424] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [89069.509436] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [89069.509443] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [89069.509450] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [89069.509455] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [89069.509468] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [89069.509474] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [89069.509480] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [89069.509485] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [89069.509490] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [89069.509495] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [89069.509503] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [89069.509508] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [89069.509514] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [89069.509519] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [89069.509524] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [89069.509528] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [89071.653433] r8152 4-1.1.3:1.0 enx00e04ceb9e75: carrier on
> [91813.733956] audit: type=1400 audit(1755902062.580:161): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="/usr/lib/ipsec/stroke" pid=232129 comm="apparmor_parser"
> [91813.737084] Initializing XFRM netlink socket
> [91813.745763] IPsec XFRM device driver
> [91813.959208] systemd-sysv-generator[232296]: SysV service '/etc/init.d/xl2tpd' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> [91813.959218] systemd-sysv-generator[232296]: Please update package to include a native systemd unit file.
> [91813.959221] systemd-sysv-generator[232296]: ! This compatibility logic is deprecated, expect removal soon. !
> [91814.844614] systemd-sysv-generator[232459]: SysV service '/etc/init.d/xl2tpd' lacks a native systemd unit file, automatically generating a unit file for compatibility.
> [91814.844622] systemd-sysv-generator[232459]: Please update package to include a native systemd unit file.
> [91814.844624] systemd-sysv-generator[232459]: ! This compatibility logic is deprecated, expect removal soon. !
> [91815.623163] audit: type=1400 audit(1755902064.472:162): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="/usr/lib/ipsec/charon" pid=232506 comm="apparmor_parser"
> [93604.289951] usb 3-1: USB disconnect, device number 2
> [93604.289973] usb 3-1.1: USB disconnect, device number 3
> [93604.292128] usb 3-1.5: USB disconnect, device number 5
> [93604.362065] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
> [93604.362122] xhci_hcd 0000:39:00.0: HC died; cleaning up
> [93604.362187] r8152 4-1.1.3:1.0 enx00e04ceb9e75: Stop submitting intr, status -108
> [93604.427208] xhci_hcd 0000:39:00.0: remove, state 1
> [93604.427233] usb usb4: USB disconnect, device number 1
> [93604.490926] usb 4-1: USB disconnect, device number 2
> [93604.490946] usb 4-1.1: USB disconnect, device number 3
> [93604.490954] r8152-cfgselector 4-1.1.3: USB disconnect, device number 5
> [93604.543423] usb 4-1.4: USB disconnect, device number 4
> [93604.631830] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
> [93604.631843] xhci_hcd 0000:39:00.0: remove, state 1
> [93604.631846] usb usb3: USB disconnect, device number 1
> [93604.632739] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> [93604.646634] pci_bus 0000:02: Allocating resources
> [93604.646659] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [93604.646665] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [93604.646668] pcieport 0000:01:00.0: Assigned bridge window [mem 0xa0000000-0xc1ffffff 64bit pref] to [bus 02-39] cannot fit 0x200000 required for 0000:02:02.0 bridging to [bus 39]
> [93604.646673] pcieport 0000:02:02.0: bridge window [mem 0x00000000 64bit pref] to [bus 39] requires relaxed alignment rules
> [93604.646677] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [93604.646796] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [93604.646803] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [93604.646816] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [93604.647411] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
> [93604.647416] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
> [93604.647425] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [93604.647427] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [93604.647430] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [93604.647432] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [93604.647434] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [93604.647436] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [93604.647439] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
> [93604.647441] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
> [93604.647444] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
> [93604.647445] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
> [93604.647448] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
> [93604.647450] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
> [93609.488383] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [93609.491057] pci_bus 0000:03: busn_res: [bus 03] is released
> [93609.491705] pci_bus 0000:04: busn_res: [bus 04-38] is released
> [93609.492211] pci_bus 0000:39: busn_res: [bus 39] is released
> [93609.492730] pci_bus 0000:02: busn_res: [bus 02-39] is released
> [93663.138017] usbcore: deregistering interface driver btusb
> [93876.820426] PM: suspend entry (deep)
> [93876.903833] Filesystems sync: 0.083 seconds
> [93876.922241] Freezing user space processes
> [93876.925365] Freezing user space processes completed (elapsed 0.003 seconds)
> [93876.925379] OOM killer disabled.
> [93876.925382] Freezing remaining freezable tasks
> [93876.927355] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [93876.927477] printk: Suspending console(s) (use no_console_suspend to debug)
> [93877.445422] ACPI: EC: interrupt blocked
> [93877.467818] ACPI: PM: Preparing to enter system sleep state S3
> [93877.477854] ACPI: EC: event blocked
> [93877.477858] ACPI: EC: EC stopped
> [93877.477860] ACPI: PM: Saving platform NVS memory
> [93877.481042] Disabling non-boot CPUs ...
> [93877.483125] smpboot: CPU 3 is now offline
> [93877.488221] smpboot: CPU 2 is now offline
> [93877.493498] smpboot: CPU 1 is now offline
> [93877.501187] ACPI: PM: Low-level resume complete
> [93877.501233] ACPI: EC: EC started
> [93877.501233] ACPI: PM: Restoring platform NVS memory
> [93877.503118] Enabling non-boot CPUs ...
> [93877.503142] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [93877.503877] CPU1 is up
> [93877.503901] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [93877.504661] CPU2 is up
> [93877.504677] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [93877.505390] CPU3 is up
> [93877.508273] ACPI: PM: Waking up from system sleep state S3
> [93877.538931] ACPI: EC: interrupt unblocked
> [93877.589393] ACPI: EC: event unblocked
> [93877.602341] nvme nvme0: 4/0/0 default/read/poll queues
> [93877.741088] OOM killer enabled.
> [93877.741090] Restarting tasks: Starting
> [93877.741127] usb 1-3: USB disconnect, device number 94
> [93877.743890] Restarting tasks: Done
> [93877.743909] random: crng reseeded on system resumption
> [93877.859912] usb 1-3: new full-speed USB device number 97 using xhci_hcd
> [93877.875937] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [93877.997177] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [93877.997186] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [93877.999626] usb 1-4: USB disconnect, device number 95
> [93878.049192] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [93878.199937] usb 1-4: new full-speed USB device number 98 using xhci_hcd
> [93878.339665] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [93878.339672] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [93878.339680] usb 1-4: Product: Touchscreen
> [93878.339682] usb 1-4: Manufacturer: ELAN
> [93878.355772] PM: suspend exit
> [93878.358277] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002B/input/input204
> [93878.358429] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002B/input/input205
> [93878.358502] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002B/input/input206
> [93878.358654] hid-multitouch 0003:04F3:2234.002B: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [93878.358787] usb 1-5: USB disconnect, device number 96
> [93878.476335] usb 1-5: new high-speed USB device number 99 using xhci_hcd
> [93878.510105] Process accounting resumed
> [93878.682027] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [93878.682034] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [93878.682036] usb 1-5: Product: Integrated_Webcam_HD
> [93878.682043] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [93878.694422] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [93878.856559] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [93878.856565] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [93878.857730] usbcore: registered new interface driver btusb
> [93879.004348] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [93879.219231] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [93879.241614] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [93933.455974] wlp58s0: authenticate with 9c:c8:fc:3d:47:9e (local address=9c:b6:d0:d1:6a:b1)
> [93933.455994] wlp58s0: send auth to 9c:c8:fc:3d:47:9e (try 1/3)
> [93933.456943] wlp58s0: authenticated
> [93933.459348] wlp58s0: associate with 9c:c8:fc:3d:47:9e (try 1/3)
> [93933.500334] wlp58s0: RX AssocResp from 9c:c8:fc:3d:47:9e (capab=0x1431 status=0 aid=1)
> [93933.504246] wlp58s0: associated
> [93933.570993] wlp58s0: Limiting TX power to 20 (20 - 0) dBm as advertised by 9c:c8:fc:3d:47:9e
> [93969.871533] wlp58s0: disconnect from AP 9c:c8:fc:3d:47:9e for new auth to 9c:c8:fc:3d:47:9f
> [93969.955860] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [93969.955875] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [93969.958827] wlp58s0: authenticated
> [93969.962914] wlp58s0: associate with 9c:c8:fc:3d:47:9f (try 1/3)
> [93969.995832] wlp58s0: RX ReassocResp from 9c:c8:fc:3d:47:9f (capab=0x1011 status=0 aid=1)
> [93969.999073] wlp58s0: associated
> [93970.074182] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 9c:c8:fc:3d:47:9f
> [94135.947339] audit: type=1400 audit(1755925390.442:163): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="libreoffice-oosplash" pid=238463 comm="apparmor_parser"
> [94135.967176] audit: type=1400 audit(1755925390.462:164): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="libreoffice-senddoc" pid=238466 comm="apparmor_parser"
> [94154.012414] apparmor_parser: page allocation failure: order:10, mode:0x40dc0(GFP_KERNEL|__GFP_ZERO|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
> [94154.012426] CPU: 2 UID: 0 PID: 238469 Comm: apparmor_parser Not tainted 6.17.0-rc2-00053-gb19a97d57c15 #119 PREEMPT(voluntary) 
> [94154.012429] Hardware name: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> [94154.012430] Call Trace:
> [94154.012432]  <TASK>
> [94154.012435]  dump_stack_lvl+0x5d/0x80
> [94154.012440]  warn_alloc+0x15e/0x180
> [94154.012444]  ? __alloc_pages_direct_compact+0x17f/0x1a0
> [94154.012447]  __alloc_pages_slowpath.constprop.0+0x4d0/0xd20
> [94154.012450]  __alloc_frozen_pages_noprof+0x2c9/0x320
> [94154.012453]  alloc_pages_mpol+0x79/0x160
> [94154.012456]  ___kmalloc_large_node+0xc0/0xe0
> [94154.012458]  __kmalloc_large_node_noprof+0x1d/0xa0
> [94154.012460]  __kmalloc_noprof+0x404/0x4f0
> [94154.012462]  ? kmemdup_noprof+0x20/0x40
> [94154.012464]  ? unpack_pdb+0x1df/0xaa0
> [94154.012466]  ? unpack_pdb+0x1df/0xaa0
> [94154.012467]  unpack_pdb+0x1df/0xaa0
> [94154.012469]  unpack_profile+0x711/0x12d0
> [94154.012471]  aa_unpack+0x143/0x7e0
> [94154.012473]  aa_replace_profiles+0xa3/0x1290
> [94154.012474]  ? find_vmap_area+0xbc/0xd0
> [94154.012476]  policy_update+0xc5/0x150
> [94154.012479]  profile_replace+0x9d/0x110
> [94154.012480]  vfs_write+0xcc/0x450
> [94154.012483]  ? kmem_cache_free+0x236/0x460
> [94154.012485]  ksys_write+0x6b/0xe0
> [94154.012487]  do_syscall_64+0x84/0xae0
> [94154.012489]  ? __x64_sys_openat+0x54/0xa0
> [94154.012491]  ? do_syscall_64+0xbc/0xae0
> [94154.012491]  ? __lruvec_stat_mod_folio+0x83/0xd0
> [94154.012494]  ? __folio_mod_stat+0x26/0x80
> [94154.012496]  ? set_ptes.isra.0+0x36/0x70
> [94154.012498]  ? do_anonymous_page+0xfe/0x930
> [94154.012500]  ? ___pte_offset_map+0x1b/0x150
> [94154.012502]  ? __handle_mm_fault+0xabc/0xf10
> [94154.012503]  ? count_memcg_events+0xae/0x160
> [94154.012506]  ? handle_mm_fault+0x1d3/0x2d0
> [94154.012507]  ? do_user_addr_fault+0x20d/0x680
> [94154.012509]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [94154.012511] RIP: 0033:0x7f09045fa687
> [94154.012544] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> [94154.012545] RSP: 002b:00007ffe3f34c0e0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [94154.012547] RAX: ffffffffffffffda RBX: 00007f0904568740 RCX: 00007f09045fa687
> [94154.012548] RDX: 00000000005da22b RSI: 000055e818661170 RDI: 0000000000000006
> [94154.012549] RBP: 00000000005da22b R08: 0000000000000000 R09: 0000000000000000
> [94154.012550] R10: 0000000000000000 R11: 0000000000000202 R12: 000055e818661170
> [94154.012550] R13: 0000000000000006 R14: 000055e81555b1d0 R15: 0000000000000007
> [94154.012552]  </TASK>
> [94154.012553] Mem-Info:
> [94154.012558] active_anon:1063296 inactive_anon:928274 isolated_anon:0
>                 active_file:628423 inactive_file:299694 isolated_file:0
>                 unevictable:509180 dirty:1130 writeback:0
>                 slab_reclaimable:115698 slab_unreclaimable:50787
>                 mapped:241050 shmem:1185031 pagetables:17400
>                 sec_pagetables:514 bounce:0
>                 kernel_misc_reclaimable:0
>                 free:323668 free_pcp:220 free_cma:0
> [94154.012562] Node 0 active_anon:4253184kB inactive_anon:3713096kB active_file:2513692kB inactive_file:1198776kB unevictable:2036720kB isolated(anon):0kB isolated(file):0kB mapped:964200kB dirty:4520kB writeback:0kB shmem:4740124kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:811008kB kernel_stack:25104kB pagetables:69600kB sec_pagetables:2056kB all_unreclaimable? no Balloon:0kB
> [94154.012566] Node 0 DMA free:13312kB boost:0kB min:64kB low:80kB high:96kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15984kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [94154.012570] lowmem_reserve[]: 0 1538 15508 15508 15508
> [94154.012573] Node 0 DMA32 free:357328kB boost:0kB min:6632kB low:8288kB high:9944kB reserved_highatomic:2048KB free_highatomic:2040KB active_anon:291372kB inactive_anon:516252kB active_file:367640kB inactive_file:34828kB unevictable:1932kB writepending:4kB present:1642444kB managed:1575248kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [94154.012577] lowmem_reserve[]: 0 0 13970 13970 13970
> [94154.012579] Node 0 Normal free:924032kB boost:136980kB min:197860kB low:213080kB high:228300kB reserved_highatomic:2048KB free_highatomic:2040KB active_anon:3962008kB inactive_anon:3196844kB active_file:2146052kB inactive_file:1163948kB unevictable:2034396kB writepending:4516kB present:14704640kB managed:14305876kB mlocked:16164kB bounce:0kB free_pcp:888kB local_pcp:0kB free_cma:0kB
> [94154.012583] lowmem_reserve[]: 0 0 0 0 0
> [94154.012585] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 2*2048kB (UM) 2*4096kB (M) = 13312kB
> [94154.012594] Node 0 DMA32: 431*4kB (UME) 357*8kB (UMEH) 391*16kB (UMEH) 368*32kB (UMEH) 329*64kB (UMEH) 299*128kB (UMEH) 258*256kB (UMEH) 203*512kB (UEH) 103*1024kB (UH) 0*2048kB 0*4096kB = 357396kB
> [94154.012605] Node 0 Normal: 12819*4kB (UMEH) 8739*8kB (UME) 7778*16kB (UMEH) 4358*32kB (UMEH) 3143*64kB (UMEH) 1553*128kB (UMEH) 307*256kB (UMEH) 110*512kB (MEH) 4*1024kB (MH) 0*2048kB 0*4096kB = 924036kB
> [94154.012615] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
> [94154.012617] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
> [94154.012618] 2297831 total pagecache pages
> [94154.012618] 183307 pages in swap cache
> [94154.012619] Free swap  = 6132536kB
> [94154.012620] Total swap = 8387904kB
> [94154.012620] 4090767 pages RAM
> [94154.012621] 0 pages HighMem/MovableOnly
> [94154.012621] 116646 pages reserved
> [94154.012622] 0 pages hwpoisoned
> [94154.012636] audit: type=1400 audit(1755925408.506:165): apparmor="STATUS" info="failed to unpack - perms" error=-71 profile="unconfined" name="libreoffice-soffice" pid=238469 comm="apparmor_parser" name="libreoffice-soffice" offset=9139
> [94154.016703] audit: type=1400 audit(1755925408.510:166): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="libreoffice-soffice//gpg" pid=238469 comm="apparmor_parser"
> [94154.046548] audit: type=1400 audit(1755925408.542:167): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="libreoffice-xpdfimport" pid=238490 comm="apparmor_parser"
> [100858.408453] wlp58s0: deauthenticating from 9c:c8:fc:3d:47:9f by local choice (Reason: 3=DEAUTH_LEAVING)
> [100859.778899] PM: suspend entry (deep)
> [100859.794101] Filesystems sync: 0.015 seconds
> [100859.806714] Freezing user space processes
> [100859.808198] Freezing user space processes completed (elapsed 0.001 seconds)
> [100859.808203] OOM killer disabled.
> [100859.808204] Freezing remaining freezable tasks
> [100859.809756] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [100859.809816] printk: Suspending console(s) (use no_console_suspend to debug)
> [100860.320543] ACPI: EC: interrupt blocked
> [100860.342769] ACPI: PM: Preparing to enter system sleep state S3
> [100860.347962] ACPI: EC: event blocked
> [100860.347964] ACPI: EC: EC stopped
> [100860.347965] ACPI: PM: Saving platform NVS memory
> [100860.349870] Disabling non-boot CPUs ...
> [100860.351392] smpboot: CPU 3 is now offline
> [100860.354288] smpboot: CPU 2 is now offline
> [100860.357860] smpboot: CPU 1 is now offline
> [100860.366820] ACPI: PM: Low-level resume complete
> [100860.366865] ACPI: EC: EC started
> [100860.366865] ACPI: PM: Restoring platform NVS memory
> [100860.368760] Enabling non-boot CPUs ...
> [100860.368782] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [100860.369520] CPU1 is up
> [100860.369535] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [100860.370310] CPU2 is up
> [100860.370326] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [100860.371047] CPU3 is up
> [100860.373934] ACPI: PM: Waking up from system sleep state S3
> [100860.415013] ACPI: EC: interrupt unblocked
> [100860.428812] ACPI: EC: event unblocked
> [100860.442034] nvme nvme0: 4/0/0 default/read/poll queues
> [100860.655264] OOM killer enabled.
> [100860.655266] Restarting tasks: Starting
> [100860.655343] usb 1-3: USB disconnect, device number 97
> [100860.656009] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [100860.661205] Restarting tasks: Done
> [100860.661225] random: crng reseeded on system resumption
> [100860.776015] usb 1-3: new full-speed USB device number 100 using xhci_hcd
> [100860.825792] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [100860.889732] PM: suspend exit
> [100860.913842] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [100860.913847] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [100860.916847] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [100860.917232] usb 1-4: USB disconnect, device number 98
> [100860.958429] Process accounting resumed
> [100861.292057] usb 1-4: new full-speed USB device number 101 using xhci_hcd
> [100861.429516] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [100861.429522] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [100861.429524] usb 1-4: Product: Touchscreen
> [100861.429532] usb 1-4: Manufacturer: ELAN
> [100861.439143] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002C/input/input209
> [100861.439331] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002C/input/input210
> [100861.439427] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002C/input/input211
> [100861.439634] hid-multitouch 0003:04F3:2234.002C: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [100861.439853] usb 1-5: USB disconnect, device number 99
> [100861.568027] usb 1-5: new high-speed USB device number 102 using xhci_hcd
> [100861.768587] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [100861.768600] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [100861.768601] usb 1-5: Product: Integrated_Webcam_HD
> [100861.768603] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [100861.776471] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [100861.865754] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [100866.444853] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [100866.444859] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [100866.446415] wlp58s0: authenticated
> [100866.447959] wlp58s0: associate with 9c:c8:fc:3d:47:9f (try 1/3)
> [100866.481919] wlp58s0: RX AssocResp from 9c:c8:fc:3d:47:9f (capab=0x1011 status=0 aid=2)
> [100866.484532] wlp58s0: associated
> [100866.532214] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 9c:c8:fc:3d:47:9f
> [101383.914623] wlp58s0: deauthenticating from 9c:c8:fc:3d:47:9f by local choice (Reason: 3=DEAUTH_LEAVING)
> [101385.469740] PM: suspend entry (deep)
> [101385.482642] Filesystems sync: 0.012 seconds
> [101385.493031] Freezing user space processes
> [101385.494876] Freezing user space processes completed (elapsed 0.001 seconds)
> [101385.494881] OOM killer disabled.
> [101385.494882] Freezing remaining freezable tasks
> [101385.496392] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [101385.496444] printk: Suspending console(s) (use no_console_suspend to debug)
> [101386.046050] ACPI: EC: interrupt blocked
> [101386.066724] ACPI: PM: Preparing to enter system sleep state S3
> [101386.071801] ACPI: EC: event blocked
> [101386.071803] ACPI: EC: EC stopped
> [101386.071804] ACPI: PM: Saving platform NVS memory
> [101386.073696] Disabling non-boot CPUs ...
> [101386.075253] smpboot: CPU 3 is now offline
> [101386.078342] smpboot: CPU 2 is now offline
> [101386.081452] smpboot: CPU 1 is now offline
> [101386.088974] ACPI: PM: Low-level resume complete
> [101386.089018] ACPI: EC: EC started
> [101386.089018] ACPI: PM: Restoring platform NVS memory
> [101386.090906] Enabling non-boot CPUs ...
> [101386.090930] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [101386.091666] CPU1 is up
> [101386.091681] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [101386.092446] CPU2 is up
> [101386.092462] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [101386.093178] CPU3 is up
> [101386.096052] ACPI: PM: Waking up from system sleep state S3
> [101386.129565] ACPI: EC: interrupt unblocked
> [101386.147683] ACPI: EC: event unblocked
> [101386.161198] nvme nvme0: 4/0/0 default/read/poll queues
> [101386.374940] OOM killer enabled.
> [101386.374942] Restarting tasks: Starting
> [101386.374992] usb 1-3: USB disconnect, device number 100
> [101386.376746] Restarting tasks: Done
> [101386.376771] random: crng reseeded on system resumption
> [101386.409332] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [101386.497367] usb 1-3: new full-speed USB device number 103 using xhci_hcd
> [101386.574076] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [101386.634765] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [101386.634770] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [101386.639945] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [101386.639949] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [101386.640144] PM: suspend exit
> [101386.641653] usb 1-4: USB disconnect, device number 101
> [101386.737843] Process accounting resumed
> [101386.833819] usb 1-4: new full-speed USB device number 104 using xhci_hcd
> [101386.974788] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [101386.974796] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [101386.974798] usb 1-4: Product: Touchscreen
> [101386.974800] usb 1-4: Manufacturer: ELAN
> [101386.984316] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002D/input/input214
> [101386.984476] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002D/input/input215
> [101386.984541] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002D/input/input216
> [101386.984680] hid-multitouch 0003:04F3:2234.002D: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [101386.984813] usb 1-5: USB disconnect, device number 102
> [101386.996562] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [101387.019115] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [101387.105371] usb 1-5: new high-speed USB device number 105 using xhci_hcd
> [101387.303478] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [101387.303485] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [101387.303488] usb 1-5: Product: Integrated_Webcam_HD
> [101387.303490] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [101387.311806] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [101387.589002] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [101796.714953] PM: suspend entry (deep)
> [101796.724259] Filesystems sync: 0.009 seconds
> [101796.740550] Freezing user space processes
> [101796.742596] Freezing user space processes completed (elapsed 0.002 seconds)
> [101796.742602] OOM killer disabled.
> [101796.742604] Freezing remaining freezable tasks
> [101796.744141] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [101796.744204] printk: Suspending console(s) (use no_console_suspend to debug)
> [101797.284713] ACPI: EC: interrupt blocked
> [101797.307534] ACPI: PM: Preparing to enter system sleep state S3
> [101797.317626] ACPI: EC: event blocked
> [101797.317631] ACPI: EC: EC stopped
> [101797.317633] ACPI: PM: Saving platform NVS memory
> [101797.320840] Disabling non-boot CPUs ...
> [101797.322933] smpboot: CPU 3 is now offline
> [101797.327574] smpboot: CPU 2 is now offline
> [101797.333227] smpboot: CPU 1 is now offline
> [101797.339391] ACPI: PM: Low-level resume complete
> [101797.339435] ACPI: EC: EC started
> [101797.339436] ACPI: PM: Restoring platform NVS memory
> [101797.341348] Enabling non-boot CPUs ...
> [101797.341377] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [101797.342114] CPU1 is up
> [101797.342129] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [101797.342999] CPU2 is up
> [101797.343015] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [101797.343739] CPU3 is up
> [101797.346601] ACPI: PM: Waking up from system sleep state S3
> [101797.376191] ACPI: EC: interrupt unblocked
> [101797.392549] ACPI: EC: event unblocked
> [101797.404382] nvme nvme0: 4/0/0 default/read/poll queues
> [101797.507151] OOM killer enabled.
> [101797.507152] Restarting tasks: Starting
> [101797.507181] usb 1-3: USB disconnect, device number 103
> [101797.509658] Restarting tasks: Done
> [101797.509676] random: crng reseeded on system resumption
> [101797.614232] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [101797.626189] usb 1-3: new full-speed USB device number 106 using xhci_hcd
> [101797.763396] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [101797.763404] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [101797.892848] PM: suspend exit
> [101797.894845] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [101797.894857] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [101797.901063] usb 1-4: USB disconnect, device number 104
> [101798.098236] usb 1-4: new full-speed USB device number 107 using xhci_hcd
> [101798.227178] Process accounting resumed
> [101798.235678] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [101798.235685] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [101798.235694] usb 1-4: Product: Touchscreen
> [101798.235696] usb 1-4: Manufacturer: ELAN
> [101798.247132] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002E/input/input219
> [101798.247362] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002E/input/input220
> [101798.247462] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002E/input/input221
> [101798.247646] hid-multitouch 0003:04F3:2234.002E: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [101798.247810] usb 1-5: USB disconnect, device number 105
> [101798.253958] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [101798.275919] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [101798.366332] usb 1-5: new high-speed USB device number 108 using xhci_hcd
> [101798.562924] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [101798.562931] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [101798.562934] usb 1-5: Product: Integrated_Webcam_HD
> [101798.562936] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [101798.571344] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [101798.844578] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [102233.436858] PM: suspend entry (deep)
> [102233.468945] Filesystems sync: 0.032 seconds
> [102233.473999] Freezing user space processes
> [102233.475849] Freezing user space processes completed (elapsed 0.001 seconds)
> [102233.475853] OOM killer disabled.
> [102233.475854] Freezing remaining freezable tasks
> [102233.477329] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [102233.477382] printk: Suspending console(s) (use no_console_suspend to debug)
> [102233.985067] ACPI: EC: interrupt blocked
> [102234.007090] ACPI: PM: Preparing to enter system sleep state S3
> [102234.017232] ACPI: EC: event blocked
> [102234.017236] ACPI: EC: EC stopped
> [102234.017238] ACPI: PM: Saving platform NVS memory
> [102234.020466] Disabling non-boot CPUs ...
> [102234.023597] smpboot: CPU 3 is now offline
> [102234.027776] smpboot: CPU 2 is now offline
> [102234.031894] smpboot: CPU 1 is now offline
> [102234.039192] ACPI: PM: Low-level resume complete
> [102234.039237] ACPI: EC: EC started
> [102234.039238] ACPI: PM: Restoring platform NVS memory
> [102234.041160] Enabling non-boot CPUs ...
> [102234.041187] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [102234.041918] CPU1 is up
> [102234.041933] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [102234.042689] CPU2 is up
> [102234.042807] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [102234.043519] CPU3 is up
> [102234.046380] ACPI: PM: Waking up from system sleep state S3
> [102234.077814] ACPI: EC: interrupt unblocked
> [102234.092161] ACPI: EC: event unblocked
> [102234.104410] nvme nvme0: 4/0/0 default/read/poll queues
> [102234.207896] OOM killer enabled.
> [102234.207898] Restarting tasks: Starting
> [102234.208125] usb 1-3: USB disconnect, device number 106
> [102234.208937] Restarting tasks: Done
> [102234.208956] random: crng reseeded on system resumption
> [102234.314714] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [102234.326736] usb 1-3: new full-speed USB device number 109 using xhci_hcd
> [102234.463941] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [102234.463959] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [102234.480020] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [102234.590658] PM: suspend exit
> [102234.590807] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [102234.590815] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [102234.595315] usb 1-4: USB disconnect, device number 107
> [102234.790724] usb 1-4: new full-speed USB device number 110 using xhci_hcd
> [102234.823843] Process accounting resumed
> [102234.839781] rfkill: input handler enabled
> [102234.858921] rfkill: input handler disabled
> [102234.928204] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [102234.928211] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [102234.928213] usb 1-4: Product: Touchscreen
> [102234.928215] usb 1-4: Manufacturer: ELAN
> [102234.937757] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002F/input/input224
> [102234.937893] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002F/input/input225
> [102234.937967] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.002F/input/input226
> [102234.938105] hid-multitouch 0003:04F3:2234.002F: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [102234.938231] usb 1-5: USB disconnect, device number 108
> [102234.948719] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [102234.982741] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [102235.059043] usb 1-5: new high-speed USB device number 111 using xhci_hcd
> [102235.256355] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [102235.256372] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [102235.256378] usb 1-5: Product: Integrated_Webcam_HD
> [102235.256383] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [102235.265145] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [102235.566260] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [102349.593871] PM: suspend entry (deep)
> [102349.611589] Filesystems sync: 0.017 seconds
> [102349.618018] Freezing user space processes
> [102349.619830] Freezing user space processes completed (elapsed 0.001 seconds)
> [102349.619835] OOM killer disabled.
> [102349.619836] Freezing remaining freezable tasks
> [102349.801536] Freezing remaining freezable tasks completed (elapsed 0.181 seconds)
> [102349.801602] printk: Suspending console(s) (use no_console_suspend to debug)
> [102350.309671] ACPI: EC: interrupt blocked
> [102350.330742] ACPI: PM: Preparing to enter system sleep state S3
> [102350.341223] ACPI: EC: event blocked
> [102350.341227] ACPI: EC: EC stopped
> [102350.341228] ACPI: PM: Saving platform NVS memory
> [102350.344068] Disabling non-boot CPUs ...
> [102350.346984] smpboot: CPU 3 is now offline
> [102350.350596] smpboot: CPU 2 is now offline
> [102350.354365] smpboot: CPU 1 is now offline
> [102350.363828] ACPI: PM: Low-level resume complete
> [102350.363872] ACPI: EC: EC started
> [102350.363873] ACPI: PM: Restoring platform NVS memory
> [102350.365763] Enabling non-boot CPUs ...
> [102350.365788] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [102350.366528] CPU1 is up
> [102350.366542] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [102350.367305] CPU2 is up
> [102350.367321] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [102350.368042] CPU3 is up
> [102350.370925] ACPI: PM: Waking up from system sleep state S3
> [102350.401906] ACPI: EC: interrupt unblocked
> [102350.417854] ACPI: EC: event unblocked
> [102350.430044] nvme nvme0: 4/0/0 default/read/poll queues
> [102350.536908] OOM killer enabled.
> [102350.536919] Restarting tasks: Starting
> [102350.537322] usb 1-3: USB disconnect, device number 109
> [102350.539913] Restarting tasks: Done
> [102350.539950] random: crng reseeded on system resumption
> [102350.649361] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [102350.665361] usb 1-3: new full-speed USB device number 112 using xhci_hcd
> [102350.802530] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [102350.802538] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [102350.810081] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [102350.895399] PM: suspend exit
> [102350.896075] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [102350.896081] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [102350.903775] usb 1-4: USB disconnect, device number 110
> [102351.076135] rfkill: input handler enabled
> [102351.076374] Process accounting resumed
> [102351.107864] rfkill: input handler disabled
> [102351.109478] usb 1-4: new full-speed USB device number 113 using xhci_hcd
> [102351.246850] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [102351.246858] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [102351.246861] usb 1-4: Product: Touchscreen
> [102351.246863] usb 1-4: Manufacturer: ELAN
> [102351.256260] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [102351.259390] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0030/input/input229
> [102351.259619] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0030/input/input230
> [102351.259703] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0030/input/input231
> [102351.259883] hid-multitouch 0003:04F3:2234.0030: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [102351.260051] usb 1-5: USB disconnect, device number 111
> [102351.283083] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [102351.377395] usb 1-5: new high-speed USB device number 114 using xhci_hcd
> [102351.573890] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [102351.573905] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [102351.573921] usb 1-5: Product: Integrated_Webcam_HD
> [102351.573925] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [102351.582305] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [102351.868767] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [102409.908067] PM: suspend entry (deep)
> [102409.915127] Filesystems sync: 0.007 seconds
> [102409.921688] Freezing user space processes
> [102409.923410] Freezing user space processes completed (elapsed 0.001 seconds)
> [102409.923414] OOM killer disabled.
> [102409.923415] Freezing remaining freezable tasks
> [102409.924923] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [102409.924974] printk: Suspending console(s) (use no_console_suspend to debug)
> [102410.432600] ACPI: EC: interrupt blocked
> [102410.454786] ACPI: PM: Preparing to enter system sleep state S3
> [102410.465934] ACPI: EC: event blocked
> [102410.465939] ACPI: EC: EC stopped
> [102410.465941] ACPI: PM: Saving platform NVS memory
> [102410.469559] Disabling non-boot CPUs ...
> [102410.471912] smpboot: CPU 3 is now offline
> [102410.478646] smpboot: CPU 2 is now offline
> [102410.485821] smpboot: CPU 1 is now offline
> [102410.495318] ACPI: PM: Low-level resume complete
> [102410.495363] ACPI: EC: EC started
> [102410.495363] ACPI: PM: Restoring platform NVS memory
> [102410.497253] Enabling non-boot CPUs ...
> [102410.497276] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [102410.498020] CPU1 is up
> [102410.498037] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [102410.498802] CPU2 is up
> [102410.498817] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [102410.499542] CPU3 is up
> [102410.502449] ACPI: PM: Waking up from system sleep state S3
> [102410.531171] ACPI: EC: interrupt unblocked
> [102410.547785] ACPI: EC: event unblocked
> [102410.560518] nvme nvme0: 4/0/0 default/read/poll queues
> [102410.667534] OOM killer enabled.
> [102410.667539] Restarting tasks: Starting
> [102410.667659] usb 1-3: USB disconnect, device number 112
> [102410.669373] Restarting tasks: Done
> [102410.669410] random: crng reseeded on system resumption
> [102410.784789] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [102410.954895] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [102411.065937] PM: suspend exit
> [102411.184798] usb 1-3: new full-speed USB device number 115 using xhci_hcd
> [102411.325964] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [102411.325971] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [102411.328386] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [102411.328392] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [102411.330135] usb 1-4: USB disconnect, device number 113
> [102411.351923] Process accounting resumed
> [102411.556768] usb 1-4: new full-speed USB device number 116 using xhci_hcd
> [102411.684271] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [102411.694821] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [102411.694829] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [102411.694832] usb 1-4: Product: Touchscreen
> [102411.694835] usb 1-4: Manufacturer: ELAN
> [102411.703818] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0031/input/input234
> [102411.703951] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0031/input/input235
> [102411.704021] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0031/input/input236
> [102411.704156] hid-multitouch 0003:04F3:2234.0031: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [102411.704381] usb 1-5: USB disconnect, device number 114
> [102411.706455] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [102411.824744] usb 1-5: new high-speed USB device number 117 using xhci_hcd
> [102412.000380] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [102412.025216] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [102412.025223] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [102412.025225] usb 1-5: Product: Integrated_Webcam_HD
> [102412.025227] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [102412.033039] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [102422.112641] wlp58s0: authenticate with 00:6b:f1:ea:9c:2f (local address=9c:b6:d0:d1:6a:b1)
> [102422.112649] wlp58s0: send auth to 00:6b:f1:ea:9c:2f (try 1/3)
> [102422.113247] wlp58s0: authenticated
> [102422.116589] wlp58s0: associate with 00:6b:f1:ea:9c:2f (try 1/3)
> [102422.118099] wlp58s0: RX AssocResp from 00:6b:f1:ea:9c:2f (capab=0x1101 status=17 aid=0)
> [102422.118104] wlp58s0: 00:6b:f1:ea:9c:2f denied association (code=17)
> [102422.691025] wlp58s0: authenticate with 70:79:b3:62:6d:ed (local address=9c:b6:d0:d1:6a:b1)
> [102422.691066] wlp58s0: send auth to 70:79:b3:62:6d:ed (try 1/3)
> [102422.692070] wlp58s0: authenticated
> [102422.696574] wlp58s0: associate with 70:79:b3:62:6d:ed (try 1/3)
> [102422.700511] wlp58s0: RX AssocResp from 70:79:b3:62:6d:ed (capab=0x1101 status=0 aid=11)
> [102422.703111] wlp58s0: associated
> [102422.707988] wlp58s0: Limiting TX power to 21 (21 - 0) dBm as advertised by 70:79:b3:62:6d:ed
> [102459.126203] wlp58s0: disconnect from AP 70:79:b3:62:6d:ed for new auth to 00:6b:f1:ea:9c:2f
> [102459.203098] wlp58s0: authenticate with 00:6b:f1:ea:9c:2f (local address=9c:b6:d0:d1:6a:b1)
> [102459.203106] wlp58s0: send auth to 00:6b:f1:ea:9c:2f (try 1/3)
> [102459.206644] wlp58s0: authenticated
> [102459.208105] wlp58s0: associate with 00:6b:f1:ea:9c:2f (try 1/3)
> [102459.209519] wlp58s0: RX ReassocResp from 00:6b:f1:ea:9c:2f (capab=0x101 status=17 aid=0)
> [102459.209530] wlp58s0: 00:6b:f1:ea:9c:2f denied association (code=17)
> [102464.233218] wlp58s0: authenticate with 70:79:b3:62:6d:ed (local address=9c:b6:d0:d1:6a:b1)
> [102464.233233] wlp58s0: send auth to 70:79:b3:62:6d:ed (try 1/3)
> [102464.235955] wlp58s0: authenticated
> [102464.240032] wlp58s0: associate with 70:79:b3:62:6d:ed (try 1/3)
> [102464.243303] wlp58s0: RX AssocResp from 70:79:b3:62:6d:ed (capab=0x1101 status=0 aid=11)
> [102464.246666] wlp58s0: associated
> [102464.282133] wlp58s0: Limiting TX power to 21 (21 - 0) dBm as advertised by 70:79:b3:62:6d:ed
> [102538.364878] wlp58s0: disconnect from AP 70:79:b3:62:6d:ed for new auth to 00:6b:f1:ea:9c:2f
> [102538.429898] wlp58s0: authenticate with 00:6b:f1:ea:9c:2f (local address=9c:b6:d0:d1:6a:b1)
> [102538.429914] wlp58s0: send auth to 00:6b:f1:ea:9c:2f (try 1/3)
> [102538.430550] wlp58s0: authenticated
> [102538.439081] wlp58s0: associate with 00:6b:f1:ea:9c:2f (try 1/3)
> [102538.440513] wlp58s0: RX ReassocResp from 00:6b:f1:ea:9c:2f (capab=0x101 status=17 aid=0)
> [102538.440536] wlp58s0: 00:6b:f1:ea:9c:2f denied association (code=17)
> [102543.472313] wlp58s0: authenticate with 70:79:b3:62:6d:ed (local address=9c:b6:d0:d1:6a:b1)
> [102543.472338] wlp58s0: send auth to 70:79:b3:62:6d:ed (try 1/3)
> [102543.474800] wlp58s0: authenticated
> [102543.491017] wlp58s0: associate with 70:79:b3:62:6d:ed (try 1/3)
> [102543.494569] wlp58s0: RX AssocResp from 70:79:b3:62:6d:ed (capab=0x1101 status=0 aid=11)
> [102543.503895] wlp58s0: associated
> [102543.641918] wlp58s0: Limiting TX power to 21 (21 - 0) dBm as advertised by 70:79:b3:62:6d:ed
> [102691.829477] wlp58s0: disconnect from AP 70:79:b3:62:6d:ed for new auth to 00:6b:f1:ea:9c:2f
> [102691.907340] wlp58s0: authenticate with 00:6b:f1:ea:9c:2f (local address=9c:b6:d0:d1:6a:b1)
> [102691.907357] wlp58s0: send auth to 00:6b:f1:ea:9c:2f (try 1/3)
> [102691.908289] wlp58s0: authenticated
> [102691.917045] wlp58s0: associate with 00:6b:f1:ea:9c:2f (try 1/3)
> [102691.918526] wlp58s0: RX ReassocResp from 00:6b:f1:ea:9c:2f (capab=0x101 status=17 aid=0)
> [102691.918543] wlp58s0: 00:6b:f1:ea:9c:2f denied association (code=17)
> [102696.955195] wlp58s0: authenticate with 70:79:b3:62:6d:ed (local address=9c:b6:d0:d1:6a:b1)
> [102696.955221] wlp58s0: send auth to 70:79:b3:62:6d:ed (try 1/3)
> [102696.959455] wlp58s0: authenticated
> [102696.961002] wlp58s0: associate with 70:79:b3:62:6d:ed (try 1/3)
> [102696.964855] wlp58s0: RX AssocResp from 70:79:b3:62:6d:ed (capab=0x1101 status=0 aid=11)
> [102696.968683] wlp58s0: associated
> [102697.035743] wlp58s0: Limiting TX power to 21 (21 - 0) dBm as advertised by 70:79:b3:62:6d:ed
> [102873.341127] wlp58s0: deauthenticating from 70:79:b3:62:6d:ed by local choice (Reason: 3=DEAUTH_LEAVING)
> [102874.837481] PM: suspend entry (deep)
> [102874.938158] Filesystems sync: 0.100 seconds
> [102874.961572] Freezing user space processes
> [102874.964962] Freezing user space processes completed (elapsed 0.003 seconds)
> [102874.964981] OOM killer disabled.
> [102874.964985] Freezing remaining freezable tasks
> [102874.967237] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
> [102874.967397] printk: Suspending console(s) (use no_console_suspend to debug)
> [102875.476629] ACPI: EC: interrupt blocked
> [102875.498716] ACPI: PM: Preparing to enter system sleep state S3
> [102875.510468] ACPI: EC: event blocked
> [102875.510473] ACPI: EC: EC stopped
> [102875.510476] ACPI: PM: Saving platform NVS memory
> [102875.514053] Disabling non-boot CPUs ...
> [102875.516455] smpboot: CPU 3 is now offline
> [102875.528286] smpboot: CPU 2 is now offline
> [102875.538333] smpboot: CPU 1 is now offline
> [102875.548973] ACPI: PM: Low-level resume complete
> [102875.549017] ACPI: EC: EC started
> [102875.549018] ACPI: PM: Restoring platform NVS memory
> [102875.550929] Enabling non-boot CPUs ...
> [102875.550953] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [102875.551697] CPU1 is up
> [102875.551712] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [102875.552487] CPU2 is up
> [102875.552502] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [102875.553227] CPU3 is up
> [102875.556118] ACPI: PM: Waking up from system sleep state S3
> [102875.585142] ACPI: EC: interrupt unblocked
> [102875.620972] ACPI: EC: event unblocked
> [102875.633995] nvme nvme0: 4/0/0 default/read/poll queues
> [102875.849202] OOM killer enabled.
> [102875.849209] Restarting tasks: Starting
> [102875.849275] usb 1-3: USB disconnect, device number 115
> [102875.854565] Restarting tasks: Done
> [102875.854587] random: crng reseeded on system resumption
> [102875.882758] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [102875.970804] usb 1-3: new full-speed USB device number 118 using xhci_hcd
> [102876.108165] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [102876.108178] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [102876.185953] PM: suspend exit
> [102876.186282] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [102876.186285] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [102876.187256] usb 1-4: USB disconnect, device number 116
> [102876.291345] Process accounting resumed
> [102876.374753] usb 1-4: new full-speed USB device number 119 using xhci_hcd
> [102876.542559] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [102876.551665] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [102876.551674] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [102876.551677] usb 1-4: Product: Touchscreen
> [102876.551679] usb 1-4: Manufacturer: ELAN
> [102876.563153] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0032/input/input239
> [102876.563290] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0032/input/input240
> [102876.563364] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0032/input/input241
> [102876.563508] hid-multitouch 0003:04F3:2234.0032: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [102876.563630] usb 1-5: USB disconnect, device number 117
> [102876.568475] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [102876.686832] usb 1-5: new high-speed USB device number 120 using xhci_hcd
> [102876.883344] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [102876.883354] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [102876.883358] usb 1-5: Product: Integrated_Webcam_HD
> [102876.883361] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [102876.892690] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [102877.148990] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [102881.751977] wlp58s0: authenticate with 7a:8a:20:b8:f7:9a (local address=9c:b6:d0:d1:6a:b1)
> [102881.751984] wlp58s0: send auth to 7a:8a:20:b8:f7:9a (try 1/3)
> [102881.755514] wlp58s0: authenticated
> [102881.758690] wlp58s0: associate with 7a:8a:20:b8:f7:9a (try 1/3)
> [102881.763900] wlp58s0: RX AssocResp from 7a:8a:20:b8:f7:9a (capab=0x411 status=0 aid=8)
> [102881.766725] wlp58s0: associated
> [102956.386272] wlp58s0: disconnect from AP 7a:8a:20:b8:f7:9a for new auth to fe:ec:da:8e:56:dc
> [102956.470767] wlp58s0: authenticate with fe:ec:da:8e:56:dc (local address=9c:b6:d0:d1:6a:b1)
> [102956.470787] wlp58s0: send auth to fe:ec:da:8e:56:dc (try 1/3)
> [102956.474266] wlp58s0: authenticated
> [102956.485735] wlp58s0: associate with fe:ec:da:8e:56:dc (try 1/3)
> [102956.492663] wlp58s0: RX ReassocResp from fe:ec:da:8e:56:dc (capab=0x411 status=0 aid=21)
> [102956.495716] wlp58s0: associated
> [103008.249255] ath10k_pci 0000:3a:00.0: failed to flush transmit queue (skip 0 ar-state 1): 0
> [103008.289852] wlp58s0: disconnect from AP fe:ec:da:8e:56:dc for new auth to fc:ec:da:8d:56:d7
> [103008.391814] wlp58s0: authenticate with fc:ec:da:8d:56:d7 (local address=9c:b6:d0:d1:6a:b1)
> [103008.391836] wlp58s0: send auth to fc:ec:da:8d:56:d7 (try 1/3)
> [103008.398267] wlp58s0: send auth to fc:ec:da:8d:56:d7 (try 2/3)
> [103008.403201] wlp58s0: send auth to fc:ec:da:8d:56:d7 (try 3/3)
> [103008.408335] wlp58s0: authentication with fc:ec:da:8d:56:d7 timed out
> [103008.936822] wlp58s0: authenticate with fe:ec:da:8e:56:d7 (local address=9c:b6:d0:d1:6a:b1)
> [103008.936846] wlp58s0: send auth to fe:ec:da:8e:56:d7 (try 1/3)
> [103008.938226] wlp58s0: send auth to fe:ec:da:8e:56:d7 (try 2/3)
> [103008.939912] wlp58s0: send auth to fe:ec:da:8e:56:d7 (try 3/3)
> [103008.942104] wlp58s0: authentication with fe:ec:da:8e:56:d7 timed out
> [103009.861549] wlp58s0: authenticate with fe:ec:da:8e:56:dc (local address=9c:b6:d0:d1:6a:b1)
> [103009.861557] wlp58s0: send auth to fe:ec:da:8e:56:dc (try 1/3)
> [103009.862822] wlp58s0: send auth to fe:ec:da:8e:56:dc (try 2/3)
> [103009.864395] wlp58s0: send auth to fe:ec:da:8e:56:dc (try 3/3)
> [103009.865696] wlp58s0: authentication with fe:ec:da:8e:56:dc timed out
> [103011.086080] wlp58s0: authenticate with 7a:8a:20:b8:f7:9a (local address=9c:b6:d0:d1:6a:b1)
> [103011.086098] wlp58s0: send auth to 7a:8a:20:b8:f7:9a (try 1/3)
> [103011.087436] wlp58s0: send auth to 7a:8a:20:b8:f7:9a (try 2/3)
> [103011.091105] wlp58s0: send auth to 7a:8a:20:b8:f7:9a (try 3/3)
> [103011.092456] wlp58s0: authentication with 7a:8a:20:b8:f7:9a timed out
> [104341.011474] wlp58s0: authenticate with ac:4a:56:9a:a1:8f (local address=9c:b6:d0:d1:6a:b1)
> [104341.011502] wlp58s0: send auth to ac:4a:56:9a:a1:8f (try 1/3)
> [104341.012597] wlp58s0: send auth to ac:4a:56:9a:a1:8f (try 2/3)
> [104341.013857] wlp58s0: send auth to ac:4a:56:9a:a1:8f (try 3/3)
> [104341.014979] wlp58s0: authentication with ac:4a:56:9a:a1:8f timed out
> [104341.943253] wlp58s0: authenticate with ac:4a:56:99:27:4f (local address=9c:b6:d0:d1:6a:b1)
> [104341.943269] wlp58s0: send auth to ac:4a:56:99:27:4f (try 1/3)
> [104341.944618] wlp58s0: authenticated
> [104341.947341] wlp58s0: associate with ac:4a:56:99:27:4f (try 1/3)
> [104341.952961] wlp58s0: RX AssocResp from ac:4a:56:99:27:4f (capab=0x101 status=0 aid=15)
> [104341.959417] wlp58s0: associated
> [104341.983766] wlp58s0: Limiting TX power to 30 (30 - 0) dBm as advertised by ac:4a:56:99:27:4f
> [104384.535496] wlp58s0: authenticate with 70:79:b3:6e:2f:8f (local address=9c:b6:d0:d1:6a:b1)
> [104384.535513] wlp58s0: send auth to 70:79:b3:6e:2f:8f (try 1/3)
> [104384.536771] wlp58s0: send auth to 70:79:b3:6e:2f:8f (try 2/3)
> [104384.538317] wlp58s0: send auth to 70:79:b3:6e:2f:8f (try 3/3)
> [104384.539410] wlp58s0: authentication with 70:79:b3:6e:2f:8f timed out
> [104385.967741] wlp58s0: authenticate with 1c:d1:e0:3b:68:ef (local address=9c:b6:d0:d1:6a:b1)
> [104385.967758] wlp58s0: send auth to 1c:d1:e0:3b:68:ef (try 1/3)
> [104385.968882] wlp58s0: send auth to 1c:d1:e0:3b:68:ef (try 2/3)
> [104385.970269] wlp58s0: send auth to 1c:d1:e0:3b:68:ef (try 3/3)
> [104385.971422] wlp58s0: authentication with 1c:d1:e0:3b:68:ef timed out
> [104387.762187] wlp58s0: authenticate with ac:4a:56:9a:a1:8f (local address=9c:b6:d0:d1:6a:b1)
> [104387.762202] wlp58s0: send auth to ac:4a:56:9a:a1:8f (try 1/3)
> [104387.763357] wlp58s0: send auth to ac:4a:56:9a:a1:8f (try 2/3)
> [104387.764539] wlp58s0: send auth to ac:4a:56:9a:a1:8f (try 3/3)
> [104387.765638] wlp58s0: authentication with ac:4a:56:9a:a1:8f timed out
> [105290.561279] PM: suspend entry (deep)
> [105290.584847] Filesystems sync: 0.023 seconds
> [105290.591432] Freezing user space processes
> [105290.593245] Freezing user space processes completed (elapsed 0.001 seconds)
> [105290.593249] OOM killer disabled.
> [105290.593250] Freezing remaining freezable tasks
> [105290.594675] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [105290.594735] printk: Suspending console(s) (use no_console_suspend to debug)
> [105291.129536] ACPI: EC: interrupt blocked
> [105291.152887] ACPI: PM: Preparing to enter system sleep state S3
> [105291.163201] ACPI: EC: event blocked
> [105291.163205] ACPI: EC: EC stopped
> [105291.163207] ACPI: PM: Saving platform NVS memory
> [105291.166462] Disabling non-boot CPUs ...
> [105291.169885] smpboot: CPU 3 is now offline
> [105291.173661] smpboot: CPU 2 is now offline
> [105291.177351] smpboot: CPU 1 is now offline
> [105291.187074] ACPI: PM: Low-level resume complete
> [105291.187118] ACPI: EC: EC started
> [105291.187119] ACPI: PM: Restoring platform NVS memory
> [105291.189013] Enabling non-boot CPUs ...
> [105291.189036] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [105291.189776] CPU1 is up
> [105291.189792] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [105291.190553] CPU2 is up
> [105291.190568] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [105291.191293] CPU3 is up
> [105291.194150] ACPI: PM: Waking up from system sleep state S3
> [105291.227491] ACPI: EC: interrupt unblocked
> [105291.256484] ACPI: EC: event unblocked
> [105291.268865] nvme nvme0: 4/0/0 default/read/poll queues
> [105291.502946] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [105291.701869] OOM killer enabled.
> [105291.701872] Restarting tasks: Starting
> [105291.702429] usb 1-3: USB disconnect, device number 118
> [105291.704279] Restarting tasks: Done
> [105291.704330] random: crng reseeded on system resumption
> [105291.802912] PM: suspend exit
> [105291.922953] usb 1-3: new full-speed USB device number 121 using xhci_hcd
> [105292.014481] Process accounting resumed
> [105292.081900] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [105292.081908] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [105292.083832] usb 1-4: USB disconnect, device number 119
> [105292.084827] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [105292.084831] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [105292.278965] usb 1-4: new full-speed USB device number 122 using xhci_hcd
> [105292.416439] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [105292.416447] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [105292.416450] usb 1-4: Product: Touchscreen
> [105292.416452] usb 1-4: Manufacturer: ELAN
> [105292.426136] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0033/input/input244
> [105292.426302] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0033/input/input245
> [105292.426372] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0033/input/input246
> [105292.426503] hid-multitouch 0003:04F3:2234.0033: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [105292.426733] usb 1-5: USB disconnect, device number 120
> [105292.440825] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [105292.464727] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [105292.546948] usb 1-5: new high-speed USB device number 123 using xhci_hcd
> [105292.689985] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [105292.747470] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [105292.747476] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [105292.747478] usb 1-5: Product: Integrated_Webcam_HD
> [105292.747480] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [105292.755333] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [106305.993219] PM: suspend entry (deep)
> [106306.028232] Filesystems sync: 0.035 seconds
> [106306.048790] Freezing user space processes
> [106306.051604] Freezing user space processes completed (elapsed 0.002 seconds)
> [106306.051615] OOM killer disabled.
> [106306.051618] Freezing remaining freezable tasks
> [106306.053391] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [106306.053526] printk: Suspending console(s) (use no_console_suspend to debug)
> [106306.564240] ACPI: EC: interrupt blocked
> [106306.585646] ACPI: PM: Preparing to enter system sleep state S3
> [106306.596842] ACPI: EC: event blocked
> [106306.596847] ACPI: EC: EC stopped
> [106306.596849] ACPI: PM: Saving platform NVS memory
> [106306.600076] Disabling non-boot CPUs ...
> [106306.603228] smpboot: CPU 3 is now offline
> [106306.606867] smpboot: CPU 2 is now offline
> [106306.610843] smpboot: CPU 1 is now offline
> [106306.619381] ACPI: PM: Low-level resume complete
> [106306.619425] ACPI: EC: EC started
> [106306.619425] ACPI: PM: Restoring platform NVS memory
> [106306.621329] Enabling non-boot CPUs ...
> [106306.621352] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [106306.622085] CPU1 is up
> [106306.622101] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [106306.622866] CPU2 is up
> [106306.622880] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [106306.623604] CPU3 is up
> [106306.626509] ACPI: PM: Waking up from system sleep state S3
> [106306.657713] ACPI: EC: interrupt unblocked
> [106306.673203] ACPI: EC: event unblocked
> [106306.684995] nvme nvme0: 4/0/0 default/read/poll queues
> [106306.786969] OOM killer enabled.
> [106306.786970] Restarting tasks: Starting
> [106306.787024] usb 1-3: USB disconnect, device number 121
> [106306.788526] Restarting tasks: Done
> [106306.788546] random: crng reseeded on system resumption
> [106306.893770] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [106306.917730] usb 1-3: new full-speed USB device number 124 using xhci_hcd
> [106307.054942] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [106307.054951] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [106307.174342] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [106307.174351] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [106307.175117] PM: suspend exit
> [106307.178967] usb 1-4: USB disconnect, device number 122
> [106307.373780] usb 1-4: new full-speed USB device number 125 using xhci_hcd
> [106307.451959] Process accounting resumed
> [106307.511255] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [106307.511262] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [106307.511265] usb 1-4: Product: Touchscreen
> [106307.511273] usb 1-4: Manufacturer: ELAN
> [106307.522429] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0034/input/input249
> [106307.523496] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0034/input/input250
> [106307.523595] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0034/input/input251
> [106307.523784] hid-multitouch 0003:04F3:2234.0034: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [106307.523957] usb 1-5: USB disconnect, device number 123
> [106307.533060] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [106307.561803] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [106307.645762] usb 1-5: new high-speed USB device number 126 using xhci_hcd
> [106307.842235] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [106307.842252] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [106307.842254] usb 1-5: Product: Integrated_Webcam_HD
> [106307.842257] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [106307.850111] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [106308.116294] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [106347.346505] wlp58s0: authenticate with 58:8b:f3:1f:3f:50 (local address=9c:b6:d0:d1:6a:b1)
> [106347.346515] wlp58s0: send auth to 58:8b:f3:1f:3f:50 (try 1/3)
> [106347.347380] wlp58s0: authenticated
> [106347.349221] wlp58s0: associate with 58:8b:f3:1f:3f:50 (try 1/3)
> [106347.352102] wlp58s0: RX AssocResp from 58:8b:f3:1f:3f:50 (capab=0x11 status=0 aid=1)
> [106347.354587] wlp58s0: associated
> [106347.434111] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 58:8b:f3:1f:3f:50
> [106866.208203] usbcore: deregistering interface driver btusb
> [111240.761804] wlp58s0: deauthenticating from 58:8b:f3:1f:3f:50 by local choice (Reason: 3=DEAUTH_LEAVING)
> [111243.942856] ath10k_pci 0000:3a:00.0: failed to install key for vdev 0 peer 58:8b:f3:1f:3f:50: -110
> [111243.942889] wlp58s0: failed to remove key (0, 58:8b:f3:1f:3f:50) from hardware (-110)
> [111244.477776] PM: suspend entry (deep)
> [111244.496324] Filesystems sync: 0.018 seconds
> [111244.502844] Freezing user space processes
> [111244.504559] Freezing user space processes completed (elapsed 0.001 seconds)
> [111244.504564] OOM killer disabled.
> [111244.504565] Freezing remaining freezable tasks
> [111244.505947] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [111244.505996] printk: Suspending console(s) (use no_console_suspend to debug)
> [111245.026944] ACPI: EC: interrupt blocked
> [111245.049190] ACPI: PM: Preparing to enter system sleep state S3
> [111245.060457] ACPI: EC: event blocked
> [111245.060461] ACPI: EC: EC stopped
> [111245.060463] ACPI: PM: Saving platform NVS memory
> [111245.063750] Disabling non-boot CPUs ...
> [111245.065807] smpboot: CPU 3 is now offline
> [111245.069544] smpboot: CPU 2 is now offline
> [111245.074504] smpboot: CPU 1 is now offline
> [111245.084772] ACPI: PM: Low-level resume complete
> [111245.084819] ACPI: EC: EC started
> [111245.084820] ACPI: PM: Restoring platform NVS memory
> [111245.086690] Enabling non-boot CPUs ...
> [111245.086767] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [111245.087496] CPU1 is up
> [111245.087512] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [111245.088268] CPU2 is up
> [111245.088283] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [111245.088986] CPU3 is up
> [111245.091868] ACPI: PM: Waking up from system sleep state S3
> [111245.123441] ACPI: EC: interrupt unblocked
> [111245.138169] ACPI: EC: event unblocked
> [111245.150865] nvme nvme0: 4/0/0 default/read/poll queues
> [111245.358754] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [111245.368451] OOM killer enabled.
> [111245.368452] Restarting tasks: Starting
> [111245.368497] usb 1-3: USB disconnect, device number 124
> [111245.370999] Restarting tasks: Done
> [111245.371027] random: crng reseeded on system resumption
> [111245.494726] usb 1-3: new full-speed USB device number 127 using xhci_hcd
> [111245.632479] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [111245.632490] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [111245.635584] usb 1-4: USB disconnect, device number 125
> [111245.642210] PM: suspend exit
> [111245.822719] usb 1-4: new full-speed USB device number 2 using xhci_hcd
> [111245.936748] Process accounting resumed
> [111245.964208] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [111245.964215] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [111245.964218] usb 1-4: Product: Touchscreen
> [111245.964220] usb 1-4: Manufacturer: ELAN
> [111245.982970] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0035/input/input254
> [111245.983090] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0035/input/input255
> [111245.983153] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0035/input/input256
> [111245.983281] hid-multitouch 0003:04F3:2234.0035: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [111245.983399] usb 1-5: USB disconnect, device number 126
> [111246.106728] usb 1-5: new high-speed USB device number 3 using xhci_hcd
> [111246.303452] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [111246.303459] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [111246.303462] usb 1-5: Product: Integrated_Webcam_HD
> [111246.303464] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [111246.311737] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [111246.553122] usbcore: registered new interface driver btusb
> [111246.554493] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [111246.554505] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [111246.592169] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [111246.912422] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [111246.936420] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [111251.513425] wlp58s0: authenticate with 58:8b:f3:1f:3f:50 (local address=9c:b6:d0:d1:6a:b1)
> [111251.513443] wlp58s0: send auth to 58:8b:f3:1f:3f:50 (try 1/3)
> [111251.514592] wlp58s0: authenticated
> [111251.518709] wlp58s0: associate with 58:8b:f3:1f:3f:50 (try 1/3)
> [111251.520805] wlp58s0: RX AssocResp from 58:8b:f3:1f:3f:50 (capab=0x11 status=0 aid=3)
> [111251.523920] wlp58s0: associated
> [111251.531707] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 58:8b:f3:1f:3f:50
> [112337.322603] usbcore: deregistering interface driver btusb
> [113002.750960] wlp58s0: deauthenticating from 58:8b:f3:1f:3f:50 by local choice (Reason: 3=DEAUTH_LEAVING)
> [113005.981904] ath10k_pci 0000:3a:00.0: failed to install key for vdev 0 peer 58:8b:f3:1f:3f:50: -110
> [113005.981928] wlp58s0: failed to remove key (0, 58:8b:f3:1f:3f:50) from hardware (-110)
> [113006.493303] PM: suspend entry (deep)
> [113006.510162] Filesystems sync: 0.016 seconds
> [113006.526821] Freezing user space processes
> [113006.528971] Freezing user space processes completed (elapsed 0.002 seconds)
> [113006.528980] OOM killer disabled.
> [113006.528982] Freezing remaining freezable tasks
> [113006.530541] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [113006.530627] printk: Suspending console(s) (use no_console_suspend to debug)
> [113007.048488] ACPI: EC: interrupt blocked
> [113007.071893] ACPI: PM: Preparing to enter system sleep state S3
> [113007.083016] ACPI: EC: event blocked
> [113007.083021] ACPI: EC: EC stopped
> [113007.083022] ACPI: PM: Saving platform NVS memory
> [113007.086524] Disabling non-boot CPUs ...
> [113007.088755] smpboot: CPU 3 is now offline
> [113007.092249] smpboot: CPU 2 is now offline
> [113007.097017] smpboot: CPU 1 is now offline
> [113007.105879] ACPI: PM: Low-level resume complete
> [113007.105922] ACPI: EC: EC started
> [113007.105923] ACPI: PM: Restoring platform NVS memory
> [113007.107812] Enabling non-boot CPUs ...
> [113007.107836] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [113007.108572] CPU1 is up
> [113007.108586] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [113007.109342] CPU2 is up
> [113007.109357] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [113007.110094] CPU3 is up
> [113007.112945] ACPI: PM: Waking up from system sleep state S3
> [113007.142225] ACPI: EC: interrupt unblocked
> [113007.158186] ACPI: EC: event unblocked
> [113007.169307] nvme nvme0: 4/0/0 default/read/poll queues
> [113007.383553] OOM killer enabled.
> [113007.383555] Restarting tasks: Starting
> [113007.383599] usb 1-3: USB disconnect, device number 127
> [113007.386110] Restarting tasks: Done
> [113007.386141] random: crng reseeded on system resumption
> [113007.397906] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [113007.505970] usb 1-3: new full-speed USB device number 4 using xhci_hcd
> [113007.568326] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [113007.651368] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [113007.651386] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [113007.664306] usb 1-4: USB disconnect, device number 2
> [113007.778708] PM: suspend exit
> [113007.878006] usb 1-4: new full-speed USB device number 5 using xhci_hcd
> [113007.958842] Process accounting resumed
> [113008.019501] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [113008.019508] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [113008.019511] usb 1-4: Product: Touchscreen
> [113008.019513] usb 1-4: Manufacturer: ELAN
> [113008.035218] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0036/input/input259
> [113008.035370] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0036/input/input260
> [113008.035443] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0036/input/input261
> [113008.036506] hid-multitouch 0003:04F3:2234.0036: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [113008.036633] usb 1-5: USB disconnect, device number 3
> [113008.157914] usb 1-5: new high-speed USB device number 6 using xhci_hcd
> [113008.354461] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [113008.354468] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [113008.354469] usb 1-5: Product: Integrated_Webcam_HD
> [113008.354471] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [113008.362559] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [113008.598704] usbcore: registered new interface driver btusb
> [113008.599987] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [113008.599998] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [113008.742426] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [113008.956065] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [113008.979656] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [113013.416821] wlp58s0: authenticate with 58:8b:f3:1f:3f:50 (local address=9c:b6:d0:d1:6a:b1)
> [113013.416840] wlp58s0: send auth to 58:8b:f3:1f:3f:50 (try 1/3)
> [113013.417740] wlp58s0: authenticated
> [113013.421890] wlp58s0: associate with 58:8b:f3:1f:3f:50 (try 1/3)
> [113013.424672] wlp58s0: RX AssocResp from 58:8b:f3:1f:3f:50 (capab=0x11 status=0 aid=1)
> [113013.427679] wlp58s0: associated
> [113013.448070] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 58:8b:f3:1f:3f:50
> [113160.146102] wlp58s0: deauthenticating from 58:8b:f3:1f:3f:50 by local choice (Reason: 3=DEAUTH_LEAVING)
> [113161.785479] PM: suspend entry (deep)
> [113161.800683] Filesystems sync: 0.015 seconds
> [113161.814422] Freezing user space processes
> [113161.816534] Freezing user space processes completed (elapsed 0.002 seconds)
> [113161.816542] OOM killer disabled.
> [113161.816544] Freezing remaining freezable tasks
> [113161.818111] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [113161.818197] printk: Suspending console(s) (use no_console_suspend to debug)
> [113162.328775] ACPI: EC: interrupt blocked
> [113162.349369] ACPI: PM: Preparing to enter system sleep state S3
> [113162.360681] ACPI: EC: event blocked
> [113162.360686] ACPI: EC: EC stopped
> [113162.360687] ACPI: PM: Saving platform NVS memory
> [113162.363967] Disabling non-boot CPUs ...
> [113162.366132] smpboot: CPU 3 is now offline
> [113162.372362] smpboot: CPU 2 is now offline
> [113162.377492] smpboot: CPU 1 is now offline
> [113162.386125] ACPI: PM: Low-level resume complete
> [113162.386168] ACPI: EC: EC started
> [113162.386168] ACPI: PM: Restoring platform NVS memory
> [113162.388041] Enabling non-boot CPUs ...
> [113162.388073] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [113162.388824] CPU1 is up
> [113162.388839] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [113162.389612] CPU2 is up
> [113162.389627] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [113162.390348] CPU3 is up
> [113162.393218] ACPI: PM: Waking up from system sleep state S3
> [113162.422908] ACPI: EC: interrupt unblocked
> [113162.435059] ACPI: EC: event unblocked
> [113162.446310] nvme nvme0: 4/0/0 default/read/poll queues
> [113162.652537] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [113162.662772] OOM killer enabled.
> [113162.662773] Restarting tasks: Starting
> [113162.662869] usb 1-3: USB disconnect, device number 4
> [113162.664823] Restarting tasks: Done
> [113162.664852] random: crng reseeded on system resumption
> [113162.784606] usb 1-3: new full-speed USB device number 7 using xhci_hcd
> [113162.894366] PM: suspend exit
> [113162.925822] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [113162.925832] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [113162.928867] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [113162.928872] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [113162.932539] usb 1-4: USB disconnect, device number 5
> [113163.041322] Process accounting resumed
> [113163.056457] rfkill: input handler enabled
> [113163.075583] rfkill: input handler disabled
> [113163.188592] usb 1-4: new full-speed USB device number 8 using xhci_hcd
> [113163.291473] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [113163.314253] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [113163.344007] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [113163.344016] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [113163.344019] usb 1-4: Product: Touchscreen
> [113163.344021] usb 1-4: Manufacturer: ELAN
> [113163.372988] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0037/input/input264
> [113163.373261] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0037/input/input265
> [113163.373402] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0037/input/input266
> [113163.373726] hid-multitouch 0003:04F3:2234.0037: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [113163.373873] usb 1-5: USB disconnect, device number 6
> [113163.492586] usb 1-5: new high-speed USB device number 9 using xhci_hcd
> [113163.697111] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [113163.697118] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [113163.697120] usb 1-5: Product: Integrated_Webcam_HD
> [113163.697121] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [113163.704948] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [113163.883985] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [113168.664366] wlp58s0: authenticate with 58:8b:f3:1f:3f:50 (local address=9c:b6:d0:d1:6a:b1)
> [113168.664374] wlp58s0: send auth to 58:8b:f3:1f:3f:50 (try 1/3)
> [113168.665218] wlp58s0: authenticated
> [113168.668481] wlp58s0: associate with 58:8b:f3:1f:3f:50 (try 1/3)
> [113168.669921] wlp58s0: RX AssocResp from 58:8b:f3:1f:3f:50 (capab=0x11 status=0 aid=2)
> [113168.672573] wlp58s0: associated
> [113168.686504] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 58:8b:f3:1f:3f:50
> [113740.356293] wlp58s0: deauthenticating from 58:8b:f3:1f:3f:50 by local choice (Reason: 3=DEAUTH_LEAVING)
> [113742.066425] PM: suspend entry (deep)
> [113742.084223] Filesystems sync: 0.017 seconds
> [113742.091149] Freezing user space processes
> [113742.092815] Freezing user space processes completed (elapsed 0.001 seconds)
> [113742.092819] OOM killer disabled.
> [113742.092820] Freezing remaining freezable tasks
> [113742.094297] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [113742.094408] printk: Suspending console(s) (use no_console_suspend to debug)
> [113742.599516] ACPI: EC: interrupt blocked
> [113742.622579] ACPI: PM: Preparing to enter system sleep state S3
> [113742.632673] ACPI: EC: event blocked
> [113742.632678] ACPI: EC: EC stopped
> [113742.632679] ACPI: PM: Saving platform NVS memory
> [113742.635899] Disabling non-boot CPUs ...
> [113742.638000] smpboot: CPU 3 is now offline
> [113742.643434] smpboot: CPU 2 is now offline
> [113742.647909] smpboot: CPU 1 is now offline
> [113742.656511] ACPI: PM: Low-level resume complete
> [113742.656558] ACPI: EC: EC started
> [113742.656559] ACPI: PM: Restoring platform NVS memory
> [113742.658447] Enabling non-boot CPUs ...
> [113742.658472] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [113742.659205] CPU1 is up
> [113742.659221] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [113742.659992] CPU2 is up
> [113742.660008] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [113742.660719] CPU3 is up
> [113742.663610] ACPI: PM: Waking up from system sleep state S3
> [113742.701306] ACPI: EC: interrupt unblocked
> [113742.716549] ACPI: EC: event unblocked
> [113742.728849] nvme nvme0: 4/0/0 default/read/poll queues
> [113742.938666] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [113742.941075] OOM killer enabled.
> [113742.941077] Restarting tasks: Starting
> [113742.941144] usb 1-3: USB disconnect, device number 7
> [113742.941647] Restarting tasks: Done
> [113742.941671] random: crng reseeded on system resumption
> [113743.106577] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [113743.224165] PM: suspend exit
> [113743.351107] usb 1-3: new full-speed USB device number 10 using xhci_hcd
> [113743.428501] Process accounting resumed
> [113743.488701] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [113743.488709] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [113743.492674] usb 1-4: USB disconnect, device number 8
> [113743.493473] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [113743.493477] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [113743.690629] usb 1-4: new full-speed USB device number 11 using xhci_hcd
> [113743.836239] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [113743.836255] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [113743.836258] usb 1-4: Product: Touchscreen
> [113743.836260] usb 1-4: Manufacturer: ELAN
> [113743.850373] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0038/input/input269
> [113743.852021] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0038/input/input270
> [113743.852418] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0038/input/input271
> [113743.853172] hid-multitouch 0003:04F3:2234.0038: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [113743.853761] usb 1-5: USB disconnect, device number 9
> [113743.871388] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [113743.896479] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [113744.002806] usb 1-5: new high-speed USB device number 12 using xhci_hcd
> [113744.154466] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [113744.199505] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [113744.199533] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [113744.199542] usb 1-5: Product: Integrated_Webcam_HD
> [113744.199558] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [113744.211132] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [113748.976994] wlp58s0: authenticate with 58:8b:f3:1f:3f:50 (local address=9c:b6:d0:d1:6a:b1)
> [113748.977003] wlp58s0: send auth to 58:8b:f3:1f:3f:50 (try 1/3)
> [113748.978321] wlp58s0: authenticated
> [113748.978734] wlp58s0: associate with 58:8b:f3:1f:3f:50 (try 1/3)
> [113748.980273] wlp58s0: RX AssocResp from 58:8b:f3:1f:3f:50 (capab=0x11 status=0 aid=3)
> [113748.982779] wlp58s0: associated
> [113748.984577] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 58:8b:f3:1f:3f:50
> [114134.363752] wlp58s0: deauthenticating from 58:8b:f3:1f:3f:50 by local choice (Reason: 3=DEAUTH_LEAVING)
> [114136.069113] PM: suspend entry (deep)
> [114136.081584] Filesystems sync: 0.012 seconds
> [114136.091412] Freezing user space processes
> [114136.093228] Freezing user space processes completed (elapsed 0.001 seconds)
> [114136.093232] OOM killer disabled.
> [114136.093233] Freezing remaining freezable tasks
> [114136.094758] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [114136.094807] printk: Suspending console(s) (use no_console_suspend to debug)
> [114136.625382] ACPI: EC: interrupt blocked
> [114136.646579] ACPI: PM: Preparing to enter system sleep state S3
> [114136.656655] ACPI: EC: event blocked
> [114136.656660] ACPI: EC: EC stopped
> [114136.656661] ACPI: PM: Saving platform NVS memory
> [114136.659865] Disabling non-boot CPUs ...
> [114136.661956] smpboot: CPU 3 is now offline
> [114136.668245] smpboot: CPU 2 is now offline
> [114136.671767] smpboot: CPU 1 is now offline
> [114136.678610] ACPI: PM: Low-level resume complete
> [114136.678655] ACPI: EC: EC started
> [114136.678655] ACPI: PM: Restoring platform NVS memory
> [114136.680567] Enabling non-boot CPUs ...
> [114136.680597] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [114136.681340] CPU1 is up
> [114136.681355] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [114136.682117] CPU2 is up
> [114136.682133] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [114136.682849] CPU3 is up
> [114136.685725] ACPI: PM: Waking up from system sleep state S3
> [114136.716648] ACPI: EC: interrupt unblocked
> [114136.730105] ACPI: EC: event unblocked
> [114136.742611] nvme nvme0: 4/0/0 default/read/poll queues
> [114136.959106] OOM killer enabled.
> [114136.959108] Restarting tasks: Starting
> [114136.959151] usb 1-3: USB disconnect, device number 10
> [114136.962323] Restarting tasks: Done
> [114136.962343] random: crng reseeded on system resumption
> [114136.964753] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [114137.080803] usb 1-3: new full-speed USB device number 13 using xhci_hcd
> [114137.219080] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [114137.219091] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [114137.251165] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [114137.251174] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [114137.251613] PM: suspend exit
> [114137.257146] usb 1-4: USB disconnect, device number 11
> [114137.448752] usb 1-4: new full-speed USB device number 14 using xhci_hcd
> [114137.457675] Process accounting resumed
> [114137.611367] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [114137.615491] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [114137.615500] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [114137.615503] usb 1-4: Product: Touchscreen
> [114137.615505] usb 1-4: Manufacturer: ELAN
> [114137.633719] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0039/input/input274
> [114137.634551] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0039/input/input275
> [114137.634634] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0039/input/input276
> [114137.634786] hid-multitouch 0003:04F3:2234.0039: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [114137.634929] usb 1-5: USB disconnect, device number 12
> [114137.635504] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [114137.756803] usb 1-5: new high-speed USB device number 15 using xhci_hcd
> [114137.953382] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [114137.953395] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [114137.953399] usb 1-5: Product: Integrated_Webcam_HD
> [114137.953403] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [114137.961520] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [114138.260131] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [114143.011251] wlp58s0: authenticate with 58:8b:f3:1f:3f:50 (local address=9c:b6:d0:d1:6a:b1)
> [114143.011258] wlp58s0: send auth to 58:8b:f3:1f:3f:50 (try 1/3)
> [114143.012118] wlp58s0: authenticated
> [114143.016694] wlp58s0: associate with 58:8b:f3:1f:3f:50 (try 1/3)
> [114143.018029] wlp58s0: RX AssocResp from 58:8b:f3:1f:3f:50 (capab=0x11 status=0 aid=2)
> [114143.020768] wlp58s0: associated
> [114143.072928] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 58:8b:f3:1f:3f:50
> [114245.334517] wlp58s0: deauthenticating from 58:8b:f3:1f:3f:50 by local choice (Reason: 3=DEAUTH_LEAVING)
> [114252.238819] wlp58s0: authenticate with 58:8b:f3:1f:3f:50 (local address=9c:b6:d0:d1:6a:b1)
> [114252.238841] wlp58s0: send auth to 58:8b:f3:1f:3f:50 (try 1/3)
> [114252.240001] wlp58s0: authenticated
> [114252.243588] wlp58s0: associate with 58:8b:f3:1f:3f:50 (try 1/3)
> [114252.245149] wlp58s0: RX AssocResp from 58:8b:f3:1f:3f:50 (capab=0x11 status=0 aid=2)
> [114252.248355] wlp58s0: associated
> [114252.327397] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 58:8b:f3:1f:3f:50
> [114346.226582] wlp58s0: deauthenticating from 58:8b:f3:1f:3f:50 by local choice (Reason: 3=DEAUTH_LEAVING)
> [114347.934235] PM: suspend entry (deep)
> [114347.952523] Filesystems sync: 0.018 seconds
> [114347.958607] Freezing user space processes
> [114347.960383] Freezing user space processes completed (elapsed 0.001 seconds)
> [114347.960387] OOM killer disabled.
> [114347.960388] Freezing remaining freezable tasks
> [114347.961864] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [114347.961913] printk: Suspending console(s) (use no_console_suspend to debug)
> [114348.496887] ACPI: EC: interrupt blocked
> [114348.518668] ACPI: PM: Preparing to enter system sleep state S3
> [114348.529771] ACPI: EC: event blocked
> [114348.529777] ACPI: EC: EC stopped
> [114348.529778] ACPI: PM: Saving platform NVS memory
> [114348.533231] Disabling non-boot CPUs ...
> [114348.535499] smpboot: CPU 3 is now offline
> [114348.540418] smpboot: CPU 2 is now offline
> [114348.545641] smpboot: CPU 1 is now offline
> [114348.553876] ACPI: PM: Low-level resume complete
> [114348.553920] ACPI: EC: EC started
> [114348.553921] ACPI: PM: Restoring platform NVS memory
> [114348.555807] Enabling non-boot CPUs ...
> [114348.555832] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [114348.556574] CPU1 is up
> [114348.556589] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [114348.557367] CPU2 is up
> [114348.557382] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [114348.558101] CPU3 is up
> [114348.560970] ACPI: PM: Waking up from system sleep state S3
> [114348.614873] ACPI: EC: interrupt unblocked
> [114348.668762] ACPI: EC: event unblocked
> [114348.681369] nvme nvme0: 4/0/0 default/read/poll queues
> [114348.904991] OOM killer enabled.
> [114348.904994] Restarting tasks: Starting
> [114348.905052] usb 1-3: USB disconnect, device number 13
> [114348.906390] Restarting tasks: Done
> [114348.906411] random: crng reseeded on system resumption
> [114348.934849] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [114349.030814] usb 1-3: new full-speed USB device number 16 using xhci_hcd
> [114349.110028] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [114349.168475] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [114349.168480] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [114349.199095] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [114349.199099] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [114349.199859] PM: suspend exit
> [114349.200626] usb 1-4: USB disconnect, device number 14
> [114349.314198] Process accounting resumed
> [114349.410796] usb 1-4: new full-speed USB device number 17 using xhci_hcd
> [114349.552339] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [114349.552346] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [114349.552349] usb 1-4: Product: Touchscreen
> [114349.552352] usb 1-4: Manufacturer: ELAN
> [114349.559507] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [114349.572764] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003A/input/input279
> [114349.572894] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003A/input/input280
> [114349.572962] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003A/input/input281
> [114349.573095] hid-multitouch 0003:04F3:2234.003A: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [114349.573212] usb 1-5: USB disconnect, device number 15
> [114349.588518] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [114349.690850] usb 1-5: new high-speed USB device number 18 using xhci_hcd
> [114349.887556] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [114349.887577] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [114349.887586] usb 1-5: Product: Integrated_Webcam_HD
> [114349.887593] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [114349.896355] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [114350.048486] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [114354.920193] wlp58s0: authenticate with 58:8b:f3:1f:3f:50 (local address=9c:b6:d0:d1:6a:b1)
> [114354.920209] wlp58s0: send auth to 58:8b:f3:1f:3f:50 (try 1/3)
> [114354.921597] wlp58s0: authenticated
> [114354.922743] wlp58s0: associate with 58:8b:f3:1f:3f:50 (try 1/3)
> [114354.924390] wlp58s0: RX AssocResp from 58:8b:f3:1f:3f:50 (capab=0x11 status=0 aid=1)
> [114354.927448] wlp58s0: associated
> [114355.012408] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 58:8b:f3:1f:3f:50
> [115024.150370] wlp58s0: deauthenticating from 58:8b:f3:1f:3f:50 by local choice (Reason: 3=DEAUTH_LEAVING)
> [115025.909433] PM: suspend entry (deep)
> [115025.999844] Filesystems sync: 0.090 seconds
> [115026.023398] Freezing user space processes
> [115026.026292] Freezing user space processes completed (elapsed 0.002 seconds)
> [115026.026309] OOM killer disabled.
> [115026.026313] Freezing remaining freezable tasks
> [115026.028287] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [115026.028441] printk: Suspending console(s) (use no_console_suspend to debug)
> [115026.536358] ACPI: EC: interrupt blocked
> [115026.558974] ACPI: PM: Preparing to enter system sleep state S3
> [115026.570287] ACPI: EC: event blocked
> [115026.570292] ACPI: EC: EC stopped
> [115026.570294] ACPI: PM: Saving platform NVS memory
> [115026.573747] Disabling non-boot CPUs ...
> [115026.576004] smpboot: CPU 3 is now offline
> [115026.583303] smpboot: CPU 2 is now offline
> [115026.586724] smpboot: CPU 1 is now offline
> [115026.594771] ACPI: PM: Low-level resume complete
> [115026.594815] ACPI: EC: EC started
> [115026.594815] ACPI: PM: Restoring platform NVS memory
> [115026.596703] Enabling non-boot CPUs ...
> [115026.596727] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [115026.597469] CPU1 is up
> [115026.597484] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [115026.598255] CPU2 is up
> [115026.598271] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [115026.598991] CPU3 is up
> [115026.601853] ACPI: PM: Waking up from system sleep state S3
> [115026.631235] ACPI: EC: interrupt unblocked
> [115026.668331] ACPI: EC: event unblocked
> [115026.680295] nvme nvme0: 4/0/0 default/read/poll queues
> [115026.908059] OOM killer enabled.
> [115026.908061] Restarting tasks: Starting
> [115026.908960] usb 1-3: USB disconnect, device number 16
> [115026.909283] Restarting tasks: Done
> [115026.909298] random: crng reseeded on system resumption
> [115026.930284] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [115027.030333] usb 1-3: new full-speed USB device number 19 using xhci_hcd
> [115027.167929] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [115027.167954] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [115027.246778] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [115027.246792] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [115027.247774] PM: suspend exit
> [115027.251098] usb 1-4: USB disconnect, device number 17
> [115027.427956] Process accounting resumed
> [115027.510286] usb 1-4: new full-speed USB device number 20 using xhci_hcd
> [115027.607630] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [115027.632094] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [115027.647777] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [115027.647787] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [115027.647796] usb 1-4: Product: Touchscreen
> [115027.647799] usb 1-4: Manufacturer: ELAN
> [115027.659133] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003B/input/input284
> [115027.659374] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003B/input/input285
> [115027.659479] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003B/input/input286
> [115027.659774] hid-multitouch 0003:04F3:2234.003B: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [115027.659970] usb 1-5: USB disconnect, device number 18
> [115027.778270] usb 1-5: new high-speed USB device number 21 using xhci_hcd
> [115027.974814] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [115027.974827] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [115027.974840] usb 1-5: Product: Integrated_Webcam_HD
> [115027.974844] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [115027.986457] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [115028.099610] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [115033.044897] wlp58s0: authenticate with 58:8b:f3:1f:3f:50 (local address=9c:b6:d0:d1:6a:b1)
> [115033.044921] wlp58s0: send auth to 58:8b:f3:1f:3f:50 (try 1/3)
> [115033.046344] wlp58s0: authenticated
> [115033.050052] wlp58s0: associate with 58:8b:f3:1f:3f:50 (try 1/3)
> [115033.051647] wlp58s0: RX AssocResp from 58:8b:f3:1f:3f:50 (capab=0x11 status=0 aid=1)
> [115033.054821] wlp58s0: associated
> [115033.063127] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 58:8b:f3:1f:3f:50
> [115267.876448] wlp58s0: deauthenticating from 58:8b:f3:1f:3f:50 by local choice (Reason: 3=DEAUTH_LEAVING)
> [115269.499914] PM: suspend entry (deep)
> [115269.518417] Filesystems sync: 0.018 seconds
> [115269.539456] Freezing user space processes
> [115269.542183] Freezing user space processes completed (elapsed 0.002 seconds)
> [115269.542196] OOM killer disabled.
> [115269.542199] Freezing remaining freezable tasks
> [115269.543577] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [115269.543691] printk: Suspending console(s) (use no_console_suspend to debug)
> [115270.090551] ACPI: EC: interrupt blocked
> [115270.113536] ACPI: PM: Preparing to enter system sleep state S3
> [115270.128748] ACPI: EC: event blocked
> [115270.128753] ACPI: EC: EC stopped
> [115270.128755] ACPI: PM: Saving platform NVS memory
> [115270.132221] Disabling non-boot CPUs ...
> [115270.134409] smpboot: CPU 3 is now offline
> [115270.143077] smpboot: CPU 2 is now offline
> [115270.148322] smpboot: CPU 1 is now offline
> [115270.156606] ACPI: PM: Low-level resume complete
> [115270.156650] ACPI: EC: EC started
> [115270.156650] ACPI: PM: Restoring platform NVS memory
> [115270.158542] Enabling non-boot CPUs ...
> [115270.158566] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [115270.159311] CPU1 is up
> [115270.159327] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [115270.160110] CPU2 is up
> [115270.160126] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [115270.160848] CPU3 is up
> [115270.163728] ACPI: PM: Waking up from system sleep state S3
> [115270.194221] ACPI: EC: interrupt unblocked
> [115270.210302] ACPI: EC: event unblocked
> [115270.223060] nvme nvme0: 4/0/0 default/read/poll queues
> [115270.431496] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [115270.440786] OOM killer enabled.
> [115270.440788] Restarting tasks: Starting
> [115270.440836] usb 1-3: USB disconnect, device number 19
> [115270.441386] Restarting tasks: Done
> [115270.441406] random: crng reseeded on system resumption
> [115270.694633] PM: suspend exit
> [115270.815751] usb 1-3: new full-speed USB device number 22 using xhci_hcd
> [115270.956404] rfkill: input handler enabled
> [115270.967473] rfkill: input handler disabled
> [115270.968294] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [115270.968301] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [115270.977205] usb 1-4: USB disconnect, device number 20
> [115270.980201] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [115270.980213] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [115270.993838] Process accounting resumed
> [115271.205101] usb 1-4: new full-speed USB device number 23 using xhci_hcd
> [115271.341364] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [115271.341376] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [115271.341377] usb 1-4: Product: Touchscreen
> [115271.341379] usb 1-4: Manufacturer: ELAN
> [115271.349829] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [115271.352933] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003C/input/input289
> [115271.353230] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003C/input/input290
> [115271.353889] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003C/input/input291
> [115271.356550] hid-multitouch 0003:04F3:2234.003C: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [115271.356830] usb 1-5: USB disconnect, device number 21
> [115271.377828] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [115271.475636] usb 1-5: new high-speed USB device number 24 using xhci_hcd
> [115271.655642] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [115271.672739] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [115271.672775] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [115271.672785] usb 1-5: Product: Integrated_Webcam_HD
> [115271.672800] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [115271.685592] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [115276.621183] wlp58s0: authenticate with 58:8b:f3:1f:3f:50 (local address=9c:b6:d0:d1:6a:b1)
> [115276.621200] wlp58s0: send auth to 58:8b:f3:1f:3f:50 (try 1/3)
> [115276.622751] wlp58s0: authenticated
> [115276.624029] wlp58s0: associate with 58:8b:f3:1f:3f:50 (try 1/3)
> [115276.625539] wlp58s0: RX AssocResp from 58:8b:f3:1f:3f:50 (capab=0x11 status=0 aid=1)
> [115276.628673] wlp58s0: associated
> [115276.644970] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 58:8b:f3:1f:3f:50
> [115527.179152] wlp58s0: deauthenticating from 58:8b:f3:1f:3f:50 by local choice (Reason: 3=DEAUTH_LEAVING)
> [115528.965960] PM: suspend entry (deep)
> [115528.987024] Filesystems sync: 0.021 seconds
> [115528.993792] Freezing user space processes
> [115528.995526] Freezing user space processes completed (elapsed 0.001 seconds)
> [115528.995529] OOM killer disabled.
> [115528.995530] Freezing remaining freezable tasks
> [115528.996970] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [115528.997020] printk: Suspending console(s) (use no_console_suspend to debug)
> [115529.531158] ACPI: EC: interrupt blocked
> [115529.550921] ACPI: PM: Preparing to enter system sleep state S3
> [115529.560965] ACPI: EC: event blocked
> [115529.560969] ACPI: EC: EC stopped
> [115529.560971] ACPI: PM: Saving platform NVS memory
> [115529.564169] Disabling non-boot CPUs ...
> [115529.567336] smpboot: CPU 3 is now offline
> [115529.572059] smpboot: CPU 2 is now offline
> [115529.576204] smpboot: CPU 1 is now offline
> [115529.584811] ACPI: PM: Low-level resume complete
> [115529.584856] ACPI: EC: EC started
> [115529.584856] ACPI: PM: Restoring platform NVS memory
> [115529.586768] Enabling non-boot CPUs ...
> [115529.586793] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [115529.587545] CPU1 is up
> [115529.587560] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [115529.588338] CPU2 is up
> [115529.588353] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [115529.589087] CPU3 is up
> [115529.591965] ACPI: PM: Waking up from system sleep state S3
> [115529.623852] ACPI: EC: interrupt unblocked
> [115529.639094] ACPI: EC: event unblocked
> [115529.650596] nvme nvme0: 4/0/0 default/read/poll queues
> [115529.857159] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [115529.860016] OOM killer enabled.
> [115529.860018] Restarting tasks: Starting
> [115529.860051] usb 1-3: USB disconnect, device number 22
> [115529.861160] Restarting tasks: Done
> [115529.861178] random: crng reseeded on system resumption
> [115529.981175] usb 1-3: new full-speed USB device number 25 using xhci_hcd
> [115530.118467] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [115530.118481] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [115530.131366] PM: suspend exit
> [115530.131933] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [115530.131941] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [115530.139086] usb 1-4: USB disconnect, device number 23
> [115530.315047] Process accounting resumed
> [115530.325318] usb 1-4: new full-speed USB device number 26 using xhci_hcd
> [115530.467141] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [115530.467149] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [115530.467151] usb 1-4: Product: Touchscreen
> [115530.467159] usb 1-4: Manufacturer: ELAN
> [115530.478443] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003D/input/input294
> [115530.478663] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003D/input/input295
> [115530.482417] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003D/input/input296
> [115530.484367] hid-multitouch 0003:04F3:2234.003D: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [115530.484551] usb 1-5: USB disconnect, device number 24
> [115530.490704] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [115530.515174] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [115530.609458] usb 1-5: new high-speed USB device number 27 using xhci_hcd
> [115530.805989] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [115530.805995] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [115530.805997] usb 1-5: Product: Integrated_Webcam_HD
> [115530.805999] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [115530.813847] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [115531.154531] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [115535.990548] wlp58s0: authenticate with ac:4a:56:9a:a1:8f (local address=9c:b6:d0:d1:6a:b1)
> [115535.990568] wlp58s0: send auth to ac:4a:56:9a:a1:8f (try 1/3)
> [115535.991817] wlp58s0: authenticated
> [115535.994995] wlp58s0: associate with ac:4a:56:9a:a1:8f (try 1/3)
> [115536.089031] wlp58s0: RX AssocResp from ac:4a:56:9a:a1:8f (capab=0x101 status=0 aid=140)
> [115536.092567] wlp58s0: associated
> [115536.127188] wlp58s0: Limiting TX power to 30 (30 - 0) dBm as advertised by ac:4a:56:9a:a1:8f
> [115632.689298] wlp58s0: deauthenticating from ac:4a:56:9a:a1:8f by local choice (Reason: 3=DEAUTH_LEAVING)
> [115634.329837] PM: suspend entry (deep)
> [115634.353556] Filesystems sync: 0.023 seconds
> [115634.359250] Freezing user space processes
> [115634.361118] Freezing user space processes completed (elapsed 0.001 seconds)
> [115634.361121] OOM killer disabled.
> [115634.361122] Freezing remaining freezable tasks
> [115634.362601] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [115634.362651] printk: Suspending console(s) (use no_console_suspend to debug)
> [115634.894106] ACPI: EC: interrupt blocked
> [115634.917210] ACPI: PM: Preparing to enter system sleep state S3
> [115634.927373] ACPI: EC: event blocked
> [115634.927378] ACPI: EC: EC stopped
> [115634.927380] ACPI: PM: Saving platform NVS memory
> [115634.930643] Disabling non-boot CPUs ...
> [115634.932719] smpboot: CPU 3 is now offline
> [115634.937563] smpboot: CPU 2 is now offline
> [115634.940835] smpboot: CPU 1 is now offline
> [115634.949746] ACPI: PM: Low-level resume complete
> [115634.949792] ACPI: EC: EC started
> [115634.949793] ACPI: PM: Restoring platform NVS memory
> [115634.951678] Enabling non-boot CPUs ...
> [115634.951703] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [115634.952454] CPU1 is up
> [115634.952468] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [115634.953241] CPU2 is up
> [115634.953259] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [115634.953984] CPU3 is up
> [115634.956850] ACPI: PM: Waking up from system sleep state S3
> [115634.988847] ACPI: EC: interrupt unblocked
> [115635.002863] ACPI: EC: event unblocked
> [115635.015140] nvme nvme0: 4/0/0 default/read/poll queues
> [115635.229364] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [115635.231278] OOM killer enabled.
> [115635.231280] Restarting tasks: Starting
> [115635.231868] usb 1-3: USB disconnect, device number 25
> [115635.235170] Restarting tasks: Done
> [115635.235190] random: crng reseeded on system resumption
> [115635.353446] usb 1-3: new full-speed USB device number 28 using xhci_hcd
> [115635.478079] PM: suspend exit
> [115635.490709] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [115635.490719] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [115635.503038] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [115635.503053] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [115635.504781] usb 1-4: USB disconnect, device number 26
> [115635.589267] Process accounting resumed
> [115635.608939] rfkill: input handler enabled
> [115635.650705] rfkill: input handler disabled
> [115635.834976] usb 1-4: new full-speed USB device number 29 using xhci_hcd
> [115635.862121] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [115635.887050] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [115635.974862] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [115635.974871] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [115635.974880] usb 1-4: Product: Touchscreen
> [115635.974882] usb 1-4: Manufacturer: ELAN
> [115635.985568] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003E/input/input299
> [115635.985824] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003E/input/input300
> [115635.985938] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003E/input/input301
> [115635.986148] hid-multitouch 0003:04F3:2234.003E: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [115635.986341] usb 1-5: USB disconnect, device number 27
> [115636.105298] usb 1-5: new high-speed USB device number 30 using xhci_hcd
> [115636.301817] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [115636.301841] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [115636.301847] usb 1-5: Product: Integrated_Webcam_HD
> [115636.301861] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [115636.311599] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [115636.455446] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [115640.885387] wlp58s0: authenticate with ac:4a:56:9a:a1:8f (local address=9c:b6:d0:d1:6a:b1)
> [115640.885394] wlp58s0: send auth to ac:4a:56:9a:a1:8f (try 1/3)
> [115640.886561] wlp58s0: send auth to ac:4a:56:9a:a1:8f (try 2/3)
> [115640.887698] wlp58s0: send auth to ac:4a:56:9a:a1:8f (try 3/3)
> [115640.888790] wlp58s0: authentication with ac:4a:56:9a:a1:8f timed out
> [115641.451672] wlp58s0: authenticate with 00:81:c4:e7:0a:df (local address=9c:b6:d0:d1:6a:b1)
> [115641.451688] wlp58s0: send auth to 00:81:c4:e7:0a:df (try 1/3)
> [115641.452428] wlp58s0: authenticated
> [115641.456972] wlp58s0: associate with 00:81:c4:e7:0a:df (try 1/3)
> [115641.458946] wlp58s0: RX AssocResp from 00:81:c4:e7:0a:df (capab=0x101 status=0 aid=13)
> [115641.462264] wlp58s0: associated
> [115641.472683] wlp58s0: Limiting TX power to 17 dBm as advertised by 00:81:c4:e7:0a:df
> [115656.888377] wlp58s0: deauthenticating from 00:81:c4:e7:0a:df by local choice (Reason: 3=DEAUTH_LEAVING)
> [116599.289518] PM: suspend entry (deep)
> [116599.316978] Filesystems sync: 0.027 seconds
> [116599.323656] Freezing user space processes
> [116599.325416] Freezing user space processes completed (elapsed 0.001 seconds)
> [116599.325420] OOM killer disabled.
> [116599.325420] Freezing remaining freezable tasks
> [116599.326816] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [116599.326864] printk: Suspending console(s) (use no_console_suspend to debug)
> [116599.863484] ACPI: EC: interrupt blocked
> [116599.885296] ACPI: PM: Preparing to enter system sleep state S3
> [116599.895447] ACPI: EC: event blocked
> [116599.895451] ACPI: EC: EC stopped
> [116599.895453] ACPI: PM: Saving platform NVS memory
> [116599.898794] Disabling non-boot CPUs ...
> [116599.900868] smpboot: CPU 3 is now offline
> [116599.904396] smpboot: CPU 2 is now offline
> [116599.908679] smpboot: CPU 1 is now offline
> [116599.917353] ACPI: PM: Low-level resume complete
> [116599.917398] ACPI: EC: EC started
> [116599.917399] ACPI: PM: Restoring platform NVS memory
> [116599.919295] Enabling non-boot CPUs ...
> [116599.919318] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [116599.920055] CPU1 is up
> [116599.920068] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [116599.920831] CPU2 is up
> [116599.920847] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [116599.921586] CPU3 is up
> [116599.924439] ACPI: PM: Waking up from system sleep state S3
> [116599.960600] ACPI: EC: interrupt unblocked
> [116599.976923] ACPI: EC: event unblocked
> [116599.988843] nvme nvme0: 4/0/0 default/read/poll queues
> [116600.094449] OOM killer enabled.
> [116600.094451] Restarting tasks: Starting
> [116600.097577] usb 1-3: USB disconnect, device number 28
> [116600.097671] Restarting tasks: Done
> [116600.097689] random: crng reseeded on system resumption
> [116600.221380] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [116600.395505] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [116600.545870] PM: suspend exit
> [116600.669364] usb 1-3: new full-speed USB device number 31 using xhci_hcd
> [116600.778147] Process accounting resumed
> [116600.814531] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [116600.814539] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [116600.817111] usb 1-4: USB disconnect, device number 29
> [116600.818358] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [116600.818363] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [116601.029287] usb 1-4: new full-speed USB device number 32 using xhci_hcd
> [116601.166993] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [116601.167002] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [116601.167005] usb 1-4: Product: Touchscreen
> [116601.167008] usb 1-4: Manufacturer: ELAN
> [116601.177549] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [116601.178347] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003F/input/input304
> [116601.178517] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003F/input/input305
> [116601.178678] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.003F/input/input306
> [116601.178876] hid-multitouch 0003:04F3:2234.003F: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [116601.179066] usb 1-5: USB disconnect, device number 30
> [116601.204390] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [116601.305268] usb 1-5: new high-speed USB device number 33 using xhci_hcd
> [116601.421920] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [116601.505843] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [116601.505849] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [116601.505851] usb 1-5: Product: Integrated_Webcam_HD
> [116601.505852] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [116601.513696] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [116906.888755] usbcore: deregistering interface driver btusb
> [122198.249402] PM: suspend entry (deep)
> [122198.266935] Filesystems sync: 0.017 seconds
> [122198.273383] Freezing user space processes
> [122198.275107] Freezing user space processes completed (elapsed 0.001 seconds)
> [122198.275111] OOM killer disabled.
> [122198.275112] Freezing remaining freezable tasks
> [122198.276585] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [122198.276635] printk: Suspending console(s) (use no_console_suspend to debug)
> [122198.799440] ACPI: EC: interrupt blocked
> [122198.820821] ACPI: PM: Preparing to enter system sleep state S3
> [122198.830886] ACPI: EC: event blocked
> [122198.830890] ACPI: EC: EC stopped
> [122198.830892] ACPI: PM: Saving platform NVS memory
> [122198.834163] Disabling non-boot CPUs ...
> [122198.836273] smpboot: CPU 3 is now offline
> [122198.840776] smpboot: CPU 2 is now offline
> [122198.843693] smpboot: CPU 1 is now offline
> [122198.850013] ACPI: PM: Low-level resume complete
> [122198.850059] ACPI: EC: EC started
> [122198.850059] ACPI: PM: Restoring platform NVS memory
> [122198.851968] Enabling non-boot CPUs ...
> [122198.851993] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [122198.852739] CPU1 is up
> [122198.852754] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [122198.853525] CPU2 is up
> [122198.853541] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [122198.854264] CPU3 is up
> [122198.857168] ACPI: PM: Waking up from system sleep state S3
> [122198.886522] ACPI: EC: interrupt unblocked
> [122198.940250] ACPI: EC: event unblocked
> [122198.951624] nvme nvme0: 4/0/0 default/read/poll queues
> [122199.057057] OOM killer enabled.
> [122199.057061] Restarting tasks: Starting
> [122199.057122] usb 1-3: USB disconnect, device number 31
> [122199.057979] Restarting tasks: Done
> [122199.058031] random: crng reseeded on system resumption
> [122199.178638] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [122199.182592] usb 1-3: new full-speed USB device number 34 using xhci_hcd
> [122199.319769] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [122199.319777] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [122199.322151] usb 1-4: USB disconnect, device number 32
> [122199.345205] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [122199.462151] PM: suspend exit
> [122199.506742] usb 1-4: new full-speed USB device number 35 using xhci_hcd
> [122199.644432] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [122199.644458] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [122199.644474] usb 1-4: Product: Touchscreen
> [122199.644480] usb 1-4: Manufacturer: ELAN
> [122199.725774] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0040/input/input309
> [122199.725959] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0040/input/input310
> [122199.726058] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0040/input/input311
> [122199.727029] hid-multitouch 0003:04F3:2234.0040: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [122199.732363] usb 1-5: USB disconnect, device number 33
> [122199.747020] Process accounting resumed
> [122199.856085] usb 1-5: new high-speed USB device number 36 using xhci_hcd
> [122200.055058] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [122200.055066] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [122200.055076] usb 1-5: Product: Integrated_Webcam_HD
> [122200.055078] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [122200.063923] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [122200.287916] usbcore: registered new interface driver btusb
> [122200.288506] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [122200.288510] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [122200.357177] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [122200.645390] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [122200.672255] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [122227.563131] wlp58s0: authenticate with 00:5d:73:81:ad:cf (local address=9c:b6:d0:d1:6a:b1)
> [122227.563148] wlp58s0: send auth to 00:5d:73:81:ad:cf (try 1/3)
> [122227.564176] wlp58s0: authenticated
> [122227.568410] wlp58s0: associate with 00:5d:73:81:ad:cf (try 1/3)
> [122227.571653] wlp58s0: RX AssocResp from 00:5d:73:81:ad:cf (capab=0x101 status=0 aid=8)
> [122227.574852] wlp58s0: associated
> [122227.666404] wlp58s0: Limiting TX power to 21 (21 - 0) dBm as advertised by 00:5d:73:81:ad:cf
> [122255.734988] wlp58s0: disconnect from AP 00:5d:73:81:ad:cf for new auth to 00:5d:73:7e:03:2f
> [122255.839138] wlp58s0: authenticate with 00:5d:73:7e:03:2f (local address=9c:b6:d0:d1:6a:b1)
> [122255.839157] wlp58s0: send auth to 00:5d:73:7e:03:2f (try 1/3)
> [122255.840417] wlp58s0: send auth to 00:5d:73:7e:03:2f (try 2/3)
> [122255.842591] wlp58s0: send auth to 00:5d:73:7e:03:2f (try 3/3)
> [122255.843989] wlp58s0: authentication with 00:5d:73:7e:03:2f timed out
> [122256.842728] wlp58s0: authenticate with 00:5d:73:81:ad:cf (local address=9c:b6:d0:d1:6a:b1)
> [122256.842748] wlp58s0: send auth to 00:5d:73:81:ad:cf (try 1/3)
> [122256.843884] wlp58s0: send auth to 00:5d:73:81:ad:cf (try 2/3)
> [122256.845093] wlp58s0: send auth to 00:5d:73:81:ad:cf (try 3/3)
> [122256.846887] wlp58s0: authentication with 00:5d:73:81:ad:cf timed out
> [122311.231507] wlp58s0: authenticate with 90:77:ee:5f:2f:af (local address=9c:b6:d0:d1:6a:b1)
> [122311.231529] wlp58s0: send auth to 90:77:ee:5f:2f:af (try 1/3)
> [122311.232454] wlp58s0: authenticated
> [122311.237737] wlp58s0: associate with 90:77:ee:5f:2f:af (try 1/3)
> [122311.241072] wlp58s0: RX AssocResp from 90:77:ee:5f:2f:af (capab=0x101 status=0 aid=2)
> [122311.244496] wlp58s0: associated
> [122311.325020] wlp58s0: Limiting TX power to 21 (21 - 0) dBm as advertised by 90:77:ee:5f:2f:af
> [122335.826904] wlp58s0: disconnect from AP 90:77:ee:5f:2f:af for new auth to 90:77:ee:75:03:cf
> [122335.921207] wlp58s0: authenticate with 90:77:ee:75:03:cf (local address=9c:b6:d0:d1:6a:b1)
> [122335.921224] wlp58s0: send auth to 90:77:ee:75:03:cf (try 1/3)
> [122335.922310] wlp58s0: send auth to 90:77:ee:75:03:cf (try 2/3)
> [122335.923770] wlp58s0: send auth to 90:77:ee:75:03:cf (try 3/3)
> [122335.924900] wlp58s0: authentication with 90:77:ee:75:03:cf timed out
> [122336.554666] wlp58s0: authenticate with 90:77:ee:1b:90:2f (local address=9c:b6:d0:d1:6a:b1)
> [122336.554692] wlp58s0: send auth to 90:77:ee:1b:90:2f (try 1/3)
> [122336.555912] wlp58s0: send auth to 90:77:ee:1b:90:2f (try 2/3)
> [122336.557375] wlp58s0: send auth to 90:77:ee:1b:90:2f (try 3/3)
> [122336.558848] wlp58s0: authentication with 90:77:ee:1b:90:2f timed out
> [122337.582786] wlp58s0: authenticate with 90:77:ee:39:0d:2f (local address=9c:b6:d0:d1:6a:b1)
> [122337.582803] wlp58s0: send auth to 90:77:ee:39:0d:2f (try 1/3)
> [122337.583954] wlp58s0: send auth to 90:77:ee:39:0d:2f (try 2/3)
> [122337.585108] wlp58s0: send auth to 90:77:ee:39:0d:2f (try 3/3)
> [122337.586291] wlp58s0: authentication with 90:77:ee:39:0d:2f timed out
> [122338.959904] wlp58s0: authenticate with 90:77:ee:5f:2f:af (local address=9c:b6:d0:d1:6a:b1)
> [122338.959931] wlp58s0: send auth to 90:77:ee:5f:2f:af (try 1/3)
> [122338.961152] wlp58s0: send auth to 90:77:ee:5f:2f:af (try 2/3)
> [122338.963651] wlp58s0: send auth to 90:77:ee:5f:2f:af (try 3/3)
> [122338.964762] wlp58s0: authentication with 90:77:ee:5f:2f:af timed out
> [122378.182077] wlp58s0: authenticate with 7c:ad:4f:e8:3a:8f (local address=9c:b6:d0:d1:6a:b1)
> [122378.182083] wlp58s0: send auth to 7c:ad:4f:e8:3a:8f (try 1/3)
> [122378.183137] wlp58s0: authenticated
> [122378.184410] wlp58s0: associate with 7c:ad:4f:e8:3a:8f (try 1/3)
> [122378.187685] wlp58s0: RX AssocResp from 7c:ad:4f:e8:3a:8f (capab=0x101 status=0 aid=5)
> [122378.190621] wlp58s0: associated
> [122378.285599] wlp58s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 7c:ad:4f:e8:3a:8f
> [122414.540573] wlp58s0: disconnect from AP 7c:ad:4f:e8:3a:8f for new auth to 7c:ad:4f:e8:3a:80
> [122414.655419] wlp58s0: authenticate with 7c:ad:4f:e8:3a:80 (local address=9c:b6:d0:d1:6a:b1)
> [122414.655434] wlp58s0: send auth to 7c:ad:4f:e8:3a:80 (try 1/3)
> [122414.657832] wlp58s0: send auth to 7c:ad:4f:e8:3a:80 (try 2/3)
> [122414.659436] wlp58s0: send auth to 7c:ad:4f:e8:3a:80 (try 3/3)
> [122414.660981] wlp58s0: authentication with 7c:ad:4f:e8:3a:80 timed out
> [122416.258865] wlp58s0: authenticate with 7c:ad:4f:e8:3a:8f (local address=9c:b6:d0:d1:6a:b1)
> [122416.258873] wlp58s0: send auth to 7c:ad:4f:e8:3a:8f (try 1/3)
> [122416.260008] wlp58s0: send auth to 7c:ad:4f:e8:3a:8f (try 2/3)
> [122416.261219] wlp58s0: send auth to 7c:ad:4f:e8:3a:8f (try 3/3)
> [122416.262497] wlp58s0: authentication with 7c:ad:4f:e8:3a:8f timed out
> [122525.183912] PM: suspend entry (deep)
> [122525.195158] Filesystems sync: 0.011 seconds
> [122525.214014] Freezing user space processes
> [122525.216204] Freezing user space processes completed (elapsed 0.002 seconds)
> [122525.216212] OOM killer disabled.
> [122525.216214] Freezing remaining freezable tasks
> [122525.217858] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [122525.217940] printk: Suspending console(s) (use no_console_suspend to debug)
> [122525.725283] ACPI: EC: interrupt blocked
> [122525.746861] ACPI: PM: Preparing to enter system sleep state S3
> [122525.757023] ACPI: EC: event blocked
> [122525.757027] ACPI: EC: EC stopped
> [122525.757029] ACPI: PM: Saving platform NVS memory
> [122525.760307] Disabling non-boot CPUs ...
> [122525.762420] smpboot: CPU 3 is now offline
> [122525.766295] smpboot: CPU 2 is now offline
> [122525.776925] smpboot: CPU 1 is now offline
> [122525.789636] ACPI: PM: Low-level resume complete
> [122525.789681] ACPI: EC: EC started
> [122525.789682] ACPI: PM: Restoring platform NVS memory
> [122525.791575] Enabling non-boot CPUs ...
> [122525.791599] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [122525.792343] CPU1 is up
> [122525.792357] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [122525.793143] CPU2 is up
> [122525.793158] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [122525.793876] CPU3 is up
> [122525.796731] ACPI: PM: Waking up from system sleep state S3
> [122525.827172] ACPI: EC: interrupt unblocked
> [122525.840341] ACPI: EC: event unblocked
> [122525.852803] nvme nvme0: 4/0/0 default/read/poll queues
> [122526.060851] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [122526.123912] OOM killer enabled.
> [122526.123916] Restarting tasks: Starting
> [122526.124234] usb 1-3: USB disconnect, device number 34
> [122526.126175] Restarting tasks: Done
> [122526.126207] random: crng reseeded on system resumption
> [122526.225412] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [122526.248858] usb 1-3: new full-speed USB device number 37 using xhci_hcd
> [122526.387813] PM: suspend exit
> [122526.391750] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [122526.391765] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [122526.397475] usb 1-4: USB disconnect, device number 35
> [122526.398712] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [122526.398719] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [122526.596837] usb 1-4: new full-speed USB device number 38 using xhci_hcd
> [122526.667420] rfkill: input handler enabled
> [122526.685405] rfkill: input handler disabled
> [122526.695154] Process accounting resumed
> [122526.746581] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [122526.746589] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [122526.746591] usb 1-4: Product: Touchscreen
> [122526.746593] usb 1-4: Manufacturer: ELAN
> [122526.757812] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [122526.760970] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0041/input/input314
> [122526.761097] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0041/input/input315
> [122526.761157] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0041/input/input316
> [122526.761285] hid-multitouch 0003:04F3:2234.0041: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [122526.761398] usb 1-5: USB disconnect, device number 36
> [122526.782531] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [122526.896790] usb 1-5: new high-speed USB device number 39 using xhci_hcd
> [122527.131985] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [122527.131993] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [122527.131995] usb 1-5: Product: Integrated_Webcam_HD
> [122527.131997] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [122527.140549] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [122527.297917] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [122626.724197] usbcore: deregistering interface driver btusb
> [122941.583439] PM: suspend entry (deep)
> [122941.589073] Filesystems sync: 0.005 seconds
> [122941.596504] Freezing user space processes
> [122941.598267] Freezing user space processes completed (elapsed 0.001 seconds)
> [122941.598272] OOM killer disabled.
> [122941.598273] Freezing remaining freezable tasks
> [122941.599726] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [122941.599774] printk: Suspending console(s) (use no_console_suspend to debug)
> [122942.126565] ACPI: EC: interrupt blocked
> [122942.147849] ACPI: PM: Preparing to enter system sleep state S3
> [122942.161086] ACPI: EC: event blocked
> [122942.161090] ACPI: EC: EC stopped
> [122942.161091] ACPI: PM: Saving platform NVS memory
> [122942.163979] Disabling non-boot CPUs ...
> [122942.165948] smpboot: CPU 3 is now offline
> [122942.171365] smpboot: CPU 2 is now offline
> [122942.176038] smpboot: CPU 1 is now offline
> [122942.186143] ACPI: PM: Low-level resume complete
> [122942.186188] ACPI: EC: EC started
> [122942.186189] ACPI: PM: Restoring platform NVS memory
> [122942.188102] Enabling non-boot CPUs ...
> [122942.188131] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [122942.188880] CPU1 is up
> [122942.188895] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [122942.189660] CPU2 is up
> [122942.189676] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [122942.190406] CPU3 is up
> [122942.193255] ACPI: PM: Waking up from system sleep state S3
> [122942.223976] ACPI: EC: interrupt unblocked
> [122942.239359] ACPI: EC: event unblocked
> [122942.249399] nvme nvme0: 4/0/0 default/read/poll queues
> [122942.356666] OOM killer enabled.
> [122942.356671] Restarting tasks: Starting
> [122942.356731] usb 1-3: USB disconnect, device number 37
> [122942.357673] Restarting tasks: Done
> [122942.357710] random: crng reseeded on system resumption
> [122942.458073] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [122942.478031] usb 1-3: new full-speed USB device number 40 using xhci_hcd
> [122942.615292] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [122942.615302] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [122942.617406] usb 1-4: USB disconnect, device number 38
> [122942.730864] PM: suspend exit
> [122942.794018] usb 1-4: new full-speed USB device number 41 using xhci_hcd
> [122942.936040] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [122942.936048] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [122942.936051] usb 1-4: Product: Touchscreen
> [122942.936053] usb 1-4: Manufacturer: ELAN
> [122942.945757] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0042/input/input319
> [122942.945892] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0042/input/input320
> [122942.946028] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0042/input/input321
> [122942.946164] hid-multitouch 0003:04F3:2234.0042: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [122942.946828] usb 1-5: USB disconnect, device number 39
> [122942.949191] Process accounting resumed
> [122943.069978] usb 1-5: new high-speed USB device number 42 using xhci_hcd
> [122943.278365] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [122943.278371] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [122943.278373] usb 1-5: Product: Integrated_Webcam_HD
> [122943.278374] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [122943.286071] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [122943.610879] usbcore: registered new interface driver btusb
> [122943.612226] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [122943.612235] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [122943.692541] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [122943.971429] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [122943.995665] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [123331.155951] PM: suspend entry (deep)
> [123331.171579] Filesystems sync: 0.015 seconds
> [123331.178359] Freezing user space processes
> [123331.180206] Freezing user space processes completed (elapsed 0.001 seconds)
> [123331.180210] OOM killer disabled.
> [123331.180211] Freezing remaining freezable tasks
> [123331.181667] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [123331.181717] printk: Suspending console(s) (use no_console_suspend to debug)
> [123331.736230] ACPI: EC: interrupt blocked
> [123331.759219] ACPI: PM: Preparing to enter system sleep state S3
> [123331.769271] ACPI: EC: event blocked
> [123331.769275] ACPI: EC: EC stopped
> [123331.769277] ACPI: PM: Saving platform NVS memory
> [123331.772423] Disabling non-boot CPUs ...
> [123331.775622] smpboot: CPU 3 is now offline
> [123331.778938] smpboot: CPU 2 is now offline
> [123331.782428] smpboot: CPU 1 is now offline
> [123331.788387] ACPI: PM: Low-level resume complete
> [123331.788432] ACPI: EC: EC started
> [123331.788432] ACPI: PM: Restoring platform NVS memory
> [123331.790344] Enabling non-boot CPUs ...
> [123331.790369] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [123331.791112] CPU1 is up
> [123331.791130] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [123331.791897] CPU2 is up
> [123331.791913] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [123331.792638] CPU3 is up
> [123331.795517] ACPI: PM: Waking up from system sleep state S3
> [123331.826260] ACPI: EC: interrupt unblocked
> [123331.883299] ACPI: EC: event unblocked
> [123331.895827] nvme nvme0: 4/0/0 default/read/poll queues
> [123332.005210] OOM killer enabled.
> [123332.005222] Restarting tasks: Starting
> [123332.006753] usb 1-3: USB disconnect, device number 40
> [123332.013328] Restarting tasks: Done
> [123332.013368] random: crng reseeded on system resumption
> [123332.133305] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
> [123332.133313] usb 1-3: new full-speed USB device number 43 using xhci_hcd
> [123332.270513] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [123332.270522] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [123332.296754] atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> [123332.398866] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [123332.398874] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [123332.399469] PM: suspend exit
> [123332.406485] usb 1-4: USB disconnect, device number 41
> [123332.660976] Process accounting resumed
> [123332.689274] usb 1-4: new full-speed USB device number 44 using xhci_hcd
> [123332.758075] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [123332.782983] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [123332.826969] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [123332.826975] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [123332.826983] usb 1-4: Product: Touchscreen
> [123332.826984] usb 1-4: Manufacturer: ELAN
> [123332.837792] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0043/input/input324
> [123332.837983] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0043/input/input325
> [123332.838078] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0043/input/input326
> [123332.838284] hid-multitouch 0003:04F3:2234.0043: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [123332.838457] usb 1-5: USB disconnect, device number 42
> [123332.957263] usb 1-5: new high-speed USB device number 45 using xhci_hcd
> [123333.153783] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [123333.153792] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [123333.153795] usb 1-5: Product: Integrated_Webcam_HD
> [123333.153797] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [123333.162217] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [123333.295762] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [123346.130324] wlp58s0: authenticate with 9c:c8:fc:3d:47:9f (local address=9c:b6:d0:d1:6a:b1)
> [123346.130339] wlp58s0: send auth to 9c:c8:fc:3d:47:9f (try 1/3)
> [123346.134096] wlp58s0: authenticated
> [123346.136289] wlp58s0: associate with 9c:c8:fc:3d:47:9f (try 1/3)
> [123346.159050] wlp58s0: RX AssocResp from 9c:c8:fc:3d:47:9f (capab=0x1011 status=0 aid=1)
> [123346.162168] wlp58s0: associated
> [123346.299511] wlp58s0: Limiting TX power to 30 (30 - 0) dBm as advertised by 9c:c8:fc:3d:47:9f
> [124355.153497] intel_pmc_core: Invalid LTR scale factor.
> [124357.433410] intel_pmc_core: Invalid LTR scale factor.


