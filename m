Return-Path: <linux-pm+bounces-14134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263EB977DD6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20A61F21723
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A251A1D86DC;
	Fri, 13 Sep 2024 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XHy+qyJM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06A1D86DB;
	Fri, 13 Sep 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223987; cv=none; b=KYpz6su7r5SWZU7/DgNQRFdWHAgmU7/oxQdtnkJKN4814HPwL511P29JL+V9vPXRjGciaQ9BvKaZg362xX4X6QyuDx7chc5+x5rWSaN+D+ixB8HKL7t54n2ijDO5F5+6/SqTBg3UR2gwRDQyXfsZuEhk9UreUvHrPXjvnbJ4CMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223987; c=relaxed/simple;
	bh=tzPwMqG+3Kp2waF1TxZO9fHlxxSurR5xbTdggowSWqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6dmXZZ3ZLei0g/9x9aWPrGSRknBYQGM/3rcTXSyWOI5GYWHasybP7BlWIheKZ/pRqYZoP4Mcf+6YTTjq8QGjYpAky7XV6I5noN1Glh+jzSOgkmQNVT/SmJf9swEH3sk8c+ljZuzb8rbFIKLRCms716+j60rJDVEgFquSoRgTP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XHy+qyJM; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7af9326c71bc11ef8b96093e013ec31c-20240913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dbFE54p5YQWTJB15O5Q9PNu5uByvL0/k1s8swtLuwZ8=;
	b=XHy+qyJMcPvPp//VBBy0WH0mFbSx91oHXvyXzR5NTAdY8Wj/hIsCnoPN8qGHLM1X/gdVvuFLHcF3yN3jzMDs2TcyfWjyRFL1OMr7t4BbyGyrQb8k1DiYop6ur9gJOpg9MrJ2g2mMHIHGcr0s3g4XoC6H1DqqTIQJ2nu9wDclWRQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:8eb4ba7f-13ff-4742-9a20-5a1e7eb4eb5d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:79daf8b6-8c4d-4743-b649-83c6f3b849d4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7af9326c71bc11ef8b96093e013ec31c-20240913
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1698981713; Fri, 13 Sep 2024 18:39:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
Subject: [PATCH v1 1/2] PM / devfreq: mediatek: protect oop in critical session
Date: Fri, 13 Sep 2024 18:39:32 +0800
Message-ID: <20240913103933.30895-2-chun-jen.tseng@mediatek.com>
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
X-TM-AS-Result: No-10--4.484100-8.000000
X-TMASE-MatchedRID: LAlCrEnopVXUzvcPSorAlFz+axQLnAVBtGonEOW5g+agaf0+XUrNk3kk
	h754FS8n6DB7yJ7eUTP0VyIrxg+OJcZEoJx1HltluIwLnB3Aqp25+1figft3Lg5SzgJNSArLkVq
	DBn//HhImL4e5hLr+f0mZgncXR4mgGAdnzrnkM48URSScn+QSXt0H8LFZNFG7doMssNsUwYVV2Y
	FKivUXnovjZuoPNVwq7Ouc1TlJj0nz/pMg4hZ1PL27cYXrOln+oV7D15FntQdDvz+t8eVtJ0AAL
	As+DNqOStqwsbgFR/qAhOcaQrQ0U1GyRcoeF18qmKP0zzpTAeGwod8xOMKmvA1Aka/KIp/p
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.484100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: FC2A249B0FAC5904A78B645CACC39F666E4A44308525607319F5BE191941A9442000:8

mtk_ccifreq_target() & mtk_ccifreq_opp_notifier() is re-enter funtion
when cpufreq governor is more than one. It should add global mutex to
protect OPP , avoid get wrong frequency & voltage.

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 drivers/devfreq/mtk-cci-devfreq.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 7ad5225b0381..293cf81e53fe 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -29,13 +29,14 @@ struct mtk_ccifreq_drv {
 	struct clk *inter_clk;
 	int inter_voltage;
 	unsigned long pre_freq;
-	/* Avoid race condition for regulators between notify and policy */
-	struct mutex reg_lock;
 	struct notifier_block opp_nb;
 	const struct mtk_ccifreq_platform_data *soc_data;
 	int vtrack_max;
 };
 
+/* Avoid race condition for regulators between notify and policy */
+static DEFINE_MUTEX(reg_lock);
+
 static int mtk_ccifreq_set_voltage(struct mtk_ccifreq_drv *drv, int new_voltage)
 {
 	const struct mtk_ccifreq_platform_data *soc_data = drv->soc_data;
@@ -125,22 +126,20 @@ static int mtk_ccifreq_set_voltage(struct mtk_ccifreq_drv *drv, int new_voltage)
 static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 			      u32 flags)
 {
-	struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
+	struct mtk_ccifreq_drv *drv;
 	struct clk *cci_pll;
 	struct dev_pm_opp *opp;
 	unsigned long opp_rate;
 	int voltage, pre_voltage, inter_voltage, target_voltage, ret;
 
+	mutex_lock(&reg_lock);
+
+	drv = dev_get_drvdata(dev);
 	if (!drv)
 		return -EINVAL;
 
-	if (drv->pre_freq == *freq)
-		return 0;
-
-	mutex_lock(&drv->reg_lock);
-
-	inter_voltage = drv->inter_voltage;
 	cci_pll = clk_get_parent(drv->cci_clk);
+	inter_voltage = drv->inter_voltage;
 
 	opp_rate = *freq;
 	opp = devfreq_recommended_opp(dev, &opp_rate, 1);
@@ -206,7 +205,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 	}
 
 	drv->pre_freq = *freq;
-	mutex_unlock(&drv->reg_lock);
+	mutex_unlock(&reg_lock);
 
 	return 0;
 
@@ -214,21 +213,23 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 	mtk_ccifreq_set_voltage(drv, pre_voltage);
 
 out_unlock:
-	mutex_unlock(&drv->reg_lock);
+	mutex_unlock(&reg_lock);
 	return ret;
 }
 
 static int mtk_ccifreq_opp_notifier(struct notifier_block *nb,
 				    unsigned long event, void *data)
 {
-	struct dev_pm_opp *opp = data;
+	struct dev_pm_opp *opp;
 	struct mtk_ccifreq_drv *drv;
 	unsigned long freq, volt;
 
+	mutex_lock(&reg_lock);
+
+	opp = data;
 	drv = container_of(nb, struct mtk_ccifreq_drv, opp_nb);
 
 	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
-		mutex_lock(&drv->reg_lock);
 		freq = dev_pm_opp_get_freq(opp);
 
 		/* current opp item is changed */
@@ -236,8 +237,8 @@ static int mtk_ccifreq_opp_notifier(struct notifier_block *nb,
 			volt = dev_pm_opp_get_voltage(opp);
 			mtk_ccifreq_set_voltage(drv, volt);
 		}
-		mutex_unlock(&drv->reg_lock);
 	}
+	mutex_unlock(&reg_lock);
 
 	return 0;
 }
@@ -262,7 +263,6 @@ static int mtk_ccifreq_probe(struct platform_device *pdev)
 	drv->dev = dev;
 	drv->soc_data = (const struct mtk_ccifreq_platform_data *)
 				of_device_get_match_data(&pdev->dev);
-	mutex_init(&drv->reg_lock);
 	platform_set_drvdata(pdev, drv);
 
 	drv->cci_clk = devm_clk_get(dev, "cci");
-- 
2.45.2


