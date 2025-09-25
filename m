Return-Path: <linux-pm+bounces-35412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E65EDBA113B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 20:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D308C7B987C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 18:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0E93191D3;
	Thu, 25 Sep 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzgFWPZm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ADF218ACC
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826277; cv=none; b=CnI7dsrdfTSpOmmGeZx1GKkr+REQHts1GlUBSqF7Dq8HTfVXY4u84e7AIgvLerVJ+8iHHvzeVNWoIK3JenumQo6wzXIV7gzqFUxLIDtXBxc1hxXeoseChvPNkT+qDTmj1DI7u0YSPy0rwYjF52EHMGJ7B8frMbEFnY8o2/PwUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826277; c=relaxed/simple;
	bh=0HDVqTQaim5C4kfGq9KY4W5ZIXHRhxYWm2ylHFBOdqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HntqDayCRnpnAuD5qIj45quPObjVSc94ZSDythLGuJaR69Tq2J0PitmIGDX0QkFerDypf6w+0+Z+G14WH7INL9+/i7LPivR16SGQ3ocmbt74fegmsU3wMn2XCEtU5PkYo/d1jOHsHsxM9Zt3vRs+53iylDtzURlf0+dTS/7+jLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzgFWPZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E615C113CF;
	Thu, 25 Sep 2025 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758826277;
	bh=0HDVqTQaim5C4kfGq9KY4W5ZIXHRhxYWm2ylHFBOdqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzgFWPZmCgJEJEz7LUV6eeWebhDeF3Iuc/ciGokXiAIecx1PvZ2F+77NfGDgE4m51
	 qcQLXPOjA7vL5eWratiVfMH2ktTq/rpS1vEKVzOLijXIO9oiumPnsL3BGQEDBo5q86
	 Z40cqvLeYI8B2t1mOucVQ2J+Ldc7X/2l1PyzKJVtoO06UoCF6w3b7cbWc3lJoreknQ
	 rRiL0/sLwRFJhD+GPFc7AKbOw6mOgrs8AgsJgEcHUOkn8cSumnXEXbHqA1twJ2ppHp
	 bKubCzAop81ujVh1nIIPif10Ny4/WkIQVxUdzGSWGnHtrT2wZBilf/whgdAqP2PkHN
	 ZNBqmJs+dIdiw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	Kenneth Crudup <kenny@panix.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 1/3] PM: hibernate: Fix hybrid-sleep
Date: Thu, 25 Sep 2025 13:51:06 -0500
Message-ID: <20250925185108.2968494-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925185108.2968494-1-superm1@kernel.org>
References: <20250925185108.2968494-1-superm1@kernel.org>
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
the suspend sequence starts. Add an extra call for pm_restrict_gfp_mask()
when exiting suspend so that the pm_restore_gfp_mask() call in hibernate()
is balanced.

Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend sequence")
Tested-by: Kenneth Crudup <kenny@panix.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 kernel/power/hibernate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2f66ab453823..3c6b110ee9b0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -695,12 +695,15 @@ static void power_down(void)
 
 #ifdef CONFIG_SUSPEND
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
+		pm_restore_gfp_mask();
 		error = suspend_devices_and_enter(mem_sleep_current);
 		if (error) {
 			hibernation_mode = hibernation_ops ?
 						HIBERNATION_PLATFORM :
 						HIBERNATION_SHUTDOWN;
 		} else {
+			pm_restrict_gfp_mask();
+
 			/* Restore swap signature. */
 			error = swsusp_unmark();
 			if (error)
-- 
2.51.0


