Return-Path: <linux-pm+bounces-15242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F031992427
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 08:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BBB1F22EFE
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 06:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF9161326;
	Mon,  7 Oct 2024 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WiTI0yb0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65231534E6;
	Mon,  7 Oct 2024 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281268; cv=none; b=LJ0xLBAOptnQf8K/Z4iZTQyPzweaS/a74lmhUG7qYH5loFpXIlR9QsvclNA4mxz3E+Mdg9vZephY9On3+2cifugDrA/jl6kKpZl2x2W2+w2c+qx8AZ6sqEkvcGdXqcCK74ywiIcPYvPS/RCGaYrlr1FOZO8lbWaWtWHMQqk6n+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281268; c=relaxed/simple;
	bh=EoUAP1AqkN5GyLx9+7NrDZmrMpMK1c4xx2v9RETBrk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4mZZW25an/Nxv5Xq92mZ2RwoPMEbJ8mbP6lrn+6/DXN0B1WQAfToZmt8GAgTDm7C+YseNYM6cYcS3dsX/rJH/HBiOUUYtSufCZteZOakyzncFSOzx7epGSGlI5WJ4rytFzBQ6p02oZqoRP2NuVFe/pg09QACZp36kcEoK2b6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WiTI0yb0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974SnrY015079;
	Mon, 7 Oct 2024 06:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5njRfijPqTse3ZW/zlCzrQCYNKTXJNAwZILpOjdsuU=; b=WiTI0yb01+xQ2tZj
	Ozkftk9hpxREiENbcPj/+tZwSmGlqXbICPwssnLSPMf46E02qmPkH8Vh6fzuDYol
	U5oqf2tdQKRR8isVqMlFsjK65w+AhvWPuyDzCV35Q0wjuljAAClbNPTWvxK1Wgmr
	S35lrlAg8HCm7maFSbph95GT60SJE23e+CNuEK1GmxyJxAqLE6QwlE/C9YjubNy0
	pN8YEIBzDN0cNUkuGJFXtf6Y+W8vcFuaHsiC9VAoIcNi0r865lmWO4m+zgQdlEvI
	gKkqVMapo9tP072wSTfx885Zoro0v4jhP+YGv2aQk2C79slSDjmsLySmTXpxTDqo
	+UJjog==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs735bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 06:07:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49767Z6a022263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 06:07:35 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 6 Oct 2024 23:07:30 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <johan@kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>,
        "Johan Hovold" <johan+linaro@kernel.org>
Subject: [PATCH V3 3/4] pmdomain: core: Fix debugfs node creation failure
Date: Mon, 7 Oct 2024 11:36:41 +0530
Message-ID: <20241007060642.1978049-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007060642.1978049-1-quic_sibis@quicinc.com>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -mW3wJIsM1BcWsTttycpFiRLak1qhnFX
X-Proofpoint-GUID: -mW3wJIsM1BcWsTttycpFiRLak1qhnFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070041

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
Fix-suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

genpd names with ida appended:
power-domain-cpu0_0
power-domain-cpu1_1
....
ebi_18
gfx_19
...
NCC_56
NCC_57
NCC_58

genpd summary with ida appended:
domain                          status          children        performance
    /device                         runtime status                  managed by
    ------------------------------------------------------------------------------
    NCC_58                          on                                                 0
    NCC_57                          on                                                 0
    NCC_56                          on                                                 0
    ...
    gfx_19                          off-0                                              0
    ebi_18                          off-0                                              0
    ...
    power-domain-cpu1_1             off-0                                              0
	genpd:0:cpu1                    suspended                   0           SW
    power-domain-cpu0_0             off-0                                              0
	genpd:0:cpu0                    suspended                   0           SW

 drivers/pmdomain/core.c   | 40 ++++++++++++++++++++++++---------------
 include/linux/pm_domain.h |  1 +
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 5ede0f7eda09..631cb732bb39 100644
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
@@ -1940,7 +1944,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb)
 
 	if (ret) {
 		dev_warn(dev, "failed to add notifier for PM domain %s\n",
-			 genpd->name);
+			 dev_name(&genpd->dev));
 		return ret;
 	}
 
@@ -1987,7 +1991,7 @@ int dev_pm_genpd_remove_notifier(struct device *dev)
 
 	if (ret) {
 		dev_warn(dev, "failed to remove notifier for PM domain %s\n",
-			 genpd->name);
+			 dev_name(&genpd->dev));
 		return ret;
 	}
 
@@ -2013,7 +2017,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	 */
 	if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
 		WARN(1, "Parent %s of subdomain %s must be IRQ safe\n",
-				genpd->name, subdomain->name);
+		     dev_name(&genpd->dev), subdomain->name);
 		return -EINVAL;
 	}
 
@@ -2088,7 +2092,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 
 	if (!list_empty(&subdomain->parent_links) || subdomain->device_count) {
 		pr_warn("%s: unable to remove subdomain %s\n",
-			genpd->name, subdomain->name);
+			dev_name(&genpd->dev), subdomain->name);
 		ret = -EBUSY;
 		goto out;
 	}
@@ -2264,8 +2268,13 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	if (ret)
 		return ret;
 
+	ret = ida_alloc(&genpd_ida, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+	genpd->device_id = ret;
+
 	device_initialize(&genpd->dev);
-	dev_set_name(&genpd->dev, "%s", genpd->name);
+	dev_set_name(&genpd->dev, "%s_%u", genpd->name, genpd->device_id);
 
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
@@ -2287,13 +2296,13 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 
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
 
@@ -2307,9 +2316,10 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	genpd_unlock(genpd);
 	genpd_debug_remove(genpd);
 	cancel_work_sync(&genpd->power_off_work);
+	ida_free(&genpd_ida, genpd->device_id);
 	genpd_free_data(genpd);
 
-	pr_debug("%s: removed %s\n", __func__, genpd->name);
+	pr_debug("%s: removed %s\n", __func__, dev_name(&genpd->dev));
 
 	return 0;
 }
@@ -3272,12 +3282,12 @@ static int genpd_summary_one(struct seq_file *s,
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
@@ -3502,7 +3512,7 @@ static void genpd_debug_add(struct generic_pm_domain *genpd)
 	if (!genpd_debugfs_dir)
 		return;
 
-	d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
+	d = debugfs_create_dir(dev_name(&genpd->dev), genpd_debugfs_dir);
 
 	debugfs_create_file("current_state", 0444,
 			    d, genpd, &status_fops);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b637ec14025f..738df5296ec7 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -163,6 +163,7 @@ struct generic_pm_domain {
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
 	unsigned int device_count;	/* Number of devices */
+	unsigned int device_id;		/* unique device id */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */
-- 
2.34.1


