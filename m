Return-Path: <linux-pm+bounces-12900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DBB95F8D9
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 20:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D5E1C20DDD
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314C9198E7F;
	Mon, 26 Aug 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzN5bGQs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAFD1547E2
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696072; cv=none; b=RyBuKTpDTQs8wKceGsPxh3nqV9ErOwIDi2OlrQwUwUqI2OnjTca0SyqSjWyQIpx8YhtLGIBxdhddXiqqL6qS4NnZlAQWxKiXvy8LHSboC106ZClDtozfGwj14qLuGaWU71cxm5o9qTNaPMuUySrpO1vKlINdzJEDGBhB8h39drg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696072; c=relaxed/simple;
	bh=8tI41OLGRUhiCTYQJ0WfeJYB2E/WYQJJKojQ8WZSGNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3/OhKMKlwl6JDFlzOpsbONe3pIAZ2WnXy03lTZBCgDO+RwmJ+V1zPlVDk5Y9ZSZT4o3/Xw/IsAmcTgaackglINL0QeY7907RtcWX4+LjDcWceJ6YM0CkH9NVsSVDDXZZhpOWvnUB1FQaj1AhIFya+uP5yInDm1xC9M5V8Dy16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzN5bGQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89542C8B7AD
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 18:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724696071;
	bh=8tI41OLGRUhiCTYQJ0WfeJYB2E/WYQJJKojQ8WZSGNE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rzN5bGQskCYQQrsZgP1gf9vF92vn6aKIRnlYlwUsiRuSFhsgDrKFFBtJo2BhdUbXk
	 E5USS3fxuVKxjcQn32f1V7+y+oXKo3Q9nWygOEq2XcSTsrGMbWKRCiW/tB43bNV6r+
	 33QKn2OUKmrSkx0EFJIFGlMBLPOT3oqmpvm9Xg9s1hg25YePhBlrRvwn23O4fi0zDd
	 M3sS5smFTeSPp8E7ELLpPZnRcB62gD/b77QZEh8LjYLPr2BFVyiXGq6PHjCtPXGyqA
	 ThM6AvRDc6fdweVSpzwXnXPp+HSlrNtz0F1kbKyYv+c7EKTNqAllGaDNDxKJQUdfZ7
	 iYZsUfpbXfeww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7D793C53B7E; Mon, 26 Aug 2024 18:14:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Mon, 26 Aug 2024 18:14:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219110-137361-gxBFvVOwEf@https.bugzilla.kernel.org/>
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

--- Comment #9 from Artem S. Tashkinov (aros@gmx.com) ---
Could be a firmware bug, not the first one :-)

This command doesn't seem to work here:

# rdmsr MSR
0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

