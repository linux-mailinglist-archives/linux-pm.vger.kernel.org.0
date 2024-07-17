Return-Path: <linux-pm+bounces-11206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C1C933D27
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896822835A1
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AAE17FAD8;
	Wed, 17 Jul 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CphmN5Wl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060038DC3
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721220749; cv=none; b=FLhQJGe8Xkeb9yqv2On3/FzekK+JS2RqPq+RjgJLu9/dOjTJLdznUzahyEp0UnZT4AwztKeh8doTEu8b3dQ3WkP0HYypp2ebcsHVldBa49MawRnOEpNM/lv0BlQA47PTQnv1RGD7+gQab0BYAZbVwXHWOvlQRSSafaldnYDHNm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721220749; c=relaxed/simple;
	bh=QdTBCleGzWTdZlVSD2RIVnuf2oFhcuY5Akv5ctFpmas=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i72r7RnFPcewvvhUft2zX8lw4u9BPRR9EnzussELraJv4Jx68Pyqrepp7YsCqJBEzbSYwqZRc1oXd6D+GciYKjli24ByNMiHm4EfMyqNCwU98jIkuPzq2os24qoppc3o+uyGGR934D8SKFPnOiEAgNswf4yDfZyudlUojk5t7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CphmN5Wl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D340C4AF09
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721220748;
	bh=QdTBCleGzWTdZlVSD2RIVnuf2oFhcuY5Akv5ctFpmas=;
	h=From:To:Subject:Date:From;
	b=CphmN5WlM0NNISsH3wrt+5R3ICfh3FM3/BMDaizEW9D1N3irWZr3yXwh9puBZnxaZ
	 f1+Ruq+l6p0pvBt44jA1IV47dCigKqABMfuqSM9zgK+hZuIJS2TKKkwuV5zc3glycp
	 +UY7tThsesZFvpb1O7mcuerS7ewogbgiX1WgdHkV2S/LAx3wXWjx8cCZc/hns4fhkK
	 sJABPXUxFltfJOSVxr3nEimcv5GE4xcTBuBz76/+CWShTvr7VYIPF9MyTP5+rzbiRf
	 2DHvQ848a70E2Rp3qZNd6hZAeEWloMpiWxz3yiSUa/PmqhEBm/ZFKVh1skXCYdOeeA
	 2q0kg+3p36gjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 846DCC53BA7; Wed, 17 Jul 2024 12:52:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] New: amd_pstate=active reset computer
Date: Wed, 17 Jul 2024 12:52:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: catalin@antebit.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219051-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219051

            Bug ID: 219051
           Summary: amd_pstate=3Dactive reset computer
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: catalin@antebit.com
        Regression: No

Hello!

I have a ASUS TUF A17 FA706QR laptop. Ryzen 5800H, nvidia dgpu.

I have installed Ubuntu Desktop 24.04 LTS with kernel 6.8 and the laptop
started to reset shortly after booting: from a few minutes to 30 minutes,
nothing in the logs.
Before I had Ubuntu 20.04 with 5.15 kernel, no problems, but amd_pstate was=
 not
active.
Reset occurs by leaving the laptop at idle or doing something like playing =
an
youtube video.
I also tried kdump without getting any dump files.

I noticed that the processor runs at lower frequencies than 20.04, so do the
fans, most of the time at 0 rpm. Temps 50-70 degrees.

I ran stress on one core, youtube play in the same time, cpu temp ~90 degre=
es,
no reset!

I switched the power profile to Performance and it didn't reset.
It only happens on Balanced or Power Saver profiles.

Next step was amd_pstate=3Dpassive, reset only on Power Saver.

The fix was amd_pstate=3Ddisable. No reset at all

Not happening on other Asus laptops with Ryzen 6800H, Lenovo (no Nvidia) 58=
00H,
6800H, 7840HS with amd_pstate=3Dactive, Ubuntu 22/24, 6.5 and 6.8 kernels.


Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

