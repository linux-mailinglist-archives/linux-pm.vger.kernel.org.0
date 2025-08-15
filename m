Return-Path: <linux-pm+bounces-32417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB16B27436
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 02:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061D13AE7C3
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 00:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD12233997;
	Fri, 15 Aug 2025 00:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIYakc4B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097672AF1D
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218815; cv=none; b=lxZgq5Qbeh+mcET36ndPKL+NtHT07wOk2ziV6zjIN0TXzk+DwDxQrfnlp4/6rWdyJaC4aFc7wSWGTqcgJEF2cGNX7tzc4jYmKOKTLw/Wk6Hx7AH4O5I6r7dRdwcvexxpsHG3VUf5djhz2IILuSQckC2J9DdkLp/Vl2VzZfalcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218815; c=relaxed/simple;
	bh=NGHUsgRmczxuidnxsvy2YLjYs5fgom/YxjQeqd4o2TU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TbZRFtJXispghvUi7keOIBYgHxYf9/7Tzfz/ppfpmAv655tdfQAzBgXzNd2uhlfDW6m+yntXjjARddjEDXZE1CvYxPgz2tV1Gr5WtDal2l8990VrTMPz8aaCSsu2q0OcmZXJQddQUu7PGh2lcxP7ZsohbzlYxEqGG6RBvCCIkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIYakc4B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323266b700cso2911647a91.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 17:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755218813; x=1755823613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hAsJQ5DTMdQ9jWgeSvxJLl+Te++Am+tQIELCBHnm1as=;
        b=dIYakc4BlwJkh3i/SWyAOTjO3SOKO17yF0RGM+Fh2Jhe0/QDXNKSTt4rg6jLnw6uPw
         H+6zIGWXgWTAumlTdkhQqHckU6mlH75CcQAoxTfgFKYKTF6LuH1qQjvJVEN0zaRy10Ko
         DsoicgJpXiqC6+M6X24U0ZmhH7F5SdVfdM2et05JpYkaD/ZcxHPWiaWSd8fmVUCjlxV1
         hIbZmeVBSHGHPx9IDcnqJn5pEb/GPlJ2jRQYSFRpKIiRkhPZaFIHIcCjzUFaiaUAwobI
         1hZ4rIq+tNDRaZa/Wtx/GCCtWNQs67L324m0nGJr2dEQBHJp9uthq0h+Rg0xDPHlXaOm
         4VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755218813; x=1755823613;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAsJQ5DTMdQ9jWgeSvxJLl+Te++Am+tQIELCBHnm1as=;
        b=iagWVYBhUCt0qJUecPwKFZchN4181Kj+tvsCYZbRED3/kdITzNJ1z3rzQlnjU65sDf
         eK+EGASNkUEmOWqipEpp2sanzwgf4VP7m0c8SiYx0g88AQQLkCA3lG3tMk6aXspIQSAc
         w2pHMtxkkGYwn7HJKoPVrlkUYqn7D6eJkmJpgvjKb7Fk8K29Bi0DuPw5CEV0u/NdRUZy
         ic4XKS2ZFzvlypQhyIOnF3nrF210v0REZxjdSw7gC4FS6It7lgLAZRxQqJOqKMptsm17
         AYlb3GSS2+1nQ94EmJ4bwRiq5x8s3uWJOOtdo81mytioTLP/Dol+ksPvkKggrEiqF6ZF
         6E1A==
X-Forwarded-Encrypted: i=1; AJvYcCX/vLAGPGucSCdnx9M230//v2cWu2DoFUQW+oM2MyP/cI1N+iHHjPfxvBX6b1+iNUiPfGU0GLpm2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4CoH3v13urk7yG1wCVdtE9QZRUIJfq98qwm4OAnLaNco5ab+
	prk6ckt5V2z1Ay/lYioYvGNGGXDlrMTAuk0dRHCJH4j1kk/CJYbv6lqBNYiGhkvrZqiijMklU4c
	o4II+haX9ZFqwQA==
X-Google-Smtp-Source: AGHT+IGjlfrKgPjG05XzCQJ2sRxdOAQ0R7rX/HyHtZUy2d4IK3L+JT4TWg4qbt9RHa/NDhFsV0p5DJGC326MGw==
X-Received: from pjf14.prod.google.com ([2002:a17:90b:3f0e:b0:31c:38fb:2958])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a51:b0:321:9922:56ed with SMTP id 98e67ed59e1d1-32342107615mr361808a91.31.1755218813276;
 Thu, 14 Aug 2025 17:46:53 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:46:34 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250815004635.3684650-1-wusamuel@google.com>
Subject: [PATCH v2] PM: Support aborting suspend during filesystem sync
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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
 kernel/power/suspend.c      | 85 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 95 insertions(+), 2 deletions(-)

v1 -> v2:
- Added documentation for suspend_abort_fs_sync()
- Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration static

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
index b4ca17c2fecf..dc37ab942bcb 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -31,6 +31,7 @@
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
 #include <linux/fs.h>
+#include <linux/workqueue.h>
 
 #include "power.h"
 
@@ -74,6 +75,21 @@ bool pm_suspend_default_s2idle(void)
 }
 EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
 
+static bool suspend_fs_sync_queued;
+static DEFINE_SPINLOCK(suspend_fs_sync_lock);
+static DECLARE_COMPLETION(suspend_fs_sync_complete);
+
+/**
+ * Triggers the completion that aborts suspend. This completion will only have
+ * an effect if called during filesystems sync step of suspend.
+ */
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
@@ -403,6 +419,71 @@ void __weak arch_suspend_enable_irqs(void)
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
@@ -590,8 +671,10 @@ static int enter_state(suspend_state_t state)
 
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
2.51.0.rc1.167.g924127e9c0-goog


