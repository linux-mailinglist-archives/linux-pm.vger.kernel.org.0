Return-Path: <linux-pm+bounces-36376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F2BEC05D
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 01:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9017F4EBEC7
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 23:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2660306484;
	Fri, 17 Oct 2025 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KX4Fi6Kb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E92FF676
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760744366; cv=none; b=HbN2nO3PSEMOm7xRvwYHFvgL006dn0LAJ0UrcaU1mEPfb6+2n3n+BP4joa+5HpicU8OR9Eg3GUwXYgd0YNtcZ6xwBLsjtcDJ8tfrrYDfq5j8BGRRH/aBn9xo/EJqrHvpmJGfKNfvMu7SCSKWonMJVUzFiuf3y9gGbwGV0jIXBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760744366; c=relaxed/simple;
	bh=jqJzoT6C1FBrpNFhUT95JPLDMyIMgUDkvwjHq/IDjb0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JHTM+fxsLdvsoNFLCbQc6IilSeyoKdUClN98XomoNhFheN0j8iYbN7BD8E952/Me821PnCOMmE6tbs8Z86SEqZvenw9zeh8FZsF1pxhtUpDWlX2OHPucTFomLa/Vq/nuAMQ42Xjp9Rp3w2ZtVGKhnB6qU8yNjRwLlUE6glN1jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KX4Fi6Kb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55735710f0so3466644a12.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 16:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760744363; x=1761349163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yGaR4Lkrg5CO3a3Yp6pfuW13Xlq7zJBAakO+BSHZzSI=;
        b=KX4Fi6Kb1abq9aDpzepxFz/8Wlk9PPpYPXid9vKscVgq1Cn6Q18eikVt6BRI0AzdEy
         S5+JbPDKmRZyaL+1ybuAaHEJ4XikMLRrm0Gyxm52oWaJE00FK69IJqiBvBfKP7DJPpIz
         qZxr0KFr4imiMyBiLsBW1tfQTzafiG9jEkCZViMdYav4AZA+zQxu6MdXA0szi1yg1VHU
         V4SD+s4cuxsKNtIWLRyvsgtv6cappNc2AAX5qMdplJsdY6lDrUbeWy+s6uq29ufW0cZG
         nBLySfuVsKh6pC4EA4ZDkJe+RNiv9e8aY1zajNHcS/rwvzdxlFVaE/pOLauljwsPjK/J
         1XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760744363; x=1761349163;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGaR4Lkrg5CO3a3Yp6pfuW13Xlq7zJBAakO+BSHZzSI=;
        b=h6XiqbO0eZBxPu1MP03Tx2cNH7vCRXRmB/WaR4NqvzDkTZ0cic1UaZc5enTYxh8/NE
         BvKTG0HDr9pNhTbDfL4LN1qmNpju869UnyIw8ppXxnwuIVTRwSyJj4a5211hgbHA+IRz
         gFE0slU40CCYTYshctQmqzlLRVHA1OalegrpPEibbjLEyDiLUFLsYTOGQSZyv2YX5msB
         F6aCcwaWRKsRF9d/Dj/R3hW3PL/8PVCp4ROc/oCLKwRy4PddVD3GQVBpasYFIZ0NDXse
         /VWEhqs4hvKn6Oq21Q633hfVJnyyByDmOkdvjvzOxaA0natDqAb5qLlOnyQQnMpTphKW
         NRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6EciU1QQko+U4YxFRAWRXzbDWDJ3K3xSPWGC8BXEXtMxfwDkuKMC94JJKVRChsf1NIbomq5X8ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKbBHua2kpN/H7vFwdm3lStGpeRhGN2okttzJSboZC2NApua7
	69K6mUcOkXAkriZtDWQfG56VJ4DwlDfZEhu9hn4Q6Ju8O8ufCk2W9zE9qAeEhOGFB31fM3Le0Vj
	e6QRf9qRl5T8HqQ==
X-Google-Smtp-Source: AGHT+IEjucK5balrGPY+mrMaiiHcJyrBalh7qhOWXHwfTXE717HWXcKk1ifjBXQgbWupeaAm17FGf2JRMiny8w==
X-Received: from pjpx13.prod.google.com ([2002:a17:90a:a38d:b0:33b:51fe:1a93])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1585:b0:262:cbbc:3125 with SMTP id adf61e73a8af0-334a8564fa3mr7732169637.20.1760744362665;
 Fri, 17 Oct 2025 16:39:22 -0700 (PDT)
Date: Fri, 17 Oct 2025 23:39:06 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017233907.2305303-1-wusamuel@google.com>
Subject: [PATCH v5] PM: Support aborting sleep during filesystem sync
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: tuhaowen@uniontech.com, Samuel Wu <wusamuel@google.com>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

At the start of suspend and hibernate, filesystems will sync to save the
current state of the device. However, the long tail of the filesystem
sync can take upwards of 25 seconds. If during this filesystem sync
there is some wakeup or abort signal, it will not be processed until the
sync is complete; from a user's perspective, this looks like the device
is unresponsive to any form of input.

This patch adds functionality to handle a sleep abort signal when in
the filesystem sync phase of suspend or hibernate. This topic was first
discussed by Saravana Kannan at LPC 2024 [1], where the general
consensus was to allow filesystem sync on a parallel thread. In case of
abort, the suspend process will stop waiting on an in-progress
filesystem sync, and continue by aborting suspend before the filesystem
sync is complete.

Additionally, there is extra care needed to account for back-to-back
sleeps while maintaining functionality to immediately abort during the
filesystem sync stage. This patch handles this by serializing the
sequence with an invariant; a subsequent sleep's filesystem sync
operation will only start when the previous sleep's filesystem sync has
finished. While waiting for the previous sleep's filesystem sync to
finish, the subsequent sleep will still abort early if a wakeup event is
triggered, solving the original issue of filesystem sync blocking abort.

[1]: https://lpc.events/event/18/contributions/1845/

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
Changes in v5:
- Update spin_lock() to spin_lock_irqsave() since abort can be in IRQ context
- Updated changelog description to be more precise regarding continuing abort
  sleep before fs_sync() is complete
- Rename abort_sleep_during_fs_sync() to pm_stop_waiting_for_fs_sync()
- Simplify from a goto to do-while in pm_sleep_fs_sync()
- v4 link: https://lore.kernel.org/all/20250911185314.2377124-1-wusamuel@google.com

Changes in v4:
- Removed patch 1/3 of v3 as it is already picked up on linux-pm
- Squashed patches 2/3 and 3/3 from v3 into this single patch
- Added abort during fs_sync functionality to hibernate in addition to suspend
- Moved variables and functions for abort from power/suspend.c to power/main.c
- Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
- Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync()
- v3 link: https://lore.kernel.org/all/20250821004237.2712312-1-wusamuel@google.com/

Changes in v3:
- Split v2 patch into 3 patches
- Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) condition
- Updated documentation and comments within kernel/power/suspend.c
- v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-wusamuel@google.com/

Changes in v2:
- Added documentation for suspend_abort_fs_sync()
- Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration static
- v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-wusamuel@google.com

 drivers/base/power/wakeup.c |  8 ++++
 include/linux/suspend.h     |  4 ++
 kernel/power/hibernate.c    |  5 ++-
 kernel/power/main.c         | 75 +++++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c      |  7 +++-
 5 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index d1283ff1080b..689c16b08b38 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_source *ws)
 
 	/* Increment the counter of events in progress. */
 	cec = atomic_inc_return(&combined_event_count);
+	/*
+	 * wakeup_source_activate() aborts sleep only if events_check_enabled
+	 * is set (see pm_wakeup_pending()). Similarly, abort sleep during
+	 * fs_sync only if events_check_enabled is set.
+	 */
+	if (events_check_enabled)
+		pm_stop_waiting_for_fs_sync();
 
 	trace_wakeup_source_activate(ws->name, cec);
 }
@@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
 void pm_system_wakeup(void)
 {
 	atomic_inc(&pm_abort_suspend);
+	pm_stop_waiting_for_fs_sync();
 	s2idle_wake();
 }
 EXPORT_SYMBOL_GPL(pm_system_wakeup);
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..dc6829b3836f 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -450,6 +450,8 @@ void restore_processor_state(void);
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
+extern void pm_stop_waiting_for_fs_sync(void);
+extern int pm_sleep_fs_sync(void);
 extern void pm_report_hw_sleep_time(u64 t);
 extern void pm_report_max_hw_sleep(u64 t);
 void pm_restrict_gfp_mask(void);
@@ -505,6 +507,8 @@ static inline void pm_restrict_gfp_mask(void) {}
 static inline void pm_restore_gfp_mask(void) {}
 
 static inline void ksys_sync_helper(void) {}
+static inline pm_stop_waiting_for_fs_sync(void) {}
+static inline int pm_sleep_fs_sync(void) {}
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 14e85ff23551..9c8db4b3c114 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -824,7 +824,10 @@ int hibernate(void)
 	if (error)
 		goto Restore;
 
-	ksys_sync_helper();
+	error = pm_sleep_fs_sync();
+	if (error)
+		goto Restore;
+
 	if (filesystem_freeze_enabled)
 		filesystems_freeze();
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3cf2d7e72567..81a53d833358 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -570,6 +570,81 @@ bool pm_sleep_transition_in_progress(void)
 {
 	return pm_suspend_in_progress() || hibernation_in_progress();
 }
+
+static bool pm_sleep_fs_sync_queued;
+static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
+static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
+
+/**
+ * pm_stop_waiting_for_fs_sync - Abort fs_sync to abort sleep early
+ *
+ * This function causes the suspend process to stop waiting on an in-progress
+ * filesystem sync, such that the suspend process can be aborted before the
+ * filesystem sync is complete.
+ */
+void pm_stop_waiting_for_fs_sync(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
+	complete(&pm_sleep_fs_sync_complete);
+	spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
+}
+
+static void sync_filesystems_fn(struct work_struct *work)
+{
+	unsigned long flags;
+
+	ksys_sync_helper();
+	spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
+	pm_sleep_fs_sync_queued = false;
+	complete(&pm_sleep_fs_sync_complete);
+	spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
+}
+static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
+
+/**
+ * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
+ *
+ * Return 0 on successful file system sync, otherwise returns -EBUSY if file
+ * system sync was aborted.
+ */
+int pm_sleep_fs_sync(void)
+{
+	bool need_pm_sleep_fs_sync_requeue;
+	unsigned long flags;
+
+	do {
+		spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
+		reinit_completion(&pm_sleep_fs_sync_complete);
+		/*
+		 * Handle the case where a sleep immediately follows a previous
+		 * sleep that was aborted during fs_sync. In this case, wait for
+		 * the previous filesystem sync to finish. Then do another
+		 * filesystem sync so any subsequent filesystem changes are
+		 * synced before sleeping.
+		 */
+		if (pm_sleep_fs_sync_queued) {
+			need_pm_sleep_fs_sync_requeue = true;
+		} else {
+			need_pm_sleep_fs_sync_requeue = false;
+			pm_sleep_fs_sync_queued = true;
+			schedule_work(&sync_filesystems);
+		}
+		spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
+
+		/*
+		 * Completion is triggered by fs_sync finishing or an abort sleep
+		 * signal, whichever comes first
+		 */
+		wait_for_completion(&pm_sleep_fs_sync_complete);
+		if (pm_wakeup_pending())
+			return -EBUSY;
+	} while (need_pm_sleep_fs_sync_requeue);
+
+	return 0;
+}
+
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM_SLEEP_DEBUG
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4bb4686c1c08..c019a4396c1f 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -31,6 +31,7 @@
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
 #include <linux/fs.h>
+#include <linux/workqueue.h>
 
 #include "power.h"
 
@@ -588,14 +589,16 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
+	pm_wakeup_clear(0);
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-		ksys_sync_helper();
+		error = pm_sleep_fs_sync();
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+		if (error)
+			goto Unlock;
 	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
-	pm_wakeup_clear(0);
 	pm_suspend_clear_flags();
 	error = suspend_prepare(state);
 	if (error)
-- 
2.51.0.858.gf9c4a03a3a-goog


