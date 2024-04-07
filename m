Return-Path: <linux-pm+bounces-6024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3479C89B3D7
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 21:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB170B21026
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A033A1C7;
	Sun,  7 Apr 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkrq1fkm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833D2BAE1
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712518822; cv=none; b=QHDm3Cor9JXWkM+CKb4OA/B+DlxB4g2AOyCru+14N+BLHJghmf9ffxPFkx5QVEdHtKeq6sDgSir3WjaxMsghCY2I0n4GagYMQw43EAZaRQprhQJDH6rM5XsF5PBI3aiAyCeNmic9cUesEoNBrTftciyG+t8eC4rb306vA0eGn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712518822; c=relaxed/simple;
	bh=rzYA3CPmX15IqkrlmwNIKrTuD3yIblh/ekbuDLQRzhc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tCdieR97Rmf5eMcDrxOwTBmTyHKMhrNovSPd7xRM5Jo25YHIen0C4YFiVA2QodvK4OeOSkWq66PCN/Vev0r0okw72Xo+wHasHKREkSf2tI7ffZ0SwmMn4chbPrDkb17MNN3sOAAFQLN7W4VdgVsFYcG+o3NNS2dxqwgYqFVtsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkrq1fkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 631EBC433F1
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712518822;
	bh=rzYA3CPmX15IqkrlmwNIKrTuD3yIblh/ekbuDLQRzhc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Mkrq1fkmD1s4/ik5N6Sao/6m/ZjI4Uzg+JCqQM8wJpeAe0JgAzkRmzQoD0PwNQSZv
	 CM7+CMR73Yb/5NENUS79Scl47Hrv2ScHm0mkOlPnNgS9xUdFkf6clIt1cILIYjU270
	 P23Sh/+UFJcibLUsZO44m/6M6v8P101QqN9lgV3cxOUMO4t9ggM3aZCFsT+ebVf5YT
	 fvj9AWhavBF7g0d1VqjFJTt6NRKL8ymdvtlgg5JwO0FYbA/4kV4NasNYu8Y0qGNXRW
	 Up7yw7c4dh302pp7CogEBoHOUfWyDhBp+YF4UbHrXVWypwVAFOLmWWv3cHTWYZhNUp
	 iCC55Ot6pI9Wg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5A71EC53BD3; Sun,  7 Apr 2024 19:40:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218689] AMD_Pstate_EPP Ryzen 7000 issues. Freezing and static
 sound
Date: Sun, 07 Apr 2024 19:40:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kbii.chris@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218689-137361-QX0kYugUcZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218689-137361@https.bugzilla.kernel.org/>
References: <bug-218689-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218689

--- Comment #5 from Christopher Bii (kbii.chris@gmail.com) ---
(In reply to Artem S. Tashkinov from comment #4)
> If I were you, I'd definitely post your issue here:
>=20
> https://www.reddit.com/r/AMDHelp/
>=20
> and here
>=20
> https://community.amd.com/t5/support-forums/ct-p/supprtforums

I have attempted to post on both early on but to no avail. CPU, CPU cooler,
nvme and the rest we're all removed and put back. Absolutely nothing wrong =
with
them.

Even if there were to be a hardware issue, which I think is ruled out at th=
is
point. It would not perfectly explain how the issue completely goes away wh=
en
the driver/governor is changed.

The CPU benchmarks perfect scores. Another observation I had was that under
full load with that I suspect to be the faulty driver, there is no issue.

Disabling c6 in bios does not fix the issue. I will try the other driver wh=
en I
disable _PC register to see if it fixed the issue. This was something I had
tried also but I cannot fully remember whether the issue persisted or not.

The CPU benchmarks perfectly, outperforming the average on geekbench (I am
cheating since I am on the superior linux). I believe I tested the issue on
windows also, it was definitely the same until I upgraded the drivers and a=
ll.
Issue nearly completely disappeared.

I am yet to try on 6.8.4, I will try the different drivers and see whether
there is any difference.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

