Return-Path: <linux-pm+bounces-22065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A412AA3581B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 08:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299B73AB10B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DE215F4F;
	Fri, 14 Feb 2025 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fWFzqQRG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C32153E1;
	Fri, 14 Feb 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519043; cv=none; b=Lr7I2yunXNkrL45g+vYTABtwCr43jHhB305F/pdLPYfR1Xl2I9nS5sDpD9q0HzTfS0y7/hLD3bjqDVHQ+PI7irNSoMccPFUZQTH17iAIiKciap+YvzRHwhwaN6O0uumZ55cKzrky/1TCddQqZbL8EhuusKbK2nO5GvQu98aamEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519043; c=relaxed/simple;
	bh=dpnzSrNVQ5Sn2enMYiJ+zZux/fL5MEa7//LADi4zEes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arRrRnq+yPXXfKK8nuFA0uh6e0TJGyM6sudRQ16kn5vpRlwrGKD12M0Hg/S6Z6cOYQJC5kvF0BqfiW6B4xUUYZe40+HFMCeg2u1cmgbBfgtHiQbzwSEj2a/lcmnQ/hRBYJGmrNwYpgzGMsEGU2ofeZAhIhvU7HFziH3jyxlwyKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fWFzqQRG; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7134b6f2eaa711efbd192953cf12861f-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yGx9P0mJqQozpBOCmZwQ+5UxE4Q0iSbhG8oMKQTzU8s=;
	b=fWFzqQRGObW4P4gC1w8gwsRWpBKonwEy8O2vypG0kwi2GrAZNkAOiKlM7k6ymwIhXiXlGU6D+r9g4o5uLMQL5GlPEkmQp+OzT/pd5bqJJzqBX21Stu7TCh99eiz3LCmZNk6z4CZcPwAT9wx2eCihsYbGFLEU94O4CKK6edWKcDM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:76351ebd-f443-4171-8f1d-209379665dbf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:09de5b88-f9ab-4ac1-951b-e3a689bed90c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7134b6f2eaa711efbd192953cf12861f-20250214
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 663570915; Fri, 14 Feb 2025 15:43:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 15:43:53 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 15:43:53 +0800
From: Mark Tseng <chun-jen.tseng@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin
 Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<chun-jen.tseng@mediatek.com>
Subject: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race condition
Date: Fri, 14 Feb 2025 15:43:32 +0800
Message-ID: <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In mtk_cpufreq_set_target() is re-enter function but the mutex lock
decalre in mtk_cpu_dvfs_info structure for each policy. It should
change to global variable for critical session avoid race condition
with 2 or more policy.

add mtk_cpufreq_get() replace cpufreq_generic_get() and use global lock
avoid return wrong clock.

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 39 ++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 2656b88db378..07d5958e106a 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -49,8 +49,6 @@ struct mtk_cpu_dvfs_info {
 	bool need_voltage_tracking;
 	int vproc_on_boot;
 	int pre_vproc;
-	/* Avoid race condition for regulators between notify and policy */
-	struct mutex reg_lock;
 	struct notifier_block opp_nb;
 	unsigned int opp_cpu;
 	unsigned long current_freq;
@@ -59,6 +57,9 @@ struct mtk_cpu_dvfs_info {
 	bool ccifreq_bound;
 };
 
+/* Avoid race condition for regulators between notify and policy */
+static DEFINE_MUTEX(mtk_policy_lock);
+
 static struct platform_device *cpufreq_pdev;
 
 static LIST_HEAD(dvfs_info_list);
@@ -209,12 +210,12 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	long freq_hz, pre_freq_hz;
 	int vproc, pre_vproc, inter_vproc, target_vproc, ret;
 
+	mutex_lock(&mtk_policy_lock);
+
 	inter_vproc = info->intermediate_voltage;
 
 	pre_freq_hz = clk_get_rate(cpu_clk);
 
-	mutex_lock(&info->reg_lock);
-
 	if (unlikely(info->pre_vproc <= 0))
 		pre_vproc = regulator_get_voltage(info->proc_reg);
 	else
@@ -308,7 +309,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	info->current_freq = freq_hz;
 
 out:
-	mutex_unlock(&info->reg_lock);
+	mutex_unlock(&mtk_policy_lock);
 
 	return ret;
 }
@@ -316,19 +317,20 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
 				    unsigned long event, void *data)
 {
-	struct dev_pm_opp *opp = data;
+	struct dev_pm_opp *opp;
 	struct dev_pm_opp *new_opp;
 	struct mtk_cpu_dvfs_info *info;
 	unsigned long freq, volt;
 	struct cpufreq_policy *policy;
 	int ret = 0;
 
+	mutex_lock(&mtk_policy_lock);
+	opp = data;
 	info = container_of(nb, struct mtk_cpu_dvfs_info, opp_nb);
 
 	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
 		freq = dev_pm_opp_get_freq(opp);
 
-		mutex_lock(&info->reg_lock);
 		if (info->current_freq == freq) {
 			volt = dev_pm_opp_get_voltage(opp);
 			ret = mtk_cpufreq_set_voltage(info, volt);
@@ -336,7 +338,6 @@ static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
 				dev_err(info->cpu_dev,
 					"failed to scale voltage: %d\n", ret);
 		}
-		mutex_unlock(&info->reg_lock);
 	} else if (event == OPP_EVENT_DISABLE) {
 		freq = dev_pm_opp_get_freq(opp);
 
@@ -361,6 +362,7 @@ static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
 			}
 		}
 	}
+	mutex_unlock(&mtk_policy_lock);
 
 	return notifier_from_errno(ret);
 }
@@ -495,7 +497,6 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
-	mutex_init(&info->reg_lock);
 	info->current_freq = clk_get_rate(info->cpu_clk);
 
 	info->opp_cpu = cpu;
@@ -607,13 +608,31 @@ static void mtk_cpufreq_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
 }
 
+static unsigned int mtk_cpufreq_get(unsigned int cpu)
+{
+	struct mtk_cpu_dvfs_info *info;
+	unsigned long current_freq;
+
+	mutex_lock(&mtk_policy_lock);
+	info = mtk_cpu_dvfs_info_lookup(cpu);
+	if (!info) {
+		mutex_unlock(&mtk_policy_lock);
+		return 0;
+	}
+
+	current_freq = info->current_freq / 1000;
+	mutex_unlock(&mtk_policy_lock);
+
+	return current_freq;
+}
+
 static struct cpufreq_driver mtk_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = mtk_cpufreq_set_target,
-	.get = cpufreq_generic_get,
+	.get = mtk_cpufreq_get,
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
 	.register_em = cpufreq_register_em_with_opp,
-- 
2.45.2


