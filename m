Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226F51E253A
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgEZPRS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 11:17:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38500 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728205AbgEZPRR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 11:17:17 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QFDG8V007562;
        Tue, 26 May 2020 17:16:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=f15cWn5l7+qnePYQkKeXeKN4S4ucsruNAsfQ5NRJgnw=;
 b=zpX6gM+963osYSTNm0NetVZRMoM9e8ye4AfJof65ff2WaNs3AZWKAyCrGWZ0mKNa0avq
 M7epb9sAZb7vr4G3rGWmmRxm0NJeqUtG6ytTtelsiMqU2jglLeE4cRICnyvF5Kwyk+QZ
 tRJ3PGRxR0XyqVESMIk1WuoNpUriT4FZmybFnruS3bZJRjXOstoRO4YlqGTAxZtQjZ+J
 /Q9riOB8lFLuumg1MJkP2ytirbUl9PF/y71J+NeNorKQorPZApwmkq85xXZIzEeyFOUC
 vg4mNSYsJRSPFUJp2nUdLUEGN0JLxixtZ8ogBlFJgTPT0Lrxjrz+4h1bjyrOezGuEINn rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316tqh04wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 17:16:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0AB3410002A;
        Tue, 26 May 2020 17:16:29 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EE0F02C1DA0;
        Tue, 26 May 2020 17:16:28 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 May 2020 17:16:28
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
Subject: [RFC 3/3] media: stm32-dcmi: Inform cpufreq governors about cpu load needs
Date:   Tue, 26 May 2020 17:16:19 +0200
Message-ID: <20200526151619.8779-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200526151619.8779-1-benjamin.gaignard@st.com>
References: <20200526151619.8779-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When start streaming the CPU load could remain very low because almost
all the capture pipeline is done in hardware (i.e. without using the CPU)
and let believe to cpufreq governor that it could use lower frequencies.
If the governor decides to use a too low frequency that becomes a problem
when we need to acknowledge the interrupt during the blanking time.

To avoid this problem, DCMI driver informs the cpufreq governors by adding
a cpufreq minimum load QoS resquest.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index b8931490b83b..774f2506b2f1 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -24,6 +24,7 @@
 #include <linux/of_graph.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/videodev2.h>
@@ -173,6 +174,8 @@ struct stm32_dcmi {
 	struct media_device		mdev;
 	struct media_pad		vid_cap_pad;
 	struct media_pipeline		pipeline;
+
+	struct pm_qos_request		qos_request;
 };
 
 static inline struct stm32_dcmi *notifier_to_dcmi(struct v4l2_async_notifier *n)
@@ -827,6 +830,9 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	else
 		reg_set(dcmi->regs, DCMI_IER, IT_OVR | IT_ERR);
 
+	cpufreq_minload_qos_add_request(&dcmi->qos_request,
+					CPUFREQ_GOV_QOS_MIN_LOAD_MAX_VALUE);
+
 	return 0;
 
 err_pipeline_stop:
@@ -859,6 +865,8 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
 	struct stm32_dcmi *dcmi = vb2_get_drv_priv(vq);
 	struct dcmi_buf *buf, *node;
 
+	cpufreq_minload_qos_remove_request(&dcmi->qos_request);
+
 	dcmi_pipeline_stop(dcmi);
 
 	media_pipeline_stop(&dcmi->vdev->entity);
-- 
2.15.0

