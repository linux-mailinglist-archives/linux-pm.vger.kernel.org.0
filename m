Return-Path: <linux-pm+bounces-30942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BF8B07DB2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 21:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BCA503ADE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 19:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF12D322A;
	Wed, 16 Jul 2025 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1pUG3jT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9422D2387;
	Wed, 16 Jul 2025 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694293; cv=none; b=OJb30qYLfq/5CHpqGSu+CTTvvPMBnXb/+w0R+mXePzl1hVr5wP2mBtnq2NF9mvCcBRp2lrJltLt+O+AmvqdFIWjj9ena4tgWIump9Et2Vm1d+AqS0gW8kphwnaTJAkr5NUNBTbkKVgMAk/yEj/jz4Cu4kzs2H94rIUXlD2b99wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694293; c=relaxed/simple;
	bh=vPTbQU15dy/UKoBSuPlk6HFGGi3l3Rf86bQ3fMTlfYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/lbCJVmFakWkM5V01jznVNX3d33hMhDenvEFDRmMJNa6PfUATroL5MbNsnMMOE9ArM0vC7vY41vTq+qnrIgrtqnYCirnCJkym2T6kS+1GPbZR0lGo9hIIAkFPLoerAo4Pfy44d5fRgeOGXCbTXBhQB51F3rUXz5RsPhKtUJaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1pUG3jT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F56C4CEF5;
	Wed, 16 Jul 2025 19:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752694292;
	bh=vPTbQU15dy/UKoBSuPlk6HFGGi3l3Rf86bQ3fMTlfYc=;
	h=From:To:Cc:Subject:Date:From;
	b=j1pUG3jT6Zn37957Q7vFaCeeMT0WdpJzLNi8pkJokRsf+gZ5Yuj9dySxme+5vVW3q
	 ySEAychyPvqThiRw5yiHRdYWMsyboGBy/LEVm+f/6YcF6aS/Nqj7UUYFb32HZ8E4AM
	 rZB3pzl3n4MlTHzRB4PWA+YS7UMV0cIvP/NFdepxVGlYS5UrXODknBViRO9Oub7Bcx
	 3/tVFxY/yogUcSMrRmPC64T+UQWmARfSJ5m05/o/ilr1VErXKXQRlEc1eay1ImHox7
	 y+TCmSta/kAG1tbEobUqaD34I5S3CTngfrXPG/4Fdo5J11R9hl4lX1EOyxuHC7O96b
	 D2Xg+8FVwR59Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v1] PM: sleep: Rearrange suspend/resume error handling in the core
Date: Wed, 16 Jul 2025 21:31:23 +0200
Message-ID: <6198088.lOV4Wx5bFT@rjwysocki.net>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that device_suspend_noirq(), device_suspend_late() and
device_suspend() all set async_error on errors, so they don't really
need to return a value.  Accordingly, make them all void and use
async_error in their callers instead of their return values.

Moreover, since async_error is updated concurrently without locking
during asynchronous suspend and resume processing, use READ_ONCE() and
WRITE_ONCE() for accessing it in those places to ensure that all of the
accesses will be carried out as expected.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Based on the current linux-pm.git material in linux-next.

---
 drivers/base/power/main.c |   79 ++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 44 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -767,7 +767,7 @@
 	TRACE_RESUME(error);
 
 	if (error) {
-		async_error = error;
+		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
 	}
@@ -824,7 +824,7 @@
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
 	dpm_show_time(starttime, state, 0, "noirq");
-	if (async_error)
+	if (READ_ONCE(async_error))
 		dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
 
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
@@ -910,7 +910,7 @@
 	complete_all(&dev->power.completion);
 
 	if (error) {
-		async_error = error;
+		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async early" : " early", error);
 	}
@@ -971,7 +971,7 @@
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
 	dpm_show_time(starttime, state, 0, "early");
-	if (async_error)
+	if (READ_ONCE(async_error))
 		dpm_save_failed_step(SUSPEND_RESUME_EARLY);
 
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
@@ -1086,7 +1086,7 @@
 	TRACE_RESUME(error);
 
 	if (error) {
-		async_error = error;
+		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async" : "", error);
 	}
@@ -1150,7 +1150,7 @@
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
 	dpm_show_time(starttime, state, 0, NULL);
-	if (async_error)
+	if (READ_ONCE(async_error))
 		dpm_save_failed_step(SUSPEND_RESUME);
 
 	cpufreq_resume();
@@ -1387,7 +1387,7 @@
  * The driver of @dev will not receive interrupts while this function is being
  * executed.
  */
-static int device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
+static void device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -1398,7 +1398,7 @@
 
 	dpm_wait_for_subordinate(dev, async);
 
-	if (async_error)
+	if (READ_ONCE(async_error))
 		goto Complete;
 
 	if (dev->power.syscore || dev->power.direct_complete)
@@ -1431,7 +1431,7 @@
 Run:
 	error = dpm_run_callback(callback, dev, state, info);
 	if (error) {
-		async_error = error;
+		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
 		goto Complete;
@@ -1457,12 +1457,10 @@
 	complete_all(&dev->power.completion);
 	TRACE_SUSPEND(error);
 
-	if (error || async_error)
-		return error;
+	if (error || READ_ONCE(async_error))
+		return;
 
 	dpm_async_suspend_superior(dev, async_suspend_noirq);
-
-	return 0;
 }
 
 static void async_suspend_noirq(void *data, async_cookie_t cookie)
@@ -1477,7 +1475,7 @@
 {
 	ktime_t starttime = ktime_get();
 	struct device *dev;
-	int error = 0;
+	int error;
 
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
 
@@ -1508,13 +1506,13 @@
 
 		mutex_unlock(&dpm_list_mtx);
 
-		error = device_suspend_noirq(dev, state, false);
+		device_suspend_noirq(dev, state, false);
 
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error) {
+		if (READ_ONCE(async_error)) {
 			dpm_async_suspend_complete_all(&dpm_late_early_list);
 			/*
 			 * Move all devices to the target list to resume them
@@ -1528,9 +1526,8 @@
 	mutex_unlock(&dpm_list_mtx);
 
 	async_synchronize_full();
-	if (!error)
-		error = async_error;
 
+	error = READ_ONCE(async_error);
 	if (error)
 		dpm_save_failed_step(SUSPEND_SUSPEND_NOIRQ);
 
@@ -1585,7 +1582,7 @@
  *
  * Runtime PM is disabled for @dev while this function is being executed.
  */
-static int device_suspend_late(struct device *dev, pm_message_t state, bool async)
+static void device_suspend_late(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -1602,11 +1599,11 @@
 
 	dpm_wait_for_subordinate(dev, async);
 
-	if (async_error)
+	if (READ_ONCE(async_error))
 		goto Complete;
 
 	if (pm_wakeup_pending()) {
-		async_error = -EBUSY;
+		WRITE_ONCE(async_error, -EBUSY);
 		goto Complete;
 	}
 
@@ -1640,7 +1637,7 @@
 Run:
 	error = dpm_run_callback(callback, dev, state, info);
 	if (error) {
-		async_error = error;
+		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async late" : " late", error);
 		goto Complete;
@@ -1654,12 +1651,10 @@
 	TRACE_SUSPEND(error);
 	complete_all(&dev->power.completion);
 
-	if (error || async_error)
-		return error;
+	if (error || READ_ONCE(async_error))
+		return;
 
 	dpm_async_suspend_superior(dev, async_suspend_late);
-
-	return 0;
 }
 
 static void async_suspend_late(void *data, async_cookie_t cookie)
@@ -1678,7 +1673,7 @@
 {
 	ktime_t starttime = ktime_get();
 	struct device *dev;
-	int error = 0;
+	int error;
 
 	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
 
@@ -1711,13 +1706,13 @@
 
 		mutex_unlock(&dpm_list_mtx);
 
-		error = device_suspend_late(dev, state, false);
+		device_suspend_late(dev, state, false);
 
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error) {
+		if (READ_ONCE(async_error)) {
 			dpm_async_suspend_complete_all(&dpm_suspended_list);
 			/*
 			 * Move all devices to the target list to resume them
@@ -1731,9 +1726,8 @@
 	mutex_unlock(&dpm_list_mtx);
 
 	async_synchronize_full();
-	if (!error)
-		error = async_error;
 
+	error = READ_ONCE(async_error);
 	if (error) {
 		dpm_save_failed_step(SUSPEND_SUSPEND_LATE);
 		dpm_resume_early(resume_event(state));
@@ -1822,7 +1816,7 @@
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being suspended asynchronously.
  */
-static int device_suspend(struct device *dev, pm_message_t state, bool async)
+static void device_suspend(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -1834,7 +1828,7 @@
 
 	dpm_wait_for_subordinate(dev, async);
 
-	if (async_error) {
+	if (READ_ONCE(async_error)) {
 		dev->power.direct_complete = false;
 		goto Complete;
 	}
@@ -1854,7 +1848,7 @@
 
 	if (pm_wakeup_pending()) {
 		dev->power.direct_complete = false;
-		async_error = -EBUSY;
+		WRITE_ONCE(async_error, -EBUSY);
 		goto Complete;
 	}
 
@@ -1938,7 +1932,7 @@
 
  Complete:
 	if (error) {
-		async_error = error;
+		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async" : "", error);
 	}
@@ -1946,12 +1940,10 @@
 	complete_all(&dev->power.completion);
 	TRACE_SUSPEND(error);
 
-	if (error || async_error)
-		return error;
+	if (error || READ_ONCE(async_error))
+		return;
 
 	dpm_async_suspend_superior(dev, async_suspend);
-
-	return 0;
 }
 
 static void async_suspend(void *data, async_cookie_t cookie)
@@ -1970,7 +1962,7 @@
 {
 	ktime_t starttime = ktime_get();
 	struct device *dev;
-	int error = 0;
+	int error;
 
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
 	might_sleep();
@@ -2005,13 +1997,13 @@
 
 		mutex_unlock(&dpm_list_mtx);
 
-		error = device_suspend(dev, state, false);
+		device_suspend(dev, state, false);
 
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error) {
+		if (READ_ONCE(async_error)) {
 			dpm_async_suspend_complete_all(&dpm_prepared_list);
 			/*
 			 * Move all devices to the target list to resume them
@@ -2025,9 +2017,8 @@
 	mutex_unlock(&dpm_list_mtx);
 
 	async_synchronize_full();
-	if (!error)
-		error = async_error;
 
+	error = READ_ONCE(async_error);
 	if (error)
 		dpm_save_failed_step(SUSPEND_SUSPEND);
 




