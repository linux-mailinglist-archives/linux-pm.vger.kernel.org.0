Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155013D79AA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhG0PZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbhG0PZt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 11:25:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED0BC061799
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 08:25:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z24so12684019qkz.7
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uACF40c2NdgUaP/eloeCXxsjfQEh0zhdGJ3bzro+2cQ=;
        b=U39KbeQyGRnzs3KYkDrfgoIvsPDloRvb/qtiUVV53xkfKhAcQWHbQnezvtyMWiZsoq
         RM+kSmJ8arhA0TeBKDz4gEtx28/xk+tRKFHTU4d+GEIx/KxB9yXEXbjkbSVFqtQuYH8f
         QKvSGY5XzxL26XFZXJd3IAzkoJCj10JsSHjFLnQfuGJPY8SJneOk5tzl2JkljDFUfO8o
         q/WrEygorabO5yjJGQnhwU7CmSmR7Ddg0t11uyOjpNow1F5iEEfJYAW2RX1gu/kq6mdJ
         dQ8DsnrAfyFo+wUBBmIi9lz+UOXmD388XevJU/KA/4tL100DYZOVynfMVYaIQsZk5TES
         S5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uACF40c2NdgUaP/eloeCXxsjfQEh0zhdGJ3bzro+2cQ=;
        b=o8X+HlZ/Eq8fZruu+MN5Omdcu/W6TFFky9u4FeXkA/qJ55m6nBD7JMG0X4iMffAj2t
         x5HkJjIJBUwVSp17/AIJ+ld1nnsYzKLBpIGwwAHRbDdRKBAYSDsjxNzPAhdoA/zPkRCh
         yFpIuVcyMKrAk67rYja+jaNIRqvAtpnuKsoLAVebDmc1EEu9C1Rn2GpKQAL3YIDcaoQx
         dkta8jGaHUQSHrsggbMXmjrc2PeVoRWVXF0yAkvT3mDBkaazPxgwhbEkD+8rMYOC0Rzn
         H73k6S499k00sZNnDFj3ruZ+cE2XN7BnsZOaaF0rzXz/9ELoPRbRl0JaGHH0bRHbH2+4
         VoHw==
X-Gm-Message-State: AOAM5312C2zSyeP+kefwWsOpkw8uPGcSSWuHDcpJ5zwRrnVsosjw9lyh
        fOgUJ4ozvx9Sv+fmo5C+S+jMHg==
X-Google-Smtp-Source: ABdhPJyoDCLCa1/lEC+HDYZXujjuRK34hbTueCoip0M8c5f3lBJL2Va0GWO9JUlubtn8GUd5zidCBQ==
X-Received: by 2002:a05:620a:120b:: with SMTP id u11mr22354891qkj.455.1627399515565;
        Tue, 27 Jul 2021 08:25:15 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id q4sm1539663qtr.20.2021.07.27.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 08:25:15 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     steev@kali.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [Patch v4 2/6] thermal: qcom: Add support for LMh driver
Date:   Tue, 27 Jul 2021 11:25:08 -0400
Message-Id: <20210727152512.1098329-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727152512.1098329-1-thara.gopinath@linaro.org>
References: <20210727152512.1098329-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Driver enabling various pieces of Limits Management Hardware(LMh) for cpu
cluster0 and cpu cluster1 namely kick starting monitoring of temperature,
current, battery current violations, enabling reliability algorithm and
setting up various temperature limits.

The following has been explained in the cover letter. I am including this
here so that this remains in the commit message as well.

LMh is a hardware infrastructure on some Qualcomm SoCs that can enforce
temperature and current limits as programmed by software for certain IPs
like CPU. On many newer LMh is configured by firmware/TZ and no programming
is needed from the kernel side. But on certain SoCs like sdm845 the
firmware does not do a complete programming of the h/w. On such soc's
kernel software has to explicitly set up the temperature limits and turn on
various monitoring and enforcing algorithms on the hardware.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v3->v4:
	- Minor code re-arrangement and removal of redundant code as per Bjorn's
	  review comments
	- Added suppress_bind_attrs to driver as per Bjorn's review comments.
	- Changes to support changes in LMh dt node properties naming and types.

v2->v3:
	- Rearranged enabling of various LMh subfunction and removed returning
	  on error in enabling any one subfunction as the different pieces can
	  operate and thus be enabled independently.
	- Other minor cosmetic fixes.

v1->v2:
	- Cosmetic and spelling fixes from review comments from Randy Dunlap
	- Added irq_disable to lmh_irq_ops and removed disabling of irq from
	  lmh_handle_irq. Now cpufreq explicitly disables irq prior to
	  handling it as per Bjorn's suggestion.
	- Rebased to new version of qcom_scm_lmh_dcvsh as changed in patch 1.
	- Removed generic dt compatible string and introduced platform specific one
	  as per Bjorn's suggestion.
	- Take arm, low and high temp thresholds for LMh from dt properties instead of
	  #defines in the driver as per Daniel's suggestion.
	- Other minor fixes.

 drivers/thermal/qcom/Kconfig  |  10 ++
 drivers/thermal/qcom/Makefile |   1 +
 drivers/thermal/qcom/lmh.c    | 232 ++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/thermal/qcom/lmh.c

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 8d5ac2df26dc..7d942f71e532 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -31,3 +31,13 @@ config QCOM_SPMI_TEMP_ALARM
 	  trip points. The temperature reported by the thermal sensor reflects the
 	  real time die temperature if an ADC is present or an estimate of the
 	  temperature based upon the over temperature stage value.
+
+config QCOM_LMH
+	tristate "Qualcomm Limits Management Hardware"
+	depends on ARCH_QCOM
+	help
+	  This enables initialization of Qualcomm limits management
+	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on
+	  input from temperature and current sensors.  On many newer Qualcomm SoCs
+	  LMh is configured in the firmware and this feature need not be enabled.
+	  However, on certain SoCs like sdm845 LMh has to be configured from kernel.
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 252ea7d9da0b..0fa2512042e7 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -5,3 +5,4 @@ qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
 				   tsens-8960.o
 obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
+obj-$(CONFIG_QCOM_LMH)		+= lmh.o
diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
new file mode 100644
index 000000000000..8c8e8cc35e11
--- /dev/null
+++ b/drivers/thermal/qcom/lmh.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2021, Linaro Limited. All rights reserved.
+ */
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/qcom_scm.h>
+
+#define LMH_NODE_DCVS			0x44435653
+#define LMH_CLUSTER0_NODE_ID		0x6370302D
+#define LMH_CLUSTER1_NODE_ID		0x6370312D
+
+#define LMH_SUB_FN_THERMAL		0x54484D4C
+#define LMH_SUB_FN_CRNT			0x43524E54
+#define LMH_SUB_FN_REL			0x52454C00
+#define LMH_SUB_FN_BCL			0x42434C00
+
+#define LMH_ALGO_MODE_ENABLE		0x454E424C
+#define LMH_TH_HI_THRESHOLD		0x48494748
+#define LMH_TH_LOW_THRESHOLD		0x4C4F5700
+#define LMH_TH_ARM_THRESHOLD		0x41524D00
+
+#define LMH_REG_DCVS_INTR_CLR		0x8
+
+struct lmh_hw_data {
+	void __iomem *base;
+	struct irq_domain *domain;
+	int irq;
+};
+
+static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
+{
+	struct lmh_hw_data *lmh_data = data;
+	int irq = irq_find_mapping(lmh_data->domain, 0);
+
+	/* Call the cpufreq driver to handle the interrupt */
+	if (irq)
+		generic_handle_irq(irq);
+
+	return 0;
+}
+
+static void lmh_enable_interrupt(struct irq_data *d)
+{
+	struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
+
+	/* Clear the existing interrupt */
+	writel(0xff, lmh_data->base + LMH_REG_DCVS_INTR_CLR);
+	enable_irq(lmh_data->irq);
+}
+
+static void lmh_disable_interrupt(struct irq_data *d)
+{
+	struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
+
+	disable_irq_nosync(lmh_data->irq);
+}
+
+static struct irq_chip lmh_irq_chip = {
+	.name           = "lmh",
+	.irq_enable	= lmh_enable_interrupt,
+	.irq_disable	= lmh_disable_interrupt
+};
+
+static int lmh_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	struct lmh_hw_data *lmh_data = d->host_data;
+
+	irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, lmh_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops lmh_irq_ops = {
+	.map = lmh_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int lmh_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *cpu_node;
+	struct lmh_hw_data *lmh_data;
+	int temp_low, temp_high, temp_arm, cpu_id, ret;
+	u32 node_id;
+
+	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
+	if (!lmh_data)
+		return -ENOMEM;
+
+	lmh_data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(lmh_data->base))
+		return PTR_ERR(lmh_data->base);
+
+	cpu_node = of_parse_phandle(np, "qcom,lmh-cpu", 0);
+	if (!cpu_node)
+		return -EINVAL;
+	cpu_id = of_cpu_node_to_id(cpu_node);
+	of_node_put(cpu_node);
+
+	ret = of_property_read_u32(np, "qcom,lmh-temp-high-millicelsius", &temp_high);
+	if (ret) {
+		dev_err(dev, "missing qcom,lmh-temp-high-millicelsius property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "qcom,lmh-temp-low-millicelsius", &temp_low);
+	if (ret) {
+		dev_err(dev, "missing qcom,lmh-temp-low-millicelsius property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "qcom,lmh-temp-arm-millicelsius", &temp_arm);
+	if (ret) {
+		dev_err(dev, "missing qcom,lmh-temp-arm-millicelsius property\n");
+		return ret;
+	}
+
+	/*
+	 * Only sdm845 has lmh hardware currently enabled from hlos. If this is needed
+	 * for other platforms, revisit this to check if the <cpu-id, node-id> should be part
+	 * of a dt match table.
+	 */
+	if (cpu_id == 0) {
+		node_id = LMH_CLUSTER0_NODE_ID;
+	} else if (cpu_id == 4) {
+		node_id = LMH_CLUSTER1_NODE_ID;
+	} else {
+		dev_err(dev, "Wrong CPU id associated with LMh node\n");
+		return -EINVAL;
+	}
+
+	if (!qcom_scm_lmh_dcvsh_available())
+		return -EINVAL;
+
+	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
+				 LMH_NODE_DCVS, node_id, 0);
+	if (ret)
+		dev_err(dev, "Error %d enabling current subfunction\n", ret);
+
+	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
+				 LMH_NODE_DCVS, node_id, 0);
+	if (ret)
+		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
+
+	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
+				 LMH_NODE_DCVS, node_id, 0);
+	if (ret)
+		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
+
+	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
+				 LMH_NODE_DCVS, node_id, 0);
+	if (ret) {
+		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
+		return ret;
+	}
+
+	ret = qcom_scm_lmh_profile_change(0x1);
+	if (ret) {
+		dev_err(dev, "Error %d changing profile\n", ret);
+		return ret;
+	}
+
+	/* Set default thermal trips */
+	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm,
+				 LMH_NODE_DCVS, node_id, 0);
+	if (ret) {
+		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
+		return ret;
+	}
+
+	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high,
+				 LMH_NODE_DCVS, node_id, 0);
+	if (ret) {
+		dev_err(dev, "Error setting thermal HI threshold%d\n", ret);
+		return ret;
+	}
+
+	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low,
+				 LMH_NODE_DCVS, node_id, 0);
+	if (ret) {
+		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
+		return ret;
+	}
+
+	lmh_data->irq = platform_get_irq(pdev, 0);
+	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
+	if (!lmh_data->domain) {
+		dev_err(dev, "Error adding irq_domain\n");
+		return -EINVAL;
+	}
+
+	/* Disable the irq and let cpufreq enable it when ready to handle the interrupt */
+	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
+			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
+			       "lmh-irq", lmh_data);
+	if (ret) {
+		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
+		irq_domain_remove(lmh_data->domain);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id lmh_table[] = {
+	{ .compatible = "qcom,sdm845-lmh", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lmh_table);
+
+static struct platform_driver lmh_driver = {
+	.probe = lmh_probe,
+	.driver = {
+		.name = "qcom-lmh",
+		.of_match_table = lmh_table,
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(lmh_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("QCOM LMh driver");
-- 
2.25.1

