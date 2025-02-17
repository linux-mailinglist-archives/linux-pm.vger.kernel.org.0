Return-Path: <linux-pm+bounces-22242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3B1A38D51
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6949C3A52CA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9530822B5A3;
	Mon, 17 Feb 2025 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFShrN+0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662019048F
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824304; cv=none; b=r0r6XVEv7ckKPiuo3Rkas9H5L/FeCCcjIsSMgUilLuL2L1yCB/wPNu2yo8EIRFLINj7HVwz1CjECejrrch/Rq+IiNz3qIzBwRl+MVR71aBfSGn4cELx0W/zDWzI9dgJORGr5JV/KJRLcHcYOBxn0st9Bjpbw3P2C5GeOZXfuBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824304; c=relaxed/simple;
	bh=0SBIDNow1B7VtcoOuSmSKI0v9GbtKNO5tUN644CCbGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxdZUnYqXksOhueJzOQbyg+0mLdiZuV5lU91ErgvBT+vBaApnYwdSCdJ54rThOoHDIo2S+LCpmnfsB8ZbnoxaivU6EESVIUZxQrAiah+tLCUUBipB6lJGzsh/xMscnRJui5zX1Ng11R7ql7XXGftgKRCA+Eew5FvXz94wa8SkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFShrN+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E053CC4CEEB
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739824303;
	bh=0SBIDNow1B7VtcoOuSmSKI0v9GbtKNO5tUN644CCbGQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WFShrN+0eh/doVp1mWsMUsWQ8ZS23LpP6UThzhYNiM22NcLbZ52F5M2TmS3bcUq6y
	 xS7M4teOx07Ifh1XBsqesgaQmoR7aKB3mteOT7Sa2WC7l7CRS+wvW9x8rlKCN2GJQh
	 IC6v2FkKEJ7sQAjkeFUh+6+H2CbnwTTaIuck5J01vTdxluxyU0rLyDx9KR0vHey+gk
	 KIW+3QboxvWLmmgfg3hIVj4nOEZqbul+8k12Ac4vYjvqlK9Sx4x0Lr+02E5wT/yMkH
	 9RrtzdzaN+HB7NB6zAO+IkJ3oz/PnLPZehy2yiSrf8KT0YsUqN/vrrERyYFAcDcFsG
	 ixTMPHyWXTcJw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D9BA9C3279E; Mon, 17 Feb 2025 20:31:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 20:31:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: miroslav@pavleski.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-IaWSIdIhpe@https.bugzilla.kernel.org/>
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

--- Comment #77 from Miroslav Pavleski (miroslav@pavleski.net) ---
> I'm confused here on the timing of all of these events, do you mean to say
> that
the patch did nothing?  That's what it seems like at least.

All the files in the zip are after applying the patched kernel and rebootin=
g.=20
amd_pstate_report-2025-02-17_post_patch2.txt is report created after resumi=
ng
from s2idle.

I've just double checked in the source tree used for building the kernel
package. The patch is applied.=20

In addition, I did some more testing after resuming from sleep. Seems now i=
t is
not jumping above the scaling_max_freq when not stressed.=20

I stress tested all 16 cores and then it ramped up towards boost freq. (abo=
ve
nominal 3.3), while having scaling_max_freq set to 1.6GHz and boost 0. Howe=
ver
when I stopped the cpu hogging, it ramped back down idling between 400MHz a=
nd
1400MHz. Subjectively I would say the behavior is now *way better*, the CPU=
 is
not drawing a lot of power when not stressed, under light desktop use. The =
fans
stay quiet.

Seems like the amd-pstate-epp has complex algorithm that takes the
scaling_max_freq as a hint, not as hard limit. The upside is that when need=
ed,
it adapts to those needs. The downside is that this is not ideal under batt=
ery
use, as rogue processes (e.g. browser tabs) might drain battery without the
user realizing it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

