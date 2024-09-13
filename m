Return-Path: <linux-pm+bounces-14136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D69977DDA
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1828328270D
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667911D88A1;
	Fri, 13 Sep 2024 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mra8e86e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD371D86E0;
	Fri, 13 Sep 2024 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223988; cv=none; b=NyxiERGjwK8GxLN7dS6wnXma63N73Dv00KSVcNL4a0cINy2T0FaFzbAlJHEJ0aI6S75DLIQd/31n/f3ZVNvlUm8KS7U3apKjTfDYS11X7IjKFoXOU4oV0LGml/GOFm4V9WURGYCQTBWzmikH5Orkvb70v4TKRY/IDqQCksJxHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223988; c=relaxed/simple;
	bh=OCe+QOzw/lB+V8u2rpMuXo0xrmE/gbox1sA2o2MXkMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJsdxlPJ5uA8Vum6wYSzLFUYG70IQWEXXh1OdqF33PG6A9uttcHn3X5Yg+CNiwoS175WqdIjo2YCZSBFNlxqAuZFeR9C/a6vMCd+m7+Zw1jvBmxs+3Q6xaNHod/E73iv5HSwYvL7KOv99U0P0BgZ5k0j967AxJPw+eK5HCKxFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Mra8e86e; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b0b678471bc11ef8b96093e013ec31c-20240913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pS/YBV545XadShzl+JV3iEXwq0ukjSd6qB95fLU6jtM=;
	b=Mra8e86eMMtRYc3VYJRBmjPMikAnzYwCqhF/jlOFcoLVhVyDiZZPm/zL494DcvDxfpKBIBquXe+FPuvyDnN468WuNKjKQCJw5jvIF9igUdPOA0g0uXHh4eG7T1JAlIq7U4yis5+q7gWMzWbksv9r1pLJwnBlXTG6JJKV1qN6YaQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:c464df6f-7834-4a87-9598-888e6a047dab,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:caf0ebbf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7b0b678471bc11ef8b96093e013ec31c-20240913
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 614725121; Fri, 13 Sep 2024 18:39:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Sep 2024 18:39:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Sep 2024 18:39:37 +0800
From: Mark Tseng <chun-jen.tseng@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Kyungmin
 Park" <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<chun-jen.tseng@mediatek.com>
Subject: [PATCH v1 2/2] cpufreq: mediatek: Fixed cpufreq has 2 policy will cause concurrency
Date: Fri, 13 Sep 2024 18:39:33 +0800
Message-ID: <20240913103933.30895-3-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240913103933.30895-1-chun-jen.tseng@mediatek.com>
References: <20240913103933.30895-1-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.646400-8.000000
X-TMASE-MatchedRID: NRO3hbO9xfYsJluZlyHlY8AmcZEx8XHJnQkHrAHoKqYA6s2mIXI3kAQH
	T64gg+vfhbvmKbpIiCZEzxsFM1euZkzhWNnvpqvYXP5rFAucBUEjs7F41+YP7NSVUkz9BPXec1B
	UAZEsVDboMHvInt5RM8tR/vbsBoBQ7DvDbr7RMEril2r2x2PwtQrefVId6fzVdxcn1spsVVkoSp
	oF9H5fPdQPqLBIkXdW57+d6CGh74J/Kgj3tMS/EMFHAfWALUlhAn4P7FuKVFAiPSULBgbDb+g6D
	D179VtATIPFmUsu9TBMwbPxIFtiF7MywGOaB4QQngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIXzYx
	eQR1Dvteoc8+S50jzaLdGITE8Df+vw7wTiLlKfCj07KR8K62ZL1knp3UBvYm
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.646400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5968523419A560E3B6635D9CEC4A214E18E49A95633F58B26A814CDDCA359DDB2000:8

mtk_cpufreq_set_target() is re-enter function but the mutex lock decalre
in mtk_cpu_dvfs_info structure for each policy. It should change to
global variable for critical session avoid policy get wrong OPP.

SoC with CCI architecture should set transition_delay to 10 ms
because cpufreq need to call devfreq notifier in async mode. if delay
less than 10ms may get wrong OPP-level in CCI driver.

Add CPUFREQ_ASYNC_NOTIFICATION flages for cpufreq policy because some of
process will get CPU frequency by cpufreq sysfs node. It may get wrong
frequency then call cpufreq_out_of_sync() to fixed frequency.

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 65 ++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 663f61565cf7..3303b6d72ea7 100644
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
@@ -200,20 +201,29 @@ static bool is_ccifreq_ready(struct mtk_cpu_dvfs_info *info)
 static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 				  unsigned int index)
 {
-	struct cpufreq_frequency_table *freq_table = policy->freq_table;
-	struct clk *cpu_clk = policy->clk;
-	struct clk *armpll = clk_get_parent(cpu_clk);
-	struct mtk_cpu_dvfs_info *info = policy->driver_data;
-	struct device *cpu_dev = info->cpu_dev;
+	struct cpufreq_frequency_table *freq_table;
+	struct clk *cpu_clk;
+	struct clk *armpll;
+	struct mtk_cpu_dvfs_info *info;
+	struct device *cpu_dev;
 	struct dev_pm_opp *opp;
 	long freq_hz, pre_freq_hz;
 	int vproc, pre_vproc, inter_vproc, target_vproc, ret;
+	struct cpufreq_freqs freqs;
 
-	inter_vproc = info->intermediate_voltage;
+	mutex_lock(&mtk_policy_lock);
 
-	pre_freq_hz = clk_get_rate(cpu_clk);
+	freq_table = policy->freq_table;
+	cpu_clk = policy->clk;
+	armpll = clk_get_parent(cpu_clk);
+	info = policy->driver_data;
+	cpu_dev = info->cpu_dev;
+	inter_vproc = info->intermediate_voltage;
+	pre_freq_hz = policy->cur * 1000;
 
-	mutex_lock(&info->reg_lock);
+	freqs.old = policy->cur;
+	freqs.new = freq_table[index].frequency;
+	cpufreq_freq_transition_begin(policy, &freqs);
 
 	if (unlikely(info->pre_vproc <= 0))
 		pre_vproc = regulator_get_voltage(info->proc_reg);
@@ -308,7 +318,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	info->current_freq = freq_hz;
 
 out:
-	mutex_unlock(&info->reg_lock);
+	cpufreq_freq_transition_end(policy, &freqs, false);
+	mutex_unlock(&mtk_policy_lock);
 
 	return ret;
 }
@@ -316,19 +327,20 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
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
@@ -336,7 +348,6 @@ static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
 				dev_err(info->cpu_dev,
 					"failed to scale voltage: %d\n", ret);
 		}
-		mutex_unlock(&info->reg_lock);
 	} else if (event == OPP_EVENT_DISABLE) {
 		freq = dev_pm_opp_get_freq(opp);
 
@@ -361,6 +372,7 @@ static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
 			}
 		}
 	}
+	mutex_unlock(&mtk_policy_lock);
 
 	return notifier_from_errno(ret);
 }
@@ -495,7 +507,6 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
-	mutex_init(&info->reg_lock);
 	info->current_freq = clk_get_rate(info->cpu_clk);
 
 	info->opp_cpu = cpu;
@@ -597,6 +608,9 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
 
+	if (info->soc_data->ccifreq_supported)
+		policy->transition_delay_us = 10000;
+
 	return 0;
 }
 
@@ -607,13 +621,32 @@ static void mtk_cpufreq_exit(struct cpufreq_policy *policy)
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
+		 CPUFREQ_ASYNC_NOTIFICATION |
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


