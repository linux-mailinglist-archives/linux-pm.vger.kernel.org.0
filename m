Return-Path: <linux-pm+bounces-23997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDBBA602B8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 21:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8073B125F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0DE1F463C;
	Thu, 13 Mar 2025 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ORaCZlcw"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844571F37C5;
	Thu, 13 Mar 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898132; cv=none; b=Ze1mjNjfHQ54Wv0ne79T+keAGFsrwOEjRggGt3R3s0X4/oMWwpoPfGFup/tf06qF/rCgI1DJxiIauto8VqmMbYZinPsiNTHEL9L4sINKRJzfwsIZnwaV4Ynai8r7OuxsCrQJtRsfoRxy1UpfPgPGM3bJ3ur4R3bo6tK4AnHPwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898132; c=relaxed/simple;
	bh=Bu0PktBMHBhQFAY01Z2FQXI2KJUpuNghVeOrGayJTC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZzJg4NrVNpc9uScg07eGcy5fEIThr3R1XJrYUVwDPJuY0A8Mex8Kvf7OKk4zYyOET6TAlxHt22txU797cpwQ1ASAHJWiXiG/2MnSjoo8VBoiZoXEv0iwqERmu4m1wJ610+RG/veBrj6tLIJfX4mC6cuOgFd8Puop6lq0CXX/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ORaCZlcw; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 5c0ce5d0e197efee; Thu, 13 Mar 2025 21:35:28 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D9D428E4517;
	Thu, 13 Mar 2025 21:35:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741898128;
	bh=Bu0PktBMHBhQFAY01Z2FQXI2KJUpuNghVeOrGayJTC8=;
	h=From:Subject:Date;
	b=ORaCZlcwCKy3PNpT43l/Q7W5qIyX0jMtipCZz7nvJbKKsgcC+YqEvPV8fz/efLwg2
	 Jh/nn4EyaSnWQDmUPI5Ecyp2vk4omoE1ZdecemVT6J1FhvOjuZFPyOYEAYcSkMVrw+
	 YOAdPalGzpK7B2fbhpiJ1l/1ZRnT634BVpHQ6dFaQVxwuYV0VNKb926PVHa5fjR3Cs
	 RrEDzp+OBoi7zEYxB4ulLJOfIWTRNXL44R9DDFr8vijxr+oddTXziJZ6XmlY2bBiM/
	 McyNUCcvVSwJ65PKj0CaRlTLWKC2efwWVCqvWVaD4O1dgTsirrxDU3brnveYMPumjr
	 ZzHHUHSBM3pcQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v2 2/3] PM: sleep: Suspend parents and suppliers after suspending
 subordinates
Date: Thu, 13 Mar 2025 21:34:33 +0100
Message-ID: <3271724.5fSG56mABF@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepjhhohhgrnheskhgvrhhnvghlrdhorhhgpdhrtgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In analogy with the previous change affecting the resume path,
make device_suspend() start the async suspend of the device's parent
and suppliers after the device itself has been processed and make
dpm_suspend() start processing "async" leaf devices (that is, devices
without children or consumers) upfront because they don't need to wait
for any other devices.

On the Dell XPS13 9360 in my office, this change reduces the total
duration of device suspend by approximately 100 ms (over 20%).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Suggested-by: Saravana Kannan <saravanak@google.com>
---

v1 -> v2:
   * Adjust for the changes in patch [1/3].
   * Fix walking suppliers in dpm_async_suspend_superior().
   * Use device links read locking in dpm_async_suspend_superior() (Saravana).
   * Move all devices to the target list even if there are errors in
     dpm_suspend() so they are properly resumed during rollback (Saravana).

---
 drivers/base/power/main.c |   78 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1231,6 +1231,50 @@
 
 /*------------------------- Suspend routines -------------------------*/
 
+static bool dpm_leaf_device(struct device *dev)
+{
+	struct device *child;
+
+	lockdep_assert_held(&dpm_list_mtx);
+
+	child = device_find_any_child(dev);
+	if (child) {
+		put_device(child);
+
+		return false;
+	}
+
+	/*
+	 * Since this function is required to run under dpm_list_mtx, the
+	 * list_empty() below will only return true if the device's list of
+	 * consumers is actually empty before calling it.
+	 */
+	return list_empty(&dev->links.consumers);
+}
+
+static void dpm_async_suspend_superior(struct device *dev, async_func_t func)
+{
+	struct device_link *link;
+	int idx;
+
+	mutex_lock(&dpm_list_mtx);
+
+	/* Start processing the device's parent if it is "async". */
+	if (dev->parent)
+		dpm_async_with_cleanup(dev->parent, func);
+
+	mutex_unlock(&dpm_list_mtx);
+
+	idx = device_links_read_lock();
+
+	/* Start processing the device's "async" suppliers. */
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+			dpm_async_with_cleanup(link->supplier, func);
+
+	device_links_read_unlock(idx);
+}
+
 /**
  * resume_event - Return a "resume" message for given "suspend" sleep state.
  * @sleep_state: PM message representing a sleep state.
@@ -1656,6 +1700,8 @@
 	device_links_read_unlock(idx);
 }
 
+static void async_suspend(void *data, async_cookie_t cookie);
+
 /**
  * device_suspend - Execute "suspend" callbacks for given device.
  * @dev: Device to handle.
@@ -1785,7 +1831,13 @@
 
 	complete_all(&dev->power.completion);
 	TRACE_SUSPEND(error);
-	return error;
+
+	if (error || async_error)
+		return error;
+
+	dpm_async_suspend_superior(dev, async_suspend);
+
+	return 0;
 }
 
 static void async_suspend(void *data, async_cookie_t cookie)
@@ -1803,6 +1855,7 @@
 int dpm_suspend(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
+	struct device *dev;
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
@@ -1816,12 +1869,28 @@
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Start processing "async" leaf devices upfront because they don't need
+	 * to wait.
+	 */
+	list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry) {
+		dpm_clear_async_state(dev);
+		if (dpm_leaf_device(dev))
+			dpm_async_with_cleanup(dev, async_suspend);
+	}
+
 	while (!list_empty(&dpm_prepared_list)) {
-		struct device *dev = to_device(dpm_prepared_list.prev);
+		dev = to_device(dpm_prepared_list.prev);
 
 		list_move(&dev->power.entry, &dpm_suspended_list);
 
-		dpm_clear_async_state(dev);
+		/*
+		 * Move all devices to the target list to resume them properly
+		 * on errors.
+		 */
+		if (error || async_error)
+			continue;
+
 		if (dpm_async_fn(dev, async_suspend))
 			continue;
 
@@ -1834,9 +1903,6 @@
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
-
-		if (error || async_error)
-			break;
 	}
 
 	mutex_unlock(&dpm_list_mtx);




