Return-Path: <linux-pm+bounces-29874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C3BAEEF60
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 09:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2F2440180
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19866259CB6;
	Tue,  1 Jul 2025 07:04:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B52586EB
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353495; cv=none; b=Em1MplCiHrgu/btheNSZAPtvHlfrMqCqjCcWnVZA8E/csaGXOQGRubYIVuULPiy9txCAIbUBCjcRDdr0NKZ3B43522yAXvY++V4cfHKeRDUg+D6m3M8wfsQgqgjclJkRGCTOB52Z7MkxdGC0LsLD/jLuHey9uHofFJJBnOPepko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353495; c=relaxed/simple;
	bh=71oLnrBcUF9GypLRqilZXGtz49po4EnaJWiTgKZw4Ek=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSLLkZi5R02UwNCH7SHJidM/NvB6Zcc1taKkii712VaH+sofd+GkT/5S3dnMjTdmgNOgao9U3EDPyYXu2EF8aKzGfTFEy9XhdBg5TlgWnyI9us4Excdzqm7tEbSFjANlIqpBAYawELxoDSEY+bIuR6dOsyq3VqgI02Hp4rGS60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se; spf=pass smtp.mailfrom=benis.se; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benis.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benis.se
Date: Tue, 01 Jul 2025 07:04:43 +0000
To: "Zhang, Rui" <rui.zhang@intel.com>
From: =?utf-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Message-ID: <w1oZ3TmKGo5jIZitOAFijvrms0dIML16dkDbNsXKgfWVrmwZO8tiSajRChU8GDgN-VELm13UZekXJl2I4L0iXfT9v0xjlJaJLmdypJ5Tc9Q=@benis.se>
In-Reply-To: <ee9a2111eab5a8bc95fb406d8bfed12bcc5616b9.camel@intel.com>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se> <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de> <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se> <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de> <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se> <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de> <3b25e59bc1b162ee8f43ffbd3c50589a52d540af.camel@intel.com> <rFJU7KbF6iq0CxJtSjPu4vLVjWata5hY1Kl-wOv253p0C2W7egJQQrkUnkSqmr1vXDXeTwwtwp0u5ZnQU6pZmPuJ7TnNBVgudMG-q5MRHyM=@benis.se> <ee9a2111eab5a8bc95fb406d8bfed12bcc5616b9.camel@intel.com>
Feedback-ID: 18592338:user:proton
X-Pm-Message-ID: ff63203df2276ffe7178a9896337e2118e46b423
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


On Tuesday, 1 July 2025 at 08:55, Zhang, Rui <rui.zhang@intel.com> wrote:

> On Mon, 2025-06-30 at 12:48 +0000, Benjamin Hasselgren-Hall=C3=A9n wrote:
>=20
> > Best regards,
> > Benjamin Hasselgren-Hall=C3=A9n
> >=20
> > On Monday, 30 June 2025 at 03:18, Zhang, Rui rui.zhang@intel.com
> > wrote:
> >=20
> > > > > So I tested thermald again. So here are some results.
> > > > >=20
> > > > > Before:
> > > > > Running Valheim the power draw is 35w and the fps is 41.
> > > > >=20
> > > > > After I have installed thermald:
> > > > > Running Valheim the power draw is 44w and the fps is 46
> > > > >=20
> > > > > So it's working,
> > >=20
> > > Good to know that thermald helps.
> > >=20
> > > can you please also attach the turbostat output? say "turbostat -o
> > > ts.log
> > > sleep 1"
> >=20
> > https://drive.benis.se/s/KtRtCQXi7mS8GMi
> > There you go. I am compiling the linux kernel atm so the laptop is
> > working very hard (I am thinking of logging).
>=20
> is this done with or without thermald activated?

Thermald is active.=20

> I see the TDP is 17W, not sure if it has already been set by thermald or
> not.

I can do a test with a different load if that matters?

> can you also paste the lscpu output?

Architecture:                x86_64
  CPU op-mode(s):            32-bit, 64-bit
  Address sizes:             42 bits physical, 48 bits virtual
  Byte Order:                Little Endian
CPU(s):                      8
  On-line CPU(s) list:       0-7
Vendor ID:                   GenuineIntel
  Model name:                Intel(R) Core(TM) Ultra 7 258V
    CPU family:              6
    Model:                   189
    Thread(s) per core:      1
    Core(s) per socket:      8
    Socket(s):               1
    Stepping:                1
    CPU(s) scaling MHz:      12%
    CPU max MHz:             4800.0000
    CPU min MHz:             400.0000
    BogoMIPS:                6604.80
    Flags:                   fpu vme de pse tsc msr pae mce cx8 apic sep mt=
rr pg
                             e mca cmov pat pse36 clflush dts acpi mmx fxsr=
 sse=20
                             sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm=
 cons
                             tant_tsc art arch_perfmon pebs bts rep_good no=
pl xt
                             opology nonstop_tsc cpuid aperfmperf tsc_known=
_freq
                              pni pclmulqdq dtes64 monitor ds_cpl vmx smx e=
st tm
                             2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 ss=
e4_2=20
                             x2apic movbe popcnt tsc_deadline_timer aes xsa=
ve av
                             x f16c rdrand lahf_lm abm 3dnowprefetch cpuid_=
fault
                              epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_sh=
adow=20
                             flexpriority ept vpid ept_ad fsgsbase tsc_adju=
st bm
                             i1 avx2 smep bmi2 erms invpcid rdt_a rdseed ad=
x sma
                             p clflushopt clwb intel_pt sha_ni xsaveopt xsa=
vec x
                             getbv1 xsaves split_lock_detect user_shstk avx=
_vnni
                              lam wbnoinvd dtherm ida arat pln pts hwp hwp_=
notif
                             y hwp_act_window hwp_epp hwp_pkg_req hfi vnmi =
umip=20
                             pku ospke waitpkg gfni vaes vpclmulqdq rdpid b=
us_lo
                             ck_detect movdiri movdir64b fsrm md_clear seri=
alize
                              pconfig arch_lbr ibt flush_l1d arch_capabilit=
ies
Virtualization features:    =20
  Virtualization:            VT-x
Caches (sum of all):        =20
  L1d:                       320 KiB (8 instances)
  L1i:                       512 KiB (8 instances)
  L2:                        14 MiB (5 instances)
  L3:                        12 MiB (1 instance)
NUMA:                       =20
  NUMA node(s):              1
  NUMA node0 CPU(s):         0-7
Vulnerabilities:            =20
  Gather data sampling:      Not affected
  Ghostwrite:                Not affected
  Indirect target selection: Not affected
  Itlb multihit:             Not affected
  L1tf:                      Not affected
  Mds:                       Not affected
  Meltdown:                  Not affected
  Mmio stale data:           Not affected
  Reg file data sampling:    Not affected
  Retbleed:                  Not affected
  Spec rstack overflow:      Not affected
  Spec store bypass:         Mitigation; Speculative Store Bypass disabled =
via p
                             rctl
  Spectre v1:                Mitigation; usercopy/swapgs barriers and __use=
r poi
                             nter sanitization
  Spectre v2:                Mitigation; Enhanced / Automatic IBRS; IBPB co=
nditi
                             onal; PBRSB-eIBRS Not affected; BHI BHI_DIS_S
  Srbds:                     Not affected
  Tsx async abort:           Not affected


>=20
> thanks,
> rui

