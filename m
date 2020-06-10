Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F811F56E7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 16:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgFJOjy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 10:39:54 -0400
Received: from smtp1.axis.com ([195.60.68.17]:53322 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgFJOjx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jun 2020 10:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1996; q=dns/txt; s=axis-central1;
  t=1591799993; x=1623335993;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=f9LZRbq2gqRPTsVfTL7+SZEhrzzg5RLrAM5dHzD/5ZM=;
  b=Jrxs9pdqpfOdH9pwx39FJiqRgunPVWkmeGAigoTdTwGru1ppKjtjy/Nc
   27/qUV0Y5l1xzOS06nVSkNPajE2Y46g9hVrhmk06d7ljioaMko10fhWmo
   jexTMpgerh1cT+LvCRhdHbcCER1iIetTQOjs7zJfhMNphxG3/MqhCxteQ
   xZrs6rrTta/sxORNsdjRW5V4t/qyFACiCKNl3GuuhnU/MCDQkLhpAagXe
   Vfx9WNGTCyV1XvfqKFq4KEnXOV95gTztYmgrVVcQzXXbW0YY2x5n9DfNY
   ko5WfgIS8WmUfkO3tupVti5UBBq4w2Xb+rNfHSJxmBjGeAOrZxfcB0eDM
   A==;
IronPort-SDR: 0I1IasE6onjJfpU0QrIldCWQhC4jN2MveENewo1bo56iXhWsU/JyVfdRxK0fUeJk7RkWmWUPeW
 pUIvHTQgSdO5sk2OeoVazLOuj1KX7oT+KCaReLCd+u+5qybE0S1tJ667NIxksOmQXkTZoX/jSy
 THpt9IJfZ9NmfBDHRq66osGsbcC/DKqdSKMJkUr+WRIdV47A4jhxT0pHo43T/nR4tiJcVB+lAH
 Q5ul+yw9jzyFFrcNpfjj5GOFhgbzU2K41K1yrdl96oBNe1PmsJh3GyC7ICFOeoNREqFxbiX5Pv
 WxM=
X-IronPort-AV: E=Sophos;i="5.73,496,1583190000"; 
   d="scan'208";a="9667423"
From:   Gustav Wiklander <gustav.wiklander@axis.com>
To:     <linux-pm@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <khilman@kernel.org>,
        <ulf.hansson@linaro.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <gregkh@linuxfoundation.org>, <kernel@axis.com>,
        Gustav Wiklander <gustavwi@axis.com>
Subject: [PATCH] PM / Domains: Add module ref count for each consumer
Date:   Wed, 10 Jun 2020 16:39:43 +0200
Message-ID: <20200610143943.12548-1-gustav.wiklander@axis.com>
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
 drivers/base/power/domain.c | 11 ++++++++++-
 include/linux/pm_domain.h   |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0a01df608849..80723f6d5e6b 100644
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
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9ec78ee53652..777c1b30e5af 100644
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
+	struct module *owner;		/* Module owner of the PM domain */
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
 	struct list_head master_links;	/* Links with PM domain as a master */
-- 
2.11.0

