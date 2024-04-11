Return-Path: <linux-pm+bounces-6258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A088A07BF
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 07:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B9D1F22046
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 05:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325C413C818;
	Thu, 11 Apr 2024 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui+iuklX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77E4F5FE
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813455; cv=none; b=NlCir6qOWKsPUDbXdM2w/frL5d7r6rS5l9Qo8bjbUo7qQvvLc/NjD5sHlwxzq3vy8Gn+ipIzqporq4u8L3FG67WtZExndBb37Bton0VL8SSGiwVo+TewclsnECkJIL6qt8lofXjV6+ZscOFQy5EFdjRxtGaJordrV8Y3/FjUZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813455; c=relaxed/simple;
	bh=vH6QTvw+Cbkc94wTnfRmq+8iLxVTbKGDTAKeukoF6Tg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j2Kg19DRMvMmsZmifDMbPmijUqAS2XU9fxMeWq9ERy6CL7XP0uk54NC/GWpMjo7QdQ69Hdnuq1QJICiZmxCZRHLhGmuQ40i+NR3PcRLmwYAvRAwYCQPBD/Smkk+uUZm6FPhqYX2sXVK8bCOwrL6e4smfhz6Zii19nBCziyA2yYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui+iuklX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A78F2C43390
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 05:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712813454;
	bh=vH6QTvw+Cbkc94wTnfRmq+8iLxVTbKGDTAKeukoF6Tg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ui+iuklX/5lQmAyPyFcBwSHtcFdIXvKZ/59U/ULjil+IMajz7ewRp7ZdLE2vVIZLD
	 r/bh6ciBUGMPCje3A+g2ha4wybYWHTQ2BaG1D+k7chjn6SJveuvUGGEzQ0/dNR9uVq
	 GW/PmaoY9i0+7yOQmmBI6lnVYiPItL96m6ibLI0A8n6PjPsjI8esUA1OJXtNwAOaRL
	 CwuX7nZrsLNsua37d05vDKvqgELOlcobFayAvxBq98N3Ii51ZxQ37pUUnQYf24UuGt
	 lbnZi4U3sx9BIQlIWSo+5ovBoclXs9OBKeT610sAxjQtog7nxxAYS4SFCK0W4bxgRS
	 mxDKHqzVZzv3w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9DD02C53BD6; Thu, 11 Apr 2024 05:30:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 05:30:54 +0000
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
Message-ID: <bug-218686-137361-H5YRR7x3vj@https.bugzilla.kernel.org/>
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

--- Comment #29 from xiaojian.du@amd.com ---
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

typo: make menuconfig  -> Processor type and features -> <M>/dev/cpu/*/msr -
> Model-specific register support, change <M> to <*>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

