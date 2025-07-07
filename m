Return-Path: <linux-pm+bounces-30310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA0AFBBF2
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 21:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E983AD6C7
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA242E3716;
	Mon,  7 Jul 2025 19:54:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01939266B64
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918047; cv=none; b=L31v/ILc1RfSuZMWKyRofkugMmd8s4MzAVm9MILw5MnfiWl081l3JS4Rb6i1Lc6sVZhvpsSrw22Hb4rWq1jQo9nFJlErsVNDWd90oaRGzO4PLf1PnNIaY62O7yvpr7L0TUHjsWGfDc8flQUYPCYqtgcXf+DvsFeNxy02jPLXdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918047; c=relaxed/simple;
	bh=jYtgkC/6O8jRVm7aTW+OzpDkpXe0RzCCsKfnhLnFtlg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ogk/PdMi42Eb7a6+hho+8qqsspbXdmXG7P9krIqVEX5AfXCuQPgHbrxhlZbmIloiyNbV/c/91q+OSILB0uK+Vo8mpOYdLwJ/yjdeFamWHSNQaSAl07oqkWcl2xTZvNc3pEybcZF/oa3PHnSFztpxO4OGi1LfEw0JV9fF6H62etc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Mon, 07 Jul 2025 19:53:49 +0000
To: "Zhang, Rui" <rui.zhang@intel.com>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <0vAkn5EMnW3T5oXUyvg_ha8ZRUpyO6BzCeRK7y-Xmaijwdaysuct0YFUZ5ECTqFrvXwJeW1WjdkbSRdJUbC-2Xq0-cBmoviHxyjZRxiTcJc=@benis.se>
In-Reply-To: <fad3442f78f82154f507cf485057c6688659e4a5.camel@intel.com>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de> <3b25e59bc1b162ee8f43ffbd3c50589a52d540af.camel@intel.com> <rFJU7KbF6iq0CxJtSjPu4vLVjWata5hY1Kl-wOv253p0C2W7egJQQrkUnkSqmr1vXDXeTwwtwp0u5ZnQU6pZmPuJ7TnNBVgudMG-q5MRHyM=@benis.se> <ee9a2111eab5a8bc95fb406d8bfed12bcc5616b9.camel@intel.com> <w1oZ3TmKGo5jIZitOAFijvrms0dIML16dkDbNsXKgfWVrmwZO8tiSajRChU8GDgN-VELm13UZekXJl2I4L0iXfT9v0xjlJaJLmdypJ5Tc9Q=@benis.se> <fad3442f78f82154f507cf485057c6688659e4a5.camel@intel.com>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: 4e6510e8323bc570ac36ab36ea7cedbb450059b9
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





Best regards,
Benjamin Hasselgren-Hall=C3=A9n


On Wednesday, 2 July 2025 at 03:14, Zhang, Rui <rui.zhang@intel.com> wrote:

> On Tue, 2025-07-01 at 07:04 +0000, Benjamin Hasselgren-Hall=C3=A9n wrote:
>=20
> > Best regards,
> > Benjamin Hasselgren-Hall=C3=A9n
> >=20
> > On Tuesday, 1 July 2025 at 08:55, Zhang, Rui rui.zhang@intel.com
> > wrote:
> >=20
> > > On Mon, 2025-06-30 at 12:48 +0000, Benjamin Hasselgren-Hall=C3=A9n wr=
ote:
> > >=20
> > > > Best regards,
> > > > Benjamin Hasselgren-Hall=C3=A9n
> > > >=20
> > > > On Monday, 30 June 2025 at 03:18, Zhang, Rui rui.zhang@intel.com
> > > > wrote:
> > > >=20
> > > > > > > So I tested thermald again. So here are some results.
> > > > > > >=20
> > > > > > > Before:
> > > > > > > Running Valheim the power draw is 35w and the fps is 41.
> > > > > > >=20
> > > > > > > After I have installed thermald:
> > > > > > > Running Valheim the power draw is 44w and the fps is 46
> > > > > > >=20
> > > > > > > So it's working,
> > > > >=20
> > > > > Good to know that thermald helps.
> > > > >=20
> > > > > can you please also attach the turbostat output? say "turbostat -
> > > > > o
> > > > > ts.log
> > > > > sleep 1"
> > > >=20
> > > > https://drive.benis.se/s/KtRtCQXi7mS8GMi
> > > > There you go. I am compiling the linux kernel atm so the laptop is
> > > > working very hard (I am thinking of logging).
> > >=20
> > > is this done with or without thermald activated?
> >=20
> > Thermald is active.
> >=20
> > > I see the TDP is 17W, not sure if it has already been set by thermald
> > > or
> > > not.
> >=20
> > I can do a test with a different load if that matters?
> >=20
> > > can you also paste the lscpu output?
> >=20
> > Architecture: x86_64
> > CPU op-mode(s): 32-bit, 64-bit
> > Address sizes: 42 bits physical, 48 bits virtual
> > Byte Order: Little Endian
> > CPU(s): 8
> > On-line CPU(s) list: 0-7
> > Vendor ID: GenuineIntel
> > Model name: Intel(R) Core(TM) Ultra 7 258V
>=20
>=20
> https://www.intel.com/content/www/us/en/products/sku/240957/intel-core-ul=
tra-7-processor-258v-12m-cache-up-to-4-80-ghz/specifications.html
> so the TDP is indeed 17W.
>=20
> And the turbostat output you attached shows that the processors are
> running at around 17W, so the processor power is not capped in your
> previous test (with thermald activated).
>=20
> I suspect that the firmware caps the power via MMIO RAPL, and thermald
> fixes that.
> can you please do the following test
> 1. do a fresh boot
> 2. run "grep . /sys/class/powercap// > powercap-thermald-off.log"
>=20
> 3. run "sudo turbostat -o ts-thermald-off.log stress -c 8 -t 10"
> 4. activate thermald
> 5. run "sudo turbostat -o ts-thermald-on.log stress -c 8 -t 10"
> 6. run "grep . /sys/class/powercap// > powercap-thermald-on.log"
>=20
> 7. attach the four log files

Logs
https://drive.benis.se/s/o75BQ9WfPEWNcrn
https://drive.benis.se/s/pFBLr7NDLJkyr83
https://drive.benis.se/s/E3e8mEbLsrmmoHJ
https://drive.benis.se/s/qSYAJtLEwkSAzQT

I have noticed that if I only run CPU or GPU - the performance is good. So =
when running Valheim (game) that do not require any cpu - the performance i=
s on par with Windows, but when benchmarking Company of Heroes 3 or Cyberpu=
nk 2077, the performance is like 50% of Windows (I might have state this be=
fore). I can also see how the fps are dropping very fast after starting the=
 game. I do not see the gpu mhz in MangoHud and when I try intel_gpu_top I =
get:
sudo intel_gpu_top
No device filter specified and no discrete/integrated i915 devices found
It's not supported?

//Benjamin


>=20
> thanks,
> rui
>=20
> > CPU family: 6
> > Model: 189
> > Thread(s) per core: 1
> > Core(s) per socket: 8
> > Socket(s): 1
> > Stepping: 1
> > CPU(s) scaling MHz: 12%
> > CPU max MHz: 4800.0000
> > CPU min MHz: 400.0000
> > BogoMIPS: 6604.80
> > Flags: fpu vme de pse tsc msr pae mce cx8 apic
> > sep mtrr pg
> > e mca cmov pat pse36 clflush dts acpi mmx
> > fxsr sse
> > sse2 ss ht tm pbe syscall nx pdpe1gb
> > rdtscp lm cons
> > tant_tsc art arch_perfmon pebs bts
> > rep_good nopl xt
> > opology nonstop_tsc cpuid aperfmperf
> > tsc_known_freq
> > pni pclmulqdq dtes64 monitor ds_cpl vmx
> > smx est tm
> > 2 ssse3 sdbg fma cx16 xtpr pdcm pcid
> > sse4_1 sse4_2
> > x2apic movbe popcnt tsc_deadline_timer aes
> > xsave av
> > x f16c rdrand lahf_lm abm 3dnowprefetch
> > cpuid_fault
> > epb ssbd ibrs ibpb stibp ibrs_enhanced
> > tpr_shadow
> > flexpriority ept vpid ept_ad fsgsbase
> > tsc_adjust bm
> > i1 avx2 smep bmi2 erms invpcid rdt_a
> > rdseed adx sma
> > p clflushopt clwb intel_pt sha_ni xsaveopt
> > xsavec x
> > getbv1 xsaves split_lock_detect user_shstk
> > avx_vnni
> > lam wbnoinvd dtherm ida arat pln pts hwp
> > hwp_notif
> > y hwp_act_window hwp_epp hwp_pkg_req hfi
> > vnmi umip
> > pku ospke waitpkg gfni vaes vpclmulqdq
> > rdpid bus_lo
> > ck_detect movdiri movdir64b fsrm md_clear
> > serialize
> > pconfig arch_lbr ibt flush_l1d
> > arch_capabilities
> > Virtualization features:
> > Virtualization: VT-x
> > Caches (sum of all):
> > L1d: 320 KiB (8 instances)
> > L1i: 512 KiB (8 instances)
> > L2: 14 MiB (5 instances)
> > L3: 12 MiB (1 instance)
> > NUMA:
> > NUMA node(s): 1
> > NUMA node0 CPU(s): 0-7
> > Vulnerabilities:
> > Gather data sampling: Not affected
> > Ghostwrite: Not affected
> > Indirect target selection: Not affected
> > Itlb multihit: Not affected
> > L1tf: Not affected
> > Mds: Not affected
> > Meltdown: Not affected
> > Mmio stale data: Not affected
> > Reg file data sampling: Not affected
> > Retbleed: Not affected
> > Spec rstack overflow: Not affected
> > Spec store bypass: Mitigation; Speculative Store Bypass
> > disabled via p
> > rctl
> > Spectre v1: Mitigation; usercopy/swapgs barriers and
> > __user poi
> > nter sanitization
> > Spectre v2: Mitigation; Enhanced / Automatic IBRS;
> > IBPB conditi
> > onal; PBRSB-eIBRS Not affected; BHI
> > BHI_DIS_S
> > Srbds: Not affected
> > Tsx async abort: Not affected
> >=20
> > > thanks,
> > > rui

