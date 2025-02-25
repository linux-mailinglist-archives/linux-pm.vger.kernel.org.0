Return-Path: <linux-pm+bounces-22899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F201A4470E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 17:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E30B7AF302
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6090619ABAB;
	Tue, 25 Feb 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="F32oceb9"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3722199FC9;
	Tue, 25 Feb 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501986; cv=none; b=H0LzwkCVe7nAVdd69t1w5GXxqU5ZGHs52VqWgE4Zr5KTrwQq4+QVmpDgAwlN5iuNxFM1jhTw7oRxR0npd3/RlLPiNg8WeGS6rq1Dj5k8qZjbFInLkdoK5J24ryxl+YSUI1h96p/VjmbyFDfJ3GvC5Zyybky1LAdThzPt0eTp5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501986; c=relaxed/simple;
	bh=/h1M9Yd/hl0peihTWu72GbT2QD7Z8SUTRbuKu4wuUVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/L1yT0z80hLXDyKeaRJAfPTfZNl9oldM136zHP8cpHJouLd7x1SeruI8Upog59rLffoqs8zbDhIHLdcq7wqj6PXR1WqQsNagYbeorlSl93PHzxSRNbWOukjDc+aUIg4/+KVY+YMVywksSU4zZnDJVJcNU0WvIEHzARJY9zIdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=F32oceb9; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id d576d25cca437ddc; Tue, 25 Feb 2025 17:46:16 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E50A922C28BF;
	Tue, 25 Feb 2025 17:46:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740501976;
	bh=/h1M9Yd/hl0peihTWu72GbT2QD7Z8SUTRbuKu4wuUVM=;
	h=From:Subject:Date;
	b=F32oceb9XdzbWUceV5xaf1eeRTSsVGgFgwJOJW+5OErbIt1Mvdhv2fT63tBsBdMAO
	 HDpyjn1xTbE1Ue+c5qm3IT41oAVMqFU2RydR8GAd5c0mlESr6gXtAgZtPSSqOQe2g6
	 mNGxg/nEQ8cpLf/8NwwFj9y/Z6a7RDSaG8gBBsKwYhc3F8hTO+6a2pdrR8nSzabvlt
	 n1su8E6Hpki4bTJkgIvGILHVRB1LmPEFqGYpK7OTN9abPLKzz7AyokBrUUHW5xpJ6i
	 sDTw8jJeqCS3Wjj0+WORaMUBjx0L84bUnu83KxH5yekzQtLzUad5nu3OKU/+z8Sllw
	 ZTxZA+4d3m5EA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v1 4/5] PM: sleep: Start suspending parents and suppliers after
 subordinate suspend
Date: Tue, 25 Feb 2025 17:45:31 +0100
Message-ID: <8536271.NyiUUSuA9g@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

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
---
 drivers/base/power/main.c |   73 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 4 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1237,6 +1237,49 @@
 
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
+
+	mutex_lock(&dpm_list_mtx);
+
+	/* Start processing the device's parent if it is "async". */
+	if (dev->parent)
+		dpm_async_unless_in_progress(dev->parent, func);
+
+	/*
+	 * Start processing the device's "async" suppliers.
+	 *
+	 * The dpm_list_mtx locking is sufficient for this.
+	 */
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+			dpm_async_unless_in_progress(link->consumer, func);
+
+	mutex_unlock(&dpm_list_mtx);
+}
+
 /**
  * resume_event - Return a "resume" message for given "suspend" sleep state.
  * @sleep_state: PM message representing a sleep state.
@@ -1663,6 +1706,8 @@
 	device_links_read_unlock(idx);
 }
 
+static void async_suspend(void *data, async_cookie_t cookie);
+
 /**
  * device_suspend - Execute "suspend" callbacks for given device.
  * @dev: Device to handle.
@@ -1791,7 +1836,13 @@
 
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
@@ -1809,6 +1860,7 @@
 int dpm_suspend(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
+	struct device *dev;
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
@@ -1822,15 +1874,28 @@
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Start processing "async" leaf devices upfront because they don't need
+	 * to wait.
+	 */
+	list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry) {
+		dpm_clear_async_state(dev);
+		if (dpm_leaf_device(dev))
+			dpm_async_fn(dev, async_suspend);
+	}
+
 	while (!list_empty(&dpm_prepared_list)) {
-		struct device *dev = to_device(dpm_prepared_list.prev);
+		dev = to_device(dpm_prepared_list.prev);
 
 		list_move(&dev->power.entry, &dpm_suspended_list);
 
-		dpm_clear_async_state(dev);
-		if (dpm_async_fn(dev, async_suspend))
+		dpm_async_unless_in_progress(dev, async_suspend);
+
+		if (dev->power.work_in_progress)
 			continue;
 
+		dev->power.work_in_progress = true;
+
 		get_device(dev);
 
 		mutex_unlock(&dpm_list_mtx);




