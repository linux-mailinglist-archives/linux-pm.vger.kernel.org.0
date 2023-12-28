Return-Path: <linux-pm+bounces-1659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6004181FAC0
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 20:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DD6B240F8
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54505101C8;
	Thu, 28 Dec 2023 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnDliCXQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD310787
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 19:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1A94C433C9
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703791648;
	bh=UXiegDxyHraNvCyzMV1Ys8BAy4kGhrKGvijkX8rXhn0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gnDliCXQ/r42nx4EyRLlA1lk6OQterftdA0W9kKgBUhoQz7brOG22ALYgtQ890kb+
	 vnNLa8Zv1fQt6Ybw4ClG/mJGQrPeFBSCyXZ/uqbWSJBYhsx+9gFhQ79kMatmfofQ4A
	 B0invvPGCqZqPmUubXuBQQPquTbv73nu37L3vOVY0CxFOT7r766kX4xIr+L6QkaZxs
	 3t7SytXp/DrDosRMZywPUGUDACiWcPi8mvJpELC2cR0mu1xhGW/dvx7FLmFF6fjJ86
	 t3nqWksdgYm4kgjnru1fhWpf3j32LYER+7xeDPRhfO8WEbTcu5XKGO5LLSrGT8neHd
	 Vw44C6YX6t/9g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 86698C53BD2; Thu, 28 Dec 2023 19:27:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 28 Dec 2023 19:27:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: voidpointertonull+kernelorgbugzilla@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-sWYT6Fqs1u@https.bugzilla.kernel.org/>
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

--- Comment #12 from Pedro (voidpointertonull+kernelorgbugzilla@gmail.com) =
---
Got to test the new changes in 6.7 , and it does work, but max frequency
changes didn't really seem to apply well.
Initially I figured that changes were just not deterministic, but later I
successfully figured that the first change (after boot?) just doesn't take
effect, and then setting the same value also doesn't make any change, so
setting a higher then desired value, then setting the desired value does the
trick.

According to htop reported values, the frequency still exceeds the maximum,=
 but
based on both power consumption and performance, the max frequency setting =
does
something after all, I'm just not really sure how reliable it is, but it's =
neat
to have something.

Almost forgot to report here as planned, but coincidentally I needed to use
CUDA, and totally fortunately Nvidia doesn't feel like supporting the latest
kernel yet, so I'm back on 6.5 and I get to enjoy the heat again with long
running test which reminded me of this bug report.

So generally recommending updating to 6.7 if this feature is really desired.
I'm surely missing it, the stupid high frequency by default is okay for bur=
sty
tasks, but it's definitely great to be able to restrict it on demand.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

