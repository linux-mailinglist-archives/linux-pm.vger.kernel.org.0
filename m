Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D339D73D3E8
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFYU0L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjFYU0F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3A6E71
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f86a7a5499so3301081e87.2
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724761; x=1690316761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrZT1xpqMoW3gRcTc+trXrBHNBhRtmW4micpomQsV/g=;
        b=AKMRZvZeIcgxnPp9S2o0aLNnvnBggnBtK6vKo9qv3tT4rRiCe/1Dsjd8zq6LmNrGJx
         g7XnXBWYP7gSYdi/+vam5LcNU2iWMGYyPO6+sPJ+6DQJ8A2FaxPcSgzGDteDsLUg/rKn
         b14jNx6Ilz9Sb0m/qUwK1r6uYv6QSHSnf8czrccJz1k0dOYEmGDqcJGbvhj0u0cTekw7
         Giy014l8SQhqy5RrAvGnSKMgOpKJZwAAhOSi3kmcL9zOMa8ZYljaKipKnEn+Oswv6uZU
         NzHNNU07Gpw/xQAkH1Hvv+O6PnyYqkmV0WG38xdVpwrfGX5Ka4npm/HzX8Qfk0I5cJ01
         pDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724761; x=1690316761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrZT1xpqMoW3gRcTc+trXrBHNBhRtmW4micpomQsV/g=;
        b=VLQMmJsjNqTimQEM+U3Ve+qFtLnNw4KGbHiI05VrsjIsIzx+57SO8r+cRQSl58CPaz
         EyFBqvvMHbC/EUunkrTfPjJentMniwUf2WU+0m+/aGfuurGQNECdPXYIk9HWeKN7tyCx
         YHg13SLJQAxHyWB2SLW8T3i1D4GHLTP4nrFcUR0VgQScQ4xDqKk9V20bcicIfSjVQetl
         TE7oQZdPhP1Fhuc1fEjd/AFVFR3FhtpnMNAo3e6vBQT2vWqq2FAzYWYGXLGZQ0wtB2M+
         fOXZQB80W3kViynW4Ew2ubhWJBjqTnfwqHp0vU0RrVpRoLRgz+5vCYe7vEDCvaHHPozB
         mJ+w==
X-Gm-Message-State: AC+VfDx4ONiGz8x7qCHsr0UgUkvHQ9jXSN+9orUCM0QnmKU2AtkqBoEI
        qSdePnDvy/i5nDKweLiPSGE0GQ==
X-Google-Smtp-Source: ACHHUZ6f/DZyY4dB8uTPX5S/fBFEaC/BzP9VlRMVw3OPG5M/kQ4JZPDwtHZwezEwm1m5zj8PL+9m+Q==
X-Received: by 2002:a19:5f05:0:b0:4f8:442c:de25 with SMTP id t5-20020a195f05000000b004f8442cde25mr14503886lfb.5.1687724761237;
        Sun, 25 Jun 2023 13:26:01 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:26:00 -0700 (PDT)
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
Subject: [PATCH v2 13/26] soc: qcom: Add driver for Qualcomm Krait L2 cache scaling
Date:   Sun, 25 Jun 2023 23:25:34 +0300
Message-Id: <20230625202547.174647-14-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
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

Add a simple driver that handles scaling of L2 frequency and voltages.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/Kconfig          |   9 ++
 drivers/soc/qcom/Makefile         |   1 +
 drivers/soc/qcom/krait-l2-cache.c | 190 ++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 drivers/soc/qcom/krait-l2-cache.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e597799e8121..01090b7a3c06 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -70,6 +70,15 @@ config QCOM_LLCC
 	  SDM845. This provides interfaces to clients that use the LLCC.
 	  Say yes here to enable LLCC slice driver.
 
+config QCOM_KRAIT_L2_CACHE
+	tristate "Qualcomm Krait L2 cache scaling"
+	depends on ARCH_QCOM && ARM || COMPILE_TEST
+	select INTERCONNECT
+	select INTERCONNECT_CLK
+	default ARM_QCOM_CPUFREQ_NVMEM
+	help
+	  The driver for scaling the L2 cache frequency on Qualcomm Krait platforms.
+
 config QCOM_KRYO_L2_ACCESSORS
 	bool
 	depends on (ARCH_QCOM || COMPILE_TEST) && ARM64
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 99114c71092b..cdd1cc96e9f9 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_QCOM_APR) += apr.o
 obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
 obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
+obj-$(CONFIG_QCOM_KRAIT_L2_CACHE) += krait-l2-cache.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
diff --git a/drivers/soc/qcom/krait-l2-cache.c b/drivers/soc/qcom/krait-l2-cache.c
new file mode 100644
index 000000000000..af9e7b955daf
--- /dev/null
+++ b/drivers/soc/qcom/krait-l2-cache.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/interconnect-clk.h>
+#include <linux/interconnect-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
+
+#include <dt-bindings/soc/qcom,krait-l2-cache.h>
+
+/* Random ID that doesn't clash with main qnoc and OSM */
+#define L2_MASTER_NODE 2000
+
+/* vdd-mem and vdd-dig */
+#define NUM_SUPPLIES 2
+static int krait_l2_config_regulators(struct device *dev,
+				      struct dev_pm_opp *old_opp,
+				      struct dev_pm_opp *new_opp,
+				      struct regulator **regulators,
+				      unsigned int count)
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
+static int krait_l2_probe(struct platform_device *pdev)
+{
+	struct dev_pm_opp_config krait_l2_cfg = {
+		.clk_names = (const char * const[]) { NULL, NULL },
+		.config_regulators = krait_l2_config_regulators,
+		.regulator_names = (const char * const[]) { "vdd-mem", "vdd-dig", NULL },
+	};
+	struct icc_clk_data data[] = {
+		{ .name = "l2", .opp = true},
+	};
+
+	struct device *dev = &pdev->dev;
+	struct icc_provider *provider;
+	struct clk *clk;
+	int ret;
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = devm_pm_opp_set_config(dev, &krait_l2_cfg);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret)
+		return ret;
+
+	data[0].clk = clk;
+	provider = icc_clk_register(dev, L2_MASTER_NODE, ARRAY_SIZE(data), data);
+	if (IS_ERR(provider))
+		return PTR_ERR(provider);
+
+	platform_set_drvdata(pdev, provider);
+
+	return 0;
+}
+
+static int krait_l2_remove(struct platform_device *pdev)
+{
+	struct icc_provider *provider = platform_get_drvdata(pdev);
+
+	icc_clk_unregister(provider);
+
+	return 0;
+}
+
+static const struct of_device_id krait_l2_match_table[] = {
+	{ .compatible = "qcom,krait-l2-cache" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, krait_l2_match_table);
+
+static struct platform_driver krait_l2_driver = {
+	.probe = krait_l2_probe,
+	.remove = krait_l2_remove,
+	.driver = {
+		.name = "qcom-krait-l2",
+		.of_match_table = krait_l2_match_table,
+		.sync_state = icc_sync_state,
+	},
+};
+
+module_platform_driver(krait_l2_driver);
+
+MODULE_DESCRIPTION("Qualcomm Krait L2 scaling driver");
+MODULE_LICENSE("GPL v2");
-- 
2.39.2

