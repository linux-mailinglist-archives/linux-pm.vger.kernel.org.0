Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47998789D9E
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjH0LvS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjH0Luw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:50:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54B11B3
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50078eba7afso3674410e87.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137042; x=1693741842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnITtNcMyMSxc31ZcHRiGB5svJMuSqesWbV/xQT+2r4=;
        b=TvXvxT7pX3IltVpeMhXluMpr0iAt6aKaGdiA1VhKZaLGyoPyVOq9ubp5mS6qwgCFSl
         9Z0kBJA9NzujKSBXDG8mMFN2ZI0GlRox+Uk9dxspWZppfPhAYbewyHxOwbbZy38WPJiY
         yQ16da9gZXJHlXso3InW7qls/RCXUF4PYiyvGQ1F7YjXNeFIK67liBWvEQGuQV6DTNYd
         3YVVvlW/7fsPEhSZV2M8+3Y59S3LL4vHRPU9fdsNF4GZT+z6XOl2tz3i8Fx3ywFbzlVT
         YSKYcJS+Q5SxT16HVYyuqyEdF+KXVUhbs1xxD2Im4uhpGacGq+43W1mcXuy+163/35QT
         HzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137042; x=1693741842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnITtNcMyMSxc31ZcHRiGB5svJMuSqesWbV/xQT+2r4=;
        b=MXgOOr5cZngkQBTsdQxhWq/oo6zQevGNg701smqVS4C9k6zMQ37BmRB6vKRU2l+YNX
         bLQlxLjIXV17vtAVqi6EMr0rCX0nZjQ7HOGje5zLJPvZJyBvBSZ5CgSMkOUvy8ock0Cu
         9jD3f72uDK3uFxPh1J7AeEdXKeNmOsGxjzH/4dJXiNN84e89xD+8hJNsLh/w7h/gq6DJ
         gB+wINtOmMXVfhYn7nh4u6lDOxcwKv/J6YXHkjqLIr3wLpqy6slEi6SATQWPmL79Txag
         Pb9mkqcHP2enpGmwg1feHCNhhrb2TGqWT4RgmMfIR/bKA6C8ROdNYmhBBwtFtVNZMmwG
         3YhA==
X-Gm-Message-State: AOJu0YzgjJg55HjIyFKFBms/l/qGECDWt0odxpA0c3dfzO64XFBmBuud
        KPrzf4Z6K1b5PVnsqNoNcSz4sQ==
X-Google-Smtp-Source: AGHT+IH4hcaPqPNCAltwy+paP9T8QC2pkn6BXwS5gw26TyFFBnHvfWguhcDHxeOCmsc+VH3n604uBg==
X-Received: by 2002:a05:6512:3ca9:b0:4fd:fadc:f1e with SMTP id h41-20020a0565123ca900b004fdfadc0f1emr20733714lfv.44.1693137041909;
        Sun, 27 Aug 2023 04:50:41 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:41 -0700 (PDT)
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
Subject: [PATCH v4 08/23] soc: qcom: Add driver for Qualcomm Krait L2 cache scaling
Date:   Sun, 27 Aug 2023 14:50:18 +0300
Message-Id: <20230827115033.935089-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/soc/qcom/krait-l2-cache.c | 160 ++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/soc/qcom/krait-l2-cache.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 715348869d04..1f3040ef551d 100644
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
index bbca2e1e55bb..4d16e5cdd334 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_QCOM_STATS)	+= qcom_stats.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
 obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
+obj-$(CONFIG_QCOM_KRAIT_L2_CACHE) += krait-l2-cache.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
diff --git a/drivers/soc/qcom/krait-l2-cache.c b/drivers/soc/qcom/krait-l2-cache.c
new file mode 100644
index 000000000000..fb0ca9f4797c
--- /dev/null
+++ b/drivers/soc/qcom/krait-l2-cache.c
@@ -0,0 +1,160 @@
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
+		ret = krait_l2_set_one_supply(dev, regulators[0], &supplies[0]);
+		if (ret)
+			return ret;
+
+		ret = krait_l2_set_one_supply(dev, regulators[1], &supplies[1]);
+		if (ret) {
+			dev_pm_opp_get_supplies(old_opp, supplies);
+			krait_l2_set_one_supply(dev, regulators[0], &supplies[0]);
+
+			return ret;
+		}
+	} else {
+		ret = krait_l2_set_one_supply(dev, regulators[1], &supplies[1]);
+		if (ret)
+			return ret;
+
+		ret = krait_l2_set_one_supply(dev, regulators[0], &supplies[0]);
+		if (ret) {
+			dev_pm_opp_get_supplies(old_opp, supplies);
+			krait_l2_set_one_supply(dev, regulators[1], &supplies[1]);
+
+			return ret;
+		}
+	}
+
+	return 0;
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
+		{ .name = "l2", .opp = true },
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

