Return-Path: <linux-pm+bounces-40338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E1CFB458
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 23:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 085AC3032949
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 22:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B193081A2;
	Tue,  6 Jan 2026 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7neLF8t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6832E1C6B
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767739161; cv=none; b=nG59Xmk7Mpe7lCCAWLr4j4U2Qg84bTEd8HzAvBPdkpdqT8/0GazcFvPALKHh7XcV70iPso0JXI9tz8NTXtj321FIeSdDRrlJlJMc3nlFN+evkv1qi7XsYPmNs+p9o5MMp+NmFxNwUAm8U0uWE/AVsA9sAp7saqX2BB69M8aq/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767739161; c=relaxed/simple;
	bh=Awkkv8aju/LoeLJYyyXBApeNnvAn6P92N10m1r9BVLo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jBzdwQyBuyfSBj6n6wXSmFJcAMBm49d/OBS+wsr2LslKPNQRAR7HNQhoJXRAEfikwAJnXhoHMi/4Yk5+qHMFHMovUoxjpuuPu/QYzw1zdYfKWTPA3gF6zsGk5jTn57jO0fONNqJvtjWRmvv8panSkCuw8urn2Tedp//ia3kR/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7neLF8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28905C116C6
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767739161;
	bh=Awkkv8aju/LoeLJYyyXBApeNnvAn6P92N10m1r9BVLo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A7neLF8t1VPEDXeIM1QTa+mo7gpXu3sY2GkbicRMvCYheQB35gqgoSAhIWhvz5p+J
	 loPNv9Gz6rnsuP09t/BAnben0dm4g0DBlgxsuLSHPid6Y9IZBDshnOV9ZQcWoJ4PS3
	 o9Um4VUzW23xfWdoqOFVFtkRXjO5xptMgczc9eKmK6ZLVTr0SyNVcnjM7ETfYjh6GW
	 42/x8Vm5sTeECuA7Ztf0U2jC8vKwGpakmVVGGoqM1D2wQpf/bLbT7uUNGAy2+JrttJ
	 voHt+HaNb/t+TtLfWLXvZnjOdXq3dDLqbMp3c2KPdjlv5qLsCTdOPY+SIgAaSATBLC
	 Dk58IZpZ+nBIQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 20A49C41612; Tue,  6 Jan 2026 22:39:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220946] hibernation seems to be broken after commit
 bb31fef0d03ed17d587b40e3458786be408fb9df on v6.19.0-rc4
Date: Tue, 06 Jan 2026 22:39:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220946-137361-totEhfPkjp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220946-137361@https.bugzilla.kernel.org/>
References: <bug-220946-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220946

--- Comment #7 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
OK thanks for updating.

I suggest updating BIOS, hopefully amd-pstate will actually be compatible w=
ith
your system rather than the failure to probe from invalid values from the B=
IOS:

> [    0.515949] amd_pstate: min_freq(0) or max_freq(0) or nominal_freq(0)
> value is incorrect
> [    0.515950] amd_pstate: Failed to initialize CPU 11: -22
> [    0.515965] amd_pstate: failed to register with return -19

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

