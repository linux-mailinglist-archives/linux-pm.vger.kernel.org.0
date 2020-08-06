Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE93C23D7A9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 09:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgHFHsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 03:48:38 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:45574
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726799AbgHFHsX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 03:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:message-id:to:
         from:date:from;
        bh=js6ddQGjshLYMBr3KACQwW7bxmSrcf7Ipr2yq9tUVhk=;
        b=uzGk3f8Tbi2quAtVymDGokS/XFp/J6pLvgesU/QRUoL3pUNkqqOnUkWOk0Pgrz8hSawLk++mo9c6a
         F0z4XI1VJ7oPrE1cXRaAtG4X4rulPVMp69Qznu9Q6HWo/RSz7F2YcpwTYx8SsawcyYXxI80Ds5ZYjv
         H5sV75m5mcf/+y92KswT4AlfMM0iYMxiW7blR5l3+AfJCKHWF8cg5NhPmSaByooUS4G5m+wabyRWkY
         sezxGh34hiC6tTOAUjyjyf32FwYqFUkmkGyNZWqM3QnEitaMOyYqS6LJXQhS/64wQO/fsdyHNJGltw
         NUCNSKuEYEsFSbMmKSXThadbSkVqEvw==
X-HalOne-Cookie: 35fd9665de40a721992ac6626549ec43b33e2414
X-HalOne-ID: 2306380e-d7b9-11ea-8889-d0431ea8a290
Received: from [192.168.0.126] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2306380e-d7b9-11ea-8889-d0431ea8a290;
        Thu, 06 Aug 2020 07:47:55 +0000 (UTC)
Date:   Thu, 6 Aug 2020 09:47:54 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     linux-pm@vger.kernel.org
Message-ID: <cd04b10.40bfc293.173c2bda013@lechevalier.se>
Subject: amd_energy supported cpus?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

According to https://www.kernel.org/doc/html/latest/hwmon/amd_energy.html f=
amily 17h CPUs should be supported. But are there exceptions from this, for=
 example the various APUs?

I'm running a AMD 3000G APU and Kernel 5.8 but the module doesn't load:

# modprobe amd_energy
modprobe: ERROR: could not insert 'amd_energy': No such device

There is no message in dmesg.

I couldn't understand the data sheets from the documentation, but are there=
 cpus within dam 17h (23) that are not supported?=20

This is my CPU (APU)=20
# lscpu=20

Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   43 bits physical, 48 bits virtual
CPU(s):                          4
On-line CPU(s) list:             0-3
Thread(s) per core:              2
Core(s) per socket:              2
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       AuthenticAMD
CPU family:                      23
Model:                           24
Model name:                      AMD Athlon 3000G with Radeon Vega Graphics
Stepping:                        1
Frequency boost:                 enabled
CPU MHz:                         2194.348
CPU max MHz:                     3900.0000
CPU min MHz:                     1600.0000
BogoMIPS:                        7785.52
Virtualization:                  AMD-V
L1d cache:                       64 KiB
L1i cache:                       128 KiB
L2 cache:                        1 MiB
L3 cache:                        4 MiB
NUMA node0 CPU(s):               0-3
Vulnerability Itlb multihit:     Not affected
Vulnerability L1tf:              Not affected
Vulnerability Mds:               Not affected
Vulnerability Meltdown:          Not affected
Vulnerability Spec store bypass: Vulnerable
Vulnerability Spectre v1:        Vulnerable: __user pointer sanitization an=
d usercopy barriers only; no swapgs barriers
Vulnerability Spectre v2:        Vulnerable, IBPB: disabled, STIBP: disable=
d
Vulnerability Srbds:             Not affected
Vulnerability Tsx async abort:   Not affected
Flags:                           fpu vme de pse tsc msr pae mce cx8 apic se=
p mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxex=
t fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid e=
xtd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 mo=
vbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_leg=
acy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr=
_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate sme ssbd sev ibpb v=
mmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsave=
opt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock n=
rip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthres=
hold avic v_vmsave_vmload vgif overflow_recov succor smca
