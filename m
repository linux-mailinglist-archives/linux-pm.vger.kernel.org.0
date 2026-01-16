Return-Path: <linux-pm+bounces-40957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA99D29A4F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 02:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C56B0301A731
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 01:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA73358CF;
	Fri, 16 Jan 2026 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hLMudqQP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5C335545;
	Fri, 16 Jan 2026 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527632; cv=none; b=Ejvt7mYmt6oPYt2WqfiSda/kiAA99G6mYSfEOiy6R/RMHpFY6S0mTxIIuaxjaHg1eNp8VbT4NdupnmqPfvVRL9jqeMrJFHubAAFkaROMxCrbxmbUpR6mungXx/9MiMG6EdcqkgN7A5yMR6okQ+vCwlMiuvbkqZZpcsIhCSHNBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527632; c=relaxed/simple;
	bh=cl9G9gUCCefSwZQztfZ/hIVtxBY3FjWjwztkJQsRzbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PdXNcbtG6a4uEEa7OMgXOMsre2M7eAWBUBs+MSRFjD7Nk4Wh/6BCgv5PYiP9Zog+AYAdtLXNydqH1JKPL+VxZIqF9XcUqKB9JHiLQLimTa4C1kW7ABY7LzLceERX1fvEYO+jhPPkgQaPaXFuAK8BzrYU0kqNn+lUxdJkpa4Fnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hLMudqQP; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1768527582;
	bh=i8sax+Q6GvwgMz1ddDPfZuAAjgqNWAWZQw9z3RdR4M8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hLMudqQPJ+9S+KEumWu7wDdQJug3lWRxqGKM9SRU3t/n/BoYM8BkZ+h1aqQ0mPkIo
	 kmyaVOC9C+yOWIw7AFkv4PnsThzcE2H/YrvAzIl0Bg5WUUyxJlmhc7OsFmewmND4Fy
	 NEMu2ymLxfLD4sj0xrZzAGIBAvkYi3Qt2IVNseLY=
X-QQ-mid: zesmtpip3t1768527565t30b1972b
X-QQ-Originating-IP: FZA9/ZOd7kklH5gWdfU9zIva4egROiXgcWnwkELrUe4=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 Jan 2026 09:39:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12821783964837250733
EX-QQ-RecipientCnt: 7
From: tuhaowen <tuhaowen@uniontech.com>
To: pavel@kernel.org,
	rafael@kernel.org
Cc: tuhaowen@uniontech.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	saravanak@google.com
Subject: [PATCH v1 RESEND] PM: sleep: Add configurable timeout and mode control for filesystem sync
Date: Fri, 16 Jan 2026 09:39:17 +0800
Message-Id: <20260116013917.979567-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251229065251.3315787-1-tuhaowen@uniontech.com>
References: <20251229065251.3315787-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MSyoPQEuxKCufVAPApr51F91mbvk1zcYI51/jjxcd0tllBvg3vfbHhrA
	nC2nagLgsJ2DV30+XUIz3il+kecn9zdp7doMC9DqNhD0t7YDbUqG3GsNwhFctcGSVCFSL/6
	DCGwCHGKavELWHvKdexkBJZjGEPC4+fU9WxGkR4NBDO4e4GaqFfH/DR2G74Omen8w9722XH
	Woy8WIhUBWSAguw3QvqeWU28X0aFjzVyi1AkcJ8CuHSt5TZOCUJGkSFUZovSlsReC0zsV8q
	eRhQUksyypo2z/u0krmxp51ofYszt6s2P45RMUkAhKZ8SOpdiZiudCIRRvS/5d6lSxu9vGU
	z/SKtV2opPJFZWsReuLZhxJY6M4rWCLTiSgaSW+5ZZo8/ZNGxJZMezx92BuJJ1WiccgLrIv
	6YWRkcW069bKYvTa9PuwfpfuzO1p+i+ekgtlsviFqBK5tgsazU2MUyCqyrrEmyMGH6T271d
	mIFLNT1FaaZ0+KMMgFHU3JMmxvFqdXjgtkPBXm3VYpXkkMfRN1F4jbDdsqOE/d9kMqC/UCS
	1S68HReaNuF2y5I9qdpHpsGa0A8nfG/sv5LxYUZmFV7MpWDSVr7AeKhxQ49bUpL9svrWUbq
	K5IRPp6QSIIfcwo2olvYFIxs9yyE16oojk6eyvYFf0igEMJ9C43L9bzoMepv2fOXrqeOnHL
	OpI2OgfSpDWpZ/nnh3FwGOMDfE+oa7xitgNAu/cepiSzrbRjQRglfYCps1Y1FGBRPIWI43J
	FDCwIwqVjbCB34Lx35uffosBnXLv2lP9lS9AngsO5VbUxJyu3ZnP61/IPCuImjvnVeZ7NTy
	KvHGNnF4ngsQQ6uM2kEAC4hUoMWHS3hNVCivBrubY9LCQMFCpXvbBdxjaYjGfGmpKepX9kZ
	4qnNtqomvT6/Rq2RM4yw+hRxBdSQB/G24G4ZMPY9SZTz7T2Fqtneb7VkhhVBgVMu6MjTmlb
	sYXpAVAlgTk0/9UsJQCteAVbffgzZZpH2nQRyXh8VKoMpgSxy4pqc+ERA0LpyZWbRWpJSmE
	d0GgQ1PYCxttqCiSIBy8Cna7EEV7h4me/aW8HzUg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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


