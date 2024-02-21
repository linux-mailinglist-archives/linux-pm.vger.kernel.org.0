Return-Path: <linux-pm+bounces-4176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF61E85CE99
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 04:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0901C22590
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 03:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C9C2F36;
	Wed, 21 Feb 2024 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhePMXFV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6938F9A
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708485247; cv=none; b=lqBNRuVACF/uFOBxScqP93wYVSsCLoTR5r2S5RI2GzTJyCwWZbNLptJgyK+7yM9lVYWPt/4wm4n2gMTNoJDWlqQhUqxdiT6Ft7OWdLvtWHx6htxhwJgmfAIyiGE05biBZL8uR9BokIPAhofpk+I8NEdXGOPHMUjPSP0RMg4Ml5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708485247; c=relaxed/simple;
	bh=c5veOUgzEGr1H0DDpUsfahWYnZRf5VlkErHFjpbfm3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q+OPPmhIJSUfsMx+Zgc61u9O6rfdXW6ckpkQHkued8A+6B+/0TJnDHAj+vxuPDXVynBPiWvfU01griH6bVq+qauPCR8w95XG0LqKS1IWGGLEpbCQiSN1qmm1Vjyo/l04PMPgNaa9wCyBz3apgyRFpeqdQEb+9CuHDHSbshk4VZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhePMXFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7C81C433A6
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 03:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708485246;
	bh=c5veOUgzEGr1H0DDpUsfahWYnZRf5VlkErHFjpbfm3E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZhePMXFVJdmoI73SnOApVMqFEPho9VJ4NFF9K5MVy8AmXI3neoFBttv3sDErUxwNd
	 ZI/+HQiNrKRJGmtqirKW3ydFYcvhpHC7MfmWEdOA3Ip4AG4CTuJtpuJ65/sr4eLzgX
	 4sI0B9rETR05vs0vgqyXYw985F7ANY4yNSLKmqloI+Qs1gt/NA9lO544KVNrtV7Rqv
	 2aqHfhGKI3ucCcltBV/8UY7f3iSNBNTMBw2HxqRIZjFH6+CfgPeoswInErrSPef81H
	 VNaBo6tw28HcB+qHZgPH8Wql4BpgYX9L2z6WpJEcD6h47LYp1VwY/NtihKtRJBm0M+
	 Xf2Rp4NcAwjXA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A2F3CC53BD5; Wed, 21 Feb 2024 03:14:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Wed, 21 Feb 2024 03:14:06 +0000
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
Message-ID: <bug-217931-137361-C5gHAgRHWx@https.bugzilla.kernel.org/>
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

--- Comment #55 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Sjoer van der Ploeg from comment #54)
> (In reply to Perry Yuan(AMD) from comment #53)
> > How about the output of "lscpu -ae"?
>=20
> Sorry for the late reply:
>=20
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>   0    0      0    0 0:0:0:0          yes 4550.0000 550.0000 3569.5090
>   1    0      0    1 1:1:1:0          yes 4550.0000 550.0000 3552.6860
>   2    0      0    2 2:2:2:0          yes 4550.0000 550.0000 3559.3779
>   3    0      0    3 3:3:3:0          yes 4550.0000 550.0000 3854.7759
>   4    0      0    4 4:4:4:0          yes 4550.0000 550.0000 3590.6599
>   5    0      0    5 5:5:5:0          yes 4550.0000 550.0000 3552.8989
>   6    0      0    6 6:6:6:0          yes 4550.0000 550.0000 3840.7690
>   7    0      0    7 7:7:7:0          yes 4550.0000 550.0000 3584.2910
>   8    0      0    0 0:0:0:0          yes 4550.0000 550.0000 3546.3811
>   9    0      0    1 1:1:1:0          yes 4550.0000 550.0000 3551.5229
>  10    0      0    2 2:2:2:0          yes 4550.0000 550.0000 3591.2500
>  11    0      0    3 3:3:3:0          yes 4550.0000 550.0000 3594.0801
>  12    0      0    4 4:4:4:0          yes 4550.0000 550.0000 3552.0400
>  13    0      0    5 5:5:5:0          yes 4550.0000 550.0000 3572.1050
>  14    0      0    6 6:6:6:0          yes 4550.0000 550.0000 4124.7349
>  15    0      0    7 7:7:7:0          yes 4550.0000 550.0000 3583.7170

The max frequency value is correct to be 4.55GHZ on your system by the CPPC
capabilities reported by your firmware.
4.55GHZ is boost frequency which cannot maintain long time, it can try EPP =
mode
& performance profile, and run some lighter workload, the freq will be reac=
hing
to max freq.=20

>  14    0      0    6 6:6:6:0          yes 4550.0000 550.0000 4124.7349

seeing from this, the freq is close to 4.5GHz, please try the EPP and
performance profile on your system.=20
then check the lscpu -ae output to confirm if it can reach 4.5GHz as well.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

