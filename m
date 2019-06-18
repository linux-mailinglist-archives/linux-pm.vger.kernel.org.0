Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D1497FA
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 06:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfFREPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 00:15:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35233 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfFREPV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 00:15:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so6941295pgl.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 21:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bI5TZZVVWddYzi+zG+c3/8d//MTYrG/SEFr1ZVygmWI=;
        b=Va3jlYRkO6XmYcP4WnDmEIjixZAh3JbumkQtut9GDOvuenRaczimujEG27I18JsxS2
         ncBOEaSo94X4oYO9UZBS9xTsnVzpLHPPTsrbJ4wELh8r5HHNAYSoYjZ2NJ4cmB5Lhhfl
         6uiLdLYWXPCgYg8LF2nD84jyITT/UANOAWUhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bI5TZZVVWddYzi+zG+c3/8d//MTYrG/SEFr1ZVygmWI=;
        b=ueK2wE/8WSav7vSXOLk/11XAd0JZXipnfYGSY+dMHj5+0W+8B+yQ8UHJVWmHk75lL5
         dXCTPE1VhMc5TXkWAyGTF3s1IvhDnI4xAdsFyxG1KfYv/mIcwInCj/szn1ACRkWqPyVC
         pvPv/6JI8scHWBnPIqDaBAAGYcxlNwSs0f7OrsYoM8o0yZ3C3gICUl2fbz/D0+2qVToC
         cHUF5Uq310Ia349PYYBwCWOyzsbYcMX+8qOZbWYKmWZflAuvgSqZkG+Upas//Y8K8o2q
         e9oCMJ4v7jtj+dm0MsU4tgF/Pp8mqhjLn2vK6ZJajFjRVkVdlxJPdOsK/QgSrnKunpPz
         PQVQ==
X-Gm-Message-State: APjAAAVxN9i69Gie44u+AhabnckEBCq8Gs3dFtKVjb/1p5PMMs8A1Cag
        1ij0S1+x7RWkyphRVSNHcRXyrw==
X-Google-Smtp-Source: APXvYqwrFMYT6lCjebCRGps6DV03B4EN/FXJdD3P3q9sNrtIL19XuUD7DrcPdmrtB7AyuciVYfJ49Q==
X-Received: by 2002:a62:ee04:: with SMTP id e4mr1380578pfi.232.1560831320142;
        Mon, 17 Jun 2019 21:15:20 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id 25sm13590685pfp.76.2019.06.17.21.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 21:15:19 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Subject: [PATCH RFC 2/2] devfreq: mt8183-cci: using cpufreq-map governor in cci dvfs driver
Date:   Tue, 18 Jun 2019 12:14:36 +0800
Message-Id: <20190618041433.245629-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618041433.245629-1-hsinyi@chromium.org>
References: <20190618041433.245629-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Hsin-Yi Wang <hsinyi@chromium.org>

This is based on mediatek's devfreq patches[1].

In MT8183 SoC, CCI and little core cluster share same regulator. In original
implementation, CCI frequency depends on regulator voltage, which results in
bad memory access performance if tasks are loaded on other cpus other than
little cluster (cpus 0-3).

Using cpufreq-map mt8183-cci's devfreq governor can improve this situation,
since in most cases, higher cpufreq implies higher loadings on the CCI, and CCI
should consider all cpu loadings instead of only the little cluster.

[1] https://patchwork.kernel.org/patch/10946063/

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/devfreq/mt8183-cci-devfreq.c | 194 +--------------------------
 1 file changed, 4 insertions(+), 190 deletions(-)

diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
index 250c963789f3..a153adee033e 100644
--- a/drivers/devfreq/mt8183-cci-devfreq.c
+++ b/drivers/devfreq/mt8183-cci-devfreq.c
@@ -17,164 +17,7 @@
 struct cci_devfreq {
 	struct devfreq *devfreq;
 	struct regulator *proc_reg;
-	unsigned long proc_reg_uV;
 	struct clk *cci_clk;
-	unsigned long freq;
-	struct notifier_block nb;
-	struct notifier_block opp_nb;
-	int cci_min_freq;
-};
-
-static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
-					  unsigned long val, void *data)
-{
-	int ret;
-	struct cci_devfreq *cci_df =
-		container_of(nb, struct cci_devfreq, nb);
-
-	/* deal with reduce frequency */
-	if (val & REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
-		struct pre_voltage_change_data *pvc_data = data;
-
-		if (pvc_data->min_uV < pvc_data->old_uV) {
-			cci_df->proc_reg_uV =
-				(unsigned long)(pvc_data->min_uV);
-			mutex_lock(&cci_df->devfreq->lock);
-			ret = update_devfreq(cci_df->devfreq);
-			if (ret)
-				pr_err("Fail to reduce cci frequency: %d\n",
-				       ret);
-			mutex_unlock(&cci_df->devfreq->lock);
-		}
-	} else if ((val & REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) &&
-	    ((unsigned long)data > cci_df->proc_reg_uV)) {
-		cci_df->proc_reg_uV = (unsigned long)data;
-		mutex_lock(&cci_df->devfreq->lock);
-		ret = update_devfreq(cci_df->devfreq);
-		if (ret)
-			pr_err("Fail to raise cci frequency back: %d\n", ret);
-		mutex_unlock(&cci_df->devfreq->lock);
-	} else if ((val & REGULATOR_EVENT_VOLTAGE_CHANGE) &&
-	    (cci_df->proc_reg_uV < (unsigned long)data)) {
-		/* deal with increase frequency */
-		cci_df->proc_reg_uV = (unsigned long)data;
-		mutex_lock(&cci_df->devfreq->lock);
-		ret = update_devfreq(cci_df->devfreq);
-		if (ret)
-			pr_err("Fail to raise cci frequency: %d\n", ret);
-		mutex_unlock(&cci_df->devfreq->lock);
-	}
-
-	return 0;
-}
-
-static int ccidevfreq_opp_notifier(struct notifier_block *nb,
-unsigned long event, void *data)
-{
-	int ret;
-	struct dev_pm_opp *opp = data;
-	struct cci_devfreq *cci_df = container_of(nb, struct cci_devfreq,
-						  opp_nb);
-	unsigned long	freq, volt, cur_volt;
-
-	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
-		freq = dev_pm_opp_get_freq(opp);
-		/* current opp item is changed */
-		if (freq == cci_df->freq) {
-			volt = dev_pm_opp_get_voltage(opp);
-			cur_volt = regulator_get_voltage(cci_df->proc_reg);
-
-			if (volt > cur_volt) {
-				/* need reduce freq */
-				mutex_lock(&cci_df->devfreq->lock);
-				ret = update_devfreq(cci_df->devfreq);
-				if (ret)
-					pr_err("Fail to reduce cci frequency by opp notification: %d\n",
-					       ret);
-				mutex_unlock(&cci_df->devfreq->lock);
-			}
-		}
-
-		if (freq == cci_df->cci_min_freq) {
-			volt = dev_pm_opp_get_voltage(opp);
-			regulator_set_voltage(cci_df->proc_reg, volt, INT_MAX);
-		}
-	} else if (event == OPP_EVENT_DISABLE) {
-	}
-
-	return 0;
-}
-
-
-static int mtk_cci_governor_get_target(struct devfreq *devfreq,
-				       unsigned long *freq)
-{
-	struct cci_devfreq *cci_df;
-	struct dev_pm_opp *opp;
-	int ret;
-
-	cci_df = dev_get_drvdata(devfreq->dev.parent);
-
-	/* find available frequency */
-	opp = dev_pm_opp_find_freq_ceil_by_volt(devfreq->dev.parent,
-						cci_df->proc_reg_uV);
-	ret = PTR_ERR_OR_ZERO(opp);
-	if (ret) {
-		pr_err("%s[%d], cannot find opp with voltage=%d: %d\n",
-		       __func__, __LINE__, cci_df->proc_reg_uV, ret);
-		return ret;
-	}
-	*freq = dev_pm_opp_get_freq(opp);
-
-	return 0;
-}
-
-static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
-					  unsigned int event, void *data)
-{
-	int ret;
-	struct cci_devfreq *cci_df;
-	struct notifier_block *nb;
-	struct notifier_block *opp_nb;
-
-	cci_df = dev_get_drvdata(devfreq->dev.parent);
-	nb = &cci_df->nb;
-	opp_nb = &cci_df->opp_nb;
-
-	switch (event) {
-	case DEVFREQ_GOV_START:
-	case DEVFREQ_GOV_RESUME:
-		nb->notifier_call = cci_devfreq_regulator_notifier;
-		ret = regulator_register_notifier(cci_df->proc_reg,
-						  nb);
-		if (ret)
-			pr_err("%s: failed to add governor: %d\n", __func__,
-			       ret);
-		opp_nb->notifier_call = ccidevfreq_opp_notifier;
-		dev_pm_opp_register_notifier(devfreq->dev.parent, opp_nb);
-		break;
-
-	case DEVFREQ_GOV_STOP:
-	case DEVFREQ_GOV_SUSPEND:
-		ret = regulator_unregister_notifier(cci_df->proc_reg,
-						    nb);
-		if (ret)
-			pr_err("%s: failed to add governor: %d\n", __func__,
-			       ret);
-		break;
-
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static struct devfreq_governor mtk_cci_devfreq_governor = {
-	.name = "mtk_cci_vmon",
-	.get_target_freq = mtk_cci_governor_get_target,
-	.event_handler = mtk_cci_governor_event_handler,
-	.immutable = true
 };
 
 static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
@@ -193,8 +36,6 @@ static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
 		return ret;
 	}
 
-	cci_df->freq = *freq;
-
 	return 0;
 }
 
@@ -206,8 +47,6 @@ static int mtk_cci_devfreq_probe(struct platform_device *pdev)
 {
 	struct device *cci_dev = &pdev->dev;
 	struct cci_devfreq *cci_df;
-	unsigned long freq, volt;
-	struct dev_pm_opp *opp;
 	int ret;
 
 	cci_df = devm_kzalloc(cci_dev, sizeof(*cci_df), GFP_KERNEL);
@@ -237,19 +76,12 @@ static int mtk_cci_devfreq_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* set voltage lower bound */
-	freq = 1;
-	opp = dev_pm_opp_find_freq_ceil(cci_dev, &freq);
-	cci_df->cci_min_freq = dev_pm_opp_get_freq(opp);
-	volt = dev_pm_opp_get_voltage(opp);
-	dev_pm_opp_put(opp);
-
 	platform_set_drvdata(pdev, cci_df);
 
 	cci_df->devfreq = devm_devfreq_add_device(cci_dev,
-						  &cci_devfreq_profile,
-						  "mtk_cci_vmon",
-						  NULL);
+						&cci_devfreq_profile,
+						"cpufreq-map",
+						NULL);
 	if (IS_ERR(cci_df->devfreq)) {
 		ret = PTR_ERR(cci_df->devfreq);
 		dev_err(cci_dev, "cannot create cci devfreq device:%d\n", ret);
@@ -277,30 +109,12 @@ static struct platform_driver cci_devfreq_driver = {
 
 static int __init mtk_cci_devfreq_init(void)
 {
-	int ret;
-
-	ret = devfreq_add_governor(&mtk_cci_devfreq_governor);
-	if (ret) {
-		pr_err("%s: failed to add governor: %d\n", __func__, ret);
-		return ret;
-	}
-
-	ret = platform_driver_register(&cci_devfreq_driver);
-	if (ret)
-		devfreq_remove_governor(&mtk_cci_devfreq_governor);
-
-	return ret;
+	return platform_driver_register(&cci_devfreq_driver);
 }
 module_init(mtk_cci_devfreq_init)
 
 static void __exit mtk_cci_devfreq_exit(void)
 {
-	int ret;
-
-	ret = devfreq_remove_governor(&mtk_cci_devfreq_governor);
-	if (ret)
-		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
-
 	platform_driver_unregister(&cci_devfreq_driver);
 }
 module_exit(mtk_cci_devfreq_exit)
-- 
2.20.1

