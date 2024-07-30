Return-Path: <linux-pm+bounces-11688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C51E7941EF5
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 19:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD771C232D0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD732189918;
	Tue, 30 Jul 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJX1fo5M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89203189915
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361235; cv=none; b=rkJh1FGnkpaSZ4hbcAnheQGRC43/BR5rkhq0avQ85S1Bely1cdLOlOyN/37QaQMzE+tlGpMAJ0MqnR9uPDPTtjlSXa8goRhFcNvfOPnSphERdycPH38sIm5adfCIPscIRcRY1my++OEiTzgjy4QHL3LIw0jJXbQAzctHUFQOIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361235; c=relaxed/simple;
	bh=yYoLgPxU4QbaRFugioiSok0dMHTa8CFTrLq6j17qTjI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WxHKRtbpETPHGDMv5anpMBAIGw+VC4q/iO8f5EeZRJIGH5NW2kZEvXoI//Wjx64GPXtuPdShGLeJtfY36VPf5kDOlorlFrV+u8fBOevQVxV1v6AcK8FlQWho9vF7LebAIkS7pxpAwJc/SKbU5JLUHCX/tOC2eYAd3YoWVYDbz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJX1fo5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2333DC4AF0A
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722361235;
	bh=yYoLgPxU4QbaRFugioiSok0dMHTa8CFTrLq6j17qTjI=;
	h=From:To:Subject:Date:From;
	b=CJX1fo5MWavsChY0400wLv45OAzI/9QbEyChSILjNaITGLU906/DYWgoWjffQyZx3
	 938Cqg8u64TkEiUHDayv5V3GH28U62Q9TwaMRyLP29v9FFssGTUctorZryNt+rc3KP
	 PvbXehWK0B2uJ0Y3GTFhCOMoCQUzci1s+aRVW5IrzE/+2Ysu17C1UTPn2OTIRFAvHH
	 NCMjBJC1qeotWgs6rOkf7UtFaeVtyWV9/RdWRrITONQLb0gRRceOsTVeyAMvGwIk8X
	 A0ro/4+CNBuvhQYBEehGCZTk7S4l/A5nxzCtFGk+eEAiwgF0pZBrbRQvr2tSCWc+y+
	 z3qN0ALX1qBLQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1A600C53B73; Tue, 30 Jul 2024 17:40:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] New: amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Tue, 30 Jul 2024 17:40:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

            Bug ID: 219110
           Summary: amd-pstate's balance_performance
                    energy_performance_preference doesn't survive suspend
                    resume
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

On boot I'm setting
/sys/devices/system/cpu/cpufreq/*/energy_performance_preference to
`balance_performance` however after a suspend resume cycle it gets reset to
`performance` despite energy_performance_preference reporting that it's set=
 to
`balance_performance` which is basically a lie.

How do I know it?

Start watching a 1440p/4K VP9/AV1 video with video acceleration on on YouTu=
be.

With default performance I'm looking at more than 14W CPU package consumpti=
on
on average.

With balance_performance it goes down to roughly 8W.

Upon resume with reportedly balance_performance it's back to > 14W.

Please fix.

That's with kernel 6.9.12. If this has been fixed in 6.10, please let me kn=
ow.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

