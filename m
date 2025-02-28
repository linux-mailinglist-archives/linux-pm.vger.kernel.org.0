Return-Path: <linux-pm+bounces-23199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59287A4A3B9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FED19C12CD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 20:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19B27FE90;
	Fri, 28 Feb 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="avybDTxm"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7327FE63;
	Fri, 28 Feb 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773275; cv=pass; b=mhbt/VG186m2E0Re5WYLkZrCqA2bThGmYhvHxArHpJEE74aaLfaSrBhJgcAIzxup/7eGu4Ox/vWfaeX1W7snbuF1nTMEEckAIcG2O/lwDjWg1tU985rIwUI5VclaJI6Gt//SWyTevs7GNxHgjYLMXJxVv9qOLNvG9iSascnSOsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773275; c=relaxed/simple;
	bh=r4xP4ZHPuwUJBYdSuLGVqcA8m40ukymHF025NZlivkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWAVM/kfkJM4X4XCNb9ZJ0dS7aRsYz3tgQjGBF9KpeQv7cTVH4u7RTMqz1No/UOwu0qsUmTcu53tNE+dQYODy4ID80Ux7KpHIS+LmC2x10Ni3/JVQLN/t+Fb7UlgwQ7khQApD59OdlfjcgX3DX9qJsxIztfXGb410xl7ldxOhcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=avybDTxm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740773254; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dZjTvIUzJ6Op/YEGPvjp5OMKVnWIsDLQPpH/ldDtzG3zGJboJHXvpwBCdFgEGHZ8E6IN3yTKTOVKhZ2xYtWu/QMeuup/X+r96n94X3rMJVK1U3dA8klZdAR/b8H4scFVtsRjy1V5PmdO2qaqia4hgowjGhwfW/8MXvK1LAczz6o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740773254; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2SOERDO8KDpCBQ69jB2lh1eDVl6DUgQ1HkSLtL1Yc8s=; 
	b=CwrkZLEN4HgVIwwsFkkYlDleQirhc7CP35M+MqhlQf7irqkhTSCwAfq2Vwbi8RrxEag4FORf5i5+fb9O8JQHYs2r0bP0DDYCZEPLy0xR/NxLb9qPKVOAoKMbwi0NjvTgmqCi4NjdrrOhls2oIADGUJAsI6gzsf90TcnHpPgXptQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740773254;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=2SOERDO8KDpCBQ69jB2lh1eDVl6DUgQ1HkSLtL1Yc8s=;
	b=avybDTxmoFTg9Ioih7bgwjNS+xxpsux/3p4Qn8bV1whWAuhe2L8+PkyAPzeVrhqe
	2e0IeeJ6ZImpRRhMMEgQ4mTlQ3bpBaWDQCj0Ap99rRCt5rfyozfRxhy42UKcKzwj+6X
	22zg4C0e1+JAs1QGkENESs6LDtF2lGSTqIoXLLCo=
Received: by mx.zohomail.com with SMTPS id 1740773253247589.8429112117;
	Fri, 28 Feb 2025 12:07:33 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 28 Feb 2025 21:06:56 +0100
Subject: [PATCH v3 6/6] thermal: rockchip: support reading trim values from
 OTP
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rk3576-tsadc-upstream-v3-6-4bfbb3b699b9@collabora.com>
References: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
In-Reply-To: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Many of the Rockchip SoCs support storing trim values for the sensors in
factory programmable memory. These values specify a fixed offset from
the sensor's returned temperature to get a more accurate picture of what
temperature the silicon is actually at.

The way this is implemented is with various OTP cells, which may be
absent. There may both be whole-TSADC trim values, as well as per-sensor
trim values.

In the downstream driver, whole-chip trim values override the per-sensor
trim values. This rewrite of the functionality changes the semantics to
something I see as slightly more useful: allow the whole-chip trim
values to serve as a fallback for lacking per-sensor trim values,
instead of overriding already present sensor trim values.

Additionally, the chip may specify an offset (trim_base, trim_base_frac)
in degrees celsius and degrees decicelsius respectively which defines
what the basis is from which the trim, if any, should be calculated
from. By default, this is 30 degrees Celsius, but the chip can once
again specify a different value through OTP cells.

The implementation of these trim calculations have been tested
extensively on an RK3576, where it was confirmed to get rid of pesky 1.8
degree Celsius offsets between certain sensors.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 221 +++++++++++++++++++++++++++++++++----
 1 file changed, 202 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index bec1930bebd87859a7e519cfc9f05e10b1c31e87..4868ea90237ed8c33666a15c08499024120c79d7 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -69,16 +70,18 @@ struct chip_tsadc_table {
  * struct rockchip_tsadc_chip - hold the private data of tsadc chip
  * @chn_offset: the channel offset of the first channel
  * @chn_num: the channel number of tsadc chip
- * @tshut_temp: the hardware-controlled shutdown temperature value
+ * @trim_slope: used to convert the trim code to a temperature in millicelsius
+ * @tshut_temp: the hardware-controlled shutdown temperature value, with no trim
  * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
  * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
  * @initialize: SoC special initialize tsadc controller method
  * @irq_ack: clear the interrupt
  * @control: enable/disable method for the tsadc controller
- * @get_temp: get the temperature
+ * @get_temp: get the raw temperature, unadjusted by trim
  * @set_alarm_temp: set the high temperature interrupt
  * @set_tshut_temp: set the hardware-controlled shutdown temperature
  * @set_tshut_mode: set the hardware-controlled shutdown mode
+ * @get_trim_code: convert a hardware temperature code to one adjusted for by trim
  * @table: the chip-specific conversion table
  */
 struct rockchip_tsadc_chip {
@@ -86,6 +89,9 @@ struct rockchip_tsadc_chip {
 	int chn_offset;
 	int chn_num;
 
+	/* Used to convert trim code to trim temp */
+	int trim_slope;
+
 	/* The hardware-controlled tshut property */
 	int tshut_temp;
 	enum tshut_mode tshut_mode;
@@ -105,6 +111,8 @@ struct rockchip_tsadc_chip {
 	int (*set_tshut_temp)(const struct chip_tsadc_table *table,
 			      int chn, void __iomem *reg, int temp);
 	void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mode m);
+	int (*get_trim_code)(const struct chip_tsadc_table *table,
+			     int code, int trim_base, int trim_base_frac);
 
 	/* Per-table methods */
 	struct chip_tsadc_table table;
@@ -114,12 +122,16 @@ struct rockchip_tsadc_chip {
  * struct rockchip_thermal_sensor - hold the information of thermal sensor
  * @thermal:  pointer to the platform/configuration data
  * @tzd: pointer to a thermal zone
+ * @of_node: pointer to the device_node representing this sensor, if any
  * @id: identifier of the thermal sensor
+ * @trim_temp: per-sensor trim temperature value
  */
 struct rockchip_thermal_sensor {
 	struct rockchip_thermal_data *thermal;
 	struct thermal_zone_device *tzd;
+	struct device_node *of_node;
 	int id;
+	int trim_temp;
 };
 
 /**
@@ -132,7 +144,11 @@ struct rockchip_thermal_sensor {
  * @pclk: the advanced peripherals bus clock
  * @grf: the general register file will be used to do static set by software
  * @regs: the base address of tsadc controller
- * @tshut_temp: the hardware-controlled shutdown temperature value
+ * @trim_base: major component of sensor trim value, in Celsius
+ * @trim_base_frac: minor component of sensor trim value, in Decicelsius
+ * @trim: fallback thermal trim value for each channel
+ * @tshut_temp: the hardware-controlled shutdown temperature value, with no trim
+ * @trim_temp: the fallback trim temperature for the whole sensor
  * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
  * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
  */
@@ -149,7 +165,12 @@ struct rockchip_thermal_data {
 	struct regmap *grf;
 	void __iomem *regs;
 
+	int trim_base;
+	int trim_base_frac;
+	int trim;
+
 	int tshut_temp;
+	int trim_temp;
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
 };
@@ -249,6 +270,9 @@ struct rockchip_thermal_data {
 
 #define GRF_CON_TSADC_CH_INV			(0x10001 << 1)
 
+
+#define RK_MAX_TEMP				(180000)
+
 /**
  * struct tsadc_table - code to temperature conversion table
  * @code: the value of adc channel
@@ -1077,6 +1101,15 @@ static void rk_tsadcv4_tshut_mode(int chn, void __iomem *regs,
 	writel_relaxed(val_cru, regs + TSADCV3_HSHUT_CRU_INT_EN);
 }
 
+static int rk_tsadcv2_get_trim_code(const struct chip_tsadc_table *table,
+				    int code, int trim_base, int trim_base_frac)
+{
+	int temp = trim_base * 1000 + trim_base_frac * 100;
+	u32 base_code = rk_tsadcv2_temp_to_code(table, temp);
+
+	return code - base_code;
+}
+
 static const struct rockchip_tsadc_chip px30_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 0,
@@ -1314,6 +1347,8 @@ static const struct rockchip_tsadc_chip rk3576_tsadc_data = {
 	.set_alarm_temp = rk_tsadcv3_alarm_temp,
 	.set_tshut_temp = rk_tsadcv3_tshut_temp,
 	.set_tshut_mode = rk_tsadcv4_tshut_mode,
+	.get_trim_code = rk_tsadcv2_get_trim_code,
+	.trim_slope = 923,
 	.table = {
 		.id = rk3588_code_table,
 		.length = ARRAY_SIZE(rk3588_code_table),
@@ -1429,7 +1464,7 @@ static int rockchip_thermal_set_trips(struct thermal_zone_device *tz, int low, i
 		__func__, sensor->id, low, high);
 
 	return tsadc->set_alarm_temp(&tsadc->table,
-				     sensor->id, thermal->regs, high);
+				     sensor->id, thermal->regs, high + sensor->trim_temp);
 }
 
 static int rockchip_thermal_get_temp(struct thermal_zone_device *tz, int *out_temp)
@@ -1441,6 +1476,8 @@ static int rockchip_thermal_get_temp(struct thermal_zone_device *tz, int *out_te
 
 	retval = tsadc->get_temp(&tsadc->table,
 				 sensor->id, thermal->regs, out_temp);
+	*out_temp -= sensor->trim_temp;
+
 	return retval;
 }
 
@@ -1449,6 +1486,104 @@ static const struct thermal_zone_device_ops rockchip_of_thermal_ops = {
 	.set_trips = rockchip_thermal_set_trips,
 };
 
+/**
+ * rockchip_get_efuse_value - read an OTP cell from a device node
+ * @np: pointer to the device node with the nvmem-cells property
+ * @cell_name: name of cell that should be read
+ * @value: pointer to where the read value will be placed
+ *
+ * Return: Negative errno on failure, during which *value will not be touched,
+ * or 0 on success.
+ */
+static int rockchip_get_efuse_value(struct device_node *np, const char *cell_name,
+				    int *value)
+{
+	struct nvmem_cell *cell;
+	int ret = 0;
+	size_t len;
+	u8 *buf;
+	int i;
+
+	cell = of_nvmem_cell_get(np, cell_name);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (len > sizeof(*value)) {
+		ret = -ERANGE;
+		goto exit;
+	}
+
+	/* Copy with implicit endian conversion */
+	*value = 0;
+	for (i = 0; i < len; i++)
+		*value |= (int) buf[i] << (8 * i);
+
+exit:
+	kfree(buf);
+	return ret;
+}
+
+static int rockchip_get_trim_configuration(struct device *dev, struct device_node *np,
+					   struct rockchip_thermal_data *thermal)
+{
+	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
+	int trim_base = 0, trim_base_frac = 0, trim = 0;
+	int trim_code;
+	int ret;
+
+	thermal->trim_base = 0;
+	thermal->trim_base_frac = 0;
+	thermal->trim = 0;
+
+	if (!tsadc->get_trim_code)
+		return 0;
+
+	ret = rockchip_get_efuse_value(np, "trim_base", &trim_base);
+	if (ret < 0) {
+		if (ret == -ENOENT) {
+			trim_base = 30;
+			dev_dbg(dev, "trim_base is absent, defaulting to 30\n");
+		} else {
+			dev_err(dev, "failed reading nvmem value of trim_base: %pe\n",
+				ERR_PTR(ret));
+			return ret;
+		}
+	}
+	ret = rockchip_get_efuse_value(np, "trim_base_frac", &trim_base_frac);
+	if (ret < 0) {
+		if (ret == -ENOENT) {
+			dev_dbg(dev, "trim_base_frac is absent, defaulting to 0\n");
+		} else {
+			dev_err(dev, "failed reading nvmem value of trim_base_frac: %pe\n",
+				ERR_PTR(ret));
+			return ret;
+		}
+	}
+	thermal->trim_base = trim_base;
+	thermal->trim_base_frac = trim_base_frac;
+
+	/*
+	 * If the tsadc node contains the trim property, then it is used in the
+	 * absence of per-channel trim values
+	 */
+	if (!rockchip_get_efuse_value(np, "trim", &trim))
+		thermal->trim = trim;
+	if (trim) {
+		trim_code = tsadc->get_trim_code(&tsadc->table, trim,
+						 trim_base, trim_base_frac);
+		thermal->trim_temp = thermal->chip->trim_slope * trim_code;
+	}
+
+	return 0;
+}
+
 static int rockchip_configure_from_dt(struct device *dev,
 				      struct device_node *np,
 				      struct rockchip_thermal_data *thermal)
@@ -1509,6 +1644,8 @@ static int rockchip_configure_from_dt(struct device *dev,
 	if (IS_ERR(thermal->grf))
 		dev_warn(dev, "Missing rockchip,grf property\n");
 
+	rockchip_get_trim_configuration(dev, np, thermal);
+
 	return 0;
 }
 
@@ -1519,23 +1656,50 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 				 int id)
 {
 	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
+	struct device *dev = &pdev->dev;
+	int trim = thermal->trim;
+	int trim_code, tshut_temp;
+	int trim_temp = 0;
 	int error;
 
+	if (thermal->trim_temp)
+		trim_temp = thermal->trim_temp;
+
+	if (tsadc->get_trim_code && sensor->of_node) {
+		error = rockchip_get_efuse_value(sensor->of_node, "trim", &trim);
+		if (error < 0 && error != -ENOENT) {
+			dev_err(dev, "failed reading trim of sensor %d: %pe\n",
+				id, ERR_PTR(error));
+			return error;
+		}
+		if (trim) {
+			trim_code = tsadc->get_trim_code(&tsadc->table, trim,
+							 thermal->trim_base,
+							 thermal->trim_base_frac);
+			trim_temp = thermal->chip->trim_slope * trim_code;
+		}
+	}
+
+	sensor->trim_temp = trim_temp;
+
+	dev_dbg(dev, "trim of sensor %d is %d\n", id, sensor->trim_temp);
+
+	tshut_temp = min(thermal->tshut_temp + sensor->trim_temp, RK_MAX_TEMP);
+
 	tsadc->set_tshut_mode(id, thermal->regs, thermal->tshut_mode);
 
-	error = tsadc->set_tshut_temp(&tsadc->table, id, thermal->regs,
-			      thermal->tshut_temp);
+	error = tsadc->set_tshut_temp(&tsadc->table, id, thermal->regs, tshut_temp);
 	if (error)
-		dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
-			__func__, thermal->tshut_temp, error);
+		dev_err(dev, "%s: invalid tshut=%d, error=%d\n",
+			__func__, tshut_temp, error);
 
 	sensor->thermal = thermal;
 	sensor->id = id;
-	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev, id, sensor,
+	sensor->tzd = devm_thermal_of_zone_register(dev, id, sensor,
 						    &rockchip_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		error = PTR_ERR(sensor->tzd);
-		dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
+		dev_err(dev, "failed to register sensor %d: %d\n",
 			id, error);
 		return error;
 	}
@@ -1558,9 +1722,11 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct rockchip_thermal_data *thermal;
+	struct device_node *child;
 	int irq;
 	int i;
 	int error;
+	u32 chn;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -1611,6 +1777,18 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	thermal->chip->initialize(thermal->grf, thermal->regs,
 				  thermal->tshut_polarity);
 
+	for_each_available_child_of_node(np, child) {
+		if (!of_property_read_u32(child, "reg", &chn)) {
+			if (chn < thermal->chip->chn_num)
+				thermal->sensors[chn].of_node = child;
+			else
+				dev_warn(&pdev->dev,
+					 "sensor address (%d) too large, ignoring its trim\n",
+					 chn);
+		}
+
+	}
+
 	for (i = 0; i < thermal->chip->chn_num; i++) {
 		error = rockchip_thermal_register_sensor(pdev, thermal,
 						&thermal->sensors[i],
@@ -1680,8 +1858,11 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 {
 	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
-	int i;
+	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
+	struct rockchip_thermal_sensor *sensor;
+	int tshut_temp;
 	int error;
+	int i;
 
 	error = clk_enable(thermal->clk);
 	if (error)
@@ -1695,21 +1876,23 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 
 	rockchip_thermal_reset_controller(thermal->reset);
 
-	thermal->chip->initialize(thermal->grf, thermal->regs,
-				  thermal->tshut_polarity);
+	tsadc->initialize(thermal->grf, thermal->regs, thermal->tshut_polarity);
 
 	for (i = 0; i < thermal->chip->chn_num; i++) {
-		int id = thermal->sensors[i].id;
+		sensor = &thermal->sensors[i];
+
+		tshut_temp = min(thermal->tshut_temp + sensor->trim_temp,
+				 RK_MAX_TEMP);
 
-		thermal->chip->set_tshut_mode(id, thermal->regs,
+		tsadc->set_tshut_mode(sensor->id, thermal->regs,
 					      thermal->tshut_mode);
 
-		error = thermal->chip->set_tshut_temp(&thermal->chip->table,
-					      id, thermal->regs,
-					      thermal->tshut_temp);
+		error = tsadc->set_tshut_temp(&thermal->chip->table,
+					      sensor->id, thermal->regs,
+					      tshut_temp);
 		if (error)
 			dev_err(dev, "%s: invalid tshut=%d, error=%d\n",
-				__func__, thermal->tshut_temp, error);
+				__func__, tshut_temp, error);
 	}
 
 	thermal->chip->control(thermal->regs, true);

-- 
2.48.1


