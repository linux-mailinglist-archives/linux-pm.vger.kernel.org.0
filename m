Return-Path: <linux-pm+bounces-40003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB87CE60CD
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 07:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90AD03004187
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 06:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829CD238C29;
	Mon, 29 Dec 2025 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gSNOBtKK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D02253B0;
	Mon, 29 Dec 2025 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766991230; cv=none; b=hxWIEPJbf9HHwx2f2yEue5m3fx05u+2grQnuhn34k3JP4WIeovC2h3IiqCAOE/55L1ZoE7vAyYCP6vlKiON3/SYqmfSXPMFHqkby0kdQQmWo+IotM3GGwb/jGIYv8Pmlxdfd7cFwT9TUMLAGT8OIGthLQbv3YvpViFIz9NoGVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766991230; c=relaxed/simple;
	bh=cl9G9gUCCefSwZQztfZ/hIVtxBY3FjWjwztkJQsRzbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hY7FoA4WHNwJPJBGXrupFJMQddaRYqwEJFHRJWl4GBX1AfzjBJSxeu6qTCNtwVpfSd5UrUD5zzJmSlJsg/tq4uhrk4K4R1zNbhVKm2244DSm4kvqs99PzMPAhVfrUeHJ1f12cso8IXjrM4jW2AXGDq3gKEviejTYQvrDQ5LYLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gSNOBtKK; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1766991205;
	bh=i8sax+Q6GvwgMz1ddDPfZuAAjgqNWAWZQw9z3RdR4M8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gSNOBtKKjSWqQjlwHwK0be/jZdsd5ZLJQMDbL11IaYc6N67OpUQK8mGECbxkKwwyT
	 g2Ou3h/pOaTbtl4BTRQBzbFytXipSvibY4q+7QNnS7Fl42XwGIKox9JfA0tnIh1t3R
	 ytlyYuTV/IEj2tquu7AYwpAQh1eDHTES8nVUUHQA=
X-QQ-mid: zesmtpip2t1766991200tff807f1a
X-QQ-Originating-IP: 1tqCCaoGDM+BgSTgaxbKAyY0FdW+6zZmy2kGzi/eiwU=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Dec 2025 14:53:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13051461574331737292
EX-QQ-RecipientCnt: 6
From: tuhaowen <tuhaowen@uniontech.com>
To: rafael@kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tuhaowen@uniontech.com
Subject: [PATCH v1] PM: sleep: Add configurable timeout and mode control for filesystem sync
Date: Mon, 29 Dec 2025 14:52:51 +0800
Message-Id: <20251229065251.3315787-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OTUHZG7Ulf3mRVs5EzSz1vMVPSDFN1UjsWDd9Z+l/TPY5RfUAA26Ejw2
	AZX54c2Q4KokRLO0xywpklkZFCXNrpEkSaJl6c3SXTTcUzfy7/koXwzWSybCw0onXQ/uKQk
	ppHDLVy+IvXwr3TVi8V8xsHmrLN3+npk2EucjIb8+Bc/4HVZDTDnia4kNa5gS49Z0Eas8fZ
	B1k3YmjfKLeAhRlUWE2U1KHJah+vP0RjLR/ndPb6JUu3tDH4YDIACO7MwUVBt9OHeEqdgIm
	0j4eN7XV+3yiIchyMfeohbQye+mDgwj0lKOtqBNIdiJfGpu8W2q+3e7byDBOyJGl8Sv8vEv
	JHqyKG+ho9D9WljTsvfWJN2FHhbX90PYyCyHDTLdd9uYGRHSx+Je67rHez97gXtqW/vJRQg
	pNEelOSv+4TLg1070LhPuS0gcQ/aCg/tu9KA4J9uMrUkoRbXmCrnseTW38M9e6IrFuwvAes
	9WbM1xAM8ArZcj17danemU6zoFAyPO/gPqDwsT/FDehmNC7HKXL2hEVHnvMMxdX8BqNgvhL
	PmCToqyaAX3jB4bWrcCTzUYfLsUDXE/IkXZradX8IooeqdwpNYYmO4MxylpH2O6xTODI+0A
	/fVMS8dXTrfbz7elk9wOfnGr8NYeLGbxZZjsCJHNfm8nUHV7qJItGV06nFBa7cibDl3Ho3o
	OrrpJ2sv+BNOGZk6UUGGfg0tRNB0yoxu9n6bT/auLVWsD7qPck7WVMVdzX8FU0Z49QsfT9l
	Wg4HKMAsQvcTxqWOh/V5GHiLZ/MoornxZwPNQQyKy3g/XlYvWlcZE6XWzqbPTBvsHZBIqrv
	B3b/XPK873e7JZnXKyPNCbowJ9x/bZO16bNDs+HRgF6d4KRkst4czy90WFr7G5k6lvJrGP8
	SEI2qAb904udNlUonQWOWSat7WCTRPNpU3aVa+Qn26gMkp20M0PgONAXrtT1aeJYelpu21t
	OT85Zb8ivEaqAhamtgIjVhjP99YDkU9RGwPdzFnKkHSlm1GuQsYSfSotLFy+f4tfjRGFFrZ
	+ohH1XmZjBGPbnrnRJcJMEbl26ULc=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

When users trigger system suspend on desktop systems, filesystem sync
can take 10-25 seconds or even longer if there are slow/faulty storage
devices (e.g., a failing hard drive or disconnected USB drive). During
this time, the screen goes black and the system appears completely
frozen with no visual feedback. Users cannot distinguish whether the
system is "syncing filesystems" or has "crashed/hung", leading them
to perform a hard reset, potentially causing data loss.

While the existing wakeup event mechanism allows aborting sync via key
presses (designed for mobile devices), desktop/laptop users often don't
realize they can press keys during the black screen. Instead, they tend
to force power off by holding the power button, assuming the system has
hung. This is especially problematic with faulty storage devices that
cause indefinite sync hangs.

This patch adds a timeout mechanism to automatically abort filesystem
sync after a configurable duration, preventing indefinite hangs without
requiring user intervention:

1. /sys/power/fs_sync_mode (0 or 1, default: 0)
   - Mode 0: Check wakeup events, allow user to abort sync
   - Mode 1: Only use timeout, ignore wakeup events

2. /sys/power/fs_sync_timeout (0-300 seconds, default: 0)
   - Set maximum wait time for filesystem sync

The fix adds timeout mechanism to pm_sleep_fs_sync(). When timeout
expires or user presses a key (mode 0), the sync is aborted and
suspend proceeds, preventing indefinite hangs. The default behavior
(mode 0, timeout 0) maintains backward compatibility.

Link: https://lore.kernel.org/all/CAJZ5v0g_HXQjWfp=L0KetRCHMTD=QsP3wJKNZnadJic2yccCUQ@mail.gmail.com/

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
 kernel/power/main.c | 94 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 03b2c5495c77..bb7dd73e18fc 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -102,6 +102,12 @@ static atomic_t pm_fs_sync_count = ATOMIC_INIT(0);
 static struct workqueue_struct *pm_fs_sync_wq;
 static DECLARE_WAIT_QUEUE_HEAD(pm_fs_sync_wait);
 
+/* Timeout for file system sync during suspend/hibernate (in seconds) */
+static unsigned int fs_sync_timeout_secs;
+
+/* File system sync mode: 0 = interrupt mode, 1 = timeout mode */
+static unsigned int fs_sync_mode;
+
 static bool pm_fs_sync_completed(void)
 {
 	return atomic_read(&pm_fs_sync_count) == 0;
@@ -119,11 +125,15 @@ static DECLARE_WORK(pm_fs_sync_work, pm_fs_sync_work_fn);
 /**
  * pm_sleep_fs_sync() - Sync file systems in an interruptible way
  *
- * Return: 0 on successful file system sync, or -EBUSY if the file system sync
- * was aborted.
+ * Return: 0 on successful file system sync,
+ *         -EBUSY if the file system sync was aborted by wakeup event,
+ *         -ETIME if the file system sync timed out.
  */
 int pm_sleep_fs_sync(void)
 {
+	unsigned long timeout_jiffies = 0;
+	unsigned long start_time;
+
 	pm_wakeup_clear(0);
 
 	/*
@@ -137,16 +147,90 @@ int pm_sleep_fs_sync(void)
 		queue_work(pm_fs_sync_wq, &pm_fs_sync_work);
 	}
 
+	/* Setup timeout only in timeout mode (mode 1) */
+	if (fs_sync_mode && fs_sync_timeout_secs > 0) {
+		timeout_jiffies = msecs_to_jiffies(fs_sync_timeout_secs * 1000);
+		start_time = jiffies;
+	}
+
 	while (!pm_fs_sync_completed()) {
-		if (pm_wakeup_pending())
+		if (!fs_sync_mode && pm_wakeup_pending())
 			return -EBUSY;
 
+		if (fs_sync_mode && timeout_jiffies > 0 &&
+		    time_after(jiffies, start_time + timeout_jiffies)) {
+			pr_warn("PM: File system sync timed out after %u seconds, proceeding with suspend\n",
+				fs_sync_timeout_secs);
+			return -ETIME;
+		}
+
 		wait_event_timeout(pm_fs_sync_wait, pm_fs_sync_completed(),
 				   PM_FS_SYNC_WAKEUP_RESOLUTION);
 	}
 
 	return 0;
 }
+
+/*
+ * fs_sync_timeout: Control file system sync timeout during suspend/hibernate.
+ *
+ * show() returns the timeout value in seconds.
+ * store() accepts a value in seconds. 0 means no timeout (only interrupted by wakeup events).
+ * Non-zero values will cause the sync to be interrupted after the specified time.
+ */
+static ssize_t fs_sync_timeout_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", fs_sync_timeout_secs);
+}
+
+static ssize_t fs_sync_timeout_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	/* Allow values from 0 to 300 seconds (5 minutes) */
+	if (val > 300)
+		return -EINVAL;
+
+	fs_sync_timeout_secs = val;
+	return n;
+}
+
+power_attr(fs_sync_timeout);
+
+/*
+ * fs_sync_mode: Control file system sync behavior mode
+ *
+ * 0 = interrupt mode (default): check wakeup events during sync, can abort suspend/hibernate
+ * 1 = timeout mode: ignore wakeup events during sync, only use timeout
+ */
+static ssize_t fs_sync_mode_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", fs_sync_mode);
+}
+
+static ssize_t fs_sync_mode_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val > 1)
+		return -EINVAL;
+
+	fs_sync_mode = val;
+	return n;
+}
+power_attr(fs_sync_mode);
 #endif /* CONFIG_SUSPEND || CONFIG_HIBERNATION */
 
 /* Routines for PM-transition notifications */
@@ -1085,6 +1169,10 @@ static struct attribute * g[] = {
 	&mem_sleep_attr.attr,
 	&sync_on_suspend_attr.attr,
 #endif
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+	&fs_sync_timeout_attr.attr,
+	&fs_sync_mode_attr.attr,
+#endif
 #ifdef CONFIG_PM_AUTOSLEEP
 	&autosleep_attr.attr,
 #endif
-- 
2.20.1


