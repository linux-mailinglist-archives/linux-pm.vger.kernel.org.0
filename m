Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B06C1A6C1E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbgDMSjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729321AbgDMSi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 14:38:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A83C008748;
        Mon, 13 Apr 2020 11:38:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E9CFC2A12CA
Received: by jupiter.universe (Postfix, from userid 1000)
        id 51CA24800F9; Mon, 13 Apr 2020 20:38:55 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 2/4] power: supply: charger-manager: Prepare for const properties
Date:   Mon, 13 Apr 2020 20:38:51 +0200
Message-Id: <20200413183853.1088823-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
References: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This prepares the driver to work with the properties entry
in power_supply_desc marked as const.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/charger-manager.c | 40 ++++++++++++++------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a21e1a2673f8..a71e2ee81423 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1422,7 +1422,9 @@ static int charger_manager_prepare_sysfs(struct charger_manager *cm)
 }
 
 static int cm_init_thermal_data(struct charger_manager *cm,
-		struct power_supply *fuel_gauge)
+		struct power_supply *fuel_gauge,
+		enum power_supply_property *properties,
+		size_t *num_properties)
 {
 	struct charger_desc *desc = cm->desc;
 	union power_supply_propval val;
@@ -1433,9 +1435,8 @@ static int cm_init_thermal_data(struct charger_manager *cm,
 					POWER_SUPPLY_PROP_TEMP, &val);
 
 	if (!ret) {
-		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
-				POWER_SUPPLY_PROP_TEMP;
-		cm->charger_psy_desc.num_properties++;
+		properties[*num_properties] = POWER_SUPPLY_PROP_TEMP;
+		(*num_properties)++;
 		cm->desc->measure_battery_temp = true;
 	}
 #ifdef CONFIG_THERMAL
@@ -1446,9 +1447,8 @@ static int cm_init_thermal_data(struct charger_manager *cm,
 			return PTR_ERR(cm->tzd_batt);
 
 		/* Use external thermometer */
-		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
-				POWER_SUPPLY_PROP_TEMP_AMBIENT;
-		cm->charger_psy_desc.num_properties++;
+		properties[*num_properties] = POWER_SUPPLY_PROP_TEMP_AMBIENT;
+		(*num_properties)++;
 		cm->desc->measure_battery_temp = true;
 		ret = 0;
 	}
@@ -1621,6 +1621,8 @@ static int charger_manager_probe(struct platform_device *pdev)
 	int j = 0;
 	union power_supply_propval val;
 	struct power_supply *fuel_gauge;
+	enum power_supply_property *properties;
+	size_t num_properties;
 	struct power_supply_config psy_cfg = {};
 
 	if (IS_ERR(desc)) {
@@ -1717,18 +1719,17 @@ static int charger_manager_probe(struct platform_device *pdev)
 	cm->charger_psy_desc.name = cm->psy_name_buf;
 
 	/* Allocate for psy properties because they may vary */
-	cm->charger_psy_desc.properties =
-		devm_kcalloc(&pdev->dev,
+	properties = devm_kcalloc(&pdev->dev,
 			     ARRAY_SIZE(default_charger_props) +
 				NUM_CHARGER_PSY_OPTIONAL,
-			     sizeof(enum power_supply_property), GFP_KERNEL);
-	if (!cm->charger_psy_desc.properties)
+			     sizeof(*properties), GFP_KERNEL);
+	if (!properties)
 		return -ENOMEM;
 
-	memcpy(cm->charger_psy_desc.properties, default_charger_props,
+	memcpy(properties, default_charger_props,
 		sizeof(enum power_supply_property) *
 		ARRAY_SIZE(default_charger_props));
-	cm->charger_psy_desc.num_properties = psy_default.num_properties;
+	num_properties = psy_default.num_properties;
 
 	/* Find which optional psy-properties are available */
 	fuel_gauge = power_supply_get_by_name(desc->psy_fuel_gauge);
@@ -1739,25 +1740,28 @@ static int charger_manager_probe(struct platform_device *pdev)
 	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
-		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
+		properties[cm->charger_psy_desc.num_properties] =
 				POWER_SUPPLY_PROP_CHARGE_NOW;
-		cm->charger_psy_desc.num_properties++;
+		num_properties++;
 	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CURRENT_NOW,
 					  &val)) {
-		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
+		properties[cm->charger_psy_desc.num_properties] =
 				POWER_SUPPLY_PROP_CURRENT_NOW;
-		cm->charger_psy_desc.num_properties++;
+		num_properties++;
 	}
 
-	ret = cm_init_thermal_data(cm, fuel_gauge);
+	ret = cm_init_thermal_data(cm, fuel_gauge, properties, &num_properties);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize thermal data\n");
 		cm->desc->measure_battery_temp = false;
 	}
 	power_supply_put(fuel_gauge);
 
+	cm->charger_psy_desc.properties = properties;
+	cm->charger_psy_desc.num_properties = num_properties;
+
 	INIT_DELAYED_WORK(&cm->fullbatt_vchk_work, fullbatt_vchk);
 
 	/* Register sysfs entry for charger(regulator) */
-- 
2.25.1

