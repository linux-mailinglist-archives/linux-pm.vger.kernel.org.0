Return-Path: <linux-pm+bounces-9847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1784191414A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE1F1F218E6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 04:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36CDDDC;
	Mon, 24 Jun 2024 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CDBkDEL8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC5168A9;
	Mon, 24 Jun 2024 04:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719204578; cv=none; b=NaYwKHGYlXqYI6vvdClGkU/sZEwSqZwlVaMASImCr+mjkSabrLsk9uZIz4sWbpoqx3X4qzWV0E55Wyh4DuNb5OoGRm2jLLZl4DBzYlTggCAr09n//oZaxrO71XvAj7bL5JFuxq9MHvujNUdj0PlbpyOItZNLcGGBcjK2PW4/JEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719204578; c=relaxed/simple;
	bh=JUVqGjz1iRAWkVa4AnQh84lQcbsn6IWnYiyewY7joow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAHSGgiB/mMIkk8f5dsjMA1pGVGyZ0lWt6UfZIlrs/4X5FqyUeMMeduRZOdHFXPEc53jqaI3y0DG/r7a9PcpZnAkU6kvQem+pGX2vVI+7JJOInLd/KO5WotvZSOkFzu2RMZMYzNXTNIXOq3A7nKU7gJnLl0R2U5t5OeD9JjVvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CDBkDEL8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O002I9001481;
	Mon, 24 Jun 2024 04:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UCccK02F7BsWYZLV8xPiXaTuhg11aJN+SpDz5ei1w84=; b=CDBkDEL8WzlR3ngZ
	2qHbrZwrWsD8fHIDqajNdxeJcdxEwY0DbMDvvRbkN3mObB+igpvBfLtc8Ns5M6pJ
	v+IGEZRVVn2Umx26aMM2qoqX37W8+NVd5/Kl/xeV2Zp5d5oMzo0etKQGzb4dLJVH
	0NGctVvv3YDDBU8SIP508chRQQkbYW5srlIuncQmw5QcpNx3gQqIE5GHRP1ymd+F
	bM6YsVDx0nXmOzMDW+DLOo+cRfKf7xlyCWKDPtXikQmStzz6xiDPb75cDn8T4ztl
	FmBWalMff5I0nGZvr+cZdfjEe1HNzjwOgObAivDGUfHfMZff1KkodA5brwaq/1fX
	jv5sDg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnxgtn28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 04:49:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O4nMRc027585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 04:49:22 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 21:49:14 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Andy
 Gross" <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit
 Pandey" <quic_ajipan@quicinc.com>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V7 1/5] PM: domains: Allow devices attached to genpd to be managed by HW
Date: Mon, 24 Jun 2024 10:18:05 +0530
Message-ID: <20240624044809.17751-2-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624044809.17751-1-quic_jkona@quicinc.com>
References: <20240624044809.17751-1-quic_jkona@quicinc.com>
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
X-Proofpoint-GUID: 5wNgf1EP9m8lk3MFgIf_p1PQL4cP6pcn
X-Proofpoint-ORIG-GUID: 5wNgf1EP9m8lk3MFgIf_p1PQL4cP6pcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240036

From: Ulf Hansson <ulf.hansson@linaro.org>

Some power-domains may be capable of relying on the HW to control the power
for a device that's hooked up to it. Typically, for these kinds of
configurations the consumer driver should be able to change the behavior of
power domain at runtime, control the power domain in SW mode for certain
configurations and handover the control to HW mode for other usecases.

To allow a consumer driver to change the behaviour of the PM domain for its
device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
which the genpd provider should implement if it can support switching
between HW controlled mode and SW controlled mode. Similarly, add the
dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
its corresponding optional genpd callback, ->get_hwmode_dev(), which the
genpd provider can also implement to synchronize the initial HW mode
state in genpd_add_device() by reading back the mode from the hardware.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Taniya Das <quic_tdas@quicinc.com>
---
 drivers/pmdomain/core.c   | 64 +++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h | 17 +++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 83d978743659..a9a409b2d25c 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -588,6 +588,68 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
 
+/**
+ * dev_pm_genpd_set_hwmode() - Set the HW mode for the device and its PM domain.
+ *
+ * @dev: Device for which the HW-mode should be changed.
+ * @enable: Value to set or unset the HW-mode.
+ *
+ * Some PM domains can rely on HW signals to control the power for a device. To
+ * allow a consumer driver to switch the behaviour for its device in runtime,
+ * which may be beneficial from a latency or energy point of view, this function
+ * may be called.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Return: Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
+{
+	struct generic_pm_domain *genpd;
+	int ret = 0;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	if (!genpd->set_hwmode_dev)
+		return -EOPNOTSUPP;
+
+	genpd_lock(genpd);
+
+	if (dev_gpd_data(dev)->hw_mode == enable)
+		goto out;
+
+	ret = genpd->set_hwmode_dev(genpd, dev, enable);
+	if (!ret)
+		dev_gpd_data(dev)->hw_mode = enable;
+
+out:
+	genpd_unlock(genpd);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_set_hwmode);
+
+/**
+ * dev_pm_genpd_get_hwmode() - Get the HW mode setting for the device.
+ *
+ * @dev: Device for which the current HW-mode setting should be fetched.
+ *
+ * This helper function allows consumer drivers to fetch the current HW mode
+ * setting of its the device.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Return: Returns the HW mode setting of device from SW cached hw_mode.
+ */
+bool dev_pm_genpd_get_hwmode(struct device *dev)
+{
+	return dev_gpd_data(dev)->hw_mode;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -1687,6 +1749,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
 
+	gpd_data->hw_mode = genpd->get_hwmode_dev ? genpd->get_hwmode_dev(genpd, dev) : false;
+
 	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
 	if (ret)
 		goto out;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 71e4f0fb8867..858c8e7851fb 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -175,6 +175,10 @@ struct generic_pm_domain {
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
+	int (*set_hwmode_dev)(struct generic_pm_domain *domain,
+			      struct device *dev, bool enable);
+	bool (*get_hwmode_dev)(struct generic_pm_domain *domain,
+			      struct device *dev);
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
@@ -237,6 +241,7 @@ struct generic_pm_domain_data {
 	unsigned int performance_state;
 	unsigned int default_pstate;
 	unsigned int rpm_pstate;
+	bool hw_mode;
 	void *data;
 };
 
@@ -267,6 +272,8 @@ int dev_pm_genpd_remove_notifier(struct device *dev);
 void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
 ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 void dev_pm_genpd_synced_poweroff(struct device *dev);
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
+bool dev_pm_genpd_get_hwmode(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -340,6 +347,16 @@ static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
 static inline void dev_pm_genpd_synced_poweroff(struct device *dev)
 { }
 
+static inline int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool dev_pm_genpd_get_hwmode(struct device *dev)
+{
+	return false;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.43.0


