Return-Path: <linux-pm+bounces-33211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF068B39252
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 05:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C51E7B77AB
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 03:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8751F8AC5;
	Thu, 28 Aug 2025 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GTCf1Qch"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1ED1DE8B3;
	Thu, 28 Aug 2025 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352849; cv=none; b=dMN+WgiEUrZTELMPR455bHQ90jrLb0bRduuU4hdV3+i7wcrg7ocPg6n69CxxY9StoUVxGyKXqtMETh3SGz74jHlsnyzEgurDm63VopCUiIzN6UQgTT834ttjguIQt2ek4SjyifUebmZJDNu2HdE24e6bTFuEtuCJ3cveWNKt4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352849; c=relaxed/simple;
	bh=KDHCN7BwimAXAdhEenYspj+eCnOF9MrveCuzMKkRT0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=so+QJ/V4R8E7ZFMZGu2/HJfEUABvJs4Rm96dNZLg/pbG9XSyxHBcaxwj1r/rTazEB9xin+Al6xfzQ+NVzecVV/EknoJlvhQQXrlhyFgtdEz0tkIjlF6KQ84ouRMWaZepY6W9G6xiMnFpgPHwhGJ/GpfhWPBZHKvRqzhALe5g9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GTCf1Qch; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1756352823;
	bh=xlKAOiVXiHODSXJvcs1IbGt+M3nwyvROfioraEC390o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=GTCf1QchlxrMr3Z/VolruSlz084s8cNajdP8bBKvLC9dhZOdeGM3flG2SqnokWS0m
	 QBGmUwN1uzAyZT+ptCv2c0m9k9RM2ypHfjzXXitVKmIN5jf7kimdP4M/yzx6MRv3yb
	 f3vCBMM11Wf9F+1dE2lMhKWVzLQQGOttEVPsspwg=
X-QQ-mid: zesmtpip4t1756352815t49050dbf
X-QQ-Originating-IP: EF7BkL+oyaNazOyjqa4gQW0zaXe3DWnxwRNDM8J65+k=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 Aug 2025 11:46:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12583369538011558736
EX-QQ-RecipientCnt: 7
From: tuhaowen <tuhaowen@uniontech.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tuhaowen@uniontech.com,
	huangbibo@uniontech.com
Subject: [RFC PATCH] PM: Add configurable sync timeout to prevent suspend hang
Date: Thu, 28 Aug 2025 11:46:46 +0800
Message-Id: <20250828034646.10700-1-tuhaowen@uniontech.com>
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
X-QQ-XMAILINFO: MBKLumFSBSSxtNfp7qAsxop/79C5KToxtZNTljvegdPP1lM+RWbG8t90
	7MLE1dJ+WDO48tveenhTL5t19t8muT1m2JUko6VEGPe53Hh+9yiZYllydkAG4oFXf0kYhzx
	ZCD/tdzwY6n1D2XBxJmfn7GPS3p3jVihOdls4YmJBbhKqbSd+qNrzbGM3zmh9Me54ga7pPT
	MK/lyHNT1CzrarD34emf36xTBPQKhsSbPKNXIUJ/7ftY/18oQU4v1Rf/QVrqQNg7+BiHSq5
	b6E1XAPZSGjjTy2fPUUzbhbofuvTS2E3DuAgEGopVuKo6r8oHi5eVzKA1CqPemj2tx5iatQ
	uX1lU6YG3or/UIwsbVwYr8Dqg65Zdmn5DWP1XUnIFh7FIkeH5wD17A6ePFKfqsAvqqkIMsT
	fQhQliBusWD3CJwh4rb6PtPsqtieRopAIKGdI4q0BYw3zw1NC88/kKo5bEIvQnUS+U6pbte
	hrN7K0KFDC/0y2RTdlv02xnXqyOeOQ30AlsnQqwkTzpKWESJnOkGkhdsuXFrzC/Z4u0Kdin
	hkakPo/fLl+Kv90hPJoVncbbhuIjL6GQumEq2YPsnbcV0WJiBSrSlvJkKMypkB9PXJBZJ5s
	R8YyPETz4y6p8hqJcE30OZ6n0Kb9onlSMoJTVV2T5khzzwYG2Fyek3lZBrYikpchPUSc6J4
	gMzYb77G+MZZCenlLAilHEYwUw47Fb1NNi8tl3Ei22vIICV2H3FkdNZipjcLHsoneruuGij
	sE6yoJbuK+IvgAxJAppc+W0tzgz+Q11tvk22PvWAgeRH5RCpdvlBigZ5VOVym6QwVigqnQT
	ebmGuGn/I4skrgB9EBB8KZgjT0MXJjQayj6tFF5dZzey19HSqZbcaBVYKDG6oAC/yzngWwI
	EWIe8bY5tCISKziHLmSpMAgWfSTXM8vh1/X3YHQzfOZogtktpxEygIeuwkX30H7cq/MMQoy
	oO3R1cc/6Xr7UTKtadDraKNTOLha/EabzAfTD2F6HJ2zg8ycvuLZbsldZpuc/u12/Evk=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

When users initiate suspend while large file copy operations are in
progress (especially to USB storage devices), the system can appear to
hang with a black screen for an extended period. This occurs because
ksys_sync_helper() in the suspend path blocks until all pending I/O
operations complete, which can take several minutes for large file
transfers.

This creates a poor user experience where the system appears
unresponsive, and users may force power off thinking the system has
crashed.

This RFC proposes adding an optional timeout mechanism for the sync
operation during suspend. The implementation includes:

- A configurable timeout (default: 60 seconds, disabled by default)
- Module parameters for runtime configuration:
  * sync_on_suspend_timeout_enable: Enable/disable the timeout feature
  * sync_on_suspend_timeout_ms: Configure timeout duration
- Uses a separate kernel thread to perform sync with timeout monitoring
- On timeout, suspend is aborted with clear error messaging
- Maintains backward compatibility (disabled by default)

Questions for the community:

1. Is this approach acceptable for addressing the user experience issue?
2. Are there better alternatives to handle long-running sync operations
   during suspend?
3. Should the default timeout value be different?
4. Any concerns with the implementation approach?

The feature is disabled by default to ensure no regression in existing
behavior. When enabled, it allows users to abort suspend if sync takes
too long, providing immediate feedback rather than an apparent system
hang.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
 kernel/power/suspend.c | 56 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8eaec4ab1..feb1583c5 100644
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
 
+/* Sync timeout parameters */
+static bool sync_on_suspend_timeout_enable;
+module_param(sync_on_suspend_timeout_enable, bool, 0644);
+MODULE_PARM_DESC(sync_on_suspend_timeout_enable, "Enable sync timeout during suspend (default: false)");
+
+static unsigned int sync_on_suspend_timeout_ms = 60000;
+module_param(sync_on_suspend_timeout_ms, uint, 0644);
+MODULE_PARM_DESC(sync_on_suspend_timeout_ms, "Sync timeout in milliseconds during suspend (default: 60000)");
+
+/* Sync timeout implementation */
+static struct completion sync_completion;
+static struct task_struct *sync_task;
+
 const char * const pm_labels[] = {
 	[PM_SUSPEND_TO_IDLE] = "freeze",
 	[PM_SUSPEND_STANDBY] = "standby",
@@ -61,6 +77,40 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
+static int sync_thread_func(void *data)
+{
+	ksys_sync_helper();
+	complete(&sync_completion);
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
+	init_completion(&sync_completion);
+	sync_task = kthread_run(sync_thread_func, NULL, "suspend_sync");
+	if (IS_ERR(sync_task)) {
+		pr_warn("PM: Failed to create sync thread, performing sync directly\n");
+		ksys_sync_helper();
+		return 0;
+	}
+
+	timeout_jiffies = msecs_to_jiffies(sync_on_suspend_timeout_ms);
+	if (!wait_for_completion_timeout(&sync_completion, timeout_jiffies)) {
+		pr_warn("PM: Sync operation timed out after %u ms, aborting suspend\n",
+				sync_on_suspend_timeout_ms);
+		kthread_stop(sync_task);
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


