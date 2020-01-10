Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0307C136AD9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgAJKQn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:16:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47620 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727457AbgAJKQh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:16:37 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AADAYI031435;
        Fri, 10 Jan 2020 11:16:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=COHQnqHla3sZoJ+b3CXfSU4rWcXe80jr6g7s8OF+M4E=;
 b=IoWMUVQD6ge49dE+Qyo3oqByi2dX/IgoAlumthJsYkjPfraUk61t6ZawrE1rGACXJlF7
 pTs02XuEzyUKTobP7roawbgnQ47sT8nFs+NvlqnhAl8CKTwyOL8btxlX1/617yWkm1JW
 BJ6E/2c3CcK3fbFmkwAIhopCI3gzbzIeiSFSDygNjBiL3trXVUahH2ObnstiHT4NArBf
 A/SrE4ZjJiDdlzoN114wweXxq5sr7zQkT/hKYlFt7LcRDqVOHOV5oD7xHdhJndWJztbX
 NrDDuHEd0/nNgPH41WVOoSmOQbYXnMlFawsLxiAPFJbUT6rDf7S3OTaeCNC2NpRudUNh VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xdw8b7kvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 11:16:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6C8F9100039;
        Fri, 10 Jan 2020 11:16:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5CF2D2A7907;
        Fri, 10 Jan 2020 11:16:11 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Jan 2020 11:16:10
 +0100
From:   Pascal Paillet <p.paillet@st.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <p.paillet@st.com>, <david.hernandezsanchez@st.com>,
        <horms+renesas@verge.net.au>, <wsa+renesas@sang-engineering.com>,
        <linux-pm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH_V3 4/6] thermal: stm32: handle multiple trip points
Date:   Fri, 10 Jan 2020 11:16:03 +0100
Message-ID: <20200110101605.24984-5-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110101605.24984-1-p.paillet@st.com>
References: <20200110101605.24984-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let the thermal framework handle the trip points instead
of custom code inside the driver. This is backward compatible,
simplifies the driver and offers the possibility to the user
to set any trip point he needs.

stm_thermal_set_trips callback that is registered to
set_trips ops to handle the low and high thresholds and replaces
stm_thermal_set_threshold and stm_thermal_update_threshold functions.
modify irq enable to handle the thresholds.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 drivers/thermal/st/stm_thermal.c | 298 +++++++++----------------------
 1 file changed, 86 insertions(+), 212 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 679d38867206..29e7ee89adf6 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -61,6 +61,7 @@
 #define TS1_T0_POS		16
 #define TS1_SMP_TIME_POS	16
 #define TS1_HITTHD_POS		16
+#define TS1_LITTHD_POS		0
 #define HSREF_CLK_DIV_POS	24
 
 /* DTS_CFGR1 bit definitions */
@@ -97,43 +98,49 @@ struct stm_thermal_sensor {
 	struct thermal_zone_device *th_dev;
 	enum thermal_device_mode mode;
 	struct clk *clk;
-	int high_temp;
-	int low_temp;
-	int temp_critical;
-	int temp_passive;
 	unsigned int low_temp_enabled;
-	int num_trips;
+	unsigned int high_temp_enabled;
 	int irq;
-	unsigned int irq_enabled;
 	void __iomem *base;
 	int t0, fmt0, ramp_coeff;
 };
 
-static irqreturn_t stm_thermal_alarm_irq(int irq, void *sdata)
+static int stm_enable_irq(struct stm_thermal_sensor *sensor)
 {
-	struct stm_thermal_sensor *sensor = sdata;
+	u32 value;
 
-	disable_irq_nosync(irq);
-	sensor->irq_enabled = false;
+	dev_dbg(sensor->dev, "low:%d high:%d\n", sensor->low_temp_enabled,
+		sensor->high_temp_enabled);
+
+	/* Disable IT generation for low and high thresholds */
+	value = readl_relaxed(sensor->base + DTS_ITENR_OFFSET);
+	value &= ~(LOW_THRESHOLD | HIGH_THRESHOLD);
 
-	return IRQ_WAKE_THREAD;
+	if (sensor->low_temp_enabled)
+		value |= HIGH_THRESHOLD;
+
+	if (sensor->high_temp_enabled)
+		value |= LOW_THRESHOLD;
+
+	/* Enable interrupts */
+	writel_relaxed(value, sensor->base + DTS_ITENR_OFFSET);
+
+	return 0;
 }
 
-static irqreturn_t stm_thermal_alarm_irq_thread(int irq, void *sdata)
+static irqreturn_t stm_thermal_irq_handler(int irq, void *sdata)
 {
-	u32 value;
 	struct stm_thermal_sensor *sensor = sdata;
 
-	/* read IT reason in SR and clear flags */
-	value = readl_relaxed(sensor->base + DTS_SR_OFFSET);
+	dev_dbg(sensor->dev, "sr:%d\n",
+		readl_relaxed(sensor->base + DTS_SR_OFFSET));
 
-	if ((value & LOW_THRESHOLD) == LOW_THRESHOLD)
-		writel_relaxed(LOW_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
+	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
 
-	if ((value & HIGH_THRESHOLD) == HIGH_THRESHOLD)
-		writel_relaxed(HIGH_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
+	stm_enable_irq(sensor);
 
-	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
+	/* Acknoledge all DTS irqs */
+	writel_relaxed(ICIFR_MASK, sensor->base + DTS_ICIFR_OFFSET);
 
 	return IRQ_HANDLED;
 }
@@ -298,39 +305,6 @@ static int stm_thermal_calculate_threshold(struct stm_thermal_sensor *sensor,
 	return 0;
 }
 
-static int stm_thermal_set_threshold(struct stm_thermal_sensor *sensor)
-{
-	u32 value, th;
-	int ret;
-
-	value = readl_relaxed(sensor->base + DTS_ITR1_OFFSET);
-
-	/* Erase threshold content */
-	value &= ~(TS1_LITTHD_MASK | TS1_HITTHD_MASK);
-
-	/* Retrieve the sample threshold number th for a given temperature */
-	ret = stm_thermal_calculate_threshold(sensor, sensor->high_temp, &th);
-	if (ret)
-		return ret;
-
-	value |= th & TS1_LITTHD_MASK;
-
-	if (sensor->low_temp_enabled) {
-		/* Retrieve the sample threshold */
-		ret = stm_thermal_calculate_threshold(sensor, sensor->low_temp,
-						      &th);
-		if (ret)
-			return ret;
-
-		value |= (TS1_HITTHD_MASK  & (th << TS1_HITTHD_POS));
-	}
-
-	/* Write value on the Low interrupt threshold */
-	writel_relaxed(value, sensor->base + DTS_ITR1_OFFSET);
-
-	return 0;
-}
-
 /* Disable temperature interrupt */
 static int stm_disable_irq(struct stm_thermal_sensor *sensor)
 {
@@ -344,66 +318,48 @@ static int stm_disable_irq(struct stm_thermal_sensor *sensor)
 	return 0;
 }
 
-/* Enable temperature interrupt */
-static int stm_enable_irq(struct stm_thermal_sensor *sensor)
+static int stm_thermal_set_trips(void *data, int low, int high)
 {
-	u32 value;
+	struct stm_thermal_sensor *sensor = data;
+	u32 itr1, th;
+	int ret;
 
-	/*
-	 * Code below enables High temperature threshold using a low threshold
-	 * sampling value
-	 */
+	dev_dbg(sensor->dev, "set trips %d <--> %d\n", low, high);
 
-	/* Make sure LOW_THRESHOLD IT is clear before enabling */
-	writel_relaxed(LOW_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
+	/* Erase threshold content */
+	itr1 = readl_relaxed(sensor->base + DTS_ITR1_OFFSET);
+	itr1 &= ~(TS1_LITTHD_MASK | TS1_HITTHD_MASK);
 
-	/* Enable IT generation for low threshold */
-	value = readl_relaxed(sensor->base + DTS_ITENR_OFFSET);
-	value |= LOW_THRESHOLD;
+	/*
+	 * Disable low-temp if "low" is too small. As per thermal framework
+	 * API, we use -INT_MAX rather than INT_MIN.
+	 */
 
-	/* Enable the low temperature threshold if needed */
-	if (sensor->low_temp_enabled) {
-		/* Make sure HIGH_THRESHOLD IT is clear before enabling */
-		writel_relaxed(HIGH_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
+	if (low > -INT_MAX) {
+		sensor->low_temp_enabled = 1;
+		ret = stm_thermal_calculate_threshold(sensor, low, &th);
+		if (ret)
+			return ret;
 
-		/* Enable IT generation for high threshold */
-		value |= HIGH_THRESHOLD;
+		itr1 |= (TS1_HITTHD_MASK  & (th << TS1_HITTHD_POS));
+	} else {
+		sensor->low_temp_enabled = 0;
 	}
 
-	/* Enable thresholds */
-	writel_relaxed(value, sensor->base + DTS_ITENR_OFFSET);
-
-	dev_dbg(sensor->dev, "%s: IT enabled on sensor side", __func__);
-
-	return 0;
-}
-
-static int stm_thermal_update_threshold(struct stm_thermal_sensor *sensor)
-{
-	int ret;
-
-
-	ret = stm_sensor_power_off(sensor);
-	if (ret)
-		return ret;
-
-	ret = stm_disable_irq(sensor);
-	if (ret)
-		return ret;
-
-	ret = stm_thermal_set_threshold(sensor);
-	if (ret)
-		return ret;
-
-	ret = stm_enable_irq(sensor);
-	if (ret)
-		return ret;
+	/* Disable high-temp if "high" is too big. */
+	if (high < INT_MAX) {
+		sensor->high_temp_enabled = 1;
+		ret = stm_thermal_calculate_threshold(sensor, high, &th);
+		if (ret)
+			return ret;
 
-	ret = stm_sensor_power_on(sensor);
-	if (ret)
-		return ret;
+		itr1 |= (TS1_LITTHD_MASK  & (th << TS1_LITTHD_POS));
+	} else {
+		sensor->high_temp_enabled = 0;
+	}
 
-	sensor->mode = THERMAL_DEVICE_ENABLED;
+	/* Write new threshod values*/
+	writel_relaxed(itr1, sensor->base + DTS_ITR1_OFFSET);
 
 	return 0;
 }
@@ -447,42 +403,6 @@ static int stm_thermal_get_temp(void *data, int *temp)
 	*temp = mcelsius(sensor->t0 + ((freqM - sensor->fmt0) /
 			 sensor->ramp_coeff));
 
-	dev_dbg(sensor->dev, "%s: temperature = %d millicelsius",
-		__func__, *temp);
-
-	/* Update thresholds */
-	if (sensor->num_trips > 1) {
-		/* Update alarm threshold value to next higher trip point */
-		if (sensor->high_temp == sensor->temp_passive &&
-		    celsius(*temp) >= sensor->temp_passive) {
-			sensor->high_temp = sensor->temp_critical;
-			sensor->low_temp = sensor->temp_passive;
-			sensor->low_temp_enabled = true;
-			ret = stm_thermal_update_threshold(sensor);
-			if (ret)
-				return ret;
-		}
-
-		if (sensor->high_temp == sensor->temp_critical &&
-		    celsius(*temp) < sensor->temp_passive) {
-			sensor->high_temp = sensor->temp_passive;
-			sensor->low_temp_enabled = false;
-			ret = stm_thermal_update_threshold(sensor);
-			if (ret)
-				return ret;
-		}
-
-		/*
-		 * Re-enable alarm IRQ if temperature below critical
-		 * temperature
-		 */
-		if (!sensor->irq_enabled &&
-		    (celsius(*temp) < sensor->temp_critical)) {
-			sensor->irq_enabled = true;
-			enable_irq(sensor->irq);
-		}
-	}
-
 	return 0;
 }
 
@@ -500,8 +420,8 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 	}
 
 	ret = devm_request_threaded_irq(dev, sensor->irq,
-					stm_thermal_alarm_irq,
-					stm_thermal_alarm_irq_thread,
+					NULL,
+					stm_thermal_irq_handler,
 					IRQF_ONESHOT,
 					dev->driver->name, sensor);
 	if (ret) {
@@ -510,8 +430,6 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 		return ret;
 	}
 
-	sensor->irq_enabled = true;
-
 	dev_dbg(dev, "%s: thermal IRQ registered", __func__);
 
 	return 0;
@@ -521,6 +439,8 @@ static int stm_thermal_sensor_off(struct stm_thermal_sensor *sensor)
 {
 	int ret;
 
+	stm_disable_irq(sensor);
+
 	ret = stm_sensor_power_off(sensor);
 	if (ret)
 		return ret;
@@ -533,7 +453,6 @@ static int stm_thermal_sensor_off(struct stm_thermal_sensor *sensor)
 static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
 {
 	int ret;
-	struct device *dev = sensor->dev;
 
 	ret = clk_prepare_enable(sensor->clk);
 	if (ret)
@@ -547,26 +466,8 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
 	if (ret)
 		goto thermal_unprepare;
 
-	/* Set threshold(s) for IRQ */
-	ret = stm_thermal_set_threshold(sensor);
-	if (ret)
-		goto thermal_unprepare;
-
-	ret = stm_enable_irq(sensor);
-	if (ret)
-		goto thermal_unprepare;
-
-	ret = stm_sensor_power_on(sensor);
-	if (ret) {
-		dev_err(dev, "%s: failed to power on sensor\n", __func__);
-		goto irq_disable;
-	}
-
 	return 0;
 
-irq_disable:
-	stm_disable_irq(sensor);
-
 thermal_unprepare:
 	clk_disable_unprepare(sensor->clk);
 
@@ -595,6 +496,12 @@ static int stm_thermal_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = stm_sensor_power_on(sensor);
+	if (ret)
+		return ret;
+
+	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
+	stm_enable_irq(sensor);
 
 	return 0;
 }
@@ -604,6 +511,7 @@ SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops, stm_thermal_suspend, stm_thermal_resume);
 
 static const struct thermal_zone_of_device_ops stm_tz_ops = {
 	.get_temp	= stm_thermal_get_temp,
+	.set_trips	= stm_thermal_set_trips,
 };
 
 static const struct of_device_id stm_thermal_of_match[] = {
@@ -616,9 +524,8 @@ static int stm_thermal_probe(struct platform_device *pdev)
 {
 	struct stm_thermal_sensor *sensor;
 	struct resource *res;
-	const struct thermal_trip *trip;
 	void __iomem *base;
-	int ret, i;
+	int ret;
 
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "%s: device tree node not found\n",
@@ -654,10 +561,18 @@ static int stm_thermal_probe(struct platform_device *pdev)
 	/* Clear irq flags */
 	writel_relaxed(ICIFR_MASK, sensor->base + DTS_ICIFR_OFFSET);
 
-	/* Register IRQ into GIC */
-	ret = stm_register_irq(sensor);
-	if (ret)
+	/* Configure and enable HW sensor */
+	ret = stm_thermal_prepare(sensor);
+	if (ret) {
+		dev_err(&pdev->dev, "Error preprare sensor: %d\n", ret);
 		return ret;
+	}
+
+	ret = stm_sensor_power_on(sensor);
+	if (ret) {
+		dev_err(&pdev->dev, "Error power on sensor: %d\n", ret);
+		return ret;
+	}
 
 	sensor->th_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
 							      sensor,
@@ -670,53 +585,12 @@ static int stm_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (!sensor->th_dev->ops->get_crit_temp) {
-		/* Critical point must be provided */
-		ret = -EINVAL;
-		goto err_tz;
-	}
-
-	ret = sensor->th_dev->ops->get_crit_temp(sensor->th_dev,
-			&sensor->temp_critical);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Not able to read critical_temp: %d\n", ret);
+	/* Register IRQ into GIC */
+	ret = stm_register_irq(sensor);
+	if (ret)
 		goto err_tz;
-	}
-
-	sensor->temp_critical = celsius(sensor->temp_critical);
-
-	/* Set thresholds for IRQ */
-	sensor->high_temp = sensor->temp_critical;
-
-	trip = of_thermal_get_trip_points(sensor->th_dev);
-	sensor->num_trips = of_thermal_get_ntrips(sensor->th_dev);
-
-	/* Find out passive temperature if it exists */
-	for (i = (sensor->num_trips - 1); i >= 0;  i--) {
-		if (trip[i].type == THERMAL_TRIP_PASSIVE) {
-			sensor->temp_passive = celsius(trip[i].temperature);
-			/* Update high temperature threshold */
-			sensor->high_temp = sensor->temp_passive;
-			}
-	}
 
-	/*
-	 * Ensure low_temp_enabled flag is disabled.
-	 * By disabling low_temp_enabled, low threshold IT will not be
-	 * configured neither enabled because it is not needed as high
-	 * threshold is set on the lowest temperature trip point after
-	 * probe.
-	 */
-	sensor->low_temp_enabled = false;
-
-	/* Configure and enable HW sensor */
-	ret = stm_thermal_prepare(sensor);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Not able to enable sensor: %d\n", ret);
-		goto err_tz;
-	}
+	stm_enable_irq(sensor);
 
 	/*
 	 * Thermal_zone doesn't enable hwmon as default,
-- 
2.17.1

