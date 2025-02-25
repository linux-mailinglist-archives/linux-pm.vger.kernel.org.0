Return-Path: <linux-pm+bounces-22900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52475A4470F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 17:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2C57B0088
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC40819AD8B;
	Tue, 25 Feb 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="DerIyJ8c"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE4199E88;
	Tue, 25 Feb 2025 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501986; cv=none; b=EQLvvodEYYsFy58KCtUYLI0Pg7Pi9LswWjhnBU7FAZF56Hdt3xRXK29+7eoc6HhQ4oxn1Ak4fGRBUPWA1eVvpR+LCZ7K1oIsNLAdWxEzxp2fzjN+rEaamU4iXjDysBIRJ4V34weRGAjEmBeSD7hXfGsrExrQevUYLaEbHlpenKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501986; c=relaxed/simple;
	bh=/Bl7bGe++8isDlcz6Yj2CRmk4+9xThGrSHZAAT8K00E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mczRtXTxsUWLkCTiuokh8UP9Zb6gbCVLpvKynIRZ/Y26ubgZXGH7HQrhulBSv0agx+b0KfJLKLYWVZ/oH+01NlUtVNiTCacmjV6fjRWq6sZ09yjiWTKM9ZZg3cq3t33+dgkq/EanMmjriSL7t6L6AL0WyZtUDFO1c7NhQ+dS7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=DerIyJ8c; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id d0c76005e8e4e746; Tue, 25 Feb 2025 17:46:15 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0AA6622C28BF;
	Tue, 25 Feb 2025 17:46:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740501975;
	bh=/Bl7bGe++8isDlcz6Yj2CRmk4+9xThGrSHZAAT8K00E=;
	h=From:Subject:Date;
	b=DerIyJ8cOL8sFe0ssqaBLAhjptKb0jb+awo4bNfQCj8BMmtKGyQjTH2dMWFOL9o+G
	 FOv5nXZugVANCRDq1KTNw+O/4WTow7dMhMkAKBrSpedXxMET8I41PtnmffvVCWBH6r
	 WAHs83oGhiKEeK0ea45WVqTB8K48y7Q9w3VJPNiKLpeTse9umHhkAjebdAek4kpYHw
	 vyPSpa6NtdkWm0oKSipvou5+O/kYASjV8uOad/TdAri4bUtJl15XR0XsOTD9SeIv62
	 r1A9SPyCOMjPs3dH2XF0MZetmt44+f0Zti115u2pNVtznIRJSCxXdu7QnJTyyPq9FJ
	 K3iKFaWsOCqAQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v1 5/5] PM: sleep: Make late and noirq suspend of devices more
 asynchronous
Date: Tue, 25 Feb 2025 17:45:37 +0100
Message-ID: <2016539.usQuhbGJ8B@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In analogy with previous changes, make device_suspend_late() and
device_suspend_noirq() start the async suspend of the device's parent
and suppliers after the device itself has been processed and make
dpm_suspend_late() and dpm_noirq_suspend_devices() start processing
"async" leaf devices (that is, devices without children or consumers)
upfront because they don't need to wait for any other devices.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   60 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1317,6 +1317,8 @@
 	device_links_read_unlock(idx);
 }
 
+static void async_suspend_noirq(void *data, async_cookie_t cookie);
+
 /**
  * device_suspend_noirq - Execute a "noirq suspend" callback for given device.
  * @dev: Device to handle.
@@ -1396,7 +1398,13 @@
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
@@ -1410,6 +1418,7 @@
 static int dpm_noirq_suspend_devices(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
+	struct device *dev;
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
@@ -1419,15 +1428,28 @@
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Start processing "async" leaf devices upfront because they don't need
+	 * to wait.
+	 */
+	list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entry) {
+		dpm_clear_async_state(dev);
+		if (dpm_leaf_device(dev))
+			dpm_async_fn(dev, async_suspend_noirq);
+	}
+
 	while (!list_empty(&dpm_late_early_list)) {
-		struct device *dev = to_device(dpm_late_early_list.prev);
+		dev = to_device(dpm_late_early_list.prev);
 
 		list_move(&dev->power.entry, &dpm_noirq_list);
 
-		dpm_clear_async_state(dev);
-		if (dpm_async_fn(dev, async_suspend_noirq))
+		dpm_async_unless_in_progress(dev, async_suspend_noirq);
+
+		if (dev->power.work_in_progress)
 			continue;
 
+		dev->power.work_in_progress = true;
+
 		get_device(dev);
 
 		mutex_unlock(&dpm_list_mtx);
@@ -1492,6 +1514,8 @@
 	spin_unlock_irq(&parent->power.lock);
 }
 
+static void async_suspend_late(void *data, async_cookie_t cookie);
+
 /**
  * device_suspend_late - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
@@ -1568,7 +1592,13 @@
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
@@ -1586,6 +1616,7 @@
 int dpm_suspend_late(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
+	struct device *dev;
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
@@ -1597,15 +1628,28 @@
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Start processing "async" leaf devices upfront because they don't need
+	 * to wait.
+	 */
+	list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry) {
+		dpm_clear_async_state(dev);
+		if (dpm_leaf_device(dev))
+			dpm_async_fn(dev, async_suspend_late);
+	}
+
 	while (!list_empty(&dpm_suspended_list)) {
-		struct device *dev = to_device(dpm_suspended_list.prev);
+		dev = to_device(dpm_suspended_list.prev);
 
 		list_move(&dev->power.entry, &dpm_late_early_list);
 
-		dpm_clear_async_state(dev);
-		if (dpm_async_fn(dev, async_suspend_late))
+		dpm_async_unless_in_progress(dev, async_suspend_late);
+
+		if (dev->power.work_in_progress)
 			continue;
 
+		dev->power.work_in_progress = true;
+
 		get_device(dev);
 
 		mutex_unlock(&dpm_list_mtx);




