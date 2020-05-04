Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9EA1C497B
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 00:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgEDWNg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 18:13:36 -0400
Received: from mail-bn8nam11olkn2047.outbound.protection.outlook.com ([40.92.20.47]:17633
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728202AbgEDWNf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 18:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZriF2GZk2BlwHCcwHeKv40eCG51RJChU6NoAnMob0wYXUdH0gGdiuHCv02PK2l2E2ZCPq8JkRAhJ1z3EK9JZK1f98W1sJURvzZKle/YjnZ+7ennvXvd8LR2rzCa+ak1foSBliiZmsfG4kPKz0pU5/6UxXspJer36IUgmlQXQ8hGxSqUDYqDd6pv/zusbvNkUBeCaaYgupepKsS/yEwV3mV9l6wQQX2C1yPSBLAryvugpHIxL/Ddr4r8laTsEnEFzcvEnkL06zTHtYc/9acAo32U06aL9s7VMZLcZ8qbR2/imRWoan5mnS61SLShvtQKW5IA1OAzPtBar/ba8XovJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SrpbefCRfEjV8iCNrMUH8buPaWQxavRgC+FU0Fe/0U=;
 b=d1b/p/6Ta90hYUUHd421gI6BHzQ/u09/th1xOrKMZO8omNy6Uzox8+ivw9sn93uqajGnmQFhthMR1dKx5Ebcr740RLZ17AKKp9mo8kCVE8odGDp1tgdhmQMZU2LY8X2yOcJDhlZfEGwwp+mGBbte8UT/oxW5i+n+oRIFkgzVBWpE8ZV+fFKWlziXZI5HZ9HNWVXUEzHU2WoIxNOeWObNBab1k3HGek+cOOEPPvDMk7BFwbmr3yaKsTdai6j7tN6lu9eORGH52I7Z8zquN0O0+LkS10vTAe7qzoVK70PGtyBtmsUIG1VyUDmp1pCadOp7uIlclBFb3VAHn1czQndoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::40) by
 BN8NAM11HT024.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::194)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 22:13:31 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::4d) by BN8NAM11FT010.mail.protection.outlook.com
 (2a01:111:e400:fc4b::309) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 22:13:31 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:C4ED0778683EEC4312A8066D6998C8158858CDF1521D03DE303DEF954BE741C4;UpperCasedChecksum:B36B717E36E5C63444A31DF994CA95C786BD1BDC40255040C3BC9BAC164B2B47;SizeAsReceived:7758;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 22:13:31 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 3/3] power: supply: max17040: Set rcomp value
Date:   Mon,  4 May 2020 15:13:00 -0700
Message-ID: <BN6PR04MB066057B881DEFC0C48208589A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504221300.3153-1-xc-racer2@live.ca>
References: <20200504221300.3153-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR2201CA0053.namprd22.prod.outlook.com
 (2603:10b6:301:16::27) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200504221300.3153-4-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR2201CA0053.namprd22.prod.outlook.com (2603:10b6:301:16::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Mon, 4 May 2020 22:13:30 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200504221300.3153-4-xc-racer2@live.ca>
X-TMN:  [KPXs7hi3OI0qzQkXUSboa9ggWN8isMFJInOlAPO9Hda/k0eObCDUSvcNS1hPkGEV]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e86124e9-0d75-4e3b-c0c9-08d7f078611f
X-MS-TrafficTypeDiagnostic: BN8NAM11HT024:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7l7qdfru6v/RME/CFdETyKAW4IqQ2vacxmFVLHGjhA4NT9U5fZKMqijA1lO/a0PpHtpaHVvYTYfGnRVAifvT1aAmxgbSGxbc95y//DGTAlXlptiGpHF69O8OdrVILbIxIvhYvIx9lhO4SKnasVsRd/CmwjiLLD0IhIjhquQ8ItOAwjFLJO7hXJ4hVsOKjcoT+6MLdipzc+m2lcnPTJ4JytYa4UtZ4JXyCSO3O1NEEZjUiV4WvCAhEY9HfVDJDqUg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: QZ0qL2uX4cnkVDH1EgjDNfnZ+YpdIXGSsuH1u6anzpQ2MdIqVccvzbiwVtZ5XszSsr5kkUHE/+ix9ckMxZD1Yhann1K81V6X8e0GmjXkwB31lOkGDzGxiOxSem03Zclgm4joa9kzgv2Jk8o8EvhkTNfj5k2QyenoH9Ny0YhrpVgLnTOXAMMOQA6kWuLNBmP7SxdHrpA2uq5tDJIsaQvfMg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86124e9-0d75-4e3b-c0c9-08d7f078611f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 22:13:31.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT024
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to the datasheet (1), the rcomp parameter can
vary based on the typical operating temperature and the
battery chemistry.  If provided, make sure we set it after
we reset the chip on boot.

1) https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/max17040_battery.c | 33 +++++++++++++++++++++----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 48aa44665e2f..f66e2fdc0a8a 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
@@ -31,6 +32,8 @@
 
 #define MAX17040_ATHD_MASK		0xFFC0
 #define MAX17040_ATHD_DEFAULT_POWER_UP	4
+#define MAX17040_RCOMP_MASK		0xFF
+#define MAX17040_RCOMP_DEFAULT_POWER_UP	0x97
 
 struct max17040_chip {
 	struct i2c_client		*client;
@@ -48,6 +51,8 @@ struct max17040_chip {
 	int status;
 	/* Low alert threshold from 32% to 1% of the State of Charge */
 	u32 low_soc_alert;
+	/* Optimization for specific chemistries */
+	u8 rcomp_value;
 };
 
 static int max17040_get_property(struct power_supply *psy,
@@ -119,6 +124,20 @@ static int max17040_set_low_soc_alert(struct i2c_client *client, u32 level)
 	return ret;
 }
 
+static int max17040_set_rcomp(struct i2c_client *client, u32 val)
+{
+	int ret;
+	u16 data;
+
+	data = max17040_read_reg(client, MAX17040_RCOMP);
+	/* clear the rcomp val and set MSb 8 bits */
+	data &= MAX17040_RCOMP_MASK;
+	data |= val << 8;
+	ret = max17040_write_reg(client, MAX17040_RCOMP, data);
+
+	return ret;
+}
+
 static void max17040_get_vcell(struct i2c_client *client)
 {
 	struct max17040_chip *chip = i2c_get_clientdata(client);
@@ -190,8 +209,14 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 				 "maxim,alert-low-soc-level",
 				 &chip->low_soc_alert);
 
-	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33)
+	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33) {
+		dev_err(&client->dev,
+			"failed: low SOC alert OF data out of bounds\n");
 		return -EINVAL;
+	}
+
+	chip->rcomp_value = MAX17040_RCOMP_DEFAULT_POWER_UP;
+	device_property_read_u8(dev, "maxim,rcomp-value", &chip->rcomp_value);
 
 	return 0;
 }
@@ -289,11 +314,8 @@ static int max17040_probe(struct i2c_client *client,
 	chip->client = client;
 	chip->pdata = client->dev.platform_data;
 	ret = max17040_get_of_data(chip);
-	if (ret) {
-		dev_err(&client->dev,
-			"failed: low SOC alert OF data out of bounds\n");
+	if (ret)
 		return ret;
-	}
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
@@ -307,6 +329,7 @@ static int max17040_probe(struct i2c_client *client,
 
 	max17040_reset(client);
 	max17040_get_version(client);
+	max17040_set_rcomp(client, chip->rcomp_value);
 
 	/* check interrupt */
 	if (client->irq && of_device_is_compatible(client->dev.of_node,
-- 
2.20.1

