Return-Path: <linux-pm+bounces-3208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6736A846635
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 04:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0BE1F25527
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 03:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EC3BA4C;
	Fri,  2 Feb 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBgy6lid"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D9C2CD
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842963; cv=none; b=p6ZsA2x4H6yyuUB3omjGbTGCUN1NrpKeXzpT2v0+m9wQZcatQgdCxORCO9zn2QIrnKN9Gm7SDOYO2uP3iPGHAp/2hAXGA8RVqy5rlG3Ka5JVRW2/S3t2LVGCLcXzLGAaj9I5V0lPPTkAsxE0sZ0DubLXprMq0klEEFr4vHId2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842963; c=relaxed/simple;
	bh=vw2bk/qb6o6lk1drbLsBBnoISJ18s96FJq9IaPGL56I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGEhY17DtCxObcxbm7JiBwActLwmeviAjlQ9DbFEIZSxnUx+JmAOgDohDg4KKdRU7pJXmGa+GoKaLrJpbHDPDlRtiscTi1lVEL3Wbtw29AjNdIiq0oRzwyKZmCvbHorhWWilz7AmivXCE6rHpBTMr9Ge/s1ZhQlfrrLhiGF72ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBgy6lid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12348C433A6
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 03:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706842963;
	bh=vw2bk/qb6o6lk1drbLsBBnoISJ18s96FJq9IaPGL56I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TBgy6lidhnyETjIlWS9jfJo73OT++/WaCTISx8pEQPOX419vVs6STX0Rifu7h3UnH
	 UQXu2d7lLAsjudtYUuB/+x3kP9PZ6suwTdyTgmTSZbvanuLZ2qFBconb0eE+wVDrwK
	 gvX0jzzaC7K7BGdMLOhmbjq2w/8DjdNxKviCoi6+nULagPYh/On7Byrx71VXVcnbzC
	 3aw8SLPmBenL6P/7GrXqAMoikDmfyM3urhTVTQtafSQWv2QIufkA5CwUfdlOli1kYd
	 0iGU0tZpfBWLLcYON5ODSxjEUpiKwqN+xck4aUMQ1SVgBKuM9GBBg5Sf+a7to2NHxF
	 3CcvhFDWO4VYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F2BD7C53BD5; Fri,  2 Feb 2024 03:02:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Fri, 02 Feb 2024 03:02:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-aHMuPJD4mN@https.bugzilla.kernel.org/>
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

--- Comment #51 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Artem S. Tashkinov from comment #50)
> And just in case:
>=20
> $ cat /sys/devices/system/cpu/amd_pstate/status
> active

Got it, thanks for the info.=20
We will get the scaling_max/min fixed with other patches.
This ticket is focusing on the boost control feature.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

