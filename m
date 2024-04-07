Return-Path: <linux-pm+bounces-6022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB189B3BB
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 21:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502541F21A7B
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 19:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD329D02;
	Sun,  7 Apr 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDwsFcp+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBEDDBD
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712516866; cv=none; b=glhtKoClVEvtzXHYBZCPMYv32NfP9U5BtgZ/Iho1TufJRayerTK+8BY1hMzNEjbKfFEsTOhNSV1+Adf27bO7gFiOFVvkl2Q8KmeJ7Z2xGpFEfhpuJpFxAGpZ0r6daYYc/bs2eOicKIyXihisADxUwAGN8UAlc+qif8OpJ36aqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712516866; c=relaxed/simple;
	bh=9j1mRst+P61FNzaMq6Jv4SbORSbBnBx5tYF3HXUoB4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2Tj4Xg2GeKQBCmdC+ni/HcvOhQMr7ql8HvMYbVsd4PoG7rvSNpUN+zRy9NgYFcPD1+qEd/DGrZWjqyuVthlNZxg9OgML+iHEcXRi9dBYhh6AeOmwkj6eRcSSh2Ry2cT7CvmU3JEI9ZFPQCHsPvaLjeJDdR8C3XMi1Jz9ntxbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDwsFcp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AF4EC433C7
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 19:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712516865;
	bh=9j1mRst+P61FNzaMq6Jv4SbORSbBnBx5tYF3HXUoB4w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JDwsFcp+sAsK+sCId1wrIDCHYeoCckFHjhfYep2GIOnOIEbO6fe8ZjgA+yqsH+KEP
	 wYnOm57TGXY6Sr+OaW3Xg0clib0DiFoWpJDx9cn1ZABUxVB36VLpkna6W7x1vZHaE8
	 lPQo6JtIXgciya9ktX7ZYPF6e9ReChKe7XP+Quss4YVwpszC7xmjr3m8l9Hk3/KYPB
	 jHg7xZAHZBydlICIGlobRuEWfp00pYx6Fr4rLNoi6Rqf6keu/AsdiaJKpxizz5g60P
	 3F0n6YXGVdPnh0K+Ieh4RgOB4IhHj7/3uyZPtK1PhI+N6nYvATmZtJHsqW3ksemyJk
	 ao/+tCM5SXNTw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 613B2C53BDA; Sun,  7 Apr 2024 19:07:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218689] AMD_Pstate_EPP Ryzen 7000 issues. Freezing and static
 sound
Date: Sun, 07 Apr 2024 19:07:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218689-137361-p4mPYtjaGn@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
amd-pstate has been the default CPU driver for quite some time now in many
distros and your report is the first of this kind. And since most Linux use=
rs
use AMD CPUs it becomes even more bizarre.

I still smell something is wrong with your setup hardware wise only I don't
understand what exactly.

What other options I can think of:

1. CPU dies sometimes can be faulty as well. This is extremely unlikely but
does happen.
2. Thermal paste/CPU cooler issues.
3. PSU issues.

I'm quite sure replacing the CPU is not on your mind yet, but I'd at least =
make
sure that the thermal paste is applied properly (and you've not forgotten to
remove the plastic for your cooler) and that the PSU CPU power connector is
attached properly.

And then if you're keen to check thermal paste application, please remove t=
he
die from the motherboard socket and check that all the CPU pins are intact.

Again, I'm 99.999% sure it's a hardware issue.

I'll CC Mario because he knows a lot more about AMD hardware, so probably he
could add something.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

