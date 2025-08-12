Return-Path: <linux-pm+bounces-32239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7525EB23C41
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 01:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4511AA2BB5
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 23:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915242D7389;
	Tue, 12 Aug 2025 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gwg9jyiK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A45227B8E
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755040890; cv=none; b=hdfgJsru0EV9CT0CxFCx4YVJ2skslMcnYbnd29Aveb9puVMrebqVKsrGI/SRY/kl6xpNBse3HPQjk5M4ycw1/9RyqSEWg3gQKUSEixknrc8RnQm6N9PdCq8uCawh+QgIlGir0B8lYWmoe/ALtFQpwZF/aP1zB1NHQL+onFdUZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755040890; c=relaxed/simple;
	bh=LOk7dl93AGvnlrN+hnrHWS3R9F8H5tutntHoaNuqDdQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gcE02f7ozUbAO1osaomesjEVJSownZ5VA3ody2gStQx0/PtMNict6PXcGGRjR1vGsbqhrzviVWvNYLlmsXBjPhG1ihDXJ6fnx3vNgW8K0u0OsoWfD24sZ3UOfXIoXk9mIQ0hBlU8tCg/k1s6QzPwpjn1K/bafjJLoc+GW8ZjN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gwg9jyiK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2400a932e59so97866445ad.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755040888; x=1755645688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bZpiz79XGOfcAFrU83e9u5Jtr5pnmDIUJC8xFkGk0EY=;
        b=Gwg9jyiKV2ZAnontM272UA9FC3LrvDPewTXQpEEfeNTBUuPeNwjCVYN+r7hsUdazFm
         NBr2pjVwhAz31sWyQP4Yx/362rL4D6G3HZEJafClmLDWtmHWuBJfKtzF18TPLt6CaWFH
         Wj6337eQYmkuRoddj9dKvqxlj2RU/TBVIFlPHgN1X05NP7u56MBRLXJ7xr3Nc2DMnWDv
         vcni77ETXRzQSedfVWiNrq3CnSj9g9/R39AkF0n3AQ9Wat7AflnelHpmdlfEuOT6+fwR
         KqgaQHkWga7bawzY//S9pFThGeQqjdoZ4uVvmV1dx7utAVQprao8T5agt1OgrAgZOgrq
         KRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755040888; x=1755645688;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZpiz79XGOfcAFrU83e9u5Jtr5pnmDIUJC8xFkGk0EY=;
        b=kUgQqUx3vKbdNZ/i5bdMnXzmtoBMfeCmeVkcmb2SbNQOIrp403r3A43l5kR7QGHlqk
         dDCtTzChCv37i2kgtkuPw3hCB3Dge1cJHJRrNJc7dmluU+PGjgIB0c74b73X4mAb/a++
         GPwVkHJRnnUw3/h9/zJyX8s4VoN8bZDHh5ejMFr8Y2zt7u80XVrZcxTtKPljBPuAMx8+
         WMG0dZsO4z+PCs2HcjUOXkut59EhTm+HOIcexagEu1+bY//y7GHklxBfrNJbFb++95iB
         HxlX1Z3jEWAUTMyXQbDE2Ey2SEQ1MKEc8FaY+bBI2OHJdXEXFs53GW91HGayXd8IvCI/
         uqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI3umm2Ki3Qhjko5yHMleDydl5B7vVmPYoJgdd40Ou0qJzMLU+rZ76X/iRei1jX20A+68KKRwEbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyD6amoUa6CvH87I9RB+f52Bo/CKeFy4HZbrCNPT+WVBhxN4uW
	DRpvDFk7uTSUtmg0dFxm1oUw9i2+TJG0p7yoW3K/saFLucgcFutDl/YcquZuOmVPqURT4GCCg+9
	//j1SyS2r7+ej8Q==
X-Google-Smtp-Source: AGHT+IEpN2+KlAnjkUEee+7tyFmAYnD+YYk0SolpIJ6qM5vTpNsALavalXORFevn/twSGWrD+KCnKhgjS0cCdQ==
X-Received: from plks17.prod.google.com ([2002:a17:903:2d1:b0:231:de34:f9f6])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a84:b0:240:1953:f9a with SMTP id d9443c01a7336-2430d0b3239mr16123015ad.2.1755040888203;
 Tue, 12 Aug 2025 16:21:28 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:21:23 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Message-ID: <20250812232126.1814253-1-wusamuel@google.com>
Subject: [PATCH v1] PM: Support aborting suspend during filesystem sync
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Samuel Wu <wusamuel@google.com>, Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

At the start of suspend, filesystems will sync to save the current state
of the device. However, the long tail of the filesystem sync can take
upwards of 25 seconds. If during this filesystem sync there is some
wakeup or abort signal, it will not be processed until the sync is
complete; from a user's perspective, this looks like the device is
unresponsive to any form of input.

This patch adds functionality to handle a suspend abort signal when in
the filesystem sync phase of suspend. This topic was first discussed by
Saravana Kannan at LPC 2024 [1], where the general consensus was to
allow filesystem sync on a parallel thread.

[1]: https://lpc.events/event/18/contributions/1845/

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/base/power/wakeup.c |  8 ++++
 include/linux/suspend.h     |  3 ++
 kernel/power/process.c      |  1 -
 kernel/power/suspend.c      | 80 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index d1283ff1080b..304368c3a55f 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_source *ws)
 
 	/* Increment the counter of events in progress. */
 	cec = atomic_inc_return(&combined_event_count);
+	/*
+	 * To maintain the same behavior as pm_wakeup_pending(),
+	 * aborting suspend will only happen if events_check_enabled. Similarly,
+	 * the abort during fs_sync needs the same check.
+	 */
+	if (events_check_enabled)
+		suspend_abort_fs_sync();
 
 	trace_wakeup_source_activate(ws->name, cec);
 }
@@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
 void pm_system_wakeup(void)
 {
 	atomic_inc(&pm_abort_suspend);
+	suspend_abort_fs_sync();
 	s2idle_wake();
 }
 EXPORT_SYMBOL_GPL(pm_system_wakeup);
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 317ae31e89b3..21b1ea275c79 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -276,6 +276,8 @@ extern void arch_suspend_enable_irqs(void);
 
 extern int pm_suspend(suspend_state_t state);
 extern bool sync_on_suspend_enabled;
+
+extern void suspend_abort_fs_sync(void);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
@@ -296,6 +298,7 @@ static inline bool idle_should_enter_s2idle(void) { return false; }
 static inline void __init pm_states_init(void) {}
 static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops) {}
 static inline void s2idle_wake(void) {}
+static inline void suspend_abort_fs_sync(void) {}
 #endif /* !CONFIG_SUSPEND */
 
 static inline bool pm_suspend_in_progress(void)
diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..8ff68ebaa1e0 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -132,7 +132,6 @@ int freeze_processes(void)
 	if (!pm_freezing)
 		static_branch_inc(&freezer_active);
 
-	pm_wakeup_clear(0);
 	pm_freezing = true;
 	error = try_to_freeze_tasks(true);
 	if (!error)
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index b4ca17c2fecf..3bdb8aca00cc 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -31,6 +31,7 @@
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
 #include <linux/fs.h>
+#include <linux/workqueue.h>
 
 #include "power.h"
 
@@ -74,6 +75,16 @@ bool pm_suspend_default_s2idle(void)
 }
 EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
 
+static bool suspend_fs_sync_queued;
+DEFINE_SPINLOCK(suspend_fs_sync_lock);
+DECLARE_COMPLETION(suspend_fs_sync_complete);
+void suspend_abort_fs_sync(void)
+{
+	spin_lock(&suspend_fs_sync_lock);
+	complete(&suspend_fs_sync_complete);
+	spin_unlock(&suspend_fs_sync_lock);
+}
+
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
 	unsigned int sleep_flags;
@@ -403,6 +414,71 @@ void __weak arch_suspend_enable_irqs(void)
 	local_irq_enable();
 }
 
+static void sync_filesystems_fn(struct work_struct *work)
+{
+	ksys_sync_helper();
+
+	spin_lock(&suspend_fs_sync_lock);
+	suspend_fs_sync_queued = false;
+	complete(&suspend_fs_sync_complete);
+	spin_unlock(&suspend_fs_sync_lock);
+}
+static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
+
+/**
+ * suspend_fs_sync_with_abort- Start filesystem sync and handle potential aborts
+ *
+ * Starts filesystem sync in a workqueue, while the main thread uses a
+ * completion to wait for either the filesystem sync to finish or for a wakeup
+ * event. In the case of filesystem sync finishing and triggering the
+ * completion, the suspend path continues as normal. If the complete is due to a
+ * wakeup or abort signal, the code jumps to the suspend abort path while the
+ * filesystem sync finishes in the background.
+ *
+ * An aborted suspend that is followed by another suspend is a potential
+ * scenario that complicates the sequence. This patch handles this by
+ * serializing any filesystem sync; a subsequent suspend's filesystem sync
+ * operation will only start when the previous suspend's filesystem sync has
+ * finished. Even while waiting for the previous suspend's filesystem sync to
+ * finish, the subsequent suspend will still break early if a wakeup completion
+ * is triggered, solving the original issue of filesystem sync blocking abort.
+ */
+static int suspend_fs_sync_with_abort(void)
+{
+	bool need_suspend_fs_sync_requeue;
+
+	pm_wakeup_clear(0);
+Start_fs_sync:
+	spin_lock(&suspend_fs_sync_lock);
+	reinit_completion(&suspend_fs_sync_complete);
+	/*
+	 * Handle the case where a suspend immediately follows a previous
+	 * suspend that was aborted during fs_sync. In this case, serialize
+	 * fs_sync by only starting fs_sync of the subsequent suspend when the
+	 * fs_sync of the previous suspend has finished.
+	 */
+	if (suspend_fs_sync_queued) {
+		need_suspend_fs_sync_requeue = true;
+	} else {
+		need_suspend_fs_sync_requeue = false;
+		suspend_fs_sync_queued = true;
+		schedule_work(&sync_filesystems);
+	}
+	spin_unlock(&suspend_fs_sync_lock);
+
+	/*
+	 * Completion is triggered by fs_sync finishing or a suspend abort
+	 * signal, whichever comes first
+	 */
+	wait_for_completion(&suspend_fs_sync_complete);
+	if (pm_wakeup_pending())
+		return -EBUSY;
+	if (need_suspend_fs_sync_requeue)
+		goto Start_fs_sync;
+
+	return 0;
+}
+
 /**
  * suspend_enter - Make the system enter the given sleep state.
  * @state: System sleep state to enter.
@@ -590,8 +666,10 @@ static int enter_state(suspend_state_t state)
 
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-		ksys_sync_helper();
+		error = suspend_fs_sync_with_abort();
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+		if (error)
+			goto Unlock;
 	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
-- 
2.51.0.rc0.215.g125493bb4a-goog


