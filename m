Return-Path: <linux-pm+bounces-12842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5D295D4E3
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 20:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC701C226AB
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA29F1917F2;
	Fri, 23 Aug 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8FdKgES"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3D191499
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436446; cv=none; b=tSNhPkf0aGoGDkX3Xnl0VTG6KD1Lk978Ya1ZeK7lrS1TwohWNN3dXMjPQQ8KQgQI7R/MZh6JaIicdjMVDvYk4zZzhr+D9aq6peJO7sSjDc/0UPhdThmf4jqd5KS2pagB0GsQ3xr9C+e+KeDeCQXXSkEAr7EMqqqcVGgylVWoh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436446; c=relaxed/simple;
	bh=+Y+Zv6nTOtbFjykRfhKCrC+x+hzconiAr3MrmbLaats=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3nzD5v0Me/PKwciXTJocY8k7Q6slbhhaa/fMXabK9MsPN/wQZz7+hQ30d4YTm7tpL62w1WnkbvtKi+xIvYy6r9WHWdBF7ejljz+B9otf0UP1ZZm8bfMWeJ9qYkWTdfy//257YXMMGNrTwWkszhYerE/4VIWaBbZBbbhtr5mvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8FdKgES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E90FC4AF0C
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436446;
	bh=+Y+Zv6nTOtbFjykRfhKCrC+x+hzconiAr3MrmbLaats=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=i8FdKgES1wb85d4EYM76QNVA8reutsSgta3NKpUBzCktWnRjcfNrZeUA/iCNqN246
	 NUmGCgizoqdwV06gwghjp15kU3l7p5ndSg4Dn5BqSyEhkmyNfxOC8KWt8ct82IXk8b
	 aQ9BJGC3ymONvBIbTY5MUPbck0RC1z5KyS1IIcFkpvjamUTS6+9L9+PCj5XoXnub2P
	 ZX4rk6RRuQPp9jtt7MddUPGW2X3jojsBcqwkyLPxtGUUe7bQ79MO+deIagRHW97ZBM
	 zO+dcRmZiaukFnokoEY2DqL/jR10r5c56BRzLwRr6e3adUaiRW0M7aru87PX7SH2y5
	 zgWSTWXjVLd5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 12DB7C53BB8; Fri, 23 Aug 2024 18:07:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Fri, 23 Aug 2024 18:07:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-219110-137361-LLqqBMUHJ3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219110-137361@https.bugzilla.kernel.org/>
References: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #5 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
(I've been OOO a while, but I see this in my inbox as I'm catching up now).

I have a Framework 13 on my desk (Ryzen 7840U), running 6.11-rc4.  I stopped
power-profiles-daemon before suspend to ensure it doesn't influence the res=
ult
in any way.

Before suspend I ran:
# systemctl stop power-profiles-daemon.service
# cat /sys/bus/cpu/devices/cpu*/cpufreq/energy_performance_preference

Everything is 'balance_performance'.

I then suspend with:
# systemctl suspend

I then resume and run :
# cat /sys/bus/cpu/devices/cpu*/cpufreq/energy_performance_preference

Everything is the same.
Can you reproduce my result on 6.11-rc4?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

