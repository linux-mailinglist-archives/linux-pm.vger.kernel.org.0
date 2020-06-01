Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E791E9E4F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 08:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgFAGdT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 02:33:19 -0400
Received: from cs-u-kase.cs.umn.edu ([160.94.64.2]:60808 "EHLO
        cs-u-kase.cs.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFAGdT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 02:33:19 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2020 02:33:18 EDT
Received: from cs-u-kase.cs.umn.edu (localhost [127.0.0.1])
        by cs-u-kase.cs.umn.edu (8.15.2/8.15.2/Debian-10) with ESMTP id 0516QP6u059197;
        Mon, 1 Jun 2020 01:26:25 -0500
Received: (from navid@localhost)
        by cs-u-kase.cs.umn.edu (8.15.2/8.15.2/Submit) id 0516QPRl059195;
        Mon, 1 Jun 2020 01:26:25 -0500
From:   Navid <navid.emamdoost@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu, Navid <navid.emamdoost@gmail.com>
Subject: [PATCH] power: supply: bq24190_charger.c: call pm_runtime_put in pm_runtime_get_sync failed case
Date:   Mon,  1 Jun 2020 01:25:54 -0500
Message-Id: <20200601062554.58737-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Even in failed case of pm_runtime_get_sync, the usage_count
is incremented. In order to keep the usage_count with correct
value call pm_runtime_put_autosuspend.

Signed-off-by: Navid <navid.emamdoost@gmail.com>
---
 drivers/power/supply/bq24190_charger.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 453d6332d43a..502ccdac2443 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -448,8 +448,10 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		count = ret;
+		goto out;
+	}
 
 	ret = bq24190_read_mask(bdi, info->reg, info->mask, info->shift, &v);
 	if (ret)
@@ -458,6 +460,7 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 		count = scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return count;
@@ -481,14 +484,17 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 		return ret;
 
 	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		count = ret;
+		goto out;
+	}
 
 	ret = bq24190_write_mask(bdi, info->reg, info->mask, info->shift, v);
 	if (ret)
 		count = ret;
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return count;
@@ -1076,7 +1082,7 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 
 	ret = pm_runtime_get_sync(bdi->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
@@ -1132,6 +1138,7 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -1148,7 +1155,7 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 
 	ret = pm_runtime_get_sync(bdi->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1174,6 +1181,7 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -1409,7 +1417,7 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 
 	ret = pm_runtime_get_sync(bdi->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -1438,6 +1446,7 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -1455,7 +1464,7 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 
 	ret = pm_runtime_get_sync(bdi->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1469,6 +1478,7 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
-- 
2.17.1

