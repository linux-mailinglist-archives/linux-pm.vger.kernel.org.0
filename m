Return-Path: <linux-pm+bounces-56-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE77F3BE8
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 03:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E75B21720
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 02:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0B42BAF2;
	Wed, 22 Nov 2023 02:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1pIiW0E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D423A4
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 02:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E81E2C433C9
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 02:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700621017;
	bh=82bhsvdaYhrub9U31GNj60NDg6dc8AAjHMv2U1AuYYA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=M1pIiW0E3miGr9e7IHsB3f/ZAvoyaX+zfLY8E2zOeg2QEaF8htJ7Pu4kn8gGic9ar
	 q5jODhf6LnCh+sPj0TE6a86fMVBnw+/qu9xEBsDlSYgLGxrlr7hnLXBkqxVG0bRgkZ
	 0zA8vb23cazyZQbi6AIEHvEWljrNpMhlO3NtFBwP0fzWZDmzuanxnaQuA4M2U9/Fe1
	 1E4i/b4SWMa1oBaW6s43FjTGC6JUpdy+BwsasK7TTnZv2huIi/Kcb6HS2HdvOEHlnk
	 TANRTjJOxDZnGs2JjPuc++UJyDLZyXN6F+ApUHhiQtuZ+I5JIVBPWmZ4SsJEkpDzZD
	 eUXEs1HO7vdAw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C5A8BC53BD1; Wed, 22 Nov 2023 02:43:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 22 Nov 2023 02:43:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-TPeyVpu3Lz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #4 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Gino Badouri from comment #3)
> Hi Perry,
>=20
> I have the following in: Advanced > AMD CBS > NBIO Common Options > SMU
> Common Options
>=20
> CPPC (Auto / Enabled / Disabled): Enabled
> CPPC Preferred Cores: Enabled
>=20
> There is no setting to change the default state.
>=20
> But there seems to be more reports of TRX40 users who are having the same
> problem:
>=20
> https://forum.level1techs.com/t/is-there-cppc-support-on-threadripper-300=
0-
> platform/195804/5
>=20
> https://www.reddit.com/r/threadripper/comments/151l6rn/
> threadripper_amdpstate_driver_on_arch/
>=20
> https://www.reddit.com/r/linux/comments/15p4bfs/comment/jvvr12s/
> ?utm_source=3Dreddit&utm_medium=3Dweb2x&context=3D3
>=20
> A while ago I was running a custom Xanmod kernel which had the amd-pstate
> patchset applied before it was sent upstream.
> It was an older revision of the driver of course but it was working for m=
e.
> The only requirement back then was setting the "shared_mem=3D1" flag on t=
he
> kernel command line.
> But this flag doesn't seem to fix it for me when running linux 6.5.

thanks for your information, could you show me the output of lscpu?
And I would like to see if the mainline kernel work for
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/?h=
=3Dv6.7-rc2

If mainline 6.7 still have problem on your system, I would guess there are =
some
 missing thing we need to figure out.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

