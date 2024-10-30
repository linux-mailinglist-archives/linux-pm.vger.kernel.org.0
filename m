Return-Path: <linux-pm+bounces-16730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0B9B6385
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610D61C20613
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9FB1EBFFB;
	Wed, 30 Oct 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dgEb8p0w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2FA1E909B;
	Wed, 30 Oct 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292969; cv=none; b=OYFkJXUDFnryyPHZlEBEYEaxgUf01fLEh12suPqpTViLbM+wYvKJoBnaBxm9d8EE/2SNZSFu7QYwWEjuvKGOtetDkk4yNWlmLp6ys3bYPUAeXkOCfYPVuAF0qaWX/+HHTzA7i0fbRtBIxJP5yyJDyAUi5L+zAOi169BkCaK1H0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292969; c=relaxed/simple;
	bh=1cJAzEb13hCsuVNT43vkOudxwQkG078zf/NptiCnnmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHvCYl30aBRwVhAHu55oHu6/84Tpnu/4w887ID/AVESdlO1VrzWYcYaVTlz4FMpd40I+nKE0QIGuLVl85rqUkr/Q99nafYcUPsUi+L9htz8/WmRivKt5CvJGeDxxRVfvHD59Mj9fOXLzS1pVL6TKiRmge+HJBi4GpZNmqmg3iAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dgEb8p0w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UATBXO001704;
	Wed, 30 Oct 2024 12:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XJ5Ve561ti7AUad4/FzNBwYyZSfBLTPxiwPH4ZqSgtQ=; b=dgEb8p0wGJJz+yPy
	C5E2+SRzAQNlucK5UWlcIJyfh6C7DMv5prCxeJl54bhyKO4LNBBf8uI0x9Tuu063
	pQb5Yxb7G3bzlOng+WP6CYeRd5LYY4+/D8znHNQZptvLTPh9a0OduHTIrZbd2foI
	mMcUjhjL2j20EJVTL8jU72NE6xIqDvNN+HnZoj+yF+29uPFWQXFLGFbn3TwRUwgk
	/cxCDvHvnxf7EaBcE3SC2k98WloQCGA1JXhnKTKWMTtBc8CVr/rT1bC2X1TaHQGM
	vKs4j1/5gnVf2Ch4FVQBgzg6gGXooghgH/AIabYlaTgkdRAG3ASeLpEyRMm9EzG+
	eRe63A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqcqv3x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:55:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UCtrZA013436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:55:53 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 05:55:48 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <johan@kernel.org>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <konradybcio@kernel.org>, <linux-pm@vger.kernel.org>,
        <tstrudel@google.com>, <rafael@kernel.org>,
        "Johan Hovold" <johan+linaro@kernel.org>
Subject: [PATCH V5 4/6] pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag
Date: Wed, 30 Oct 2024 18:25:10 +0530
Message-ID: <20241030125512.2884761-5-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030125512.2884761-1-quic_sibis@quicinc.com>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3VbAUIVngSU3-gAEOYgLpPKR5pt4KbzE
X-Proofpoint-GUID: 3VbAUIVngSU3-gAEOYgLpPKR5pt4KbzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300101

Introduce GENPD_FLAG_DEV_NAME_FW flag which instructs genpd to generate
an unique device name using ida. It is aimed to be used by genpd providers
which derive their names directly from FW making them susceptible to
debugfs node creation failures.

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v4:
* Rework debugfs node creation patch [Ulf/Dmitry]

 drivers/pmdomain/core.c   | 49 +++++++++++++++++++++++++++------------
 include/linux/pm_domain.h |  6 +++++
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 76490f0bf1e2..a6c8b85dd024 100644
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
@@ -171,6 +175,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
 #define genpd_is_opp_table_fw(genpd)	(genpd->flags & GENPD_FLAG_OPP_TABLE_FW)
+#define genpd_is_dev_name_fw(genpd)	(genpd->flags & GENPD_FLAG_DEV_NAME_FW)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -189,7 +194,7 @@ static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 
 	if (ret)
 		dev_warn_once(dev, "PM domain %s will not be powered off\n",
-				genpd->name);
+			      dev_name(&genpd->dev));
 
 	return ret;
 }
@@ -274,7 +279,7 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
 	if (!genpd_debugfs_dir)
 		return;
 
-	debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
+	debugfs_lookup_and_remove(dev_name(&genpd->dev), genpd_debugfs_dir);
 }
 
 static void genpd_update_accounting(struct generic_pm_domain *genpd)
@@ -731,7 +736,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
 	genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
-		 genpd->name, "on", elapsed_ns);
+		 dev_name(&genpd->dev), "on", elapsed_ns);
 
 out:
 	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
@@ -782,7 +787,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
 	genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
-		 genpd->name, "off", elapsed_ns);
+		 dev_name(&genpd->dev), "off", elapsed_ns);
 
 out:
 	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
@@ -1941,7 +1946,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb)
 
 	if (ret) {
 		dev_warn(dev, "failed to add notifier for PM domain %s\n",
-			 genpd->name);
+			 dev_name(&genpd->dev));
 		return ret;
 	}
 
@@ -1988,7 +1993,7 @@ int dev_pm_genpd_remove_notifier(struct device *dev)
 
 	if (ret) {
 		dev_warn(dev, "failed to remove notifier for PM domain %s\n",
-			 genpd->name);
+			 dev_name(&genpd->dev));
 		return ret;
 	}
 
@@ -2014,7 +2019,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	 */
 	if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
 		WARN(1, "Parent %s of subdomain %s must be IRQ safe\n",
-				genpd->name, subdomain->name);
+		     dev_name(&genpd->dev), subdomain->name);
 		return -EINVAL;
 	}
 
@@ -2089,7 +2094,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 
 	if (!list_empty(&subdomain->parent_links) || subdomain->device_count) {
 		pr_warn("%s: unable to remove subdomain %s\n",
-			genpd->name, subdomain->name);
+			dev_name(&genpd->dev), subdomain->name);
 		ret = -EBUSY;
 		goto out;
 	}
@@ -2226,6 +2231,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
+	genpd->device_id = -ENXIO;
 	genpd->has_provider = false;
 	genpd->accounting_time = ktime_get_mono_fast_ns();
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
@@ -2266,7 +2272,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		return ret;
 
 	device_initialize(&genpd->dev);
-	dev_set_name(&genpd->dev, "%s", genpd->name);
+
+	if (!genpd_is_dev_name_fw(genpd)) {
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
@@ -2288,13 +2305,13 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 
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
 
@@ -2308,9 +2325,11 @@ static int genpd_remove(struct generic_pm_domain *genpd)
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
@@ -3320,12 +3339,12 @@ static int genpd_summary_one(struct seq_file *s,
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
@@ -3550,7 +3569,7 @@ static void genpd_debug_add(struct generic_pm_domain *genpd)
 	if (!genpd_debugfs_dir)
 		return;
 
-	d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
+	d = debugfs_create_dir(dev_name(&genpd->dev), genpd_debugfs_dir);
 
 	debugfs_create_file("current_state", 0444,
 			    d, genpd, &status_fops);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 76775ab38898..45646bfcaf1a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -100,6 +100,10 @@ struct dev_pm_domain_list {
  * GENPD_FLAG_OPP_TABLE_FW:	The genpd provider supports performance states,
  *				but its corresponding OPP tables are not
  *				described in DT, but are given directly by FW.
+ *
+ * GENPD_FLAG_DEV_NAME_FW:	Instructs genpd to generate an unique device name
+ *				using ida. It is used by genpd providers which
+ *				get their genpd-names directly from FW.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -109,6 +113,7 @@ struct dev_pm_domain_list {
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
 #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
 #define GENPD_FLAG_OPP_TABLE_FW	 (1U << 7)
+#define GENPD_FLAG_DEV_NAME_FW	 (1U << 8)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
@@ -171,6 +176,7 @@ struct generic_pm_domain {
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
 	unsigned int device_count;	/* Number of devices */
+	unsigned int device_id;		/* unique device id */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */
-- 
2.34.1


