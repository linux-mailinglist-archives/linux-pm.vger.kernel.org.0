Return-Path: <linux-pm+bounces-7493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EE68BB413
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 21:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E602873EE
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E07B1586F5;
	Fri,  3 May 2024 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVzAA6FI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52973158A3B
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764683; cv=none; b=qqwqm1pM8tNJPams9YDF80IkRfR12SDMN9KXhO02ZIAYhhJh8Zkbt3bkGLoOagiRPC6vYhRPaAtB5VyQqJ0yyxj/4lNdzEIEK1/rijre531A5zFFtVYhG0QVEav1Tql9LXsxSddiRRWLtEQP6q6KV0qx/O3N5U5cnXo2b6AZJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764683; c=relaxed/simple;
	bh=nF/C+g9ztUnCXc/Uq7bixeDsLAC8/fmvOYNiEzitKGA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Iqz939mxt9QULn7c8kOlKz0FpKcc9AyAIkdsl/LWPUibzZP2Dg0VeuIzrVLSgkz2bfsYztjorqI6DTXkSLT1b6yB8qgU4SqJYFlf1NqZWTuhqRo6jUNXiUXBbBN6cwH18MfCmMEbXsysF1rcbtvuJrCZHiBAW/+kz1EO/xrfJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVzAA6FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBB07C4AF18
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714764682;
	bh=nF/C+g9ztUnCXc/Uq7bixeDsLAC8/fmvOYNiEzitKGA=;
	h=From:To:Subject:Date:From;
	b=OVzAA6FIEysCzrhcE/kwqGN8KVuxnnsk11wRUTEZosoppxn+TdxW7hYMZph5EJF8s
	 BKLK100Tdb7Zw09cT6xyB1om9t7yh9M4st/iOCgri3GGJKg+kEWU7sRBlLBBmOPDSE
	 8XAoKGPa9VBsrznW6MmWeIgDlEGMZUORntoX7/mbEnZO4ZcX1R8xtF3u0FHgE2Q9Sj
	 o9YXntewO1OI3IyO6PWfjzisBOgNagvAutX9SsMysNou573Au0iZotqAhd8EwZNroN
	 1S2zKM4D14mceSYQKMqFfBOKkCYTUTNHanHv2gYfIxjRg0K7aUA4Im0zdPNR6uu2YP
	 H+FjCJpm7qWpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BB44EC53B6B; Fri,  3 May 2024 19:31:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218805] New: CPU stuck to low frequency after resume from sleep
Date: Fri, 03 May 2024 19:31:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bogdan.nicolae@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218805-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218805

            Bug ID: 218805
           Summary: CPU stuck to low frequency after resume from sleep
           Product: Power Management
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: bogdan.nicolae@gmail.com
        Regression: No

Kernel version: 6.8.7 #1 SMP PREEMPT_DYNAMIC

Problem: On initial boot, everything works fine. After suspend-resume,
intel_cpufreq policy is stuck well below hardware limits (1.32 Ghz instead =
of
3.30 Ghz), as seen below. Manually trying to raise the upper limit is not
possible.

analyzing CPU 5:
  driver: intel_cpufreq
  CPUs which run at the same hardware frequency: 5
  CPUs which need to have their frequency coordinated by software: 5
  maximum transition latency: 20.0 us
  hardware limits: 1.20 GHz - 3.30 GHz
  available cpufreq governors: conservative ondemand userspace powersave
performance schedutil
  current policy: frequency should be within 1.20 GHz and 1.32 GHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 1.10 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
    25500 MHz max turbo 4 active cores
    25500 MHz max turbo 3 active cores
    25500 MHz max turbo 2 active cores
    25500 MHz max turbo 1 active cores

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

