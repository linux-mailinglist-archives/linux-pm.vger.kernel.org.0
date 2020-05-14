Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155DA1D4177
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgENXFV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:21 -0400
Received: from mail-mw2nam12olkn2048.outbound.protection.outlook.com ([40.92.23.48]:48353
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729089AbgENXFU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juQ1uv2PQI4oVeb3gR7UDjtU+bFKGd3Q4nSeUchXdd0froQzwMQ12DpNcqXyI94btSbdTMgQiBYFdoyJT7cCGPM+R+m/EAR5copLBmWUniHTygj7wXpf7aQZLjDiJ/bJxtSIujSVUOsDhMMNQJ+lyD5bFbASa0q3vXHmgD4HxduIU3aFsJSmgxQVvxI8O6A+lCN0Fz5HmLQJNxh8HtL1CxCO3xw10+6Gi9UHIV966j2ooev64zgUCmYGOX6Wn5+ZtAPzFj6b0ErtdktJGmf7Pie959KOFYkRgT22WDFRZb34oSGq2bbi4dlCYGvVtuTStHEGMQQq9ZujPb7UQpta/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Awkr2HpBhIcbXNIc+x+8pzhsNau8D04HOqebPXK4AQ=;
 b=B2nxgdU0PPYAcG8kxLNqWLcrCJWVLIKtCzpLp7//l3ynEGSvJ5y5XOYZkol5CjT2D/bWFmeuiPUnFANLIS+0vYcUteQGr0TxhBQjxJqtYDd62U+9gHUNiLhYNxSGTnYbOKr67OgGiQxAEXSU4yy1yfgfHmfPS6SFWUIA6NcA8Hx1/Lvng9G7cSN+CjnOqQ8NjWW0tIi+RBX+WUbVDXG4hrclQa+8Y8sJDpRIXuv7JCDBRQTbHRbim1RZA8Gu7D33xjDMOgXHux/XnMvTjxadUV9YQyTl3+/HF9+UIpadTEPhp5RYAnG7KlVcYTpWuanLIAG2YPvJSGQIl/99aoGLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::47) by
 MW2NAM12HT137.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::308)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Thu, 14 May
 2020 23:05:17 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:17 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:DA49E0BF4D44EDE16ED6CB8CF973445A05031789189D1DC617FF0DF5C394CCD6;UpperCasedChecksum:DB43982AC0D3BA7F762B9A5240929384587D5BA91CA2D7E9E9DD9B8CAFB75C9E;SizeAsReceived:7846;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:17 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 08/10] power: supply: charger-manager: Update extcon functions
Date:   Thu, 14 May 2020 16:04:33 -0700
Message-ID: <BN6PR04MB0660947F3057DE9785C5A6B4A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514230435.11798-1-xc-racer2@live.ca>
References: <20200514230435.11798-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-9-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:16 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-9-xc-racer2@live.ca>
X-TMN:  [AcyfIgyKaFETI0utMZ2iLLGcFuqS6vCeNAZkAEPkpunVOy+2tlxhWt5qcagr9rVu]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 74d3d40f-9c30-47aa-3c8d-08d7f85b44a1
X-MS-TrafficTypeDiagnostic: MW2NAM12HT137:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8P9hABOmelYHAoQi/+SKxUr+eOeeG32b5Sf1M477CajGAlyId7HMW4X92xnaQfjSNw3wpPSSDBM/OHKECCtXPwJrUeKcphgrcy7p8e/YNYAldjsf7MkPiFjHkRWsCKxa8lWc2kLMrgXz/R/5PEf9X8i9HFgV1v+dq0TAeK0kxQGRx07NhWQtRmttZIwBdhsxkLtIuT2Uw2IAMvV/6aOew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: sE0ZLSkAGq6PQiYLwIrACHzwkDqTagDcnuYORuwftGmFopS9lBY8vJ9k3pB20PG0ay6zCxXox6LpqScYCsakYPg6rgl9vNEtrapxXUzq7myirmnVno+lSKKa/xBMB8/sE8QrrNzZlo4wh9MN9mIqJyblwGNDsJS8iD+9NU7OqywH0E8HGME7EOSwRk0YWlqEIAnixBixEswVYwJDJRYe4g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d3d40f-9c30-47aa-3c8d-08d7f85b44a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:17.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT137
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In commit 830ae442202e ("extcon: Remove the deprecated extcon functions")
the function extcon_register_interest became a no-op returning an error,
leading to non-functional behaviour in charger-manager.

Additionally, a translation table is needed between the text representation
of the extcon cable names and their IDs is needed.  In order to retain DT
compatibility, TA and CHARGE-DOWNSTREAM are added as they were present up
until commit 11eecf910bd8 ("extcon: Modify the id and name of external
connector")

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/charger-manager.c | 82 +++++++++++++++++++-------
 include/linux/power/charger-manager.h  |  5 +-
 2 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 27064a46a365..4ad3dd754abf 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -26,6 +26,29 @@
 #include <linux/of.h>
 #include <linux/thermal.h>
 
+static struct {
+	const char *name;
+	u64 extcon_type;
+} extcon_mapping[] = {
+	/* Current textual representations */
+	{ "USB", EXTCON_USB },
+	{ "USB-HOST", EXTCON_USB_HOST },
+	{ "SDP", EXTCON_CHG_USB_SDP },
+	{ "DCP", EXTCON_CHG_USB_DCP },
+	{ "CDP", EXTCON_CHG_USB_CDP },
+	{ "ACA", EXTCON_CHG_USB_ACA },
+	{ "FAST-CHARGER", EXTCON_CHG_USB_FAST },
+	{ "SLOW-CHARGER", EXTCON_CHG_USB_SLOW },
+	{ "WPT", EXTCON_CHG_WPT },
+	{ "PD", EXTCON_CHG_USB_PD },
+	{ "DOCK", EXTCON_DOCK },
+	{ "JIG", EXTCON_JIG },
+	{ "MECHANICAL", EXTCON_MECHANICAL },
+	/* Deprecated textual representations */
+	{ "TA", EXTCON_CHG_USB_SDP },
+	{ "CHARGE-DOWNSTREAM", EXTCON_CHG_USB_CDP },
+};
+
 /*
  * Default temperature threshold for charging.
  * Every temperature units are in tenth of centigrade.
@@ -950,7 +973,8 @@ static int charger_extcon_notifier(struct notifier_block *self,
 static int charger_extcon_init(struct charger_manager *cm,
 		struct charger_cable *cable)
 {
-	int ret;
+	int ret, i;
+	u64 extcon_type = EXTCON_NONE;
 
 	/*
 	 * Charger manager use Extcon framework to identify
@@ -959,14 +983,39 @@ static int charger_extcon_init(struct charger_manager *cm,
 	 */
 	INIT_WORK(&cable->wq, charger_extcon_work);
 	cable->nb.notifier_call = charger_extcon_notifier;
-	ret = extcon_register_interest(&cable->extcon_dev,
-			cable->extcon_name, cable->name, &cable->nb);
+
+	cable->extcon_dev = extcon_get_extcon_dev(cable->extcon_name);
+	if (IS_ERR_OR_NULL(cable->extcon_dev)) {
+		pr_err("Cannot find extcon_dev for %s (cable: %s)\n",
+			cable->extcon_name, cable->name);
+		if (cable->extcon_dev == NULL)
+			return -EPROBE_DEFER;
+		else
+			return PTR_ERR(cable->extcon_dev);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(extcon_mapping); i++) {
+		if (!strcmp(cable->name, extcon_mapping[i].name)) {
+			extcon_type = extcon_mapping[i].extcon_type;
+			break;
+		}
+	}
+	if (extcon_type == EXTCON_NONE) {
+		pr_err("Cannot find cable for type %s", cable->name);
+		return -EINVAL;
+	}
+
+	cable->extcon_type = extcon_type;
+
+	ret = devm_extcon_register_notifier(cm->dev, cable->extcon_dev,
+		cable->extcon_type, &cable->nb);
 	if (ret < 0) {
-		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
+		pr_err("Cannot register extcon_dev for %s (cable: %s)\n",
 			cable->extcon_name, cable->name);
+		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -983,6 +1032,7 @@ static int charger_manager_register_extcon(struct charger_manager *cm)
 {
 	struct charger_desc *desc = cm->desc;
 	struct charger_regulator *charger;
+	unsigned long event;
 	int ret;
 	int i;
 	int j;
@@ -1010,6 +1060,11 @@ static int charger_manager_register_extcon(struct charger_manager *cm)
 			}
 			cable->charger = charger;
 			cable->cm = cm;
+
+			event = extcon_get_state(cable->extcon_dev,
+				cable->extcon_type);
+			charger_extcon_notifier(&cable->nb,
+				event, NULL);
 		}
 	}
 
@@ -1370,7 +1425,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 	struct charger_desc *desc = cm_get_drv_data(pdev);
 	struct charger_manager *cm;
 	int ret, i = 0;
-	int j = 0;
 	union power_supply_propval val;
 	struct power_supply *fuel_gauge;
 	struct power_supply_config psy_cfg = {};
@@ -1568,12 +1622,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 		struct charger_regulator *charger;
 
 		charger = &desc->charger_regulators[i];
-		for (j = 0; j < charger->num_cables; j++) {
-			struct charger_cable *cable = &charger->cables[j];
-			/* Remove notifier block if only edev exists */
-			if (cable->extcon_dev.edev)
-				extcon_unregister_interest(&cable->extcon_dev);
-		}
 
 		regulator_put(desc->charger_regulators[i].consumer);
 	}
@@ -1588,7 +1636,6 @@ static int charger_manager_remove(struct platform_device *pdev)
 	struct charger_manager *cm = platform_get_drvdata(pdev);
 	struct charger_desc *desc = cm->desc;
 	int i = 0;
-	int j = 0;
 
 	/* Remove from the list */
 	mutex_lock(&cm_list_mtx);
@@ -1598,15 +1645,6 @@ static int charger_manager_remove(struct platform_device *pdev)
 	cancel_work_sync(&setup_polling);
 	cancel_delayed_work_sync(&cm_monitor_work);
 
-	for (i = 0 ; i < desc->num_charger_regulators ; i++) {
-		struct charger_regulator *charger
-				= &desc->charger_regulators[i];
-		for (j = 0 ; j < charger->num_cables ; j++) {
-			struct charger_cable *cable = &charger->cables[j];
-			extcon_unregister_interest(&cable->extcon_dev);
-		}
-	}
-
 	for (i = 0 ; i < desc->num_charger_regulators ; i++)
 		regulator_put(desc->charger_regulators[i].consumer);
 
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index c127dbe31e49..45e228b353ea 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -40,7 +40,7 @@ enum cm_batt_temp {
 /**
  * struct charger_cable
  * @extcon_name: the name of extcon device.
- * @name: the name of charger cable(external connector).
+ * @name: the name of the cable connector
  * @extcon_dev: the extcon device.
  * @wq: the workqueue to control charger according to the state of
  *	charger cable. If charger cable is attached, enable charger.
@@ -56,9 +56,10 @@ enum cm_batt_temp {
 struct charger_cable {
 	const char *extcon_name;
 	const char *name;
+	struct extcon_dev *extcon_dev;
+	u64 extcon_type;
 
 	/* The charger-manager use Extcon framework */
-	struct extcon_specific_cable_nb extcon_dev;
 	struct work_struct wq;
 	struct notifier_block nb;
 
-- 
2.20.1

