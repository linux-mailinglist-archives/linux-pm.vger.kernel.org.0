Return-Path: <linux-pm+bounces-17584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9498E9C9508
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 23:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A9B284D4B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 22:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7471B0F10;
	Thu, 14 Nov 2024 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItHwvwAb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723C1B21AE
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622189; cv=none; b=fnjRGGm0RGpHw8gwPJcUcOrj3RopUqivYw5t3WhXCa9ere0ENAKc5k3lKyw5Eri55XdB/GSAmzIpkwoqCFbPZRExgmCGu2U9Sn9aF4P+dQ/6ZMEkMoKu757IuN1FGDpKjxy5ID2gUDa5ZNtPqjfozCNPo5FQTJ3RVO6aQJNaBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622189; c=relaxed/simple;
	bh=zT69LE77WSFfAhqCDH5w950kvxq/gLKyUSfzX7wNoIg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=LWdW7xgjBX2P3voYJeT6Q/7pQh5LJzFwfz/v7cKReXaaYWSuC/nraMChg+z7fc30A5hZsTCB0Ijpy4hCfOP7rmIAa5GGi9Vyr5TuxUHgCLuEZ8E8tnyGd3H+EHvQR0rSfCOTezY0Z7bOQxTpr4YvSfpZz3J2UKhtTM7S+iq0MJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ItHwvwAb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so1635486276.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 14:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731622186; x=1732226986; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cuwLd2wG5w5IEQwXRfGEca25xUbPGee3GN6Vgv7vgbI=;
        b=ItHwvwAbgCu7II3PVd5JtpIDdSo/KOMlylB5YZIg1isP/Uadv/3qOkN7uJufuEdobX
         m9O9uAhcYJ5Ne3SJ3ZsCgpEv3+hl0Q71AgVccMRqyWH0vco1yaIe5rwzJJBTezQ26aRK
         E+x14Ey7cvZiUbum3hglr8F5iPlKwa/eUP/mdQ8wH69hy6WOiivupikoX9YUitBUubs9
         sfnEitzAaBhDrMGmEhGAQ0vLge+1xD+raFigpC0nQqNfGPIA22ziupppN30tLu1UJiu2
         ag9PnuyLGSkDIC/u0dMC5yhugw9XCi8t+WxhwbcrCIMdOZgEfIZnpTKg+VdY6UazGob+
         OreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622186; x=1732226986;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuwLd2wG5w5IEQwXRfGEca25xUbPGee3GN6Vgv7vgbI=;
        b=wArEdVfWFr7W1SpbcbuO4ufQc/znW8at9gDxSeeenYfgVRcmhwaHVm6ihUI52yHXSQ
         sP9i3G3ENpVYaAge3UFgXAGkouqapZkt7ofLVMI55h/n4F8E05s+3eAM0TtT3soA8UB4
         vvYT8MNH/mTkCmxPwgEst/TnKNRnlYiBNguG+b9F17rDuwXb8oRfjunwxlhor7wBXHXm
         R3uXwPgN7y8kLC5YGXwQfRtVtwCg5ktqGd/Fmbfw5/H1Y+rjZgnYHO2w3q4mio8oU2X6
         NK8XatHk8nZdh6ma84TgozaaZpNEiBlHVq2LlRSSvUVLY201XwUolRxNj9kiA/t7pdnT
         JO3g==
X-Forwarded-Encrypted: i=1; AJvYcCX+N3EgxlzbSI5a20vYWG8F3QOqryLI3NVMdGTPV6QKx3VascyEAhkXO3TBfZ1les+dMonumvzxRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOE4Yifwdi0aVeB5Ef1/vQ5/5ktX3blc9mzbvG5dvd0NXK8kM
	cIs5vQwtZDiYCu7b8NIIfEZdi9QFnVXFRdx+6XVmuM6NxjH4dVN5CXfoWNFti4zFnMe+y3QwgiB
	Z4ORBoKO9hUvg8g==
X-Google-Smtp-Source: AGHT+IFkvpUZhEiNC+bQ9HRdBsFcgiebG16qqorItpAQ1ScVgOB47lhw/wazGuODgw4aX0JHOPU35kN2IPbBe74=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:3e23:8355:c37:686e])
 (user=saravanak job=sendgmr) by 2002:a25:2d12:0:b0:e29:6e61:3daf with SMTP id
 3f1490d57ef6-e3825d38f0cmr322276.2.1731622185728; Thu, 14 Nov 2024 14:09:45
 -0800 (PST)
Date: Thu, 14 Nov 2024 14:09:18 -0800
In-Reply-To: <20241114220921.2529905-1-saravanak@google.com>
Message-Id: <20241114220921.2529905-5-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 4/5] PM: sleep: Do breadth first suspend/resume for async suspend/resume
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Marek Vasut <marex@denx.de>, Bird@google.com, Tim <Tim.Bird@sony.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The dpm_list used for suspend/resume ensures that all superior devices
(parents and suppliers) precede subordinate devices (children and
consumers).

Current async resume logic:
-------------------------------
* For each resume phase (except the "complete" phase, which is always
  serialized), the resume logic first queues all async devices in the
  dpm_list. It then loops through the dpm_list again to resume the sync
  devices one by one.

* Async devices wait for all their superior devices to resume before
  starting their own resume operation.

* This process results in multiple sleep and wake-up cycles before an
  async device actually resumes. This sleeping also causes kworker
  threads to stall with work for a period. Consequently, the workqueue
  framework spins up more kworker threads to handle the other async
  devices.

* The end result is excessive thread creation, wake-ups, sleeps, and
  context switches for every async device. This overhead makes a full
  async resume (with all devices marked as async-capable) much slower
  than a synchronous resume.

Current async suspend logic:
--------------------------------
* The async suspend logic differs from the async resume logic. The
  suspend logic loops through the dpm_list. When it finds an async
  device, it queues the work and moves on. However, if it encounters a
  sync device, it waits until the sync device (and all its subordinate
  devices) have suspended before proceeding to the next device.
  Therefore, an async suspend device can be left waiting on an
  unrelated device before even being queued.

* Once queued, an async device experiences the same inefficiencies as
  in the resume logic (thread creation, wake-ups, sleeps, and context
  switches).

On a Pixel 6, averaging over 100 suspend/resume cycles, the data is as
follows:

+---------------------------+-----------+------------+----------+
| Phase			    | Full sync | Full async | % change |
+---------------------------+-----------+------------+----------+
| Total dpm_suspend*() time |	 107 ms |      72 ms |     -33% |
+---------------------------+-----------+------------+----------+
| Total dpm_resume*() time  |	  75 ms |      90 ms |     +20% |
+---------------------------+-----------+------------+----------+
| Sum			    |	 182 ms |     162 ms |     -11% |
+---------------------------+-----------+------------+----------+

This shows that full async suspend/resume is not a viable option. It
makes the user-visible resume phase slower and only improves the
overall time by 11%.

To fix all this, this patches introduces a new async suspend/resume
logic.

New suspend/resume logic:
-------------------------
* For each suspend/resume phase (except "complete" and "prepare,"
  which are always serialized), the logic first queues only the async
  devices that don't have to wait for any subordinates (for suspend)
  or superiors (for resume). It then loops through the dpm_list again
  to suspend/resume the sync devices one by one.

* When a device (sync or async) successfully suspends/resumes, it
  examines its superiors/subordinates and queues only the async
  devices that don't need to wait for any subordinates/superiors.

With this new logic:

* Queued async devices don't have to wait for completion and are
  always ready to perform their suspend/resume operation.

* The queue of async devices remains short.

* kworkers never sleep for extended periods, and the workqueue
  framework doesn't spin up many new threads to handle a backlog of
  async devices.

* The result is approximately NCPU kworker threads running in parallel
  without sleeping until all async devices finish.

On a Pixel 6, averaging over 100 suspend/resume cycles, the new logic
yields improved results:
+---------------------------+-----------+------------+------------------+
| Phase			    | Old full sync | New full async | % change |
+---------------------------+-----------+------------+------------------+
| Total dpm_suspend*() time |        107 ms |          60 ms |     -44% |
+---------------------------+-----------+------------+------------------+
| Total dpm_resume*() time  |         75 ms |          74 ms |      -1% |
+---------------------------+-----------+------------+------------------+
| Sum			    |        182 ms |         134 ms |     -26% |
+---------------------------+-----------+------------+------------------+

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/power/main.c | 242 ++++++++++++++++++++++++++++++++------
 1 file changed, 205 insertions(+), 37 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index aa1470ef6ac0..65c195be48b8 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -121,6 +121,12 @@ void device_pm_unlock(void)
 	mutex_unlock(&dpm_list_mtx);
 }
 
+static bool is_async(struct device *dev)
+{
+	return dev->power.async_suspend && pm_async_enabled
+		&& !pm_trace_is_enabled();
+}
+
 /**
  * device_pm_add - Add a device to the PM core's list of active devices.
  * @dev: Device to add to the list.
@@ -287,6 +293,9 @@ static int dpm_for_each_superior(struct device *dev, void *data,
 
 static bool dpm_wait_for_superior(struct device *dev, bool async)
 {
+	if (is_async(dev))
+		return true;
+
 	dpm_for_each_superior(dev, &async, dpm_wait_fn);
 
 	/*
@@ -334,9 +343,22 @@ static int dpm_for_each_subordinate(struct device *dev, void *data,
 
 static void dpm_wait_for_subordinate(struct device *dev, bool async)
 {
+	if (is_async(dev))
+		return;
+
 	dpm_for_each_subordinate(dev, &async, dpm_wait_fn);
 }
 
+static int dpm_check_fn(struct device *dev, void *data)
+{
+	return completion_done(&dev->power.completion) ? 0 : -EBUSY;
+}
+
+static int dpm_check_subordinate(struct device *dev)
+{
+	return dpm_for_each_subordinate(dev, NULL, dpm_check_fn);
+}
+
 /**
  * pm_op - Return the PM operation appropriate for given PM event.
  * @ops: PM operations to choose from.
@@ -578,33 +600,39 @@ bool dev_pm_skip_resume(struct device *dev)
 	return !dev->power.must_resume;
 }
 
-static bool is_async(struct device *dev)
+static void dpm_async_fn(struct device *dev, async_func_t func)
 {
-	return dev->power.async_suspend && pm_async_enabled
-		&& !pm_trace_is_enabled();
-}
-
-static bool dpm_async_fn(struct device *dev, async_func_t func)
-{
-	reinit_completion(&dev->power.completion);
-
-	if (is_async(dev)) {
-		dev->power.async_in_progress = true;
-
-		get_device(dev);
+	/*
+	 * Multiple async devices could trigger the async queuing of this
+	 * device. Make sure not to double queue it.
+	 */
+	spin_lock(&dev->power.lock);
+	if (dev->power.async_in_progress) {
+		spin_unlock(&dev->power.lock);
+		return;
+	}
+	dev->power.async_in_progress = true;
+	spin_unlock(&dev->power.lock);
 
-		if (async_schedule_dev_nocall(func, dev))
-			return true;
+	get_device(dev);
 
-		put_device(dev);
-	}
 	/*
-	 * Because async_schedule_dev_nocall() above has returned false or it
-	 * has not been called at all, func() is not running and it is safe to
-	 * update the async_in_progress flag without extra synchronization.
+	 * We aren't going to call any callbacks if the device has none.  Also,
+	 * direct_complete means all the resume and suspend callbacks should be
+	 * skipped and the device should go straight to dpm_complete().  In both
+	 * of these case, calling the func() synchronously will be a lot quicker
+	 * than even queuing the async work. So, do that.
 	 */
-	dev->power.async_in_progress = false;
-	return false;
+	if (dev->power.no_pm_callbacks || dev->power.direct_complete) {
+		func(dev, 0);
+		return;
+	}
+
+	if (async_schedule_dev_nocall(func, dev))
+		return;
+
+	WARN(1, "Unable to schedule async suspend/resume calls!\n");
+	put_device(dev);
 }
 
 /**
@@ -692,12 +720,47 @@ static void device_resume_noirq(struct device *dev, pm_message_t state, bool asy
 	}
 }
 
+static void dpm_reinit_dev_state(struct list_head *list)
+{
+	struct device *dev;
+
+	list_for_each_entry(dev, list, power.entry) {
+		reinit_completion(&dev->power.completion);
+		dev->power.async_in_progress = false;
+	}
+}
+
+static int dpm_check_superior(struct device *dev)
+{
+	return dpm_for_each_superior(dev, NULL, dpm_check_fn);
+}
+
+static int dpm_async_queue_resume_ready_fn(struct device *dev, void *data)
+{
+	if (!is_async(dev) || dpm_check_superior(dev))
+		return 0;
+
+	dpm_async_fn(dev, data);
+	return 0;
+}
+
+static void dpm_async_resume_loop(struct list_head *from, async_func_t func)
+{
+	struct device *dev;
+
+	list_for_each_entry(dev, from, power.entry)
+		dpm_async_queue_resume_ready_fn(dev, func);
+}
+
 static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
 
 	device_resume_noirq(dev, pm_transition, true);
 	put_device(dev);
+
+	dpm_for_each_subordinate(dev, async_resume_noirq,
+				 dpm_async_queue_resume_ready_fn);
 }
 
 static void dpm_noirq_resume_devices(pm_message_t state)
@@ -712,23 +775,26 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 
 	mutex_lock(&dpm_list_mtx);
 
+	dpm_reinit_dev_state(&dpm_noirq_list);
+
 	/*
 	 * Trigger the resume of "async" devices upfront so they don't have to
 	 * wait for the "non-async" ones they don't depend on.
 	 */
-	list_for_each_entry(dev, &dpm_noirq_list, power.entry)
-		dpm_async_fn(dev, async_resume_noirq);
+	dpm_async_resume_loop(&dpm_noirq_list, async_resume_noirq);
 
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
 
-		if (!dev->power.async_in_progress) {
+		if (!is_async(dev)) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
 
 			device_resume_noirq(dev, state, false);
+			dpm_for_each_subordinate(dev, async_resume_noirq,
+						 dpm_async_queue_resume_ready_fn);
 
 			put_device(dev);
 
@@ -834,6 +900,9 @@ static void async_resume_early(void *data, async_cookie_t cookie)
 
 	device_resume_early(dev, pm_transition, true);
 	put_device(dev);
+
+	dpm_for_each_subordinate(dev, async_resume_early,
+				 dpm_async_queue_resume_ready_fn);
 }
 
 /**
@@ -852,23 +921,26 @@ void dpm_resume_early(pm_message_t state)
 
 	mutex_lock(&dpm_list_mtx);
 
+	dpm_reinit_dev_state(&dpm_late_early_list);
+
 	/*
 	 * Trigger the resume of "async" devices upfront so they don't have to
 	 * wait for the "non-async" ones they don't depend on.
 	 */
-	list_for_each_entry(dev, &dpm_late_early_list, power.entry)
-		dpm_async_fn(dev, async_resume_early);
+	dpm_async_resume_loop(&dpm_late_early_list, async_resume_early);
 
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
 		list_move_tail(&dev->power.entry, &dpm_suspended_list);
 
-		if (!dev->power.async_in_progress) {
+		if (!is_async(dev)) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
 
 			device_resume_early(dev, state, false);
+			dpm_for_each_subordinate(dev, async_resume_early,
+					dpm_async_queue_resume_ready_fn);
 
 			put_device(dev);
 
@@ -996,6 +1068,9 @@ static void async_resume(void *data, async_cookie_t cookie)
 
 	device_resume(dev, pm_transition, true);
 	put_device(dev);
+
+	dpm_for_each_subordinate(dev, async_resume,
+				 dpm_async_queue_resume_ready_fn);
 }
 
 /**
@@ -1018,23 +1093,26 @@ void dpm_resume(pm_message_t state)
 
 	mutex_lock(&dpm_list_mtx);
 
+	dpm_reinit_dev_state(&dpm_suspended_list);
+
 	/*
 	 * Trigger the resume of "async" devices upfront so they don't have to
 	 * wait for the "non-async" ones they don't depend on.
 	 */
-	list_for_each_entry(dev, &dpm_suspended_list, power.entry)
-		dpm_async_fn(dev, async_resume);
+	dpm_async_resume_loop(&dpm_suspended_list, async_resume);
 
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
 		list_move_tail(&dev->power.entry, &dpm_prepared_list);
 
-		if (!dev->power.async_in_progress) {
+		if (!is_async(dev)) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
 
 			device_resume(dev, state, false);
+			dpm_for_each_subordinate(dev, async_resume,
+					dpm_async_queue_resume_ready_fn);
 
 			put_device(dev);
 
@@ -1274,12 +1352,35 @@ static int device_suspend_noirq(struct device *dev, pm_message_t state, bool asy
 	return error;
 }
 
+static int dpm_async_queue_suspend_ready_fn(struct device *dev, void *data)
+{
+	if (!is_async(dev) || dpm_check_subordinate(dev))
+		return 0;
+
+	dpm_async_fn(dev, data);
+	return 0;
+}
+
+static void dpm_async_suspend_loop(struct list_head *from, async_func_t func)
+{
+	struct device *dev;
+
+	list_for_each_entry_reverse(dev, from, power.entry)
+		dpm_async_queue_suspend_ready_fn(dev, func);
+}
+
 static void async_suspend_noirq(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
 
 	device_suspend_noirq(dev, pm_transition, true);
 	put_device(dev);
+
+	if (async_error)
+		return;
+
+	dpm_for_each_superior(dev, async_suspend_noirq,
+			      dpm_async_queue_suspend_ready_fn);
 }
 
 static int dpm_noirq_suspend_devices(pm_message_t state)
@@ -1294,12 +1395,20 @@ static int dpm_noirq_suspend_devices(pm_message_t state)
 
 	mutex_lock(&dpm_list_mtx);
 
+	dpm_reinit_dev_state(&dpm_late_early_list);
+
+	/*
+	 * Trigger the "async" devices upfront so they don't have to wait for
+	 * the "non-async" ones they don't depend on.
+	 */
+	dpm_async_suspend_loop(&dpm_late_early_list, async_suspend_noirq);
+
 	while (!list_empty(&dpm_late_early_list)) {
 		struct device *dev = to_device(dpm_late_early_list.prev);
 
 		list_move(&dev->power.entry, &dpm_noirq_list);
 
-		if (dpm_async_fn(dev, async_suspend_noirq))
+		if (is_async(dev))
 			continue;
 
 		get_device(dev);
@@ -1307,13 +1416,20 @@ static int dpm_noirq_suspend_devices(pm_message_t state)
 		mutex_unlock(&dpm_list_mtx);
 
 		error = device_suspend_noirq(dev, state, false);
+		if (!error && !async_error)
+			dpm_for_each_superior(dev, async_suspend_noirq,
+					      dpm_async_queue_suspend_ready_fn);
 
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error)
+		if (error || async_error) {
+			/* See explanation in dpm_suspend() */
+			list_splice_init(&dpm_late_early_list, &dpm_noirq_list);
 			break;
+		}
+
 	}
 
 	mutex_unlock(&dpm_list_mtx);
@@ -1447,6 +1563,12 @@ static void async_suspend_late(void *data, async_cookie_t cookie)
 
 	device_suspend_late(dev, pm_transition, true);
 	put_device(dev);
+
+	if (async_error)
+		return;
+
+	dpm_for_each_superior(dev, async_suspend_late,
+			      dpm_async_queue_suspend_ready_fn);
 }
 
 /**
@@ -1467,12 +1589,20 @@ int dpm_suspend_late(pm_message_t state)
 
 	mutex_lock(&dpm_list_mtx);
 
+	dpm_reinit_dev_state(&dpm_suspended_list);
+
+	/*
+	 * Trigger the "async" devices upfront so they don't have to wait for
+	 * the "non-async" ones they don't depend on.
+	 */
+	dpm_async_suspend_loop(&dpm_suspended_list, async_suspend_late);
+
 	while (!list_empty(&dpm_suspended_list)) {
 		struct device *dev = to_device(dpm_suspended_list.prev);
 
 		list_move(&dev->power.entry, &dpm_late_early_list);
 
-		if (dpm_async_fn(dev, async_suspend_late))
+		if (is_async(dev))
 			continue;
 
 		get_device(dev);
@@ -1480,13 +1610,19 @@ int dpm_suspend_late(pm_message_t state)
 		mutex_unlock(&dpm_list_mtx);
 
 		error = device_suspend_late(dev, state, false);
+		if (!error && !async_error)
+			dpm_for_each_superior(dev, async_suspend_late,
+					      dpm_async_queue_suspend_ready_fn);
 
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error)
+		if (error || async_error) {
+			/* See explanation in dpm_suspend() */
+			list_splice_init(&dpm_suspended_list, &dpm_late_early_list);
 			break;
+		}
 	}
 
 	mutex_unlock(&dpm_list_mtx);
@@ -1712,6 +1848,12 @@ static void async_suspend(void *data, async_cookie_t cookie)
 
 	device_suspend(dev, pm_transition, true);
 	put_device(dev);
+
+	if (async_error)
+		return;
+
+	dpm_for_each_superior(dev, async_suspend,
+			      dpm_async_queue_suspend_ready_fn);
 }
 
 /**
@@ -1734,12 +1876,20 @@ int dpm_suspend(pm_message_t state)
 
 	mutex_lock(&dpm_list_mtx);
 
+	dpm_reinit_dev_state(&dpm_prepared_list);
+
+	/*
+	 * Trigger the "async" devices upfront so they don't have to wait for
+	 * the "non-async" ones they don't depend on.
+	 */
+	dpm_async_suspend_loop(&dpm_prepared_list, async_suspend);
+
 	while (!list_empty(&dpm_prepared_list)) {
 		struct device *dev = to_device(dpm_prepared_list.prev);
 
 		list_move(&dev->power.entry, &dpm_suspended_list);
 
-		if (dpm_async_fn(dev, async_suspend))
+		if (is_async(dev))
 			continue;
 
 		get_device(dev);
@@ -1747,13 +1897,31 @@ int dpm_suspend(pm_message_t state)
 		mutex_unlock(&dpm_list_mtx);
 
 		error = device_suspend(dev, state, false);
+		if (!error && !async_error)
+			dpm_for_each_superior(dev, async_suspend,
+					      dpm_async_queue_suspend_ready_fn);
 
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error)
+		if (error || async_error) {
+			/*
+			 * async devices that come after the current sync device
+			 * in the list might have already suspended. We need to
+			 * make sure those async devices are resumed again. By
+			 * moving all devices to the next list, we make sure the
+			 * error handling path resumes all suspended devices.
+			 *
+			 * However, we also need to avoid resuming devices that
+			 * haven't been suspended yet. Fortunately, the existing
+			 * is_suspended/is_noirq_suspended/is_late_suspended
+			 * flags take care of skipping the resume of a device if
+			 * it hasn't been suspended yet.
+			 */
+			list_splice_init(&dpm_prepared_list, &dpm_suspended_list);
 			break;
+		}
 	}
 
 	mutex_unlock(&dpm_list_mtx);
-- 
2.47.0.338.g60cca15819-goog


