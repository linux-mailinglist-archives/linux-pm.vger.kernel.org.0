Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E92315A45
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 00:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhBIXue (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 18:50:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59020 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhBIXI6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 18:08:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 119N5jkk085795;
        Tue, 9 Feb 2021 17:05:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612911945;
        bh=qU877wM+24hVWpXuypQ2pX4RaadwVT/D3XrUZ7E+Jqw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Jyc0tZC8sStoITibAXiVSZ4wIwD10etZz8fPb74lNT7pQ9ioBB7xrxbxtsGD+CqHT
         oX2JrcYnyWsZbWflU+oj3TCv3G31F55q40iHCsBh5kpE0pc6qIOL4jI6kinAGzJrCN
         nOmsCszFIgxx/Xf8kmuV7YMNy8pDHSxzZ1ttCDhc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 119N5jTB050120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 17:05:45 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Feb
 2021 17:05:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Feb 2021 17:05:44 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 119N5iDT072550;
        Tue, 9 Feb 2021 17:05:44 -0600
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH 2/2] power: supply: bq25980: Moves properties from battery node 
Date:   Tue, 9 Feb 2021 17:05:27 -0600
Message-ID: <20210209230527.26712-2-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209230527.26712-1-r-rivera-matos@ti.com>
References: <20210209230527.26712-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

fix: exposes POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT on the

charger node

fix: exposes POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE on the

charger node

fix: eliminates unnecessary set_property for the battery node

Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
---
 drivers/power/supply/bq25980_charger.c | 40 ++++++++------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 7c489a9e8877..ac73e2c19238 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -641,33 +641,6 @@ static int bq25980_get_state(struct bq25980_device *bq,
 	return 0;
 }
 
-static int bq25980_set_battery_property(struct power_supply *psy,
-				enum power_supply_property psp,
-				const union power_supply_propval *val)
-{
-	struct bq25980_device *bq = power_supply_get_drvdata(psy);
-	int ret = 0;
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		ret = bq25980_set_const_charge_curr(bq, val->intval);
-		if (ret)
-			return ret;
-		break;
-
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		ret = bq25980_set_const_charge_volt(bq, val->intval);
-		if (ret)
-			return ret;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
 static int bq25980_get_battery_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
@@ -736,6 +709,18 @@ static int bq25980_set_charger_property(struct power_supply *psy,
 			return ret;
 		break;
 
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = bq25980_set_const_charge_curr(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = bq25980_set_const_charge_volt(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -957,7 +942,6 @@ static struct power_supply_desc bq25980_battery_desc = {
 	.name			= "bq25980-battery",
 	.type			= POWER_SUPPLY_TYPE_BATTERY,
 	.get_property		= bq25980_get_battery_property,
-	.set_property		= bq25980_set_battery_property,
 	.properties		= bq25980_battery_props,
 	.num_properties		= ARRAY_SIZE(bq25980_battery_props),
 	.property_is_writeable	= bq25980_property_is_writeable,
-- 
2.30.0

