Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B02324364
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 18:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhBXRy2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 12:54:28 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52828 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBXRy1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 12:54:27 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 41ccb729f266e117; Wed, 24 Feb 2021 18:53:44 +0100
Received: from kreacher.localnet (89-64-80-80.dynamic.chello.pl [89.64.80.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 79D6666152E;
        Wed, 24 Feb 2021 18:53:43 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "elaine.zhang" <zhangqing@rock-chips.com>
Subject: [PATCH v1] PM: runtime: Update device status before letting suppliers suspend
Date:   Wed, 24 Feb 2021 18:53:42 +0100
Message-ID: <1930477.9OOUKYNkGr@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeiueevhfeigffhffevueekgedtleeitdfhffejleevtddvtdettedvfffffffhjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekledrieegrdektddrkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrdektddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopeiihhgrnhhgqhhinhhgsehrohgtkhdqtghhihhpshdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the PM-runtime status of the device is not updated in
__rpm_callback(), attempts to suspend the suppliers of the given
device triggered by rpm_put_suppliers() called by it may fail.

Fix this by making __rpm_callback() update the device's status to
RPM_SUSPENDED before calling rpm_put_suppliers() if the current
status of the device is RPM_SUSPENDING and the callback just invoked
by it has returned 0 (success).

While at it, modify the code in __rpm_callback() to always check
the device's PM-runtime status under its PM lock.

Link: https://lore.kernel.org/linux-pm/CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com/
Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
Reported-by: elaine.zhang <zhangqing@rock-chips.com>
Diagnosed-by: Ulf Hansson <ulf.hansson@linaro.org> 
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is different from the previously posted tentative patch, please retest.

---
 drivers/base/power/runtime.c |   61 +++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -325,22 +325,21 @@ static void rpm_put_suppliers(struct dev
 static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
-	int retval, idx;
 	bool use_links = dev->power.links_count > 0;
+	int retval, idx;
+	bool get, put;
 
 	if (dev->power.irq_safe) {
 		spin_unlock(&dev->power.lock);
+	} else if (!use_links) {
+		spin_unlock_irq(&dev->power.lock);
 	} else {
+		get = dev->power.runtime_status == RPM_RESUMING;
+
 		spin_unlock_irq(&dev->power.lock);
 
-		/*
-		 * Resume suppliers if necessary.
-		 *
-		 * The device's runtime PM status cannot change until this
-		 * routine returns, so it is safe to read the status outside of
-		 * the lock.
-		 */
-		if (use_links && dev->power.runtime_status == RPM_RESUMING) {
+		/* Resume suppliers if necessary. */
+		if (get) {
 			idx = device_links_read_lock();
 
 			retval = rpm_get_suppliers(dev);
@@ -355,24 +354,36 @@ static int __rpm_callback(int (*cb)(stru
 
 	if (dev->power.irq_safe) {
 		spin_lock(&dev->power.lock);
-	} else {
-		/*
-		 * If the device is suspending and the callback has returned
-		 * success, drop the usage counters of the suppliers that have
-		 * been reference counted on its resume.
-		 *
-		 * Do that if resume fails too.
-		 */
-		if (use_links
-		    && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
-		    || (dev->power.runtime_status == RPM_RESUMING && retval))) {
-			idx = device_links_read_lock();
+		return retval;
+	}
 
- fail:
-			rpm_put_suppliers(dev);
+	spin_lock_irq(&dev->power.lock);
 
-			device_links_read_unlock(idx);
-		}
+	if (!use_links)
+		return retval;
+
+	/*
+	 * If the device is suspending and the callback has returned success,
+	 * drop the usage counters of the suppliers that have been reference
+	 * counted on its resume.
+	 *
+	 * Do that if the resume fails too.
+	 */
+	put = dev->power.runtime_status == RPM_SUSPENDING && !retval;
+	if (put)
+		__update_runtime_status(dev, RPM_SUSPENDED);
+	else
+		put = get && retval;
+
+	if (put) {
+		spin_unlock_irq(&dev->power.lock);
+
+		idx = device_links_read_lock();
+
+fail:
+		rpm_put_suppliers(dev);
+
+		device_links_read_unlock(idx);
 
 		spin_lock_irq(&dev->power.lock);
 	}



