Return-Path: <linux-pm+bounces-25429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15BA89309
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 06:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D5017F477
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 04:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69762238C36;
	Tue, 15 Apr 2025 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZreBX+qG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45101238D2F
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 04:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744691814; cv=none; b=Ts3Ca6tqs/Je34pjdt6FC1hBoyJ0WmenvGXX9gaa7WVJMGLlyKEzfuJhMeBS/+XikdtwS6btX4w4xJSVHBCg+6btI5Y4MfN6ReBxyxbFtKROFF6amCyqD1XhMPUma0eeIV4VzMw3XZt5DWUaTlsFEitR+IyxEr8dQ9TU92C+JVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744691814; c=relaxed/simple;
	bh=shpfcYUiweoKMsOsk6dyHEqcrlJ+1nZzlRfOKbm31L4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fQ/msZVE3/uVhfFzJmVLJ8lEpTOaKsDWoSN2ko8NpK8RxMLLhaJiywbF1HDSlhx45++btEoo/9ocGDMn77+ovseDC5lPSwWPI1ZAL9le0Yh1brLhkJcR42ytNIE/o1TYxtIz+tpy4bDxQpahCmIHprcIa/a96tl30qP3wW2JCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZreBX+qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A855AC4CEDD
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 04:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744691813;
	bh=shpfcYUiweoKMsOsk6dyHEqcrlJ+1nZzlRfOKbm31L4=;
	h=From:To:Subject:Date:From;
	b=ZreBX+qGNbbjdnAAQHZ3Vvbw2o0dS9iLVb5Umqs/AnlDYCTIWQhFWmQ67RundU2YK
	 ezZgfha+Px/K7SFtECz20A+1Ey9D4PeuZJzh2dKCR8AgvCYLprNPgCwPX+t49fMd50
	 /AR1X3NE+7iz+YJ7Z7tSeediKslNsa/flCwjB2OiLhRbXIqBV1elpa82AqEMo0BoGr
	 8gMs+yucDkMGyf8yZ9tpHsrjeadD0ceQrAutSs32CMOOXf3aXnu3OaLykFZ9H3Cofr
	 B92c3wCEmKZqr2letMhC+8vhOeaq1ra520Zos/Nx2Ml2BLUBwhgVAXpT1hudCP9f8S
	 b9FR/rIbDK1RQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 98D9CC4160E; Tue, 15 Apr 2025 04:36:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220013] New: [REGRESSION, BISECTED] acpi-cpufreq: Boost
 disablement not being restored after resume from suspend
Date: Tue, 15 Apr 2025 04:36:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nic.c3.14@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220013-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220013

            Bug ID: 220013
           Summary: [REGRESSION, BISECTED] acpi-cpufreq: Boost disablement
                    not being restored after resume from suspend
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: nic.c3.14@gmail.com
        Regression: No

On kernel 6.13.8, disabling boost by setting
/sys/devices/system/cpu/cpufreq/boost to 0 would persist after resuming from
suspend. After updating to 6.14.2, the system is able to enter boost states
after resuming from suspend despite the boost flag still being set to 0.
Toggling it to 1 and then back to 0 in this state re-disables boost. My sys=
tem
uses the acpi-cpufreq driver.

Hardware: AMD Ryzen 7 2700U

Steps to Reproduce:
1. Disable boost by writing 0 to /sys/devices/system/cpu/cpufreq/boost
2. Place the system into S3 suspend
3. Wake the system. /sys/devices/system/cpu/cpufreq/boost` should still be =
0.
4. Place a load on the processor to cause the system to enter a boost state,
such as running `stress -c 4`.
5. The processor boosts

I have bisected this to commit 2b16c631832df6cf8782fb1fdc7df8a4f03f4f16
("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()").

This issue persists with mainline master (commit 004a365eb8b9 ("Merge tag
'erofs-for-6.15-rc2-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs") at the time of
testing). Reverting commit 2b16c631832d restores the previous behavior (not=
 a
clean revert; needed to merge with be6b8681a0e4c1477a2c1cb155f7b9188aa88acb
("cpufreq: acpi: Set policy->boost_supported"))

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

