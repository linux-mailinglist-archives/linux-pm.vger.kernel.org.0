Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3232952CD
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409606AbgJUTOi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 15:14:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63870 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504797AbgJUTOg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 15:14:36 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 030494657aca0941; Wed, 21 Oct 2020 21:14:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Saravana Kannan <saravanak@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH 1/3] PM: runtime: Drop runtime PM references to supplier on link removal
Date:   Wed, 21 Oct 2020 21:12:15 +0200
Message-ID: <1682736.0MbBAd5gSP@kreacher>
In-Reply-To: <6543936.FbWAdBN1tG@kreacher>
References: <6543936.FbWAdBN1tG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

While removing a device link, drop the supplier device's runtime PM
usage counter as many times as needed to drop all of the runtime PM
references to it from the consumer in addition to dropping the
consumer's link count.

Fixes: baa8809f6097 ("PM / runtime: Optimize the use of device links")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 5.1+ <stable@vger.kernel.org> # 5.1+
---
 drivers/base/core.c          |    6 ++----
 drivers/base/power/runtime.c |   21 ++++++++++++++++++++-
 include/linux/pm_runtime.h   |    4 ++--
 3 files changed, 24 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1729,7 +1729,7 @@ void pm_runtime_new_link(struct device *
 	spin_unlock_irq(&dev->power.lock);
 }
 
-void pm_runtime_drop_link(struct device *dev)
+static void pm_runtime_drop_link_count(struct device *dev)
 {
 	spin_lock_irq(&dev->power.lock);
 	WARN_ON(dev->power.links_count == 0);
@@ -1737,6 +1737,25 @@ void pm_runtime_drop_link(struct device
 	spin_unlock_irq(&dev->power.lock);
 }
 
+/**
+ * pm_runtime_drop_link - Prepare for device link removal.
+ * @link: Device link going away.
+ *
+ * Drop the link count of the consumer end of @link and decrement the supplier
+ * device's runtime PM usage counter as many times as needed to drop all of the
+ * PM runtime reference to it from the consumer.
+ */
+void pm_runtime_drop_link(struct device_link *link)
+{
+	if (!(link->flags & DL_FLAG_PM_RUNTIME))
+		return;
+
+	pm_runtime_drop_link_count(link->consumer);
+
+	while (refcount_dec_not_one(&link->rpm_active))
+		pm_runtime_put(link->supplier);
+}
+
 static bool pm_runtime_need_not_resume(struct device *dev)
 {
 	return atomic_read(&dev->power.usage_count) <= 1 &&
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -58,7 +58,7 @@ extern void pm_runtime_clean_up_links(st
 extern void pm_runtime_get_suppliers(struct device *dev);
 extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
-extern void pm_runtime_drop_link(struct device *dev);
+extern void pm_runtime_drop_link(struct device_link *link);
 
 /**
  * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
@@ -280,7 +280,7 @@ static inline void pm_runtime_clean_up_l
 static inline void pm_runtime_get_suppliers(struct device *dev) {}
 static inline void pm_runtime_put_suppliers(struct device *dev) {}
 static inline void pm_runtime_new_link(struct device *dev) {}
-static inline void pm_runtime_drop_link(struct device *dev) {}
+static inline void pm_runtime_drop_link(struct device_link *link) {}
 
 #endif /* !CONFIG_PM */
 
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -763,8 +763,7 @@ static void __device_link_del(struct kre
 	dev_dbg(link->consumer, "Dropping the link to %s\n",
 		dev_name(link->supplier));
 
-	if (link->flags & DL_FLAG_PM_RUNTIME)
-		pm_runtime_drop_link(link->consumer);
+	pm_runtime_drop_link(link);
 
 	list_del_rcu(&link->s_node);
 	list_del_rcu(&link->c_node);
@@ -778,8 +777,7 @@ static void __device_link_del(struct kre
 	dev_info(link->consumer, "Dropping the link to %s\n",
 		 dev_name(link->supplier));
 
-	if (link->flags & DL_FLAG_PM_RUNTIME)
-		pm_runtime_drop_link(link->consumer);
+	pm_runtime_drop_link(link);
 
 	list_del(&link->s_node);
 	list_del(&link->c_node);



