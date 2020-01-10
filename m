Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 958FF136ADC
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgAJKQw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:16:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27732 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727362AbgAJKQf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:16:35 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AAE8E0029396;
        Fri, 10 Jan 2020 11:16:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=kcy7DkskaCndOk2uMSVaKAbzzWhKEKw+tCSsEu32ubU=;
 b=LfinnW0p1IsXpjDD/uOJsL3tBkR0y/BmQahnQsGTYsudwe0RbdzghuH+F0pqurgkzU4j
 jB0ui606qts15SzIUfensSzRKING68TrVyn5a74qnxtfpAOQP7agPnE3GjcuZXv/NtgJ
 8gyv0kx3CcuP5u88l/1V536zaokG8amhVv/RFljhAZnJYqEnddZ77LfLjP0CEXnufzyc
 357fJ6+324nsWMf9qMu16oe9hlrd5lR9tbbBwD9SVoA+YRCCERSGQ/QUqgCJbrQuKDTx
 e7ZKBqe/4KuQjUXNgXsIyNl152/10Cyhi6qOfrVEsVDWaJLw+SY8Fb7fGq1S1sTDAUwo dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakkb742c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 11:16:12 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 93545100038;
        Fri, 10 Jan 2020 11:16:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 841702A7906;
        Fri, 10 Jan 2020 11:16:10 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
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
Subject: [PATCH_V3 3/6] thermal: stm32: disable interrupts at probe
Date:   Fri, 10 Jan 2020 11:16:02 +0100
Message-ID: <20200110101605.24984-4-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110101605.24984-1-p.paillet@st.com>
References: <20200110101605.24984-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In case of CPU reset, the interrupts could be enabled at boot time.
Disable interrupts and clear flags.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 drivers/thermal/st/stm_thermal.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index a21fa7e0c72b..679d38867206 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -51,6 +51,12 @@
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
@@ -330,12 +336,10 @@ static int stm_disable_irq(struct stm_thermal_sensor *sensor)
 {
 	u32 value;
 
-	/* Disable IT generation for low and high thresholds */
+	/* Disable IT generation */
 	value = readl_relaxed(sensor->base + DTS_ITENR_OFFSET);
-	writel_relaxed(value & ~(LOW_THRESHOLD | HIGH_THRESHOLD),
-		       sensor->base + DTS_ITENR_OFFSET);
-
-	dev_dbg(sensor->dev, "%s: IT disabled on sensor side", __func__);
+	value &= ~ITENR_MASK;
+	writel_relaxed(value, sensor->base + DTS_ITENR_OFFSET);
 
 	return 0;
 }
@@ -645,6 +649,11 @@ static int stm_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(sensor->clk);
 	}
 
+	stm_disable_irq(sensor);
+
+	/* Clear irq flags */
+	writel_relaxed(ICIFR_MASK, sensor->base + DTS_ICIFR_OFFSET);
+
 	/* Register IRQ into GIC */
 	ret = stm_register_irq(sensor);
 	if (ret)
-- 
2.17.1

