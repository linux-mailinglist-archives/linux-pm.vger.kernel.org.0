Return-Path: <linux-pm+bounces-8489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6658D67C9
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 19:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410AF1F28743
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 17:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E29176ABA;
	Fri, 31 May 2024 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGoVJAgd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3963172793
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175375; cv=none; b=j3dKtBG+OxYA85TnBm/hmmS3hP+DO3N/h/HQUmKtWq96cHeLngd49Mlp6MuKSeaxftqFt9G2N6iVKxd3IRF02ZdMzu/iYMEprN08C5Y3cKygH4FW40R0fsy3Un6aM8TtCfF86Ri93G3Mc7VHLoMxvvVc36KhagvtgAR2snqTaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175375; c=relaxed/simple;
	bh=BBjWwhcxxwfjQkqMtMF2mCrCiqh85bYsYAJSBSwnh8o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HA6obZsLd+czdQY55sAdVgMEhR0jewtLQALYEhDEJkkQxIQPEIQOp0iR75sGjlQqJw+xWpRiFpVNnA8wdOaXjmJIhyR4gx6UNGn9MfEohWWEqA8n1PjnGU2HQGfgTk/B2UtcTVJi2ZedkWW4KvB018JTxlX7+UghO9y0oYtCxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGoVJAgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7059BC116B1
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717175374;
	bh=BBjWwhcxxwfjQkqMtMF2mCrCiqh85bYsYAJSBSwnh8o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RGoVJAgd90UfyYI1SvhrXT5WrxE+s7knlr1sLlPPmOJi68DHOjILI2lML78kTZu4T
	 qPVeq7VgJ7+WddbRwB7MNIg60CLQjBJadKjO6SyMpH/wRllGf45PnzY2NXI5NjhT7K
	 rzCJeO+1YjNxrjaX9NaYuurrPXDBccCuU+sM8gunldjfzBAQjXDZGVL5Ij+I3hX7UF
	 FG96MqZbRik6DFaCFplYBkTrhcJAfaq5w6d418UirFBT0dLGsULIc+kZ0sEBOzZ6o7
	 3503XQywLOISkLypl+tVIl0jAeJRMDwbubG48CqqkGfKhKZKDLZelsGcgPb1f7+PmO
	 ndv18+Vy2Bm7A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6867DC53B7E; Fri, 31 May 2024 17:09:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218919] My machine enter automaticaly in ondemand but my kernel
 config have default CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE enable by default
Date: Fri, 31 May 2024 17:09:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218919-137361-zs6eQPTRxp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218919-137361@https.bugzilla.kernel.org/>
References: <bug-218919-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218919

--- Comment #1 from sander44 (ionut_n2001@yahoo.com) ---
#  lscpu
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          39 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   16
  On-line CPU(s) list:    0-15
Vendor ID:                GenuineIntel
  BIOS Vendor ID:         Intel(R) Corporation
  Model name:             Intel(R) Core(TM) i9-9980HK CPU @ 2.40GHz
    BIOS Model name:      Intel(R) Core(TM) i9-9980HK CPU @ 2.40GHz To Be
Filled By O.E.M. CPU @ 2.3GHz
    BIOS CPU family:      207
    CPU family:           6
    Model:                158
    Thread(s) per core:   2
    Core(s) per socket:   8
    Socket(s):            1
    Stepping:             13
    Frequency boost:      enabled
    CPU(s) scaling MHz:   130%
    CPU max MHz:          2401.0000
    CPU min MHz:          800.0000
    BogoMIPS:             4806.40
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr =
pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall =
nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl =
vmx
est tm2 ss
                          se3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2=
apic
movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm
3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow
flexpriority ept vpid ept_ad fsgsbase tsc_adjust sgx bmi1 avx2 smep bmi2 er=
ms
invpcid mpx r
                          dseed adx smap clflushopt intel_pt xsaveopt xsavec
xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
vnmi sgx_lc md_clear flush_l1d arch_capabilities
Virtualization features:
  Virtualization:         VT-x
Caches (sum of all):
  L1d:                    256 KiB (8 instances)
  L1i:                    256 KiB (8 instances)
  L2:                     2 MiB (8 instances)
  L3:                     16 MiB (1 instance)
NUMA:
  NUMA node(s):           1
  NUMA node0 CPU(s):      0-15
Vulnerabilities:
  Gather data sampling:   Vulnerable
  Itlb multihit:          KVM: Vulnerable
  L1tf:                   Not affected
  Mds:                    Not affected
  Meltdown:               Not affected
  Mmio stale data:        Vulnerable
  Reg file data sampling: Not affected
  Retbleed:               Vulnerable
  Spec rstack overflow:   Not affected
  Spec store bypass:      Vulnerable
  Spectre v1:             Vulnerable: __user pointer sanitization and userc=
opy
barriers only; no swapgs barriers
  Spectre v2:             Vulnerable; IBPB: disabled; STIBP: disabled;
PBRSB-eIBRS: Vulnerable; BHI: Vulnerable
  Srbds:                  Vulnerable
  Tsx async abort:        Mitigation; TSX disabled


# cat /proc/cmdline
BOOT_IMAGE=3D/boot/vmlinuz-6.8.11-x64coreivybridge-pve-realtime1-rt11
root=3D/dev/mapper/pve-root ro apparmor=3D1 security=3Dapparmor art=3Dvirta=
llow
udmabuf.list_limit=3D8192 processor.max_cstate=3D0 intel.max_cstate=3D0
processor_idle.max_cstate=3D0 intel_idle.max_cstate=3D0 clocksource=3Dtsc
tsc=3Dreliable nowatchdog rcupdate.rcu_cpu_stall_suppress=3D1 irqaffinity=
=3D0
hpet=3Ddisable numa_balancing=3Ddisable igb.blacklist=3Dno efi=3Druntime hu=
gepages=3D1024
nmi_watchdog=3D0 i915.force_probe=3D* i915.enable_rc6=3D0 i915.enable_dc=3D0
i915.disable_power_well=3D0 isolcpus rcu_nocbs noht nohpet nosoftlockup
rcu_nocb_poll vt.handoff=3D7 i915.enable_guc=3D2 msr.allow_writes=3Don
cpuidle.governor=3Dmobile split_lock_detect=3Doff intel_pstate=3Ddisable qu=
iet
mitigations=3Doff threadirqs cpufreq.default_governor=3Dperformance skew_ti=
ck=3D1
rcu_nocb_poll rcu_nocbs=3D14 nohz=3Don nohz_full=3D14 kthread_cpus=3D14 irq=
affinity=3D14
isolcpus=3Dmanaged_irq,domain,14 nosoftlockup tsc=3Dnowatchdog acpi_irq_nob=
alance

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

