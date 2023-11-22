Return-Path: <linux-pm+bounces-61-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537517F402D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 09:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E19128113E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB6C153;
	Wed, 22 Nov 2023 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxZee9y8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3F3D969
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 08:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E9DBC433C9
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 08:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700642049;
	bh=khtkkxyvTBlOe7hqdOjFGqV5PmSpuCZ0eJS6SDtuD8g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LxZee9y8kBq45ICiJ9H4gwQoBUrg0s9Z9X5dEexegb0abdyUx16K2xRVKgdhpLfDO
	 E0+RQ5rLDKmWR+/HlaT6ZaIOYZfFY4/AvZaXS1pLKLdNjI54Fh7p6DFt3HC3TbDpGR
	 vKVa7o43dHGSLs/MVxb/o5uMkR3bnSEJF4Gh4AcrpofjQXpmQKBI4pVfMB0NRMVzSj
	 vakPsFneh9jrlUUfaiAjrvPRt+OBWzfSIb/GBBRC8EFgBOkhLHJYR3rpK1cbZtW2GO
	 1fEGXXOsbw2SvsHthPL5cYgg918KCLMP/JO3hxMB02LCwqDvzGc593IRzaznOlmKIf
	 wJlnjzDQFU8qg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F14C8C53BCD; Wed, 22 Nov 2023 08:34:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 22 Nov 2023 08:34:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-w9tdKWuvSc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #5 from Gino Badouri (badouri.g@gmail.com) ---
Hi Perry,

Thanks for looking into this.
I've updated to 6.7 rc2.

# uname -a
Linux pve 6.7.0-060700rc2-generic #202311192332 SMP PREEMPT_DYNAMIC Sun Nov=
 19
23:40:20 UTC 2023 x86_64 GNU/Linux

# cat /proc/cmdline=20
BOOT_IMAGE=3D/boot/vmlinuz-6.7.0-060700rc2-generic root=3D/dev/mapper/pve-r=
oot ro
quiet iommu=3Dpt amd_iommu=3Don kvm_amd.npt=3D1 kvm_amd.avic=3D1 nmi_watchd=
og=3D0
video=3Dvesafb:off video=3Defifb:off video=3Dsimplefb:off nomodeset
initcall_blacklist=3Dsysfb_init modprobe.blacklist=3Dnouveau
modprobe.blacklist=3Damdgpu modprobe.blacklist=3Dradeon modprobe.blacklist=
=3Dnvidia
hugepagesz=3D1G default_hugepagesz=3D2M amd_pstate=3Dactive

# lscpu
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         43 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  48
  On-line CPU(s) list:   0-47
Vendor ID:               AuthenticAMD
  BIOS Vendor ID:        Advanced Micro Devices, Inc.
  Model name:            AMD Ryzen Threadripper 3960X 24-Core Processor
    BIOS Model name:     AMD Ryzen Threadripper 3960X 24-Core Processor=20
Unknown
                          CPU @ 3.8GHz
    BIOS CPU family:     107
    CPU family:          23
    Model:               49
    Thread(s) per core:  2
    Core(s) per socket:  24
    Socket(s):           1
    Stepping:            0
    Frequency boost:     enabled
    CPU(s) scaling MHz:  58%
    CPU max MHz:         3800.0000
    CPU min MHz:         2200.0000
    BogoMIPS:            7585.72
    Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge
mc
                         a cmov pat pse36 clflush mmx fxsr sse sse2 ht sysc=
all
n
                         x mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc
rep_go
                         od nopl nonstop_tsc cpuid extd_apicid aperfmperf r=
apl
p
                         ni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2
movbe
                          popcnt aes xsave avx f16c rdrand lahf_lm cmp_lega=
cy
sv
                         m extapic cr8_legacy abm sse4a misalignsse
3dnowprefetc
                         h osvw ibs skinit wdt tce topoext perfctr_core
perfctr_
                         nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3
hw_pstate
                          ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 sm=
ep
bm
                         i2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni
xsa
                         veopt xsavec xgetbv1 cqm_llc cqm_occup_llc
cqm_mbm_tota
                         l cqm_mbm_local clzero irperf xsaveerptr rdpru
wbnoinvd
                          amd_ppin arat npt lbrv svm_lock nrip_save tsc_sca=
le
vm
                         cb_clean flushbyasid decodeassists pausefilter
pfthresh
                         old avic v_vmsave_vmload vgif v_spec_ctrl umip rdp=
id
ov
                         erflow_recov succor smca sev sev_es
Virtualization features:=20
  Virtualization:        AMD-V
Caches (sum of all):=20=20=20=20=20
  L1d:                   768 KiB (24 instances)
  L1i:                   768 KiB (24 instances)
  L2:                    12 MiB (24 instances)
  L3:                    128 MiB (8 instances)
NUMA:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  NUMA node(s):          1
  NUMA node0 CPU(s):     0-47
Vulnerabilities:=20=20=20=20=20=20=20=20=20
  Gather data sampling:  Not affected
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Mmio stale data:       Not affected
  Retbleed:              Mitigation; untrained return thunk; SMT enabled wi=
th
ST
                         IBP protection
  Spec rstack overflow:  Mitigation; Safe RET
  Spec store bypass:     Mitigation; Speculative Store Bypass disabled via
prctl
  Spectre v1:            Mitigation; usercopy/swapgs barriers and __user
pointer
                          sanitization
  Spectre v2:            Mitigation; Retpolines, IBPB conditional, STIBP
always-
                         on, RSB filling, PBRSB-eIBRS Not affected
  Srbds:                 Not affected
  Tsx async abort:       Not affected


Unfortunately the driver is still printing:
[    0.640246] amd_pstate: the _CPC object is not present in SBIOS or ACPI
disabled

If it helps, I've uploaded the acpi tables in both dat and dsl format here:
https://mega.nz/file/apkElTBL#JEmN0vmBSh7d-hbDiN-V0lwG7mwZQfitqnv4iVk0ACU

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

