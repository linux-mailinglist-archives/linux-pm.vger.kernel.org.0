Return-Path: <linux-pm+bounces-9015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E89051E1
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889422831E2
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 12:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20488168C3A;
	Wed, 12 Jun 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYrFV/KL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC57156221
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193672; cv=none; b=gJ1odr8BrkF0GQCOtXRIzQMcETVJe4EWtPpqPGXfBf6vTE1fh5RSxwbxutPJj/rsGKaVxLWaNIUXjYpbnfxwpIsHGNYe8HBiV7jzYUi/PtRcz5FFbEbvBJnm+ihrdIJtd4LIznh/1jHAeUqEOTynlNjkSENTP+EKks6wneFKfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193672; c=relaxed/simple;
	bh=2g8RTokAD6/6nDcfJi2b7LgsPt7rLDy7TqRzepO2TAc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O4qjX8r4hSvVEwNshhc8OVHzZ81uLc0Rc8lYlgPQwug0nChN+JKchAQhxhdUrYSMr4FDCWUnzx8o9CgheKIXbqY830iJ+LTx8o3NbXVkrSd8iHdxApRcuzVsNWXUzfxyJJCHAdPR2UjIinAJsPCmSbwRDUN5rgWMEUyZezlcv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYrFV/KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88410C4AF4D
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 12:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718193671;
	bh=2g8RTokAD6/6nDcfJi2b7LgsPt7rLDy7TqRzepO2TAc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZYrFV/KL5rLliezWJ37vcdkt9VozRoYCr+ZUMUQV/KdVRIpKf1lYXWoT23wjEoLfu
	 svSsSZnk0dYivNXV1ez2RPkXvIy1h9o7xZK4OsVhz+i8vM/eFdqsEQHtJfO5xSXTzS
	 5KEHUn//OHu3NTfMuTTmrCaCGI6Ex+ALrOPChbbOAR7pFJt/xlJ2qbTg72baDpEBGW
	 dwf5iVueAJp6dyT51ROshU5rw5Sst5WCb4IGEELp339meexqn7B8UH1Fd23RtMWFwc
	 xdAWNb068KaXZruaQKY1EToBd+wP/mwGkZyDEBhTHJJdMJ/WrEZfy5wAXX3d7QtIrr
	 KnkuSPxIIMcyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 78409C53BB9; Wed, 12 Jun 2024 12:01:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Wed, 12 Jun 2024 12:01:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-XA1YZUaGc1@https.bugzilla.kernel.org/>
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

--- Comment #60 from Artem S. Tashkinov (aros@gmx.com) ---
Under Linux 6.9.4 the amd-pstate driver doesn't adhere to the maximum set
frequency for my Ryzen 7 5800X:

# cpupower frequency-info
analyzing CPU 10:
  driver: amd-pstate-epp
  CPUs which run at the same hardware frequency: 10
  CPUs which need to have their frequency coordinated by software: 10
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 550 MHz - 4.93 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 550 MHz and 1000 MHz.
                  The governor "powersave" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 3.54 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
    AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.93 GHz.
    AMD PSTATE Nominal Performance: 128. Nominal Frequency: 3.80 GHz.
    AMD PSTATE Lowest Non-linear Performance: 59. Lowest Non-linear Frequen=
cy:
1.75 GHz.
    AMD PSTATE Lowest Performance: 19. Lowest Frequency: 550 MHz.

# lscpu -ae
CPU SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0      0    0 0:0:0:0          yes 4929.0000 550.0000 3124.8250
  1      0    1 1:1:1:0          yes 4929.0000 550.0000 3585.6809
  2      0    2 2:2:2:0          yes 4929.0000 550.0000  550.0000
  3      0    3 3:3:3:0          yes 4929.0000 550.0000 3554.8350
  4      0    4 4:4:4:0          yes 4929.0000 550.0000 3434.6189
  5      0    5 5:5:5:0          yes 4929.0000 550.0000 3589.3491
  6      0    6 6:6:6:0          yes 4929.0000 550.0000  550.0000
  7      0    7 7:7:7:0          yes 4929.0000 550.0000  550.0000
  8      0    0 0:0:0:0          yes 4929.0000 550.0000 3377.0410
  9      0    1 1:1:1:0          yes 4929.0000 550.0000 3545.8970
 10      0    2 2:2:2:0          yes 4929.0000 550.0000 3487.3730
 11      0    3 3:3:3:0          yes 4929.0000 550.0000 3185.1221
 12      0    4 4:4:4:0          yes 4929.0000 550.0000  550.0000
 13      0    5 5:5:5:0          yes 4929.0000 550.0000 4315.6221
 14      0    6 6:6:6:0          yes 4929.0000 550.0000 3148.2390
 15      0    7 7:7:7:0          yes 4929.0000 550.0000 3555.2141

---------------------------------------------------------------------------=
------------

And it's even more confusing since we now have:

1. * /sys/devices/system/cpu/cpufreq/policyX/scaling_available_governors
  performance powersave

2. How is it related to=20

/sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference which=
 can
be of=20
default performance balance_performance balance_power power?

3. And what's the "default" state?

---------------------------------------------------------------------------=
------------

It's all so simple with acpi-cpufreq :-(

1. I can enable/disable boost (not possible under amd-pstate on 6.9.4)
2. I can easily set maximum CPU core clock frequency (not possible for Ryze=
n 7
5800X under amd-pstate on 6.9.4)
3. I can set governors (performance powersave ondemand conservative)

With amd-pstate it's a huge maddening mess.

I'm going back to acpi-cpufreq until 6.10 at least for my desktop.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

