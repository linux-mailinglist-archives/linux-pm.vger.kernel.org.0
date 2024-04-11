Return-Path: <linux-pm+bounces-6257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED108A07B5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 07:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D1A28B511
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 05:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9562F13C810;
	Thu, 11 Apr 2024 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP2Hhdu0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126613B2B8
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813345; cv=none; b=XahMGgB96H4qHnybiqNar0yFfM25Rv+NYhkvFnjaSRskCbv5ddYayINhdLWruicj7d67KzyIhPC7G1Nc3sKVilp2zBb/fpmzuSqBu4dAYK+rscAet4pt6VmoDWTUIAsNRTp8Piomc5+D2mpxpOouMIUAKC9phww8T020oeKB2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813345; c=relaxed/simple;
	bh=EBg9+BnQqqzGN6w2fO0K6Cam1N54HR51JbJ2OSa30SI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XsD0aDhZiPRsFF2OUwy9Wx2L8J6rLMZ+9fBCSqYU5HGAwgTN7A2HWtdUp8ImlPnTvsBAKPE/d4pf4MtawJovo3StYZcljvSjltdHNGMiWuwH9bW8HZJGgmpwrV6TUa2O4UlYFh8aMvhKgKI2OS0ayc7RLKvYSHJX2mRKSx61DYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP2Hhdu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6775C43390
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 05:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712813344;
	bh=EBg9+BnQqqzGN6w2fO0K6Cam1N54HR51JbJ2OSa30SI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nP2Hhdu0t/pFE3ugT4SIw3Kv1dRrr4csf1LbNECkhLa83SKY6MNU8R3IDxopvXSxn
	 QVz5EyxNOtemQpmYLPn1+qPXmB2Ck1fcK+fVG4hVq2ll7L9OqQbMqevIXKXkPugmSv
	 T8b11PRRiURO3TPT5TMJHVqvoysLp++eh9Olm4d12+LXTCO+kamlWqk86yUKOARXiV
	 a1+jxBQs0OCCqQN9iRrF3KqGLyB1zlNPYCJwwMAG7vFkGPzmAQBGciSkER5EMcHiRy
	 x47UHOwq8UEVek67vDPVcu4DArjUItQf4h7VMOxg9Y4wWtpH9hDTPhvfMkxV69hMRj
	 /E3tODH1hUM6Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D8AEAC53BD9; Thu, 11 Apr 2024 05:29:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 05:29:04 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218686-137361-Y2Nb7DS2yE@https.bugzilla.kernel.org/>
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

xiaojian.du@amd.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |xiaojian.du@amd.com

--- Comment #28 from xiaojian.du@amd.com ---
confirmed from another Phoenix 7840HS platform:
CPPC flag is exposed by BIOS.
So, on your 8945H CPU platform, it is very possible that ASUS doesn't enable
the CPPC in the BIOS.
I see this BIOS is built at 02/15/2024
"DMI: ASUSTeK COMPUTER INC. ROG Zephyrus G14 GA403UV_GA403UV/GA403UV, BIOS
GA403UV.303 02/15/2024"

~$ cat /proc/cpuinfo | grep cppc
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb
rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl nonstop_tsc cpuid extd_apic=
id
aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic m=
ovbe
popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy =
abm
sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core
perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba
perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall fsgsbase bmi1 avx2 smep bm=
i2
erms invpcid cqm rdt_a avx512f avx512dq rdseed adx smap avx512ifma clflusho=
pt
clwb avx512cd sha_ni avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_l=
lc
cqm_occup_llc cqm_mbm_total cqm_mbm_local avx512_bf16 clzero irperf xsaveer=
ptr
rdpru wbnoinvd **cppc** arat npt lbrv svm_lock nrip_save tsc_scale vmcb_cle=
an
flushbyasid decodeassists pausefilter pfthreshold v_vmsave_vmload vgif x2av=
ic
v_spec_ctrl vnmi avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes vpclmulqdq
avx512_vnni avx512_bitalg avx512_vpopcntdq rdpid overflow_recov succor smca
fsrm flush_l1d


BTW, suppose you're using a test kernel 6.9-rc built by yourslef,, need to
check kernel building config file to enable msr support:
make menucofnig  -> Processor type and features -> <M>/dev/cpu/*/msr -
Model-specific register support, change <M> to <*>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

