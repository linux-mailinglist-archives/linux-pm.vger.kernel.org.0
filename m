Return-Path: <linux-pm+bounces-24058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7330EA6127B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 150CD7A62D4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21291FF7B3;
	Fri, 14 Mar 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dnHLHjMi"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483B33062;
	Fri, 14 Mar 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958591; cv=none; b=bJgiQWhzC6VPtTgpxB1ZiW39ZqyWdFhQArjIqQ23FEIeWruOiQ5zAoSnMzs8BCnT+bHY/sPEAUscaFTKQinFLwTBnvoAt1O8eR+UsWV51ngE/kuC1JIsYOz8wEUOWUt4UHl1cL2/6n87DeeuEeNv/iiFoA2rxCiFQO2/NGEtmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958591; c=relaxed/simple;
	bh=Xi6eAIqF9YoMvolpEr548W5nu/pRhUxpbEp+MqJVoug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSjDvQZ8MFnMT2aBOSGd6/9GItcoqL7PEqXIc2QecfIo8Uw0Hal9tARk3nGNsNDuKgv6jJ8NT6JWbodPS7tB3Ukx30OKXT++oI8O5zKn4tl6xXLmbUcuNdpIIgeywAIT4ijND2+I6A8c9UgyyF9MoY3kEEvYe3gEvWViH/7VKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dnHLHjMi; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 85438b371985ad6e; Fri, 14 Mar 2025 14:23:07 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9C612912D03;
	Fri, 14 Mar 2025 14:23:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741958587;
	bh=Xi6eAIqF9YoMvolpEr548W5nu/pRhUxpbEp+MqJVoug=;
	h=From:Subject:Date;
	b=dnHLHjMi2HqXVGWzEVcSUwKzwM0/LyfPDbbSgWpI7rWUCSCLVkiS32Pm9Xv/AY2/X
	 EU19fnoN+fjI32oF1iuhTANLrOxeeyemK4NzMjDNV6NLnIvYpWsJsLNlq78vNeYaOm
	 bBb3tY1TlYTAxgfSUKH9hDYuTOWmVJ5iwOFGATmWxqEO2vuK4LGCv3IkyU0TZkwr7Z
	 hAfCi+L++U7BqrNThfTnIz6NCImAiydS7uOCaf5Kn95CGJ7p2B12UARl1Fky+2oIJQ
	 MrtBhfigioVsBVu8rj9PcrQfRP2BM20TSUiYAwPfdyRkePwxgtGvyAUYjsUlDXGs97
	 9Zgg2rCBg+KfQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>
Subject: [PATCH v3 1/5] PM: sleep: Resume children after resuming the parent
Date: Fri, 14 Mar 2025 13:50:09 +0100
Message-ID: <22630663.EfDdHjke4D@rjwysocki.net>
In-Reply-To: <10629535.nUPlyArG6x@rjwysocki.net>
References: <10629535.nUPlyArG6x@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=24 Fuz1=24 Fuz2=24

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to [1], the handling of device suspend and resume, and
particularly the latter, involves unnecessary overhead related to
starting new async work items for devices that cannot make progress
right away because they have to wait for other devices.

To reduce this problem in the resume path, use the observation that
starting the async resume of the children of a device after resuming
the parent is likely to produce less scheduling and memory management
noise than starting it upfront while at the same time it should not
increase the resume duration substantially.

Accordingly, modify the code to start the async resume of the device's
children when the processing of the parent has been completed in each
stage of device resume and only start async resume upfront for devices
without parents.

Also make it check if a given device can be resumed asynchronously
before starting the synchronous resume of it in case it will have to
wait for another that is already resuming asynchronously.

In addition to making the async resume of devices more friendly to
systems with relatively less computing resources, this change is also
preliminary for analogous changes in the suspend path.

On the systems where it has been tested, this change by itself does
not affect the overall system resume duration in a measurable way.

Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@google.com/ [1]
Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   Introduce dpm_root_device() as a wrapper around the dev->parent check,
   adjust comments.

v1 -> v2:
   Use a separate lock for power.work_in_progress protection which should
   reduce lock contention on dpm_list_mtx.

---
 drivers/base/power/main.c |   85 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 19 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -63,6 +63,7 @@
 static DEFINE_MUTEX(dpm_list_mtx);
 static pm_message_t pm_transition;
 
+static DEFINE_MUTEX(async_wip_mtx);
 static int async_error;
 
 static const char *pm_verb(int event)
@@ -597,8 +598,11 @@
 		&& !pm_trace_is_enabled();
 }
 
-static bool dpm_async_fn(struct device *dev, async_func_t func)
+static bool __dpm_async(struct device *dev, async_func_t func)
 {
+	if (dev->power.work_in_progress)
+		return true;
+
 	if (!is_async(dev))
 		return false;
 
@@ -611,14 +615,37 @@
 
 	put_device(dev);
 
+	return false;
+}
+
+static bool dpm_async_fn(struct device *dev, async_func_t func)
+{
+	guard(mutex)(&async_wip_mtx);
+
+	return __dpm_async(dev, func);
+}
+
+static int dpm_async_with_cleanup(struct device *dev, void *fn)
+{
+	guard(mutex)(&async_wip_mtx);
+
+	if (!__dpm_async(dev, fn))
+		dev->power.work_in_progress = false;
+
+	return 0;
+}
+
+static void dpm_async_resume_children(struct device *dev, async_func_t func)
+{
 	/*
-	 * async_schedule_dev_nocall() above has returned false, so func() is
-	 * not running and it is safe to update power.work_in_progress without
-	 * extra synchronization.
+	 * Start processing "async" children of the device unless it's been
+	 * started already for them.
+	 *
+	 * This could have been done for the device's "async" consumers too, but
+	 * they either need to wait for their parents or the processing has
+	 * already started for them after their parents were processed.
 	 */
-	dev->power.work_in_progress = false;
-
-	return false;
+	device_for_each_child(dev, func, dpm_async_with_cleanup);
 }
 
 static void dpm_clear_async_state(struct device *dev)
@@ -627,6 +654,13 @@
 	dev->power.work_in_progress = false;
 }
 
+static bool dpm_root_device(struct device *dev)
+{
+	return !dev->parent;
+}
+
+static void async_resume_noirq(void *data, async_cookie_t cookie);
+
 /**
  * device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
@@ -710,6 +744,8 @@
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
 	}
+
+	dpm_async_resume_children(dev, async_resume_noirq);
 }
 
 static void async_resume_noirq(void *data, async_cookie_t cookie)
@@ -733,19 +769,20 @@
 	mutex_lock(&dpm_list_mtx);
 
 	/*
-	 * Trigger the resume of "async" devices upfront so they don't have to
-	 * wait for the "non-async" ones they don't depend on.
+	 * Start processing "async" root devices upfront so they don't wait for
+	 * the "sync" devices they don't depend on.
 	 */
 	list_for_each_entry(dev, &dpm_noirq_list, power.entry) {
 		dpm_clear_async_state(dev);
-		dpm_async_fn(dev, async_resume_noirq);
+		if (dpm_root_device(dev))
+			dpm_async_with_cleanup(dev, async_resume_noirq);
 	}
 
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
 
-		if (!dev->power.work_in_progress) {
+		if (!dpm_async_fn(dev, async_resume_noirq)) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
@@ -781,6 +818,8 @@
 	device_wakeup_disarm_wake_irqs();
 }
 
+static void async_resume_early(void *data, async_cookie_t cookie);
+
 /**
  * device_resume_early - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
@@ -848,6 +887,8 @@
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async early" : " early", error);
 	}
+
+	dpm_async_resume_children(dev, async_resume_early);
 }
 
 static void async_resume_early(void *data, async_cookie_t cookie)
@@ -875,19 +916,20 @@
 	mutex_lock(&dpm_list_mtx);
 
 	/*
-	 * Trigger the resume of "async" devices upfront so they don't have to
-	 * wait for the "non-async" ones they don't depend on.
+	 * Start processing "async" root devices upfront so they don't wait for
+	 * the "sync" devices they don't depend on.
 	 */
 	list_for_each_entry(dev, &dpm_late_early_list, power.entry) {
 		dpm_clear_async_state(dev);
-		dpm_async_fn(dev, async_resume_early);
+		if (dpm_root_device(dev))
+			dpm_async_with_cleanup(dev, async_resume_early);
 	}
 
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
 		list_move_tail(&dev->power.entry, &dpm_suspended_list);
 
-		if (!dev->power.work_in_progress) {
+		if (!dpm_async_fn(dev, async_resume_early)) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
@@ -919,6 +961,8 @@
 }
 EXPORT_SYMBOL_GPL(dpm_resume_start);
 
+static void async_resume(void *data, async_cookie_t cookie);
+
 /**
  * device_resume - Execute "resume" callbacks for given device.
  * @dev: Device to handle.
@@ -1018,6 +1062,8 @@
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async" : "", error);
 	}
+
+	dpm_async_resume_children(dev, async_resume);
 }
 
 static void async_resume(void *data, async_cookie_t cookie)
@@ -1049,19 +1095,20 @@
 	mutex_lock(&dpm_list_mtx);
 
 	/*
-	 * Trigger the resume of "async" devices upfront so they don't have to
-	 * wait for the "non-async" ones they don't depend on.
+	 * Start processing "async" root devices upfront so they don't wait for
+	 * the "sync" devices they don't depend on.
 	 */
 	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
 		dpm_clear_async_state(dev);
-		dpm_async_fn(dev, async_resume);
+		if (dpm_root_device(dev))
+			dpm_async_with_cleanup(dev, async_resume);
 	}
 
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
 		list_move_tail(&dev->power.entry, &dpm_prepared_list);
 
-		if (!dev->power.work_in_progress) {
+		if (!dpm_async_fn(dev, async_resume)) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);





