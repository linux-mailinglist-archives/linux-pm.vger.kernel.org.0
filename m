Return-Path: <linux-pm+bounces-16293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952259AC7B7
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58B81C2268E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497051AA7A5;
	Wed, 23 Oct 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dn9aOaQU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A21A3A8D;
	Wed, 23 Oct 2024 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678955; cv=none; b=LWz29du5UzEQrEgnO88t7H56ZH4OVZN6KO6dhDFk3sK1C5e6GSDSxpbu45/DrxNrYlkzXR9Nw4qjQuZwtDhqfKuCd3rsc3hXg+Yxa3XZgJ6n5pmORb0UK76TN4oWBcKf7DOaKy3YL52tbAi9WulxJCr21uhnHxmf83xKKpzabxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678955; c=relaxed/simple;
	bh=UbH1ohsDF2CKHqVY99eKOuNWdKUZ4+Yt+cMdjDn0w4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsVwLbh79gRsCIWwj4qk44Zg8RZA/LzlLpWKGjbPp4D3h0K1RVzeCTFIbtqipGroyNChZhf4iTf6jJf3PwStYMzcSHgwKHv4cLQi8AO7lC21MNobrMS4wFngOIwzepeUyxMaYRhXSkUuUnVz/yMa9oYQc/aczpJbu0D5gVicKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dn9aOaQU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9MLis031271;
	Wed, 23 Oct 2024 10:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N9thzI2s9qip/T79oZliExDHbQAqsITN4CwToGHt28Q=; b=dn9aOaQU6PXp8Q/6
	ixVAuX6WKDks88F2Ey84Og/gvgTSyUa2SXamDqk+CvDoJ+KI70sx9l95PFS7y6L0
	T2ilBsDSnIK8R+5D8DVLg6r0XcgB7cNOLG7xW/pn+ynyQk+G8tiFtYdVpvBUgo+5
	pgFuEg3kGx/1sp6tAA96YruN/SVe5qtgQ9jW83djHPt9Ci5B6Kz4Xz3ebktVD8Ap
	oTFBu6pt2DxJUazIls1hda8zlZFioOzUMFmeY7CZFa8zJ1whHqTzLbChffbGc8q+
	OVSkF149QhD7cufV5E7H0ns21QA4MeBQpcJu3uNcpiS0KOpH/xjPqtXHHWVTsFcM
	GJhfGw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3vsu7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 10:22:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NAMKdb010205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 10:22:21 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Oct 2024 03:22:16 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <johan@kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>,
        "Johan Hovold" <johan+linaro@kernel.org>
Subject: [PATCH V4 3/4] pmdomain: core: Fix debugfs node creation failure
Date: Wed, 23 Oct 2024 15:51:47 +0530
Message-ID: <20241023102148.1698910-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023102148.1698910-1-quic_sibis@quicinc.com>
References: <20241023102148.1698910-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: oMv9eqmeUCp-SpNGElq7Gzy8DpaZYZnT
X-Proofpoint-ORIG-GUID: oMv9eqmeUCp-SpNGElq7Gzy8DpaZYZnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230063

The domain attributes returned by the perf protocol can end up
reporting identical names across domains, resulting in debugfs
node creation failure. Fix this failure by ensuring that pm domains
get a unique name using ida in pm_genpd_init.

Logs: [X1E reports 'NCC' for all its scmi perf domains]
debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
debugfs: Directory 'NCC' with parent 'pm_genpd' already present!

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3:
* Update device names only when a name collision occurs [Dmitry/Ulf]
* Drop Johan's T-b from "fix debugfs node creation failure"

 drivers/pmdomain/core.c   | 65 ++++++++++++++++++++++++++++++---------
 include/linux/pm_domain.h |  1 +
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 76490f0bf1e2..756ed0975788 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "PM: " fmt
 
 #include <linux/delay.h>
+#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -23,6 +24,9 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 
+/* Provides a unique ID for each genpd device */
+static DEFINE_IDA(genpd_ida);
+
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
@@ -189,7 +193,7 @@ static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 
 	if (ret)
 		dev_warn_once(dev, "PM domain %s will not be powered off\n",
-				genpd->name);
+			      dev_name(&genpd->dev));
 
 	return ret;
 }
@@ -274,7 +278,7 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
 	if (!genpd_debugfs_dir)
 		return;
 
-	debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
+	debugfs_lookup_and_remove(dev_name(&genpd->dev), genpd_debugfs_dir);
 }
 
 static void genpd_update_accounting(struct generic_pm_domain *genpd)
@@ -731,7 +735,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
 	genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
-		 genpd->name, "on", elapsed_ns);
+		 dev_name(&genpd->dev), "on", elapsed_ns);
 
 out:
 	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
@@ -782,7 +786,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
 	genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
-		 genpd->name, "off", elapsed_ns);
+		 dev_name(&genpd->dev), "off", elapsed_ns);
 
 out:
 	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
@@ -1941,7 +1945,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb)
 
 	if (ret) {
 		dev_warn(dev, "failed to add notifier for PM domain %s\n",
-			 genpd->name);
+			 dev_name(&genpd->dev));
 		return ret;
 	}
 
@@ -1988,7 +1992,7 @@ int dev_pm_genpd_remove_notifier(struct device *dev)
 
 	if (ret) {
 		dev_warn(dev, "failed to remove notifier for PM domain %s\n",
-			 genpd->name);
+			 dev_name(&genpd->dev));
 		return ret;
 	}
 
@@ -2014,7 +2018,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	 */
 	if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
 		WARN(1, "Parent %s of subdomain %s must be IRQ safe\n",
-				genpd->name, subdomain->name);
+		     dev_name(&genpd->dev), subdomain->name);
 		return -EINVAL;
 	}
 
@@ -2089,7 +2093,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 
 	if (!list_empty(&subdomain->parent_links) || subdomain->device_count) {
 		pr_warn("%s: unable to remove subdomain %s\n",
-			genpd->name, subdomain->name);
+			dev_name(&genpd->dev), subdomain->name);
 		ret = -EBUSY;
 		goto out;
 	}
@@ -2199,6 +2203,23 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 	}
 }
 
+static bool genpd_name_present(const char *name)
+{
+	bool ret = false;
+	const struct generic_pm_domain *gpd;
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+		if (!strcmp(dev_name(&gpd->dev), name)) {
+			ret = true;
+			break;
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
+}
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -2226,6 +2247,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
+	genpd->device_id = -ENXIO;
 	genpd->has_provider = false;
 	genpd->accounting_time = ktime_get_mono_fast_ns();
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
@@ -2266,7 +2288,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		return ret;
 
 	device_initialize(&genpd->dev);
-	dev_set_name(&genpd->dev, "%s", genpd->name);
+
+	if (!genpd_name_present(genpd->name)) {
+		dev_set_name(&genpd->dev, "%s", genpd->name);
+	} else {
+		ret = ida_alloc(&genpd_ida, GFP_KERNEL);
+		if (ret < 0) {
+			put_device(&genpd->dev);
+			return ret;
+		}
+		genpd->device_id = ret;
+		dev_set_name(&genpd->dev, "%s_%u", genpd->name, genpd->device_id);
+	}
 
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
@@ -2288,13 +2321,13 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 
 	if (genpd->has_provider) {
 		genpd_unlock(genpd);
-		pr_err("Provider present, unable to remove %s\n", genpd->name);
+		pr_err("Provider present, unable to remove %s\n", dev_name(&genpd->dev));
 		return -EBUSY;
 	}
 
 	if (!list_empty(&genpd->parent_links) || genpd->device_count) {
 		genpd_unlock(genpd);
-		pr_err("%s: unable to remove %s\n", __func__, genpd->name);
+		pr_err("%s: unable to remove %s\n", __func__, dev_name(&genpd->dev));
 		return -EBUSY;
 	}
 
@@ -2308,9 +2341,11 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	genpd_unlock(genpd);
 	genpd_debug_remove(genpd);
 	cancel_work_sync(&genpd->power_off_work);
+	if (genpd->device_id != -ENXIO)
+		ida_free(&genpd_ida, genpd->device_id);
 	genpd_free_data(genpd);
 
-	pr_debug("%s: removed %s\n", __func__, genpd->name);
+	pr_debug("%s: removed %s\n", __func__, dev_name(&genpd->dev));
 
 	return 0;
 }
@@ -3320,12 +3355,12 @@ static int genpd_summary_one(struct seq_file *s,
 	else
 		snprintf(state, sizeof(state), "%s",
 			 status_lookup[genpd->status]);
-	seq_printf(s, "%-30s  %-30s  %u", genpd->name, state, genpd->performance_state);
+	seq_printf(s, "%-30s  %-30s  %u", dev_name(&genpd->dev), state, genpd->performance_state);
 
 	/*
 	 * Modifications on the list require holding locks on both
 	 * parent and child, so we are safe.
-	 * Also genpd->name is immutable.
+	 * Also the device name is immutable.
 	 */
 	list_for_each_entry(link, &genpd->parent_links, parent_node) {
 		if (list_is_first(&link->parent_node, &genpd->parent_links))
@@ -3550,7 +3585,7 @@ static void genpd_debug_add(struct generic_pm_domain *genpd)
 	if (!genpd_debugfs_dir)
 		return;
 
-	d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
+	d = debugfs_create_dir(dev_name(&genpd->dev), genpd_debugfs_dir);
 
 	debugfs_create_file("current_state", 0444,
 			    d, genpd, &status_fops);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 76775ab38898..1106b86de279 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -171,6 +171,7 @@ struct generic_pm_domain {
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
 	unsigned int device_count;	/* Number of devices */
+	unsigned int device_id;		/* unique device id */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */
-- 
2.34.1


