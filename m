Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1B5E8D2E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390708AbfJ2QqU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:46:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26982 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727279AbfJ2QqI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:46:08 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TGhXa2026559;
        Tue, 29 Oct 2019 17:45:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=cUNYleQOTDVYQ2kHeqm4eAjJNxaCQ04tYu9otVBG33M=;
 b=t6qvVNmCbyVwbLydDiLqxFcdzWvqEScCxt31fTLVerLjU2PZEIXSJ777akiQQUE3CFlZ
 y1ghwEYLI13DZdNHTJruAgW+c1HMPF5mHHfDj5DwWUU3B9+p84kKt0vnkUOe+w+t5O8I
 pxfKRICCTiHPn1oScsABlEPgqG+Vg5gtGAotX36LXFTO2+BC94DjBTETTmJoCxjdi2EE
 KlH2HCmuJ682lRZBresYUbjbmxxPGEFjKTeRGXcvxAZ/zbhwim5N9L5i3ajNcVrBIRMb
 28V7aAS7Ao5I0CEuvQo9uQor95snjbYv2C02L1NwcG/dvAOkr0KGLRv5Ra6QWhJfN/43 jA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vvbm0gwdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 17:45:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BFD34100034;
        Tue, 29 Oct 2019 17:45:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AE8C62A748A;
        Tue, 29 Oct 2019 17:45:44 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 29 Oct 2019 17:45:44
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
Subject: [PATCH 2/4] thermal: stm32: fix IRQ flood on low threshold
Date:   Tue, 29 Oct 2019 17:45:35 +0100
Message-ID: <20191029164537.1561-3-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164537.1561-1-p.paillet@st.com>
References: <20191029164537.1561-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_05:2019-10-28,2019-10-29 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix IRQ flood on low threshold by too ways:
- improve temperature reading resolution,
- add an hysteresis to the low threshold: on low threshold interrupt,
it is not possible to get the temperature value that has fired the
interrupt. The time to acquire a new value is enough for the CPU to
become hotter than the current low threshold.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Change-Id: I3b63b8aab38fd651a165c4e69a2d090b3c6f5db3
---
 drivers/thermal/st/stm_thermal.c | 73 +++++++++-----------------------
 1 file changed, 19 insertions(+), 54 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 0aae1cc14235..4bc1bbece0de 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -59,7 +59,6 @@
 
 /* Less significant bit position definitions */
 #define TS1_T0_POS		16
-#define TS1_SMP_TIME_POS	16
 #define TS1_HITTHD_POS		16
 #define TS1_LITTHD_POS		0
 #define HSREF_CLK_DIV_POS	24
@@ -83,15 +82,10 @@
 #define ONE_MHZ			1000000
 #define POLL_TIMEOUT		5000
 #define STARTUP_TIME		40
-#define TS1_T0_VAL0		30
-#define TS1_T0_VAL1		130
+#define TS1_T0_VAL0		30000  /* 30 celsius */
+#define TS1_T0_VAL1		130000 /* 130 celsius */
 #define NO_HW_TRIG		0
-
-/* The Thermal Framework expects millidegrees */
-#define mcelsius(temp)		((temp) * 1000)
-
-/* The Sensor expects oC degrees */
-#define celsius(temp)		((temp) / 1000)
+#define SAMPLING_TIME		15
 
 struct stm_thermal_sensor {
 	struct device *dev;
@@ -222,12 +216,8 @@ static int stm_thermal_calibration(struct stm_thermal_sensor *sensor)
 	if (!clk_freq)
 		return -EINVAL;
 
-	prescaler = 0;
-	clk_freq /= ONE_MHZ;
-	if (clk_freq) {
-		while (prescaler <= clk_freq)
-			prescaler++;
-	}
+	/* calculate divider for maximum 1MHz PCLK */
+	prescaler = clk_freq / ONE_MHZ + 1;
 
 	value = readl_relaxed(sensor->base + DTS_CFGR1_OFFSET);
 
@@ -235,7 +225,7 @@ static int stm_thermal_calibration(struct stm_thermal_sensor *sensor)
 	value &= ~HSREF_CLK_DIV_MASK;
 
 	/* Set prescaler. pclk_freq/prescaler < 1MHz */
-	value |= (prescaler << HSREF_CLK_DIV_POS);
+	value |= (prescaler << HSREF_CLK_DIV_POS) & HSREF_CLK_DIV_MASK;
 
 	/* Select PCLK as reference clock */
 	value &= ~REFCLK_SEL;
@@ -289,28 +279,16 @@ static int stm_thermal_calculate_threshold(struct stm_thermal_sensor *sensor,
 					   int temp, u32 *th)
 {
 	int freqM;
-	u32 sampling_time;
-
-	/* Retrieve the number of periods to sample */
-	sampling_time = (readl_relaxed(sensor->base + DTS_CFGR1_OFFSET) &
-			TS1_SMP_TIME_MASK) >> TS1_SMP_TIME_POS;
 
 	/* Figure out the CLK_PTAT frequency for a given temperature */
-	freqM = ((temp - sensor->t0) * sensor->ramp_coeff)
-		 + sensor->fmt0;
-
-	dev_dbg(sensor->dev, "%s: freqM for threshold = %d Hz",
-		__func__, freqM);
+	freqM = ((temp - sensor->t0) * sensor->ramp_coeff) / 1000 +
+		sensor->fmt0;
 
 	/* Figure out the threshold sample number */
-	*th = clk_get_rate(sensor->clk);
+	*th = clk_get_rate(sensor->clk) * SAMPLING_TIME / freqM;
 	if (!*th)
 		return -EINVAL;
 
-	*th = *th / freqM;
-
-	*th *= sampling_time;
-
 	dev_dbg(sensor->dev, "freqM=%d Hz, threshold=0x%x", freqM, *th);
 
 	return 0;
@@ -320,42 +298,28 @@ static int stm_thermal_calculate_threshold(struct stm_thermal_sensor *sensor,
 static int stm_thermal_get_temp(void *data, int *temp)
 {
 	struct stm_thermal_sensor *sensor = data;
-	u32 sampling_time;
+	u32 periods;
 	int freqM, ret;
 
 	if (sensor->mode != THERMAL_DEVICE_ENABLED)
 		return -EAGAIN;
 
-	/* Retrieve the number of samples */
-	ret = readl_poll_timeout(sensor->base + DTS_DR_OFFSET, freqM,
-				 (freqM & TS1_MFREQ_MASK), STARTUP_TIME,
-				 POLL_TIMEOUT);
-
+	/* Retrieve the number of periods sampled */
+	ret = readl_relaxed_poll_timeout(sensor->base + DTS_DR_OFFSET, periods,
+					 (periods & TS1_MFREQ_MASK),
+					 STARTUP_TIME, POLL_TIMEOUT);
 	if (ret)
 		return ret;
 
-	if (!freqM)
-		return -ENODATA;
-
-	/* Retrieve the number of periods sampled */
-	sampling_time = (readl_relaxed(sensor->base + DTS_CFGR1_OFFSET) &
-			TS1_SMP_TIME_MASK) >> TS1_SMP_TIME_POS;
-
-	/* Figure out the number of samples per period */
-	freqM /= sampling_time;
-
 	/* Figure out the CLK_PTAT frequency */
-	freqM = clk_get_rate(sensor->clk) / freqM;
+	freqM = (clk_get_rate(sensor->clk) * SAMPLING_TIME) / periods;
 	if (!freqM)
 		return -EINVAL;
 
-	dev_dbg(sensor->dev, "%s: freqM=%d\n", __func__, freqM);
-
 	/* Figure out the temperature in mili celsius */
-	*temp = mcelsius(sensor->t0 + ((freqM - sensor->fmt0) /
-			 sensor->ramp_coeff));
+	*temp = (freqM - sensor->fmt0) * 1000 / sensor->ramp_coeff + sensor->t0;
 
-	dev_dbg(sensor->dev, "temperature = %d millicelsius", *temp);
+	dev_dbg(sensor->dev, "periods=0x%x t=%d mC", periods, *temp);
 
 	return 0;
 }
@@ -379,7 +343,8 @@ static int stm_thermal_set_trips(void *data, int low, int high)
 
 	if (low > -INT_MAX) {
 		sensor->low_en = 1;
-		ret = stm_thermal_calculate_threshold(sensor, low, &th);
+		/* add 0.5 of hysteresis due to measurement error */
+		ret = stm_thermal_calculate_threshold(sensor, low - 500, &th);
 		if (ret)
 			return ret;
 
-- 
2.17.1

