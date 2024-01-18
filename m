Return-Path: <linux-pm+bounces-2352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7418C8321A8
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 23:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0D61C226DB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 22:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EDF946F;
	Thu, 18 Jan 2024 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rktOvBuj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814D28E08
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617546; cv=none; b=fe4ndq4M84NBK1znk00Vsmu6IpEFygmeKl+wzKjF71yvR63WPztIjeEDSBwNe5AGLgczS2bWTHgPRFgbf0kROO7M6YVIi8udgRF3rW3nN7eQBvmUu+FRX2gh9AjmPilQWEXpuQ2h2MlvAj0ybmlNWwT/0F8noAKNHjOVJ786FQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617546; c=relaxed/simple;
	bh=sBsxAAYqM7YoOIeeSlS/Y09zOjSxhix6jwkG8bbrhT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFhvhV57HelnlEWP3CXRf0D7IECYmGJuk79I+kbRkg+EVEhiCFZaKwwJPPC6dhue9uopP4SJTwr6cmFKCgQW++K8keyLwecF9Y1Hh2d7QYNe9BzyWVLXkvrRYVdlSWhf/6KSP7sLece0kxejAv2XxY1LUpwwGTuLAgnVaZ76vBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rktOvBuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65891C43399
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 22:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705617546;
	bh=sBsxAAYqM7YoOIeeSlS/Y09zOjSxhix6jwkG8bbrhT0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rktOvBujUK+/KFphmdbiYZRGWhsu3yt62H1pEO0wp/N3htnC7tucgKkZDqI111qdJ
	 dfnX/T5/BEyYh9jTy4IA5ef5DGhyNiHdZOQLgnJdaWs2YpA0HNDr0T9H3JSu2HeT8c
	 dK/L1X+gt6jpyXSmseOYY3YL7wAkDsy837Y5ifbB1JxVo3H7npLmT4qWKcCjpxiaNA
	 T407P47VCjTxeODTT4O2ya/Dbne9GOLpOKUC3x7sVEr6VUYdWzSjpP2fJXxqHXEzG7
	 NH+MZVUcs9axJVPd8pd+lXyGIp4tJ3BxR0RUEMKhiaPv/vkVmj0znKEb76rwHRGtUm
	 vuTwe0O9+17vg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 512D9C4332E; Thu, 18 Jan 2024 22:39:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 22:39:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-8jlL76SOcm@https.bugzilla.kernel.org/>
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

--- Comment #26 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
I tried on a Phoenix system myself, and I can reproduce what I think is the
same issue here.  I did experiment with writing MSR_AMD_CPPC_ENABLE after
writing MSR_AMD_CPPC_REQ to force the request but it didn't work.

I'll talk to some people offline about it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

