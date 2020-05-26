Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE91E253E
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgEZPRa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 11:17:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728637AbgEZPRS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 11:17:18 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QFBxuh017911;
        Tue, 26 May 2020 17:16:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=5Rg4znNj42bzqjnolZJ9lV8rYKa4nFxeh6irBMvctcs=;
 b=ZJ2hInnnSvYQ638CgiFTDp+jSj5/oidFxGSA9sSM2XMhqc62QR9HNVaLncNLEIXTlN5p
 ER9JTb3KxLPPCnv5R6HHhsfzXAGop93eNUX31yoR0c2iZM0IAnNWdbuG+Ctsxra/WIJn
 PT0L9XDXZYuKr4OgrITF+Pv2aLdTkzkexmC9L6OGQbIAuaZXL4x8M5gOdj0yN7Uku2/J
 poaJN/R1cRZtm2XPk/C6fkZmtuoTfbN3MPkGMk8uYvcX1X5AvnwPGeEZEfZlOs9UKl/Z
 mgTu5n1NvqKFkTQpFm6riYPd9ag77GGTFGfTR5wQltucbYf6AMumYRWBUOUzviSprDg8 Wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316rya8ff0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 17:16:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C6EF510002A;
        Tue, 26 May 2020 17:16:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5EF32C1DA0;
        Tue, 26 May 2020 17:16:27 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 May 2020 17:16:27
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <hugues.fruchet@st.com>, <mchehab@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <pavel@ucw.cz>, <len.brown@intel.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [RFC 2/3] cpufreq: governor: Use minimum load QoS
Date:   Tue, 26 May 2020 17:16:18 +0200
Message-ID: <20200526151619.8779-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200526151619.8779-1-benjamin.gaignard@st.com>
References: <20200526151619.8779-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make sure that the returned load is above the system-wide minimum
load QoS.
Devices could set this specific QoS to inform governors about their
need in terms of CPU load when computing it from idle time isn't accurate.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/cpufreq/cpufreq_governor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f99ae45efaea..1494e5e4c788 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -118,6 +118,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 	unsigned int ignore_nice = dbs_data->ignore_nice_load;
 	unsigned int max_load = 0, idle_periods = UINT_MAX;
 	unsigned int sampling_rate, io_busy, j;
+	unsigned int qos_min_load;
 
 	/*
 	 * Sometimes governors may use an additional multiplier to increase
@@ -225,6 +226,10 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 
 	policy_dbs->idle_periods = idle_periods;
 
+	qos_min_load = cpufreq_minload_qos_limit();
+	if (qos_min_load > max_load)
+		max_load = qos_min_load;
+
 	return max_load;
 }
 EXPORT_SYMBOL_GPL(dbs_update);
-- 
2.15.0

