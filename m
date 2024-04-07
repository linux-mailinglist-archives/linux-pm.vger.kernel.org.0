Return-Path: <linux-pm+bounces-6023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B6D89B3C4
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 21:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3411FB2234A
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACFB1E889;
	Sun,  7 Apr 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKJGS5Ki"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DC3F9CD
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712517168; cv=none; b=cJ4gtMLWRxN55CtpfF2KCBjUh1zQH7jscDiVKjvqomwpOWBP3fOLu6sEtrraYr12mkjBjSAqe/JNsRc7I7vnrH+cNKnjPWKVWbY/hx/8ZpcMWclw2VttdJS/hzO5ZueZTCkBuq+s/AOKk3yN4QLoagx4TtgiQfyWpoeTXi+GoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712517168; c=relaxed/simple;
	bh=eL9dxxC1XOcqqzACKJDO/mG8zNti4cBhZFHAyIGhOgk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9SyVouQMIiUPDdt5xtUwpgcsxnX/WHFHbpJqRrqhrtg5SAhr3sfmmbQpITu3rsInZERpeV2CeC11DQT1CUdBMXrNgdM0sc0yQ5G/vvapHTwbm0Qh3GsPFd12BvrUnoNDPPDiJ866N3kDFeXJEbjt/ZrKfgEEI2Y+qRpYk/dreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKJGS5Ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FC45C43390
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 19:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712517168;
	bh=eL9dxxC1XOcqqzACKJDO/mG8zNti4cBhZFHAyIGhOgk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YKJGS5KiZtiFfEWiDoH731Gk0X0fHmwXmsI8Zt+sRqkq4kpbcjXdIXNrou/3RjlH+
	 xkdcAukU2+Ovyr8VGzuZl/jb6oCpwgUE0sx6H7vBWUscLvQ9dAzMzqvZC3HM0Yk1Ws
	 ELmumoCGGdQhmasWjbD2ydXUFBrWG32Erfqwhj1qD5vYGsetHkyO9Az3SW9JgeiUjm
	 zlx+0NHUH4pgV+LL7hPexzz6bu1uGFeBXkbR+W72gv7wo7fBBsfrGxf5cOkpfj0lf8
	 itfx85/l+6kh23gYsxn7mxlQYrI+TCwAShcXE+lU49KQH4lQ4U7cnzrku9efJExaYg
	 G31Aa4F6vSTPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 032E7C53BDA; Sun,  7 Apr 2024 19:12:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218689] AMD_Pstate_EPP Ryzen 7000 issues. Freezing and static
 sound
Date: Sun, 07 Apr 2024 19:12:47 +0000
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
Message-ID: <bug-218689-137361-M1VH88xIcV@https.bugzilla.kernel.org/>
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
                 CC|                            |aros@gmx.com

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
If I were you, I'd definitely post your issue here:

https://www.reddit.com/r/AMDHelp/

and here

https://community.amd.com/t5/support-forums/ct-p/supprtforums

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

