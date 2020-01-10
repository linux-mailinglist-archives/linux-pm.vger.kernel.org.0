Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3B136AD5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgAJKQh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:16:37 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23052 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727452AbgAJKQg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:16:36 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AAE3Yq031197;
        Fri, 10 Jan 2020 11:16:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=AAD/GToJl17SoA/ncPjv8bRydogH2ZBtCfUpPZ40ub0=;
 b=zpzL2mKRX3XGn9bOo1I7gmQD4k8aW36S5+loLQuhg/U2FX8Zy9tx3LU9PvGDkccAfS3L
 nMQyx8AO/LbrSHjrFvlp8s5SWocc15VluEjiN6j9OZM5WHGW81paA0Qtd4pUuiCn188w
 ZPsF7j0IWLJgh3SYnzlfDisKc0MG/+p6WSOnaHQNUpn0w+iEA2fiSm9dkvQowp1/1rMs
 GG6k3bPmUujVOdYPXcrvMOJhCC9cxc1lehVrKdV1k/GqRSZ7Krj9aCTtpBXy5kGcMs5t
 iSZR1hTQRBc1OphTho7YI3NKeg8ouiv6/FYHeH+pDuu/ky3AtbrGiWWtD47VNKC6eXoA 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xepyt83ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 11:16:18 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BFA92100038;
        Fri, 10 Jan 2020 11:16:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B1AFE2A7907;
        Fri, 10 Jan 2020 11:16:12 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Jan 2020 11:16:12
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
Subject: [PATCH_V3 6/6] thermal: stm32: fix low threshold interrupt flood
Date:   Fri, 10 Jan 2020 11:16:05 +0100
Message-ID: <20200110101605.24984-7-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110101605.24984-1-p.paillet@st.com>
References: <20200110101605.24984-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the STM32 thermal peripheral, it is not possible to dump the
temperature that has caused the interrupt.
When the temperature reaches the low threshold, we generally read
a temperature that is a little bit higher than the low threshold.
This maybe due to sampling precision, and also because the CPU becomes
hotter when it quits WFI mode.
In that case, the framework does not change the trip points. This leads
to a lot of low threshold interrupts.

The fix is to set the low threshold value 0.5 degrees Celsius
below the actual request.

The problem is not so frequent with the high threshold and it would
no be a good idea to set the threshold value higher than the request.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 drivers/thermal/st/stm_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index aaf25ca2f118..1cc5e6c5709e 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -321,7 +321,8 @@ static int stm_thermal_set_trips(void *data, int low, int high)
 
 	if (low > -INT_MAX) {
 		sensor->low_temp_enabled = 1;
-		ret = stm_thermal_calculate_threshold(sensor, low, &th);
+		/* add 0.5 of hysteresis due to measurement error */
+		ret = stm_thermal_calculate_threshold(sensor, low - 500, &th);
 		if (ret)
 			return ret;
 
-- 
2.17.1

