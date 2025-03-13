Return-Path: <linux-pm+bounces-23999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A95A602BE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 21:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944B27AAABE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB31F4E4B;
	Thu, 13 Mar 2025 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dHcKMIjJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1E1F4629;
	Thu, 13 Mar 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898134; cv=none; b=aDvQcspjsUkEWF1CLFS1MogqZkbOZmO3o9XoC7wZN1qTIlCFE9qsnibOWjBXsEP+2MvzT4TzG4xOXtxYygGjyqeKZhoHrzX13iLgCipwg8XhMb4rKDm/zAiHbamjGcV1XA91zMK3tzCZABdTQ8roH/zEb8SR4rjrIaRgorN3+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898134; c=relaxed/simple;
	bh=07RaQwLG1ZQ6iEnzoTxQiO05Gm8Rsfct4gDJ9ijKynk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQgmT0mrgWsMY5vNy958c2i4xDd2Vvo4WqGReGia1w4HOsBJshaoPjZecsNK6ih5xAb3ldfjujA51iqUvx8oEE6uD4gHrQaDcj4a7e7oS3QAX19mH9CmAm/BPkN7pu3R+PsnKXy24Ct8OnGqtukmuZ8X5QApI+nEetb9OdwR1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dHcKMIjJ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 4e3b9c4d6bbf6f51; Thu, 13 Mar 2025 21:35:29 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CB0528E4517;
	Thu, 13 Mar 2025 21:35:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741898129;
	bh=07RaQwLG1ZQ6iEnzoTxQiO05Gm8Rsfct4gDJ9ijKynk=;
	h=From:Subject:Date;
	b=dHcKMIjJH+m6f8Fvu0PmcfDLp8rEq2GL4wx0H0Z0jjY9CmxRLkNCJNeM9QH6mzZu1
	 4H8tVzyQsuzIZ0KPbimyRORIUtk97YiImnKP8i79uO/wLKfwtZ8tFSiCOa9zAoAYvU
	 0g2a1/dXHTBZkU+U6J7TlPYg3afB1Gr3H4gM3OEy00Kw2feo8QWKWDNV1kuehAUubb
	 gzbtOU9vRUlNswzm+HZ3/mwaiq7Kw90JdXv7hAwXYV4vYF2K2DwoeB6AefPc729LH2
	 6cW6VJZvVgM7vc5l9g+MN0wc88DJYuy5fBHg79pJ2Ld4uL5LDK2WDrt1iAkvU0qBNL
	 To8PLmLpB4xwA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>
Subject: [PATCH v2 1/3] PM: sleep: Resume children after resuming the parent
Date: Thu, 13 Mar 2025 21:26:53 +0100
Message-ID: <3346996.44csPzL39Z@rjwysocki.net>
In-Reply-To: <1915694.tdWV9SEqCh@rjwysocki.net>
References: <1915694.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopeh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

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
not affect the overall system resume duration in a significant way.

Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@google.com/ [1]
Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   Use a separate lock for power.work_in_progress protection which should
   reduce lock contention on dpm_list_mtx.

---
 drivers/base/power/main.c |   80 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 19 deletions(-)

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
@@ -627,6 +654,8 @@
 	dev->power.work_in_progress = false;
 }
 
+static void async_resume_noirq(void *data, async_cookie_t cookie);
+
 /**
  * device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
@@ -710,6 +739,8 @@
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
 	}
+
+	dpm_async_resume_children(dev, async_resume_noirq);
 }
 
 static void async_resume_noirq(void *data, async_cookie_t cookie)
@@ -733,19 +764,20 @@
 	mutex_lock(&dpm_list_mtx);
 
 	/*
-	 * Trigger the resume of "async" devices upfront so they don't have to
-	 * wait for the "non-async" ones they don't depend on.
+	 * Start processing "async" devices without parents upfront so they
+	 * don't wait for the "sync" devices they don't depend on.
 	 */
 	list_for_each_entry(dev, &dpm_noirq_list, power.entry) {
 		dpm_clear_async_state(dev);
-		dpm_async_fn(dev, async_resume_noirq);
+		if (!dev->parent)
+			dpm_async_with_cleanup(dev, async_resume_noirq);
 	}
 
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
 
-		if (!dev->power.work_in_progress) {
+		if (!dpm_async_fn(dev, async_resume_noirq)) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
@@ -781,6 +813,8 @@
 	device_wakeup_disarm_wake_irqs();
 }
 
+static void async_resume_early(void *data, async_cookie_t cookie);
+
 /**
  * device_resume_early - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
@@ -848,6 +882,8 @@
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async early" : " early", error);
 	}
+
+	dpm_async_resume_children(dev, async_resume_early);
 }
 
 static void async_resume_early(void *data, async_cookie_t cookie)
@@ -875,19 +911,20 @@
 	mutex_lock(&dpm_list_mtx);
 
 	/*
-	 * Trigger the resume of "async" devices upfront so they don't have to
-	 * wait for the "non-async" ones they don't depend on.
+	 * Start processing "async" devices without parents upfront so they
+	 * don't wait for the "sync" devices they don't depend on.
 	 */
 	list_for_each_entry(dev, &dpm_late_early_list, power.entry) {
 		dpm_clear_async_state(dev);
-		dpm_async_fn(dev, async_resume_early);
+		if (!dev->parent)
+			dpm_async_with_cleanup(dev, async_resume_early);
 	}
 
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
 		list_move_tail(&dev->power.entry, &dpm_suspended_list);
 
-		if (!dev->power.work_in_progress) {
+		if (!dpm_async_fn(dev, async_resume_early)) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
@@ -919,6 +956,8 @@
 }
 EXPORT_SYMBOL_GPL(dpm_resume_start);
 
+static void async_resume(void *data, async_cookie_t cookie);
+
 /**
  * device_resume - Execute "resume" callbacks for given device.
  * @dev: Device to handle.
@@ -1018,6 +1057,8 @@
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async" : "", error);
 	}
+
+	dpm_async_resume_children(dev, async_resume);
 }
 
 static void async_resume(void *data, async_cookie_t cookie)
@@ -1049,19 +1090,20 @@
 	mutex_lock(&dpm_list_mtx);
 
 	/*
-	 * Trigger the resume of "async" devices upfront so they don't have to
-	 * wait for the "non-async" ones they don't depend on.
+	 * Start processing "async" devices without parents upfront so they
+	 * don't wait for the "sync" devices they don't depend on.
 	 */
 	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
 		dpm_clear_async_state(dev);
-		dpm_async_fn(dev, async_resume);
+		if (!dev->parent)
+			dpm_async_with_cleanup(dev, async_resume);
 	}
 
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
 		list_move_tail(&dev->power.entry, &dpm_prepared_list);
 
-		if (!dev->power.work_in_progress) {
+		if (!dpm_async_fn(dev, async_resume)) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);




