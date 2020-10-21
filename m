Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E782952D1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 21:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504802AbgJUTOf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 15:14:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50086 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409606AbgJUTOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 15:14:34 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 4e9c949d8a5aba96; Wed, 21 Oct 2020 21:14:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Saravana Kannan <saravanak@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH 2/3] PM: runtime: Drop pm_runtime_clean_up_links()
Date:   Wed, 21 Oct 2020 21:13:10 +0200
Message-ID: <1930592.Uf7JNTNZRN@kreacher>
In-Reply-To: <6543936.FbWAdBN1tG@kreacher>
References: <6543936.FbWAdBN1tG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit d12544fb2aa9 ("PM: runtime: Remove link state checks in
rpm_get/put_supplier()") nothing prevents the consumer device's
runtime PM from acquiring additional references to the supplier
device after pm_runtime_clean_up_links() has run (or even while it
is running), so calling this function from __device_release_driver()
may be pointless (or even harmful).

Moreover, it ignores stateless device links, so the runtime PM
handling of managed and stateless device links is inconsistent
because of it, so better get rid of it entirely.

Fixes: d12544fb2aa9 ("PM: runtime: Remove link state checks in rpm_get/put_supplier()")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 5.1+ <stable@vger.kernel.org> # 5.1+
---
 drivers/base/dd.c            |    1 -
 drivers/base/power/runtime.c |   36 ------------------------------------
 include/linux/pm_runtime.h   |    2 --
 3 files changed, 39 deletions(-)

Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -1133,7 +1133,6 @@ static void __device_release_driver(stru
 		}
 
 		pm_runtime_get_sync(dev);
-		pm_runtime_clean_up_links(dev);
 
 		driver_sysfs_remove(dev);
 
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1643,42 +1643,6 @@ void pm_runtime_remove(struct device *de
 }
 
 /**
- * pm_runtime_clean_up_links - Prepare links to consumers for driver removal.
- * @dev: Device whose driver is going to be removed.
- *
- * Check links from this device to any consumers and if any of them have active
- * runtime PM references to the device, drop the usage counter of the device
- * (as many times as needed).
- *
- * Links with the DL_FLAG_MANAGED flag unset are ignored.
- *
- * Since the device is guaranteed to be runtime-active at the point this is
- * called, nothing else needs to be done here.
- *
- * Moreover, this is called after device_links_busy() has returned 'false', so
- * the status of each link is guaranteed to be DL_STATE_SUPPLIER_UNBIND and
- * therefore rpm_active can't be manipulated concurrently.
- */
-void pm_runtime_clean_up_links(struct device *dev)
-{
-	struct device_link *link;
-	int idx;
-
-	idx = device_links_read_lock();
-
-	list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
-				device_links_read_lock_held()) {
-		if (!(link->flags & DL_FLAG_MANAGED))
-			continue;
-
-		while (refcount_dec_not_one(&link->rpm_active))
-			pm_runtime_put_noidle(dev);
-	}
-
-	device_links_read_unlock(idx);
-}
-
-/**
  * pm_runtime_get_suppliers - Resume and reference-count supplier devices.
  * @dev: Consumer device.
  */
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -54,7 +54,6 @@ extern u64 pm_runtime_autosuspend_expira
 extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
-extern void pm_runtime_clean_up_links(struct device *dev);
 extern void pm_runtime_get_suppliers(struct device *dev);
 extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
@@ -276,7 +275,6 @@ static inline u64 pm_runtime_autosuspend
 				struct device *dev) { return 0; }
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
-static inline void pm_runtime_clean_up_links(struct device *dev) {}
 static inline void pm_runtime_get_suppliers(struct device *dev) {}
 static inline void pm_runtime_put_suppliers(struct device *dev) {}
 static inline void pm_runtime_new_link(struct device *dev) {}



