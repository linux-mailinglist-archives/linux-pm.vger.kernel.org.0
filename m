Return-Path: <linux-pm+bounces-37146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0211C225E3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 22:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CE83A1C55
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 21:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E6D285404;
	Thu, 30 Oct 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwzJap91"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63EF274FEF
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858077; cv=none; b=PETjORNatBYVu3Nfgof5eGQ9TDKKI4qhJ0sfeZdppv1hHSYq5gQ8L/7PF+GymL5nijPUI3Tlj9NdfHBVmJEUJ+E/bCjz10RGhcfsy1v+NXf3wdYWGh7+P53Q+cwtQhWCR+EK62WH53DejDDaqcRQHnrmJ2OCCgQr4Mogjs+1vOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858077; c=relaxed/simple;
	bh=pSm68gUiqpDQYnDnJlfKYIXw088w3ya4Bqiww9ARBCw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Uz8MCKpGHkvh6A2E4alKN4wlFSpCto9Z6eR1btwQnimY2z3fHFS8ltW3AN89htjhjOU/sTAbxhRU0QQzVbzfPIbnA3JoteYkUovqqhBIhk5SRhyRRGuDtx5xeDyXbfvvTgdOPY9DODYTgsCYJABTYr+gZvyPkVp1abC9lm48W3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwzJap91; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so1214337a12.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761858075; x=1762462875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yM/R5fiiUTE4/cz4iiRL4jtb/AtneBwnINL9bc1sqX8=;
        b=AwzJap91x82KmgpqKhueNMbBM+zPQ2mvFE/U70eeFcXc4mK7QLEl3pl2T/QhF2AJkB
         +aRMRc2T+hoS1P+xKIY7OfHl5ALxmTf6ORmqq5IkZFalfmriGmNwgK/u0r9evHFAqwHe
         NiDh91fI9yDj0T5vOzZz/DC4LsRUSYXciFH4uZEzvsyhOSZDmETg0sFf8y6J8bF7tEVE
         4TR4W422fgT7ll/KKB9iN4Ojy+LryehQrmJevbvloAlV/sjR7NIDd3tp56mCD7YYJr9H
         QoZKOw6W4YkJ5ZbFJmVJn6b39w1gIvgoFoqGXYX09v5kipGDjNn8r7+steswM8S8XZ4q
         K2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761858075; x=1762462875;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yM/R5fiiUTE4/cz4iiRL4jtb/AtneBwnINL9bc1sqX8=;
        b=wmKvs+RPZXdNfCyWwzvhef3wMvuHCH3M5VO1CenjmoRkpkftDLtFc8QiHguLoIe8jZ
         odA2pJ0j1EEoGMgLVixjILkDyACznlGt0sfkeion41Wbd9IB22l0tFBQNQrekpB3biVn
         aB3ltWenUQdMC+FWtb9Z9vA/QDtFttXQCTpvZMfCpG8Rc/Qj80HXB4KvBwi3/OEfLJW4
         1dcSa1zi6tiTXJfYry83VnxCezHKbDndllUM4DmNVCnCo7gpnjV8zC+qmrgMMzWfu0Gm
         ntwW9t5YwAmM99Mo7x6Wc/ypI2YAONKWqWM/hd3NqnA/sMK03+Cy7hNepF3aTLWwGOP4
         FzWg==
X-Forwarded-Encrypted: i=1; AJvYcCVRSpTEODBW6A/LPXuiy088YTijf/mftpmTela5iDg2lyE3C12rGHnL8F4Ra6E2RZOfY8BlBU7yow==@vger.kernel.org
X-Gm-Message-State: AOJu0YydJSGLjBiEhjmn+B8A0A5yBmgBn5r9PC2nrdn0kcN1nA7aKvKY
	O8GVVVFUOyvVymdrhBnlAcuDsfwUorqly/4qd3oKJpxO9+/9o+BZiZ5d4IoY9sEk+n4/Q87nN4E
	s2OKZOt0bP8H+7Q==
X-Google-Smtp-Source: AGHT+IE/FqLjssGK3CdsUrJ2TujA0jKIyTf2vP2v/Pgmy6iJinTA5Ft0H3KFGDPgPgZuOkNPae7QF4Lai7pW8w==
X-Received: from plww12.prod.google.com ([2002:a17:902:d10c:b0:294:fae5:ee1b])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f544:b0:270:ced4:911a with SMTP id d9443c01a7336-2951a36c2cbmr14141665ad.9.1761858074943;
 Thu, 30 Oct 2025 14:01:14 -0700 (PDT)
Date: Thu, 30 Oct 2025 21:01:09 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030210110.298612-1-wusamuel@google.com>
Subject: [PATCH v6] PM: Support aborting sleep during filesystem sync
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
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
filesystem sync stage. Furthermore, in the case of the back-to-back
sleeps, a subsequent filesystem sync is needed to ensure the latest
files are synced right before sleep. If necessary, a subsequent sleep's
filesystem sync will be queued, and will only start when the previous
sleep's filesystem sync has finished. While waiting for the previous
sleep's filesystem sync to finish, the subsequent sleep will still abort
early if a wakeup event is triggered, solving the original issue of
filesystem sync blocking abort.

[1]: https://lpc.events/event/18/contributions/1845/

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
Changes in v6:
- Use spin_lock_irq() in thread context
- Use dedicated ordered workqueue for sync work items
- Use a counter instead of two bools for synchronization
- Queue fs_sync if it's not already pending on workqueue
- pm_wakeup_clear(0) is prequisite to this feature, so move it within function
- Updated commit text for motive of back-to-back fs syncs
- Tighter lock/unlock around setup, checks, and loop
- Fix function definitions for CONFIG_PM_SLEEP=n
- v5 link: https://lore.kernel.org/all/20251017233907.2305303-1-wusamuel@google.com/

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
 kernel/power/main.c         | 81 +++++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c      |  4 +-
 5 files changed, 100 insertions(+), 2 deletions(-)

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
index b02876f1ae38..4795f55f9cbe 100644
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
+static inline void pm_stop_waiting_for_fs_sync(void) {}
+static inline int pm_sleep_fs_sync(void) { return 0; }
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 53166ef86ba4..1874fde4b4f3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -820,7 +820,10 @@ int hibernate(void)
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
index a6cbc3f4347a..23ca87a172a4 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -582,6 +582,84 @@ bool pm_sleep_transition_in_progress(void)
 {
 	return pm_suspend_in_progress() || hibernation_in_progress();
 }
+
+static int pm_sleep_fs_syncs_queued;
+static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
+static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
+static struct workqueue_struct *pm_fs_sync_wq;
+
+static int __init pm_start_fs_sync_workqueue(void)
+{
+	pm_fs_sync_wq = alloc_ordered_workqueue("pm_fs_sync_wq", 0);
+
+	return pm_fs_sync_wq ? 0 : -ENOMEM;
+}
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
+	ksys_sync_helper();
+
+	spin_lock_irq(&pm_sleep_fs_sync_lock);
+	pm_sleep_fs_syncs_queued--;
+	complete(&pm_sleep_fs_sync_complete);
+	spin_unlock_irq(&pm_sleep_fs_sync_lock);
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
+	pm_wakeup_clear(0);
+	spin_lock_irq(&pm_sleep_fs_sync_lock);
+	/*
+	 * Handles back-to-back sleeps, by queuing a subsequent fs sync only if
+	 * the previous fs sync is running or is not queued. Multiple fs syncs
+	 * ensure that the latest files are saved immediately before sleep.
+	 */
+	if (!work_pending(&sync_filesystems)) {
+		pm_sleep_fs_syncs_queued++;
+		queue_work(pm_fs_sync_wq, &sync_filesystems);
+	}
+	do {
+		reinit_completion(&pm_sleep_fs_sync_complete);
+		spin_unlock_irq(&pm_sleep_fs_sync_lock);
+		/*
+		 * Completion is triggered by fs_sync finishing or a sleep
+		 * abort, whichever comes first
+		 */
+		wait_for_completion(&pm_sleep_fs_sync_complete);
+		spin_lock_irq(&pm_sleep_fs_sync_lock);
+		if (pm_wakeup_pending()) {
+			spin_unlock_irq(&pm_sleep_fs_sync_lock);
+			return -EBUSY;
+		}
+	} while (pm_sleep_fs_syncs_queued);
+	spin_unlock_irq(&pm_sleep_fs_sync_lock);
+
+	return 0;
+}
+
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM_SLEEP_DEBUG
@@ -1076,6 +1154,9 @@ static int __init pm_start_workqueue(void)
 static int __init pm_init(void)
 {
 	int error = pm_start_workqueue();
+	if (error)
+		return error;
+	error = pm_start_fs_sync_workqueue();
 	if (error)
 		return error;
 	hibernate_image_size_init();
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index b4ca17c2fecf..04781a2c69e2 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -590,8 +590,10 @@ static int enter_state(suspend_state_t state)
 
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-		ksys_sync_helper();
+		error = pm_sleep_fs_sync();
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+		if (error)
+			goto Unlock;
 	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
-- 
2.51.1.930.gacf6e81ea2-goog


