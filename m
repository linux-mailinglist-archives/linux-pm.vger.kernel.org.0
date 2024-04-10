Return-Path: <linux-pm+bounces-6152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E149B89EB50
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05F91C20C81
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0DC3A1B5;
	Wed, 10 Apr 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVToilbA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CE18C15
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732113; cv=none; b=KCe0UyJrbdF6gEP4HhTL5YuhiqOZvezIsMNHrRwhKuFk6K/TMeAzr/LZaDfKL7IXpDzMvMR/g3dZBFXc/in8oiMJ2VKE3SoV/B2Rm864LVtRy4L6kO2HPhPTjuTyz+90L7ojYlQ6jP10LixM4I5CoxH+JNoYwvzvOx4Dj1iNCbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732113; c=relaxed/simple;
	bh=KTMvZd4GUdUSW+qVSwV5FncLKLv0wEx3Tv6YIhQSQFY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwU8OnDvEmWfET25I3aFQtAnMhydWv/8C8DMmvkcRJboa3cXpaUD/XVDR4S19F9LHaZaad7zO8WLWaZqZN7FBLxGPCm59lf9I/0Paq2kAPlM6MVgPhIctHKMXy9ceWBjWALNHq6BpQTHSTCcIDOmIVV/dcnICesfJCgwvM0620A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVToilbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9141EC433F1
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712732112;
	bh=KTMvZd4GUdUSW+qVSwV5FncLKLv0wEx3Tv6YIhQSQFY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kVToilbA5cLoZdNmApDvQ6swj63mPKVlVpLjJ8o/yguBmX6YilFO2wn3EFIPOeMDK
	 JNiOsxYvt1+Ij2m0khePWq22WRyLwGDXxf91BmR3+HWX3sBYt+rOr1DlbPdDMB+3pu
	 TV2W80xOa1KTmSa71VyUqzWzex6nfKHOASugf4tL7ROw+tMZ3clDlAUUT4NfcS0Dij
	 ypJKYz6Rp2oUduvEuSzdTE234RU+aCjKT4CmvJ9kCSUqCU6iNqAEWU3J7y74OLm1gu
	 FCj6mH2NuRnQrTh5jLVWyM4jgwYgFEmuzBm9zS2kY0b4tWqVvieNxrUprBupgN1i+s
	 WcBs+N4uN3tUQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 67B09C53BD9; Wed, 10 Apr 2024 06:55:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:55:12 +0000
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
Message-ID: <bug-218686-137361-z9uIcepDtz@https.bugzilla.kernel.org/>
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

--- Comment #18 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
I guess all the OEMs should provide the option to users,
just need to find it.
How about this path?
Advanced-> AMD CBS -> NBIO Common options -> SMU Common Options-> CPPC

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

