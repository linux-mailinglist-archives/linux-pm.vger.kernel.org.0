Return-Path: <linux-pm+bounces-33899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5865B44BD1
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 04:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB9C488073
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 02:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054C42749ED;
	Fri,  5 Sep 2025 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OCt3hXJv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93665271468;
	Fri,  5 Sep 2025 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040472; cv=none; b=UyjvCucnpxMZwK/8+Ub17A833rmPKNNoEZB82S0ZsFrnYpdNqirkpx76+rTZ15AmhkCv1cvRMbDEJCwLt8ReI+IMwMP5J0WJnfcrFyz5OL9z7io1bv0rMVA3qkCs0ttzFQNN8cdzXYAr/411ujTesVsLv9a3MpzxnFavszUIx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040472; c=relaxed/simple;
	bh=N60s4+7FghpNzyq7v5VvavLnPHbvQfoeNWF8zIPvD3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cfj2wpNZAWHUJLIwr5rFLcyPTSrzYFRZuK1Rgy4y+X7HVq4s99vSvGNso6ZC/4fI6SpY4lX74wJjZNRXIYCqc/CccqxfBqXCTwp1/ZwXFc1Hs+EZDgw5EJhp6AVstlC/EdksYPDrLkFEU3RsJkyTgcMJ1OJTr1wKj9/pnATpKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OCt3hXJv; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1757040432;
	bh=dHbqnUGqjaTP70or5D9/fVYz69QM9vmlVjjHYRsgMpU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=OCt3hXJvy+my/6nWeo23I3XGXXiDOuCn0b1DRHr2jZP1UE/4B9l21mkrpffeB+Les
	 gvOIb3RIidMBB51U2fcWxFA0U0hKvBpr8dyKgdqCPsGkZPyKvxVct+xfRY+TqAhCD9
	 MkcNde9SEUOqgrPgkB6VoF5qYbhNi/v3wHsMNdiU=
X-QQ-mid: zesmtpip2t1757040426t4dbc63c1
X-QQ-Originating-IP: TcsgnCJLV3TMgXLgi4Dhlt9ZLLboDPsTjLcfca1rHYI=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Sep 2025 10:47:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7429805484528472027
EX-QQ-RecipientCnt: 7
From: tuhaowen <tuhaowen@uniontech.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tuhaowen@uniontech.com,
	huangbibo@uniontech.com
Subject: [PATCH] PM: Add configurable sync timeout during suspend and hibernate to prevent hang
Date: Fri,  5 Sep 2025 10:47:02 +0800
Message-Id: <20250905024702.1214-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NlWvLSkfVnGc3NCZzfwkfv/2iy1I2bGTOYiovfP7uRCPYTZP5L7BKRLb
	IPwPhGyqUyIFPlhEYThK6Z28A8SAzRJjm2sU3UGcT2p9309oMtpIyUMTE/Mbt9ycmRxwc3Y
	jlarwZlgDWWHjDwPmsjNZT9yYCC/NvMRMSZpLjM4G92lSb5jxUx/+2ArBPg6/nM+ZfB8f35
	SAGucIRTjMobm5+AMt8t88jUwVypg/16wUG+vwLxC+p/+q1oY+03G+XXSfpOCthGtvVkWj3
	5n0ScmS3pFmdPUuvV9Tn6SZU5TvkimHwoaKUdOzSQIUT9SVhg/EXtfzbmdxUhLcsuqaWH/9
	peruGxqXvPSP2oShI5/7QyQI4iPXHsn1Wk7xIX4GvYT+xBMS/fMuYItGeDSFr9NBj7ULWx7
	Mz6WNMt7ae5bo9xzGZyoIS+lWhPKYzgbcLxZrsqEwSPev74LW6qRo6iaBSvOxqzQW6VO/pD
	5QdTc01JHVZoKMQk9SzP/8OyUl43QOHeui20NzBY3uGB6r/FVVKVYOAkLVGq7tOmHSIRFgR
	UphYzn04XStkpq7+gD2k+sGVIMQVlvrTX6FlFIWFKgHjmRWh/FTC247/r9GWWvsCf3ndI+R
	vwx+CEdq9TTQcgEPMXteLP4jd7No9ufYLHlI36ZlE6i8UKKBMP/My2WavrB6e29PGL2Q9yn
	ZCo5GF0L30Ihjl0DHRQy24+oLqCTvci9lCNqdjAwy9KYk8NaWgB37sE/WpjxB3WQTxcQTup
	CIhSNSNq04atxjuz1cWoH4/LIBEkVxzZLYi+CeMTT3ob5BSNRe8duTCPuQZ84FENXBJzO1u
	N9diVGXDX6AR1xlxRxfXoavH5lOOscKXtQZhIYbjq1aLlRmTeDBd4IAk0ThVb82uDQcs/AX
	z1Xru/tPixJRorkVYYvW3klk6pcv7Bwa6O5JfYJ2jh+ATI8fqXmzIFlW4KY5ZOYto/ZL5Oh
	I91fDNLY8sV8ZEvtcqIZXEBIycpj23hbfMPPxmpj3qHpRkgiVUsHd7NyFEaXmqEG5+YEls2
	dpm1HKp36dz7X/Rk6X
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

When users initiate suspend (S3) or hibernate (S4) while large file
copy operations are in progress (especially to USB storage devices),
the system can appear to hang with a black screen for an extended period.
This occurs because the filesystem sync in the suspend/hibernate path
blocks until all pending I/O operations complete,
which can take several minutes for large file transfers or slow devices.

This patch introduces an optional, configurable timeout mechanism for
the sync operation during both suspend and hibernate.
If the timeout is reached, the operation is aborted,
and a clear error message is provided to the user, improving user
experience by preventing indefinite system hangs.

The timeout is disabled by default for both suspend and hibernate
to maintain backward compatibility. If enabled, the default
timeout value is 10000 ms (10 seconds), which can be changed
at runtime via module parameters:

- sync_on_suspend_timeout_enable (bool, default: false)
- sync_on_suspend_timeout_ms (uint, default: 10000)
- sync_on_hibernation_timeout_enable (bool, default: false)
- sync_on_hibernation_timeout_ms (uint, default: 10000)

Compared to [PATCH v3 0/3] PM: Support aborting suspend during
filesystem sync (see: https://lore.kernel.org/linux-pm/20250821004237.
2712312-1-wusamuel@google.com/), this patch addresses scenarios where
there may be no wakeup event, but the sync operation is excessively
slow (e.g., due to slow or faulty storage). By introducing a configurable
timeout, it proactively prevents indefinite hangs and improves user
experience in a wider range of real-world cases. The implementation
is also simpler and gives users or system integrators more flexibility
to tune behavior for different devices and requirements.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
 kernel/power/hibernate.c | 55 ++++++++++++++++++++++++++++++++++++++-
 kernel/power/suspend.c   | 56 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 23c0f4e6c..2c173a0e5 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -33,10 +33,27 @@
 #include <linux/ktime.h>
 #include <linux/security.h>
 #include <linux/secretmem.h>
+#include <linux/moduleparam.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+#include <linux/jiffies.h>
 #include <trace/events/power.h>
 
 #include "power.h"
 
+/* Sync timeout parameters for hibernation */
+static bool sync_on_hibernation_timeout_enable;
+module_param(sync_on_hibernation_timeout_enable, bool, 0644);
+MODULE_PARM_DESC(sync_on_hibernation_timeout_enable, "Enable sync timeout during hibernation (default: false)");
+
+static unsigned int sync_on_hibernation_timeout_ms = 10000;
+module_param(sync_on_hibernation_timeout_ms, uint, 0644);
+MODULE_PARM_DESC(sync_on_hibernation_timeout_ms, "Sync timeout in milliseconds during hibernation (default: 10000)");
+
+/* Sync timeout implementation for hibernation */
+static struct completion hibernation_sync_completion;
+static struct task_struct *hibernation_sync_task;
+
 
 static int nocompress;
 static int noresume;
@@ -97,6 +114,40 @@ bool hibernation_available(void)
 		!secretmem_active() && !cxl_mem_active();
 }
 
+static int hibernation_sync_thread_func(void *data)
+{
+	ksys_sync_helper();
+	complete(&hibernation_sync_completion);
+	return 0;
+}
+
+static int hibernation_sync_with_timeout(void)
+{
+	unsigned long timeout_jiffies;
+
+	if (!sync_on_hibernation_timeout_enable) {
+		ksys_sync_helper();
+		return 0;
+	}
+
+	init_completion(&hibernation_sync_completion);
+	hibernation_sync_task = kthread_run(hibernation_sync_thread_func, NULL, "hibernation_sync");
+	if (IS_ERR(hibernation_sync_task)) {
+		pr_warn("PM: hibernation: Failed to create sync thread, performing sync directly\n");
+		ksys_sync_helper();
+		return 0;
+	}
+
+	timeout_jiffies = msecs_to_jiffies(sync_on_hibernation_timeout_ms);
+	if (!wait_for_completion_timeout(&hibernation_sync_completion, timeout_jiffies)) {
+		pr_warn("PM: hibernation: Sync operation timed out after %u ms, aborting hibernation\n",
+				sync_on_hibernation_timeout_ms);
+		kthread_stop(hibernation_sync_task);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
 /**
  * hibernation_set_ops - Set the global hibernate operations.
  * @ops: Hibernation operations to use in subsequent hibernation transitions.
@@ -777,7 +828,9 @@ int hibernate(void)
 	if (error)
 		goto Restore;
 
-	ksys_sync_helper();
+	error = hibernation_sync_with_timeout();
+	if (error)
+		goto Exit;
 
 	error = freeze_processes();
 	if (error)
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8eaec4ab1..144caf525 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -30,9 +30,25 @@
 #include <trace/events/power.h>
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+#include <linux/jiffies.h>
 
 #include "power.h"
 
+/* Sync timeout parameters for suspend */
+static bool sync_on_suspend_timeout_enable;
+module_param(sync_on_suspend_timeout_enable, bool, 0644);
+MODULE_PARM_DESC(sync_on_suspend_timeout_enable, "Enable sync timeout during suspend (default: false)");
+
+static unsigned int sync_on_suspend_timeout_ms = 10000;
+module_param(sync_on_suspend_timeout_ms, uint, 0644);
+MODULE_PARM_DESC(sync_on_suspend_timeout_ms, "Sync timeout in milliseconds during suspend (default: 10000)");
+
+/* Sync timeout implementation for suspend */
+static struct completion suspend_sync_completion;
+static struct task_struct *suspend_sync_task;
+
 const char * const pm_labels[] = {
 	[PM_SUSPEND_TO_IDLE] = "freeze",
 	[PM_SUSPEND_STANDBY] = "standby",
@@ -61,6 +77,40 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
+static int suspend_sync_thread_func(void *data)
+{
+	ksys_sync_helper();
+	complete(&suspend_sync_completion);
+	return 0;
+}
+
+static int suspend_sync_with_timeout(void)
+{
+	unsigned long timeout_jiffies;
+
+	if (!sync_on_suspend_timeout_enable) {
+		ksys_sync_helper();
+		return 0;
+	}
+
+	init_completion(&suspend_sync_completion);
+	suspend_sync_task = kthread_run(suspend_sync_thread_func, NULL, "suspend_sync");
+	if (IS_ERR(suspend_sync_task)) {
+		pr_warn("PM: suspend: Failed to create sync thread, performing sync directly\n");
+		ksys_sync_helper();
+		return 0;
+	}
+
+	timeout_jiffies = msecs_to_jiffies(sync_on_suspend_timeout_ms);
+	if (!wait_for_completion_timeout(&suspend_sync_completion, timeout_jiffies)) {
+		pr_warn("PM: suspend: Sync operation timed out after %u ms, aborting suspend\n",
+				sync_on_suspend_timeout_ms);
+		kthread_stop(suspend_sync_task);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
 /**
  * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
  *
@@ -585,8 +635,12 @@ static int enter_state(suspend_state_t state)
 
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-		ksys_sync_helper();
+		error = suspend_sync_with_timeout();
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+		if (error) {
+			pr_err("PM: Sync timeout, aborting suspend\n");
+			goto Unlock;
+		}
 	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
-- 
2.20.1


