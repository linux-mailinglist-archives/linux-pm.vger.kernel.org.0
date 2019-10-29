Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42EE8D22
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390487AbfJ2QqL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:46:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21008 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728524AbfJ2QqJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:46:09 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TGhCLW011486;
        Tue, 29 Oct 2019 17:45:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=92G5zptu/BKdiJ/91ipkjy88pDUEE0M92MQEthDZ4Bk=;
 b=lqmOI5eT2E2ok6TTbsDFq80hzIuZPJR0ek81UttTo0T+ZyrGy4F78IjQiu96mBkXZezH
 SYRjxHNiZgttrBNkGEJFrbwWw0U3CttXPjsLi7IElcIaHK6t+u1DsfNKhaZDiXhflwym
 9a2ub13RaTlC5L2XrpE9FJRhukvlu5JGzcnZjzRY9+j0hEotsMkENLOZ3dbTwFDNOt3M
 7Zq75itVQlTNh9tGRfhlR1OsJiQjHSI2NRjbQEpURd3HlIy60JGSzUnPvuHf3eT1ptwx
 ZwQ9StWI+0lCTtc127OfK3RQ0iqD1sW0xHAVsWflVS6Ff0Rfjjlcc+YidhIESCApC2PF eQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vvbww8tn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 17:45:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 761D510002A;
        Tue, 29 Oct 2019 17:45:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 654DF2A748A;
        Tue, 29 Oct 2019 17:45:45 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 29 Oct 2019 17:45:45
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
Subject: [PATCH 3/4] thermal: stm32: fix engineering calibration value
Date:   Tue, 29 Oct 2019 17:45:36 +0100
Message-ID: <20191029164537.1561-4-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164537.1561-1-p.paillet@st.com>
References: <20191029164537.1561-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_05:2019-10-28,2019-10-29 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TS1_T0 is only used by engineering during calibration.
The temperature offset is actually fixed to 30 Celsius.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Change-Id: I83abea65ff3f58f8954256495f2d5d38f0d868d9
---
 drivers/thermal/st/stm_thermal.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 4bc1bbece0de..37abbdffe573 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -82,8 +82,7 @@
 #define ONE_MHZ			1000000
 #define POLL_TIMEOUT		5000
 #define STARTUP_TIME		40
-#define TS1_T0_VAL0		30000  /* 30 celsius */
-#define TS1_T0_VAL1		130000 /* 130 celsius */
+#define T0			30000  /* 30 celsius */
 #define NO_HW_TRIG		0
 #define SAMPLING_TIME		15
 
@@ -94,7 +93,7 @@ struct stm_thermal_sensor {
 	struct clk *clk;
 	int irq;
 	void __iomem *base;
-	int t0, fmt0, ramp_coeff;
+	int fmt0, ramp_coeff;
 	int low_en, high_en;
 };
 
@@ -248,14 +247,6 @@ static int stm_thermal_calibration(struct stm_thermal_sensor *sensor)
 /* Fill in DTS structure with factory sensor values */
 static int stm_thermal_read_factory_settings(struct stm_thermal_sensor *sensor)
 {
-	/* Retrieve engineering calibration temperature */
-	sensor->t0 = readl_relaxed(sensor->base + DTS_T0VALR1_OFFSET) &
-					TS1_T0_MASK;
-	if (!sensor->t0)
-		sensor->t0 = TS1_T0_VAL0;
-	else
-		sensor->t0 = TS1_T0_VAL1;
-
 	/* Retrieve fmt0 and put it on Hz */
 	sensor->fmt0 = ADJUST * (readl_relaxed(sensor->base +
 				 DTS_T0VALR1_OFFSET) & TS1_FMT0_MASK);
@@ -269,8 +260,8 @@ static int stm_thermal_read_factory_settings(struct stm_thermal_sensor *sensor)
 		return -EINVAL;
 	}
 
-	dev_dbg(sensor->dev, "%s: T0 = %doC, FMT0 = %dHz, RAMP_COEFF = %dHz/oC",
-		__func__, sensor->t0, sensor->fmt0, sensor->ramp_coeff);
+	dev_dbg(sensor->dev, "%s: FMT0 = %dHz, RAMP_COEFF = %dHz/oC",
+		__func__, sensor->fmt0, sensor->ramp_coeff);
 
 	return 0;
 }
@@ -281,8 +272,7 @@ static int stm_thermal_calculate_threshold(struct stm_thermal_sensor *sensor,
 	int freqM;
 
 	/* Figure out the CLK_PTAT frequency for a given temperature */
-	freqM = ((temp - sensor->t0) * sensor->ramp_coeff) / 1000 +
-		sensor->fmt0;
+	freqM = ((temp - T0) * sensor->ramp_coeff) / 1000 + sensor->fmt0;
 
 	/* Figure out the threshold sample number */
 	*th = clk_get_rate(sensor->clk) * SAMPLING_TIME / freqM;
@@ -317,7 +307,7 @@ static int stm_thermal_get_temp(void *data, int *temp)
 		return -EINVAL;
 
 	/* Figure out the temperature in mili celsius */
-	*temp = (freqM - sensor->fmt0) * 1000 / sensor->ramp_coeff + sensor->t0;
+	*temp = (freqM - sensor->fmt0) * 1000 / sensor->ramp_coeff + T0;
 
 	dev_dbg(sensor->dev, "periods=0x%x t=%d mC", periods, *temp);
 
-- 
2.17.1

