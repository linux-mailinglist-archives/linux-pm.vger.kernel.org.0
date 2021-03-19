Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE65134201F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCSOsq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 10:48:46 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47194 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhCSOsW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 10:48:22 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id e69104418b086582; Fri, 19 Mar 2021 15:48:20 +0100
Received: from kreacher.localnet (89-64-81-50.dynamic.chello.pl [89.64.81.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E1BC0667D8E;
        Fri, 19 Mar 2021 15:48:19 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "elaine.zhang" <zhangqing@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/2] PM: runtime: Defer suspending suppliers
Date:   Fri, 19 Mar 2021 15:47:31 +0100
Message-ID: <2773244.e9J7NaK4W3@kreacher>
In-Reply-To: <4641414.31r3eYUQgx@kreacher>
References: <5448054.DvuYhMxLoT@kreacher> <4641414.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefkedgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgefgleetgeduheeugeeikeevudelueelvdeufeejfeffgeefjedugfetfeehhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekledrieegrdekuddrhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdehtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeiihhgrnhhgqhhinhhgsehrohgtkhdqtghhihhpshdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the PM-runtime status of the device is not updated in
__rpm_callback(), attempts to suspend the suppliers of the given
device triggered by the rpm_put_suppliers() call in there may
cause a supplier to be suspended completely before the status of
the consumer is updated to RPM_SUSPENDED, which is confusing.

To avoid that (1) modify __rpm_callback() to only decrease the
PM-runtime usage counter of each supplier and (2) make rpm_suspend()
try to suspend the suppliers after changing the consumer's status to
RPM_SUSPENDED, in analogy with the device's parent.

Link: https://lore.kernel.org/linux-pm/CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com/
Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
Reported-by: elaine.zhang <zhangqing@rock-chips.com>
Diagnosed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Change a function name as requested by Ulf.
   * Add the R-by tag from Ulf.
   * Use spin_unlock_irq()/spin_lock_irq() around the rpm_suspend_suppliers()
     call in rpm_suspend().

---
 drivers/base/power/runtime.c |   45 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -305,7 +305,7 @@ static int rpm_get_suppliers(struct devi
 	return 0;
 }
 
-static void rpm_put_suppliers(struct device *dev)
+static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
 {
 	struct device_link *link;
 
@@ -313,10 +313,30 @@ static void rpm_put_suppliers(struct dev
 				device_links_read_lock_held()) {
 
 		while (refcount_dec_not_one(&link->rpm_active))
-			pm_runtime_put(link->supplier);
+			pm_runtime_put_noidle(link->supplier);
+
+		if (try_to_suspend)
+			pm_request_idle(link->supplier);
 	}
 }
 
+static void rpm_put_suppliers(struct device *dev)
+{
+	__rpm_put_suppliers(dev, true);
+}
+
+static void rpm_suspend_suppliers(struct device *dev)
+{
+	struct device_link *link;
+	int idx = device_links_read_lock();
+
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
+		pm_request_idle(link->supplier);
+
+	device_links_read_unlock(idx);
+}
+
 /**
  * __rpm_callback - Run a given runtime PM callback for a given device.
  * @cb: Runtime PM callback to run.
@@ -344,8 +364,10 @@ static int __rpm_callback(int (*cb)(stru
 			idx = device_links_read_lock();
 
 			retval = rpm_get_suppliers(dev);
-			if (retval)
+			if (retval) {
+				rpm_put_suppliers(dev);
 				goto fail;
+			}
 
 			device_links_read_unlock(idx);
 		}
@@ -368,9 +390,9 @@ static int __rpm_callback(int (*cb)(stru
 		    || (dev->power.runtime_status == RPM_RESUMING && retval))) {
 			idx = device_links_read_lock();
 
- fail:
-			rpm_put_suppliers(dev);
+			__rpm_put_suppliers(dev, false);
 
+fail:
 			device_links_read_unlock(idx);
 		}
 
@@ -642,8 +664,11 @@ static int rpm_suspend(struct device *de
 		goto out;
 	}
 
+	if (dev->power.irq_safe)
+		goto out;
+
 	/* Maybe the parent is now able to suspend. */
-	if (parent && !parent->power.ignore_children && !dev->power.irq_safe) {
+	if (parent && !parent->power.ignore_children) {
 		spin_unlock(&dev->power.lock);
 
 		spin_lock(&parent->power.lock);
@@ -652,6 +677,14 @@ static int rpm_suspend(struct device *de
 
 		spin_lock(&dev->power.lock);
 	}
+	/* Maybe the suppliers are now able to suspend. */
+	if (dev->power.links_count > 0) {
+		spin_unlock_irq(&dev->power.lock);
+
+		rpm_suspend_suppliers(dev);
+
+		spin_lock_irq(&dev->power.lock);
+	}
 
  out:
 	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);



