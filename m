Return-Path: <linux-pm+bounces-6263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC9A8A0BC1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1832833F4
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9D8143C74;
	Thu, 11 Apr 2024 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIAzRmZC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99004143C72
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826120; cv=none; b=YDqGTDzbGbXHkXiDpkghlAYzpDeSwBE//pmNfsBNzqXtGazRN7l0PtV44FvkT3lvgSkR5x9x7K1d8fVJ2/RnGe+ZyzMpzE2Z5wemBuNV1X4XLbpiA2J9RHD5hvJzyD7NLelUQSEmewRSs/5IByUStZfEpocG4SEDJ1RTII85kKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826120; c=relaxed/simple;
	bh=z85phIcjIUSo9rzbDDtJPEVs60P5iRLDH807+BsZqYY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SuRMxzuLa7zGwm02Dyv4buZOcyDYZnO+fJHPwE3SZ0AYlvwoVwu/Bs1XyXxPYPtp8r4Ay1/82DZTykaNc9EtCNvMSfdgtxnj/MY8Vs4Wlzt2LWEo+l3MMljcLpMa7lmbmvlfqSh+hVVOElgio6VKedITgdsjdHAQuVDBx1qEEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIAzRmZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64129C43330
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 09:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712826120;
	bh=z85phIcjIUSo9rzbDDtJPEVs60P5iRLDH807+BsZqYY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RIAzRmZCt4/Clkfvesnp1zX2JlvhXRq+HA18zC5Z191cr02Nh3sV5AxV7BGlKZM7X
	 KqSRJL47TTBHTgy2F+VznOf3oPkWgQK08CkC2QERGL6gTgHYYOlAA6PYXCD6ZpTbSP
	 xx3kcC9XQUTOhFxDkOcWbHn0xoVcZyXx2rPw3N27d8h1rMHhBypO0TuWN8P0JS7u78
	 +soV2cNJs+VJ51+amIWTwW/9/moxiL78LEuU4OhT7okQyZETNQaRl72X8EWmtvT+zF
	 MdF9Gsdsa0s7R1YHHUYWO2Rg4EgPl4PtrYMvts5XPRUDkLReqksw7Z79m3xplkYG2k
	 n3j9GowZtE5+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 50271C53BD9; Thu, 11 Apr 2024 09:02:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 09:02:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xiaojian.du@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-dy2vzGy8f4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #31 from xiaojian.du@amd.com ---
(In reply to al0uette from comment #30)
> (In reply to xiaojian.du from comment #28)
> > confirmed from another Phoenix 7840HS platform:
> > CPPC flag is exposed by BIOS.
> > So, on your 8945H CPU platform, it is very possible that ASUS doesn't
> enable
> > the CPPC in the BIOS.
> > I see this BIOS is built at 02/15/2024
> > "DMI: ASUSTeK COMPUTER INC. ROG Zephyrus G14 GA403UV_GA403UV/GA403UV, B=
IOS
> > GA403UV.303 02/15/2024"
> >=20
> > ~$ cat /proc/cpuinfo | grep cppc
> > flags         : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov
> > pat
> > pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb
> rdtscp
> > lm constant_tsc rep_good amd_lbr_v2 nopl nonstop_tsc cpuid extd_apicid
> > aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2ap=
ic
> > movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic
> > cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce
> > topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp=
_l3
> > hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall
> fsgsbase
> > bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq rdseed adx =
smap
> > avx512ifma clflushopt clwb avx512cd sha_ni avx512bw avx512vl xsaveopt
> xsavec
> > xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
> avx512_bf16
> > clzero irperf xsaveerptr rdpru wbnoinvd **cppc** arat npt lbrv svm_lock
> > nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
> > pfthreshold v_vmsave_vmload vgif x2avic v_spec_ctrl vnmi avx512vbmi umip
> pku
> > ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg
> > avx512_vpopcntdq rdpid overflow_recov succor smca fsrm flush_l1d
> >=20
> >=20
> > BTW, suppose you're using a test kernel 6.9-rc built by yourslef,, need=
 to
> > check kernel building config file to enable msr support:
> > make menucofnig  -> Processor type and features -> <M>/dev/cpu/*/msr -
> > Model-specific register support, change <M> to <*>
>=20
> I've also confirmed this on prebuilt stable kernel from my distribution, =
so
> it's not my config's problem.
>=20
> But why CPPC works on Windows? Can we add something like a quirk to make
> CPPC work on Linux for these machines?

From my own platform, renoir APU, amd ryzen 4750g + a520 mainboard,
I check hwinfo64 when enabled/disabled CPPC, hwinfo shows diff info.
(BIOS pah: AMD CBS->NBIO->SMU COMMON->CPPC auto/enable/disable)

From you pic, it shows only "one line" info of CPPC, it matches with mine w=
hen
disbaled CPPC in BIOS.

When enabled CPPC in BIOS, hwinfo shows "two lines" of CPPC info.
=E6=A0=B8=E5=BF=83=E6=80=A7=E8=83=BD=E9=A1=BA=E5=BA=8F=EF=BC=9A           8=
, 5, 1, 7, 3, 4, 2, 6
=E6=A0=B8=E5=BF=83=E6=80=A7=E8=83=BD=E9=A1=BA=E5=BA=8F=EF=BC=88CPPC=EF=BC=
=89=EF=BC=9A    1, 2, 3, 4, 5, 6, 7, 8

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

