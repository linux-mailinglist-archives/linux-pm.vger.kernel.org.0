Return-Path: <linux-pm+bounces-3152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8871084534E
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 10:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA27290B32
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD8E15AAAF;
	Thu,  1 Feb 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSnsXhus"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA014010
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778007; cv=none; b=g8tpr9JsVL3aajts2Yvxq2IOrldjVHlFSxx1dgu6rSAlBnx0yuDgm6zqn+IG31whsKp0GDNX/N5VJDt+iLI2+lexgqjGmHB2DViHgGVN5Ix1BFEWOKd8YG8srMq3U37/SXUOR9xvCfV8FksHj0msKLDHakXw7xiHRxWYyVMJE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778007; c=relaxed/simple;
	bh=A7xAxogbtp21CFMQ3LViWDtXtyKDKJRHbGevI/XCtks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+Oz8TFxyV4uQIXWeKRn7kQbrEu/EUFGjtHvKL+W/z0UjdoBMygdSXQAmb5DuWajHiFubrO3Nt0x8mOxlFyod+vT3N/1Sfyo63gQi7Gc04oormrwcmtB14sLUi7jVzrpEYTSgOEoygGYc7GnrslfuzJWgauIDtZstoxDaw/1c78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSnsXhus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51803C433B1
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 09:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706778006;
	bh=A7xAxogbtp21CFMQ3LViWDtXtyKDKJRHbGevI/XCtks=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dSnsXhus8JN+rt8KwHgdeTGpzWmpcEckLNKsEwfPKcSh2H0Vfx+2ehfHuIrveA9zw
	 fSNZ74YVW2aH3KKK52jxkjc+WQjSXMHT1e2cLVF78RHXimEQ6v18QO+Kag2SkGovYO
	 CS2AjlAay0X1XIpnECKnXrhf6qdllyM58u4Pzt7N0Y73jXk6wruHgm1DNYoGtjvVTA
	 gIASxISWJfNUM5/INn73LezW5Gi2DQUOZj3nxI7ZF4DbYRzenveSLuFyRIjnlrLdwO
	 JOUmroz6qX06ywgIJVnOdnAkUId62cdOMoxhCjlL64O6Yuq3ibfE9yYvnX0ThU3GSa
	 R9oz+IWCU5QXw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3E284C53BD3; Thu,  1 Feb 2024 09:00:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 01 Feb 2024 09:00:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-QtE8NMp0er@https.bugzilla.kernel.org/>
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

--- Comment #45 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
/sys/devices/system/cpu/cpu0/cpufreq$ ll
total 0
drwxr-xr-x  2 root root    0 Jan 11 00:41 ./
drwxr-xr-x 26 root root    0 Jan 11 00:41 ../
-r--r--r--  1 root root 4096 Feb  1 03:54 affected_cpus
-r--r--r--  1 root root 4096 Feb  1 03:54 amd_pstate_highest_perf
-r--r--r--  1 root root 4096 Feb  1 03:54 amd_pstate_lowest_nonlinear_freq
-r--r--r--  1 root root 4096 Feb  1 03:54 amd_pstate_max_freq
-r--r--r--  1 root root 4096 Jan 11 00:41 cpuinfo_max_freq
-r--r--r--  1 root root 4096 Jan 11 00:41 cpuinfo_min_freq
-r--r--r--  1 root root 4096 Feb  1 03:54 cpuinfo_transition_latency
-r--r--r--  1 root root 4096 Feb  1 03:54
energy_performance_available_preferences
-rw-r--r--  1 root root 4096 Feb  1 03:54 energy_performance_preference
-r--r--r--  1 root root 4096 Feb  1 03:54 related_cpus
-r--r--r--  1 root root 4096 Feb  1 03:54 scaling_available_governors
-r--r--r--  1 root root 4096 Feb  1 03:54 scaling_cur_freq
-r--r--r--  1 root root 4096 Jan 15 01:16 scaling_driver
-rw-r--r--  1 root root 4096 Feb  1 03:54 scaling_governor
-rw-r--r--  1 root root 4096 Feb  1 03:54 scaling_max_freq
-rw-r--r--  1 root root 4096 Feb  1 03:54 scaling_min_freq
-rw-r--r--  1 root root 4096 Feb  1 03:54 scaling_setspeed

You can see, only the last three entries are allowed to write new values.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

