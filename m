Return-Path: <linux-pm+bounces-22902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B814A44710
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56330866D71
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010D19CD17;
	Tue, 25 Feb 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="tthz19Uu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17719AA63;
	Tue, 25 Feb 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501987; cv=none; b=B5oy5/ECYYoStzc1lCbI1iR6xI0WnBFCHnwzEzlaV+dxSwikN7/E3sBrAYtGtlXGzmk0ZmOc+34L5dOTuXy/u+2pnMMkqSKcDj1HOuZJGaEeebhdWcgGJtIXNlKbv5TXN9WujJeKf7QY5YMhc7bI+hp8noIWFCNJLne3MfRa3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501987; c=relaxed/simple;
	bh=TXX6+lyM02BQDjNAokzwdr/qxJ0m9P3ixaNYCT5hmQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgV8spRgxqclbYIL4vY8PIQds3L2kh88f+fUfzwFenhFZL0yFcU+8gm8tBTd5eElWyq7d1f9GP0Ot/RZfgkMs+fgsZnXUuJhSlxmrijz51l6khsTJYKFcjrnNASKg85BzygpgtSl0S9FXm1Db9+nqoJFSJXdx1pcIBoPM7OWKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=tthz19Uu; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 364f8efee1ad67b9; Tue, 25 Feb 2025 17:46:18 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BA2D722C28BF;
	Tue, 25 Feb 2025 17:46:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740501978;
	bh=TXX6+lyM02BQDjNAokzwdr/qxJ0m9P3ixaNYCT5hmQA=;
	h=From:Subject:Date;
	b=tthz19Uu3ngB+djs8zWyZyTs8TTaqsMV753Tlmrb84pB17EjXvf0p2e8VafnaX1I7
	 bxEbE1QPN8H2X/W7AFzN+hAGQYSfqJT7ltdIsnkzbBD21jit+qfMWNZl1v/BX93Zjt
	 4j4GUsxADbRLLgDkTqmWI0kZAPZMEXcV0jbKvc22DumA//DXK77MXnXNDsWbXgWl/j
	 CvRU/VJcicNHnq8rAy143eYQsCSptwibre8bjPsQ1SR57bIJnFQr8do8jdpj9gG6C0
	 Ea+w82HsHoum4ccm/Wv/S5ACD3ZoDolzY0Qp+ter/rAFythszANnhxwc862PQx+7vM
	 pVY07i3tSdNqA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v1 2/5] PM: sleep: Rearrange dpm_async_fn() and async state clearing
Date: Tue, 25 Feb 2025 17:39:40 +0100
Message-ID: <8494650.T7Z3S40VBb@rjwysocki.net>
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

In preparation for subsequent changes, move the power.completion
reinitialization along with clearing power.work_in_progress into a
separate function called dpm_clear_async_state() and rearrange
dpm_async_fn() to get rid of unnecessary indentation.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -599,27 +599,34 @@
 
 static bool dpm_async_fn(struct device *dev, async_func_t func)
 {
-	reinit_completion(&dev->power.completion);
+	if (!is_async(dev))
+		return false;
 
-	if (is_async(dev)) {
-		dev->power.work_in_progress = true;
+	dev->power.work_in_progress = true;
 
-		get_device(dev);
+	get_device(dev);
 
-		if (async_schedule_dev_nocall(func, dev))
-			return true;
+	if (async_schedule_dev_nocall(func, dev))
+		return true;
+
+	put_device(dev);
 
-		put_device(dev);
-	}
 	/*
-	 * Because async_schedule_dev_nocall() above has returned false or it
-	 * has not been called at all, func() is not running and it is safe to
-	 * update the work_in_progress flag without extra synchronization.
+	 * async_schedule_dev_nocall() above has returned false, so func() is
+	 * not running and it is safe to update power.work_in_progress without
+	 * extra synchronization.
 	 */
 	dev->power.work_in_progress = false;
+
 	return false;
 }
 
+static void dpm_clear_async_state(struct device *dev)
+{
+	reinit_completion(&dev->power.completion);
+	dev->power.work_in_progress = false;
+}
+
 /**
  * device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
@@ -729,8 +736,10 @@
 	 * Trigger the resume of "async" devices upfront so they don't have to
 	 * wait for the "non-async" ones they don't depend on.
 	 */
-	list_for_each_entry(dev, &dpm_noirq_list, power.entry)
+	list_for_each_entry(dev, &dpm_noirq_list, power.entry) {
+		dpm_clear_async_state(dev);
 		dpm_async_fn(dev, async_resume_noirq);
+	}
 
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
@@ -869,8 +878,10 @@
 	 * Trigger the resume of "async" devices upfront so they don't have to
 	 * wait for the "non-async" ones they don't depend on.
 	 */
-	list_for_each_entry(dev, &dpm_late_early_list, power.entry)
+	list_for_each_entry(dev, &dpm_late_early_list, power.entry) {
+		dpm_clear_async_state(dev);
 		dpm_async_fn(dev, async_resume_early);
+	}
 
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
@@ -1035,8 +1046,10 @@
 	 * Trigger the resume of "async" devices upfront so they don't have to
 	 * wait for the "non-async" ones they don't depend on.
 	 */
-	list_for_each_entry(dev, &dpm_suspended_list, power.entry)
+	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
+		dpm_clear_async_state(dev);
 		dpm_async_fn(dev, async_resume);
+	}
 
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
@@ -1314,6 +1327,7 @@
 
 		list_move(&dev->power.entry, &dpm_noirq_list);
 
+		dpm_clear_async_state(dev);
 		if (dpm_async_fn(dev, async_suspend_noirq))
 			continue;
 
@@ -1491,6 +1505,7 @@
 
 		list_move(&dev->power.entry, &dpm_late_early_list);
 
+		dpm_clear_async_state(dev);
 		if (dpm_async_fn(dev, async_suspend_late))
 			continue;
 
@@ -1758,6 +1773,7 @@
 
 		list_move(&dev->power.entry, &dpm_suspended_list);
 
+		dpm_clear_async_state(dev);
 		if (dpm_async_fn(dev, async_suspend))
 			continue;
 




