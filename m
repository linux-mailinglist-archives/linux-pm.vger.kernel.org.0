Return-Path: <linux-pm+bounces-34205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E2B4A2C2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9B44E18A1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 06:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E89A30504C;
	Tue,  9 Sep 2025 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YwPg07wX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23582594BE;
	Tue,  9 Sep 2025 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401187; cv=none; b=gjMzupHpvaxL3JwcgkFgcIuI7jtklNVkQehRwd/mqujLHwye8QdpTG0AXcGctHAraELxacBlyfuzr2eCEfKai/Cvu0e8wHotg8ksym2m6KTpBcQbL8hcyuR/jtxZigQ25fE4XRkENGJUa1nmKAIVSarQhAL56n+M6b7l6PlyeCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401187; c=relaxed/simple;
	bh=BHJ8sqoqyUyJ68vlzeIfk7fhhGNyUBpM7zl7WiDhdE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUUnUcSBnmZK53Z5kaE33PiaVw2+acmi0aCqKEPpSSfGccITMsjHNBJwllYwM4Ylz6pTdyDwZ1Y8DT27VqsT0jsX/UtnrgrydHWYRNLScV6C2FgZU1VEHNDsIWokymGkwOxgTiMKPZbiD2/xXB9oUtgURJPvSWv5Fnz36hgc7Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YwPg07wX; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1757401133;
	bh=EwH0w4PvA3lfCqW8m/2b+fjNT4NdGf5u9DmtXqAOHkk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YwPg07wXe7jGG/NTKieEzMgV1hECOJEJyTgi+wkJdBlFn7QvxpTTNikbIHrMRG9Nf
	 tyFsWtuEhqw4oxcIc/NysLuitdkoh0OF1ILk9q3JsTBGyYBPYC4dmNWcnu9nJeI+b7
	 6BVAUZ8opg4wPRO6U3O1tzuLN5JICBookmGS5uIk=
X-QQ-mid: zesmtpip2t1757401125t4e3447c9
X-QQ-Originating-IP: 8UGy5pCIyeWgCEIGkL9vSwscSkxUIz1k8lZ1704/x84=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 14:58:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17818815471825471435
EX-QQ-RecipientCnt: 10
From: tuhaowen <tuhaowen@uniontech.com>
To: rafael@kernel.org
Cc: tuhaowen@uniontech.com,
	huangbibo@uniontech.com,
	kernel-team@android.com,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@kernel.org,
	saravanak@google.com,
	wusamuel@google.com
Subject: [PATCH v3] PM: Add configurable sync timeout for suspend and hibernation
Date: Tue,  9 Sep 2025 14:58:36 +0800
Message-Id: <20250909065836.32534-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250908022238.6852-1-tuhaowen@uniontech.com>
References: <20250908022238.6852-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Of2cEohDBRJBDM+Qe3D+WtGbjNGrZtKNGF2ObA7PgfFGF04sLwd3fww+
	JAcBwSI4QO2tOrGOj6nhCAVeS3KUxYKfsZwbosiy5koe9IQYGK/uV71TKtATlZy+7n1sviA
	3jMYms430TLxFi3pMQShs++xR3J7XCa83/oAFApWFQ615xIPO3DohiE6/0UBISjIScdUUXR
	bSJFeWjijWph2y0RNraTYoxSL0mbbNJclIHorB84rCcLJs6v/hmTLmhSfjTH6vSj2n2jf1q
	1SVv9bZrRTcYhUd/gcqJY9eeZAUlaUcUHbas+cPcrRQxPcufbpO3hbHnSM9sH/g603AskUh
	megS3JEl52pD5NvkdCyvM/d0FLYT55+0BiN+F4BeLUcgQszDShxLQURJqd9CjqYcZ6E2/Vt
	KzJ6gqe/acdeULCy/kLtKpj/J2x275U0oJ9KIhAOVYzkQqymFSoSewe9VujpJ3BXvfA2QDj
	ehpeFL9M4BchTFDU9TKeUkAb9NCNlIjq2u7RRO1sIgZit2AvGnqvr0B+sWqwrO0uolB3ixb
	9Bja4cI39lo5SYKVYzmICpMXD3fLAGq5gvMDncaAx5wO1M1P7UnJWATenH7d67bm0BOyeEF
	0dXgONEwdxZG9nU9n967dto1W8Ga1wUYqZnsZbMPrEEN0GR2zC0S/oYb/xO8MRNn+2k9+OU
	rDbXu4BfSG+SxeRT7iXp+P50dpt0esUMYfmrSWPKJu669bzW5klEWXtrI2AZ5mr7YMrQcQt
	0Yktcgui+WNDw2AleSDgeQxGEJuXJtz0n2CXJeGHE8ncJ0t+jPZEXooe1bi61AsrzliK/c+
	SUoy2lW5SAg8kawY/XQfc5yq/8gaNWRrVN96IUSRpw+8l6IV7s+MwLDEcSvuio8xRvhmDqN
	HcjeeYAbYrieOFbfLXHu2G3BglifjBTG0MmL2XH+zPzw2UdlHNsyzSyjnNo0+hg20ytseLg
	aUrafInsRDpmctQlsSPc58ncVdyZnD/FI7w6vdNUc8Q2DGzEVueezoYXNjnfBga2ATu3JWt
	W4qo/XqG2CokiVh9AjBoUFv8PD4Sg=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

When large file operations are in progress during system suspend or
hibernation, the ksys_sync() call can hang for extended periods,
leading to unresponsive system behavior. Users copying large files
to USB drives may experience black screen hangs when attempting to
suspend, requiring forced power cycles.

A specific problematic scenario occurs when data is being copied and
the system enters S3 suspend. If the block device is removed during
this process, some filesystems may not properly handle the device
disappearance and continue to believe the block device exists. This
causes ksys_sync() to be switched out and never complete, with the
following stack trace:

[<0>] __switch_to+0xd0/0x168
[<0>] iterate_supers+0x88/0x118
[<0>] ksys_sync+0x48/0xb8
[<0>] ksys_sync_helper+0x18/0xa0
[<0>] pm_suspend+0x260/0x3e8

This patch introduces a unified sync timeout mechanism for both
suspend-to-RAM (S3) and hibernation (S4) to prevent indefinite
hangs while maintaining data integrity.

Key features:
- Configurable timeout via sysfs interface
- Default behavior unchanged (timeout disabled by default)
- Unified implementation for both suspend and hibernation paths
- Graceful fallback to direct sync on thread creation failure
- Non-blocking timeout: sync continues in background after timeout

Sysfs interface:
- /sys/power/sleep_sync_timeout: Runtime configuration (0-600000ms)

When timeout is enabled and exceeded, the suspend/hibernation operation
fails gracefully with -ETIMEDOUT to prevent system hangs, while the
sync operation continues running in the background to ensure eventual
data integrity. This approach provides responsive user experience
without compromising data safety.

Implementation creates a separate kthread for sync operations when
timeout is enabled. If the timeout expires, the main suspend path
immediately returns with an error, allowing the system to remain
responsive, while the background sync thread continues to completion
independently. The sync operation is never forcibly terminated or
interrupted.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
Changes in v3:
- Added mutex protection to prevent concurrent sync timeout operations
- Removed kthread_stop() to allow sync completion after system resume
- Non-blocking timeout implementation: sync continues in background
---
 include/linux/suspend.h  |  3 ++
 kernel/power/hibernate.c |  4 +-
 kernel/power/main.c      | 88 ++++++++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c   |  6 ++-
 4 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index da6ebca3f..976c8f8a1 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -439,6 +439,8 @@ void restore_processor_state(void);
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
+extern int ksys_sync_helper_timeout(unsigned int timeout_ms);
+extern unsigned int sync_timeout_ms;
 extern void pm_report_hw_sleep_time(u64 t);
 extern void pm_report_max_hw_sleep(u64 t);
 
@@ -486,6 +488,7 @@ static inline void pm_report_hw_sleep_time(u64 t) {};
 static inline void pm_report_max_hw_sleep(u64 t) {};
 
 static inline void ksys_sync_helper(void) {}
+static inline int ksys_sync_helper_timeout(unsigned int timeout_ms) { return 0; }
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 23c0f4e6c..2678181a5 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -777,7 +777,9 @@ int hibernate(void)
 	if (error)
 		goto Restore;
 
-	ksys_sync_helper();
+	error = ksys_sync_helper_timeout(sync_timeout_ms);
+	if (error)
+		goto Exit;
 
 	error = freeze_processes();
 	if (error)
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6254814d4..a437fa0b2 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -17,10 +17,22 @@
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/pm_runtime.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+#include <linux/jiffies.h>
 
 #include "power.h"
 
 #ifdef CONFIG_PM_SLEEP
+/* Sync timeout parameters */
+unsigned int sync_timeout_ms;
+EXPORT_SYMBOL_GPL(sync_timeout_ms);
+
+/* Sync timeout implementation */
+static struct completion sync_completion;
+static struct task_struct *sync_task;
+static DEFINE_MUTEX(sync_timeout_mutex);
+
 /*
  * The following functions are used by the suspend/hibernate code to temporarily
  * change gfp_allowed_mask in order to avoid using I/O during memory allocations
@@ -79,6 +91,50 @@ void ksys_sync_helper(void)
 }
 EXPORT_SYMBOL_GPL(ksys_sync_helper);
 
+static int sync_thread_func(void *data)
+{
+	ksys_sync_helper();
+	complete(&sync_completion);
+	return 0;
+}
+
+int ksys_sync_helper_timeout(unsigned int timeout_ms)
+{
+	unsigned long timeout_jiffies;
+	int ret = 0;
+
+	/* If timeout is 0, use regular sync without timeout */
+	if (timeout_ms == 0) {
+		ksys_sync_helper();
+		return 0;
+	}
+
+	mutex_lock(&sync_timeout_mutex);
+	init_completion(&sync_completion);
+	sync_task = kthread_run(sync_thread_func, NULL, "sync_timeout");
+	if (IS_ERR(sync_task)) {
+		pr_warn("%s: Failed to create sync thread, performing sync directly\n",
+			__func__);
+		ksys_sync_helper();
+		goto unlock;
+	}
+
+	timeout_jiffies = msecs_to_jiffies(timeout_ms);
+	if (!wait_for_completion_timeout(&sync_completion, timeout_jiffies)) {
+		pr_warn("%s: Sync operation timed out after %u ms, aborting suspend/hibernation\n",
+			__func__, timeout_ms);
+		pr_info("%s: Sync operation continues in background\n", __func__);
+		ret = -ETIMEDOUT;
+	}
+
+unlock:
+	mutex_unlock(&sync_timeout_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ksys_sync_helper_timeout);
+
+
+
 /* Routines for PM-transition notifications */
 
 static BLOCKING_NOTIFIER_HEAD(pm_chain_head);
@@ -240,6 +296,37 @@ static ssize_t sync_on_suspend_store(struct kobject *kobj,
 }
 
 power_attr(sync_on_suspend);
+
+/*
+ * sleep_sync_timeout: configure sync timeout during suspend/hibernation.
+ *
+ * show() returns the current sync timeout in milliseconds.
+ * store() accepts timeout value in milliseconds. 0 disables timeout.
+ */
+static ssize_t sleep_sync_timeout_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", sync_timeout_ms);
+}
+
+static ssize_t sleep_sync_timeout_store(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	/* Allow any reasonable timeout value */
+	if (val > 600000) /* Max 10 minutes */
+		return -EINVAL;
+
+	sync_timeout_ms = val;
+	return n;
+}
+
+power_attr(sleep_sync_timeout);
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_PM_SLEEP_DEBUG
@@ -974,6 +1061,7 @@ static struct attribute * g[] = {
 #ifdef CONFIG_SUSPEND
 	&mem_sleep_attr.attr,
 	&sync_on_suspend_attr.attr,
+	&sleep_sync_timeout_attr.attr,
 #endif
 #ifdef CONFIG_PM_AUTOSLEEP
 	&autosleep_attr.attr,
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8eaec4ab1..4f8015a75 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -585,8 +585,12 @@ static int enter_state(suspend_state_t state)
 
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-		ksys_sync_helper();
+		error = ksys_sync_helper_timeout(sync_timeout_ms);
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+		if (error) {
+			pr_err("PM: Sync timeout, aborting suspend\n");
+			goto Unlock;
+		}
 	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
-- 
2.20.1


