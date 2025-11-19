Return-Path: <linux-pm+bounces-38228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61639C705E8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 18:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 486DB28D3A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7C334C1A;
	Wed, 19 Nov 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9FH6Gvi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30032FA1A
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572477; cv=none; b=EQ3fvzLX4pukng+1QrbO4zAGpGEsa4FdfF0Pj/Te25dD8uXSXZfhuA9J864tk6PteTY14Nvu6+J9vvozkD2cuCT0gsdLbHF2BI3suqnMNCJMBQDh7DI59OGPwCrJKduCF7QM/nkw/sYFvG+SIB2m3vffkVoKJ/QmesJikXE2uG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572477; c=relaxed/simple;
	bh=hdLwb9acqDfhxBhnz8O1AJyDAdi9H/fDe7nvfKDiOuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qPXbw+/vKhyOaghGN3j+axX+fJFq+45Ai6+bNrpQHFeFKdXsPsv1cNR+Gqym1aOhV0LGb+FnddxdE8Ye9SFwUIuex/bc2P9yMrJSufPLBMDMdqXWBwGeQ17vFigyXUeXVcXvKFI4awXVMK0wCGK8kTm5TjU20on088jOwuzXW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9FH6Gvi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so6114206a12.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 09:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763572475; x=1764177275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7C622rNOWivI+OfNCjEY0kVqx3N/Aq517Mczx5KB0m4=;
        b=W9FH6GvimuVImlw7vMWR0bb255QLZGqiV8GBiEVQqaLxE1tC57hrOpZ1595VPbuLLR
         TjAbfHiWDWrraNhrWe8DoHxG4swJJm4172TiNjdFAgccjbLw+GA1Qr4ZeLayZqam6l5M
         SSZM8q6U/Dw4tWjaYGsWjwypvn+bwA7EQKtOTfukNAy5oX1hpnT0MtpdLP6boOnyjMpS
         QuTkBkUWWvMPNJ6B6/BSElZwAhLAoPR2j4uL8PZp72zcLFxWIS8EXivpwkKsLO4rvx8P
         iA4fTdYYuCpbXKpiv/naX0CkUTP0GMhElXbAuYHqQf25QiX+Gzz3Jf7XofFsuqv3GoK5
         6aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572475; x=1764177275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7C622rNOWivI+OfNCjEY0kVqx3N/Aq517Mczx5KB0m4=;
        b=FGLdBU/viTN/rh9Dlug/YtM3CWf3tTm4BGCBYdxHePXmlMrzFOr8mYr2eEZ7wXEiqg
         7wT/LCw4bug0V6ZwSwfiDoXNHxVSTEH3kDp357IMBSU81Ok8Ibu4j8SQ8M9+OudaHbIG
         hzBnapztSbyUoFxHa8sUuoxTXcLJjbz98/hB8pOYPCjT9GArbUSn0EyfIHgTTGq1NTey
         lRH4cZsgNoOE9uXpTbXqRaap/Q1348+4feuxg+lqqo6VXcBb7EGkduI9kuUlBCR4sBU5
         fYePs6MTqlvSvvTlUbTDmCQVl9PF/zWl3ykAOmv4PLJS6dIsKcjPjsKLizzi1vkLOXJZ
         M0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUnYll2epz1nXbUcgT6Rk3tdqsmoyO9wKgRyEmSCUIm6WwjlvoAhlPoXdXSO4uSo3u5jReYX5MOhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGT8Bqx1EQSgsFrFkjo1Ha+78blTVzr4u4dnaKjE+JoOUwbfJ/
	BM4GbD5VLQnBPN5FBnvQhcSo/mq8dVdI/EFxvXaQGn9w6DtsKLZaWlicbVdjKXemkjxLMuC7PvF
	4BG8paxCKOnu7RA==
X-Google-Smtp-Source: AGHT+IFcYEkscRBJM2wJ0hgN6X5hVzAyQFJwpeYa0ouwGIvKCLQRaLgmTSK+lp1IyAIbGOBaIKeQSk+dseGujQ==
X-Received: from dlah17.prod.google.com ([2002:a05:701b:2611:b0:119:78ff:fe0f])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:a92:b0:11b:9386:8270 with SMTP id a92af1059eb24-11c938b7857mr20568c88.45.1763572475044;
 Wed, 19 Nov 2025 09:14:35 -0800 (PST)
Date: Wed, 19 Nov 2025 09:14:24 -0800
In-Reply-To: <20251119171426.4086783-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119171426.4086783-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119171426.4086783-2-wusamuel@google.com>
Subject: [PATCH v7 1/2] PM: Add framework to abort during fs_sync
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: tuhaowen@uniontech.com, Samuel Wu <wusamuel@google.com>, 
	Saravana Kannan <saravanak@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add helper function pm_sleep_fs_sync() and related data structures to
setup a framework that allows for aborting suspend and hibernate during
their filesystem sync phase.

Suggested-by: Saravana Kannan <saravanak@google.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/power/main.c  | 79 ++++++++++++++++++++++++++++++++++++++++----
 kernel/power/power.h |  1 +
 2 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index a6cbc3f4347a..03b2c5495c77 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -18,6 +18,8 @@
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/pm_runtime.h>
+#include <linux/atomic.h>
+#include <linux/wait.h>
 
 #include "power.h"
 
@@ -92,6 +94,61 @@ void ksys_sync_helper(void)
 }
 EXPORT_SYMBOL_GPL(ksys_sync_helper);
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+/* Wakeup events handling resolution while syncing file systems in jiffies */
+#define PM_FS_SYNC_WAKEUP_RESOLUTION	5
+
+static atomic_t pm_fs_sync_count = ATOMIC_INIT(0);
+static struct workqueue_struct *pm_fs_sync_wq;
+static DECLARE_WAIT_QUEUE_HEAD(pm_fs_sync_wait);
+
+static bool pm_fs_sync_completed(void)
+{
+	return atomic_read(&pm_fs_sync_count) == 0;
+}
+
+static void pm_fs_sync_work_fn(struct work_struct *work)
+{
+	ksys_sync_helper();
+
+	if (atomic_dec_and_test(&pm_fs_sync_count))
+		wake_up(&pm_fs_sync_wait);
+}
+static DECLARE_WORK(pm_fs_sync_work, pm_fs_sync_work_fn);
+
+/**
+ * pm_sleep_fs_sync() - Sync file systems in an interruptible way
+ *
+ * Return: 0 on successful file system sync, or -EBUSY if the file system sync
+ * was aborted.
+ */
+int pm_sleep_fs_sync(void)
+{
+	pm_wakeup_clear(0);
+
+	/*
+	 * Take back-to-back sleeps into account by queuing a subsequent fs sync
+	 * only if the previous fs sync is running or is not queued. Multiple fs
+	 * syncs increase the likelihood of saving the latest files immediately
+	 * before sleep.
+	 */
+	if (!work_pending(&pm_fs_sync_work)) {
+		atomic_inc(&pm_fs_sync_count);
+		queue_work(pm_fs_sync_wq, &pm_fs_sync_work);
+	}
+
+	while (!pm_fs_sync_completed()) {
+		if (pm_wakeup_pending())
+			return -EBUSY;
+
+		wait_event_timeout(pm_fs_sync_wait, pm_fs_sync_completed(),
+				   PM_FS_SYNC_WAKEUP_RESOLUTION);
+	}
+
+	return 0;
+}
+#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATION */
+
 /* Routines for PM-transition notifications */
 
 static BLOCKING_NOTIFIER_HEAD(pm_chain_head);
@@ -231,10 +288,10 @@ static ssize_t mem_sleep_store(struct kobject *kobj, struct kobj_attribute *attr
 power_attr(mem_sleep);
 
 /*
- * sync_on_suspend: invoke ksys_sync_helper() before suspend.
+ * sync_on_suspend: Sync file systems before suspend.
  *
- * show() returns whether ksys_sync_helper() is invoked before suspend.
- * store() accepts 0 or 1.  0 disables ksys_sync_helper() and 1 enables it.
+ * show() returns whether file systems sync before suspend is enabled.
+ * store() accepts 0 or 1.  0 disables file systems sync and 1 enables it.
  */
 bool sync_on_suspend_enabled = !IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC);
 
@@ -1066,16 +1123,26 @@ static const struct attribute_group *attr_groups[] = {
 struct workqueue_struct *pm_wq;
 EXPORT_SYMBOL_GPL(pm_wq);
 
-static int __init pm_start_workqueue(void)
+static int __init pm_start_workqueues(void)
 {
 	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE | WQ_UNBOUND, 0);
+	if (!pm_wq)
+		return -ENOMEM;
 
-	return pm_wq ? 0 : -ENOMEM;
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+	pm_fs_sync_wq = alloc_ordered_workqueue("pm_fs_sync", 0);
+	if (!pm_fs_sync_wq) {
+		destroy_workqueue(pm_wq);
+		return -ENOMEM;
+	}
+#endif
+
+	return 0;
 }
 
 static int __init pm_init(void)
 {
-	int error = pm_start_workqueue();
+	int error = pm_start_workqueues();
 	if (error)
 		return error;
 	hibernate_image_size_init();
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 7ccd709af93f..75b63843886e 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -19,6 +19,7 @@ struct swsusp_info {
 } __aligned(PAGE_SIZE);
 
 #if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+extern int pm_sleep_fs_sync(void);
 extern bool filesystem_freeze_enabled;
 #endif
 
-- 
2.52.0.rc1.455.g30608eb744-goog


