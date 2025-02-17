Return-Path: <linux-pm+bounces-22225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71850A38AAE
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 18:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA653B20EB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC0229B02;
	Mon, 17 Feb 2025 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT4v/FbD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8421A421
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813899; cv=none; b=PpTCeYxpGUY5eytRf7x9Rb4/Vsdn6WzWzHiml5WMeFZuuhBdcv0Ouv3Y8U9ONCNarNny4cX8jyFjOkLUxdk//PraBjvn4o3DGx5ljY5+kHkez4uvQ0Ax7xvRzegYv9sW9m9AMPfQ70Nq+sFO0B1Tf0S9Ry/JU5N2QtPUDE6YXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813899; c=relaxed/simple;
	bh=pkFSPEsrQyEYFTGgrsrU5HZOXJ0wZNBnirI26Xjw2c4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g0G2sKmZs1+oedkW/kkyqPvzSATy8QByZBB3y/UYvXvpRPlmyb/T8fozgso3NUtg+ifuxwIIV346gOlPm2vMUeMH5r2Iwa0WlGC3gH96SZHrcLgdaXSi2YtnO1LZVu6ztyHJufjS+sNMUR6rWGvomMvx4xYbo7RJbTyEv0xNTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT4v/FbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F65AC4CEEB
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739813899;
	bh=pkFSPEsrQyEYFTGgrsrU5HZOXJ0wZNBnirI26Xjw2c4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kT4v/FbDg9FaW4rk6NP2y5Kwq2qV2T9vJFOnyqrNhu8HpT5kvMCw02K13IRyNAyra
	 UBWnTUKZKpi5mjr55XYKeAElhqE1ry3+hxy0+lIFD2bDtoMDNeQEU1ZLZDUtMG59pU
	 7gz0oS22z8zI46kxOe03vWdN8CNZXhNhNp6LFbuygkcqSexGcaDskvSxrkAeXyCLtB
	 /xE4QgIHrLV22oYYA0EgHDajYAyLSIMgV5mNuVmfy/En8Sd+/H1jQ9kTGPJ4SagmgH
	 DWspxPYj2MJPwvr1WSHiHfbcGGxbv/nkbCPdQ1iEYDZt+lj23qswWMQ1qkSOozYnpq
	 v1F4pyncqdaAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 47A16C41612; Mon, 17 Feb 2025 17:38:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 17:38:18 +0000
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
Message-ID: <bug-217931-137361-wLmB5fU59v@https.bugzilla.kernel.org/>
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

--- Comment #68 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
This bug should have been closed a while ago (boost is landed a while now)
rather than cargo culted for the new issue.  In any case let's work through
your new issue and then we can close it once and for all.

> AMD Ryzen 9 6900HS, ROG Zephyrus G14 GA402RK
> After S3 sleeping the machine

S3 resume?  I don't believe that's a POR configuration for Ryzen 6000.  Are=
 you
sure you don't mean s0i3/s2idle?  Or have you done some hacking on your BIO=
S to
try to get S3 back?

It would be really illustrative to me if you can please clone this repo and=
 run
amd_s2idle.py and share the report.

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools.git/

> it goes haywire, even boosting CPUs (ignoring boost flag) and going above=
 the
> set limits.

I'm wondering if there is a case that the CPPC registers are in the wrong s=
tate
after resume.  In addition to running amd_s2idle.py, can you please run
amd_pstate.py both at bootup and then again after suspend?  Save two separa=
te
reports and attach them here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

