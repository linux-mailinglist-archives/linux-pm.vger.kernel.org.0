Return-Path: <linux-pm+bounces-7789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED98C4B2D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 04:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6822B283327
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 02:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9D628;
	Tue, 14 May 2024 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzWnFxVP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C3D29AB
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715653859; cv=none; b=OhOTjWbaCMn72cbXFAJb/+JzP2Rnnc1CQb3gqzZzCsCfVDOcnFe4+FA5kF9AFkVLowYyXNbj2Xs4fp8jiFP5GxX1wTvOLJcxy4BDrP3tjVLwFcxvaIxxXu014Tf+9bgYtsxky7AdpsRLbNzC+nSgwlBp3PsXuZYyaMbjGDunNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715653859; c=relaxed/simple;
	bh=HxEXqethyYw5yHlJiwesDPt52Y10ImXA1pWy1/Q7EHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H6aWoObE5Sbkvca9Wtq+e36HE0MPMUG+SFX7mOBYIrO6z5QkV9SJSMEcbJHorSEMNMyKL1SMXLz7KbUMvPq1GZnEr+qfs0uOHrdH/JxsGv9WMSmLdpHregX13whVZXoMiituXds6YaLCYeKx18mF15EwYGxmpzf4TBZL4kPyuqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzWnFxVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 840DEC32781
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 02:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715653858;
	bh=HxEXqethyYw5yHlJiwesDPt52Y10ImXA1pWy1/Q7EHI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YzWnFxVP/bBLoda/3zxtzfn8m7HDNdLvhRBd1nOahZhKSNMx+TDS8apbL27KfqQBN
	 o/Zlf5COrjMO9eVGFLarYZG4fJ+R+Xv8UsAZ26ZFRj7F35LMw+rwFGPjIs3YclwLsA
	 i7ekz8sDKAeD34sN1zxwPwsvzZN/LA3w3W9CKe7oUN8uzmYIQ21WRq/YzuPO0xiykJ
	 6kKBefnbejbxtuYa4omMVMcF/7vvBBW4UNx0upYbkR2NtVMBFUtwHL5bwXSATOVOsu
	 FqctmZ3EO963ibKKDyld3BK168LdpijJ11hvH8Lxj2uroMgkFtLUz2LGxOoT7gXtRr
	 oyKr+RufWbiuw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 775A7C53BA7; Tue, 14 May 2024 02:30:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Tue, 14 May 2024 02:30:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-vMG4ClXhCw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #29 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
 Hi Brandon,=20

V2 patchset had been sent out,

https://lore.kernel.org/lkml/cover.1715356532.git.perry.yuan@amd.com/


the patches need to be applied to linux-pm/bleeding-ege branch,

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/?h=3Dbl=
eeding-edge

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

