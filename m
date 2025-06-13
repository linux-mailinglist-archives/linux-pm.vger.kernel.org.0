Return-Path: <linux-pm+bounces-28699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0FBAD9775
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 23:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081BC189E026
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 21:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAB62356C0;
	Fri, 13 Jun 2025 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1Pb5svE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F92E11C1
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851062; cv=none; b=dcz/Kw0Z4cEFc1pR/9q2zt0LgCXqD7n431RJKKC3SDwXST0TRDlWLxM3l+QKGi3E63NJDQQ6UCGZJKrcd8t3PgtgdpilZaZlfrRrcn4v5Zb021lCI4AKs7Vyremmqe5Vp7ouND4Ej2tE07Gek5OqUHc5td0+nCLsmIpSajVLhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851062; c=relaxed/simple;
	bh=GJfPbPeu9q+2/ctADOJkntAal4bqSrgg30/06dFHPVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxVGfKiTeeZ7vDIDYO2h9SNcE91RSqWwXl6m3tvU/Ll+iSuzzcOskElB85DOQMJILcYQQBhe4c7d3+RLDtxCVwLLBPi+A4G+ngAn5qk/JM91uzvE8DgU9KXaRbOcBX6obGSlQ14X5DcHJRc58KFCdzbjOj1t3MXojBsg9pyyTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1Pb5svE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA943C4CEE3;
	Fri, 13 Jun 2025 21:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749851061;
	bh=GJfPbPeu9q+2/ctADOJkntAal4bqSrgg30/06dFHPVs=;
	h=From:To:Cc:Subject:Date:From;
	b=c1Pb5svEJPW7BnMQIy4dzAlbioiM0wMC/G4nwO9W9mNyKXb2rT9TjkekI6YIaGTW0
	 xnEbRTHR/WOtDFM4lDyHaltqg4Te/uz7fCSz+Z5h2/vWGqzpUizBOLJoLOgy80pfcu
	 JANhKPQ+BU740VbNPauEHmGg5Prq7wenNqJgQLT8JICChYNHkR4TRuUmLp+nO8pfc9
	 JMGsSo+Zc6A9s5vPlQ34Mb07KL72uUAFFQAzmkGKNQIAzvkYJmL9FUUW+gff79y2UB
	 3cOBMjxtsB0d6LfvGMIhOEBs9ZucL2m/4hO1YJQYASiIutIrDVi/VLen6IfWDprq8S
	 hXTtGoc5Z70Cg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	bhe@redhat.com
Cc: christian.koenig@amd.com,
	linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH] PM: Restrict swap use to later in the suspend sequence
Date: Fri, 13 Jun 2025 16:43:44 -0500
Message-ID: <20250613214413.4127087-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Currently swap is restricted before drivers have had a chance to do their
prepare() PM callbacks. Restricting swap this early means that if a driver
needs to evict some content from memory into sawp in it's prepare callback
it won't be able to.

On AMD dGPUs this can lead to failed suspends under memory pressure
situations as all VRAM must be evicted to system memory or swap.

Move the swap restriction to right after all devices have had a chance to
do the prepare() callback.  If there is any problem with the sequence,
restore swap in the appropriate dpm resume callbacks or error handling
paths.

Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/base/power/main.c | 5 ++++-
 include/linux/suspend.h   | 5 +++++
 kernel/kexec_core.c       | 1 +
 kernel/power/hibernate.c  | 3 ---
 kernel/power/power.h      | 5 -----
 kernel/power/suspend.c    | 3 +--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 0215b20c5e2c8..4970a804afb6d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1241,6 +1241,7 @@ void dpm_complete(pm_message_t state)
  */
 void dpm_resume_end(pm_message_t state)
 {
+	pm_restore_gfp_mask();
 	dpm_resume(state);
 	dpm_complete(state);
 }
@@ -2183,8 +2184,10 @@ int dpm_suspend_start(pm_message_t state)
 	error = dpm_prepare(state);
 	if (error)
 		dpm_save_failed_step(SUSPEND_PREPARE);
-	else
+	else {
+		pm_restrict_gfp_mask();
 		error = dpm_suspend(state);
+	}
 
 	dpm_show_time(starttime, state, error, "start");
 	return error;
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b1c76c8f2c822..6a3f920988720 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -446,6 +446,8 @@ extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
 extern void pm_report_hw_sleep_time(u64 t);
 extern void pm_report_max_hw_sleep(u64 t);
+void pm_restrict_gfp_mask(void);
+void pm_restore_gfp_mask(void);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
@@ -492,6 +494,9 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 static inline void pm_report_hw_sleep_time(u64 t) {};
 static inline void pm_report_max_hw_sleep(u64 t) {};
 
+static inline void pm_restrict_gfp_mask(void) {}
+static inline void pm_restore_gfp_mask(void) {}
+
 static inline void ksys_sync_helper(void) {}
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9c59fa480b0b6..3a9a9f240dbc9 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1136,6 +1136,7 @@ int kernel_kexec(void)
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
  Resume_console:
+		pm_restore_gfp_mask();
 		console_resume_all();
 		thaw_processes();
  Restore_console:
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 519fb09de5e0c..9216e3b91d3b3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -423,7 +423,6 @@ int hibernation_snapshot(int platform_mode)
 	}
 
 	console_suspend_all();
-	pm_restrict_gfp_mask();
 
 	error = dpm_suspend(PMSG_FREEZE);
 
@@ -559,7 +558,6 @@ int hibernation_restore(int platform_mode)
 
 	pm_prepare_console();
 	console_suspend_all();
-	pm_restrict_gfp_mask();
 	error = dpm_suspend_start(PMSG_QUIESCE);
 	if (!error) {
 		error = resume_target_kernel(platform_mode);
@@ -571,7 +569,6 @@ int hibernation_restore(int platform_mode)
 		BUG_ON(!error);
 	}
 	dpm_resume_end(PMSG_RECOVER);
-	pm_restore_gfp_mask();
 	console_resume_all();
 	pm_restore_console();
 	return error;
diff --git a/kernel/power/power.h b/kernel/power/power.h
index cb1d715620020..7ccd709af93f5 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -239,11 +239,6 @@ static inline void suspend_test_finish(const char *label) {}
 /* kernel/power/main.c */
 extern int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down);
 extern int pm_notifier_call_chain(unsigned long val);
-void pm_restrict_gfp_mask(void);
-void pm_restore_gfp_mask(void);
-#else
-static inline void pm_restrict_gfp_mask(void) {}
-static inline void pm_restore_gfp_mask(void) {}
 #endif
 
 #ifdef CONFIG_HIGHMEM
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 76b141b9aac01..bb608b68fb301 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -540,6 +540,7 @@ int suspend_devices_and_enter(suspend_state_t state)
 	return error;
 
  Recover_platform:
+	pm_restore_gfp_mask();
 	platform_recover(state);
 	goto Resume_devices;
 }
@@ -606,9 +607,7 @@ static int enter_state(suspend_state_t state)
 
 	trace_suspend_resume(TPS("suspend_enter"), state, false);
 	pm_pr_dbg("Suspending system (%s)\n", mem_sleep_labels[state]);
-	pm_restrict_gfp_mask();
 	error = suspend_devices_and_enter(state);
-	pm_restore_gfp_mask();
 
  Finish:
 	events_check_enabled = false;
-- 
2.43.0


