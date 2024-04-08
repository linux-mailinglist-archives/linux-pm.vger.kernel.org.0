Return-Path: <linux-pm+bounces-6031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AA489B665
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 05:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDA5B21F75
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69235EDF;
	Mon,  8 Apr 2024 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5aeWSeu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525C1851
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546868; cv=none; b=dndp2hkN6J3BEoZjUC/5ZiPyY5JC5NiSwEgpDNv/dnvDtKCQXPPekrmbHLhipHSUTEh3Upoy6PZWtK9ZDyzjTvM/to1tEQty0sv+3W8qu0BoxHABPjaW5NyTy4bj1v+Cv/wlg7f3MoXUErvJj2BbGdUk2KWyoNr4TLI3Q8qY5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546868; c=relaxed/simple;
	bh=jPI5SyrsOyNxdrvAEgPm/G9kbPv5nJKkPRPUqjYiE6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TGCkO/eqKDIp2UcrdqAFJ/vMKtjF0vfzr9FmzgpMdn9lJCEuPRfdzNnlpvugOZ4Hdgc43C5lNBJz3CmCD6tDWQcf2UTeaEOfl+W1Ce4bcfcbeX66+dNimAmY1fNyf/hBF3jm5Fp+tczw4kPxarMhZFp3mmox4ypJdBi7hHfj8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5aeWSeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB555C433A6
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 03:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712546867;
	bh=jPI5SyrsOyNxdrvAEgPm/G9kbPv5nJKkPRPUqjYiE6s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U5aeWSeuyAs1nIaUtG3QbVrgDv8ZVMdNnBLx0r1NaaFENvpG+mB5IeWZ9GLRosy4F
	 wqje53q7cPOPuAlyggdI4npwGdcxSAecEex4rk2ijeqP4anA1MrrwiDSgbFSV4oxa9
	 NM/nPE/uEI2EAXL/4NLam/INNu46VrabBNFs61N8xQVMf0z6vSzeqFQMJM6OxRlQrT
	 0Mos572owyglw7lxAN0guEWVfI1aK7EiPMYSs78iIsxf4WOqXRsv61oH4g4ExkuONM
	 dt+iyTee/f87WhBWQc3Vjt42SHpehoutpwFOrFfGKPIsuwIY0JcIUdNllrFzK7LTS5
	 QDD03eKUAH+Tw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C5715C4332E; Mon,  8 Apr 2024 03:27:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 08 Apr 2024 03:27:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-A5Lz7B0q7q@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #59 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Artem S. Tashkinov from comment #56)
> Here's my report for 6.8.4 and Ryzen 7 7840HS:
>=20
> 1. Setting scaling_max_freq works, cool, but you cannot go below 544MHz. =
You
> can set 400MHz but the CPU will continue to jump to 544MHz, not a big dea=
l.
>=20
> 2. Setting scaling_min_freq sort of works, the CPU _prefers_ to stay at t=
his
> specified frequency but occasionally drops to 400MHz. Then, the CPU doesn=
't
> totally respect it, i.e. for values below 1.4GHz it stays around 1397MHz.
> The relationship is not linear, setting 4GHz results in the CPU preferring
> 3766Mhz. Or 2GHz -> 1982MHz. Not a big deal. Unlikely anyone would want to
> set the lowest frequency.
>=20
> 3. /sys/devices/system/cpu/amd_pstate/cpb_boost is missing altogether:
>=20
> # find /sys -iname '*boost*'
> [nothing]
>=20
> So, my only remaining question is where's boost support? Or it's not
> supported for all Zen CPUs?
>=20
> Thanks a lot for your work regardless!
1.  please try to apply the two patches for your cpb testing.=20
https://lore.kernel.org/lkml/cover.1711335714.git.perry.yuan@amd.com/
https://lore.kernel.org/lkml/Zfqv3ckVU4km+RLr@BLR-5CG11610CF.amd.com/

2. are you testing under EPP driver mode? the 400MHz is the lowest freq,
however it dose not mean the CPU will be keeping at 400MHz, it will wake up=
 and
idle and  bump up frequency shortly according to the workload.  you need to
know, when the Core is idle, kernel will not get the realtime frequency by
APERF/MPERF, cpufreq just show the lowest freq as 400MHz. It is not an issu=
e.=20

There is one idle frequency defined by power firmware, it is 1.4GHz for some
client system, the lowest active frequency is not 400MHz, it is 1.4GHz.  so=
 you
have no need to worry the 1.4GHz or 400MHz, it is not a problem.

3. the invalid max frequency value issue is caused by wrong highest perf va=
lue
defined by pstate driver, I have been working a solution to fix that. with =
EPP
driver mode, it will not cause any performance problem, just a little
uncomfortable to see the wrong value listed.=20=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

