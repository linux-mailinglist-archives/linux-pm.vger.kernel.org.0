Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1F030D7CD
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 11:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhBCKmD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 05:42:03 -0500
Received: from mail-eopbgr130129.outbound.protection.outlook.com ([40.107.13.129]:6788
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233926AbhBCKl7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 05:41:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONfFuAlSF8j2cAFxI59teRDrbAgVY+zneSH8NSP70tJt2PRFyMIqoV1hFJSDnQoYFlsaLGExbmsmdOKoB7tA4pPF+SHLpwVupWI2z7h22OJXv9PAefeM0VlDq7puREBSGXuNkgvdGZgNkIB/LNBSV1hea8FW5HiwHbf2JmQZGgNPoeCbPhpfRD6QEYazUAOanhNd1ctAZx4Dq+VqG3cgE2booBgCJj/zpb4ECbhK2Z0plZ3kDv6+W4gPMFazYQmtGmP6C5NbI5M+v+ZF584FSLaLGFM1xmlFF9tGXON5t46423QChMwDwiI81h6epC+4+psM/YRFSmcukgacHrMFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGFG4hj3UyIS5K5V7leE41pEt3J5EQEx6BogS1e7uQ=;
 b=ilnC9xhlotmpjc5WCoSvgUjLbMVeEwLlL2n+WCUfsD/XRXn4Eb7W589JA4QrVPN3NF+suCD5AfIp88q4FJCQwKnNUNGnazIgfyeP7kt+HN6ObHq63oon7blAJ2FUlUfjpfGpQM7M7fL21Se1uXxUEozFh6+oZngEqS4iwlzz5+3NERgYmJ+ZA8eN3TnH5b5anYT3WxLRlbIGvfiPNVXk1O+fNdnB8WkfHAIXTtSez+ra52JgsThHXrfvJ6Hsn/xKVTRC3HhleyDaT5/SOFBOUs7skLzPe7JZ+zcZYyS+hbrU6su4gHQejbpCC7FbBLAxB/vK/g5lWw7F43xgjPKsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGFG4hj3UyIS5K5V7leE41pEt3J5EQEx6BogS1e7uQ=;
 b=XckXgntWIU7nU+2YE0mLJXs3DEkprmgjPmc1r8Thcqd05bF006rfzhI7VLQmVfxf8NwrLKqgZik4d4HeYOxbIHuBy4FXyrgcVDzla9Yg8wLAizA+irQwiXHctMUZDfHH9ReSF9p0NlhgXNB2Vf/uQz9AuCQ1AsMplppeK48JsVY=
Received: from AM0PR07CA0006.eurprd07.prod.outlook.com (2603:10a6:208:ac::19)
 by AM8PR06MB7105.eurprd06.prod.outlook.com (2603:10a6:20b:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 3 Feb
 2021 10:41:09 +0000
Received: from VE1EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:ac:cafe::28) by AM0PR07CA0006.outlook.office365.com
 (2603:10a6:208:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.13 via Frontend
 Transport; Wed, 3 Feb 2021 10:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 VE1EUR02FT043.mail.protection.outlook.com (10.152.13.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 3 Feb 2021 10:41:08 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V3 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Date:   Wed,  3 Feb 2021 10:41:00 +0000
Message-Id: <20210203104100.17143-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203104100.17143-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210203104100.17143-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6dc8cf81-5c2f-4c56-f05f-08d8c830379e
X-MS-TrafficTypeDiagnostic: AM8PR06MB7105:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR06MB710571169FEC2641AE64EFCDD7B49@AM8PR06MB7105.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeBi69iZesVFqCyxTMw84XS7uXWJYocrwAMMcTkBmbHPZGPf5SXYMR707IbqX3spLipiPJBejpARCXj+mLPhFAG2x7R+lO5uPBS+iyHk+lMTDGFSOubeFKRvUnzNL/n0FxF2Km4spRV7GaRwfMG9bOUE5wGm6ki+q++awvD8IV0lsx/xNkXK5O0izGTvVsAmO/cCy7O0TN+4yyMRNd3mS+80rwza0eKv41OcpR6DmSD/TI8lBc0JB/DoR1mAhHRN4VKSOUCFpDFUDYdQnmF8mtJ+xN8GlOjbhPTmgq2W2MXY33XumvVZG8A2vFJAUfvvpvOqfM6pRI7ichYcMhjJzJOyMzngq8GpEFU8UjdVD3iI8midsBNDSAPNJ2neNrXwRfnOBkaBKhECaJhTu5kWTCL6zFdGrY5amiryTaTwqtSYPG2SKp/su8GjC9r3PMZIHwNzTaCgrf3FSS2rWMkkSwvxud19cIx27vxIS1AfA68ocpKsP0gl17lI1qxCx5W3z3/Slg9ZYdy9CiMQLZHZUwjbmEQEARHZOtI2gyaFdCpSFvmBwbl3yB1keXOAUmTYHd5YXBBW8QctDSU2E4eS5u+/zH3uT9zMU2+yVwGWvhs7/vET5m8RNcseO4Ib2g9gWKSSphowDX6vd9PxziDwaOzFwFlgsoNlIHKml+dj2YUPzUgLR0lImrziwxbsJiyhjrhEj+mSmMubTId2Xm8I57u9EllaUh2EcKixnllwtvQZUpGGhGIBfrl8af+fHus0Evhp+NKvLAtaFKC2QJjnmg==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(8936002)(83380400001)(336012)(8676002)(1076003)(2616005)(81166007)(5660300002)(6512007)(47076005)(356005)(956004)(34020700004)(82740400003)(6486002)(86362001)(82310400003)(36860700001)(316002)(36736006)(6506007)(36756003)(70206006)(70586007)(478600001)(118246002)(4326008)(2906002)(186003)(107886003)(6666004)(966005)(26005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 10:41:08.7564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc8cf81-5c2f-4c56-f05f-08d8c830379e
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7105
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for TI BQ78Z100, I2C interface gas gauge.
It provides a fully integrated safety protection
and authentication for 1 to 2-series cell Li-Ion and
Li-Polymer battery packs.

The patch was tested with BQ78Z100 equipment.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
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

