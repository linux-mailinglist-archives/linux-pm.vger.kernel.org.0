Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B5319DF2E
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgDCUUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:20:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:1086 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgDCUUf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 16:20:35 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vBBl1nhTzpX;
        Fri,  3 Apr 2020 22:20:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585945231; bh=Uo9Dg3wLKTkFKZCWLFRcaiKTWxbVtqoScgjUwEkb2W8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=nxz83yBUg1uqm/R9KaMLxkSsgsiD0pHoYlrtlPa7cN6e7iUsNhapQ5kn5tAD+fLJs
         kliv3pYb58PuQP2Mw/8oni4J8ad0OjktVOaLT9aZQcYT0YGamLmJPWerSurv3fhQJ2
         H7pXlkfdllJfgRo6l0Bom9ecUpJxpbytsMhVpMaTfOhN+gu86y5C2kpqOOtZala9XU
         elFyWZ8UDBeIM+Lupvlz57izjhrf7/1mcyz822YKcv+BfTIXZnKywOs60/ozMGyyVv
         CwrtXu7Wwv3WlSOApWLPS9yyyERhoC7xE8nndeYw8G1zwNEX5smbg/TUvFbDFZoxxm
         WMSVUKcSgptBg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 22:20:31 +0200
Message-Id: <a529e64edb81a4795fe0b6480f1e4051bed1b099.1585944770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 02/11] power: charger-manager: don't write through
 desc->properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

psy_desc->properties will become pointer to const.  Avoid writing
through the pointer to enable constification of the tables elsewhere.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v3: initial version
---
 drivers/power/supply/charger-manager.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 887f5bb879e5..7ecb82107efb 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1425,15 +1425,18 @@ static int cm_init_thermal_data(struct charger_manager *cm,
 		struct power_supply *fuel_gauge)
 {
 	struct charger_desc *desc = cm->desc;
+	enum power_supply_property *props;
 	union power_supply_propval val;
 	int ret;
 
+	props = (void *)cm->charger_psy_desc.properties;
+
 	/* Verify whether fuel gauge provides battery temperature */
 	ret = power_supply_get_property(fuel_gauge,
 					POWER_SUPPLY_PROP_TEMP, &val);
 
 	if (!ret) {
-		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
+		props[cm->charger_psy_desc.num_properties] =
 				POWER_SUPPLY_PROP_TEMP;
 		cm->charger_psy_desc.num_properties++;
 		cm->desc->measure_battery_temp = true;
@@ -1446,7 +1449,7 @@ static int cm_init_thermal_data(struct charger_manager *cm,
 			return PTR_ERR(cm->tzd_batt);
 
 		/* Use external thermometer */
-		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
+		props[cm->charger_psy_desc.num_properties] =
 				POWER_SUPPLY_PROP_TEMP_AMBIENT;
 		cm->charger_psy_desc.num_properties++;
 		cm->desc->measure_battery_temp = true;
@@ -1622,6 +1625,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	union power_supply_propval val;
 	struct power_supply *fuel_gauge;
 	struct power_supply_config psy_cfg = {};
+	enum power_supply_property *props;
 
 	if (IS_ERR(desc)) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
@@ -1717,7 +1721,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	cm->charger_psy_desc.name = cm->psy_name_buf;
 
 	/* Allocate for psy properties because they may vary */
-	cm->charger_psy_desc.properties =
+	cm->charger_psy_desc.properties = props =
 		devm_kcalloc(&pdev->dev,
 			     ARRAY_SIZE(default_charger_props) +
 				NUM_CHARGER_PSY_OPTIONAL,
@@ -1725,7 +1729,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	if (!cm->charger_psy_desc.properties)
 		return -ENOMEM;
 
-	memcpy(cm->charger_psy_desc.properties, default_charger_props,
+	memcpy(props, default_charger_props,
 		sizeof(enum power_supply_property) *
 		ARRAY_SIZE(default_charger_props));
 
@@ -1738,14 +1742,14 @@ static int charger_manager_probe(struct platform_device *pdev)
 	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
-		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
+		props[cm->charger_psy_desc.num_properties] =
 				POWER_SUPPLY_PROP_CHARGE_NOW;
 		cm->charger_psy_desc.num_properties++;
 	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CURRENT_NOW,
 					  &val)) {
-		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
+		props[cm->charger_psy_desc.num_properties] =
 				POWER_SUPPLY_PROP_CURRENT_NOW;
 		cm->charger_psy_desc.num_properties++;
 	}
-- 
2.20.1

