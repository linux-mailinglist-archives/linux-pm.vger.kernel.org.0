Return-Path: <linux-pm+bounces-13908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED3A97245C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 23:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E2A2849C6
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 21:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B52018A6BA;
	Mon,  9 Sep 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+TVCZND"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934617085C
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916616; cv=none; b=SyxWRZgpSQ0dVISg74PpiNOeTBeHobqYY0rGGLTu/2hTV/Mso/LktddV1pUlwkAjJZdCVrsE9H783kmUfZaKvGFUGEDbZ3CToiAgAuPQwIDmzcjIpHFrKWraTdbkPU4v86fdsITmTPjinLEyQkkVihdhBw8/kOQNSNfJs+U+dz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916616; c=relaxed/simple;
	bh=R0/5dxATOJL4KS9QVnCoLX3ozBN1T1sgeXuYTcaL0LA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gpJSy5BpV2jvipzlphMKXim4KE2rei6i00R7ZlIdDfybuyOaCG2npNfLgq3Vg/lZrd9XHCqMg/OInNRnmE7q7eGX84gH71sJm1K4jhaVfB0zDlSnRz33LwrUt1WpnckepsdvsT1BkdJjFbTEvwvvPeyyEU5058QqVDTICrJw54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+TVCZND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62F87C4CECE
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 21:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725916616;
	bh=R0/5dxATOJL4KS9QVnCoLX3ozBN1T1sgeXuYTcaL0LA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e+TVCZND50aiDrrG1Q4/Kr54F+FwSpPGDTzBKB/vIAop+7A54onqGn9xDAy+suft9
	 NivgbON6sjm/dmxRvJHDAmEOrUCU12aIjEoJq9KnKddbsWQK5Bnakn1rqanBogxSIR
	 7eMvk8vzUaBuBf8T5ZBqHMyTmIXj1xvhFk336g4Cn4JLFr5C5UXNLxfX6y1Se+/Jh1
	 0x0OcYsAayUwrzieY3P2aiPM1ZoIsOjLkgDrYONevmfgcROj7jKO3IWwYDDuD+DIDj
	 HHMzSJgyFvnCY+aeiU6oDC614CZKu1aEgKv09q3mf/b+PTcFzvuvUOX+ga7Pss49bX
	 fU6ySj7Ya/oRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5B228C53BC5; Mon,  9 Sep 2024 21:16:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 21:16:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218686-137361-A2K0Z9l9k9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |REOPENED
         Resolution|DOCUMENTED                  |---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

