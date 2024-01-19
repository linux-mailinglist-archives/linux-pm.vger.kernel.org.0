Return-Path: <linux-pm+bounces-2354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E0183229F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 01:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DC21F21F5D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF8182;
	Fri, 19 Jan 2024 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGaSBV19"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19A63D
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623827; cv=none; b=gz/dd6FDJf1nnbdn6ZFE4K78+ZF8ci5Vfs8O7stCBrNsHv65MGFnFn8wX8kIAQ5V7S0WvgG190TWlKHKUtUrKr4jmIYe2xhacgQnDrKT2xUZT7l5/0qp3qyk3ZkiDN55jlTA1IXjh+l2mqlSDWdwVSNf7EgHrTS+cag1x2d1t4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623827; c=relaxed/simple;
	bh=L0xCNofjzfpId6Id2n6a9JZo2+jdv2wGeu02BhtSLjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KXak+Si35GJC2vorP4DkX97O9upxiMpsUF0v/hxkzByX5+cxgxKiGsrFX8EZ/mxAO1cBCpIS9N6qqJoOSBYThOiOJM6R+AZqsoqppa6ilPPciRG87hSOSAZKrKfs+oRL2N2iU9Aq6YwVbfLIBDOvChRtey1uSSsNsgk5cx143vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGaSBV19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3051C43394
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705623826;
	bh=L0xCNofjzfpId6Id2n6a9JZo2+jdv2wGeu02BhtSLjY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rGaSBV19Zj3+WDP0h3V/aTf2nG6GwEGXXI9Eo1bq9TeejOuMmSeFyjVlTmveGP+/d
	 clqxz+tLY6FKV8sPgM8Efs4b0O8TcYXBNGGWLVI5ahtgVh0ts1MGHFqcux78SBQl8G
	 RHfpHAfwb3276WpmlLdEUZsBAk52OsTA4rklgSureebSh/1aX3g49lwSuklMJ2JqBc
	 EfiXb/hFOVaYyscgSpGhh+qgp/g8ZfZ0OCGuHHm2b3ZJ6tC7ma8LQF2DXUCwGGPa65
	 sJe/Ow7tHp8HWy/7hB7obYFlWx5u6fowXWV5KYzW+K0yZmyOX3E77gr2ka8MBm8FFP
	 uPsOPnEejH4JA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8F813C53BD2; Fri, 19 Jan 2024 00:23:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Fri, 19 Jan 2024 00:23:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alex.delorenzo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-BHRebdqOob@https.bugzilla.kernel.org/>
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

--- Comment #27 from AlexDeLorenzo.dev (alex.delorenzo@gmail.com) ---
(In reply to Mario Limonciello (AMD) from comment #16)
> When you say getting stuck in lowest supported frequency does it resemble
> bug 218305 perhaps?

Looking at bug 218305, I haven't noticed if the issue is triggered by
suspend/resume or restart cycles. I'm on a laptop that regularly goes throu=
gh
several days of use before being rebooted, so it's possible. I'll keep an e=
ye
out to see if that's related. From what I experienced, the issue would occur
while using the machine for a few hours, and the issue would "fix" itself u=
pon
a suspend/resume or restart.

As far as similarities to bug 218305, I'm also running a Ryzen APU (on Zen 3
and not 4) on an HP Dev One, which I believe is a modified Elitebook 845 G8=
 or
G9. However, I've been told by HP support and the System76 team they outsou=
rced
the project to that the firmware on the Dev One was custom written for the
project and unrelated to the standard Elitebook line's firmware.

I also use `ryzenadj` to set STAPM, PPT FAST and SLOW limits. Like in bug
218305, I also leave my laptop plugged in the majority of the time.

When I experience the issue again, I'll look at more diagnostics to see if =
it's
like bug 218305.=20

> What is your CPU scaling governor when it happened?=20

I use the amd-pstate-epp driver in active mode, and alternate between the
powersave and performance governors depending on whether I'm on battery pow=
er
or not, and delegate that switch to power-profiles-daemon versus using sysf=
s.

It's happened while on AC power, so it is likely I was using the performance
governor when I experienced the issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

