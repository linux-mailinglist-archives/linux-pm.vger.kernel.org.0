Return-Path: <linux-pm+bounces-27076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A0AB552A
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 14:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4877116DC7E
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31DE211713;
	Tue, 13 May 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp4xE2SN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB8D14F70
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140456; cv=none; b=CRLZAsTrySkN0A5eK9ALMNPXSqH99Hpwqblih4remsMQtjNtrWLpqrZwzzcbsgqXIjsl+8IjPsQLQlpi38R2rPII1eVRL1Nv4ycMHQTikb6jgvWlEoeF3+kTG1r1guk7uojGQ28I2zvi7tAad+Bc8542W8OOX11a43cnxzH3x5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140456; c=relaxed/simple;
	bh=Y3m5AWZ6PvyvbhChdtV1d9xtNBtNT1gPRY2yCCkje3A=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gcwC9yvEebk9ACwddk+V8ZM+YQjxrqCfsKGG/PNyuu4F8mxMSKVSS/5xd6M2jLxbGf+uvT+vKLAEd1GFli1X4yN7NF4GcNHESkGwAy2CZxP/9cBXcUMNiNgcd96TgHCCJ+/dF9FjKJ+wOv4X3wf+U6COdfTn0L9BWEnGGH7v13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp4xE2SN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C40CC4CEE4
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 12:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747140456;
	bh=Y3m5AWZ6PvyvbhChdtV1d9xtNBtNT1gPRY2yCCkje3A=;
	h=From:To:Subject:Date:From;
	b=Sp4xE2SNGZNjIh/Ie9eCW3mrCvVcbwxc44NEQQsNVVKn4ZkW1WccpCcWULwWqGYyC
	 acYWebzvVGYGsStgoQ+164O1IGBWbxJvHnQST4AsfQERNeTlcBI07T2w3bQI2ye1Wb
	 M52I8VEE/f01YtO+syDsfiBFcnNwvH+t6F82jSQ2Z3JGmBfM+SG70G9uhHzpn3bOTn
	 H9kkLa+qA7yUzmk8kLaKMdQk913p6BAqu1yPDu02TLJXWFwm4l+fRjmGJ/4YgH3paF
	 OTGeDv7WNStfgS9DdJduqYNRpJ5nvKsiDQbMKoIZoNzzRxRFcUfIGzDUuPc20QpIWj
	 vRD9+GQXbBHFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2D54AC4160E; Tue, 13 May 2025 12:47:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220117] New: cpufreq performance governor doesn't correctly
 apply in combination with isolcpus
Date: Tue, 13 May 2025 12:47:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: robbert.proost@vitestro.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220117-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220117

            Bug ID: 220117
           Summary: cpufreq performance governor doesn't correctly apply
                    in combination with isolcpus
           Product: Power Management
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: robbert.proost@vitestro.com
        Regression: No

During testing on my setup with kernel 6.6.69 I have found that even though=
 the
cpufreq uses the performance governor, it doesn't seem to correctly apply on
CPUs that are isolated using `isolcpus`.

In my setup if have isolated core 2 and 3 set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE in my kernel configuration to 'Y'.
When verifying the used governor with 'cat
/sys/devices/system/cpu/cpu2/cpufreq/scaling_governor' it correctly outputs
'performance'.

However, when running 'cat /proc/cpuinfo' the clock frequency of the isolat=
ed
CPUs is 800 MHz instead of the expected 3000 MHz. For the not isolated CPUs=
 it
does correctly show 3000 MHz. Changing
'/sys/devices/system/cpu/cpuX/cpufreq/scaling_min_freq' to 3000 MHz does ch=
ange
the clock frequency to 3000 MHz, but that shouldn't be needed.

Kernel bootline: console=3Dtty console=3DttyS0,115200 acpi_enforce_resource=
s=3Dlax
panic=3D1 earlyprintk isolcpus=3D2,3 rootwait

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

