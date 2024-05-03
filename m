Return-Path: <linux-pm+bounces-7471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2EF8BA938
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 10:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5089F1F2163B
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7E14A4FF;
	Fri,  3 May 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T694N4kH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241F1474AA
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726182; cv=none; b=JGVyZrbpS1uwmj9GKu2+4zn2p0K32Ylit7cMABr0rao2KOwLby3j32jIczKFoqM4vUUWG8xQQjuOt5dymDnY2nlnouRFkfkUkbig+InngExwN2lTXERT8jJKUy4/Q7vxztPxg4mBe4coq/8ZILb0ksE1jeCg8e4P+EAC/mSKBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726182; c=relaxed/simple;
	bh=AcMFbldTG4tnqcSQ1OWIxPVrT5Wf+Wg72fbhT7y3xYg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VkgA+ccI6uBp4ZlAXRM/xHTH820V5LuUJJapc7HpnssUS6RkCq19VZbtJqELSzuldeh01QkGclx3LxqQi7/iADuoK48OLH9WzjpqWnFLVj7n/Hj/8+D4BbznuVSexke1a6IxaitXqNg4vy021SUf4Fopi0cto+N/ic5Ieu4JSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T694N4kH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D087C4AF18
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 08:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714726182;
	bh=AcMFbldTG4tnqcSQ1OWIxPVrT5Wf+Wg72fbhT7y3xYg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=T694N4kHDSDq/VzNyQxzMGAWSZI0k1nSvACBCSFQ5c73uZnI6JXHZRGAKFv8NsiDG
	 Izp9tzxsGu9BSQrQ+dPf8M8UR7NSQ7/Z1DUOf0aP2sUEGNM50RGBy0qrz2vS2xzsIm
	 U9QDwUGfM6XPE8O2rBAkbLQAALyynCdkRiuojU+ak6q9i6+adF3wqWsURspanZS9bl
	 F8P83rrixhp1HUasdF5Ejvq1sJdOmIpel4d1NLOsylkCCfHXAwBN4ycmJ4jtyoroWX
	 /g9/aaElTPmixBgHPP2jY048rUH6sbwDV+z1jzwKtqQz60j+Q2lAaarW8KW8bacjyj
	 aoGKkySWy3Ujw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0D46CC433DE; Fri,  3 May 2024 08:49:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Fri, 03 May 2024 08:49:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218759-137361-3TjBIEhtqO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #16 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to Perry Yuan(AMD) from comment #14)
> I have got issue root cause and working on new fix patch=EF=BC=8C=20

What's the status? 6.9 might be released in 9 days and it would be good to =
have
this fixed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

