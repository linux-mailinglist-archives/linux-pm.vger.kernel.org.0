Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9914F686126
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 09:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjBAIDm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 03:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBAIDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 03:03:38 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA583D0AF
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 00:03:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id e10so11863827pgc.9
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 00:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKaoH6voOrCeEe9wM9lehvgyF6hiz4uKs3IziBm+HRU=;
        b=xAfQPQxRuA0JtxUnfTbeOWNFrIrGNKsL96fWIEuhZzM3nfU2jzHGOnlkgm5I+Tm2Zr
         s6h+8qC3fkrfBRUNCwp0Pr4gLCSYm1yGzlK4uQQoKaSMDFj3o20GssBgjW7xaI6sYYRp
         WJsYrkyIAyb9uXBJSsO8dqkyGwfRC4T+Sus8WcbB4XhlV0iD19F71B4OzrC+GeNgHLPc
         Qf3j3bP/aWRTooQA/6Cy/1JkkBQ8ajtTDTgf7LUnPv04CMgDJpjKCy1uaL6U5iAwDMns
         sGPeQO7iyH4pwV/4/kwm7vRc5fTcyt4uGdZ+rxf4Zo2N7xx0OEeQIZaeTckmlMxgL+lY
         TTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKaoH6voOrCeEe9wM9lehvgyF6hiz4uKs3IziBm+HRU=;
        b=pBZ+EEG2ogSDwcEOTG0kUqE6Emd4RfzFlzoRrz2+FzZmQymJvZBPq0u1fkrTnLWuzs
         SOjTwFqjxExfnTDpbV0t0fxQ6Y6bvveYn++OAhpmrCYfh3MS9Fu8nrUJrigv1/OBSCtb
         v/qMMYVf6VzCx8fgc36O2K0yIUMvjH93rhncrRHv2+MLsAokN5oiZ35ZPVbzridEYyqZ
         tNrUi2MBQifaUoaMcZg7E49DdaDDs331uX6Fi2yZ1s/dbehH7OM5A7tdjvvItY1vF/yh
         IxJZ9TOLJzwKa/ZsPH82zfBkv1uDoDEIPRsiGQ/xyJ4ZCVZsxlnx+TP2FkD6AjNUgQMt
         zFmg==
X-Gm-Message-State: AO0yUKU0GRw7terS1mgcoQ8xZuvjxHxAd9N2csKfqiRg4LA4ohwkpvlO
        76pEuxbwb8miyaxn10bl6DH/eQ==
X-Google-Smtp-Source: AK7set8ePkwRparmZt+NCaP03fc+YSNwfC2SYHoMXQGM6+HDKNuvXLb0QVeHtuMUcpzXDYWAfUIacw==
X-Received: by 2002:aa7:990a:0:b0:583:9b05:d1f0 with SMTP id z10-20020aa7990a000000b005839b05d1f0mr1555624pff.33.1675238612851;
        Wed, 01 Feb 2023 00:03:32 -0800 (PST)
Received: from niej-dt-7B47.. (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id dc6-20020a056a0035c600b005897f5436c0sm10961814pfb.118.2023.02.01.00.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 00:03:32 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     bryan.odonoghue@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
Date:   Wed,  1 Feb 2023 16:02:27 +0800
Message-Id: <20230201080227.473547-2-jun.nie@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201080227.473547-1-jun.nie@linaro.org>
References: <20230201080227.473547-1-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Cache Coherent Interconnect (CCI) is used by some Qualcomm SoCs. This
driver is introduced so that its freqency can be adjusted. And regulator
associated with opp table can be also adjusted accordingly which is
shared with cpu cluster.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/devfreq/Kconfig    |   9 +++
 drivers/devfreq/Makefile   |   1 +
 drivers/devfreq/qcom-cci.c | 162 +++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 drivers/devfreq/qcom-cci.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 9754d8b31621..6f3f1872f3fb 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -130,6 +130,15 @@ config ARM_MEDIATEK_CCI_DEVFREQ
 	  buck voltages and update a proper CCI frequency. Use the notification
 	  to get the regulator status.
 
+config ARM_QCOM_CCI_DEVFREQ
+	tristate "QUALCOMM CCI DEVFREQ Driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	select DEVFREQ_GOV_PASSIVE
+	help
+	  This adds a devfreq driver for Qualcomm Cache Coherent Interconnect which
+	  shares the same regulator with the cpu cluster. This driver can track a
+	  proper regulator state while CCI frequency is updated.
+
 config ARM_RK3399_DMC_DEVFREQ
 	tristate "ARM RK3399 DMC DEVFREQ Driver"
 	depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index bf40d04928d0..f2526d8c168d 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
 obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
 obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)	+= mtk-cci-devfreq.o
+obj-$(CONFIG_ARM_QCOM_CCI_DEVFREQ)	+= qcom-cci.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)	+= sun8i-a33-mbus.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
diff --git a/drivers/devfreq/qcom-cci.c b/drivers/devfreq/qcom-cci.c
new file mode 100644
index 000000000000..21b5f133cddc
--- /dev/null
+++ b/drivers/devfreq/qcom-cci.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/devfreq.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/pm_opp.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define SPEED_PVS(s, p) ((s << 16) | p)
+
+struct qcom_cci {
+	struct devfreq_dev_profile profile;
+	struct devfreq *devfreq;
+	struct clk *clk;
+};
+
+static int qcom_cci_target(struct device *dev,
+		unsigned long *freq, u32 flags)
+{
+	struct dev_pm_opp *new_opp;
+	int ret;
+
+	new_opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(new_opp)) {
+		ret = PTR_ERR(new_opp);
+		dev_err(dev, "failed to get recommended opp: %d\n", ret);
+		return ret;
+	}
+	dev_pm_opp_put(new_opp);
+
+	return dev_pm_opp_set_rate(dev, *freq);
+}
+
+static int qcom_cci_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct qcom_cci *priv = dev_get_drvdata(dev);
+
+	*freq = clk_get_rate(priv->clk);
+
+	return 0;
+}
+
+static int qcom_get_dev_version(struct nvmem_cell *speedbin_nvmem)
+{
+	int speed = 0, pvs = 0;
+	u8 *speedbin;
+	size_t len;
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	speed = (speedbin[0xc] >> 2) & 0x7;
+	pvs = (speedbin[0x3] >> 5 & 0x1) | ((speedbin[0x6] >> 2 & 0x3) << 1);
+	kfree(speedbin);
+
+	/* Convert speedbin and PVS into version bit map */
+	switch (SPEED_PVS(speed, pvs)) {
+	case SPEED_PVS(0, 0): return 0x1;
+	case SPEED_PVS(2, 0): return 0x2;
+	case SPEED_PVS(2, 2): return 0x4;
+	case SPEED_PVS(4, 0): return 0x8;
+	case SPEED_PVS(5, 0): return 0x10;
+	case SPEED_PVS(5, 6): return 0x20;
+	default:
+		return 0x1;
+	}
+}
+
+static void qcom_cci_exit(struct device *dev)
+{
+	dev_pm_opp_of_remove_table(dev);
+}
+
+static int qcom_cci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qcom_cci *priv;
+	const char *gov = DEVFREQ_GOV_USERSPACE;
+	struct device_node *np = dev->of_node;
+	struct nvmem_cell *speedbin_nvmem;
+	int ret;
+	u32 version;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		ret = PTR_ERR(priv->clk);
+		dev_err(dev, "failed to fetch clk: %d\n", ret);
+		return ret;
+	}
+	platform_set_drvdata(pdev, priv);
+
+	/* Check whether we have profiled speed version per chip */
+	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
+	if (IS_ERR(speedbin_nvmem))
+		return PTR_ERR(speedbin_nvmem);
+
+	version = qcom_get_dev_version(speedbin_nvmem);
+	dev_info(dev, "%s: set opp table version 0x%x\n", __func__, version);
+
+	nvmem_cell_put(speedbin_nvmem);
+	ret = dev_pm_opp_set_supported_hw(dev, &version, 1);
+	if (ret) {
+		dev_err(dev, "Failed to set supported hardware\n");
+		return ret;
+	}
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to get OPP table\n");
+		return ret;
+	}
+
+	priv->profile.target = qcom_cci_target;
+	priv->profile.exit = qcom_cci_exit;
+	priv->profile.get_cur_freq = qcom_cci_get_cur_freq;
+	priv->profile.initial_freq = clk_get_rate(priv->clk);
+
+	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
+						gov, NULL);
+	if (IS_ERR(priv->devfreq)) {
+		ret = PTR_ERR(priv->devfreq);
+		dev_err(dev, "failed to add devfreq device: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	dev_pm_opp_of_remove_table(dev);
+	return ret;
+}
+
+static const struct of_device_id qcom_cci_of_match[] = {
+	{ .compatible = "qcom,msm8939-cci"},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, qcom_cci_of_match);
+
+static struct platform_driver qcom_cci_platdrv = {
+	.probe		= qcom_cci_probe,
+	.driver = {
+		.name	= "qcom-cci-devfreq",
+		.of_match_table = qcom_cci_of_match,
+	},
+};
+module_platform_driver(qcom_cci_platdrv);
+
+MODULE_DESCRIPTION("QCOM cci frequency scaling driver");
+MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
+MODULE_LICENSE("GPL");
-- 
2.34.1

