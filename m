Return-Path: <linux-pm+bounces-11125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E42931D7D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 01:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7F71F21B8B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 23:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BB813CA97;
	Mon, 15 Jul 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDrUGz+p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E920DF4
	for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084919; cv=none; b=mNxOMRtj3fHMWTsQ9zBleQVF3r7MY4nOdtllH2dOD57RK+xhaX3BYKTbw3nvbj8UNvS0PsUxsMnsTBUmIVN3D8ir4rNnUjF18EMa0sUPNviuZwriCZqOn1ze8DqcBW+3WV+xTjyVARfrdP7pZQTBgxUa9hEM1y1tfY86gl/KCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084919; c=relaxed/simple;
	bh=LVCHZneNpezZyF61WmC6m60FAPrr6Bf0brjRySDVozw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FfxWxG8eZB1V+0LV4gwbU0f4i6psJAF5ydxQ+YYgrc1qsZrr1zcRAe+utA3KhSfNSvVC0bbofjB3JIz2vEFAbUS666X/AbugdPV5hrkUYaWU705Mkm/zXHQpnNOXadBowKNdW/6U7c/Fuv4mS7UxNoiq1rFheU4Fo69OKIO/93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDrUGz+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB4D1C4AF0F
	for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 23:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721084918;
	bh=LVCHZneNpezZyF61WmC6m60FAPrr6Bf0brjRySDVozw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PDrUGz+p6s6Sef4BnkIyKWcUf+fDBb+c+PmIwF5ELEf11mioJzDZBq//cMA9R98DO
	 9ESYjBg+jBNqbx5/TDcKjQJZJZ5B/dc9gtLyWquS5zOFDMFOQ8VkwojIuFiiKnLMh/
	 LtgFE+OO3NUqsVnT0Peq2S9ls/u5zKSXT+VZ9R5/7VkReH6CmSrt7jvMiTqUlMQs0e
	 0IpbJDJdsmAtOxdsGTqsHjJgU2p3ZFBf4ZJy6XqIROIrUUav9CY8Xw3wIkcWgkw5Lf
	 kX3PpYyIQP2VyaZ7vrp6MgGYvna+lw/zB715ObzedFcGlDpT5NlPOsvIYSrlYyQPHu
	 7jRZGpNzKak+Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BF2E8C53BA7; Mon, 15 Jul 2024 23:08:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 15 Jul 2024 23:08:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nicolas.granger.m@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218686-137361-J1ZztSARil@https.bugzilla.kernel.org/>
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

Nicolas Granger (nicolas.granger.m@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nicolas.granger.m@gmail.com

--- Comment #56 from Nicolas Granger (nicolas.granger.m@gmail.com) ---
I opened another bug (https://bugzilla.kernel.org/show_bug.cgi?id=3D219044)=
 but I
suspect it might be a duplicate of this one. Can anyone please confirm if t=
his
is indeed a duplicate?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

