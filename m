Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C00744F06
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjGBRn3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjGBRnD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:03 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B981E59
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:01 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b69f216c73so53861281fa.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319780; x=1690911780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToaHpu+bS+TSSVzlAiXsgBFVFvPGvZ7MVa6XyFQwsPw=;
        b=Qv1FY3YeGFdklIDg9GVCb9zo4MYDGuCASbmWAtKDPB2UOzHs6WYt9abkU2y1bg2JTd
         WISJv+YcgkQcu/I70BG0rrbGqRDnBBXfBhjt+xgSixzFKMyhGYtmMt3650qyUr00af/w
         BxuQNYdBzodZx/f3X4+lahYelrwTcK9+f4OuRDlcpD+oqOPg1gOLhsgoARYbrcJkHp/W
         O68adExqqEtmB0cKgxbzPKnjMuKgMni0YxU5soCVj9SI7Rzzz5qTTL4TAYSC2bPziPcm
         HGtxTIJ8Hl2OJBG/W4ZFzv2Rp2asQcApp+6buOV+3PZXoVSLNIY2Em4DVKpsbiukreGh
         SQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319780; x=1690911780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToaHpu+bS+TSSVzlAiXsgBFVFvPGvZ7MVa6XyFQwsPw=;
        b=cwuwPFz8biHumF/GeeihwsE9lJp2ygK+lypNQ9/jvdUc73+pCXZw4b35psx9EpxfOd
         NG7tgltkvZ3HwH8s6grjK01d4cOipLtxE90LJia6oJekN2KpO2WW9JjCO92aRovCo50v
         CtqVID6+F+Z/qstpD9GHg352Fyi9MVzmKpdeJ1EBAYxHxet7MduIxYgoHRU4frKRSL93
         HuV4CKeMbFkcjsJdnPzF/lGMQIucC5tfHcYycs07CheK3inKIMyubEmBcS22SQ/97KkW
         OMiQJNwIz0S0ALCDkC3Ajk0lUUxEtxRcUcrfpNNrqF7LNzeSSkcM2NA5m8S8DQJLifut
         ejhg==
X-Gm-Message-State: ABy/qLZxKT2IQhNT5gRw5wPNIV9PbdILYMb8Q92R7H6P9ASOJt9pDj3C
        UrDB5QLB8V7COej7TkOHjqgSJg==
X-Google-Smtp-Source: APBJJlHyDevwi/1NjTG355WznUhCaRjvXNIMrHX/HbLWuA6KukdUno24sAnbii35JFkrQEYGjLz4RQ==
X-Received: by 2002:a2e:9d03:0:b0:2b6:e623:7b57 with SMTP id t3-20020a2e9d03000000b002b6e6237b57mr897232lji.25.1688319779849;
        Sun, 02 Jul 2023 10:42:59 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:42:59 -0700 (PDT)
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
Subject: [PATCH v3 13/28] soc: qcom: Add driver for Qualcomm Krait L2 cache scaling
Date:   Sun,  2 Jul 2023 20:42:31 +0300
Message-Id: <20230702174246.121656-14-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
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

Add a simple driver that handles scaling of L2 frequency and voltages.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/Kconfig          |   9 ++
 drivers/soc/qcom/Makefile         |   1 +
 drivers/soc/qcom/krait-l2-cache.c | 167 ++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
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
index 000000000000..c493da50ab65
--- /dev/null
+++ b/drivers/soc/qcom/krait-l2-cache.c
@@ -0,0 +1,167 @@
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
+static int krait_l2_set_one_supply(struct device *dev,
+				   struct regulator *reg,
+				   struct dev_pm_opp_supply *supply)
+{
+	int ret;
+
+	dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__,
+		supply->u_volt_min, supply->u_volt, supply->u_volt_max);
+
+	ret = regulator_set_voltage_triplet(reg,
+					    supply->u_volt_min,
+					    supply->u_volt,
+					    supply->u_volt_max);
+	if (ret) {
+		dev_err(dev, "%s: failed to set voltage (%lu %lu %lu mV): %d\n",
+			__func__, supply->u_volt_min, supply->u_volt,
+			supply->u_volt_max, ret);
+		return ret;
+	}
+
+	return 0;
+}
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
+			ret = krait_l2_set_one_supply(dev, regulators[i], &supplies[i]);
+			if (ret)
+				goto restore_backwards;
+		}
+	} else {
+		for (i = count; i > 0; i--) {
+			ret = krait_l2_set_one_supply(dev, regulators[i - 1], &supplies[i - 1]);
+			if (ret)
+				goto restore_forward;
+		}
+	}
+
+	return 0;
+
+restore_backwards:
+
+	dev_pm_opp_get_supplies(old_opp, supplies);
+
+	for (; i > 0; i--)
+		krait_l2_set_one_supply(dev, regulators[i - 1], &supplies[i - 1]);
+
+	return ret;
+
+restore_forward:
+
+	dev_pm_opp_get_supplies(old_opp, supplies);
+
+	for ( ; i < count; i++)
+		krait_l2_set_one_supply(dev, regulators[i], &supplies[i]);
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

