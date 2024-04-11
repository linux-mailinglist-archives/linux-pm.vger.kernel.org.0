Return-Path: <linux-pm+bounces-6283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82EC8A1C42
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 19:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F59BB21B1C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15156772;
	Thu, 11 Apr 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtyLHR8r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A40E56459
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850816; cv=none; b=eLdrhPNsVKEHly+zBjs/RWjfwYEIjl6V4GKBzzgUBXuLtaajZVd9uxm0zDAb5YjZPpvnXyqydwl4BQE3xvRqhH8FQVZP433yOp2QSAZmS4O2rrEbrellCOgbj02eZJ3PQIk9RezB82UWRzHCuc9IKRYPYk2dP0A4hkFfxHr+nLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850816; c=relaxed/simple;
	bh=4ioGs4eP+q3XV7u6xYzGcWv+ECi2Z0515OvztIDJ5Rk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8eVppL5WLUvvSMKqn3D1yJx+rnX1NondIK/sGR3jLPu8of6ZU5hkVnOf+Gf55qsv6866bVd+ie5sfL/k6RTPbyloXjA2pJY9x3c+68sBspb9iE1B2usJEWKPVT6YCOX4fP0MlZHouk+EMapRo/CGhe25sdfnoImJoUwMpBtJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtyLHR8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9D4CC2BBFC
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 15:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850815;
	bh=4ioGs4eP+q3XV7u6xYzGcWv+ECi2Z0515OvztIDJ5Rk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PtyLHR8rBOOaWPBoSp3vdJp2/JWo3bZKOGT4LI3lpEkeMgqq5ara22haL4od/6uGf
	 oDKT6sTPHrAZ7LOEaqm9EyA6dZZHJNzWHAZ1OnxP7zbgzBPRA2gcx353Xae4yiXtfZ
	 QXaCitQ2FvNqKnhC8t18zZV3M5U+u+favgxXCwRjY/VV8NmDB1xCNO5mfyYOM41Z6K
	 ysNzjIQrfNMKsIwC98m2Z4X+LFqXxG9c8vc703LEX4rPU4Q6Z1nEgS3h8N3iWww4YM
	 hC9eVFZOtGj6vgdTPaY4voybyPZaKc3q8b2W2pLlCW32uyH7F3yrKeQN71HUWJMkkS
	 83gFjooJ1G/nA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9961BC433DE; Thu, 11 Apr 2024 15:53:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 15:53:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-MVfx8It6sK@https.bugzilla.kernel.org/>
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

--- Comment #36 from al0uette@outlook.com ---
(In reply to Mario Limonciello (AMD) from comment #35)
> One more idea for you. Can you please try to go into BIOS and do "reset B=
IOS
> default settings"? Even if you haven't changed anything this will reset a=
ny
> hidden settings too in case there is a problem with one of them.

I've reset and even reflashed BIOS, still no luck

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

