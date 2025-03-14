Return-Path: <linux-pm+bounces-24056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7321BA61271
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FA216F464
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647F1FF613;
	Fri, 14 Mar 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="bE5qpaLT"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E21FE44C;
	Fri, 14 Mar 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958367; cv=none; b=dZzKxdFq65V+s4FCZYurLovWfXhWkLY+H/OoKRdVyxJAI3O6olvoCfY/fDx82eTa6xOCuNEL6V8PRziQTE1h6mK22dzLH2Ns9pzJ/4Z5g5pn7jxLXACqPAmJY88kULCpwaZna7AJa4c2tAVrYJcormYqbY23s/dpWaNduWQ3HKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958367; c=relaxed/simple;
	bh=+TLFi6zGn84ndYCYlPnSlEB/FndOyxFdAhy3aD2xDak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMS+jeY5QjMXxzSHr8MpMp/wuFO5OZEugcGS5qIKwStkX4KHlCz02QDPPgupKISn1pCoDLnqPO6Q4StUSXxUKciMaW1fZBH3tWpcD9BXFOtApZSY+y4wPCwLFHSGJDoNv1wEN9bzSl7h3ZVuYEQ7Uh6CMRcC36NLXpx99r/RvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=bE5qpaLT; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id f27c172963a66e5f; Fri, 14 Mar 2025 14:19:23 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D2222912CFA;
	Fri, 14 Mar 2025 14:19:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741958363;
	bh=+TLFi6zGn84ndYCYlPnSlEB/FndOyxFdAhy3aD2xDak=;
	h=From:Subject:Date;
	b=bE5qpaLT5vih/iOq8DV5KaLz0Ofx5+j4ScSmVus2TpkE6eS/nbiI3l8G5dnjcaWkA
	 xo3aRAlD4GylZihdVT70Z1C89APc87bqyHJWwGz+RDd4llxrV3bjPwuFp/EtCTWmeT
	 YFeqtvVfOQR4gm11Nr/llg997C6Qu93RMq9yNMBfFRXIcVAjy8GM3lwgWpvKR/Kt26
	 jSyQXtsg8aAOwXu5/SyBgfxW1kU4N6i1zV84QBVsOdPrMP7tgUp0q4t4o1TxFjqwOd
	 tRMcM+66ziEyn3+LnBQv2QJPyCjruQ+F1x3SUJqKvQWVO3LM6HU7DT/YtZ4TdwlVng
	 4t5jxLJfMUe6A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>
Subject: [PATCH v3 3/5] PM: sleep: Make suspend of devices more asynchronous
Date: Fri, 14 Mar 2025 14:14:30 +0100
Message-ID: <1924195.CQOukoFCf9@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In analogy with previous changes, make device_suspend_late() and
device_suspend_noirq() start the async suspend of the device's parent
after the device itself has been processed and make dpm_suspend_late()
and dpm_noirq_suspend_devices() start processing "async" leaf devices
(that is, devices without children) upfront so they don't need to wait
for the other devices they don't depend on.

This change reduces the total duration of device suspend on some systems
measurably, but not significantly.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Adjust for the changes made in patch [2/5].
   * Use list_splice() for merging lists on errors.
   * Adjust changelog.

v1 -> v2:
   * Adjust for the changes in patches [1-2/3].
   * Move all devices to the target lists even if there are errors in
     dpm_suspend_late() and dpm_noirq_suspend_devices() so they are
     properly resumed during rollback (Saravana).

---
 drivers/base/power/main.c |   64 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 8 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1308,6 +1308,8 @@
 	device_links_read_unlock(idx);
 }
 
+static void async_suspend_noirq(void *data, async_cookie_t cookie);
+
 /**
  * device_suspend_noirq - Execute a "noirq suspend" callback for given device.
  * @dev: Device to handle.
@@ -1386,7 +1388,13 @@
 Complete:
 	complete_all(&dev->power.completion);
 	TRACE_SUSPEND(error);
-	return error;
+
+	if (error || async_error)
+		return error;
+
+	dpm_async_suspend_parent(dev, async_suspend_noirq);
+
+	return 0;
 }
 
 static void async_suspend_noirq(void *data, async_cookie_t cookie)
@@ -1400,6 +1408,7 @@
 static int dpm_noirq_suspend_devices(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
+	struct device *dev;
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
@@ -1409,12 +1418,21 @@
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Start processing "async" leaf devices upfront so they don't need to
+	 * wait for the "sync" devices they don't depend on.
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
 		if (dpm_async_fn(dev, async_suspend_noirq))
 			continue;
 
@@ -1428,8 +1446,14 @@
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error)
+		if (error || async_error) {
+			/*
+			 * Move all devices to the target list to resume them
+			 * properly.
+			 */
+			list_splice(&dpm_late_early_list, &dpm_noirq_list);
 			break;
+		}
 	}
 
 	mutex_unlock(&dpm_list_mtx);
@@ -1482,6 +1506,8 @@
 	spin_unlock_irq(&parent->power.lock);
 }
 
+static void async_suspend_late(void *data, async_cookie_t cookie);
+
 /**
  * device_suspend_late - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
@@ -1558,7 +1584,13 @@
 Complete:
 	TRACE_SUSPEND(error);
 	complete_all(&dev->power.completion);
-	return error;
+
+	if (error || async_error)
+		return error;
+
+	dpm_async_suspend_parent(dev, async_suspend_late);
+
+	return 0;
 }
 
 static void async_suspend_late(void *data, async_cookie_t cookie)
@@ -1576,6 +1608,7 @@
 int dpm_suspend_late(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
+	struct device *dev;
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
@@ -1587,12 +1620,21 @@
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Start processing "async" leaf devices upfront so they don't need to
+	 * wait for the "sync" devices they don't depend on.
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
 		if (dpm_async_fn(dev, async_suspend_late))
 			continue;
 
@@ -1606,8 +1648,14 @@
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error)
+		if (error || async_error) {
+			/*
+			 * Move all devices to the target list to resume them
+			 * properly.
+			 */
+			list_splice(&dpm_suspended_list, &dpm_late_early_list);
 			break;
+		}
 	}
 
 	mutex_unlock(&dpm_list_mtx);




