Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945C6136AD6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgAJKQh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:16:37 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32734 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbgAJKQg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:16:36 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AADuo6001631;
        Fri, 10 Jan 2020 11:16:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=VNdKiXHTsnLlZQDsSxPKZhiScesYyaZdTCaN+plx4oE=;
 b=JFEJPOQopDcHcSjc9etUtzI/ToH9CnFieXDHR+CN92+cxP+BLIpsRF99UdhLRyg18qjB
 hw9e+cHiFU3pFFGmRAi9gbCPuoxwq36K2GGiYGvloBOj8mesYiDRkCuZS43B+DBGyMRo
 J5Tck6FLMeUOHmh5J4mmegQL8fHFqNJ6Pj1eWEByaeHPoJFh4UTRV1ZoIUqfFApAN3s3
 qfjIzaVyDlkY0ftOhukRN/oPp0s7zSZbN5lKhMzL0FJBn+Q0ccdR7OwAvfOdet35AyPO
 3i+Scd6RVIdmP95pub0lFiD661FfgPQC2GhQT6yBkqP3t0vNazQCF8YYtUJhl+3pKkAF Xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakur6mnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 11:16:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11382100034;
        Fri, 10 Jan 2020 11:16:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 014962A7906;
        Fri, 10 Jan 2020 11:16:12 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Jan 2020 11:16:11
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
Subject: [PATCH_V3 5/6] thermal: stm32: improve temperature computing
Date:   Fri, 10 Jan 2020 11:16:04 +0100
Message-ID: <20200110101605.24984-6-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110101605.24984-1-p.paillet@st.com>
References: <20200110101605.24984-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the way of computing to avoid rounds by 1 or 2 degrees.
Also simplify the sampling time management that is hard-coded
to maximum value during probe.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 drivers/thermal/st/stm_thermal.c | 58 ++++++++------------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 29e7ee89adf6..aaf25ca2f118 100644
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
@@ -280,27 +274,17 @@ static int stm_thermal_calculate_threshold(struct stm_thermal_sensor *sensor,
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
+	dev_dbg(sensor->dev, "freqM=%d Hz, threshold=0x%x", freqM, *th);
 
 	return 0;
 }
@@ -368,40 +352,26 @@ static int stm_thermal_set_trips(void *data, int low, int high)
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
 
 	return 0;
 }
-- 
2.17.1

