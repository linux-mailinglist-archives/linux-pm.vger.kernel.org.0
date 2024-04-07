Return-Path: <linux-pm+bounces-6021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C148489B37B
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 20:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BA11C21481
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 18:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5D639FFF;
	Sun,  7 Apr 2024 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtSoiQby"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313833BBE8
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712513467; cv=none; b=hTDLGJQpR+n1hnxjDw6fn2Do/7m317YEtpUNVhc6hJRBxwrmkQQWOS6SOAr9mY0IV7/mOdUWoou8EO1WqXh3hGHANBvUODG3DIvatmIbwg8SYuHuT7Wv/sa+S7PQ7yPTvnfp1lBsejmziiXP13pGYUiHy4njBtVy5b1Ijk6pGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712513467; c=relaxed/simple;
	bh=JE4BNdze4aJzT6mWtqkL2z8m/TpjD1fS6pgqjwKPXUM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ChZPKcwTxpz5h/9Ouw2X1HIn4axyRlvahKaJWg5SP+J+gEcvK5Pyc1T1VyxZVw4AtfVM+D+FPhSNM568MjGkPmvRN4U3QJkiuGRLpqeHPBCUYK3Z8y33lY1M44VNylfgfRE74G3v9vFkyUX1/+Gjbb2Fw28al4HaEYgo+IP6xfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtSoiQby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD159C43390
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 18:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712513466;
	bh=JE4BNdze4aJzT6mWtqkL2z8m/TpjD1fS6pgqjwKPXUM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DtSoiQby4KNaBaWtgFYVTHVnb3FgfDz9Kj73xLQK5X/IoW5VAoiE7z3abG9ZabJRv
	 btfZPiSjTPkU9sIfKhaZVu6maQenpoCKlq6QPUCJo8sdn78+F218GCPCNeQS8ayXuU
	 Si0nArgpbdovlMfVm+/Op3ScsvhmsDMqUQ09dudFqOayNfbh4FiXzyXYinSVMKgcZ1
	 vp/2MXP9nW3Zqg1ZOcwJDUh5fWIFHg5uCTaDoIVwv82bElFGgf1WdukDse+/S69okn
	 G/p14Ok9k3ZttHQv5ZbjL2mUxS73k7b8vzuPpszcgSpOWgD2fbxFvtBI2civA076dF
	 ABYJhDgmbuoSQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C8DB4C53BD3; Sun,  7 Apr 2024 18:11:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218689] AMD_Pstate_EPP Ryzen 7000 issues. Freezing and static
 sound
Date: Sun, 07 Apr 2024 18:11:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kbii.chris@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218689-137361-lLTywK3efE@https.bugzilla.kernel.org/>
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

--- Comment #2 from Christopher Bii (kbii.chris@gmail.com) ---
(In reply to Artem S. Tashkinov from comment #1)
> This is extremely unlikely to be caused by the CPU driver.
>=20
> Please try resetting your BIOS settings and not using any XMP memory
> profiles first.

Few things I have done:

- Reset bios to defaults
- Updated Bios
- Downgraded bios
- Disable xmp profile
- Set/unset typical idle usage
- Tweaked nearly every setting in the bios over 2 weeks
- Replaced motherboard
- Replaced ram

Kernel params passed:

no_rcucbs=3D0-$numcores
idle=3Dnomwait
iommu=3Dsoft
acpi=3Doff

Absolutely nothing worked.

I had tried testing around different governors but had never tried using the
passive amd_pstate mode. The one thing that caught my attention was the
asynchronous power management parameter being off. This to me seems like the
most plausible cause of the stuttering.

The one thing I am absolutely certain of though, change the cpufreq driver =
and
governor 100% makes a difference. Exact cause needs to be further investiga=
ted.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

