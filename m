Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13441744F54
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGBRux (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjGBRuw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:50:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D22E67
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:50:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so4595804e87.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688320248; x=1690912248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZQJLTJ2EerMHDwduBzrfbgK2+3NvX2yJnYFO5QKR6Q=;
        b=vuJpzPvDaaQ4/kTwvTX9dc+8JsfFGjeeXY8ZoivSFxssTE1UbBtpfm6Jo6ymucoAmr
         HJI30T+Bz9s7sBkObYaJqPvVH8nKmf5RK8eCeZXmo2jCLv38F9uqvOd+xlN6ksHB19Sx
         rSHwUoiOb5WrJgDU4HScXPbM0FySfoRhxLkxX+kRmDLBqFqEbU9ePFS12m4oBqOoPP+X
         03ZDN+u9/GQia+jipO2dlUVdEVvf181HOTroiQfPLk1/I5jhysaYI25YlaiyTuk3+jH2
         pLV2ILxYKT+jiBnFSGOMm9JI9As5gHEwtsXFyvjmDFHzL9WghXRuatkq+fqNt0BXwUvy
         pWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688320248; x=1690912248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZQJLTJ2EerMHDwduBzrfbgK2+3NvX2yJnYFO5QKR6Q=;
        b=h6gA66BD8sxX2xVj5RdI/I8VxFiMzByLst9BVw1W80uB489MkzShIUTKrTgyL9CybG
         Atou7O9DXXsKPnTFaU0KfDOFg/D8LwxJ/DBLWnZAloPsnEyWF8yfNzIaiSgz1sL1lfCz
         egLJvkTdIEzaQXIKkHeOQuEzx5XX8oSQKJdEstm7ijZoV7PaYkECyncsCO/74Snum71t
         J6uEaW2bGL5kFWpV8zIYlZKZhqx/vQE29LR0Au9PYA2+DB5b0WBf+vIEDUAC68JRRHkz
         FqmsnDjnLyFLKG1nrwN+ZkHs7sUftYwOL+HYkWesV56Eg5JJHJgiZpInNMKMztnGAQpw
         XGfQ==
X-Gm-Message-State: AC+VfDyttlNKz+54sqJ98TxQ2DFaEdy8hOHQKtYECOsd9s7QLsN3JY8s
        8uifs1p+h0AyFZh00FSMDvuW6g==
X-Google-Smtp-Source: ACHHUZ5QbzPu6/c+3YUBe1rdRQkXCw7v4E1AUk5y64Ec/hIjjtRQw3XTnxSap3+9Q60pKdC9JB24FQ==
X-Received: by 2002:a05:6512:2352:b0:4f4:b10f:d521 with SMTP id p18-20020a056512235200b004f4b10fd521mr4038332lfu.13.1688320248805;
        Sun, 02 Jul 2023 10:50:48 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d1-20020ac24c81000000b004fb759964a9sm3354130lfl.168.2023.07.02.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:50:48 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [RFC PATCH 3/8] cpufreq: qcom-nvmem: provide vmin constraint for early Kraits
Date:   Sun,  2 Jul 2023 20:50:40 +0300
Message-Id: <20230702175045.122041-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
References: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Early Krait CPUs required that core voltage was not below 1.15 V.
Implement this requirement by adding separate config_regulators
callback.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 67 +++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 113f35668048..9312c8ab62a8 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -30,6 +30,8 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 
+#include <asm/cputype.h>
+
 #include <dt-bindings/arm/qcom,ids.h>
 
 struct qcom_cpufreq_drv;
@@ -257,6 +259,66 @@ static const struct qcom_cpufreq_match_data match_data_apq8064 = {
 	.regulator_names = apq8064_regulator_names,
 };
 
+static const int krait_needs_vmin(void)
+{
+	switch (read_cpuid_id()) {
+	case 0x511F04D0: /* KR28M2A20 */
+	case 0x511F04D1: /* KR28M2A21 */
+	case 0x510F06F0: /* KR28M4A10 */
+		return 1;
+	default:
+		return 0;
+	};
+}
+
+#define KRAIT_VMIN	1150000
+#define KRAIT_VMIN_MAX	(KRAIT_VMIN + 25000)
+static int krait_config_regulator_vmin(struct device *dev,
+				       struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
+				       struct regulator **regulators, unsigned int count)
+{
+	struct regulator *reg = regulators[0];
+	struct dev_pm_opp_supply supply;
+	int ret;
+
+	/* This function only supports single regulator per device */
+	if (WARN_ON(count > 1)) {
+		dev_err(dev, "multiple regulators are not supported\n");
+		return -EINVAL;
+	}
+
+	if (IS_ERR(reg)) {
+		dev_dbg(dev, "%s: regulator not available: %ld\n", __func__,
+			PTR_ERR(reg));
+		return 0;
+	}
+
+	ret = dev_pm_opp_get_supplies(new_opp, &supply);
+	if (WARN_ON(ret))
+		return ret;
+
+	if (supply.u_volt_min < KRAIT_VMIN) {
+		supply.u_volt_min = KRAIT_VMIN;
+		supply.u_volt = KRAIT_VMIN;
+		supply.u_volt_max = KRAIT_VMIN_MAX;
+	}
+
+	dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__,
+		supply.u_volt_min, supply.u_volt, supply.u_volt_max);
+
+	ret = regulator_set_voltage_triplet(reg,
+					    supply.u_volt_min,
+					    supply.u_volt,
+					    supply.u_volt_max);
+	if (ret)
+		dev_err(dev, "%s: failed to set voltage (%lu %lu %lu mV): %d\n",
+			__func__, supply.u_volt_min, supply.u_volt,
+			supply.u_volt_max, ret);
+
+	return ret;
+}
+
+
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv;
@@ -344,8 +406,11 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			config.virt_devs = NULL;
 		}
 
-		if (drv->data->regulator_names)
+		if (drv->data->regulator_names) {
 			config.regulator_names = drv->data->regulator_names;
+			if (krait_needs_vmin())
+				config.config_regulators = krait_config_regulator_vmin;
+		}
 
 		if (config.supported_hw ||
 		    config.genpd_names ||
-- 
2.39.2

