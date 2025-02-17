Return-Path: <linux-pm+bounces-22284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB4CA38EE1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BADE3174757
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403001AA1E4;
	Mon, 17 Feb 2025 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYS0y1Nh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7591AA1D8
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830178; cv=none; b=XMxVNsr8c7Z75Qz2IvG0JtmYbYkrCEPNkDiMYm7MtNpSKpYqlCiQ4PdEfNbc10kQIu1KdHGsh4PnWvIiE2/fK+gTFzh5EG6MxF2N8iHHpIqLR2IO7kcuQL2FhQl69whEZke5fbQyFP+95Ok+uL/h8MF0GKq351lExkV3q2LD4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830178; c=relaxed/simple;
	bh=HTH5zo/a8cQSIVm6Wy0nm3K7gajw+FeYtSs5JvJyKlA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LaCRFey9LG8kNAceLliIMm8cN3MpjNaXVBhveY1QPSy4r8ffbFqmN1nUTKvBrIBNlAXn9P0YBS7pUNG+YbQoG/kXsYpqvTpWk+1bsV1srZlQ5Ixq9WJg/hbKIkVdrneRaxY+FDZJiRI5iIcPyK46XDWNP4BmSlATPfetXbw2Tos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYS0y1Nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DACDCC4CEEC
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 22:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830177;
	bh=HTH5zo/a8cQSIVm6Wy0nm3K7gajw+FeYtSs5JvJyKlA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cYS0y1Nh4Dso+M/OD9O34O2DrfdozPUb4rrzYiHC84EjONnGKTAqyMcmrqlK8bnAq
	 aKEvWsaJhbdSgt1VuImsvhmwWioII8TSJhvJfkTDgRbJpZucPlH1g0Z/JGNf5KKAIB
	 sRcVk+QYTSoYDb34A64uMLpbJ9lm5vmcDHTNXTmMiG6Jkq267jXsbDW4wmLNN83//c
	 T40vWvIiCkiqNYt3N2E1iKKRvpZpghLMl6hRve7j/yM5fGxMQ+rCXQEI299vqPQUPJ
	 fY1DGL16ihuRhJ4OBO+RX3WUClNVOrFG8g890b2mm78ncArCDOsbOFr62eBhQG5Inb
	 uSKpD6+TbAjKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D52D9C41606; Mon, 17 Feb 2025 22:09:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 22:09:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: miroslav@pavleski.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-a9oSPC0teY@https.bugzilla.kernel.org/>
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

--- Comment #81 from Miroslav Pavleski (miroslav@pavleski.net) ---
> OK great, it looks like the amd-pstate issue is fixed.  I'll include this=
 in
> my next patch series for amd-pstate.  It's good timing because I'm
> overhauling a lot of this code for 6.15.

That is great news! Glad I could be of some use there.


> Unfortunately; your suspend failure is missing the thing I need to tell me
> some important info about the failure mode(the idle mask print).  This is=
 the
> line we should have seen printed.=20=20
>
> https://github.com/torvalds/linux/blob/master/drivers/platform/x86/amd/pm=
c/pmc.c#L733
>=20
> I notice this at the top before your sequence starts though:

>> feb 17 22:06:52 greenstation kernel: NOHZ tick-stop error: local softirq
>> work
>> is pending, handler #08!!!

> And that has me most concerned that the kernel wasn't really ready for
> suspend.  Let's split out your s2idle suspend issue to it's own bug and t=
ry
> to figure out the pattern and what debug we'll need.  We can keep this one
> for the amd-pstate issue, and I expect we can land the patch for a later
> 6.14-rc.

Well, I see line 733 calls amd_pmc_idlemask_read which includes the strings
"SMU" and "idlemask" in the output. Unfortunately, idlemask is not found in=
 the
journal.
When grepping for "SMU" I got this:

=3D=3D=3D
feb 17 22:03:18 greenstation kernel: amdgpu 0000:03:00.0: amdgpu: SMU drive=
r if
version not matched
feb 17 22:03:18 greenstation kernel: amdgpu 0000:03:00.0: amdgpu: SMU is
initialized successfully!
feb 17 22:03:18 greenstation kernel: amdgpu 0000:07:00.0: amdgpu: SMU is
initialized successfully!
feb 17 22:07:09 greenstation kernel: amdgpu 0000:07:00.0: amdgpu: SMU is
resuming...
feb 17 22:07:09 greenstation kernel: amdgpu 0000:07:00.0: amdgpu: SMU is
resumed successfully!
feb 17 22:07:09 greenstation kernel: amdgpu 0000:03:00.0: amdgpu: SMU is
resuming...
feb 17 22:07:09 greenstation kernel: amdgpu 0000:03:00.0: amdgpu: SMU drive=
r if
version not matched
feb 17 22:07:09 greenstation kernel: amdgpu 0000:03:00.0: amdgpu: SMU: I'm =
not
done with your previous command: SMN_C2PMSG_66:0x00000036
SMN_C2PMSG_82:0x00000000
=3D=3D=3D

Regarding the NOHZ tick-stop error. I've seen on another thread somewhere t=
hat
it is probably related to the external USB-C hub I use. I cannot judge if i=
t is
interfering with the s2idle suspend process.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

