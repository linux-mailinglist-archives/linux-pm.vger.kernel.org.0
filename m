Return-Path: <linux-pm+bounces-9020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB2990566B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36736281D96
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD8917FACF;
	Wed, 12 Jun 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhR1yw5/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB917CA1D
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204752; cv=none; b=ZGEGt0RZpeJsVR6ZVbjtq9MJB4HDIH0+wWxhCyrPSzT/njSxuFi+f7ZemAAAkshnuQfxIZZkdstQGOljUjkrhvZo8I7sAM37XO7rkCc8/vXYbhrWBNvyWWWBROlcjAWZzglKT6p2aY14osBWYm4sa252wbKJ46Nl+fzCpUHx8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204752; c=relaxed/simple;
	bh=IzmdFvXHRs99cNH6S4dxTVXYvUMtfw1xvW0yjt5iJ0A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJfhyytgmsXzodQMTnrxOCHc96X8n8fu0xGCsfEZ3SFyH7q9AOX/nxSSyM2lYpu+0RmT7eYSCXvKc77VoMTC2XBPJiUumuD6S8U8ULSpJ+BdWKxxLUCtvkgxpIoxfcxu66em+tO+gQQSBei+ZSTC1Y6G8+g0v30hGVm/68w9/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhR1yw5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE473C4AF4D
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718204751;
	bh=IzmdFvXHRs99cNH6S4dxTVXYvUMtfw1xvW0yjt5iJ0A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KhR1yw5/KxQC3CHlfF3TytasfRiT+a4lMAdBfYj6riEVNFXFBY0EPSdQ1uEGBSD5D
	 yFmbvRgzGTBNIel1LAJsL993L4X1bOsHSEJO86+2nVSGo3W8d0TCt2XOYnqoe6lZNx
	 XucjWtowtcvDIbfDdZSq4YOaysjTt3IyISIVVXqErbvLARbfura/3sEXJv/flMSgPZ
	 g7gpZCW9vWwqh6z1SN15IA/QKIKzCzyHA/KqPTt6hqnPz2ClgcQqeRgo+Wbi4/wMgT
	 3Pb1MZjDbW/Ot+JOtZwseisjlhA5ELzFNjjThJWNRDkGiKaLc07BZILdI8XX97naue
	 nPy/Fr7XCuGYw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A77E2C53B7F; Wed, 12 Jun 2024 15:05:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Wed, 12 Jun 2024 15:05:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-HjMOqVJCdM@https.bugzilla.kernel.org/>
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

--- Comment #62 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> 1. * /sys/devices/system/cpu/cpufreq/policyX/scaling_available_governors
>   performance powersave
> 2. How is it related to=20
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference whi=
ch
> can > be of=20
> default performance balance_performance balance_power power?

When using EPP then the frequency selection is done by the firmware not the
kernel.  The kernel will set upper and lower performance targets and a bias
between performance and efficiency is configured using the EPP value.

> 1. I can enable/disable boost (not possible under amd-pstate on 6.9.4)

Boost support in EPP mode is not yet merged.  Perry shared some patches for
this, but they will need to spin again.  We're aiming for 6.11 to get this
merged.

> 3. And what's the "default" state?

As per kernel documentation [1]:

"default represents the epp value is set by platform firmware"

> energy_performance_preference doesn't accept "default":

Thanks for mentioning.  I've sent a patch for discussion on that [2].

[1] https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html
[2]
https://lore.kernel.org/linux-pm/20240612145737.1618-1-mario.limonciello@am=
d.com/T/#u

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

