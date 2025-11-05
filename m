Return-Path: <linux-pm+bounces-37482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A70A5C38060
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 22:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174791895384
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 21:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A592E370E;
	Wed,  5 Nov 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU5lIH98"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC26253950
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377645; cv=none; b=dDshhACskvXgTB7BEUtO2vKQdHD0yaHcY3/Seb02ieAEhqLCRe2wDtFFZBe3OTAlQMj34qtioSpqObwK8MMVUrbzu18ta8wRwH96etEN3FDZT3qnzqTcPXQmjjltNad+YkJtd3LfdXb/w3dT7V4nsx6p44aV3tRKQEWB5ANUkkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377645; c=relaxed/simple;
	bh=i1HKvdQc0JevvihsyVfBjjkBWtF4KOKW58sqVS5FhG4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J5+X8mvuguBuiN5J8Bu7ROFSLdQWNdSTRHvIGAvbxjxfC5rAaYB+JNP53XIc+tyZDGLl/O4fazLyarKhavZ4B/eNiJiymvW8ArSlhWJF1/U4DIs94z7BFpUlBraL6nO97bQb9WTkxIH3EO9wqs5T1o3YKOeaWGLw6utlGVro1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU5lIH98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68BD1C19421
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 21:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762377645;
	bh=i1HKvdQc0JevvihsyVfBjjkBWtF4KOKW58sqVS5FhG4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JU5lIH98qi2/hjU5w0g+DF2ZAgdhA0C6A8gXKgTLmQiG1zjcEk4thm/rYjo0mFVJf
	 LKcBVPR+iQM61v6wjqjjppcnMzHGZbjVfnNXaHEKTvOZvPck3tp8t+N7/NuS1gpEcY
	 2xb8ACy5vgLYYBT6r1aOrg8wqLbcXojK0/6Z4HhXW6vEKTsOC/OQ+y+iS/UYREzH2H
	 4Lc6zm86isuDV5pc3mHeZnhd0PtXIYO5HX9797a4J8q6M4YaNBVawzyTlNQZ3QWX1O
	 yxmC778Jccw/dR9fwOZSTGBmtV1MFVnGWwLIkF39Vg2W+t0+o8L3qakMjI4gLUp1jM
	 LrwDpeY13RbeQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 62E81C433E1; Wed,  5 Nov 2025 21:20:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Wed, 05 Nov 2025 21:20:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chris.harris79@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-uzeDLDaoFm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

--- Comment #23 from Chris Harris (chris.harris79@gmail.com) ---
Done re patches 1-2.  It looks like Mario made additional commentary in mai=
ling
list.  Once acknowledged or addressed, if you need me to I will test the
collection of all four patches.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

