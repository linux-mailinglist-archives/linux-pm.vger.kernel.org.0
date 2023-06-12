Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B59072B78D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbjFLFkB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjFLFjg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C042E10D9
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4e71a09a7so4761960e87.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548373; x=1689140373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcxDwDZfbo/85khIYBSZuraP26/4wkWE6EMGE9oVioQ=;
        b=xO8QvMEbbpDd73N5wYMdhNxf48iGu0aWOhr6Al47xOuHsTdWUOla0Qm2Iov3fSJYxK
         iKPuOLaApFe5S8HaV2vas+g+6hK+fPhANh8DbvbfNp9UbdVIsfRQBjKdyfMdX0kYe9ds
         lpFMJh3wJ0pFM6P3L5e86Qd1HY/7J+zjchux515AFXZN2NeAruWI1oTRkzIMHBp8abbp
         PrO4rCqrGorIEjio732nTIIE4MYdfPd1/x/5lT8JXsFDlGismbbWGwXr+g9zD8aAI7T4
         2bOO5dCr3GCwxitQ87/WP3xlFTIMZseENFY9RKrU+c3LED13UarNTirx1qvvrRnMiYTZ
         RDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548373; x=1689140373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcxDwDZfbo/85khIYBSZuraP26/4wkWE6EMGE9oVioQ=;
        b=ftoLPtMjEJoPcuyi5uAMwN6a4WJTu0VuttRnjarSeY510c2K8fSg9Gggq/q5fW7h0P
         G9/dG1PwmdLWXcb4aG5AW+W+Ch7rUdGKEZmxuQmposekAFL5VHsLKh2CkxMSs9jhtQ6y
         vlT0uYaMOa84lVMS6mLHlQBy3rNbYKiJFsSnMg5S4o3nMXk7MjN1zH+QdOco9PZX9QcZ
         1npPEmsXCWs3HZVwppzCjBDy32we2eMDbCJ62dpNa7bIwjt1VZVvnZmAeOpkS119SuuB
         eFTRrCC7+IEp2zaPaVkIFVDcCGp2ttThfMhbrOrLKz0S9fluRQ3Q5qD058RjbrkvoBm4
         Al8g==
X-Gm-Message-State: AC+VfDynyVKnOes2Ov5ns8+fks+ZVfWD87aJNfyFw/qW6oahgRJEdahW
        vNoHIVtsKcmFyYrkF8sqlRp71Q==
X-Google-Smtp-Source: ACHHUZ6JnnQBqlWQ8vytyKIbJhtuEgKzCTcCctpgOK6LyFqsrxBZP42pngw+Hq4/WeyQZLSy35XlZA==
X-Received: by 2002:a19:791d:0:b0:4f3:a9a8:8d84 with SMTP id u29-20020a19791d000000b004f3a9a88d84mr2557182lfc.6.1686548372932;
        Sun, 11 Jun 2023 22:39:32 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:32 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 09/18] cpufreq: qcom-nvmem: Add support for voltage scaling
Date:   Mon, 12 Jun 2023 08:39:13 +0300
Message-Id: <20230612053922.3284394-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If requested by the platform, scale voltages according to data specified
in the OPP tables.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 115 ++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index fee9736f7326..18d6e6ed1bd0 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 
@@ -39,6 +40,7 @@ struct qcom_cpufreq_match_data {
 			   char **pvs_name,
 			   struct qcom_cpufreq_drv *drv);
 	const char **genpd_names;
+	const char * const *regulator_names;
 };
 
 struct qcom_cpufreq_drv {
@@ -218,6 +220,110 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
+#define NUM_SUPPLIES 2
+static int qcom_cpufreq_config_regulators(struct device *dev,
+					  struct dev_pm_opp *old_opp,
+					  struct dev_pm_opp *new_opp,
+					  struct regulator **regulators,
+					  unsigned int count)
+{
+	struct dev_pm_opp_supply supplies[NUM_SUPPLIES];
+	unsigned long old_freq, freq;
+	unsigned int i;
+	int ret;
+
+	if (WARN_ON_ONCE(count != NUM_SUPPLIES))
+		return -EINVAL;
+
+	ret = dev_pm_opp_get_supplies(new_opp, supplies);
+	if (WARN_ON(ret))
+		return ret;
+
+	old_freq = dev_pm_opp_get_freq(old_opp);
+	freq = dev_pm_opp_get_freq(new_opp);
+
+	WARN_ON(!old_freq || !freq);
+	if (freq > old_freq) {
+		for (i = 0; i < count; i++) {
+			struct regulator *reg = regulators[i];
+			struct dev_pm_opp_supply *supply = &supplies[i];
+
+			dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__,
+				supply->u_volt_min, supply->u_volt, supply->u_volt_max);
+
+			ret = regulator_set_voltage_triplet(reg,
+							    supply->u_volt_min,
+							    supply->u_volt,
+							    supply->u_volt_max);
+			if (ret) {
+				dev_err(dev, "%s: failed to set voltage (%lu %lu %lu mV): %d\n",
+					__func__, supply->u_volt_min, supply->u_volt,
+					supply->u_volt_max, ret);
+				goto restore_backwards;
+			}
+		}
+	} else {
+		for (i = count; i > 0; i--) {
+			struct regulator *reg = regulators[i - 1];
+			struct dev_pm_opp_supply *supply = &supplies[i - 1];
+
+			dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__,
+				supply->u_volt_min, supply->u_volt, supply->u_volt_max);
+
+			ret = regulator_set_voltage_triplet(reg,
+							    supply->u_volt_min,
+							    supply->u_volt,
+							    supply->u_volt_max);
+			if (ret) {
+				dev_err(dev, "%s: failed to set voltage (%lu %lu %lu mV): %d\n",
+					__func__, supply->u_volt_min, supply->u_volt,
+					supply->u_volt_max, ret);
+				goto restore_forward;
+			}
+		}
+	}
+
+	return 0;
+
+restore_backwards:
+
+	dev_pm_opp_get_supplies(old_opp, supplies);
+
+	for (; i > 0; i--) {
+		struct regulator *reg = regulators[i - 1];
+		struct dev_pm_opp_supply *supply = &supplies[i - 1];
+
+		dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__,
+			supply->u_volt_min, supply->u_volt, supply->u_volt_max);
+
+		regulator_set_voltage_triplet(reg,
+					      supply->u_volt_min,
+					      supply->u_volt,
+					      supply->u_volt_max);
+	}
+
+	return ret;
+
+restore_forward:
+
+	dev_pm_opp_get_supplies(old_opp, supplies);
+
+	for ( ; i < count; i++) {
+		struct regulator *reg = regulators[i];
+		struct dev_pm_opp_supply *supply = &supplies[i];
+
+		dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__,
+			supply->u_volt_min, supply->u_volt, supply->u_volt_max);
+
+		regulator_set_voltage_triplet(reg,
+					      supply->u_volt_min,
+					      supply->u_volt,
+					      supply->u_volt_max);
+	}
+
+	return ret;
+}
+
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv;
@@ -305,7 +411,14 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			config.virt_devs = NULL;
 		}
 
-		if (config.supported_hw || config.genpd_names) {
+		if (drv->data->regulator_names) {
+			config.config_regulators = qcom_cpufreq_config_regulators;
+			config.regulator_names = drv->data->regulator_names;
+		}
+
+		if (config.supported_hw ||
+		    config.genpd_names ||
+		    config.regulator_names) {
 			drv->opp_tokens[cpu] = dev_pm_opp_set_config(cpu_dev, &config);
 			if (drv->opp_tokens[cpu] < 0) {
 				ret = drv->opp_tokens[cpu];
-- 
2.39.2

