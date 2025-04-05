Return-Path: <linux-pm+bounces-24841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A356A7C869
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 11:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AD43BB4C0
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07911C861B;
	Sat,  5 Apr 2025 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7V+pz+o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC52E62A0
	for <linux-pm@vger.kernel.org>; Sat,  5 Apr 2025 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743844040; cv=none; b=LePPjO4t+ii2z3Ct1NkLK6KXYp3RHZ117Bncs7+uofhGCDu0lBRTxYkcxtjU+I/lQiBllTRYWOZbuLiPRYIfj7+imfAeyi8oNcgNoYB1lYRXKUdfKyAQCb4eIaFMUzvSb74612dRaoHKU9D7OINdbScJ+WQ4SMWwanGitXiZmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743844040; c=relaxed/simple;
	bh=AeemlDFjC6v1MKYlYp4QMHBC5jJGQ2iQqzR2cCNmozg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECQRtLVA12hRrQT8kYw71BUKr/SUnnJNwnb9ZIOj43Ox09bTUPi9bnyrb8UiXvNjKkRlS4MrfAnp9oHWq9ViySqirlanAPx5kNx4fxcR2v0J7woc/hjG57/WNrt9Ng/mx/w+G10RvzDXMuxumx18EaS5cmwv9fiFZwVMbP2H/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7V+pz+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6192C4CEEC
	for <linux-pm@vger.kernel.org>; Sat,  5 Apr 2025 09:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743844039;
	bh=AeemlDFjC6v1MKYlYp4QMHBC5jJGQ2iQqzR2cCNmozg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N7V+pz+oNhnTmJIrxl5CT8y+nUa6B7XILY7u+OTn8Ig0NgiBHB9agDs8EsqFcnsQV
	 4GR5MizBfb295/D9NFGbnF5DthSNOHWLL0MvIxYMJfadJ4RTges2jNXbxqnjmjkbJK
	 V3+jMpjTfkMrGwAT7+OY56Jl/gkSXrUwslaDZQ6mLzvWZjQZrHTUhFpOqxEtCD5V7c
	 DR4IxFSo84R7/bfkDOfYXxQirmspnhDRG0IEOhEeq/5KD50QJEdGlUiyUenD6AIFKR
	 iocT0zReZtg88oA1yuCZwIEgjfI+D04ub/n2wWZs/D3ep9MDt/zjjz1Z6zM6NOjvIk
	 W2cXMC/Y+v4EA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D72CEC53BC7; Sat,  5 Apr 2025 09:07:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219966] modpost: EXPORT symbol "policy_has_boost_freq"
 [vmlinux] version generation failed, symbol will not be versioned.
Date: Sat, 05 Apr 2025 09:07:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219966-137361-oAAu7roBUR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219966-137361@https.bugzilla.kernel.org/>
References: <bug-219966-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219966

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you. I also get this, but I only with =E2=80=9C6.15-rc0=E2=80=9D and =
not with 6.14. In my
case, I bisected [1] the issue to commit 6a367577153a (percpu/x86:=20
enable strict percpu checks via named AS qualifiers) [2].


[1]:
https://lore.kernel.org/lkml/eb3c109f-550f-44ce-b0a1-3837aef1d02a@molgen.mp=
g.de/T/#u
[2]:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D6a367577153acd9b432a5340fb10891eeb7e10f1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

