Return-Path: <linux-pm+bounces-17174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6693D9C1685
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 07:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE461F22AA6
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 06:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7011D0E2F;
	Fri,  8 Nov 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B0te3za8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E61CF7B6;
	Fri,  8 Nov 2024 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731047997; cv=none; b=DxZRuqbEsA3dT7IAq7UjVSxSXxjWpnJ+jKvU9Fm24gEXQVMlFAYFAPNFwiTYRQg6jeHTDJkbsxTdNd383IH0BZr5Lzh6nKDoBUumk6j/J/0WDBvHk770CcZ+erMlCQhfHv5Es3C1WxG6aLo4+XguYXtKBr//nFNGQYGPT/qndmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731047997; c=relaxed/simple;
	bh=ueT+ccky2jPcZMmNDBe7fttcASXZUBPn8YOGTnygoSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRcHMC5ZCsXpMMgI5uO1BsS6MPgC99nTG7YhvnF8s1/xeBeQUkJ+bFI9HNQy+82eaxY697mmSlLjLGdzm7Zv4zegph5eST+wK+zJldgeQhwigiuJxcTqAd0b9oiiGskXmsDI+EwSHFIjoVOdNT1rIXS4jmg6yzdbUjcxAue1Ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=B0te3za8; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 40c9f3049d9c11efbd192953cf12861f-20241108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HUfXCWBMH14NMLsYilX9Z6Z+VvsztsPB6r7RvqOT/YM=;
	b=B0te3za8+DxBtynEL5rppTJ/gmGnsjvFEu0LoHFVeWFOLqOfsUIDTLMe6n8s1A4DaWx7dHxAs5S64UUxrnbtzeymHniu31g34hesUYooZ6XuvlMpSqlBgKV/qvx3FmKqqADkXBIAHLJ6tLtReAyYp0Qg9nINMzkktaJgdfp8UZA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:5695cee6-98fc-4df6-8ec1-4a44534a3c04,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:a266d31b-4f51-4e1d-bb6a-1fd98b6b19d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 40c9f3049d9c11efbd192953cf12861f-20241108
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1064750681; Fri, 08 Nov 2024 14:39:49 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Nov 2024 14:39:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Nov 2024 14:39:49 +0800
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
Subject: [PATCH v2 4/4] cpufreq: mediatek: data safety protect
Date: Fri, 8 Nov 2024 14:39:42 +0800
Message-ID: <20241108063942.19744-5-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241108063942.19744-1-chun-jen.tseng@mediatek.com>
References: <20241108063942.19744-1-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

get policy data in global lock session avoid get wrong data.

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 3369bdd9a348..3303b6d72ea7 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -201,11 +201,11 @@ static bool is_ccifreq_ready(struct mtk_cpu_dvfs_info *info)
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
@@ -213,6 +213,11 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	mutex_lock(&mtk_policy_lock);
 
+	freq_table = policy->freq_table;
+	cpu_clk = policy->clk;
+	armpll = clk_get_parent(cpu_clk);
+	info = policy->driver_data;
+	cpu_dev = info->cpu_dev;
 	inter_vproc = info->intermediate_voltage;
 	pre_freq_hz = policy->cur * 1000;
 
-- 
2.45.2


