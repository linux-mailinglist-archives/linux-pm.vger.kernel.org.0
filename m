Return-Path: <linux-pm+bounces-26904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9EAB054E
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 23:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41A13BE1A9
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862022068E;
	Thu,  8 May 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K06CZksq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C402206B5
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746739110; cv=none; b=GB5gxlfI/znYfzTe7kYF5aQNjmWxutclEG3iUqEMq/H9/eLK0qc0f+75c/oBnVVqwluatLXGFcny0z2oQYVeTdBS71HLZKKil8t0YvvC9OSZ6xWv+4Gry2q6J4PoWVLjXK0G7xczgryIUAS8o8zVp+OLwSKlYfJ5mkaPA9TjTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746739110; c=relaxed/simple;
	bh=ITJBbvxO1iSak3FKMzKC0shGtp98+4dJk6zyaV+KLTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnKKBZJ8GVMeDeSXldfdgKQa2FenGnkG0mZgV2F3ygc2Y2/HltRj6Vhesh7skBmjgTxw0SOvECJDfWkwp07yNJTwqBxena/jGNxB5l8iucHsqPWAiB4SsllNAs56sqorCf5ls8BR8xPWrZ/7QbRkreadPSDrXwH22chuJd2FFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K06CZksq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C7BC4CEE7;
	Thu,  8 May 2025 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746739110;
	bh=ITJBbvxO1iSak3FKMzKC0shGtp98+4dJk6zyaV+KLTw=;
	h=From:To:Cc:Subject:Date:From;
	b=K06CZksquaCkXik+RnhGjfFbxKZmCcLSwKTbB0LnyynGLxErnEXkNGRugBDdk2JMA
	 PCQGHwDprC7gYEbNLEPnfKyfYmrXIPhtOtPNRRGAF29S6WE06hAkIBkpWWzE1rF/nH
	 OmrZY5x5lkWzDque09E2MC3QP1iPz1264lMuqjx2YcxiTvVIaLc7BVeownjY9KijKc
	 fyEMIn0FAgS+mOw2KePKehAAY8oI8MZGzysHxncrmuKOU/Sa6W5MB9S80W66TyT3bD
	 WP5Ko7pmgSCnNlOZ5DPGNSGXei1MqOkuh5sgBM4Z67oDom3F/x6L8aCJi0Fv04SYHq
	 +VT2n6e4P9f+A==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH v2] PM: hibernate: Explicitly set `PM_SUSPEND_MAX` at hibernate entry
Date: Thu,  8 May 2025 16:17:46 -0500
Message-ID: <20250508211822.2698678-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

`pm_debug_messages` only works at suspend time, not hibernate. This is
because during hibernate the `pm_suspend_target_state` is not set.

Explicitly set pm_suspend_target_state at hibernate time. Since the symbol
is only enabled under `CONFIG_SUSPEND`, adjust symbol location and allow it
under `CONFIG_HIBERNATION` too.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Fix for lkp robot failure where no CONFIG_SUSPEND
---
 include/linux/suspend.h  | 9 ++++++---
 kernel/power/hibernate.c | 2 ++
 kernel/power/main.c      | 3 +++
 kernel/power/suspend.c   | 2 --
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index da6ebca3ff774..b66be47ef5282 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -142,8 +142,13 @@ struct platform_s2idle_ops {
 	void (*end)(void);
 };
 
-#ifdef CONFIG_SUSPEND
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
 extern suspend_state_t pm_suspend_target_state;
+#else
+#define pm_suspend_target_state	(PM_SUSPEND_ON)
+#endif
+
+#ifdef CONFIG_SUSPEND
 extern suspend_state_t mem_sleep_current;
 extern suspend_state_t mem_sleep_default;
 
@@ -279,8 +284,6 @@ extern bool sync_on_suspend_enabled;
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
-#define pm_suspend_target_state	(PM_SUSPEND_ON)
-
 static inline void pm_suspend_clear_flags(void) {}
 static inline void pm_set_suspend_via_firmware(void) {}
 static inline void pm_set_resume_via_firmware(void) {}
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index f0db9d1896e80..8fb82a62b85f1 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -772,6 +772,7 @@ int hibernate(void)
 	}
 
 	pr_info("hibernation entry\n");
+	pm_suspend_target_state = PM_SUSPEND_MAX;
 	pm_prepare_console();
 	error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
 	if (error)
@@ -852,6 +853,7 @@ int hibernate(void)
 	hibernate_release();
  Unlock:
 	unlock_system_sleep(sleep_flags);
+	pm_suspend_target_state = PM_SUSPEND_ON;
 	pr_info("hibernation exit\n");
 
 	return error;
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 97746f08b762b..0440644695c76 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -20,6 +20,9 @@
 
 #include "power.h"
 
+suspend_state_t pm_suspend_target_state;
+EXPORT_SYMBOL_GPL(pm_suspend_target_state);
+
 #ifdef CONFIG_PM_SLEEP
 /*
  * The following functions are used by the suspend/hibernate code to temporarily
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8eaec4ab121d4..08cb71991795d 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -48,8 +48,6 @@ const char *mem_sleep_states[PM_SUSPEND_MAX];
 
 suspend_state_t mem_sleep_current = PM_SUSPEND_TO_IDLE;
 suspend_state_t mem_sleep_default = PM_SUSPEND_MAX;
-suspend_state_t pm_suspend_target_state;
-EXPORT_SYMBOL_GPL(pm_suspend_target_state);
 
 unsigned int pm_suspend_global_flags;
 EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
-- 
2.43.0


