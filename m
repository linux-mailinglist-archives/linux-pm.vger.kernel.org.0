Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB9DEE137
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 14:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfKDNaw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 08:30:52 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50814 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729058AbfKDNav (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 08:30:51 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4DHK7C008695;
        Mon, 4 Nov 2019 14:30:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=poGuxiksbd1+m08n39wqdhvTjgQ3Np+ues1IrMNq2zc=;
 b=sFszNMSAoL+e8Qpajej6/iL5t9I6gWN/2ipnLsQHek3AiIr1XmVlchU8Wrq3A71q78/b
 elEW1e199F2vZoEgdlfFCum8VAkZGo+h2iYQ/zUrmkNG27ilNxJk8MS7Hno0e1ZVVfTx
 6i6YXW4j/YshjBoQ630fa3o9rERnFsJtgQRQWV+rmf5DJ1xektDDrgj2txa/QXnRIK1Z
 +e46v5LBXdKsIR5rifEjxYrFPMoJrrsW2t3oala1+FarhW4OgYNdhctY3NHy36QJaCrm
 cKKeeG2fxZu6mctatH1/9mDCek/yYRuCHEYclHS/hgHDmlmxuEDiCXmNqkbX67R9UMor Pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w1054hntt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 14:30:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ADD4110003A;
        Mon,  4 Nov 2019 14:30:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9D0AD2FF5C2;
        Mon,  4 Nov 2019 14:30:23 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 4 Nov 2019 14:30:22
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
Subject: [PATCH v2 1/5] thermal: stm32: remove hardware irq handler
Date:   Mon, 4 Nov 2019 14:30:16 +0100
Message-ID: <20191104133020.8820-2-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104133020.8820-1-p.paillet@st.com>
References: <20191104133020.8820-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_08:2019-11-04,2019-11-04 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove hardware irq handler because it is not needed to disable the
interrupt before the threaded handler. The goal is to simplify
the code.

Change-Id: Ida967e8543c8dafc6a24508000f64f6405add31d
---
 drivers/thermal/st/stm_thermal.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index cf9ddc52f30e..31aa63fb3db1 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -98,21 +98,10 @@ struct stm_thermal_sensor {
 	unsigned int low_temp_enabled;
 	int num_trips;
 	int irq;
-	unsigned int irq_enabled;
 	void __iomem *base;
 	int t0, fmt0, ramp_coeff;
 };
 
-static irqreturn_t stm_thermal_alarm_irq(int irq, void *sdata)
-{
-	struct stm_thermal_sensor *sensor = sdata;
-
-	disable_irq_nosync(irq);
-	sensor->irq_enabled = false;
-
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t stm_thermal_alarm_irq_thread(int irq, void *sdata)
 {
 	u32 value;
@@ -464,16 +453,6 @@ static int stm_thermal_get_temp(void *data, int *temp)
 			if (ret)
 				return ret;
 		}
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
 	}
 
 	return 0;
@@ -493,7 +472,7 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 	}
 
 	ret = devm_request_threaded_irq(dev, sensor->irq,
-					stm_thermal_alarm_irq,
+					NULL,
 					stm_thermal_alarm_irq_thread,
 					IRQF_ONESHOT,
 					dev->driver->name, sensor);
@@ -503,8 +482,6 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 		return ret;
 	}
 
-	sensor->irq_enabled = true;
-
 	dev_dbg(dev, "%s: thermal IRQ registered", __func__);
 
 	return 0;
-- 
2.17.1

