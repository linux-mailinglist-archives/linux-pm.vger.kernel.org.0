Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DE439934
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 16:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhJYOwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 10:52:12 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:5765
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233657AbhJYOvf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Oct 2021 10:51:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbHwzyiLyTqBqqS0iyS1xzILaqMCno67iA7h/BG7nU4Vc2WnfVFGiFTA/9m8M5uWl4yOo8Pa1G1uUjR9PqyiTefmjLK2wuR4y2bTbKDe7eyrjnLz2K2wAQ6h97CTMYCN/jRfYyLZvXVb2YJ3/srmjbJ2Sj6Em1ReAbLxKNrwI3upJCp4A4Mir7T0kUhcE+oNT1ni7KdPk2Q+yG+/k/SKIlT0jv0RbAPqcA9SkdWovyPvJVLWcD5ju9Ba0HsLqAYbwrhGrw3YngFk0qAIKLLMNB2PPRoccSXQEtkrOSzIY5h324jsyylD8/5alzZIS0zS0G0pEbWk2RVODfVX5bnY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQdB3BDvaJ6Xni7LLHmNP3L6oINZ44zVb0u+pUiPU9M=;
 b=HC8i6HSiB5dhO6RnrlvqToVz8+GxgfnEcE1h3mdE4LK4pN+H3Vgdd5f8uo8lYQfd4SUap6JJK8+HebFNLTwfd1Cl0n5jHTc1CBwYxu0IGidOPC2r4ZHqwkUC6h1UqpNO4kV7mOPsigBjixdH/b1ohD6O6fO4BYQcUv1z80OrTSJ+YxZleS1liXzmSJeYBcrCkCClmZ/0bljl93/ufuti9a4zMUn6JJTEtWXqudHAEjYMA3VKHxeEZsitNWW5X5lia9iAl4Gc7dgQV9sHgA3F7Or+h43hLUgyk4IMQ7+S8aF/Jk8u9ykFqEW4sg5WK21WRYis9IxFFj05FQ0FPfurxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mec.at; dmarc=pass action=none header.from=mec.at; dkim=pass
 header.d=mec.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mecat.onmicrosoft.com;
 s=selector2-mecat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQdB3BDvaJ6Xni7LLHmNP3L6oINZ44zVb0u+pUiPU9M=;
 b=EqlRrVFSrW128hn26l8+qi9iFWMNs+35QcLRpP9S1epf6pv+phw0qEVf7jgixnKmOgGE5B6mT0jK9MiecBCjHQlQary1subQTqzKuXa4M3kiyAVpMLVuv9TOtGkvYOpCUxEQce4jkqjmiZdi+A2s7+J9ZEMLKjpqFnGF6vJTqk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mec.at;
Received: from AS8PR03MB7079.eurprd03.prod.outlook.com (2603:10a6:20b:291::8)
 by AM6PR03MB4629.eurprd03.prod.outlook.com (2603:10a6:20b:1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 14:49:09 +0000
Received: from AS8PR03MB7079.eurprd03.prod.outlook.com
 ([fe80::a82b:d993:9c68:f4ce]) by AS8PR03MB7079.eurprd03.prod.outlook.com
 ([fe80::a82b:d993:9c68:f4ce%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 14:49:08 +0000
From:   Thomas Marangoni <thomas.marangoni@mec.at>
To:     sre@kernel.org, wens@csie.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Marangoni <thomas.marangoni@mec.at>
Subject: [PATCH] PM: Added functionality to the axp20x_battery driver
Date:   Mon, 25 Oct 2021 16:44:55 +0200
Message-Id: <20211025144455.16665-1-thomas.marangoni@mec.at>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::24) To AS8PR03MB7079.eurprd03.prod.outlook.com
 (2603:10a6:20b:291::8)
MIME-Version: 1.0
Received: from mecdev35.mec.at (213.185.161.83) by ZR0P278CA0014.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Mon, 25 Oct 2021 14:49:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a23ade58-f593-4150-8eb5-08d997c699b1
X-MS-TrafficTypeDiagnostic: AM6PR03MB4629:
X-Microsoft-Antispam-PRVS: <AM6PR03MB4629DE37F3115428B9E8B0FCF6839@AM6PR03MB4629.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:53;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOA7OGgSD+6gCOf64G4UavSKT5oDkJfAAEUeOTB1U0YcQ7YjS0YC3igdnVd+V2q0n7tcsQONj90jDR7A30LGt7ehEFtDJbZWCz22wtlqoy+ab3pfykEicitiHRIKE7bYvTW0gjWpHur1tyIuQpgcvCC86FwvgtR9cITzwYT6/3vNQE8LUhkpxXUiRQkXOA6V2LVMHBTv1WogUIitA9syXI20a/yTQJiCxmdm2mWA1F7Runrr78lCnZ3cXqVGRWy2eYEHjkOm8w7B6clwuLSMvJG38/o+ff0f/JSQZ74K4cF7hFfx5jESnZbaEd92TJBMWyxepheFsuxs8jRz4dgf8CRsvXT7o7tENK7knuqryVhmDgK423NnCnRuwAwD/CM21nddbyctizwJGxVTHT72ZOi+q6i2bfKkEPkcpnvFJLvGH59jEGJSMauXPS9A/6qJMkjqQbfiRGx23qGem1eQ+g55zGkJF1psTyBbp306sZoBWNc//GcvKjgV2qiEXeWqjNaNhKm/PDlIu141yu+n+PW22OFuhIUHl5wsLeq/ew1CRfSvM85RtOq6ymi/+g7aOp0Vi6ivHpezguuBntm6Q2ZmlRF05rkVY66isfnHVc9AOukhSS0RHH11L9lbCNO/A0JbQQMLNlMtrGAM91cRj25Bx2SpkbAt6PYo2oBxaBF0RIH/bDc/h+kOL/zfxLwpFex2aVOzD98xy6wyeasGzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7079.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(366004)(39830400003)(66476007)(66556008)(66946007)(316002)(2906002)(36756003)(44832011)(2616005)(956004)(38100700002)(6486002)(4326008)(83380400001)(8936002)(30864003)(86362001)(186003)(26005)(1076003)(5660300002)(52116002)(6666004)(508600001)(7696005)(38350700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7dg7JVUkmUcb1UrDNjiYYfpWp92W11AcDfbrKeiHnQUIKLqsLmGJOUBnwCM?=
 =?us-ascii?Q?ZV260taBMMgDNwtQJb3EEldeWRZoePtL232cgRIdyp9ra6pse2mt6HBeKBr3?=
 =?us-ascii?Q?+C2bXbdJmDuCHlT8xQKpkCs3FiHfzeiLWsJLXsQm2nV+/7n9tb7pGg7qYCiU?=
 =?us-ascii?Q?1elG7IqCFRVhG5rEezjewFlSJV6HwWdGD0TKu1Uryy8Rau0juwqVrc3DpF4i?=
 =?us-ascii?Q?sGhirT6s2PH6Z6WG0NuC5SKV8IHXP5Zk9eErzevAni2LLWccgTmVOSf3TJOV?=
 =?us-ascii?Q?wen+v2/IHqXU+ELAmb7gMu5xxglrcEwhsDHcx8vB459YkT8xMHTpjS4iSZyc?=
 =?us-ascii?Q?uJDVFR2qUWsJ22Tm0nPkPpC3Uo3wAuybm3P1AaPxhmbYu9AL79YXlZAESdQk?=
 =?us-ascii?Q?ghQhDTfqwGC/Bb/bpRP2aoXqZ9DLeg1v3ravWPR3qRcH3lRYSWolb9JYdoD1?=
 =?us-ascii?Q?q+tJB2P4uBTsXpYngovmvZtQG3arEJk/xXrRdhXdNVeDLe0tw0LEYhlz3uyz?=
 =?us-ascii?Q?4YUNw6bEr4bJw04HABz9NEI5ggXq65VSHdHDd0QBdd4SK210gDGgI0xLbE3M?=
 =?us-ascii?Q?VG4U1izwPi8jLiGTbLs6HxT2ZrIsOlI/8xtJIgeTtowdIvSv5qd8+/rTSDQh?=
 =?us-ascii?Q?h3OAAqyJnBmxBjjJUKOnK0JM7gLh2miIaP5qEHc6bex5aYiS3JNK1c4PdH4C?=
 =?us-ascii?Q?eYOYr2IGYjzsVcuvxp676mIy+2ag0fxA8FIF+6VRY29lv38vZCzirIHb4HdM?=
 =?us-ascii?Q?UP85Hj5ZBNQ67DQlLMffU1XuNprbiGJhS8B2x8nJaY3hlqrH6XtfrG2NY/o3?=
 =?us-ascii?Q?5+TgZKfWCVAn4zfbFNSouMtPDkkFFuQPe2BD/Jvsst8X9d3LNosdKEtLTkEO?=
 =?us-ascii?Q?SKBYRkFTuMes03RSPJmGzu5F5r4dwVWeV/oK8d2EoEjYJwoM/gRwujwV7xZU?=
 =?us-ascii?Q?vZQYl0A75icTasizJlkAIiqu/Xv3oVNmmDiuMFNb/q0LTCAcStHouvFyd1h2?=
 =?us-ascii?Q?DoqjVye+Fk0mxZjJ579NTs/7+pJZwxfHo2EEiOmUdeHlpc2TThOdtBwrEn3S?=
 =?us-ascii?Q?/yTAnd/iwgyjL4irTHj0oDVzqNF/slIL6tap2NaedRqz7XEJhVunb41Rw4Zc?=
 =?us-ascii?Q?IFFgZR0uiegAyJzBnjQibbgd5/GwRsad8gmdVvJTlG3qOTjMsvxXLVM8uHlA?=
 =?us-ascii?Q?UIQ1Z+kxWrXRpvZd4YS6NcFyJojP7d6tz2w0EY3DRm4K4QmrekXt5wGu6Eo4?=
 =?us-ascii?Q?lH0sWfKgQ3Uvza+7QImOqGflriW9urYu07kOHqbZTcTYMAxL2Lc5gn5sbOf0?=
 =?us-ascii?Q?0UiQYuTGIuuwlNSMMuUU9DCFpVtgDD3fDDXq+tpRWIR5RRf2lYl3RC4eSW0v?=
 =?us-ascii?Q?6RHjMmAJ7a/xRrT1mMGqv5qvEEpy1FyzvxRactSQZSguZ3jc0fVtIyGQpCXC?=
 =?us-ascii?Q?TAglYJiN2XJAldkfblBOG71kxmLQghvx9gNkmDzmN7Dqlp/3N47n6ToSjTei?=
 =?us-ascii?Q?DV1B6NqCv2SD/meG8oWvY7t2rkjxIOtmOBWc+pJgDpaYnHatj8STea9d3E6z?=
 =?us-ascii?Q?Ygk4Ss+lsUAHhdnyZslYn2jX20huGuOX1bEXBsV8GPwisWkaoIOorGzOAw3q?=
 =?us-ascii?Q?EvwEm5jkls55hTyq1eP+6Ys=3D?=
X-OriginatorOrg: mec.at
X-MS-Exchange-CrossTenant-Network-Message-Id: a23ade58-f593-4150-8eb5-08d997c699b1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7079.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:49:08.8938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0f47e334-58db-4591-b50f-1937a70d1a07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfvLpFRRf5CFVX9S2X1Ugc0Jf/ct+bpdoSXvZ4CK9QeFfAfuOEHn9OzJQnf7t1WpxBg7hvKezzgoopDalCDTxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4629
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing features of the axp209 battery functionality to the driver.
New and present features have been added to the device tree configuration.

Following features have been implemented:
- Set/Get of OCV curve, this is used to tune the capacity status (setting these
  values is only possible with the device tree).
- Set/Get of voltage low alert, this will trigger an interrupt if the given
  voltage level is reached. Level 1 will print a warning and level 2 will shutdown
  the device.
- Set/Get of temperature sense current, this is useful if a none default NTC is
  used for temperature sensing.
- Set/Get of temperature sense rate, this defines how often the ADC is getting
  the temperature values.
- Set/Get of temperature charging and discharging voltages, this defines the
  temperature ranges (as voltage) where the battery can be charged.
  (setting these values is only possible with the device tree).
- Get of temperature voltage, this returns the voltage that is present on the NTC.

These custom properties have been added to /sys:
- voltage_low_alert_level1 (RW)
- voltage_low_alert_level2 (RW)
- ocv_curve (RO)
- temperature_sense_current (RW)
- temperature_sense_rate (RW)
- temperature_sense_voltage_now (RO)
- temperature_discharge_threshold_voltage_range (RO)
- temperature_charge_threshold_voltage_range (RO)

These IRQs have been added:
- BATT_PLUGIN (generic, useful for udev)
- BATT_REMOVAL (generic, useful for udev)
- CHARG (generic, useful for udev)
- CHARG_DONE (generic, useful for udev)
- BATT_TEMP_HIGH (prints warning, axp stops charging/discharging)
- BATT_TEMP_LOW (prints warning, axp stops charging/discharging)
- LOW_PWR_LVL1 (prints warning)
- LOW_PWR_LVL2 (prints warning and initializes a system shutdown)

These properties have been added to be applied from the device tree:
- low-voltage-level1-microvolt
- low-voltage-level2-microvolt
- temperature-sense-current-microamp
- temperature-sense-rate-hertz
- temperature-discharge-range-microvolt
- temperature-charge-range-microvolt
- voltage-max-design-microvolt
- ocv-capacity-table-0

Signed-off-by: Thomas Marangoni <thomas.marangoni@mec.at>
---
 drivers/mfd/axp20x.c                  |  13 +
 drivers/power/supply/axp20x_battery.c | 938 +++++++++++++++++++++++++-
 2 files changed, 945 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 8161a5dc68e8..05dea452b513 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -191,6 +191,17 @@ static const struct resource axp20x_usb_power_supply_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
 };
 
+static const struct resource axp20x_battery_power_supply_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_PLUGIN, "BATT_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_REMOVAL, "BATT_REMOVAL"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_CHARG, "CHARG"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_CHARG_DONE, "CHARG_DONE"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_TEMP_HIGH, "BATT_TEMP_HIGH"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_TEMP_LOW, "BATT_TEMP_LOW"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_LOW_PWR_LVL1, "LOW_PWR_LVL1"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_LOW_PWR_LVL2, "LOW_PWR_LVL2"),
+};
+
 static const struct resource axp22x_usb_power_supply_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
 	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
@@ -604,6 +615,8 @@ static const struct mfd_cell axp20x_cells[] = {
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp209-battery-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_battery_power_supply_resources),
+		.resources	= axp20x_battery_power_supply_resources,
 	}, {
 		.name		= "axp20x-ac-power-supply",
 		.of_compatible	= "x-powers,axp202-ac-power-supply",
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 18a9db0df4b1..5997c8192c73 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -31,6 +31,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/consumer.h>
 #include <linux/mfd/axp20x.h>
+#include <linux/reboot.h>
 
 #define AXP20X_PWR_STATUS_BAT_CHARGING	BIT(2)
 
@@ -56,6 +57,25 @@
 
 #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
 
+#define AXP20X_APS_WARN_MASK		GENMASK(7, 0)
+
+#define AXP20X_TEMP_MASK		GENMASK(7, 0)
+
+#define AXP20X_ADC_TS_RATE_MASK		GENMASK(7, 6)
+#define AXP20X_ADC_TS_RATE_25Hz		(0 << 6)
+#define AXP20X_ADC_TS_RATE_50Hz		(1 << 6)
+#define AXP20X_ADC_TS_RATE_100Hz	(2 << 6)
+#define AXP20X_ADC_TS_RATE_200Hz	(3 << 6)
+
+#define AXP20X_ADC_TS_CURRENT_MASK	GENMASK(5, 4)
+#define AXP20X_ADC_TS_CURRENT_20uA	(0 << 4)
+#define AXP20X_ADC_TS_CURRENT_40uA	(1 << 4)
+#define AXP20X_ADC_TS_CURRENT_60uA	(2 << 4)
+#define AXP20X_ADC_TS_CURRENT_80uA	(3 << 4)
+
+
+#define DRVNAME "axp20x-battery-power-supply"
+
 struct axp20x_batt_ps;
 
 struct axp_data {
@@ -78,6 +98,79 @@ struct axp20x_batt_ps {
 	const struct axp_data	*data;
 };
 
+/*
+ * OCV curve has fixed values and percentage can be adjusted, this array represents
+ * the fixed values in uV
+ */
+const int axp20x_ocv_values_uV[AXP20X_OCV_MAX + 1] = {
+	3132800,
+	3273600,
+	3414400,
+	3555200,
+	3625600,
+	3660800,
+	3696000,
+	3731200,
+	3766400,
+	3801600,
+	3836800,
+	3872000,
+	3942400,
+	4012800,
+	4083200,
+	4153600,
+};
+
+static irqreturn_t axp20x_battery_power_irq(int irq, void *devid)
+{
+	struct axp20x_batt_ps *axp20x_batt = devid;
+
+	power_supply_changed(axp20x_batt->batt);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t axp20x_battery_low_voltage_alert1_irq(int irq, void *devid)
+{
+	struct axp20x_batt_ps *axp20x_batt = devid;
+
+	dev_warn(axp20x_batt->dev, "Battery voltage low!");
+
+	return IRQ_HANDLED;
+}
+
+
+static irqreturn_t axp20x_battery_low_voltage_alert2_irq(int irq, void *devid)
+{
+	struct axp20x_batt_ps *axp20x_batt = devid;
+
+	dev_emerg(axp20x_batt->dev, "Battery voltage very low! Iniatializing shutdown.");
+
+	orderly_poweroff(true);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t axp20x_battery_temperature_low_irq(int irq, void *devid)
+{
+	struct axp20x_batt_ps *axp20x_batt = devid;
+
+	dev_crit(axp20x_batt->dev, "Battery temperature to low!");
+
+	return IRQ_HANDLED;
+}
+
+
+static irqreturn_t axp20x_battery_temperature_high_irq(int irq, void *devid)
+{
+	struct axp20x_batt_ps *axp20x_batt = devid;
+
+	dev_crit(axp20x_batt->dev, "Battery temperature to high!");
+
+	return IRQ_HANDLED;
+}
+
+
 static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 					  int *val)
 {
@@ -181,6 +274,361 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 	return 0;
 }
 
+static int axp20x_battery_set_ocv_table(struct axp20x_batt_ps *axp_batt,
+					struct power_supply_battery_ocv_table ocv_table[AXP20X_OCV_MAX+1],
+					int ocv_table_size)
+{
+	int ret, i, error = 0;
+
+	if (ocv_table_size != AXP20X_OCV_MAX+1)
+		return 1;
+
+	for (i = 0; i < ocv_table_size; i++) {
+		ret = regmap_update_bits(axp_batt->regmap, AXP20X_OCV(i),
+			GENMASK(7, 0), ocv_table[i].capacity);
+
+		if (ret)
+			error = ret;
+	}
+
+	return error;
+}
+
+static int axp20x_battery_set_voltage_low_alert1(struct axp20x_batt_ps *axp_batt,
+					 int voltage_alert)
+{
+	int ret;
+	/* converts the warning voltage level in uV to the neeeded reg value */
+	int val1 = (voltage_alert - 2867200) / (1400 * 4);
+
+	if (val1 < 0 || val1 > AXP20X_APS_WARN_MASK)
+		return -EINVAL;
+
+	ret = regmap_update_bits(axp_batt->regmap, AXP20X_APS_WARN_L1,
+				  AXP20X_APS_WARN_MASK, val1);
+
+	return ret;
+}
+
+static int axp20x_battery_get_voltage_low_alert1(struct axp20x_batt_ps *axp_batt,
+						 int *voltage_alert)
+{
+	int reg, ret;
+
+	ret = regmap_read(axp_batt->regmap, AXP20X_APS_WARN_L1, &reg);
+	if (ret)
+		return ret;
+
+	/* converts the reg value to warning voltage level in uV */
+	*voltage_alert = 2867200 + (1400 * (reg & AXP20X_APS_WARN_MASK) * 4);
+
+	return ret;
+}
+
+static int axp20x_battery_set_voltage_low_alert2(struct axp20x_batt_ps *axp_batt,
+					 int voltage_alert)
+{
+	int ret;
+
+	/* converts the warning voltage level in uV to the neeeded reg value */
+	int val1 = (voltage_alert - 2867200) / (1400 * 4);
+
+	if (val1 < 0 || val1 > AXP20X_APS_WARN_MASK)
+		return -EINVAL;
+
+	ret = regmap_update_bits(axp_batt->regmap, AXP20X_APS_WARN_L2,
+				  AXP20X_APS_WARN_MASK, val1);
+
+	return ret;
+}
+
+static int axp20x_battery_get_voltage_low_alert2(struct axp20x_batt_ps *axp_batt,
+						 int *voltage_alert)
+{
+	int reg, ret;
+
+	ret = regmap_read(axp_batt->regmap, AXP20X_APS_WARN_L2, &reg);
+	if (ret)
+		return ret;
+
+	/* converts the reg value to warning voltage level in uV */
+	*voltage_alert = 2867200 + (1400 * (reg & AXP20X_APS_WARN_MASK) * 4);
+
+	return ret;
+}
+
+static int axp20x_battery_set_temperature_sense_current(struct axp20x_batt_ps *axp_batt,
+							int sense_current)
+{
+	int ret;
+	int reg = -1;
+
+	switch (sense_current) {
+	case 20:
+		reg = AXP20X_ADC_TS_CURRENT_20uA;
+		break;
+	case 40:
+		reg = AXP20X_ADC_TS_CURRENT_40uA;
+		break;
+	case 60:
+		reg = AXP20X_ADC_TS_CURRENT_60uA;
+		break;
+	case 80:
+		reg = AXP20X_ADC_TS_CURRENT_80uA;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (reg < 0)
+		return -EINVAL;
+
+	ret = regmap_update_bits(axp_batt->regmap, AXP20X_ADC_RATE,
+				  AXP20X_ADC_TS_CURRENT_MASK, reg);
+
+	return ret;
+}
+
+static int axp20x_battery_get_temperature_sense_current(struct axp20x_batt_ps *axp_batt,
+							int *sense_current)
+{
+	int reg, ret;
+
+	ret = regmap_read(axp_batt->regmap, AXP20X_ADC_RATE, &reg);
+	if (ret)
+		return ret;
+
+	reg = reg & AXP20X_ADC_TS_CURRENT_MASK;
+
+	switch (reg) {
+	case AXP20X_ADC_TS_CURRENT_20uA:
+		*sense_current = 20;
+		break;
+	case AXP20X_ADC_TS_CURRENT_40uA:
+		*sense_current = 40;
+		break;
+	case AXP20X_ADC_TS_CURRENT_60uA:
+		*sense_current = 60;
+		break;
+	case AXP20X_ADC_TS_CURRENT_80uA:
+		*sense_current = 80;
+		break;
+	default:
+		*sense_current = -1;
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int axp20x_battery_set_temperature_sense_rate(struct axp20x_batt_ps *axp_batt,
+						     int sample_rate)
+{
+	int ret;
+	int reg = -1;
+
+	switch (sample_rate) {
+	case 25:
+		reg = AXP20X_ADC_TS_RATE_25Hz;
+		break;
+	case 50:
+		reg = AXP20X_ADC_TS_RATE_50Hz;
+		break;
+	case 100:
+		reg = AXP20X_ADC_TS_RATE_100Hz;
+		break;
+	case 200:
+		reg = AXP20X_ADC_TS_RATE_200Hz;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (reg < 0)
+		return -EINVAL;
+
+	ret = regmap_update_bits(axp_batt->regmap, AXP20X_ADC_RATE,
+				  AXP20X_ADC_TS_RATE_MASK, reg);
+
+	return ret;
+}
+
+static int axp20x_battery_get_temperature_sense_rate(struct axp20x_batt_ps *axp_batt,
+						     int *sample_rate)
+{
+	int reg, ret;
+
+	ret = regmap_read(axp_batt->regmap, AXP20X_ADC_RATE, &reg);
+	if (ret)
+		return ret;
+
+	reg = reg & AXP20X_ADC_TS_RATE_MASK;
+
+	switch (reg) {
+	case AXP20X_ADC_TS_RATE_25Hz:
+		*sample_rate = 25;
+		break;
+	case AXP20X_ADC_TS_RATE_50Hz:
+		*sample_rate = 50;
+		break;
+	case AXP20X_ADC_TS_RATE_100Hz:
+		*sample_rate = 100;
+		break;
+	case AXP20X_ADC_TS_RATE_200Hz:
+		*sample_rate = 200;
+		break;
+	default:
+		*sample_rate = -1;
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int axp20x_battery_set_temperature_discharge_voltage_min(struct axp20x_batt_ps *axp_batt,
+								int voltage)
+{
+	int ret;
+
+	int val1 = voltage / (0x10 * 800);
+
+	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
+		return -EINVAL;
+
+	ret = regmap_update_bits(axp_batt->regmap, AXP20X_V_LTF_DISCHRG,
+				  AXP20X_TEMP_MASK, val1);
+
+	return ret;
+}
+
+static int axp20x_battery_get_temperature_discharge_voltage_min(struct axp20x_batt_ps *axp_batt,
+								int *voltage)
+{
+	int reg, ret;
+
+	ret = regmap_read(axp_batt->regmap, AXP20X_V_LTF_DISCHRG, &reg);
+	if (ret)
+		return ret;
+
+	*voltage = reg * 0x10 * 800;
+
+	return ret;
+}
+
+static int axp20x_battery_set_temperature_discharge_voltage_max(struct axp20x_batt_ps *axp_batt,
+								int voltage)
+{
+	int ret;
+
+	int val1 = voltage / (0x10 * 800);
+
+	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
+		return -EINVAL;
+
+	ret = regmap_update_bits(axp_batt->regmap, AXP20X_V_HTF_DISCHRG,
+				  AXP20X_TEMP_MASK, val1);
+
+	return ret;
+}
+
+static int axp20x_battery_get_temperature_discharge_voltage_max(struct axp20x_batt_ps *axp_batt,
+								int *voltage)
+{
+	int reg, ret;
+
+	ret = regmap_read(axp_batt->regmap, AXP20X_V_HTF_DISCHRG, &reg);
+	if (ret)
+		return ret;
+
+	*voltage = reg * 0x10 * 800;
+
+	return ret;
+}
+
+static int axp20x_battery_set_temperature_charge_voltage_min(struct axp20x_batt_ps *axp_batt,
+							     int voltage)
+{
+	int ret;
+
+	int val1 = voltage / (0x10 * 800);
+
+	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
+		return -EINVAL;
+
+	ret = regmap_update_bits(axp_batt->regmap, AXP20X_V_LTF_CHRG,
+				  AXP20X_TEMP_MASK, val1);
+
+	return ret;
+}
+
+static int axp20x_battery_get_temperature_charge_voltage_min(struct axp20x_batt_ps *axp_batt,
+							     int *voltage)
+{
+	int reg, ret;
+
+	ret = regmap_read(axp_batt->regmap, AXP20X_V_LTF_CHRG, &reg);
+	if (ret)
+		return ret;
+
+	*voltage = reg * 0x10 * 800;
+
+	return ret;
+}
+
+static int axp20x_battery_set_temperature_charge_voltage_max(struct axp20x_batt_ps *axp_batt,
+							     int voltage)
+{
+	int ret;
+
+	int val1 = voltage / (0x10 * 800);
+
+	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
+		return -EINVAL;
+
+	ret = regmap_update_bits(axp_batt->regmap, AXP20X_V_HTF_CHRG,
+				  AXP20X_TEMP_MASK, val1);
+
+	return ret;
+}
+
+static int axp20x_battery_get_temperature_charge_voltage_max(struct axp20x_batt_ps *axp_batt,
+							     int *voltage)
+{
+	int reg, ret;
+
+	ret = regmap_read(axp_batt->regmap, AXP20X_V_HTF_CHRG, &reg);
+	if (ret)
+		return ret;
+
+	*voltage = reg * 0x10 * 800;
+
+	return ret;
+}
+
+static int axp20x_battery_get_temp_sense_voltage_now(struct axp20x_batt_ps *axp_batt,
+						     int *voltage)
+{
+	int reg, ret, val1;
+
+	ret = regmap_read(axp_batt->regmap, AXP20X_TS_IN_L, &reg);
+	if (ret)
+		return ret;
+
+	val1 = reg;
+
+	ret = regmap_read(axp_batt->regmap, AXP20X_TS_IN_H, &reg);
+	if (ret)
+		return ret;
+
+	/* merging high and low value */
+	val1 = (reg << 4) | val1;
+
+	/* convert register value to real uV */
+	*voltage = val1 * 800;
+
+	return ret;
+}
+
 static int axp20x_battery_get_prop(struct power_supply *psy,
 				   enum power_supply_property psp,
 				   union power_supply_propval *val)
@@ -461,7 +909,8 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
 		return axp20x_set_voltage_min_design(axp20x_batt, val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
-		return axp20x_batt->data->set_max_voltage(axp20x_batt, val->intval);
+		return axp20x_batt->data->set_max_voltage(axp20x_batt,
+							  val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		return axp20x_set_constant_charge_current(axp20x_batt,
@@ -472,13 +921,16 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		switch (val->intval) {
 		case POWER_SUPPLY_STATUS_CHARGING:
-			return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
-				AXP20X_CHRG_CTRL1_ENABLE, AXP20X_CHRG_CTRL1_ENABLE);
+			return regmap_update_bits(axp20x_batt->regmap,
+						  AXP20X_CHRG_CTRL1,
+						  AXP20X_CHRG_CTRL1_ENABLE,
+						  AXP20X_CHRG_CTRL1_ENABLE);
 
 		case POWER_SUPPLY_STATUS_DISCHARGING:
 		case POWER_SUPPLY_STATUS_NOT_CHARGING:
-			return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
-				AXP20X_CHRG_CTRL1_ENABLE, 0);
+			return regmap_update_bits(axp20x_batt->regmap,
+						  AXP20X_CHRG_CTRL1,
+						  AXP20X_CHRG_CTRL1_ENABLE, 0);
 		}
 		fallthrough;
 	default:
@@ -510,6 +962,275 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
 }
 
+/* -- Custom attributes ----------------------------------------------------- */
+
+static ssize_t voltage_low_alert_level1_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	int status;
+
+	int voltage_alert;
+
+	axp20x_battery_get_voltage_low_alert1(axp20x_batt, &voltage_alert);
+	status = sprintf(buf, "%d\n", voltage_alert);
+
+	return status;
+}
+
+static ssize_t voltage_low_alert_level1_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	unsigned long value;
+	int status;
+
+	status = kstrtoul(buf, 0, &value);
+	if (status)
+		return status;
+
+	status = axp20x_battery_set_voltage_low_alert1(axp20x_batt, value);
+	if (status)
+		return status;
+
+	return count;
+}
+
+DEVICE_ATTR_RW(voltage_low_alert_level1);
+
+static ssize_t voltage_low_alert_level2_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	int status;
+
+	int voltage_alert;
+
+	axp20x_battery_get_voltage_low_alert2(axp20x_batt, &voltage_alert);
+	status = sprintf(buf, "%d\n", voltage_alert);
+
+	return status;
+}
+
+static ssize_t voltage_low_alert_level2_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	unsigned long value;
+	int status;
+
+	status = kstrtoul(buf, 0, &value);
+	if (status)
+		return status;
+
+	status = axp20x_battery_set_voltage_low_alert2(axp20x_batt, value);
+	if (status)
+		return status;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(voltage_low_alert_level2);
+
+static ssize_t ocv_curve_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	int status, ret, reg, i;
+
+	int ocv_curve_size = AXP20X_OCV_MAX+1;
+	struct power_supply_battery_ocv_table ocv_curve[AXP20X_OCV_MAX+1];
+
+
+	status = 0;
+	for (i = 0; i < ocv_curve_size; i++) {
+		ret = regmap_read(axp20x_batt->regmap, AXP20X_OCV(i), &reg);
+		if (ret)
+			status = ret;
+		ocv_curve[i].capacity = reg;
+		ocv_curve[i].ocv = axp20x_ocv_values_uV[i];
+	}
+
+	if (status)
+		return status;
+
+	status = 0;
+	for (i = 0; i < ocv_curve_size; i++) {
+		ret = sprintf(buf, "%sOCV_%d=%d\nCAP_%d=%d\n", buf, i,
+			      ocv_curve[i].ocv, i, ocv_curve[i].capacity);
+		if (ret)
+			status = ret;
+	}
+
+	return status;
+}
+
+static DEVICE_ATTR_RO(ocv_curve);
+
+static ssize_t temperature_sense_current_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	int status;
+
+	int sense_current;
+
+	axp20x_battery_get_temperature_sense_current(axp20x_batt, &sense_current);
+	status = sprintf(buf, "%d\n", sense_current);
+
+	return status;
+}
+
+static ssize_t temperature_sense_current_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	unsigned long value;
+	int status;
+
+	status = kstrtoul(buf, 0, &value);
+	if (status)
+		return status;
+
+	status = axp20x_battery_set_temperature_sense_current(axp20x_batt, value);
+	if (status)
+		return status;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(temperature_sense_current);
+
+static ssize_t temperature_sense_rate_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	int status;
+
+	int sense_rate;
+
+	axp20x_battery_get_temperature_sense_rate(axp20x_batt, &sense_rate);
+	status = sprintf(buf, "%d\n", sense_rate);
+
+	return status;
+}
+
+static ssize_t temperature_sense_rate_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	unsigned long value;
+	int status;
+
+	status = kstrtoul(buf, 0, &value);
+	if (status)
+		return status;
+
+	status = axp20x_battery_set_temperature_sense_rate(axp20x_batt, value);
+	if (status)
+		return status;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(temperature_sense_rate);
+
+static ssize_t temperature_sense_voltage_now_show(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	int status;
+
+	int voltage;
+
+	axp20x_battery_get_temp_sense_voltage_now(axp20x_batt, &voltage);
+	status = sprintf(buf, "%d\n", voltage);
+
+	return status;
+}
+
+static DEVICE_ATTR_RO(temperature_sense_voltage_now);
+
+static ssize_t temperature_discharge_threshold_voltage_range_show(struct device *dev,
+								  struct device_attribute *attr,
+								  char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	int status;
+
+	int min_voltage, max_voltage;
+
+	axp20x_battery_get_temperature_discharge_voltage_min(axp20x_batt,
+							     &min_voltage);
+	axp20x_battery_get_temperature_discharge_voltage_max(axp20x_batt,
+							     &max_voltage);
+
+	status = sprintf(buf, "MIN=%d\nMAX=%d\n", min_voltage, max_voltage);
+
+	return status;
+}
+
+static DEVICE_ATTR_RO(temperature_discharge_threshold_voltage_range);
+
+static ssize_t temperature_charge_threshold_voltage_range_show(struct device *dev,
+							       struct device_attribute *attr,
+							       char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	int status;
+
+	int min_voltage, max_voltage;
+
+	axp20x_battery_get_temperature_charge_voltage_min(axp20x_batt,
+							  &min_voltage);
+	axp20x_battery_get_temperature_charge_voltage_max(axp20x_batt,
+							  &max_voltage);
+
+	status = sprintf(buf, "MIN=%d\nMAX=%d\n", min_voltage, max_voltage);
+
+	return status;
+}
+
+static DEVICE_ATTR_RO(temperature_charge_threshold_voltage_range);
+
+static struct attribute *axp20x_batt_attrs[] = {
+	&dev_attr_voltage_low_alert_level1.attr,
+	&dev_attr_voltage_low_alert_level2.attr,
+	&dev_attr_ocv_curve.attr,
+	&dev_attr_temperature_sense_current.attr,
+	&dev_attr_temperature_sense_rate.attr,
+	&dev_attr_temperature_sense_voltage_now.attr,
+	&dev_attr_temperature_discharge_threshold_voltage_range.attr,
+	&dev_attr_temperature_charge_threshold_voltage_range.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(axp20x_batt);
+
+/* -- Custom attributes END ------------------------------------------------- */
+
 static const struct power_supply_desc axp20x_batt_ps_desc = {
 	.name = "axp20x-battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
@@ -520,6 +1241,9 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 	.set_property = axp20x_battery_set_prop,
 };
 
+static const char * const irq_names[] = { "BATT_PLUGIN", "BATT_REMOVAL", "CHARG",
+					  "CHARG_DONE", NULL };
+
 static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
@@ -559,10 +1283,12 @@ MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
 
 static int axp20x_power_probe(struct platform_device *pdev)
 {
+	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct axp20x_batt_ps *axp20x_batt;
 	struct power_supply_config psy_cfg = {};
 	struct power_supply_battery_info info;
 	struct device *dev = &pdev->dev;
+	int i, irq, ret = 0;
 
 	if (!of_device_is_available(pdev->dev.of_node))
 		return -ENODEV;
@@ -602,6 +1328,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 
 	psy_cfg.drv_data = axp20x_batt;
 	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.attr_grp = axp20x_batt_groups;
 
 	axp20x_batt->data = (struct axp_data *)of_device_get_match_data(dev);
 
@@ -615,14 +1342,105 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	}
 
 	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
+		struct device_node *battery_np;
+
 		int vmin = info.voltage_min_design_uv;
+		int vmax = info.voltage_max_design_uv;
 		int ccc = info.constant_charge_current_max_ua;
+		struct power_supply_battery_ocv_table ocv_table[AXP20X_OCV_MAX+1];
+		int ocv_table_size = 0;
+		int lvl1 = 0;
+		int lvl2 = 0;
+		int temp_sense_current = 0;
+		int temp_sense_rate = 0;
+		int temp_discharge_min = -1;
+		int temp_discharge_max = -1;
+		int temp_charge_min = -1;
+		int temp_charge_max = -1;
+
+		int i = 0, j = 0;
+		bool too_many_ocv_tables = false;
+		bool too_many_ocv_values = false;
+		bool ocv_values_mismatch = false;
+
+		battery_np = of_parse_phandle(axp20x_batt->batt->of_node,
+					      "monitored-battery", 0);
+
+		of_property_read_u32(battery_np, "low-voltage-level1-microvolt",
+				     &lvl1);
+		of_property_read_u32(battery_np, "low-voltage-level2-microvolt",
+				     &lvl2);
+		of_property_read_u32(battery_np, "temperature-sense-current-microamp",
+				     &temp_sense_current);
+		of_property_read_u32(battery_np, "temperature-sense-rate-hertz",
+				     &temp_sense_rate);
+
+		of_property_read_u32_index(battery_np, "temperature-discharge-range-microvolt",
+					   0, &temp_discharge_min);
+		of_property_read_u32_index(battery_np, "temperature-discharge-range-microvolt",
+					   1, &temp_discharge_max);
+
+		of_property_read_u32_index(battery_np, "temperature-charge-range-microvolt",
+					   0, &temp_charge_min);
+		of_property_read_u32_index(battery_np, "temperature-charge-range-microvolt",
+					   1, &temp_charge_max);
 
 		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
 							      vmin))
 			dev_err(&pdev->dev,
 				"couldn't set voltage_min_design\n");
 
+		if (vmax > 0 && axp20x_battery_set_max_voltage(axp20x_batt,
+							       vmax))
+			dev_err(&pdev->dev,
+				"couldn't set voltage_max_design\n");
+
+		if (lvl1 > 0 && axp20x_battery_set_voltage_low_alert1(axp20x_batt,
+								      lvl1))
+			dev_err(&pdev->dev,
+				"couldn't set voltage_low_alert_level1\n");
+
+		if (lvl2 > 0 && axp20x_battery_set_voltage_low_alert2(axp20x_batt,
+								      lvl2))
+			dev_err(&pdev->dev,
+				"couldn't set voltage_low_alert_level2\n");
+
+		if (temp_sense_current > 0 &&
+		    axp20x_battery_set_temperature_sense_current(axp20x_batt,
+								 temp_sense_current))
+			dev_err(&pdev->dev,
+				"couldn't set temperature_sense_current\n");
+
+		if (temp_sense_rate > 0 &&
+		    axp20x_battery_set_temperature_sense_rate(axp20x_batt,
+							      temp_sense_rate))
+			dev_err(&pdev->dev,
+				"couldn't set temperature_sense_rate\n");
+
+		if (temp_discharge_min >= 0 &&
+		    axp20x_battery_set_temperature_discharge_voltage_min(axp20x_batt,
+									 temp_discharge_min))
+			dev_err(&pdev->dev,
+				"couldn't set temperature_sense_rate\n");
+
+		if (temp_discharge_max >= 0 &&
+		    axp20x_battery_set_temperature_discharge_voltage_max(axp20x_batt,
+									 temp_discharge_max))
+			dev_err(&pdev->dev,
+				"couldn't set temperature_sense_rate\n");
+
+		if (temp_charge_min >= 0 &&
+		    axp20x_battery_set_temperature_charge_voltage_min(axp20x_batt,
+								      temp_charge_min))
+			dev_err(&pdev->dev,
+				"couldn't set temperature_sense_rate\n");
+
+		if (temp_charge_max >= 0 &&
+		    axp20x_battery_set_temperature_charge_voltage_max(axp20x_batt,
+								      temp_charge_max))
+			dev_err(&pdev->dev,
+				"couldn't set temperature_sense_rate\n");
+
 		/* Set max to unverified value to be able to set CCC */
 		axp20x_batt->max_ccc = ccc;
 
@@ -634,6 +1452,57 @@ static int axp20x_power_probe(struct platform_device *pdev)
 			axp20x_batt->max_ccc = ccc;
 			axp20x_set_constant_charge_current(axp20x_batt, ccc);
 		}
+
+		too_many_ocv_tables = false;
+		too_many_ocv_values = false;
+		ocv_values_mismatch = false;
+		for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
+			if (info.ocv_table_size[i] == -EINVAL ||
+			   info.ocv_temp[i] == -EINVAL ||
+			   info.ocv_table[i] == NULL)
+				continue;
+
+			if (info.ocv_table_size[i] > (AXP20X_OCV_MAX+1)) {
+				too_many_ocv_values = true;
+				dev_err(&pdev->dev, "Too many values in ocv table, only %d values are supported",
+					AXP20X_OCV_MAX + 1);
+				break;
+			}
+
+			if (i > 0) {
+				too_many_ocv_tables = true;
+				dev_err(&pdev->dev, "Only one ocv table is supported");
+				break;
+			}
+
+			for (j = 0; j < info.ocv_table_size[i]; j++) {
+				if (info.ocv_table[i][j].ocv != axp20x_ocv_values_uV[j]) {
+					ocv_values_mismatch = true;
+					break;
+				}
+			}
+
+			if (ocv_values_mismatch) {
+				dev_err(&pdev->dev, "ocv tables missmatches requirements");
+				dev_info(&pdev->dev, "ocv table requires following ocv values in that order:");
+				for (j = 0; j < AXP20X_OCV_MAX+1; j++) {
+					dev_info(&pdev->dev, "%d uV",
+						 axp20x_ocv_values_uV[j]);
+				}
+				break;
+			}
+
+			ocv_table_size = info.ocv_table_size[i];
+			for (j = 0; j < info.ocv_table_size[i]; j++)
+				ocv_table[j] = info.ocv_table[i][j];
+
+		}
+
+		if (!too_many_ocv_tables && !too_many_ocv_values &&
+		    !ocv_values_mismatch)
+			axp20x_battery_set_ocv_table(axp20x_batt, ocv_table,
+						     ocv_table_size);
+
 	}
 
 	/*
@@ -643,13 +1512,70 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	axp20x_get_constant_charge_current(axp20x_batt,
 					   &axp20x_batt->max_ccc);
 
+	/* Request irqs after registering, as irqs may trigger immediately */
+	for (i = 0; irq_names[i]; i++) {
+		irq = platform_get_irq_byname(pdev, irq_names[i]);
+		if (irq < 0) {
+			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
+				 irq_names[i], irq);
+			continue;
+		}
+		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
+		ret = devm_request_any_context_irq(&pdev->dev, irq,
+						   axp20x_battery_power_irq, 0,
+						   DRVNAME, axp20x_batt);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
+				 irq_names[i], ret);
+	}
+
+	irq = platform_get_irq_byname(pdev, "LOW_PWR_LVL1");
+	irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
+	ret = devm_request_any_context_irq(&pdev->dev, irq,
+					   axp20x_battery_low_voltage_alert1_irq,
+					   0, DRVNAME, axp20x_batt);
+
+	if (ret < 0)
+		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_LOW_PWR_LVL1 IRQ: %d\n",
+			 ret);
+
+	irq = platform_get_irq_byname(pdev, "LOW_PWR_LVL2");
+	irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
+	ret = devm_request_any_context_irq(&pdev->dev, irq,
+					   axp20x_battery_low_voltage_alert2_irq,
+					   0, DRVNAME, axp20x_batt);
+
+	if (ret < 0)
+		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_LOW_PWR_LVL2 IRQ: %d\n",
+			 ret);
+
+	irq = platform_get_irq_byname(pdev, "BATT_TEMP_LOW");
+	irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
+	ret = devm_request_any_context_irq(&pdev->dev, irq,
+					   axp20x_battery_temperature_low_irq,
+					   0, DRVNAME, axp20x_batt);
+
+	if (ret < 0)
+		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_BATT_TEMP_LOW IRQ: %d\n",
+			 ret);
+
+	irq = platform_get_irq_byname(pdev, "BATT_TEMP_HIGH");
+	irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
+	ret = devm_request_any_context_irq(&pdev->dev, irq,
+					   axp20x_battery_temperature_high_irq,
+					   0, DRVNAME, axp20x_batt);
+
+	if (ret < 0)
+		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_BATT_TEMP_HIGH IRQ: %d\n",
+			 ret);
+
 	return 0;
 }
 
 static struct platform_driver axp20x_batt_driver = {
 	.probe    = axp20x_power_probe,
 	.driver   = {
-		.name  = "axp20x-battery-power-supply",
+		.name  = DRVNAME,
 		.of_match_table = axp20x_battery_ps_id,
 	},
 };
-- 
2.25.1

