Return-Path: <linux-pm+bounces-8541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC98D8A2B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 21:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54A31F25ABD
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0BD13B5A1;
	Mon,  3 Jun 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mf9yPV/Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585B13B588;
	Mon,  3 Jun 2024 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442854; cv=none; b=akhGiHJqQySggrUvCvdR+S5wstmaVpsrOvj0EkjMoPHCOxsHCOX+bcu8W0dtHmAbwkilWH6qnoWnVwVB4CZurACHUzOC24klue1LK2tIaomwaTWOhnHklW3R0hWi8Ho8qvRxYtB1tkaDPjDpNJ3SJG+1WOsQ0xQO+Ca7PZhA234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442854; c=relaxed/simple;
	bh=HLsZL7u7067moMzrolBSvWIvdWRJpnhHQVzFAgy6EF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApybYcY1ZIqn6pGF0R2NzQDm+uMn7Ga7m+JNW+vfM/t2ijvT5e28J9jMCno6lf0nHCpRI0aEvIZ5v5ghLzu2f4ORGygCi5B8oRHIj4JNpPX+XuQnHDJtbaYahq1/QCNbLYKD9863iVBkryBInpbmqUWfOU6T77f5Y/qYjvYTnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mf9yPV/Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453C6dar019807;
	Mon, 3 Jun 2024 19:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Wbde8YI0XAKicrSrvhYlvfySXEfjzTuZ3lNB6UsJas=; b=Mf9yPV/Y9FRwwvxE
	asnj66DNYgBxAOyN58Q1y2HhZLYmTzmWaJ6jbixwPcH04Vu8gclcXK+tWr5HA89Q
	x68t2lhswXTX92GF2FAhFXIFKo5Do1kbOqFiJra/gvMEOe1YFUGkDV4rXXV1Vwle
	SE+CoUmjNQE2TB08cWpVixDJOKPcFf6hXYDYLJ5UoWxrCnVVA54weP/R+CLC0ZNT
	H9qmd6pPzKPtWjqgK2dKyuYr29WMz5Sf8GlPechc1auuxrQMHFPIH0HzgwNi89lX
	nXsxcI6A9eOLhaLqQ+4cnjGydFM0OaeHfSrl0EIk7AdjBGGhlzStbBWdi+wk20M3
	IaP9Jg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5t4k9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 19:27:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453JRKRb000495
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 19:27:20 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 12:27:15 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>, <vincent.guittot@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V5 1/1] cpufreq: scmi: Register for limit change notifications
Date: Tue, 4 Jun 2024 00:56:54 +0530
Message-ID: <20240603192654.2167620-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603192654.2167620-1-quic_sibis@quicinc.com>
References: <20240603192654.2167620-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mRYQMOihypBlEXyrnlrXqo8nHX_SJgnJ
X-Proofpoint-GUID: mRYQMOihypBlEXyrnlrXqo8nHX_SJgnJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030158

Register for limit change notifications if supported and use the throttled
frequency from the notification to apply HW pressure.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v5:
* Drop patch 1 and use pm_qos to update constraints. [Vincent]
* Use sdev instead of cpu_dev in dev_warn. [Christian]
* Pass sdev directly through private data. [Christian]
* Dropping Rb's for now.

 drivers/cpufreq/scmi-cpufreq.c | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index b87fd127aa43..0edfa55d8e49 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/scmi_protocol.h>
 #include <linux/types.h>
@@ -25,7 +26,9 @@ struct scmi_data {
 	int domain_id;
 	int nr_opp;
 	struct device *cpu_dev;
+	struct cpufreq_policy *policy;
 	cpumask_var_t opp_shared_cpus;
+	struct notifier_block limit_notify_nb;
 };
 
 static struct scmi_protocol_handle *ph;
@@ -174,6 +177,25 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
 	NULL,
 };
 
+static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
+	struct scmi_perf_limits_report *limit_notify = data;
+	struct cpufreq_policy *policy = priv->policy;
+	unsigned int limit_freq_khz;
+	int ret;
+
+	limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
+
+	policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
+
+	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
+	if (ret < 0)
+		pr_warn("failed to update freq constraint: %d\n", ret);
+
+	return NOTIFY_OK;
+}
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, nr_opp, domain;
@@ -181,6 +203,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
+	struct scmi_device *sdev = cpufreq_get_driver_data();
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -294,6 +317,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		}
 	}
 
+	priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
+	ret = sdev->handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_PERF,
+							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
+							&domain,
+							&priv->limit_notify_nb);
+	if (ret)
+		dev_warn(&sdev->dev,
+			 "failed to register for limits change notifier for domain %d\n", domain);
+
+	priv->policy = policy;
+
 	return 0;
 
 out_free_opp:
@@ -372,6 +406,8 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 	if (!handle)
 		return -ENODEV;
 
+	scmi_cpufreq_driver.driver_data = sdev;
+
 	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
 	if (IS_ERR(perf_ops))
 		return PTR_ERR(perf_ops);
-- 
2.34.1


