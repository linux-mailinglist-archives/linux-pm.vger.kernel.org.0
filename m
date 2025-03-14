Return-Path: <linux-pm+bounces-24055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37A1A6126F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27601B62DA7
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9E11FF5E9;
	Fri, 14 Mar 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fCGRUF1r"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3B33062;
	Fri, 14 Mar 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958367; cv=none; b=GZkSQkip+FH5o0OTL0UfDth/aVUMKOJpxYAav9S/unSVM+5iVZ8vTfGN5JmHQj4F56lRXGMv1TFzsTz2EuEaa5j/QXbWnb9QHpRl3Wfi9F59ABa+UJssc8kRHq3EHLbUNiKt2Ijh5ZghaKUOWRXaL4L+8WIsFQC1cvq+aaj+pw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958367; c=relaxed/simple;
	bh=QmeYUs+yErlkIvOvXDo3UhtL+w7L7+0X2Hz8PQcj7Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQLD3Wbu0S0ekvIicrazKplMmByJGIqn4cRRrekIf0V6clXDxgdYkrVFbolIi2MNya+jD9Q2HRFTMOFQZi0Kjpo4/KrdB3oWvZgEYaycDISFWhqcJLT6FGrqNfiEP9uc8j87Bome0UrjI3I2jt6aWFG1+jzRTfZXwu3nGoHXW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fCGRUF1r; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 6c10fbdd4048e413; Fri, 14 Mar 2025 14:19:22 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 11B66912CFB;
	Fri, 14 Mar 2025 14:19:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741958362;
	bh=QmeYUs+yErlkIvOvXDo3UhtL+w7L7+0X2Hz8PQcj7Ak=;
	h=From:Subject:Date;
	b=fCGRUF1rQZGrG8nnY8L26mFuDsV767N9RBeDfEnDqHSFsiw3H6yd9pTwOiLbcjDU7
	 5tn1bjI484/5T2dInlx0Fl41aCk3cRaUlx41qxxB034f0/ytRASU9lkH0sxkb6Kk4P
	 hz1ks4jcq48vluuTzXIhKO7WO27vc/R9DHjXZ6IwP4hqICNViQaIr9/5GaNb6kwj9E
	 oMxbkMQ7EI3yzynRUbhQrqGje2Hu0y6t0DNWKtOvDmsOuCcnDy4FdTDa2CjHqwbyOj
	 LcTvQd8jno5UugUZDnl+QItZWRp4fnkuBo9hJZN15L0BW/wqAWxInqjx4apwsfPeeu
	 LTmJV/i8p2UXg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v3 4/5] PM: sleep: Make async suspend handle suppliers like parents
Date: Fri, 14 Mar 2025 14:16:33 +0100
Message-ID: <2651185.Lt9SDvczpP@rjwysocki.net>
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

Following previous changes, avoid starting "async" suspend processing
upfront for devices that have consumers and start "async" suspend
processing for the supplies of a device after suspending the device
itself.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v3.

---
 drivers/base/power/main.c |   37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1249,10 +1249,15 @@
 		return false;
 	}
 
-	return true;
+	/*
+	 * Since this function is required to run under dpm_list_mtx, the
+	 * list_empty() below will only return true if the device's list of
+	 * consumers is actually empty before calling it.
+	 */
+	return list_empty(&dev->links.consumers);
 }
 
-static void dpm_async_suspend_parent(struct device *dev, async_func_t func)
+static bool dpm_async_suspend_parent(struct device *dev, async_func_t func)
 {
 	guard(mutex)(&dpm_list_mtx);
 
@@ -1264,11 +1269,31 @@
 	 * deleted before it.
 	 */
 	if (!device_pm_initialized(dev))
-		return;
+		return false;
 
 	/* Start processing the device's parent if it is "async". */
 	if (dev->parent)
 		dpm_async_with_cleanup(dev->parent, func);
+
+	return true;
+}
+
+static void dpm_async_suspend_superior(struct device *dev, async_func_t func)
+{
+	struct device_link *link;
+	int idx;
+
+	if (!dpm_async_suspend_parent(dev, func))
+		return;
+
+	idx = device_links_read_lock();
+
+	/* Start processing the device's "async" suppliers. */
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+			dpm_async_with_cleanup(link->supplier, func);
+
+	device_links_read_unlock(idx);
 }
 
 /**
@@ -1392,7 +1417,7 @@
 	if (error || async_error)
 		return error;
 
-	dpm_async_suspend_parent(dev, async_suspend_noirq);
+	dpm_async_suspend_superior(dev, async_suspend_noirq);
 
 	return 0;
 }
@@ -1588,7 +1613,7 @@
 	if (error || async_error)
 		return error;
 
-	dpm_async_suspend_parent(dev, async_suspend_late);
+	dpm_async_suspend_superior(dev, async_suspend_late);
 
 	return 0;
 }
@@ -1879,7 +1904,7 @@
 	if (error || async_error)
 		return error;
 
-	dpm_async_suspend_parent(dev, async_suspend);
+	dpm_async_suspend_superior(dev, async_suspend);
 
 	return 0;
 }




