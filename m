Return-Path: <linux-pm+bounces-6262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A28A09A7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 09:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0024C1F24E8A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 07:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC9813DDD2;
	Thu, 11 Apr 2024 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU//yrpw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3113DBB1
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820318; cv=none; b=ezsxcvRc1UONXEKjT0P30oUWzusCp3fAiTjDVoFHgtPbwH/B2slMl8BH/xjRs2vq4lZzAA3UYt5KkdGNNt7OsbUOjn5iPWqkf/Ghp5i1bczeE7CkcxoxmoBhs1Hhx2v7nFh9qy3SPo9a8IOS8Vv++I6NjEDAYQdLRfrIbCtWnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820318; c=relaxed/simple;
	bh=4fZQm0ZlFRkzWRRHH6cmRWOQkMHosamx+oXT2RB2g/Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XAvUJ+EjPrrIbowT1cKHAw6gvZNNVSNg9/dV5Zid7YzbHZnRntWHPelA/qXpURRLDDCfrQuPF5KEZGYtmq2x1Wyt/cd0MrmpQiVxeevH2Gh0nHmo+wYy3przasVkM1MKYSj1LNEjPwbgtmKeoDWw8JAqEyBJPc/xZI5bAOKQNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU//yrpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE916C433C7
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 07:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712820317;
	bh=4fZQm0ZlFRkzWRRHH6cmRWOQkMHosamx+oXT2RB2g/Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZU//yrpwYYoswaZwp7OEZglyvZwhjfTlU2QUTUe2HuFodGF4mbpeNomjDMooJTIZ+
	 /UpQPnydRAkH7rUA5X3KMb6RrOtxcuhKeMtuwYivBOyuMkUUCx+cB9/JKW7HBHPqwB
	 rpWBKRajM9f26pV0GrAhnE+EzJdDba25u7UKBAlXbmj1XzazkBM25BqPZNaNRRVPFe
	 KhBA5TdzId7q/gSs8gbngEMfpUuUNENHa0EKGyctU7O+nR7FYW5knVgSbUobPbDsq8
	 fPSb39Nr6xhq3IWda08gOa/9VZvbM89JWc5ltFDY0pbVKb5TLuX8dMBUEoQa5pAHuM
	 UGAJ/LU6G2Nxg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C326FC53BDA; Thu, 11 Apr 2024 07:25:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 07:25:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-okvIW7mdqm@https.bugzilla.kernel.org/>
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

--- Comment #30 from al0uette@outlook.com ---
(In reply to xiaojian.du from comment #28)
> confirmed from another Phoenix 7840HS platform:
> CPPC flag is exposed by BIOS.
> So, on your 8945H CPU platform, it is very possible that ASUS doesn't ena=
ble
> the CPPC in the BIOS.
> I see this BIOS is built at 02/15/2024
> "DMI: ASUSTeK COMPUTER INC. ROG Zephyrus G14 GA403UV_GA403UV/GA403UV, BIOS
> GA403UV.303 02/15/2024"
>=20
> ~$ cat /proc/cpuinfo | grep cppc
> flags         : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov
> pat
> pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp
> lm constant_tsc rep_good amd_lbr_v2 nopl nonstop_tsc cpuid extd_apicid
> aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic
> movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic
> cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce
> topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3
> hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall fsgsb=
ase
> bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq rdseed adx sm=
ap
> avx512ifma clflushopt clwb avx512cd sha_ni avx512bw avx512vl xsaveopt xsa=
vec
> xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local avx512_b=
f16
> clzero irperf xsaveerptr rdpru wbnoinvd **cppc** arat npt lbrv svm_lock
> nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
> pfthreshold v_vmsave_vmload vgif x2avic v_spec_ctrl vnmi avx512vbmi umip =
pku
> ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg
> avx512_vpopcntdq rdpid overflow_recov succor smca fsrm flush_l1d
>=20
>=20
> BTW, suppose you're using a test kernel 6.9-rc built by yourslef,, need to
> check kernel building config file to enable msr support:
> make menucofnig  -> Processor type and features -> <M>/dev/cpu/*/msr -
> Model-specific register support, change <M> to <*>

I've also confirmed this on prebuilt stable kernel from my distribution, so
it's not my config's problem.

But why CPPC works on Windows? Can we add something like a quirk to make CP=
PC
work on Linux for these machines?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

