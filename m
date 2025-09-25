Return-Path: <linux-pm+bounces-35392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0064BA0829
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 17:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B12217A234
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704723043C8;
	Thu, 25 Sep 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVfYkQ4A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54A302CC0
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815966; cv=none; b=KckySQfxmtEo18ElJvR8twXwcCRXErUzuz7LO9xqmjt5/GZ27sdB8ClGkghAlPgsmLXkVkXZUw67RFwmfWWBeW9shIyL9ZzJAMSqQQ4R9nWsfaPimgpoDsjk9FrvAi7IESyK9tUYaEQPS8FvMRnafTd+/NL5LAvS2a4BsAhm6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815966; c=relaxed/simple;
	bh=1qVpIW/qhyQp1NzMcZoqBdC2H/v/64nZZsBZmTWFik8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzDPBTqOIV7GkbHMyGM2VNJ1/IWips/aPbkqW0q+WcWoNfZ+Ws3/Xoh6zNm3Jec0bR2QkvXXUW2biLqHm6WJ4jExGYGJTUvMezO7a2vEWd1u67GGnRKdOKK8MIv5RklY9GdqvhA8cB8pTBiTWMT3xJIirJ8fl37JLKUGgGqJIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVfYkQ4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53393C4CEF5;
	Thu, 25 Sep 2025 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758815966;
	bh=1qVpIW/qhyQp1NzMcZoqBdC2H/v/64nZZsBZmTWFik8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVfYkQ4AigyKfPmaizC/twS4QDMmckiHoN3Fq4uLxKYYMmhNj+d4e6glkrsuTVyQp
	 neRBEMUIu+34rsK2JUq4+D3CQWH0VFkvoEUpcZ17FisaMryHQVMfACNE+rOxU8eTDN
	 Q/H3W+Nf0XjKYL2uYnPjo4Z7gCAQbhkc5ZG563zeUY9vp64P+tTPYdcp24A9FiOV47
	 +o9+f9+T7cQPMoFAVivJB+QqIJltpXmKKQtrc3QRT7H+K7z1onW4UaXI4U8AijFTuk
	 44k+WCQVWtRinvbbfEpxwwZHqOmw8LJNXSjQgeMoc7J+FJhmhInrQqlise10tNU4qg
	 f3qTXeLGAlyjQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	Kenneth Crudup <kenny@panix.com>
Subject: [PATCH v2 1/3] PM: hibernate: Fix hybrid-sleep
Date: Thu, 25 Sep 2025 10:59:16 -0500
Message-ID: <20250925155918.2725474-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925155918.2725474-1-superm1@kernel.org>
References: <20250925155918.2725474-1-superm1@kernel.org>
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
Tested-by: Kenneth Crudup <kenny@panix.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * Move under CONFIG_SUSPEND scope (LKP robot)
 * Add tags
---
 kernel/power/hibernate.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2f66ab4538231..52c1818749724 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -695,6 +695,7 @@ static void power_down(void)
 
 #ifdef CONFIG_SUSPEND
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
+		pm_restore_gfp_mask();
 		error = suspend_devices_and_enter(mem_sleep_current);
 		if (error) {
 			hibernation_mode = hibernation_ops ?
@@ -862,7 +863,15 @@ int hibernate(void)
 				power_down();
 		}
 		in_suspend = 0;
-		pm_restore_gfp_mask();
+		switch (hibernation_mode) {
+#ifdef CONFIG_SUSPEND
+		case HIBERNATION_SUSPEND:
+			break;
+#endif
+		default:
+			pm_restore_gfp_mask();
+			break;
+		}
 	} else {
 		pm_pr_dbg("Hibernation image restored successfully.\n");
 	}
-- 
2.43.0


