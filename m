Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E50EE132
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 14:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfKDNax (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 08:30:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52648 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729153AbfKDNaw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 08:30:52 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4DNH0m017943;
        Mon, 4 Nov 2019 14:30:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=p03njtumV+HleK/1bWaZoOME3iGFRP863OGQq660Kvk=;
 b=PIgiBoa1kx8JUAVRMEO5EaQyJIOEtCjt1ITCMuEomInl3tm0zvZ2t15v2w8EffHY5xFL
 NQk0b5LwrdNokQLubAgkdod7vRMa8jFVVNtDpclmhcHQyT9Q0hCTwNrY2FREDyjjpPRl
 kygUqtUwC7fzs9qg0vNywIrdnaRKOGBcz+bTAMP9ewfJqwTPZe3cayXSizq3Ql5Elt2h
 1cO1qdkuq5fJmPanp/xLSEPmqZQZbiLZdZDdekOzVNcbEmLiUMvKe3a5TXeLMK9PECBC
 +ZZOjGMhQ4QqP71VOVerViNK+kbiBCI014/b71K3970LohiZoGMMdk/imJvu/JMcjDYL Qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w11jn1vxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 14:30:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF34B10003D;
        Mon,  4 Nov 2019 14:30:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CEE9C2FF5C2;
        Mon,  4 Nov 2019 14:30:25 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 4 Nov 2019 14:30:25
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
Subject: [PATCH v2 4/5] thermal: stm32: improve temperature resolution
Date:   Mon, 4 Nov 2019 14:30:19 +0100
Message-ID: <20191104133020.8820-5-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104133020.8820-1-p.paillet@st.com>
References: <20191104133020.8820-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_08:2019-11-04,2019-11-04 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, the temperature is rounded by 1 or 2 degrees.
Change the way of computing to avoid rounds.
Also simplify the sampling time management.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 drivers/thermal/st/stm_thermal.c | 58 ++++++++------------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index cb72252f2800..9986716b17c1 100644
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
@@ -259,27 +253,17 @@ static int stm_thermal_calculate_threshold(struct stm_thermal_sensor *sensor,
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
@@ -371,40 +355,26 @@ static int stm_thermal_set_trips(void *data, int low, int high)
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

