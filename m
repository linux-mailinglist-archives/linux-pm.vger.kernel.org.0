Return-Path: <linux-pm+bounces-22901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD391A4471A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD2865E36
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416719B3CB;
	Tue, 25 Feb 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fLA0Ig5x"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886019A288;
	Tue, 25 Feb 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501987; cv=none; b=bmaGZpz2FCpgA2USnSvwdojl6jZC+BrDHQ5uLVhgCMR8tgfm9JapwL+Kr2M3dWTHqWMM4+j77Y5SJ5NdL/WrjTVlwG0mdKKNOaNDBc3cBhRlULO6u2iNwDaBfptsNg+9Z1vREaf82xClj9m1FNAEAe8vUy70xeeFgogPIVXuEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501987; c=relaxed/simple;
	bh=+k1w3zIKJCdHQc3g5rjCyOSmrNbD4FRJ5HlfhHPq9GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTq7HGxwepK/05jzLrod9hDxwmKQ9vnzweeXr/Y802LOFCUNrxkZKY/U47dT6v4BFcwuyEXMt6wVFVLS3KoWBioXc00vn8MyuKl1cSh03FiLn7bAg9co+9kDY32GPcvJg6dypbRo7wUieV43oHQ3oatkBMqaK77KaHaF7Uh1agQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fLA0Ig5x; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 99d3f2a535374919; Tue, 25 Feb 2025 17:46:17 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CAFB622C28BF;
	Tue, 25 Feb 2025 17:46:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740501977;
	bh=+k1w3zIKJCdHQc3g5rjCyOSmrNbD4FRJ5HlfhHPq9GA=;
	h=From:Subject:Date;
	b=fLA0Ig5xjF91+fuwfuy0zRP0pL6tRJdi/dN0D4abz5IZpoBP+hrJGWdgU7zghNw43
	 xZ1KmXjCsfidROcmHu62SFS1YjrICVL1NPuhD7L8I+a4NUaO3CxhnOJX11Pf2A4Yk+
	 0ZPUbt+WNIFG1N2Hla4i1y1THwR9jCSPKCKBIfB0uT4U0/xwnYLvMmvR3xWge/qEL9
	 5Wy/um4yjftSi2h5g37gEGxYgvkqFIGf4al9pZD7/XwUjlSE10VdQIRgdxuODT1YoU
	 gehVZUux2xjHrXdDckCffMNAOvjNpcqcdaRyc5XEFryN6hDsrxjws7X7feX69WHX3J
	 8sVYiUYXYap1w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v1 3/5] PM: sleep: Resume children right after resuming the parent
Date: Tue, 25 Feb 2025 17:45:22 +0100
Message-ID: <1819312.VLH7GnMWUR@rjwysocki.net>
In-Reply-To: <13709135.uLZWGnKmhe@rjwysocki.net>
References: <13709135.uLZWGnKmhe@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepjhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

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
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   72 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 9 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -621,12 +621,41 @@
 	return false;
 }
 
+static int dpm_async_unless_in_progress(struct device *dev, void *fn)
+{
+	async_func_t func = fn;
+
+	if (!dev->power.work_in_progress)
+		dpm_async_fn(dev, func);
+
+	return 0;
+}
+
+static void dpm_async_resume_children(struct device *dev, async_func_t func)
+{
+	mutex_lock(&dpm_list_mtx);
+
+	/*
+	 * Start processing "async" children of the device unless it's been
+	 * started already for them.
+	 *
+	 * This could have been done for the device's "async" consumers too, but
+	 * they either need to wait for their parents or the processing has
+	 * already started for them after their parents were processed.
+	 */
+	device_for_each_child(dev, func, dpm_async_unless_in_progress);
+
+	mutex_unlock(&dpm_list_mtx);
+}
+
 static void dpm_clear_async_state(struct device *dev)
 {
 	reinit_completion(&dev->power.completion);
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
@@ -733,19 +764,24 @@
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
+			dpm_async_fn(dev, async_resume_noirq);
 	}
 
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
 
+		dpm_async_unless_in_progress(dev, async_resume_noirq);
+
 		if (!dev->power.work_in_progress) {
+			dev->power.work_in_progress = true;
+
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
@@ -781,6 +817,8 @@
 	device_wakeup_disarm_wake_irqs();
 }
 
+static void async_resume_early(void *data, async_cookie_t cookie);
+
 /**
  * device_resume_early - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
@@ -848,6 +886,8 @@
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async early" : " early", error);
 	}
+
+	dpm_async_resume_children(dev, async_resume_early);
 }
 
 static void async_resume_early(void *data, async_cookie_t cookie)
@@ -875,19 +915,24 @@
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
+			dpm_async_fn(dev, async_resume_early);
 	}
 
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
 		list_move_tail(&dev->power.entry, &dpm_suspended_list);
 
+		dpm_async_unless_in_progress(dev, async_resume_early);
+
 		if (!dev->power.work_in_progress) {
+			dev->power.work_in_progress = true;
+
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
@@ -919,6 +964,8 @@
 }
 EXPORT_SYMBOL_GPL(dpm_resume_start);
 
+static void async_resume(void *data, async_cookie_t cookie);
+
 /**
  * device_resume - Execute "resume" callbacks for given device.
  * @dev: Device to handle.
@@ -1012,6 +1059,8 @@
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async" : "", error);
 	}
+
+	dpm_async_resume_children(dev, async_resume);
 }
 
 static void async_resume(void *data, async_cookie_t cookie)
@@ -1043,19 +1092,24 @@
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
+			dpm_async_fn(dev, async_resume);
 	}
 
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
 		list_move_tail(&dev->power.entry, &dpm_prepared_list);
 
+		dpm_async_unless_in_progress(dev, async_resume);
+
 		if (!dev->power.work_in_progress) {
+			dev->power.work_in_progress = true;
+
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);




