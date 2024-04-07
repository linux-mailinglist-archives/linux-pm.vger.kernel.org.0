Return-Path: <linux-pm+bounces-6015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DA989B093
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 13:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CDCB215AA
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 11:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B24C74;
	Sun,  7 Apr 2024 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUY3qdvu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF923768
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712488862; cv=none; b=g/03dpa+1bqqBtN7aCARpZ+wWx3+3RtUVR1sdDfYG6Alu1Bo1JWbEUkY+AO87a/Stl+vh6l5a2NwgMzzetxCIWeK94sc1ZZxhnfWfgWqRzvI8G2x9xjdj9J6ZCl2bgZoJQgbFJESaCdSM4tfSV7sNWCdc1OK3olPL2vjYXTACRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712488862; c=relaxed/simple;
	bh=V9ceUh/koPA8XO+ov4c4yP6FZ7yPIrbvVTBlzC0Zmhc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j13rXi9fgTN9DRAuSsDbYEPU/zJRPE+SwJ+cN6QydTLuv6jarpVamlL/EbAZSfP3SsdH80cAuqMtml+pSpU+aUe/qSIQwNT/TkIMmJTfxMcAPtjIXdTCxBL3aRk5JYvAwTvH7VvR/homYHnaYcQJNwX/WP4RFyWKFNnERkD+A24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUY3qdvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 250EBC433C7
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 11:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712488862;
	bh=V9ceUh/koPA8XO+ov4c4yP6FZ7yPIrbvVTBlzC0Zmhc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VUY3qdvusqo3vkHDCCV6rUsl5E81UV+CFk5/VJr9gpzPatXFvBEBy3ww4eJbvEf8y
	 cayKduSDjt+EXuaa+R21bZL2UyLMlAcMNpgSvHIgXfqDaqwoBytdV7AUq+ItyOQkNl
	 jBzv+lrx5Ib0FmfNXKNSGklw7lxk1aUaAcxL6i3T6h6EiS0Bzh8py78RmjaZusLFdQ
	 muoenGvgmLZ5ZPG4iQ50IQwIk5Di3BDyDjbadRRYuyex3matlkCWOBV44D6yU3NacQ
	 dtx+/GecJJ06pcdm2VCbRCMhha3TRUdVChZU5SLVxwU07VqDjqfOYFJfpkuCgTlqss
	 x1eiq5MCIsotw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 196ADC53BD6; Sun,  7 Apr 2024 11:21:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218689] AMD_Pstate_EPP Ryzen 7000 issues. Freezing and static
 sound
Date: Sun, 07 Apr 2024 11:21:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218689-137361-mw47t3DKZD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218689-137361@https.bugzilla.kernel.org/>
References: <bug-218689-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218689

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This is extremely unlikely to be caused by the CPU driver.

Please try resetting your BIOS settings and not using any XMP memory profil=
es
first.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

