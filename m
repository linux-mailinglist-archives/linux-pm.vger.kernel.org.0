Return-Path: <linux-pm+bounces-16533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C759B20EA
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 22:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A511F212E1
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B3F17DFFD;
	Sun, 27 Oct 2024 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYf7oh8x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB3538A
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730065807; cv=none; b=A9+oTpX4mH3XzClIwWQN/OapCb0A4P9H325Di0gfReIIPIXyIQJf+hBx68XnuZFvhAQIoobxT2vdf9tNHljYK6s9Rke1V8Adm4okO2Pb1V5FSDTL8CC1Y2Yx0dtp08VJVeduHeZRDdovcMtCOEbxdfbrkVxr4+vSPSPM81U7hcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730065807; c=relaxed/simple;
	bh=8sEn9bVSTd4yeEKG9YKSB+5FcQ9XCn3K7pLiWNNPzdE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/L5i2WJG9/iuEgYxAdD26Jvu/EyloZ84dRR/xbpIfEaad1tehLY5eYmt3UM6gZqBCQEYCqakUqKZH9uUXLjF+JFQfQwmH7N81xTjuj3LEzbzsiPv3gqfe06s2mDux4D3uk5wCz3Hhxzg79pMP2d4HGXvdU/jS7cn7cziOBiz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYf7oh8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7CCAC4CEE4
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 21:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730065806;
	bh=8sEn9bVSTd4yeEKG9YKSB+5FcQ9XCn3K7pLiWNNPzdE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TYf7oh8xV3gDP2COPxkG5fkKSLz3H3cJhN+mWRqZnkNOupOQoYG55sXCg+upsP3MT
	 zoTHuOseBgqCfyiLCFUNvsaqBAthiMwa7oFxDDejZZ4f9LE9oWxFQtK8cqG0xtKpaH
	 NveLjwJRohXTsh03vvRRq7qI4zoMOlfrp7UBBi0NvGmADl36U/B6kMOYOtST9Zr6se
	 1o+Jwo34Tuo4vJ9BeW/dK18F0RVK73tlze2JKHDlmiKEHcE2vedMmej0THZ75Z9Y8k
	 6F1KzI8EsfUTmBvwSnAjppdr6jKznCTS4fJt1i1rVvCX2pt2qgeGsi+lHG2enVNXIf
	 w4bJh/eAHLgDA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B955BC53BC4; Sun, 27 Oct 2024 21:50:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Sun, 27 Oct 2024 21:50:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219431-137361-dYrL2G9GPO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #3 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Can you repro on 6.12-rc5? Can I please see kernel log with AMD pstate dynd=
bg
on the kernel command line for your system on 6.12rc5?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

