Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6515D1F5BF8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 21:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgFJTcL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 15:32:11 -0400
Received: from smtp1.axis.com ([195.60.68.17]:63015 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgFJTcL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jun 2020 15:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=4186; q=dns/txt; s=axis-central1;
  t=1591817530; x=1623353530;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=na3oxLNBAfJxN2IG/XUgrgcU56V172StpBNFi4IaUzQ=;
  b=S5kr5LNPfZ88G1IpSxHKDq4kHLO4FcHUfZYJufXe/ZBShBYmatsfcSti
   UWAPj0M7BQ5ZpSSbRuWsok0kWPpgv/1CP+3xi52/I1PMiW6/LnG4EdWDD
   j62TWAdPf59lEmL2w2eVN9q5kg6jgSxgzEHWbgIJ+DqLQyMfByRDx8J3v
   YwRhwuWBmyGE0g89/XaI/ennW0QTCxw/aEF0QTQ03i2Gv1YqV3w58iXA0
   pEIUjJeUpN9yaM77n/kSiWJTnYsnEXs2j3q7O8LVOBKhAMZ7uPihfdLcN
   am96RQ7OroP+WDkk8pgdJ3HeOTLsTc0rv8hDHyprP7HqO/XyEeJfWBrDb
   w==;
IronPort-SDR: 3AgpzJfc9mPFQhHDceCUkkPx/EcsVcTKMSg9G1UA6zMouz/gUT29dtSxaD8nV858fNw9NNCuKw
 xy4PNg08K5K+/hqZTKVmMY6c6OQE8YZcfeC28AuRht8RQjLISxptPxYt/HtAgLDRvRmEu4hLBg
 OF3x/RTjGOM1xV262bl7YqHQKAQfCyMmbNaLCEE8bFYKjDxoz829ekKrktpB5ygmIe+VvutK3F
 mePQZ1rA2oLl1Y902vMyOLERkpTW0Mh/nvWzkPuvX4RUb0A4ZhiDO7QUsXKNc9sGkTUGNa7xsp
 kTs=
X-IronPort-AV: E=Sophos;i="5.73,497,1583190000"; 
   d="scan'208";a="9676981"
From:   Gustav Wiklander <gustav.wiklander@axis.com>
To:     <linux-pm@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <khilman@kernel.org>,
        <ulf.hansson@linaro.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <gregkh@linuxfoundation.org>, <kernel@axis.com>,
        Gustav Wiklander <gustavwi@axis.com>
Subject: [PATCHv2] PM / Domains: Add module ref count for each consumer
Date:   Wed, 10 Jun 2020 21:31:56 +0200
Message-ID: <20200610193156.20363-1-gustav.wiklander@axis.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gustav Wiklander <gustavwi@axis.com>

Currently a pm_domain can be unloaded without regard for consumers.
This patch adds a module dependecy for every registered consumer.
Now a power domain driver can only be unloaded if no consumers are
registered.

Signed-off-by: Gustav Wiklander <gustavwi@axis.com>
---
Automated setting genpd->owner when calling pm_genpd_init.
Similar to how usb_register_driver does it.

 drivers/base/power/domain.c | 22 +++++++++++++++++-----
 include/linux/pm_domain.h   | 10 ++++++++--
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0a01df608849..70c8b59bfed9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1499,11 +1499,18 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
+	if (!try_module_get(genpd->owner)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
 
 	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
-	if (ret)
+	if (ret) {
+		module_put(genpd->owner);
 		goto out;
+	}
 
 	genpd_lock(genpd);
 
@@ -1579,6 +1586,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
 	genpd_free_dev_data(dev, gpd_data);
 
+	module_put(genpd->owner);
+
 	return 0;
 
  out:
@@ -1755,15 +1764,17 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 }
 
 /**
- * pm_genpd_init - Initialize a generic I/O PM domain object.
+ * __pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
  * @gov: PM domain governor to associate with the domain (may be NULL).
  * @is_off: Initial value of the domain's power_is_off field.
+ * @owner: module owner of this power domain object.
  *
  * Returns 0 on successful initialization, else a negative error code.
  */
-int pm_genpd_init(struct generic_pm_domain *genpd,
-		  struct dev_power_governor *gov, bool is_off)
+int __pm_genpd_init(struct generic_pm_domain *genpd,
+		  struct dev_power_governor *gov, bool is_off,
+		  struct module *owner)
 {
 	int ret;
 
@@ -1777,6 +1788,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
+	genpd->owner = owner;
 	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
@@ -1831,7 +1843,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pm_genpd_init);
+EXPORT_SYMBOL_GPL(__pm_genpd_init);
 
 static int genpd_remove(struct generic_pm_domain *genpd)
 {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9ec78ee53652..21a3183e00bc 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -9,6 +9,7 @@
 #define _LINUX_PM_DOMAIN_H
 
 #include <linux/device.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/err.h>
@@ -93,6 +94,7 @@ struct opp_table;
 
 struct generic_pm_domain {
 	struct device dev;
+	struct module *owner;           /* Module owner of the PM domain */
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
 	struct list_head master_links;	/* Links with PM domain as a master */
@@ -200,8 +202,12 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 			   struct generic_pm_domain *subdomain);
 int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 			      struct generic_pm_domain *subdomain);
-int pm_genpd_init(struct generic_pm_domain *genpd,
-		  struct dev_power_governor *gov, bool is_off);
+int __pm_genpd_init(struct generic_pm_domain *genpd,
+		    struct dev_power_governor *gov, bool is_off,
+		    struct module *module);
+#define pm_genpd_init(genpd, gov, is_off) \
+	__pm_genpd_init(genpd, gov, is_off, THIS_MODULE)
+
 int pm_genpd_remove(struct generic_pm_domain *genpd);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 
-- 
2.11.0

