Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32677486B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfGYHrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 03:47:47 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:4099
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388187AbfGYHrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 03:47:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2C8BgA+XTld/1/rO8tcCoIZg3YSFxO?=
 =?us-ascii?q?NGYgXAYJDAYNZhVOJfoUggXsJAQEBAQEBAQEBGxwBAYQ6BIMBNgcOAQMBAQE?=
 =?us-ascii?q?EAQEBAQUBbYRlRYV4L3JwEoMigXcTrj4zhAYBhGyBSIE0hwmEboFAP4RhhBk?=
 =?us-ascii?q?PhX8ElBqBHZU1CYEld5QSGZgLLYszgViZVAcqgVhNHxmDJ4J5jVZENTCOSgE?=
 =?us-ascii?q?B?=
X-IPAS-Result: =?us-ascii?q?A2C8BgA+XTld/1/rO8tcCoIZg3YSFxONGYgXAYJDAYNZh?=
 =?us-ascii?q?VOJfoUggXsJAQEBAQEBAQEBGxwBAYQ6BIMBNgcOAQMBAQEEAQEBAQUBbYRlR?=
 =?us-ascii?q?YV4L3JwEoMigXcTrj4zhAYBhGyBSIE0hwmEboFAP4RhhBkPhX8ElBqBHZU1C?=
 =?us-ascii?q?YEld5QSGZgLLYszgViZVAcqgVhNHxmDJ4J5jVZENTCOSgEB?=
X-IronPort-AV: E=Sophos;i="5.64,306,1559491200"; 
   d="scan'208";a="228541455"
Received: from 203-59-235-95.perm.iinet.net.au (HELO rtcentos7.electromag.com.au) ([203.59.235.95])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 25 Jul 2019 15:47:42 +0800
From:   Richard Tresidder <rtresidd@electromag.com.au>
To:     sre@kernel.org, enric.balletbo@collabora.com, ncrews@chromium.org,
        andrew.smirnov@gmail.com, groeck@chromium.org,
        david@lechnology.com, rtresidd@electromag.com.au,
        tglx@linutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] power/supply/powersupply_sysfs: Add of_node name to uevent message if available
Date:   Thu, 25 Jul 2019 15:47:38 +0800
Message-Id: <1564040858-24202-1-git-send-email-rtresidd@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the of_node name of the supply is available from the devicetree binding
then include it under the var POWER_SUPPLY_OF_NODE_NAME.
This helps where a consistent name is known via the device tree binding
but it is hard to identify based on the usual enumeration process.

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
---

Notes:
    power/supply/powersupply_sysfs: Add of_node name to uevent message if available
    
    If the of_node name of the supply is available from the devicetree binding
    then include it under the var POWER_SUPPLY_OF_NODE_NAME.
    This helps where a consistent name is known via the device tree binding
    but it is hard to identify based on the usual enumeration process.

 drivers/power/supply/power_supply_sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f37ad4e..ce6671c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -395,6 +395,13 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (ret)
 		return ret;
 
+	if (psy->of_node) {
+		ret = add_uevent_var(env, "POWER_SUPPLY_OF_NODE_NAME=%s",
+				     psy->of_node->name);
+		if (ret)
+			return ret;
+	}
+
 	prop_buf = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!prop_buf)
 		return -ENOMEM;
-- 
1.8.3.1

