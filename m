Return-Path: <linux-pm+bounces-40334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD946CFB353
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 23:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58A0301B82B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3C29A9E9;
	Tue,  6 Jan 2026 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzmRYt2m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C422A1D5
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737340; cv=none; b=iDeFbkqMFdJtS0QGFEZtZcH0uXc49ZDBnlK0lv80KYmHOtegsezkEWK4oBQn0TyhlkXL0eD8/OxsnLwP6Ys/Q+ScM3mgWwLQgq89fnzozYiDHIdXDCG8QjppM1+OYid9gnl2WT1kVZzG0XA/2e/E28ejL/9fH1yx7R7b7JhzuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737340; c=relaxed/simple;
	bh=5zed443W9vBWiELX1q4r+46AsCBwngL2I2092PCD1BE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pj6bzeJb/mJetrPj6s9N3Z4Li4rJuZvWCX4euwGSMGv3KapGbbjLDgeb5rCDDL8jE3DZHefsE3g0c/4uRW96R3JB58/8K+UjVxJMuzR88Sjo0U8GMb/BbOQiwmGhP3yOZMmFGEwg2JUh0/3wsLhTL7WiPF2Y3bWAwGBXqYAWrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzmRYt2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E9C8C116C6
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 22:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737339;
	bh=5zed443W9vBWiELX1q4r+46AsCBwngL2I2092PCD1BE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FzmRYt2mkGjhdyyjZ8cn15OMdRI9peh/XpyLRc5+an7kIygcl/AWIyZgF14/nd5wQ
	 +bLxl5iRhUq9QF0LrRf6qwhxKuPY2cXakmqxJzkOMmvE0J6FH1/FM7ACr4UwtQ0Aba
	 Z5Hnm1i+EV2HhiRKLDuwi9eJVLwtVdRO9DHFBqLBOGU2zh/5I6MlXxh60NpgWbRZ2M
	 U+7uSD7wA/Ot7tGpLt/Ctk/05bVhFL+lecVdGc5Mp4rDnTiQrzwc/ALeB1Hk/ohtom
	 qu0x1JhnD+Wz5pGggFoDJQQNXmgKus1+IphuiVnpugcRoILHFm2lDHiejfpp6AFY03
	 1SiEo2/HyC9RA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 22504C41612; Tue,  6 Jan 2026 22:08:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220946] hibernation seems to be broken after commit
 bb31fef0d03ed17d587b40e3458786be408fb9df on v6.19.0-rc4
Date: Tue, 06 Jan 2026 22:08:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jpeisach@ubuntu.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220946-137361-sFCJvg2rKy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220946-137361@https.bugzilla.kernel.org/>
References: <bug-220946-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220946

Joshua Peisach (jpeisach@ubuntu.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |UNREPRODUCIBLE

--- Comment #4 from Joshua Peisach (jpeisach@ubuntu.com) ---
Annoyingly, the issues are now unreproducible. I swear I'm not crazy, but h=
ere
are the new dmesg and acpidump. I did not upgrade BIOS yet, but it's working
now even with the patch which I thought caused a regression.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

