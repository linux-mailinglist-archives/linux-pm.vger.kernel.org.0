Return-Path: <linux-pm+bounces-2346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA32831F96
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 20:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC8C1C236BF
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 19:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442262C6BD;
	Thu, 18 Jan 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6+F+qbl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBEF2E3F5
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605772; cv=none; b=N+Trq/BBDR5Bx+EThGYHiLO3yKISOWvGMTu+rqye2S8oxDu9k1LmoUzsvJSZ2oBroU3fk9De6G7mHsPcwWXbXZrMQFkcVTuCoEiR1zSltVpeAoRsmybah6Ov5Iny/K5klQvKYT/3DiCYEGtAWkd80Zvemxfmd2zwMknqLXVtZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605772; c=relaxed/simple;
	bh=n30RLu5IsJqeGe1JBri/NQcknpROgmqRVlcU4JNFeyU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JyiuEzIk/eb8KQEonQggRjosKwFgS51eOBGdkrHsTucNAXPOKMAs0lX3p3Van6q2fWjpViQa6BmXQ5ifCrGXjH3fc5hDTllJl5n+ZRz673SxaYIfHoEAGyKGTZfVQtcHlOiCKPtjmU+h8uTBRAhq1sK4fOeKTrRqn+zjC4TUfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6+F+qbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ECCEC43399
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705605771;
	bh=n30RLu5IsJqeGe1JBri/NQcknpROgmqRVlcU4JNFeyU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G6+F+qblPAEGPfx3tZF0MGVaVACBi+N7lKQgk+E1RuTTZVpleSetXqymvcxzV/RFw
	 qNKNCwUG+MyFqaF+CekzmB7YmIuEBlxVfA3tzaGiJTgLLQsO0b+RdOKeVp0SKyfPsj
	 gqSAmdfd5DnBCZzgm5Ib32pz5RpnDtNl3+/4oGmEl0v9Aq1vjd0547GK/tXu/lgo7I
	 M5mUbz2mgTsgELu2DzAoX7TCqe8YFG3Z3ydeZHveQHmUI+9U3qyHJuDPhRb3JEyDNn
	 Hq0vItoGwoh+y1+nvBzRlXlGRKirFQ/9TtbUYt1Mqg3Fi6uwXTrvNXJOhOQkiKPtoy
	 FcB7yg9Dgm1Hg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8440EC53BD3; Thu, 18 Jan 2024 19:22:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 19:22:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-UletjdSOeZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #21 from Artem S. Tashkinov (aros@gmx.com) ---
I did

echo 3000000 | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
3000000

on Linux 6.6.x and it did exactly nothing.

cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
3000000
3000000
3000000
3000000
3000000
3000000
3000000
3000000
3000000
3000000
3000000
3000000
3000000
3000000
3000000
3000000

Cores continue to hit their respective max frequencies all the time.

Fedora hasn't yet published Linux 6.7.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

