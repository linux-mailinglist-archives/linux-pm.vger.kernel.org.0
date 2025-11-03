Return-Path: <linux-pm+bounces-37317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0206BC2DE57
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 20:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10200189A53D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AC12D9EEA;
	Mon,  3 Nov 2025 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDhrZdBO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16F292B4B
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197915; cv=none; b=mAhmYvwZ9p9zxwmKk8r1pcloxuJPew9F3VBdSDNirXju0pHUDpCmOsS1xg1wgN5Z0Am8DEX6RmMy/XBw+OXtx1uTel14fOezDbwcb8FRriNv4wdm+Oq+9nPP1Dt+Ziw/umS6Dq31hXMoWGYZLTqkgZlxOEH7iBD0amonsFEipnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197915; c=relaxed/simple;
	bh=eXIb09JwKhomQnXW2qurqbw+QIbIPmoZcUqbfAnTO1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=emXDoNz1xlNOjw5zYbyWxwnsZhRhp0VVE4KFLfmpcaaGMSfeTciP82QiK564G+pYQmd7SB35heMSxdn58NiAc1WF217IUt8Rt9zAaCUHT4FH7MA5J3cLdIKBCk7h9s27q3+kjMS/3lpTI7wRsX7yTf+7VqcLMURZpZa5/y5Ddmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDhrZdBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DD10C4CEE7
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762197914;
	bh=eXIb09JwKhomQnXW2qurqbw+QIbIPmoZcUqbfAnTO1Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IDhrZdBOXwA1rg2nV1MrHFYWVFkq7BUIEv688e7wyhwRqWvXwNfda9qzG7wlnSPbu
	 JJitfoRFBkTHqvoWMbZnpkbjf/UmYYdnbWOYwwk/saORL9x8E38ufb335VudcQO4nD
	 7Pfx0vHmTLDbmyvR87pLYVWk9QqoUG/ITJ1ug4s1k2eXfKFzIh/tNJlpIcSsYrHhy8
	 H/dR+qETV8PYBsTA7cxTyUmA3bYiMtcEXhWfEvfcJRb61UJRSCkXF0aHOmJbA1QPYP
	 aXv0DKO1Wgy0G8B+37hwlU81IKtZbAqmJ/2Ng7hEgL155AuB3aXthIRpOSZ1bpx53a
	 QsRy6cZR0/Uzw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 18F81C53BBF; Mon,  3 Nov 2025 19:25:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Mon, 03 Nov 2025 19:25:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-XodXGnJeaW@https.bugzilla.kernel.org/>
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

--- Comment #12 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Can you please try with that patch on 6.17?

If you can still reproduce it please add dyndbg=3D'file drivers/cpufreq/*.c=
 +p'
to your kernel command line and provide a new log.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

