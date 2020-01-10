Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8594C136ADF
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgAJKQ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:16:57 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27722 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727445AbgAJKQf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:16:35 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AAE8Dx029396;
        Fri, 10 Jan 2020 11:16:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=MsYZtSJTRtofOX1+DaEAVsiSRhsLl0necGZ8OJbUceY=;
 b=accDVAbHVcJLvFxLvvSntdbWOxM1RFgWQAK86Kkg8SLmaJWvoS5tTeuahNLi9Jm3u68T
 8ZgQ5D6EDnwWAEPgcYf25gFwQxd0UWoapJB2PqUPJx6mo09R4LXA1EKH7/W307+NWWv/
 NuEi7GDvf7PK6VFwhxpOnWbgTaOhlHtLzCqH9d/A9h+vPPqf4nPtVmwM0GcMksWxe0yr
 Pxw1SR+tTM/NNkDpDNRXSCFR52B6MHSKyD+bOx4Y5Y0aj1wl2qcN7ubGAH9OtpALZ7eT
 JJI5waYLhLVx1eXHk5ArYsAuxVhsluQi45ceA/teUD0P5Y7c3rRNK1fkL8WdQv5wjyPF OA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakkb742a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 11:16:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DC53810003A;
        Fri, 10 Jan 2020 11:16:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CCC992A7907;
        Fri, 10 Jan 2020 11:16:09 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Jan 2020 11:16:09
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
Subject: [PATCH_V3 2/6] thermal: stm32: rework sensor mode management
Date:   Fri, 10 Jan 2020 11:16:01 +0100
Message-ID: <20200110101605.24984-3-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110101605.24984-1-p.paillet@st.com>
References: <20200110101605.24984-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Be sure get_temp returns an error while disabling or enabling the device.
Set THERMAL_DEVICE_ENABLED state at the end of power on function.
Set THERMAL_DEVICE_DISABLED state at the beginning of power off function.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 drivers/thermal/st/stm_thermal.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 7835e109692e..a21fa7e0c72b 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -160,6 +160,8 @@ static int stm_sensor_power_on(struct stm_thermal_sensor *sensor)
 	writel_relaxed(value, sensor->base +
 		       DTS_CFGR1_OFFSET);
 
+	sensor->mode = THERMAL_DEVICE_ENABLED;
+
 	return 0;
 }
 
@@ -167,6 +169,8 @@ static int stm_sensor_power_off(struct stm_thermal_sensor *sensor)
 {
 	u32 value;
 
+	sensor->mode = THERMAL_DEVICE_DISABLED;
+
 	/* Stop measuring */
 	value = readl_relaxed(sensor->base + DTS_CFGR1_OFFSET);
 	value &= ~TS1_START;
@@ -374,7 +378,6 @@ static int stm_thermal_update_threshold(struct stm_thermal_sensor *sensor)
 {
 	int ret;
 
-	sensor->mode = THERMAL_DEVICE_DISABLED;
 
 	ret = stm_sensor_power_off(sensor);
 	if (ret)
@@ -576,8 +579,6 @@ static int stm_thermal_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	sensor->mode = THERMAL_DEVICE_DISABLED;
-
 	return 0;
 }
 
@@ -590,7 +591,6 @@ static int stm_thermal_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	sensor->mode = THERMAL_DEVICE_ENABLED;
 
 	return 0;
 }
@@ -718,8 +718,6 @@ static int stm_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_tz;
 
-	sensor->mode = THERMAL_DEVICE_ENABLED;
-
 	dev_info(&pdev->dev, "%s: Driver initialized successfully\n",
 		 __func__);
 
-- 
2.17.1

