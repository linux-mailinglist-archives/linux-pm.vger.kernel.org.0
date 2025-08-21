Return-Path: <linux-pm+bounces-32757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A19B2E985
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 02:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784F81BA128D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88311E102D;
	Thu, 21 Aug 2025 00:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TBQX82mx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B581F473C
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736980; cv=none; b=rMKh5N45shjFE6ZAAvrHDTVlXsIs87rr9bYJV8hKTG5Rjrsrd+RjvaAlqRo5lbAAgWTEGAa+spI6onfFcDXhjd38c5NmLJBK7JEKWnCbI1VQRM+hZ466w1xvrBhT2dpWQI1UvfPUKmhxGQwT4zm1/wqGob+NEZbF1qlEp7i/48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736980; c=relaxed/simple;
	bh=sjhaA9PbdBoDlY1RpJKGBmhcFyttPUwGKRyPs1/dR4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GwyXzroFNwT1tSQg58T3/VlMJlHu3HUDbuB+VqriXr8Zl0mDd2f/ARKht0ri9GNfglpWuIWT0eVuzdZWkqeSPnRLQcDptsuXf/38TSYgwWWoXAQWyK8S/L/Y2sUa/dekA+BwfcqZLZDxV9YoskLZgkimoUw+nWYx95ypBr4q6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TBQX82mx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b474a689901so264813a12.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 17:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755736978; x=1756341778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEEDFLzdkJxsA5MFxQRzqAGK72ATrZ5Rpvk68XckeHw=;
        b=TBQX82mxYJap+ImMwrlzT4+VOE/XHCjF8KW0b0AOkpK2GRpwdQ9VhecoyGqSS0Pwv1
         iBgih4e39sDs1BrFXIQOOQ8SUQPXsLKGmjvoytK6OugW1RnaD+D5tbg8anhlb7OYV/jl
         wLv8ny8JG70FpW850lwnma+pL7O3gVPJACaBPAO10yvyA+DmbOB418LCAaNNDetEzOtT
         hWIMfNww/Uu2S9xnkjYqkoUjEskEB6I2E+jaY18fsjfQf5exZzVVMU2T9a2zomQckDSQ
         +Tx+G+xKdkLZjcHkL/o2bnXDKll8/psYHz0YA3gt1F1err44KRiR4Gx6fVLdEb3dS1+N
         S+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755736978; x=1756341778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEEDFLzdkJxsA5MFxQRzqAGK72ATrZ5Rpvk68XckeHw=;
        b=SwdwUKZb124I3jYXHJpeB9Cjn18cyp0E2kH5+jbWVIdmOMjEf7WgkxjfnfBU7PlmqV
         c8S5ptOcY92brU+ZiQJeCY6wqCDASBVN56hUsqTSjcYFzVVLFUvzhI1RyCSoY2X2gdyP
         Om+Swf8+XIpaVLj0Hd6DRe4skRieDg/CpavIJv9MXJpJXllNN+ec2LLnchCrz9RWE6Hq
         SY0A8iQwBUqKwBoDhK6CBLdkT40hKjg6MQijdDHEED/cYHz7PcW9MDbbS0vRDyr/sGz5
         rLv1NUjMmeIVif+aD0hL/18VH3kts8USGXuPUOHA12sinxXhZ3mJmi2RiUxwftVBtja6
         GeAA==
X-Forwarded-Encrypted: i=1; AJvYcCV4IuDQbog5QcLowx6L/QjTD+Uy8DiHuYuhP0biRoc15WlE8Ycfi8Thh/gyBejsG9oHYtP9Y+kJ7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLjeAezO/aqIwN8fnL7bMo4hDe+2Z7gegRDJPYDE3LvJo6Pzs
	RX8S3dJ3cWoJnfkeVrRSRiMiy8AUuf+Ge2o3okGsB+uSkfo/13TE9h9DGgj8qu2hYXmJEB8hBJq
	TFqzy8i7QJr1AUQ==
X-Google-Smtp-Source: AGHT+IFRX4CzFsLvpYCXo2bF56Mrj1NmbuOZ6oMEZbAVvMBhPKevVDn1/bBzt5cMhmFdXtqW2LvHc5LTpOh3YQ==
X-Received: from pgou3.prod.google.com ([2002:a63:b543:0:b0:b46:d6fa:dd42])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7488:b0:231:acae:1977 with SMTP id adf61e73a8af0-243307c1a45mr607077637.15.1755736978591;
 Wed, 20 Aug 2025 17:42:58 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:42:34 -0700
In-Reply-To: <20250821004237.2712312-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821004237.2712312-3-wusamuel@google.com>
Subject: [PATCH v3 2/3] PM: Support aborting suspend during filesystem sync
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
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
 drivers/base/power/wakeup.c |  8 +++++++
 include/linux/suspend.h     |  2 ++
 kernel/power/suspend.c      | 48 +++++++++++++++++++++++++++++++++++--
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index d1283ff1080b..af4cf3e6ba44 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_source *ws)
 
 	/* Increment the counter of events in progress. */
 	cec = atomic_inc_return(&combined_event_count);
+	/*
+	 * wakeup_source_activate() aborts suspend only if events_check_enabled
+	 * is set (see pm_wakeup_pending()). Similarly, abort suspend during
+	 * fs_sync only if events_check_enabled is set.
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
index 317ae31e89b3..68d2e8a7eeb1 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(void);
 
 extern int pm_suspend(suspend_state_t state);
 extern bool sync_on_suspend_enabled;
+extern void suspend_abort_fs_sync(void);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
@@ -296,6 +297,7 @@ static inline bool idle_should_enter_s2idle(void) { return false; }
 static inline void __init pm_states_init(void) {}
 static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops) {}
 static inline void s2idle_wake(void) {}
+static inline void suspend_abort_fs_sync(void) {}
 #endif /* !CONFIG_SUSPEND */
 
 static inline bool pm_suspend_in_progress(void)
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4bb4686c1c08..edacd2a4143b 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -31,6 +31,7 @@
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
 #include <linux/fs.h>
+#include <linux/workqueue.h>
 
 #include "power.h"
 
@@ -74,6 +75,19 @@ bool pm_suspend_default_s2idle(void)
 }
 EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
 
+static DECLARE_COMPLETION(suspend_fs_sync_complete);
+
+/**
+ * suspend_abort_fs_sync - Abort fs_sync to abort suspend early
+ *
+ * This function aborts the fs_sync stage of suspend so that suspend itself can
+ * be aborted early.
+ */
+void suspend_abort_fs_sync(void)
+{
+	complete(&suspend_fs_sync_complete);
+}
+
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
 	unsigned int sleep_flags;
@@ -403,6 +417,34 @@ void __weak arch_suspend_enable_irqs(void)
 	local_irq_enable();
 }
 
+static void sync_filesystems_fn(struct work_struct *work)
+{
+	ksys_sync_helper();
+	complete(&suspend_fs_sync_complete);
+}
+static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
+
+/**
+ * suspend_fs_sync_with_abort - Trigger fs_sync with ability to abort
+ *
+ * Return 0 on successful file system sync, otherwise returns -EBUSY if file
+ * system sync was aborted.
+ */
+static int suspend_fs_sync_with_abort(void)
+{
+	reinit_completion(&suspend_fs_sync_complete);
+	schedule_work(&sync_filesystems);
+	/*
+	 * Completion is triggered by fs_sync finishing or a suspend abort
+	 * signal, whichever comes first
+	 */
+	wait_for_completion(&suspend_fs_sync_complete);
+	if (pm_wakeup_pending())
+		return -EBUSY;
+
+	return 0;
+}
+
 /**
  * suspend_enter - Make the system enter the given sleep state.
  * @state: System sleep state to enter.
@@ -588,14 +630,16 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
+	pm_wakeup_clear(0);
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-		ksys_sync_helper();
+		error = suspend_fs_sync_with_abort();
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
2.51.0.261.g7ce5a0a67e-goog


