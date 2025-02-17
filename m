Return-Path: <linux-pm+bounces-22240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F66A38D3B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604C6188BD2E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE4236A6A;
	Mon, 17 Feb 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atVxZwyY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC3149C41
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823795; cv=none; b=AipTy67S1KogO0Y0ZGH99FYUDkRZG5Ii2FJBZ9LDppxboXZ8zeGctBevkqbDJc67oCnVDcc+S02/SLQso258lEOQsj4wTKZWoibaRITBnzGbJkSrIoGKM9n/V2GdAZBk0sQIAOUDLRkQ5LBjUS7CQ1ZGf9a0kJNLWNBLPKF6jow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823795; c=relaxed/simple;
	bh=2RWcrT8y02vcZjksQCbeavgycig/i/ud2Yom7nao2Cs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gAayHVNQzWO+6vovfq08UGD6QitbiABwlf20u5oxVeRT9CC+oiF8pA3QKEq5I2rKkSeooOxFyany734C+/WtLGp6m2rH68OJ8uT8YVwXie0c0cjAXomMBteq73Yccy+qPDERo/Md9dBRtY/0sfdZx5UvfMz5aj+S5yGeyiZMUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atVxZwyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B43A4C4CEEB
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739823794;
	bh=2RWcrT8y02vcZjksQCbeavgycig/i/ud2Yom7nao2Cs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=atVxZwyYXKpl36h40zUVzM3hErRy+v4WD+dTPS1S9+HLEmjJxZNY9sTcBtkunlsbh
	 YWw7mg+LneLdG2XyIIyZiMD2iku1VE1nlM1Vt/6aTg+rMVB8RHJPdr7JIJxdsLKZOo
	 eEtiuhnT/+PIDQQ1L3yjYZkqIy7PTwz+K+V/Xc+ySwWj89K63In5OIDZO5WGR9Esn3
	 f3skDb+YYzQcu74t3To+cJaEvcS9yjpxDJpXEhj22L2G1yeuMlD5YpeMXb+cpy4gYa
	 OGpZb+ciKjQ6AeEgB73jjiOtUb++Y7Htmm7ICFzJLx/5q3u19pddK894usOmMgHIev
	 Al2oYKolbL9fg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AD73BC41606; Mon, 17 Feb 2025 20:23:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 20:23:14 +0000
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
Message-ID: <bug-217931-137361-8PmD7mrLIo@https.bugzilla.kernel.org/>
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

--- Comment #76 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> s2idle and pstate reports after applying the 'invalidate cppc' patch on
> 6.14rc2
> Maybe those GPIOs are used on the Asus machine for handling the Hybrid
> graphics. > I'm just speculating here.=20

OK; let's not worry about that for now.  If you find a power consumption is=
sue
later over s2idle we can figure it out then.

> I've applied the patch on 6.14rc2. Attaching
> 2025.02.17_s2idle_and_pstate_reports_post-patch.zip:

I'm confused here on the timing of all of these events, do you mean to say =
that
the patch did nothing?  That's what it seems like at least.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

