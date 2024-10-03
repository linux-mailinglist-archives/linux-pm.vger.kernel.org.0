Return-Path: <linux-pm+bounces-15107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC7298F428
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 18:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40BF1C21793
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B0A1A7242;
	Thu,  3 Oct 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYMMfS+M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287A1A4E9F
	for <linux-pm@vger.kernel.org>; Thu,  3 Oct 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972524; cv=none; b=qFCyRshoZRcokWIKALsHFYmNh9h0tTETBAJsOl8X4maIGu0neG+4c6wSUYW7a9+A8FNIvIuusGpQPZQqXKLY0+o8ebQF5LG0oX4rR2l3zGIEmbFWUHmoepKSOm+Ko3fYq4ImFA8zQBpKG/hZg6NhgpDUC+EqbEbAMMOeMqbLWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972524; c=relaxed/simple;
	bh=Eg2CykZAYD7tliWGAL57Q5U/FPLDxJVFV9VqlaK3ii8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hFKBt5wGf70nJUm1CouMn28fVXoKqRZsEFQYkofYy+zs0GYeIG1DErX7mAYvEpc215uujhpAEpnto3Dtk2EHGeIhMUWvSPFyC761oIelDvnak0b0RRCUTynP4IJoz2IK5xSGQvduqqNDdUk4RezY/ZxCJJrUmv18NF/0HGVybEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYMMfS+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ED6EC4CECC
	for <linux-pm@vger.kernel.org>; Thu,  3 Oct 2024 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727972524;
	bh=Eg2CykZAYD7tliWGAL57Q5U/FPLDxJVFV9VqlaK3ii8=;
	h=From:To:Subject:Date:From;
	b=AYMMfS+MvfDBwvXw41lXSujHvwtPO85R08AKFucEb+mOYFiKY4yRogpF5VNvlahQc
	 o02/IuHyrlsRjIM/rUJF4djQoR+dS3YHg3Q/FV8Hsbpm+/T2Ob29a3sU8qmZl5oBKS
	 zCrxx5Vaei4/4mDy0Ro+YLSldeOj+a0rpg7s8qVT3DNMpNF3YTt6z2HuTXgSbkQlFO
	 OtEo2mBW4t+YIevU7zDCFzbhUei0774V4LzW5s4zpyz22NZVFTn22Ihx/yjQYZAX2g
	 jA7M2TV54z9IgT4y3pkzwVMiVB0tgu0gFnvJscfgYR1EgQxhXGDy5BRYYT/Fz/CyX+
	 09qanIO49KHQQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2D38FC53BC4; Thu,  3 Oct 2024 16:22:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219348] New: [6.12] amd cpb boost disabling does not lock
 frequency
Date: Thu, 03 Oct 2024 16:22:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ptr1337@cachyos.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219348-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219348

            Bug ID: 219348
           Summary: [6.12] amd cpb boost disabling does not lock frequency
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: ptr1337@cachyos.org
        Regression: No

Created attachment 306956
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306956&action=3Dedit
Visulizing the problem

Hi together,

The 6.12 Kernel introduces an amd-pstate regression, which makes disabling
boost not possible.=20

The max frequency reported by cpupower is correct (4.3 GHz), when  boost is
disabled but it reaches the max frequency and this is not limited.

I have bisected it down to following commit
https://lore.kernel.org/lkml/20240905163007.1350840-9-superm1@kernel.org/ :

```
cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into
amd_get_boost_ratio_numerator()

The special case in amd_pstate_highest_perf_set() is the value used
for calculating the boost numerator.  Merge this into
amd_get_boost_ratio_numerator() and then use that to calculate boost
ratio.

This allows dropping more special casing of the highest perf value.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.sheoy@amd.com>
```

Reverting this commit does fix the **used** frequency limits.
In the attachments is a picture, which visualize this issue.

Info:
```
Operating System: CachyOS Linux=20
KDE Plasma Version: 6.1.90
KDE Frameworks Version: 6.6.0
Qt Version: 6.8.0
Kernel Version: 6.12.0-rc1 (64-bit)
Graphics Platform: Wayland
Processors: 32 =C3=97 AMD Ryzen 9 9950X 16-Core Processor
Memory: 62,4 GiB of RAM
Graphics Processor: NVIDIA GeForce RTX 4070 SUPER/PCIe/SSE2
Manufacturer: ASRock
Product Name: X670E Pro RS
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

