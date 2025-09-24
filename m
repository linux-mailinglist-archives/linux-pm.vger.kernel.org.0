Return-Path: <linux-pm+bounces-35306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE659B9C32C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 22:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34BF1B27EA9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 20:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2E724DD1F;
	Wed, 24 Sep 2025 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDLltrMr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E622AE65
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747141; cv=none; b=cqvqNyQhyLQPcj5HVs03NSjE91jLxIaEpzpfSGwlCa4tIUS4qitM2VVcsLD1uy8+sFfK1iQfys1TbTOjFhh2WUHjw3+yg/eOi7htscBdzEoMVbAODfm6RoGIwV2DNRPqZ9akDg8M+1Ee0yGMk7gb3OBo12vI7zyrarnPGCmdXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747141; c=relaxed/simple;
	bh=EWCxrLxglxq/G+xYlkXSA22/IJeat/PFPXgrltaJZqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbpmks4CZsWELE5LrxFjoqqrqXf1gysN5nhcyinZOoRzv5C4F3xjahVLzbjHJp0lzsX1U5QBZ1MdlRlnrl3IxyorJ7QBJMIMu4hBSWm1/zKgZCLj9YAYhfJqd+AR/fwIkW4Zz68mkrk7VwfmKD/MINQ0U7NzL7TNP++NjlONrec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDLltrMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4059DC116B1;
	Wed, 24 Sep 2025 20:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758747140;
	bh=EWCxrLxglxq/G+xYlkXSA22/IJeat/PFPXgrltaJZqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDLltrMrPnCeJYUgfOgpgN4QcGaKFS6WjMLSItmd+UEx2aKpS9hknhTblxpIxkofo
	 DrCTdMKPwADzzHB+cHTOJ2QUg+JuG9HRxzCI+15qJNkl5q0/HrfFU9fWk0OF4U+D4D
	 LS80qWoJ0RdAr87goB+Q/D1J0xsPb9lkCEHxP6zet0iGtAdBMX6AqBFFd4YPJIM16H
	 Hiy1R5vWR7z2u6a1xC/XjmBrDYrDtfL/YD9rXNyB84xusJkZsDQWy+nTPqDz1xVVEi
	 OWbKAdTB93swpAGXqYCckZYwrg6JdQRQkR9+kL7lMqQkF8l2KTl2OKYIuXfNX80GoD
	 zwvIMWsaYCJRg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH 1/3] PM: hibernate: Fix hybrid-sleep
Date: Wed, 24 Sep 2025 15:52:09 -0500
Message-ID: <20250924205211.1059571-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924205211.1059571-1-superm1@kernel.org>
References: <20250924205211.1059571-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hybrid sleep will hibernate the system followed by running through
the suspend routine.  Since both the hibernate and the suspend routine
will call pm_restrict_gfp_mask(), pm_restore_gfp_mask() must be called
before starting the suspend sequence.

Add an explicit call to pm_restore_gfp_mask() to power_down() before
the suspend sequence starts. Don't call pm_restore_gfp_mask() when
exiting suspend sequence it is already called:

```
power_down()
->suspend_devices_and_enter()
-->dpm_resume_end()
```

Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend sequence")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 kernel/power/hibernate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2f66ab453823..1defe8081e64 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -695,6 +695,7 @@ static void power_down(void)
 
 #ifdef CONFIG_SUSPEND
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
+		pm_restore_gfp_mask();
 		error = suspend_devices_and_enter(mem_sleep_current);
 		if (error) {
 			hibernation_mode = hibernation_ops ?
@@ -862,7 +863,8 @@ int hibernate(void)
 				power_down();
 		}
 		in_suspend = 0;
-		pm_restore_gfp_mask();
+		if (hibernation_mode != HIBERNATION_SUSPEND)
+			pm_restore_gfp_mask();
 	} else {
 		pm_pr_dbg("Hibernation image restored successfully.\n");
 	}
-- 
2.51.0


