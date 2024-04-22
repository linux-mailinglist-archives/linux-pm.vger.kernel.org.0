Return-Path: <linux-pm+bounces-6755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F58AC47A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 08:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66761F218FB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F1C481B3;
	Mon, 22 Apr 2024 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvsWzToM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE8481A4
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768631; cv=none; b=pW9BGg6/xG85R0uO3xRIDCpfScU5WypcDbd74qsni+1lhZPJG1UqLBt8sMQLuvDwRc1LdxRX37p5uxAVcqZDa7nYcwDy+QTnkXkgJCScZiWA772CdcUgByBc3F16hjThiuzl1842APdbWimgqSBTKcqLi/15ffu2HQJ8JWdzFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768631; c=relaxed/simple;
	bh=Wbt+R5bI/31p0uswGhK8+kokJ8Gbgb6pp+e3ogrGBbY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ay9aasrM6/RpDWq74Pkqf+iFa8iN0b8BfPmqXElN5Jl1S6sDwkVZZ+1PhvDHb3+K4T0hwpLhneDTLm63esvErKUdgE58YUehA22sv76W/iP1Td392Hno+IygkBV5+2ZuCtLDVSS4sQqYf6Fy+doPayTK3uLrnKXqVmTELjk4Ct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvsWzToM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0A92C116B1
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 06:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713768630;
	bh=Wbt+R5bI/31p0uswGhK8+kokJ8Gbgb6pp+e3ogrGBbY=;
	h=From:To:Subject:Date:From;
	b=BvsWzToMAGVflF3cOUStNQokSk5g4Rvk92z7JcG8aB60ejcG0rhvQKndvF+p/ToEu
	 DpCILodDUukeFe/rs2Ok3c5FfqEl1C51cAsNHyuxF+WFnW/SkQWCBVBGQDL3FlGLli
	 ISZmITC2D2F7bqwckdrgnlSeKMaFJiNLuEt86onxQMl/KQ8nk05+t/rYKsglE15pbt
	 2q9+7z7Ycq/KGy4JP5oNOC+8Hcspy829F2djBfBksdW3l2+HhJKU1c9wrO4+2UkfNS
	 t3Xrg6+dEWUwgJiQ0kE2VH3XHjcm3dJe9whQQ+pBMsEaaT0aGuLIu9pUSFdgv7RCx7
	 JfVcM0YJ94Iiw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D06E7C433E2; Mon, 22 Apr 2024 06:50:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] New: 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Mon, 22 Apr 2024 06:50:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

            Bug ID: 218759
           Summary: 6.9-rc kernels - with Ryzen 7840HS CPU single core
                    never boosts to max frequency
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: gahabana@gmail.com
        Regression: No

There is a change from 6.8 kernel to 6.9-rc which causes AMD Ryzen 7840HS C=
PU
not to be able to boost single core CPU.
Geekbench single core score is approx 15% lower (2265 vs 2538). The problem
does not show with kernel 6.8 or 6.7.
It is irrelevant whether kernel command line has amd-pstate-epp driver load=
ed
as active or passive or guide.

Simple loading of single core with:
cat /dev/zero > /dev/null

Shows both in 'htop' as well as with 'turbostat' that in the case of kernel
4.9-rc5 (as well as previous rcX) that CPU boosts single core only to 4.35G=
Hz
where with previous kernels it goes as high as 5.1GHz.

Here are the outputs of lscpu, and turbopower while running 'cat /dev/zero >
/dev/null' 1st with 6.8 kernel (working ok) and than with 6.9-rc5 kernel wh=
ich
has a problem

Hint if it helps - lscpu already shows maximum frequency as 4350Mhz with 6.=
9-rc
kernels

-----=20=20
zh@muc:~$ uname -a
Linux muc 6.8.7-060807-generic #202404170934 SMP PREEMPT_DYNAMIC Wed Apr 17
09:46:48 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
zh@muc:~$ sudo lscpu
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          48 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   16
  On-line CPU(s) list:    0-15
Vendor ID:                AuthenticAMD
  BIOS Vendor ID:         Advanced Micro Devices, Inc.
  Model name:             AMD Ryzen 7 7840HS w/ Radeon 780M Graphics
    BIOS Model name:      AMD Ryzen 7 7840HS w/ Radeon 780M Graphics=20=20=
=20=20=20
Unknown CPU @ 3.8GHz
    BIOS CPU family:      107
    CPU family:           25
    Model:                116
    Thread(s) per core:   2
    Core(s) per socket:   8
    Socket(s):            1
    Stepping:             1
    Frequency boost:      enabled
    CPU(s) scaling MHz:   32%
    CPU max MHz:          6080.0000
    CPU min MHz:          400.0000
    BogoMIPS:             7586.12
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr =
pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =
pdp
                          e1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 n=
opl
nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 f=
ma
                          cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave =
avx
f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse=
 3d
                          nowprefetch osvw ibs skinit wdt tce topoext
perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate
ssbd mba p
                          erfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall
fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq rdseed=
 adx
sma
                          p avx512ifma clflushopt clwb avx512cd sha_ni avx5=
12bw
avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total=
 c
                          qm_mbm_local user_shstk avx512_bf16 clzero irperf
xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale
vmcb_cl
                          ean flushbyasid decodeassists pausefilter pfthres=
hold
v_vmsave_vmload vgif x2avic v_spec_ctrl vnmi avx512vbmi umip pku ospke avx5=
12
                          _vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bi=
talg
avx512_vpopcntdq rdpid overflow_recov succor smca flush_l1d
Virtualization features:
  Virtualization:         AMD-V
Caches (sum of all):
  L1d:                    256 KiB (8 instances)
  L1i:                    256 KiB (8 instances)
  L2:                     8 MiB (8 instances)
  L3:                     16 MiB (1 instance)
NUMA:
  NUMA node(s):           1
  NUMA node0 CPU(s):      0-15
Vulnerabilities:
  Gather data sampling:   Not affected
  Itlb multihit:          Not affected
  L1tf:                   Not affected
  Mds:                    Not affected
  Meltdown:               Not affected
  Mmio stale data:        Not affected
  Reg file data sampling: Not affected
  Retbleed:               Not affected
  Spec rstack overflow:   Vulnerable: Safe RET, no microcode
  Spec store bypass:      Mitigation; Speculative Store Bypass disabled via
prctl
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user
pointer sanitization
  Spectre v2:             Mitigation; Enhanced / Automatic IBRS; IBPB
conditional; STIBP always-on; RSB filling; PBRSB-eIBRS Not affected; BHI Not
affected
  Srbds:                  Not affected
  Tsx async abort:        Not affected

zh@muc:~/git/kernel/tools/power/x86/turbostat$ sudo ./turbostat
turbostat version 2024.04.08 - Len Brown <lenb@kernel.org>
Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.8.7-060807-generic
root=3DUUID=3Ddc0bb664-2e43-421d-bd28-96d0332f030c ro amd_pstate=3Dguided i=
ommu=3Dpt
quiet
CPUID(0): AuthenticAMD 0x10 CPUID levels
CPUID(1): family:model:stepping 0x19:74:1 (25:116:1) microcode 0x0
CPUID(0x80000000): max_extended_levels: 0x80000028
CPUID(1): SSE3 MONITOR - - - TSC MSR - HT -
CPUID(6): APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwind=
ow,
No-HWPepp, No-HWPpkg, No-EPB
CPUID(7): No-SGX No-Hybrid
cpu0: cpufreq driver: amd-pstate
cpu0: cpufreq governor: ondemand
cpufreq boost: 1
/dev/cpu_dma_latency: 2000000000 usec (default)
current_driver: acpi_idle
current_governor: menu
current_governor_ro: menu
cpu0: POLL: CPUIDLE CORE POLL IDLE
cpu0: C1: ACPI FFH MWAIT 0x0
cpu0: C2: ACPI IOPORT 0x414
cpu0: C3: ACPI IOPORT 0x415
RAPL: 234 sec. Joule Counter Range, at 280 Watts
cpu0: MSR_RAPL_PWR_UNIT: 0x000a1003 (0.125000 Watts, 0.000015 Joules, 0.000=
977
sec.)
Core    CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     POLL    C1=
=20=20=20=20=20
C2      C3      POLL%   C1%     C2%     C3%     CorWatt PkgWatt
-       -       481     10.30   4667    3798    1.83    51969   427     401=
6=20=20=20
12902   10122   0.01    0.31    5.88    83.78   19.52   28.87
0       0       986     22.42   4401    3793    1.37    11392   162     121=
4=20=20=20
2794    3079    0.09    1.87    14.58   61.81   3.64    28.82
0       8       44      1.33    3351    3793    0.44    1514    0       27=
=20=20=20=20=20
268     721     0.00    0.03    1.87    96.94
1       1       29      1.31    2190    3793    0.51    1802    0       2=
=20=20=20=20=20=20
204     1059    0.00    0.00    2.72    96.23   0.23
1       9       16      0.62    2531    3793    0.58    478     0       26=
=20=20=20=20=20
107     157     0.00    0.02    0.78    98.62
2       2       1174    26.61   4413    3793    1.37    16684   235     254=
2=20=20=20
8383    302     0.12    2.76    65.77   5.07    4.96
2       10      225     4.93    4571    3793    1.06    2451    0       47=
=20=20=20=20=20
394     1020    0.00    0.06    2.21    93.01
3       3       15      0.67    2264    3793    0.45    845     0       13=
=20=20=20=20=20
100     402     0.00    0.04    0.80    98.59   0.18
3       11      15      0.67    2302    3793    0.57    542     0       3=
=20=20=20=20=20=20
60      277     0.00    0.00    0.83    98.56
4       4       14      0.55    2464    3793    0.47    861     2       13=
=20=20=20=20=20
328     286     0.00    0.01    1.74    97.76   0.24
4       12      39      1.43    2736    3793    0.69    871     0       3=
=20=20=20=20=20=20
65      433     0.00    0.00    0.66    98.01
5       5       2203    44.20   4984    3793    2.12    4691    25      1=
=20=20=20=20=20=20
24      367     0.02    0.00    0.20    55.63   9.82
5       13      2825    56.38   5011    3793    2.13    7846    3       99=
=20=20=20=20=20
27      1064    0.00    0.05    0.40    43.21
6       6       17      0.60    2796    3793    0.70    517     0       1=
=20=20=20=20=20=20
31      264     0.00    0.00    0.30    99.16   0.15
6       14      10      0.44    2263    3793    0.44    440     0       0=
=20=20=20=20=20=20
38      223     0.00    0.00    0.45    99.16
7       7       59      2.42    2453    3793    1.11    862     0       25=
=20=20=20=20=20
78      383     0.00    0.07    0.55    97.05   0.26
7       15      3       0.12    2161    3793    0.62    173     0       0=
=20=20=20=20=20=20
1       85      0.00    0.00    0.01    99.88

---------------------

zh@muc:~$ uname -a
Linux muc 6.9.0-rc5-zh-250HZ #3 SMP PREEMPT_DYNAMIC Sun Apr 21 22:11:26 CEST
2024 x86_64 x86_64 x86_64 GNU/Linux
zh@muc:~$ sudo lscpu
[sudo] password for zh:
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          48 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   16
  On-line CPU(s) list:    0-15
Vendor ID:                AuthenticAMD
  BIOS Vendor ID:         Advanced Micro Devices, Inc.
  Model name:             AMD Ryzen 7 7840HS w/ Radeon 780M Graphics
    BIOS Model name:      AMD Ryzen 7 7840HS w/ Radeon 780M Graphics=20=20=
=20=20=20
Unknown CPU @ 3.8GHz
    BIOS CPU family:      107
    CPU family:           25
    Model:                116
    Thread(s) per core:   2
    Core(s) per socket:   8
    Socket(s):            1
    Stepping:             1
    Frequency boost:      enabled
    CPU(s) scaling MHz:   22%
    CPU max MHz:          4350.0000
    CPU min MHz:          400.0000
    BogoMIPS:             7586.23
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr =
pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =
pdp
                          e1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 n=
opl
xtopology nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monit=
or
                          ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe popcnt =
aes
xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a m=
isa
                          lignsse 3dnowprefetch osvw ibs skinit wdt tce top=
oext
perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate
                          ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced
vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq
rdse
                          ed adx smap avx512ifma clflushopt clwb avx512cd
sha_ni avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_l=
lc
cqm_m
                          bm_total cqm_mbm_local user_shstk avx512_bf16 clz=
ero
irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc_=
sca
                          le vmcb_clean flushbyasid decodeassists pausefilt=
er
pfthreshold v_vmsave_vmload vgif x2avic v_spec_ctrl vnmi avx512vbmi umip pk=
u os
                          pke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni
avx512_bitalg avx512_vpopcntdq rdpid overflow_recov succor smca flush_l1d
amd_lbr
                          _pmc_freeze
Virtualization features:
  Virtualization:         AMD-V
Caches (sum of all):
  L1d:                    256 KiB (8 instances)
  L1i:                    256 KiB (8 instances)
  L2:                     8 MiB (8 instances)
  L3:                     16 MiB (1 instance)
NUMA:
  NUMA node(s):           1
  NUMA node0 CPU(s):      0-15
Vulnerabilities:
  Gather data sampling:   Not affected
  Itlb multihit:          Not affected
  L1tf:                   Not affected
  Mds:                    Not affected
  Meltdown:               Not affected
  Mmio stale data:        Not affected
  Reg file data sampling: Not affected
  Retbleed:               Not affected
  Spec rstack overflow:   Vulnerable: No microcode
  Spec store bypass:      Mitigation; Speculative Store Bypass disabled via
prctl
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user
pointer sanitization
  Spectre v2:             Mitigation; Enhanced / Automatic IBRS; IBPB
conditional; STIBP always-on; RSB filling; PBRSB-eIBRS Not affected; BHI Not
affected
  Srbds:                  Not affected
  Tsx async abort:        Not affected
zh@muc:~/git/kernel/tools/power/x86/turbostat$ sudo ./turbostat
turbostat version 2024.04.08 - Len Brown <lenb@kernel.org>
Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.9.0-rc5-zh-250HZ
root=3DUUID=3Ddc0bb664-2e43-421d-bd28-96d0332f030c ro amd_pstate=3Dguided i=
ommu=3Dpt
quiet
CPUID(0): AuthenticAMD 0x10 CPUID levels
CPUID(1): family:model:stepping 0x19:74:1 (25:116:1) microcode 0x0
CPUID(0x80000000): max_extended_levels: 0x80000028
CPUID(1): SSE3 MONITOR - - - TSC MSR - HT -
CPUID(6): APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwind=
ow,
No-HWPepp, No-HWPpkg, No-EPB
CPUID(7): No-SGX No-Hybrid
cpu0: cpufreq driver: amd-pstate
cpu0: cpufreq governor: ondemand
cpufreq boost: 1
/dev/cpu_dma_latency: 2000000000 usec (default)
current_driver: acpi_idle
current_governor: menu
current_governor_ro: menu
cpu0: POLL: CPUIDLE CORE POLL IDLE
cpu0: C1: ACPI FFH MWAIT 0x0
cpu0: C2: ACPI IOPORT 0x414
cpu0: C3: ACPI IOPORT 0x415
RAPL: 234 sec. Joule Counter Range, at 280 Watts
cpu0: MSR_RAPL_PWR_UNIT: 0x000a1003 (0.125000 Watts, 0.000015 Joules, 0.000=
977
sec.)
Core    CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     POLL    C1=
=20=20=20=20=20
C2      C3      POLL%   C1%     C2%     C3%     CorWatt PkgWatt
-       -       292     7.30    4005    3802    2.43    23723   44      656=
=20=20=20=20
6574    9594    0.00    0.18    4.10    88.76   4.39    11.77
0       0       52      2.57    2029    3793    0.65    3004    27      175=
=20=20=20=20
364     1643    0.00    0.51    3.27    94.01   0.11    11.73
0       8       15      0.75    1991    3793    0.60    946     1       11=
=20=20=20=20=20
212     398     0.00    0.13    1.33    97.89
1       1       37      1.79    2084    3793    1.17    1309    1       26=
=20=20=20=20=20
194     712     0.00    0.25    1.71    96.40   0.60
1       9       645     15.13   4260    3793    2.54    528     0       0=
=20=20=20=20=20=20
7       140     0.00    0.00    0.04    84.85
2       2       91      3.86    2361    3793    1.02    8182    14      122=
=20=20=20=20
4979    2346    0.00    0.18    51.79   44.75   0.37
2       10      13      0.53    2410    3793    0.71    1132    0       21=
=20=20=20=20=20
98      688     0.00    0.14    0.85    98.58
3       3       2243    52.14   4302    3793    2.55    1798    0       30=
=20=20=20=20=20
165     266     0.00    0.56    1.14    46.21   3.02
3       11      1432    33.34   4294    3793    2.56    853     0       8=
=20=20=20=20=20=20
24      85      0.00    0.10    0.22    66.35
4       4       21      0.98    2191    3793    0.82    820     0       4=
=20=20=20=20=20=20
66      478     0.00    0.04    0.47    98.61   0.07
4       12      14      0.78    1861    3793    0.88    568     0       8=
=20=20=20=20=20=20
52      320     0.00    0.00    0.49    98.80
5       5       9       0.47    1932    3793    0.87    416     0       6=
=20=20=20=20=20=20
34      235     0.00    0.03    0.36    99.17   0.04
5       13      7       0.30    2314    3793    0.67    221     0       10=
=20=20=20=20=20
19      125     0.00    0.03    0.16    99.23
6       6       33      1.62    2024    3793    1.02    1539    0       169=
=20=20=20=20
175     796     0.00    0.27    1.92    96.35   0.11
6       14      27      1.40    1896    3793    0.62    1318    1       26=
=20=20=20=20=20
95      764     0.00    0.15    0.81    97.76
7       7       14      0.61    2250    3793    0.72    653     0       25=
=20=20=20=20=20
55      357     0.00    0.35    0.53    98.58   0.05
7       15      10      0.45    2146    3793    0.71    436     0       15=
=20=20=20=20=20
35      241     0.00    0.15    0.23    99.21

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

