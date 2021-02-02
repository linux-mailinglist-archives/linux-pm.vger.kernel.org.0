Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C285930BA45
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 09:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhBBIuI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 03:50:08 -0500
Received: from mail-db8eur05on2110.outbound.protection.outlook.com ([40.107.20.110]:31969
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232716AbhBBIuE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Feb 2021 03:50:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjsizJeRENfh51WaOzcUtVxjq/dTmzxhu96NaZpus4meSuSjgzvG6keCRrqfmr9XA1D8EjlCiLxlw3mb1EAwCcQFfxC6pKc0DWE1PcRc9sBf9LOqx++K35iXCDciIIM75nyIHTcf5CpDqjf0iV7/U6D4M5cQYQYFORJuYfOT2lmhN3bvQEE9FnusFegRuXgNKIcCkpfz/grMz7qY7F9FkrbFo/nM9cI1FXrrFI1lBhVL7+ZA/c92vaswtDrjtcdQyQNT7FhdcT9SCY8NX/4rHm2x8pq0AZpr3ISUte4t7bsdAUqLke/QrtSEu085cwWA6gLAnTyzNjBZky3DmJ3f/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePuFtG+GheNuXViWGy7OCZjxfgMo5tgti4haOtBpaCo=;
 b=iyh3aTTAekFMTWv+sChH4kpO4KB8DGq+moBg7Y35ZGDbbt0hea40Nuso3YS63VZu0kLuGVbz1zSDPXHlvFAToOmYfpPgS1xnjPktFwrP/rahCfoEov9EleuuK1ep4T/k4rpI5J3NxZ4QMR0xkPZJ1z09D4RBRlWMjP8WEhBzvcTpVkagPIjE9GtiQcagDWisst8ZePe6MICVEziLRSum5YuZOQl/MireGGRyubLj6iiujogCjq5kkv69c9EBANi/98tvpQTTrPgVf0eXu/LPCvKaf+m5ESSGscV1GK9t6RKp/8vMr/JSa8yGAD48IDLcTUDj+g0Sal/jKnhlwiwjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePuFtG+GheNuXViWGy7OCZjxfgMo5tgti4haOtBpaCo=;
 b=XgGgfE6g6tIPGyLoGpXx7pJBsC7UC69elk7v/e9VBuQ2zOtxFuMOWad1i1unEW2FYVNi56JriUeFhBau0FFiEKZq3ziFbPsW2kA1FJBqYSjkcq/3v773rLa02uC1TwUUrE/smEpVUzxm7EpPANlNRyC6Lsuvhk1U6+Ekd4xo/Ks=
Received: from AM5PR0601CA0033.eurprd06.prod.outlook.com
 (2603:10a6:203:68::19) by PAXPR06MB7504.eurprd06.prod.outlook.com
 (2603:10a6:102:159::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 08:49:15 +0000
Received: from HE1EUR02FT042.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::38) by AM5PR0601CA0033.outlook.office365.com
 (2603:10a6:203:68::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Tue, 2 Feb 2021 08:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 HE1EUR02FT042.mail.protection.outlook.com (10.152.11.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Tue, 2 Feb 2021 08:49:06 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, krzk@kernel.org, afd@ti.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V2 1/2] power: supply: bq27xxx: Add support for BQ78Z100
Date:   Tue,  2 Feb 2021 08:48:57 +0000
Message-Id: <20210202084858.2944-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202084858.2944-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210202084858.2944-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 90aec72c-a39e-49a2-f32f-08d8c7576676
X-MS-TrafficTypeDiagnostic: PAXPR06MB7504:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB7504280DACA00B9D0244764ED7B59@PAXPR06MB7504.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgNtb4vHwfEtzwRBjSEu5ifYkaupr2kb77I+EU1yitHWbVPX9imBs5RVsmNRZyToGDhR5EM0V4ooihJhILxAw+PZKMPK4ZhjCMNYpQnbArBVDxhjqKzGEcmFFRt/oHkHgcqln0AI+rRjn6NfyEdJNopD2dg3OUWM3jW9AjTgLWjk3GIJjUDjvGnd1X/6nCymBwhnBWCFl6exIeWm7l2rhSzVdqPMP0TZg9qRI1UKqF0+kPOOxLOcUm0yLzvTRaXoMF0mL6NPt7q8lfdPiEmGqNcFc6aiDPooCBe21VfTRxC4o2ZfuJZyM+w2BzqntpLumogSoQ+gOspnfd/gjdk2KzvH8wCJ4bzQ7vxECwCWDosgb1DflZIrky9Gl00zeGNuCXhgPlPd6ez26zctDxuFC9cQMZHGIe6XiC4iRbTsxewp8j07QDEDK37/BsN7XpwM0Fn/vfsnU9I4fCK/lC5vlyxiTV4gpAfYhm1NFPlgUkCMV68MtQwIQRjdktM0aqBCixSlhskEDXoROeH2sRn9t2bPpWOVKR4B70s8Sk5NDnElniufvv/ZSjgvXsi3F/4SfZNcrF/AynUMI+d7PCSwta4MYxrqLq0XVO1j/ASi4uaTApzuMw+Ihhrb4UpvBgokn+EoSU/PH3WIXI417FMOCuFdaQegJ0fyb+MIliWG08PS+oj2ayLMY5+ZavJJcjY77eMCo/7a+8sfgZtLX5QcmQFdoODN0LEPRXyEoP+IxNzq9K+fE3+4nDb+0LrDQ9jsmD09VsBhOIi5cfPjNfP95w==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(36736006)(956004)(86362001)(336012)(118246002)(26005)(5660300002)(2616005)(8936002)(6506007)(316002)(966005)(186003)(478600001)(36860700001)(1076003)(356005)(6512007)(83380400001)(6486002)(70206006)(34020700004)(70586007)(82310400003)(4326008)(36756003)(47076005)(8676002)(107886003)(2906002)(6666004)(81166007)(82740400003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 08:49:06.3361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90aec72c-a39e-49a2-f32f-08d8c7576676
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT042.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7504
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for TI BQ78Z100, I2C interface gas gauge.
It provides a fully integrated safety protection,
and authentication for 1 to 2-series cell Li-Ion and
Li-Polymer battery packs.

The patch was tested with BQ78Z100 equipment.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/power/supply/bq27xxx_battery.c     | 46 +++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 315e0909e6a4..c8579ec7a4f8 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -39,6 +39,7 @@
  * https://www.ti.com/product/bq27z561
  * https://www.ti.com/product/bq28z610
  * https://www.ti.com/product/bq34z100-g1
+ * https://www.ti.com/product/bq78z100
  */
 
 #include <linux/device.h>
@@ -497,7 +498,27 @@ static u8
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x22,
 		BQ27XXX_DM_REG_ROWS,
-	};
+	},
+	bq78z100_regs[BQ27XXX_REG_MAX] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = 0x28,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = 0x18,
+		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x2a,
+		[BQ27XXX_REG_AE] = 0x22,
+		[BQ27XXX_REG_SOC] = 0x2c,
+		[BQ27XXX_REG_DCAP] = 0x3c,
+		[BQ27XXX_REG_AP] = 0x22,
+		BQ27XXX_DM_REG_ROWS,
+};
 
 static enum power_supply_property bq27000_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
@@ -792,6 +813,27 @@ static enum power_supply_property bq34z100_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static enum power_supply_property bq78z100_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
 struct bq27xxx_dm_reg {
 	u8 subclass_id;
 	u8 offset;
@@ -890,6 +932,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 #define bq27z561_dm_regs 0
 #define bq28z610_dm_regs 0
 #define bq34z100_dm_regs 0
+#define bq78z100_dm_regs 0
 
 #define BQ27XXX_O_ZERO		BIT(0)
 #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
@@ -948,6 +991,7 @@ static struct {
 	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
 	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
 							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
+	[BQ78Z100]  = BQ27XXX_DATA(bq78z100,  0x00000000, BQ27Z561_O_BITS),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index eb4f4284982f..46f078350fd3 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -248,6 +248,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27z561", BQ27Z561 },
 	{ "bq28z610", BQ28Z610 },
 	{ "bq34z100", BQ34Z100 },
+	{ "bq78z100", BQ78Z100 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
@@ -284,6 +285,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27z561" },
 	{ .compatible = "ti,bq28z610" },
 	{ .compatible = "ti,bq34z100" },
+	{ .compatible = "ti,bq78z100" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 111a40d0d3d5..ac17618043b1 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -33,6 +33,7 @@ enum bq27xxx_chip {
 	BQ27Z561,
 	BQ28Z610,
 	BQ34Z100,
+	BQ78Z100,
 };
 
 struct bq27xxx_device_info;
-- 
2.17.1

