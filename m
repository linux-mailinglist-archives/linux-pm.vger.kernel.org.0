Return-Path: <linux-pm+bounces-24054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297AA61263
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F39882338
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9591FF1B3;
	Fri, 14 Mar 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="KaM7EbtN"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664933062;
	Fri, 14 Mar 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958295; cv=none; b=Qbg2M5y2nGDtZU7MgKBikro6AoZGZqqftK7ZPi2F9m/BCNBijI57x8b6REhx0O/uWYKz0iYf+jWmCMmJ56wYKC8Xe33umUKA23wG0oSpl3kvCoQrcWUkhLwdEIN6UhPZhZK6KuIh3AkPoblMZSHucTpXV+3xuA4N+Y7wNQFd1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958295; c=relaxed/simple;
	bh=blpXADKX8e7JmQIhOP9B/BojEHJX9bhu7Scx5IP2vT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEVeIYNNar9RnUgqU/yzEQeaApyhxZwMkSb2DWja4ENRp2Qj7ni8V7XhV1Zjt8eHEEHEOTj31QNuztvp7ZEDn97WUbTbv1KHvRSdrnMwLBZtYu6TlTfztNCR5iOD2ALulWTCOicgRvvU0Q8q6ieLneJgQsWrw4izyZyfNu3S2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=KaM7EbtN; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 7074daa21ebd8cc8; Fri, 14 Mar 2025 14:18:10 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id F2C72912CFA;
	Fri, 14 Mar 2025 14:18:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741958290;
	bh=blpXADKX8e7JmQIhOP9B/BojEHJX9bhu7Scx5IP2vT0=;
	h=From:Subject:Date;
	b=KaM7EbtNkeayM2Ox260zSpqSdOmFz+w/1v6yltjdsJE4ix9ruAWbcbD3b/0mCnWTz
	 v76Kj0XkfNCeYs3wvWpyKuXoISwmRFNmnm8rhpaOlJHnCZouDFGhGyAVZZ/NNzNgUE
	 pA4dNaU1CTl84kHaxV487WMV54TvBgXSeOkOEQSjJR1sqTw1RnvtBH/d4TzaayVSYp
	 2S09+TdkiGIboXHCYkF4W4ztGtYAfGk63bnpbGEYfzd2o8/Z7qvtS52PyGZ+8+jKSq
	 GZI/6odfCsyqd7nstoGl78Z6S0t73D95stERQe6YKtNeWOcgnDWxoj7MC18P1yJ+c7
	 hM0kIp78r5ryQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v3 5/5] PM: sleep: Make async resume handle consumers like children
Date: Fri, 14 Mar 2025 14:17:49 +0100
Message-ID: <2229735.Mh6RI2rZIc@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Following previous changes, avoid starting "async" resume processing
upfront for devices that have suppliers and start "async" resume
processing for the consumers of a device after resuming the device
itself.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v3.

---
 drivers/base/power/main.c |   33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -635,17 +635,25 @@
 	return 0;
 }
 
-static void dpm_async_resume_children(struct device *dev, async_func_t func)
+static void dpm_async_resume_subordinate(struct device *dev, async_func_t func)
 {
+	struct device_link *link;
+	int idx;
+
 	/*
 	 * Start processing "async" children of the device unless it's been
 	 * started already for them.
-	 *
-	 * This could have been done for the device's "async" consumers too, but
-	 * they either need to wait for their parents or the processing has
-	 * already started for them after their parents were processed.
 	 */
 	device_for_each_child(dev, func, dpm_async_with_cleanup);
+
+	idx = device_links_read_lock();
+
+	/* Start processing the device's "async" consumers. */
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+			dpm_async_with_cleanup(link->consumer, func);
+
+	device_links_read_unlock(idx);
 }
 
 static void dpm_clear_async_state(struct device *dev)
@@ -656,7 +664,14 @@
 
 static bool dpm_root_device(struct device *dev)
 {
-	return !dev->parent;
+	lockdep_assert_held(&dpm_list_mtx);
+
+	/*
+	 * Since this function is required to run under dpm_list_mtx, the
+	 * list_empty() below will only return true if the device's list of
+	 * consumers is actually empty before calling it.
+	 */
+	return !dev->parent && list_empty(&dev->links.suppliers);
 }
 
 static void async_resume_noirq(void *data, async_cookie_t cookie);
@@ -745,7 +760,7 @@
 		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
 	}
 
-	dpm_async_resume_children(dev, async_resume_noirq);
+	dpm_async_resume_subordinate(dev, async_resume_noirq);
 }
 
 static void async_resume_noirq(void *data, async_cookie_t cookie)
@@ -888,7 +903,7 @@
 		pm_dev_err(dev, state, async ? " async early" : " early", error);
 	}
 
-	dpm_async_resume_children(dev, async_resume_early);
+	dpm_async_resume_subordinate(dev, async_resume_early);
 }
 
 static void async_resume_early(void *data, async_cookie_t cookie)
@@ -1063,7 +1078,7 @@
 		pm_dev_err(dev, state, async ? " async" : "", error);
 	}
 
-	dpm_async_resume_children(dev, async_resume);
+	dpm_async_resume_subordinate(dev, async_resume);
 }
 
 static void async_resume(void *data, async_cookie_t cookie)




