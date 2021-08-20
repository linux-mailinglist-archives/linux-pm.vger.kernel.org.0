Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B773F2983
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhHTJwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 05:52:55 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41350 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234846AbhHTJwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Aug 2021 05:52:55 -0400
X-UUID: 3f5f9730bdee4972bf3ff86d8e040e4d-20210820
X-UUID: 3f5f9730bdee4972bf3ff86d8e040e4d-20210820
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ben.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1220063913; Fri, 20 Aug 2021 17:52:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 Aug 2021 17:52:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Aug 2021 17:52:12 +0800
From:   Ben Tseng <ben.tseng@mediatek.com>
To:     Fan Chen <fan.chen@mediatek.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Ben Tseng <ben.tseng@mediatek.com>
Subject: [PATCH v9] thermal: mediatek: add another get_temp ops for thermal sensors
Date:   Fri, 20 Aug 2021 17:52:06 +0800
Message-ID: <20210820095206.30981-1-ben.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

Provide thermal zone to read thermal sensor
in the SoC. We can read all the thermal sensors
value in the SoC by the node /sys/class/thermal/

In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
on the first read of sensor that often are bogus values.
This can avoid following warning on boot:

  thermal thermal_zone6: failed to read out thermal zone (-13)

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
---

This patchset supports for MT8183 chip to mtk_thermal.c.
Add thermal zone of all the thermal sensor in SoC for
another get temperatrue. They don't need to thermal throttle.
And we bind coolers for thermal zone nodes of cpu_thermal.

Changes in V9:
    - Rebase to kernel-v5.14-rc1
    - Bind raw_to_mcelsius_v1 or raw_to_mcelsius_v2 to compatible
      data of struct mtk_thermal_data
    - Remove duplicate struct 'mtk_thermal_bank'
    - Remove unnecessary if condition check
    - Return error if any thermal zone fail to register

Changes in V8:
    - Rebase to kernel-v5.13-rc1
    - Resend

Changes in v7:
    - Fix build error in v6.

Changes in v6:
    - Rebase to kernel-5.11-rc1.
    - [1/3]
        - add interrupts property.
    - [2/3]
        - add the Tested-by in the commit message.
    - [3/3]
        - use the mt->conf->msr[id] instead of conf->msr[id] in the
          _get_sensor_temp and mtk_thermal_bank_temperature.
        - remove the redundant space in _get_sensor_temp and
          mtk_read_sensor_temp.
        - change kmalloc to dev_kmalloc in mtk_thermal_probe.

Changes in v5:
    - Rebase to kernel-5.9-rc1.
    - Revise the title of cover letter.
    - Drop "[v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESEL"
    - [2/2]
        -  Add the judgement to the version of raw_to_mcelsius.

Changes in v4:
    - Rebase to kernel-5.6-rc1.
    - [1/7]
        - Squash thermal zone settings in the dtsi from [v3,5/8]
          arm64: dts: mt8183: Increase polling frequency for CPU thermal zone.
        - Remove the property of interrupts and mediatek,hw-reset-temp.
    - [2/7]
        - Correct commit message.
    - [4/7]
        - Change the target temperature to the 80C and change the commit message.
    - [6/7]
        - Adjust newline alignment.
        - Fix the judgement on the return value of registering thermal zone.

Changes in v3:
    - Rebase to kernel-5.5-rc1.
    - [1/8]
        - Update sustainable power of cpu, tzts1~5 and tztsABB.
    - [7/8]
        - Bypass the failure that non cpu_thermal sensor is not find in thermal-zones
          in dts, which is normal for mt8173, so prompt a warning here instead of
          failing.

	Return -EAGAIN instead of -EACCESS on the first read of sensor that
        often are bogus values. This can avoid following warning on boot:

          thermal thermal_zone6: failed to read out thermal zone (-13)

Changes in v2:
    - [1/8]
        - Add the sustainable-power,trips,cooling-maps to the tzts1~tztsABB.
    - [4/8]
        - Add the min opp of cpu throttle.

Matthias Kaehlcke (1):
  arm64: dts: mt8183: Configure CPU cooling

Michael Kao (2):
  thermal: mediatek: add another get_temp ops for thermal sensors
  arm64: dts: mt8183: add thermal zone node
---
 drivers/thermal/mtk_thermal.c | 95 +++++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94ea..8bb0bb2 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -271,6 +271,7 @@ struct mtk_thermal_data {
 	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 	enum mtk_thermal_version version;
+	int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
 };
 
 struct mtk_thermal {
@@ -294,6 +295,9 @@ struct mtk_thermal {
 	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
 };
 
+static int raw_to_mcelsius_v1(struct mtk_thermal *mt, int sensno, s32 raw);
+static int raw_to_mcelsius_v2(struct mtk_thermal *mt, int sensno, s32 raw);
+
 /* MT8183 thermal sensor data */
 static const int mt8183_bank_data[MT8183_NUM_SENSORS] = {
 	MT8183_TS1, MT8183_TS2, MT8183_TS3, MT8183_TS4, MT8183_TS5, MT8183_TSABB
@@ -427,6 +431,7 @@ struct mtk_thermal {
 	.adcpnp = mt8173_adcpnp,
 	.sensor_mux_values = mt8173_mux_values,
 	.version = MTK_THERMAL_V1,
+	.raw_to_mcelsius = raw_to_mcelsius_v1,
 };
 
 /*
@@ -458,6 +463,7 @@ struct mtk_thermal {
 	.adcpnp = mt2701_adcpnp,
 	.sensor_mux_values = mt2701_mux_values,
 	.version = MTK_THERMAL_V1,
+	.raw_to_mcelsius = raw_to_mcelsius_v1,
 };
 
 /*
@@ -489,6 +495,7 @@ struct mtk_thermal {
 	.adcpnp = mt2712_adcpnp,
 	.sensor_mux_values = mt2712_mux_values,
 	.version = MTK_THERMAL_V1,
+	.raw_to_mcelsius = raw_to_mcelsius_v1,
 };
 
 /*
@@ -514,6 +521,7 @@ struct mtk_thermal {
 	.adcpnp = mt7622_adcpnp,
 	.sensor_mux_values = mt7622_mux_values,
 	.version = MTK_THERMAL_V2,
+	.raw_to_mcelsius = raw_to_mcelsius_v2,
 };
 
 /*
@@ -547,6 +555,7 @@ struct mtk_thermal {
 	.adcpnp = mt8183_adcpnp,
 	.sensor_mux_values = mt8183_mux_values,
 	.version = MTK_THERMAL_V1,
+	.raw_to_mcelsius = raw_to_mcelsius_v1,
 };
 
 /**
@@ -639,6 +648,27 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
 		mutex_unlock(&mt->lock);
 }
 
+static u32 _get_sensor_temp(struct mtk_thermal *mt, int id)
+{
+	u32 raw;
+	int temp;
+
+	raw = readl(mt->thermal_base + mt->conf->msr[id]);
+
+	temp = mt->conf->raw_to_mcelsius(mt, id, raw);
+
+	/*
+	 * The first read of a sensor often contains very high bogus
+	 * temperature value. Filter these out so that the system does
+	 * not immediately shut down.
+	 */
+
+	if (temp > 200000)
+		return -EAGAIN;
+	else
+		return temp;
+}
+
 /**
  * mtk_thermal_bank_temperature - get the temperature of a bank
  * @bank:	The bank
@@ -649,28 +679,11 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
 static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 {
 	struct mtk_thermal *mt = bank->mt;
-	const struct mtk_thermal_data *conf = mt->conf;
 	int i, temp = INT_MIN, max = INT_MIN;
-	u32 raw;
-
-	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
-		raw = readl(mt->thermal_base + conf->msr[i]);
 
-		if (mt->conf->version == MTK_THERMAL_V1) {
-			temp = raw_to_mcelsius_v1(
-				mt, conf->bank_data[bank->id].sensors[i], raw);
-		} else {
-			temp = raw_to_mcelsius_v2(
-				mt, conf->bank_data[bank->id].sensors[i], raw);
-		}
+	for (i = 0; i < mt->conf->bank_data[bank->id].num_sensors; i++) {
 
-		/*
-		 * The first read of a sensor often contains very high bogus
-		 * temperature value. Filter these out so that the system does
-		 * not immediately shut down.
-		 */
-		if (temp > 200000)
-			temp = 0;
+		temp = _get_sensor_temp(mt, i);
 
 		if (temp > max)
 			max = temp;
@@ -681,7 +694,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 
 static int mtk_read_temp(void *data, int *temperature)
 {
-	struct mtk_thermal *mt = data;
+	struct mtk_thermal_bank *tz = data;
+	struct mtk_thermal *mt = tz->mt;
 	int i;
 	int tempmax = INT_MIN;
 
@@ -700,10 +714,25 @@ static int mtk_read_temp(void *data, int *temperature)
 	return 0;
 }
 
+static int mtk_read_sensor_temp(void *data, int *temperature)
+{
+	struct mtk_thermal_bank *tz = data;
+	struct mtk_thermal *mt = tz->mt;
+	int id = tz->id - 1;
+
+	*temperature = _get_sensor_temp(mt, id);
+
+	return 0;
+}
+
 static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
 	.get_temp = mtk_read_temp,
 };
 
+static const struct thermal_zone_of_device_ops mtk_thermal_sensor_ops = {
+	.get_temp = mtk_read_sensor_temp,
+};
+
 static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 				  u32 apmixed_phys_base, u32 auxadc_phys_base,
 				  int ctrl_id)
@@ -994,6 +1023,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	u64 auxadc_phys_base, apmixed_phys_base;
 	struct thermal_zone_device *tzdev;
 	void __iomem *apmixed_base, *auxadc_base;
+	struct mtk_thermal_bank *tz;
 
 	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -1082,11 +1112,26 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
-						     &mtk_thermal_ops);
-	if (IS_ERR(tzdev)) {
-		ret = PTR_ERR(tzdev);
-		goto err_disable_clk_peri_therm;
+	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
+		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
+		if (!tz)
+			return -ENOMEM;
+
+		tz->mt = mt;
+		tz->id = i;
+
+		tzdev = devm_thermal_zone_of_sensor_register(
+						&pdev->dev, i, tz, (i == 0) ?
+						&mtk_thermal_ops :
+						&mtk_thermal_sensor_ops);
+
+		if (IS_ERR(tzdev)) {
+			ret = PTR_ERR(tzdev);
+			dev_err(&pdev->dev,
+				"Error: Failed to register thermal zone %d, ret = %d\n",
+				i, ret);
+			goto err_disable_clk_peri_therm;
+		}
 	}
 
 	ret = devm_thermal_add_hwmon_sysfs(tzdev);
-- 
1.8.1.1.dirty

