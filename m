Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20398E8D25
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfJ2QqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:46:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21012 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727692AbfJ2QqL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:46:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TGhCLU011486;
        Tue, 29 Oct 2019 17:45:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Yrqc3VV7V0g8I95k9AcWJcE8fDpK5QUBl1zPkRiabLs=;
 b=NOm/Fr6/eGqwkmQinF5k9jH8Vndjdc/qD1KlDeshDk44ib6zgs0wtfGMFMfOqkQeDK4k
 psobIbSbCY1t3ka1n97nJIMRtgsKQ17Do39UY294YkePDjVHkhJRVUkt8Dy5lbzzq4FD
 HnFjLxwwauIEp5+Zo/vGwN8ehHinFQ8wcW6y4JM2nMegS2QmBuoWVSO83Bm8tHcUoWWE
 5JgwCwVZsiui7T0IbtUfPaHSlvfyrPe3lK9DsTLmoSBCzIg6ClhKvVVfKn0SxUkWlWT6
 ITIscXxueoJ+6sYnrJakMGi1qBw67iJ2TYZhuyG78MvG6Q1nwoZ77T5MkCmA0510BBkN WQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vvbww8tn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 17:45:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09F69100034;
        Tue, 29 Oct 2019 17:45:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED7C32A748A;
        Tue, 29 Oct 2019 17:45:43 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 29 Oct 2019 17:45:43
 +0100
From:   Pascal Paillet <p.paillet@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <david.hernandezsanchez@st.com>,
        <wsa+renesas@sang-engineering.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <p.paillet@st.com>
Subject: [PATCH 1/4] thermal: stm32: implement set_trips callback
Date:   Tue, 29 Oct 2019 17:45:34 +0100
Message-ID: <20191029164537.1561-2-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164537.1561-1-p.paillet@st.com>
References: <20191029164537.1561-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_05:2019-10-28,2019-10-29 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Implement set_trips() so that the trip points are managed by the thermal
framework. The user is free to define any trip points he needs.
Simplify interrupt handling.


Signed-off-by: Pascal Paillet <p.paillet@st.com>
Change-Id: I2929d4fa5b4c5dca45cec7cb3b93fffc277394d2
---
 drivers/thermal/st/stm_thermal.c | 370 +++++++++++--------------------
 1 file changed, 125 insertions(+), 245 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index cf9ddc52f30e..0aae1cc14235 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -30,7 +30,7 @@
 #define DTS_DR_OFFSET		0x1C
 #define DTS_SR_OFFSET		0x20
 #define DTS_ITENR_OFFSET	0x24
-#define DTS_CIFR_OFFSET		0x28
+#define DTS_ICIFR_OFFSET	0x28
 
 /* DTS_CFGR1 register mask definitions */
 #define HSREF_CLK_DIV_MASK	GENMASK(30, 24)
@@ -51,10 +51,17 @@
 /* DTS_DR register mask definitions */
 #define TS1_MFREQ_MASK		GENMASK(15, 0)
 
+/* DTS_ITENR register mask definitions */
+#define ITENR_MASK		(GENMASK(2, 0) | GENMASK(6, 4))
+
+/* DTS_ICIFR register mask definitions */
+#define ICIFR_MASK		(GENMASK(2, 0) | GENMASK(6, 4))
+
 /* Less significant bit position definitions */
 #define TS1_T0_POS		16
 #define TS1_SMP_TIME_POS	16
 #define TS1_HITTHD_POS		16
+#define TS1_LITTHD_POS		0
 #define HSREF_CLK_DIV_POS	24
 
 /* DTS_CFGR1 bit definitions */
@@ -91,44 +98,59 @@ struct stm_thermal_sensor {
 	struct thermal_zone_device *th_dev;
 	enum thermal_device_mode mode;
 	struct clk *clk;
-	int high_temp;
-	int low_temp;
-	int temp_critical;
-	int temp_passive;
-	unsigned int low_temp_enabled;
-	int num_trips;
 	int irq;
-	unsigned int irq_enabled;
 	void __iomem *base;
 	int t0, fmt0, ramp_coeff;
+	int low_en, high_en;
 };
 
-static irqreturn_t stm_thermal_alarm_irq(int irq, void *sdata)
+static void stm_thermal_disable_irq(struct stm_thermal_sensor *sensor)
 {
-	struct stm_thermal_sensor *sensor = sdata;
+	u32 itenr;
+
+	/* Disable IT generation */
+	itenr = readl_relaxed(sensor->base + DTS_ITENR_OFFSET);
+	itenr &= ~ITENR_MASK;
+	writel_relaxed(itenr, sensor->base + DTS_ITENR_OFFSET);
+}
+
+static void stm_thermal_set_irq_state(struct stm_thermal_sensor *sensor)
+{
+	u32 itenr;
+
+	dev_dbg(sensor->dev, "low:%d high:%d\n", sensor->low_en,
+		sensor->high_en);
+
+	/* Disable IT generation for low and high thresholds */
+	itenr = readl_relaxed(sensor->base + DTS_ITENR_OFFSET);
+	itenr &= ~(LOW_THRESHOLD | HIGH_THRESHOLD);
+
+	if (sensor->low_en)
+		itenr |= HIGH_THRESHOLD;
 
-	disable_irq_nosync(irq);
-	sensor->irq_enabled = false;
+	if (sensor->high_en)
+		itenr |= LOW_THRESHOLD;
 
-	return IRQ_WAKE_THREAD;
+	/* Enable interrupts */
+	writel_relaxed(itenr, sensor->base + DTS_ITENR_OFFSET);
 }
 
 static irqreturn_t stm_thermal_alarm_irq_thread(int irq, void *sdata)
 {
-	u32 value;
 	struct stm_thermal_sensor *sensor = sdata;
 
-	/* read IT reason in SR and clear flags */
-	value = readl_relaxed(sensor->base + DTS_SR_OFFSET);
-
-	if ((value & LOW_THRESHOLD) == LOW_THRESHOLD)
-		writel_relaxed(LOW_THRESHOLD, sensor->base + DTS_CIFR_OFFSET);
+	dev_dbg(sensor->dev, "sr:%d\n",
+		readl_relaxed(sensor->base + DTS_SR_OFFSET));
 
-	if ((value & HIGH_THRESHOLD) == HIGH_THRESHOLD)
-		writel_relaxed(HIGH_THRESHOLD, sensor->base + DTS_CIFR_OFFSET);
+	stm_thermal_disable_irq(sensor);
 
 	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
 
+	stm_thermal_set_irq_state(sensor);
+
+	/* Acknoledge all DTS irqs */
+	writel_relaxed(ICIFR_MASK, sensor->base + DTS_ICIFR_OFFSET);
+
 	return IRQ_HANDLED;
 }
 
@@ -160,6 +182,8 @@ static int stm_sensor_power_on(struct stm_thermal_sensor *sensor)
 	writel_relaxed(value, sensor->base +
 		       DTS_CFGR1_OFFSET);
 
+	sensor->mode = THERMAL_DEVICE_ENABLED;
+
 	return 0;
 }
 
@@ -167,6 +191,8 @@ static int stm_sensor_power_off(struct stm_thermal_sensor *sensor)
 {
 	u32 value;
 
+	sensor->mode = THERMAL_DEVICE_DISABLED;
+
 	/* Stop measuring */
 	value = readl_relaxed(sensor->base + DTS_CFGR1_OFFSET);
 	value &= ~TS1_START;
@@ -285,118 +311,7 @@ static int stm_thermal_calculate_threshold(struct stm_thermal_sensor *sensor,
 
 	*th *= sampling_time;
 
-	return 0;
-}
-
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
-/* Disable temperature interrupt */
-static int stm_disable_irq(struct stm_thermal_sensor *sensor)
-{
-	u32 value;
-
-	/* Disable IT generation for low and high thresholds */
-	value = readl_relaxed(sensor->base + DTS_ITENR_OFFSET);
-	writel_relaxed(value & ~(LOW_THRESHOLD | HIGH_THRESHOLD),
-		       sensor->base + DTS_ITENR_OFFSET);
-
-	dev_dbg(sensor->dev, "%s: IT disabled on sensor side", __func__);
-
-	return 0;
-}
-
-/* Enable temperature interrupt */
-static int stm_enable_irq(struct stm_thermal_sensor *sensor)
-{
-	u32 value;
-
-	/*
-	 * Code below enables High temperature threshold using a low threshold
-	 * sampling value
-	 */
-
-	/* Make sure LOW_THRESHOLD IT is clear before enabling */
-	writel_relaxed(LOW_THRESHOLD, sensor->base + DTS_CIFR_OFFSET);
-
-	/* Enable IT generation for low threshold */
-	value = readl_relaxed(sensor->base + DTS_ITENR_OFFSET);
-	value |= LOW_THRESHOLD;
-
-	/* Enable the low temperature threshold if needed */
-	if (sensor->low_temp_enabled) {
-		/* Make sure HIGH_THRESHOLD IT is clear before enabling */
-		writel_relaxed(HIGH_THRESHOLD, sensor->base + DTS_CIFR_OFFSET);
-
-		/* Enable IT generation for high threshold */
-		value |= HIGH_THRESHOLD;
-	}
-
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
-	sensor->mode = THERMAL_DEVICE_DISABLED;
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
-
-	ret = stm_sensor_power_on(sensor);
-	if (ret)
-		return ret;
-
-	sensor->mode = THERMAL_DEVICE_ENABLED;
+	dev_dbg(sensor->dev, "freqM=%d Hz, threshold=0x%x", freqM, *th);
 
 	return 0;
 }
@@ -440,42 +355,54 @@ static int stm_thermal_get_temp(void *data, int *temp)
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
+	dev_dbg(sensor->dev, "temperature = %d millicelsius", *temp);
+
+	return 0;
+}
+
+static int stm_thermal_set_trips(void *data, int low, int high)
+{
+	struct stm_thermal_sensor *sensor = data;
+	u32 itr1, th;
+	int ret;
+
+	dev_dbg(sensor->dev, "set trips %d <--> %d\n", low, high);
+
+	/* Erase threshold content */
+	itr1 = readl_relaxed(sensor->base + DTS_ITR1_OFFSET);
+	itr1 &= ~(TS1_LITTHD_MASK | TS1_HITTHD_MASK);
+
+	/*
+	 * Disable low-temp if "low" is too small. As per thermal framework
+	 * API, we use -INT_MAX rather than INT_MIN.
+	 */
+
+	if (low > -INT_MAX) {
+		sensor->low_en = 1;
+		ret = stm_thermal_calculate_threshold(sensor, low, &th);
+		if (ret)
+			return ret;
+
+		itr1 |= (TS1_HITTHD_MASK  & (th << TS1_HITTHD_POS));
+	} else {
+		sensor->low_en = 0;
 	}
 
+	/* Disable high-temp if "high" is too big. */
+	if (high < INT_MAX) {
+		sensor->high_en = 1;
+		ret = stm_thermal_calculate_threshold(sensor, high, &th);
+		if (ret)
+			return ret;
+
+		itr1 |= (TS1_LITTHD_MASK  & (th << TS1_LITTHD_POS));
+	} else {
+		sensor->high_en = 0;
+	}
+
+	/* Write new threshod values*/
+	writel_relaxed(itr1, sensor->base + DTS_ITR1_OFFSET);
+
 	return 0;
 }
 
@@ -493,8 +420,7 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 	}
 
 	ret = devm_request_threaded_irq(dev, sensor->irq,
-					stm_thermal_alarm_irq,
-					stm_thermal_alarm_irq_thread,
+					NULL, stm_thermal_alarm_irq_thread,
 					IRQF_ONESHOT,
 					dev->driver->name, sensor);
 	if (ret) {
@@ -503,8 +429,6 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 		return ret;
 	}
 
-	sensor->irq_enabled = true;
-
 	dev_dbg(dev, "%s: thermal IRQ registered", __func__);
 
 	return 0;
@@ -514,6 +438,8 @@ static int stm_thermal_sensor_off(struct stm_thermal_sensor *sensor)
 {
 	int ret;
 
+	stm_thermal_disable_irq(sensor);
+
 	ret = stm_sensor_power_off(sensor);
 	if (ret)
 		return ret;
@@ -526,7 +452,6 @@ static int stm_thermal_sensor_off(struct stm_thermal_sensor *sensor)
 static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
 {
 	int ret;
-	struct device *dev = sensor->dev;
 
 	ret = clk_prepare_enable(sensor->clk);
 	if (ret)
@@ -540,26 +465,8 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
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
 
@@ -576,8 +483,6 @@ static int stm_thermal_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	sensor->mode = THERMAL_DEVICE_DISABLED;
-
 	return 0;
 }
 
@@ -590,7 +495,12 @@ static int stm_thermal_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	sensor->mode = THERMAL_DEVICE_ENABLED;
+	ret = stm_sensor_power_on(sensor);
+	if (ret)
+		return ret;
+
+	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
+	stm_thermal_set_irq_state(sensor);
 
 	return 0;
 }
@@ -600,6 +510,7 @@ SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops, stm_thermal_suspend, stm_thermal_resume);
 
 static const struct thermal_zone_of_device_ops stm_tz_ops = {
 	.get_temp	= stm_thermal_get_temp,
+	.set_trips	= stm_thermal_set_trips,
 };
 
 static const struct of_device_id stm_thermal_of_match[] = {
@@ -612,9 +523,8 @@ static int stm_thermal_probe(struct platform_device *pdev)
 {
 	struct stm_thermal_sensor *sensor;
 	struct resource *res;
-	const struct thermal_trip *trip;
 	void __iomem *base;
-	int ret, i;
+	int ret;
 
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "%s: device tree node not found\n",
@@ -645,10 +555,23 @@ static int stm_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(sensor->clk);
 	}
 
-	/* Register IRQ into GIC */
-	ret = stm_register_irq(sensor);
-	if (ret)
+	stm_thermal_disable_irq(sensor);
+
+	/* Clear irq flags */
+	writel_relaxed(ICIFR_MASK, sensor->base + DTS_ICIFR_OFFSET);
+
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
@@ -661,53 +584,12 @@ static int stm_thermal_probe(struct platform_device *pdev)
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
-
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
+	stm_thermal_set_irq_state(sensor);
 
 	/*
 	 * Thermal_zone doesn't enable hwmon as default,
@@ -718,8 +600,6 @@ static int stm_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_tz;
 
-	sensor->mode = THERMAL_DEVICE_ENABLED;
-
 	dev_info(&pdev->dev, "%s: Driver initialized successfully\n",
 		 __func__);
 
-- 
2.17.1

