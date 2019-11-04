Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FABEE135
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 14:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfKDNbC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 08:31:02 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27212 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728783AbfKDNax (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 08:30:53 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4DHO6w008716;
        Mon, 4 Nov 2019 14:30:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=HvQIh1/ibvktD1tZoDncL55wuWS1ZeX9ziVeLdmOO2Q=;
 b=G+0uRnUZXqEzuJC6YvVUy9xMCU77kKVy9DPCscoEZJ/uTQAp8Nuy4oE9GIieVN3PZ4x+
 tanqLkuqMwWFnva/v87XrD9QQ8PZo/UEWFKvrz65wRNpWb8d5PyeOsExwyRov/tuRQRQ
 Bq5cevaFHYrEZqTKObUd18OHCSKaRQlMZxWkJF/NKN+Amo34BFE/V3yG1HhVCbJ1svfl
 W1K6+DhlFiWbfDuNaOtuTAivIrAWv7ewfdRUeDsXaKtGkfQBE+G6n+XqWVlEuL/y3vJm
 YH6FPR+LB/ULMVDPio66uIktYsK97+ToLTytZQRH/KnYbdxE5VGd4wqZ7mEWKebxRy4F FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w1054hnty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 14:30:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9044010003E;
        Mon,  4 Nov 2019 14:30:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8221D2D379E;
        Mon,  4 Nov 2019 14:30:26 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG6NODE2.st.com (10.75.127.17)
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
Subject: [PATCH v2 5/5] thermal: stm32: fix low threshold interrupt flood
Date:   Mon, 4 Nov 2019 14:30:20 +0100
Message-ID: <20191104133020.8820-6-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104133020.8820-1-p.paillet@st.com>
References: <20191104133020.8820-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_08:2019-11-04,2019-11-04 signatures=0
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
index 9986716b17c1..f7168762fbde 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -324,7 +324,8 @@ static int stm_thermal_set_trips(void *data, int low, int high)
 
 	if (low > -INT_MAX) {
 		sensor->low_temp_enabled = 1;
-		ret = stm_thermal_calculate_threshold(sensor, low, &th);
+		/* add 0.5 of hysteresis due to measurement error */
+		ret = stm_thermal_calculate_threshold(sensor, low - 500, &th);
 		if (ret)
 			return ret;
 
-- 
2.17.1

