Return-Path: <linux-pm+bounces-33942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2562CB4531C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 11:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4FA161D78
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00FACA5A;
	Fri,  5 Sep 2025 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="V505oIzl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46EB4C9D;
	Fri,  5 Sep 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064364; cv=none; b=OD9HFYM8dOhg0A7mi5SaAxmfFXTFyk6IoTgsAGT61m1fCzYv5enhMIbXn2+qS99AsV25eA5B/vbC+PtRJl3+hsOtb4/0ouLj/oEMaEdrD2E6bxxiEE15W8SO/bx3244gF5BXIP4U+dMjl7hjPiGwS24qPSXSK7MctFCC5/resus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064364; c=relaxed/simple;
	bh=3zvekOl/XUiFqh4vR601bBqR6NZW8zUuGgIujgaGiWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TsZ9Mj56rYnUsAZXfAtlu5lMlN9QY8eipjnXT4Dcmac9g5ETDFYS9SY9Zc/FmgqvgxveJU98skeO8SkTAguVIydCBvQVnfcSnNsCqUuDYtULJz5mXrU0HUIR9KLc1qchQd7Tdj0NbgAR0t5yhxK7KkVzyT8JZKrIopmlKd5gvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=V505oIzl; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1757064290;
	bh=NSrcGanPs+5thfVBp9IfRff+Z3I/BYaUE7ZN230XMHE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=V505oIzlFc9WXaTEemOeh0habn2DXooxe+QQoJLzM/AnSHX+8AFq/KopIDegEzr4N
	 2EtYO/cLRsaTHnGZeTsLRyM1QJ9tB5OLGTw/VlFnV1vvlTlJQA/ZNxwk9e3AjpT1j1
	 X3Cke2GrRS5bu/vYa7yoK1dUonk81kwxBtmCaY0E=
X-QQ-mid: zesmtpip2t1757064283t11615352
X-QQ-Originating-IP: mlRFQHyC4nBT6gVb+OjwyzNfdLiKfLDPbT+9EicTTQE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Sep 2025 17:24:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14279267152202296948
EX-QQ-RecipientCnt: 7
From: tuhaowen <tuhaowen@uniontech.com>
To: len.brown@intel.com,
	pavel@kernel.org,
	rafael@kernel.org
Cc: tuhaowen@uniontech.com,
	huangbibo@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] PM: Add configurable sync timeout for suspend and hibernation
Date: Fri,  5 Sep 2025 17:24:33 +0800
Message-Id: <20250905092433.15257-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250905024702.1214-1-tuhaowen@uniontech.com>
References: <20250905024702.1214-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OZuCtzQljvyFda5zDYJjU3XsFzRs1S3hBWUcYTBtNYUDeuiUOk81THBo
	fbgRp6cdI/AI1ZksDBlFt+xW7HpArIUvXJ6xsq4S8rj+maWZXBJtKQIHICfq+Bnj8LgHWvd
	Cx99j0f6p1XiXMzy2ZahFWd6h2/VDG6eTly+kiWeOiI1/AbNn8y/0f6pXxj8g9szvEwkJkk
	JcruDOwNcPHi8jgrJrsPTQlja3XvsLe8FQCKK40Vpf+FaGjY8dq3T+qJOcLDYFPo1WnliFA
	T/WokkcGkJ3zbXeQTlXc7a69CnArNJc1hhrH1qO5D2DywkafItS+NtLBipL6D4DE0xEvajM
	J7prgG8LRXcVQLaMmoIoaT5GZ/Avql2DEGsq4qiwuyktHOyrPRMe1lspFxebKuk6TzyJNXP
	7miaXegC8eJ7zLJzwK08IYwcgcTPepr+HvX+xAM8rfzQoXy/wn2FE4oso/4khYx0HfS4eqF
	X1NU1B9eEnV9qJqHfzXapg3LD5DTRNoxYU5xDTgztlvBMuh9T9n3bfGkZFAn5VzZtNVipfz
	dBn/u1IVVXbuZX1nC+57Tc/u8cPSHtA7eJpuCsYgCfRFpIiCwIn72KmSstJUp1TKCaeBdIb
	RSgzbYDSi6F00LLc/lJs0ELcVawa0orLV/gcikYFmYTgpod7wFJ1Ud+yvV0pyosrw95nYZq
	AI47Z1Ik8BETVrkHZhKJdoRIR8AYPUIj1I+6wjBaH2JdqSDzCCxNiCGzstFcPu1Kxo1vckw
	iKXGUnXR3aup3cqKonLEFwV1PBUwYTBNV+g33YdEJdHLizH852mYfTb9nNApS8/2AGV7f1F
	jUDzHD/+MIw3gOcDugGdJXuxtsbSMJbzP75xk4ZdTN8cw0kkhkfsHg0qulfxcHtuMb5147+
	tyWDen3bcRcHKDLASKoA5HhDJO1+uNzcqSJ9DXAFoWrerNHbSYKAEcLbi0hpL3Ab5wMf/6s
	n1QKflh3vTTNp6FV/Fp02N9874GYQqT0iYM7v/FHHbr4KaKFQxFT6/AYxLluGOWJ5ISu29+
	aOGRfek6+xb5oBhhD8ojfqxLL/YPc9ZAslNsFRWLbO8dWOb/qI
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

When large file operations are in progress during system suspend or
hibernation, the ksys_sync() call can hang for extended periods,
leading to unresponsive system behavior. Users copying large files
to USB drives may experience black screen hangs when attempting to
suspend, requiring forced power cycles.

This patch introduces a unified sync timeout mechanism for both
suspend-to-RAM (S3) and hibernation (S4) to prevent indefinite
hangs while maintaining data integrity.

Key features:
- Configurable timeout via sysfs interface
- Default behavior unchanged (timeout disabled by default)
- Unified implementation for both suspend and hibernation paths
- Graceful fallback to direct sync on thread creation failure

Sysfs interface:
- /sys/power/sleep_sync_timeout: Runtime configuration (0-600000ms)

When timeout is enabled and exceeded, the sync operation is aborted
and suspend/hibernation fails gracefully with -ETIMEDOUT, preventing
system hangs.

Implementation creates a separate kthread for sync operations when
timeout is enabled, allowing the main suspend path to maintain
control and abort if necessary.

Compared to [PATCH v3 0/3] PM: Support aborting suspend during
filesystem sync (see: https://lore.kernel.org/linux-pm/20250821004237.
2712312-1-wusamuel@google.com/), this patch addresses scenarios where
there may be no wakeup event, but the sync operation is excessively
slow (e.g., due to slow or faulty storage). By introducing a configurable
timeout, it proactively prevents indefinite hangs and improves user
experience in a wider range of real-world cases. The implementation
is also simpler and gives users or system integrators more flexibility
to tune behavior for different devices and requirements. Additionally,
the ksys_sync_helper_timeout() interface is designed as a reusable
generic function that other kernel subsystems can leverage when they
need sync operations with timeout control, promoting code reuse and
reducing maintenance overhead across the kernel.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
Changes in v2:
- Unified timeout logic in kernel/power/main.c
- Removed duplicate code from suspend.c and hibernate.c
- Added sysfs interface for runtime configuration
- Changed default to 0 (disabled) for backward compatibility
- Increased maximum timeout to 10 minutes
- Simplified parameter control (removed separate enable flag)
---
 include/linux/suspend.h  |  3 ++
 kernel/power/hibernate.c |  4 +-
 kernel/power/main.c      | 82 ++++++++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c   |  6 ++-
 4 files changed, 93 insertions(+), 2 deletions(-)

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
index 6254814d4..3912f221a 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -17,10 +17,21 @@
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
+
 /*
  * The following functions are used by the suspend/hibernate code to temporarily
  * change gfp_allowed_mask in order to avoid using I/O during memory allocations
@@ -79,6 +90,45 @@ void ksys_sync_helper(void)
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
+
+	/* If timeout is 0, use regular sync without timeout */
+	if (timeout_ms == 0) {
+		ksys_sync_helper();
+		return 0;
+	}
+
+	init_completion(&sync_completion);
+	sync_task = kthread_run(sync_thread_func, NULL, "sync_timeout");
+	if (IS_ERR(sync_task)) {
+		pr_warn("%s: Failed to create sync thread, performing sync directly\n",
+			__func__);
+		ksys_sync_helper();
+		return 0;
+	}
+
+	timeout_jiffies = msecs_to_jiffies(timeout_ms);
+	if (!wait_for_completion_timeout(&sync_completion, timeout_jiffies)) {
+		pr_warn("%s: Sync operation timed out after %u ms, aborting\n",
+			__func__, timeout_ms);
+		kthread_stop(sync_task);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ksys_sync_helper_timeout);
+
+
+
 /* Routines for PM-transition notifications */
 
 static BLOCKING_NOTIFIER_HEAD(pm_chain_head);
@@ -240,6 +290,37 @@ static ssize_t sync_on_suspend_store(struct kobject *kobj,
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
@@ -974,6 +1055,7 @@ static struct attribute * g[] = {
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


