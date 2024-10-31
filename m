Return-Path: <linux-pm+bounces-16831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB369B7BAF
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D8D1C20B5D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9B19F47E;
	Thu, 31 Oct 2024 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="COoHFsfq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F71531F2;
	Thu, 31 Oct 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381303; cv=none; b=gFc4q+Z4z0yEg9kJDDfDFrSFjAoPZm88P4qeYV83sxBl++m4bb/ylQw3mnfv43lxsunp9qpua2AOZu2ioFkwRrYbp5l0AnvJlvgbk+0Aojpx3q9zvS4uVw7Y3THqtnUBxW/Px1Mb9cdZcuMG6qgpuvFlUxfRYkKbETqAPJbQbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381303; c=relaxed/simple;
	bh=PYDuYToY7QWYyYJvMiYKKulYNmBF+4nvvRjbuis2mS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCHNHKckRbhagH9+Iu9BAIhmSorug5jUSTPO/O8mP0sLtlAHw84vDEowRExDmdHVhFAcgFzgNFCYPHSn0WvoAwQKbA47iR3hYQ/F5OnX2FuQAPKafi8vyaDLOPX8phLIqjl5UqwvyNP5RVICdZxSYalkJp1TKEAItwUDHIkgOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=COoHFsfq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VD1tgJ027387;
	Thu, 31 Oct 2024 13:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ir45z+XSQ8wQE2H15d0e+YQETH3XktiPMA4VVa38kx0=; b=COoHFsfq9euAr7yk
	QqhrHyTuTruBWEbrHRlKC1vKl6uh6e+/tXCgLd4G5jVhloOAYgHu4w6Eds8PPlT8
	C5AX3R8P6b4f34SZYiFxe5C1IiBXFLpN4TkaScVlW/jtuVDlsUNUDUxNbzl+Tgle
	dElCjZByx8kQ0u6Dtgjf+PfuYlGvwq76HLcbUqCWVq9kHivZtGt5Sn0VUo7KV6Zk
	1Lk4MkmpqXQ3jNEfO/DL/4/LkDDfJNwXuSussYMW9zy5/FuSSBdVh0uKQakiPrrd
	WqX9YDUU+sQiupQfLPFptp9o1LOSQMVAEXvomnT0EpDwv/0NRqGauEJaHXwgsl2b
	JodeHg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k1p37304-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 13:28:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49VDSC2G003273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 13:28:12 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 31 Oct 2024 06:28:07 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>, <vincent.guittot@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V7 2/2] cpufreq: scmi: Register for limit change notifications
Date: Thu, 31 Oct 2024 18:57:45 +0530
Message-ID: <20241031132745.3765612-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031132745.3765612-1-quic_sibis@quicinc.com>
References: <20241031132745.3765612-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4IL5pyBerTaXeq4h4BKEZblqqo_afWgz
X-Proofpoint-ORIG-GUID: 4IL5pyBerTaXeq4h4BKEZblqqo_afWgz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310102

Register for limit change notifications if supported and use the throttled
frequency from the notification to apply HW pressure.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Tested-by: Mike Tipton <quic_mdtipton@quicinc.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---

v7:
* Add a new request instead of reusing the max_freq_req [Vincent]
* Use the non-devm versions of register/unregister of event notifier
  since we have to remove them when the cpus get removed anyway.
* Add new patch to fix cleanup path on boost enablement failure.

 drivers/cpufreq/scmi-cpufreq.c | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 07d6f9a9b7c8..ff13f7d4b2c9 100644
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
@@ -25,7 +26,10 @@ struct scmi_data {
 	int domain_id;
 	int nr_opp;
 	struct device *cpu_dev;
+	struct cpufreq_policy *policy;
 	cpumask_var_t opp_shared_cpus;
+	struct notifier_block limit_notify_nb;
+	struct freq_qos_request	limits_freq_req;
 };
 
 static struct scmi_protocol_handle *ph;
@@ -174,6 +178,25 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
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
+	ret = freq_qos_update_request(&priv->limits_freq_req, policy->max);
+	if (ret < 0)
+		pr_warn("failed to update freq constraint: %d\n", ret);
+
+	return NOTIFY_OK;
+}
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, nr_opp, domain;
@@ -181,6 +204,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
+	struct scmi_device *sdev = cpufreq_get_driver_data();
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -294,6 +318,25 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		}
 	}
 
+	ret = freq_qos_add_request(&policy->constraints, &priv->limits_freq_req, FREQ_QOS_MAX,
+				   FREQ_QOS_MAX_DEFAULT_VALUE);
+	if (ret < 0) {
+		dev_err(cpu_dev, "failed to add qos limits request: %d\n", ret);
+		goto out_free_table;
+	}
+
+	priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
+	ret = sdev->handle->notify_ops->event_notifier_register(sdev->handle, SCMI_PROTOCOL_PERF,
+							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
+							&priv->domain_id,
+							&priv->limit_notify_nb);
+	if (ret)
+		dev_warn(&sdev->dev,
+			 "failed to register for limits change notifier for domain %d\n",
+			 priv->domain_id);
+
+	priv->policy = policy;
+
 	return 0;
 
 out_free_table:
@@ -313,7 +356,13 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 static void scmi_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct scmi_data *priv = policy->driver_data;
+	struct scmi_device *sdev = cpufreq_get_driver_data();
 
+	sdev->handle->notify_ops->event_notifier_unregister(sdev->handle, SCMI_PROTOCOL_PERF,
+							    SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
+							    &priv->domain_id,
+							    &priv->limit_notify_nb);
+	freq_qos_remove_request(&priv->limits_freq_req);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
 	free_cpumask_var(priv->opp_shared_cpus);
@@ -372,6 +421,8 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 	if (!handle)
 		return -ENODEV;
 
+	scmi_cpufreq_driver.driver_data = sdev;
+
 	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
 	if (IS_ERR(perf_ops))
 		return PTR_ERR(perf_ops);
-- 
2.34.1


