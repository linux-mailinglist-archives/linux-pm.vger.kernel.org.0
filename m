Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF56B664
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 08:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfGQGMc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 02:12:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34685 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQGMb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 02:12:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so10298008pfo.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKqGRkCKeF68uS8Nc2o5zsS+jiggMLY6zjOj4yvnHMo=;
        b=ndaD2LEwv47y7lMmSANsBoXT55sgXCI3/ygNKKcwA6KZpw5VSy+ZM3yCqaf+bLkbJr
         hOpUrhk+h4zbYUkuZSXSsez/z+c9SRdHWSY8Gd4dB8OAcBXAfwRRYAXBwNV+dBPkK6cZ
         PKE4nYqHw9SszZjnvlEfVd61bqluDV9Alx+qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKqGRkCKeF68uS8Nc2o5zsS+jiggMLY6zjOj4yvnHMo=;
        b=KItXNnavb++UkhzhFVevPnRK94FViq1GPzVNrg61rZFOImVlNuXlgESu6prOlkFykd
         FBgUnS1nY+ZVp0OHC8TvNlicq2OeEESqoBBd77wMVYpFD/FPDHQptPTUcMNq4AIU2ab1
         hHj9UgCk/F2W+lgYjtxTOqGhVPM2Mv6KGhDY3syjHF/NhDUat9SY7GyFHUt2ccwWaQWF
         0gKIzKkWrZGRe8JoqrOU5DfPDOoBdlcQiYdmdVap1F2yfHWxrjP4SQLI4Rdwy3NvsBTv
         fLiiR9yeomQfyE5R2qXIjp4eyvuLFTHySs4TTNmxlN5KQxG85L5zCk60fDMkakkfqrKC
         uidw==
X-Gm-Message-State: APjAAAWH1SY9Tmwnn5rkT5Ozc+8tgCyiDcWyg1coXlOlIprJOI7yE6In
        izreXpgi7y1Hc0SfkaGWB6XDmg==
X-Google-Smtp-Source: APXvYqxbtGa03yLM2BA9rY63n8GJrac4dCtXBZc47gU+7zR+mkfjnM8MHXNIyVH2t21OdGF9RWgI2w==
X-Received: by 2002:a17:90a:ad93:: with SMTP id s19mr41884653pjq.36.1563343950578;
        Tue, 16 Jul 2019 23:12:30 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id y23sm24079706pfo.106.2019.07.16.23.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 23:12:30 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 1/2] devfreq: mt8183-cci: using cpu based scaling passive_governor
Date:   Wed, 17 Jul 2019 14:11:25 +0800
Message-Id: <20190717061124.453-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717061124.453-1-hsinyi@chromium.org>
References: <20190717061124.453-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is based on mediatek's devfreq patches[1].

In MT8183 SoC, CCI and little core cluster share same regulator. In original
implementation, CCI frequency depends on regulator voltage, which results in
bad memory access performance if tasks are loaded on other cpus other than
little cluster (cpus 0-3).

Using cpu based scaling devfreq passive governor can improve this situation,
since in most cases, higher cpufreq implies higher loadings on the CCI, and CCI
should consider all cpu loadings instead of only the little cluster.

[1] https://patchwork.kernel.org/patch/10946063/

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/devfreq/mt8183-cci-devfreq.c | 239 +++++++--------------------
 1 file changed, 56 insertions(+), 183 deletions(-)

diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
index 250c963789f3..4e8e5948ed41 100644
--- a/drivers/devfreq/mt8183-cci-devfreq.c
+++ b/drivers/devfreq/mt8183-cci-devfreq.c
@@ -11,189 +11,82 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time.h>
 
 #include "governor.h"
 
+#define MAX_VOLT_LIMIT		(1150000)
+
 struct cci_devfreq {
 	struct devfreq *devfreq;
 	struct regulator *proc_reg;
-	unsigned long proc_reg_uV;
 	struct clk *cci_clk;
-	unsigned long freq;
-	struct notifier_block nb;
-	struct notifier_block opp_nb;
-	int cci_min_freq;
+	int old_vproc;
+	unsigned long old_freq;
 };
 
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
+static int mtk_cci_set_voltage(struct cci_devfreq *cci_df, int vproc)
 {
-	struct cci_devfreq *cci_df;
-	struct dev_pm_opp *opp;
 	int ret;
 
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
+	ret = regulator_set_voltage(cci_df->proc_reg, vproc,
+						MAX_VOLT_LIMIT);
+	if (!ret)
+		cci_df->old_vproc = vproc;
+	return ret;
 }
 
-static struct devfreq_governor mtk_cci_devfreq_governor = {
-	.name = "mtk_cci_vmon",
-	.get_target_freq = mtk_cci_governor_get_target,
-	.event_handler = mtk_cci_governor_event_handler,
-	.immutable = true
-};
-
 static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
 				  u32 flags)
 {
 	int ret;
 	struct cci_devfreq *cci_df = dev_get_drvdata(dev);
+	struct dev_pm_opp *opp;
+	unsigned long opp_rate, opp_voltage, old_voltage;
 
 	if (!cci_df)
 		return -EINVAL;
 
+	if (cci_df->old_freq == *freq)
+		return 0;
+
+	opp_rate = *freq;
+	opp = dev_pm_opp_find_freq_floor(dev, &opp_rate);
+	opp_voltage = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
+
+	old_voltage = cci_df->old_vproc;
+	if (old_voltage == 0)
+		old_voltage = regulator_get_voltage(cci_df->proc_reg);
+
+	// scale up: set voltage first then freq
+	if (opp_voltage > old_voltage) {
+		ret = mtk_cci_set_voltage(cci_df, opp_voltage);
+		if (ret) {
+			pr_err("cci: failed to scale up voltage\n");
+			return ret;
+		}
+	}
+
 	ret = clk_set_rate(cci_df->cci_clk, *freq);
 	if (ret) {
 		pr_err("%s: failed cci to set rate: %d\n", __func__,
 		       ret);
+		mtk_cci_set_voltage(cci_df, old_voltage);
 		return ret;
 	}
 
-	cci_df->freq = *freq;
+	// scale down: set freq first then voltage
+	if (opp_voltage < old_voltage) {
+		ret = mtk_cci_set_voltage(cci_df, opp_voltage);
+		if (ret) {
+			pr_err("cci: failed to scale down voltage\n");
+			clk_set_rate(cci_df->cci_clk, cci_df->old_freq);
+			return ret;
+		}
+	}
+
+	cci_df->old_freq = *freq;
 
 	return 0;
 }
@@ -206,8 +99,7 @@ static int mtk_cci_devfreq_probe(struct platform_device *pdev)
 {
 	struct device *cci_dev = &pdev->dev;
 	struct cci_devfreq *cci_df;
-	unsigned long freq, volt;
-	struct dev_pm_opp *opp;
+	struct devfreq_passive_data *passive_data;
 	int ret;
 
 	cci_df = devm_kzalloc(cci_dev, sizeof(*cci_df), GFP_KERNEL);
@@ -237,19 +129,18 @@ static int mtk_cci_devfreq_probe(struct platform_device *pdev)
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
 
+	passive_data = devm_kzalloc(cci_dev, sizeof(*passive_data), GFP_KERNEL);
+	if (!passive_data)
+		return -ENOMEM;
+
+	passive_data->cpufreq_type = true;
+
 	cci_df->devfreq = devm_devfreq_add_device(cci_dev,
 						  &cci_devfreq_profile,
-						  "mtk_cci_vmon",
-						  NULL);
+						  DEVFREQ_GOV_PASSIVE,
+						  passive_data);
 	if (IS_ERR(cci_df->devfreq)) {
 		ret = PTR_ERR(cci_df->devfreq);
 		dev_err(cci_dev, "cannot create cci devfreq device:%d\n", ret);
@@ -277,30 +168,12 @@ static struct platform_driver cci_devfreq_driver = {
 
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

