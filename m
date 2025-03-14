Return-Path: <linux-pm+bounces-24057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BACA61279
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D70B1B62DFE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270EF1FF5F7;
	Fri, 14 Mar 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="GHHgdLaI"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94071FF1D2;
	Fri, 14 Mar 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958590; cv=none; b=EKmixEs84uNQFb0N8vP+RgvhzRxD5e8t+3TI4cLOejP1eweGYClglfkHcCbORXU080hTWsroUIrkO4cR0Z16Qi9OfIZuZcsPZMQPIubPYDmHvTVXm+idrDlsOQE1dz515yMQJaXi7cJ3MT+iIVwJCCOPxZDNw1xgoGw/rwiO5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958590; c=relaxed/simple;
	bh=uFotQyJj/99NJnpmnWY+BRTYNvnCO0dKOi2xTk3WIr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OV1oaBF42aOuJU0E+JqntB1Y+lGedtTWcFQtLE6uRussA3Eh+u1m74RMXWLCNgKfKXpZDXkPATdLPypIajoSS0jFzZhnE/jqj2b0/DMKpI7BVzpeAW1lgt8EXIsHd/6kcROORrh8zrWiR3YpuLbk9dUJXk5xgSAO+K1jJZXldws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=GHHgdLaI; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 5de17aa8f3a25c7b; Fri, 14 Mar 2025 14:23:05 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2E3B5912CFB;
	Fri, 14 Mar 2025 14:23:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741958585;
	bh=uFotQyJj/99NJnpmnWY+BRTYNvnCO0dKOi2xTk3WIr0=;
	h=From:Subject:Date;
	b=GHHgdLaIMXUTiGKuSUVr6lEFdPG9psLgesVI0wS/xscN1qw+KUWRyxEXlrzU8zn9l
	 0xCiAD+OOoRh6tpe0SehW6TdmGTUn4XCqmjptMSG6Z0CuGdi4rqtIyODGCmm9zOEA1
	 CnSJXviVIc/XzpnG+CJk3CR4HnDckLG0Yuj3QJpqaBIQm5qEs44app460CK28i3vVs
	 ElcQFtv6OMW6kau6Ow00Qgz6BHQw09xb0MzJm/FyG030wcXIJdmCyeCyJJ8bUMaEPZ
	 ANH79PmAD7BIEzIMF/70izwEPL7udYCQ06I6dek75Oq6kPhizHp27wujqaswCyg9sM
	 kg4MEE6yYMHGQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending children
Date: Fri, 14 Mar 2025 14:13:53 +0100
Message-ID: <3541233.QJadu78ljV@rjwysocki.net>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=24 Fuz1=24 Fuz2=24

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In analogy with the previous change affecting the resume path,
make device_suspend() start the async suspend of the device's parent
after the device itself has been processed and make dpm_suspend() start
processing "async" leaf devices (that is, devices without children)
upfront so they don't need to wait for the "sync" devices they don't
depend on.

On the Dell XPS13 9360 in my office, this change reduces the total
duration of device suspend by approximately 100 ms (over 20%).

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * When starting async processing early, only take parents and children
     into account.
   * Refine parent check in dpm_async_suspend_parent().
   * Use list_splice() for merging lists on errors.
   * Adjust subject and changelog.
   * Adjust comments.

v1 -> v2:
   * Adjust for the changes in patch [1/3].
   * Fix walking suppliers in dpm_async_suspend_superior().
   * Use device links read locking in dpm_async_suspend_superior() (Saravana).
   * Move all devices to the target list even if there are errors in
     dpm_suspend() so they are properly resumed during rollback (Saravana).

---
 drivers/base/power/main.c |   67 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1236,6 +1236,41 @@
 
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
+	return true;
+}
+
+static void dpm_async_suspend_parent(struct device *dev, async_func_t func)
+{
+	guard(mutex)(&dpm_list_mtx);
+
+	/*
+	 * If the device is suspended asynchronously and the parent's callback
+	 * deletes both the device and the parent itself, the parent object may
+	 * be freed while this function is running, so avoid that by checking
+	 * if the device has been deleted already as the parent cannot be
+	 * deleted before it.
+	 */
+	if (!device_pm_initialized(dev))
+		return;
+
+	/* Start processing the device's parent if it is "async". */
+	if (dev->parent)
+		dpm_async_with_cleanup(dev->parent, func);
+}
+
 /**
  * resume_event - Return a "resume" message for given "suspend" sleep state.
  * @sleep_state: PM message representing a sleep state.
@@ -1661,6 +1696,8 @@
 	device_links_read_unlock(idx);
 }
 
+static void async_suspend(void *data, async_cookie_t cookie);
+
 /**
  * device_suspend - Execute "suspend" callbacks for given device.
  * @dev: Device to handle.
@@ -1790,7 +1827,13 @@
 
 	complete_all(&dev->power.completion);
 	TRACE_SUSPEND(error);
-	return error;
+
+	if (error || async_error)
+		return error;
+
+	dpm_async_suspend_parent(dev, async_suspend);
+
+	return 0;
 }
 
 static void async_suspend(void *data, async_cookie_t cookie)
@@ -1808,6 +1851,7 @@
 int dpm_suspend(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
+	struct device *dev;
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
@@ -1821,12 +1865,21 @@
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Start processing "async" leaf devices upfront so they don't need to
+	 * wait for the "sync" devices they don't depend on.
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
 		if (dpm_async_fn(dev, async_suspend))
 			continue;
 
@@ -1840,8 +1893,14 @@
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error)
+		if (error || async_error) {
+			/*
+			 * Move all devices to the target list to resume them
+			 * properly.
+			 */
+			list_splice(&dpm_prepared_list, &dpm_suspended_list);
 			break;
+		}
 	}
 
 	mutex_unlock(&dpm_list_mtx);




