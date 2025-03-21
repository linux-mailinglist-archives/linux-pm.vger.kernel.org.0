Return-Path: <linux-pm+bounces-24389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CD2A6BEA9
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 16:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB713B8278
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D6C1E0DD1;
	Fri, 21 Mar 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1PnUhfu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B01D6DDD
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572168; cv=none; b=awIf2xGL3zu+lTxiqTEFVDdR2eEdMmcmdTxs3N8IyIPBI8IViL27m/WRfU5kyO/m50BG+oCg1f/iqKBlZhEgFIEDosLHkfBxCZB1zbzEJ8Z6whQG3BdKzR03437xM7qAPLIOs1xaZDBslQeZ7ejKlmklM86Zl7/sE++Kl4rjeBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572168; c=relaxed/simple;
	bh=Qdbf2qT3Ab//VT+2i8/a8Gug+M/rmjwmuIzZSaXKobI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rKKhKsICAVu7VDUdDMb88igjW9uYnpNSdFJ+m8RCTAn/Vt15oVc4Q/oMDErS9OmXSy1tP0h8nECS1rcqVrhXnm+CmVLSJf/DQ7wZmyM0sTDV5UlCBwaOBrwTZckifj9ybAb02rddBT3l6HkGpgTKtdAtRzCwqORHELFXSdVgUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1PnUhfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59C86C4CEE8
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742572167;
	bh=Qdbf2qT3Ab//VT+2i8/a8Gug+M/rmjwmuIzZSaXKobI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s1PnUhfuSEzczIAG+XlBrWHdfRGcXXzFTrlG89V+E99Biqh70Y+2K90T4WdAiLi0S
	 aNsRDj79jCla5inl28pjSJIxDWN4uE4nFcnx4O/W+EvgjpWkVjhGz077BhNZhSHyhi
	 i85NgevlVo9zGT6+0LoNHDxJbTeNEQz1Shh3OXJCu8V+n2jFEsebUeElUIzs42JltH
	 t14QdZly6Ot4ae4uRLlFJVvOkJAevzminQBSIeOvA5R1pfSTPYHrhNwU3SK0ldkP2c
	 HqXzadiEUhF6K0hZUH3N45jwDdxqaEOIeSAk07qqwQlPnxMix3wDlEJ9iP0SOLGWTP
	 sefh37ILuD3kw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3E6D3C41612; Fri, 21 Mar 2025 15:49:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219858] AMD Zen 2 broken power management after sleep
Date: Fri, 21 Mar 2025 15:49:27 +0000
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
Message-ID: <bug-219858-137361-0FGCnXHwuk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219858-137361@https.bugzilla.kernel.org/>
References: <bug-219858-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219858

--- Comment #4 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Also; if possible can you please see if you can reproduce it on this branch?

https://web.git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?=
h=3Dlinux-next

This is the code that is going into 6.15-rc1.  If it's fixed there, I might=
 be
able to identify a commit to backport to 6.14.y.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

