Return-Path: <linux-pm+bounces-23996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB18A602B6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 21:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02C43ADA67
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AB41F4628;
	Thu, 13 Mar 2025 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="d/4BYgPb"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A595B1F1300;
	Thu, 13 Mar 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898132; cv=none; b=NwKYsotXmJLzb3j4ugMI8ZoqwLRXGYj699M0rAZbKm9UM2eUQ3qxMB8lQ8e7nNiOgKwLbJSq0pl/vIdm5mkuf3ScVFR7wlTkA8FLg1MsJEjDf4TNPDZ3KbSzNqv9L7naS2geOFabNMrSEGdSPcAxSAGJ/gwpZVvZd1t/mpyqD10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898132; c=relaxed/simple;
	bh=hcJz+Lim0wyn5nnm5SXK6SMc50j1KpHdWKRcvXbEl2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UejxSMoFu2oVBR3VZIsl0bcYKTxUXKWev0dy1KyWadE/OHJpprujMVN6LLdP7o3lPk+sGDe5kYvNdMGQ8VE6LFH0TQMv5W5wRDhJPyKhtpeF0kVzjSCNv4AK4n/TwZAZOZjGjxqmGMQOPLfgWRRLFqE9Mv1MqXhT7ZG4QGgXQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=d/4BYgPb; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id e71e64c370882949; Thu, 13 Mar 2025 21:35:27 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C93008E4517;
	Thu, 13 Mar 2025 21:35:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741898127;
	bh=hcJz+Lim0wyn5nnm5SXK6SMc50j1KpHdWKRcvXbEl2w=;
	h=From:Subject:Date;
	b=d/4BYgPbn/98WUqif9KVcJM+Oopt0MHJEEZ4aDJ012CUwpDrHq44IZN8Ur7QkwvgY
	 BwMqS7Z78Crtqw+0oylU9L8gWtfh11YlEUucMStUIlzG33SclHsHOdJrZfV3n/tImx
	 sqbe9KRjU4CoorkhV8X+tusnqnfE4EO3fEjBg52geDVmVjTKtHcn3cPLZAvPwevfIS
	 ijDVjhV6F6tkQGTuXfIGK4fFrFotFESxGDN4yDLL/MPDAOxQN9kTmsdPSIfv/HXVgb
	 8FrSWbwzyqrkvZZXCGM3YAddvWsVl0CvMRgWbhpc4BFfLF3jUY8KetOAc7mShcq8xD
	 3J4NkLPYFMSyQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>
Subject: [PATCH v2 3/3] PM: sleep: Make suspend of devices more asynchronous
Date: Thu, 13 Mar 2025 21:35:17 +0100
Message-ID: <6030952.MhkbZ0Pkbq@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepjhhohhgrnheskhgvrhhnvghlrdhorhhgpdhrtgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In analogy with previous changes, make device_suspend_late() and
device_suspend_noirq() start the async suspend of the device's parent
and suppliers after the device itself has been processed and make
dpm_suspend_late() and dpm_noirq_suspend_devices() start processing
"async" leaf devices (that is, devices without children or consumers)
upfront because they don't need to wait for any other devices.

This change reduces the total duration of device suspend on some systems
where it has been tested measurably, but not significantly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Suggested-by: Saravana Kannan <saravanak@google.com>
---

v1 -> v2:
   * Adjust for the changes in patches [1-2/3].
   * Move all devices to the target lists even if there are errors in
     dpm_suspend_late() and dpm_noirq_suspend_devices() so they are
     properly resumed during rollback (Saravana).

---
 drivers/base/power/main.c |   68 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 12 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1312,6 +1312,8 @@
 	device_links_read_unlock(idx);
 }
 
+static void async_suspend_noirq(void *data, async_cookie_t cookie);
+
 /**
  * device_suspend_noirq - Execute a "noirq suspend" callback for given device.
  * @dev: Device to handle.
@@ -1390,7 +1392,13 @@
 Complete:
 	complete_all(&dev->power.completion);
 	TRACE_SUSPEND(error);
-	return error;
+
+	if (error || async_error)
+		return error;
+
+	dpm_async_suspend_superior(dev, async_suspend_noirq);
+
+	return 0;
 }
 
 static void async_suspend_noirq(void *data, async_cookie_t cookie)
@@ -1404,6 +1412,7 @@
 static int dpm_noirq_suspend_devices(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
+	struct device *dev;
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
@@ -1413,12 +1422,28 @@
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Start processing "async" leaf devices upfront because they don't need
+	 * to wait.
+	 */
+	list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entry) {
+		dpm_clear_async_state(dev);
+		if (dpm_leaf_device(dev))
+			dpm_async_with_cleanup(dev, async_suspend_noirq);
+	}
+
 	while (!list_empty(&dpm_late_early_list)) {
-		struct device *dev = to_device(dpm_late_early_list.prev);
+		dev = to_device(dpm_late_early_list.prev);
 
 		list_move(&dev->power.entry, &dpm_noirq_list);
 
-		dpm_clear_async_state(dev);
+		/*
+		 * Move all devices to the target list to resume them properly
+		 * on errors.
+		 */
+		if (error || async_error)
+			break;
+
 		if (dpm_async_fn(dev, async_suspend_noirq))
 			continue;
 
@@ -1431,9 +1456,6 @@
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
-
-		if (error || async_error)
-			break;
 	}
 
 	mutex_unlock(&dpm_list_mtx);
@@ -1486,6 +1508,8 @@
 	spin_unlock_irq(&parent->power.lock);
 }
 
+static void async_suspend_late(void *data, async_cookie_t cookie);
+
 /**
  * device_suspend_late - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
@@ -1562,7 +1586,13 @@
 Complete:
 	TRACE_SUSPEND(error);
 	complete_all(&dev->power.completion);
-	return error;
+
+	if (error || async_error)
+		return error;
+
+	dpm_async_suspend_superior(dev, async_suspend_late);
+
+	return 0;
 }
 
 static void async_suspend_late(void *data, async_cookie_t cookie)
@@ -1580,6 +1610,7 @@
 int dpm_suspend_late(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
+	struct device *dev;
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
@@ -1591,12 +1622,28 @@
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Start processing "async" leaf devices upfront because they don't need
+	 * to wait.
+	 */
+	list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry) {
+		dpm_clear_async_state(dev);
+		if (dpm_leaf_device(dev))
+			dpm_async_with_cleanup(dev, async_suspend_late);
+	}
+
 	while (!list_empty(&dpm_suspended_list)) {
-		struct device *dev = to_device(dpm_suspended_list.prev);
+		dev = to_device(dpm_suspended_list.prev);
 
 		list_move(&dev->power.entry, &dpm_late_early_list);
 
-		dpm_clear_async_state(dev);
+		/*
+		 * Move all devices to the target list to resume them properly
+		 * on errors.
+		 */
+		if (error || async_error)
+			continue;
+
 		if (dpm_async_fn(dev, async_suspend_late))
 			continue;
 
@@ -1609,9 +1656,6 @@
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
-
-		if (error || async_error)
-			break;
 	}
 
 	mutex_unlock(&dpm_list_mtx);




