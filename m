Return-Path: <linux-pm+bounces-18496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF4E9E2788
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 17:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9FF287E30
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14811F8AF9;
	Tue,  3 Dec 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RabNaIui"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B02BD1D;
	Tue,  3 Dec 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243557; cv=none; b=oAq+gkRFhKrgXmlDBldWQX8sbDNUQgMUyHtt16i3Xx+LgoaRl2mYvyUwhnLMonbnYd37yI5AmM4sC7EkZadKKGY4BzoPGMKy0hMFs3OGND4QygdQGcI2/eRk0zcwQDdm3nfL3TDHAsxhuS8Tuzo8HrrqxS0K2c+oGhnchur1QYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243557; c=relaxed/simple;
	bh=NBX6bYm6PhcZfSxF1qU6KXTeVP0t2N/WAHddnWEmCe0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAPOEPdL8dr9Bu2UFmxvI+Ux90HwR0/NZ2OUmrwaR9y99g21sGkDDgzVDTjI6HeWKtl/mGS3voNXKouJbVUKEdJZnZNs3d03doGXmpvxESOtYn8oSR1Z0Q3wq7tpDHby9hMzGCSO6bggHf4mITsQVhie/bMvMkN94zMgeU9AupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RabNaIui; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so39630005e9.1;
        Tue, 03 Dec 2024 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733243554; x=1733848354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hoHQXJns3WQSxcJjLxgMbUHXjcsCq0OA+uui3Ubc7w=;
        b=RabNaIuibcQEDO71BVxUi7397/FMoy8hCUsg0xP90uCRM3tgxXW/aZ8sSA1uMtnpT6
         LU1ofl3LG55hE9nPc084AgElaPl5NHGtt0634uE0m3P7aikwQAx+2xu80IUg5q5dLv3o
         cfVP8NTDlVJ9QKvIBRW0Cmfdz0dBZ/1NmUfLVobWlrhKRBY/TrpxIfrpRoqzsCYIetdS
         0UyAmxzaH4PbyHaVM43dHuSOXWXN8jIPqGonxSPmsGXcC5RPg/+NNwgzIXHSvcIwflkz
         S7Qs73C72n/hGGSbKgNMQIyiTteOpL9rr2Y5S7xBctLzuabbVduAdUlFZBa+NvndNcre
         EcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243554; x=1733848354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hoHQXJns3WQSxcJjLxgMbUHXjcsCq0OA+uui3Ubc7w=;
        b=VE1lQjD0Ycrww9d7n8JglMLn0sNHvqUEAV0HUbs3kuI/ZzktYlPwC8lBSR0lHbcthG
         8unotBroVu2Za7DJvFzgQuIRICuA7SIHhRGi3YgGt+3iEZ5TxBNnCbJ7JMWyIYPRRJAW
         b04FqHxyhqGKc9rMIzSSwJ39wF+VKr0Ik9KDr5wzsbwquuD+hCjyRF6bpsmuzLZw7ZaT
         3p3aVesVUPy4P+VTs/7xfjJm4ET3fUnx3Yfp9VFo7/3zt6oxtqlPNM1XlyX3a7+CNdD5
         tPMCTXDiqmHQIVTt9KOe/VXQdmdc6kX1qFXPyGQA8IwYKeZenA4NKIuJdyE4trAGvj/9
         GuzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2MDNWxIjBaUXEBhe59wuc89ygzW/R8N20pMqS+5n91vwsx3J7plcIgd917nVT6RMjmQI2in6qVXQ=@vger.kernel.org, AJvYcCVdcvL21b1U6C5KXFhz/lC24iyRR157nvisrpEgXTIs4D7sI8bg0CSzClSSc948vJgf7Mc38kn9X2Ah@vger.kernel.org, AJvYcCXDfcAHIyoQPtS9VY51sgtFPpiGGs8fuZxtxGuGXtaK1Z2U647l+7kuH/jtwLyHkKGWwD85PvqDNEuYz2DH@vger.kernel.org
X-Gm-Message-State: AOJu0YzKitHMBLH/mnPAVIARRE+JPv6fxBnfU+Iz+/djypel/N3fi0sR
	OkpZtEVIJqOgtF2CgbUzNuht4IVg+Jnvg1+VbnukKm07EvX1zQ7B
X-Gm-Gg: ASbGncsDZWVOARmljK5B80CWaStC/uLblX36bf0UzI4Ovv3rAIVqb3VEyGT3xc6orDf
	rX/1b75aOskOhR8lwx4jV0V5nlbizLqhDvH10xKtZlxx76Urma6lrYSj4q7wcgMy+gQA/E6Z0DU
	GpKgCQzfOSFEcjMSex0Ny9Okd624tgpFqjGObSeGJQi80Kk28oYescQQWJ4FWr07Qm30cf32sbz
	eWTfuMY4l3VQg96202vB+0vxpp8L53LuYoyWd/SkhcWYG5JdKlu9dqdg9HKR3z9rTNb8qUcflNX
	5ZBqwQ4nNUmTcIIa390=
X-Google-Smtp-Source: AGHT+IGOIV9Ss7TtlF7QZ3YTh+TalK+AG9JsQeOxqODZxDYl0/HFghFtFoGxtDDDr4QY+gX4KZXaaQ==
X-Received: by 2002:a5d:5f48:0:b0:385:f07a:f4af with SMTP id ffacd0b85a97d-385f07af622mr8698802f8f.0.1733243553749;
        Tue, 03 Dec 2024 08:32:33 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434d43a100csm2707655e9.1.2024.12.03.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:32:33 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v5 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Date: Tue,  3 Dec 2024 17:31:50 +0100
Message-ID: <20241203163158.580-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203163158.580-1-ansuelsmth@gmail.com>
References: <20241203163158.580-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple CPU Freq driver for Airoha EN7581 SoC that control CPU
frequency scaling with SMC APIs and register a generic "cpufreq-dt"
device.

CPUFreq driver registers a get-only clock to get the current global CPU
frequency from SMC and a Power Domain to configure the performance state
for each OPP to apply the requested frequency from cpufreq-dt. This is
needed as SMC use index instead of raw frequency.

All CPU share the same frequency and can't be controlled independently.
Current shared CPU frequency is returned by the related SMC command.

Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
driver is needed with OPP v2 nodes declared in DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v5:
- Rename cpu_pd to perf for power domain name
- Use remove instead of remove_new
Changes v4:
- Rework to clk-only + PM set_performance_state implementation
Changes v3:
- Adapt to new cpufreq-dt APIs
- Register cpufreq-dt instead of custom freq driver
Changes v2:
- Fix kernel bot error with missing slab.h and bitfield.h header
- Limit COMPILE_TEST to ARM64 due to smcc 1.2

 drivers/cpufreq/Kconfig.arm          |   9 ++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/airoha-cpufreq.c     | 222 +++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 4 files changed, 234 insertions(+)
 create mode 100644 drivers/cpufreq/airoha-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 5f7e13e60c80..b6f72ee41364 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -15,6 +15,15 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun50i-cpufreq-nvmem.
 
+config ARM_AIROHA_SOC_CPUFREQ
+	tristate "Airoha EN7581 SoC CPUFreq support"
+	depends on ARCH_AIROHA || (COMPILE_TEST && ARM64)
+	select PM_OPP
+	select PM_GENERIC_DOMAINS
+	default ARCH_AIROHA
+	help
+	  This adds the CPUFreq driver for Airoha EN7581 SoCs.
+
 config ARM_APPLE_SOC_CPUFREQ
 	tristate "Apple Silicon SoC CPUFreq support"
 	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index d35a28dd9463..890fff99f37d 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_AIROHA_SOC_CPUFREQ)	+= airoha-cpufreq.o
 obj-$(CONFIG_ARM_APPLE_SOC_CPUFREQ)	+= apple-soc-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
new file mode 100644
index 000000000000..363b3738adf9
--- /dev/null
+++ b/drivers/cpufreq/airoha-cpufreq.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/cpufreq.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include "cpufreq-dt.h"
+
+#define AIROHA_SIP_AVS_HANDLE			0x82000301
+#define AIROHA_AVS_OP_BASE			0xddddddd0
+#define AIROHA_AVS_OP_MASK			GENMASK(1, 0)
+#define AIROHA_AVS_OP_FREQ_DYN_ADJ		(AIROHA_AVS_OP_BASE | \
+						 FIELD_PREP(AIROHA_AVS_OP_MASK, 0x1))
+#define AIROHA_AVS_OP_GET_FREQ			(AIROHA_AVS_OP_BASE | \
+						 FIELD_PREP(AIROHA_AVS_OP_MASK, 0x2))
+
+struct airoha_cpufreq_priv {
+	struct clk_hw hw;
+	struct generic_pm_domain pd;
+
+	int opp_token;
+	struct dev_pm_domain_list *pd_list;
+	struct platform_device *cpufreq_dt;
+};
+
+static long airoha_cpufreq_clk_round(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	return rate;
+}
+
+static unsigned long airoha_cpufreq_clk_get(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	const struct arm_smccc_1_2_regs args = {
+		.a0 = AIROHA_SIP_AVS_HANDLE,
+		.a1 = AIROHA_AVS_OP_GET_FREQ,
+	};
+	struct arm_smccc_1_2_regs res;
+
+	arm_smccc_1_2_smc(&args, &res);
+
+	/* SMCCC returns freq in MHz */
+	return (int)(res.a0 * 1000 * 1000);
+}
+
+/* Airoha CPU clk SMCC is always enabled */
+static int airoha_cpufreq_clk_is_enabled(struct clk_hw *hw)
+{
+	return true;
+}
+
+static const struct clk_ops airoha_cpufreq_clk_ops = {
+	.recalc_rate = airoha_cpufreq_clk_get,
+	.is_enabled = airoha_cpufreq_clk_is_enabled,
+	.round_rate = airoha_cpufreq_clk_round,
+};
+
+static const char * const airoha_cpufreq_clk_names[] = { "cpu", NULL };
+
+/* NOP function to disable OPP from setting clock */
+static int airoha_cpufreq_config_clks_nop(struct device *dev,
+					  struct opp_table *opp_table,
+					  struct dev_pm_opp *opp,
+					  void *data, bool scaling_down)
+{
+	return 0;
+}
+
+static const char * const airoha_cpufreq_pd_names[] = { "perf" };
+
+static int airoha_cpufreq_set_performance_state(struct generic_pm_domain *domain,
+						unsigned int state)
+{
+	const struct arm_smccc_1_2_regs args = {
+		.a0 = AIROHA_SIP_AVS_HANDLE,
+		.a1 = AIROHA_AVS_OP_FREQ_DYN_ADJ,
+		.a3 = state,
+	};
+	struct arm_smccc_1_2_regs res;
+
+	arm_smccc_1_2_smc(&args, &res);
+
+	/* SMC signal correct apply by unsetting BIT 0 */
+	return res.a0 & BIT(0) ? -EINVAL : 0;
+}
+
+static int airoha_cpufreq_probe(struct platform_device *pdev)
+{
+	const struct dev_pm_domain_attach_data attach_data = {
+		.pd_names = airoha_cpufreq_pd_names,
+		.num_pd_names = ARRAY_SIZE(airoha_cpufreq_pd_names),
+		.pd_flags = PD_FLAG_DEV_LINK_ON | PD_FLAG_REQUIRED_OPP,
+	};
+	struct dev_pm_opp_config config = {
+		.clk_names = airoha_cpufreq_clk_names,
+		.config_clks = airoha_cpufreq_config_clks_nop,
+	};
+	struct platform_device *cpufreq_dt;
+	struct airoha_cpufreq_priv *priv;
+	struct device *dev = &pdev->dev;
+	const struct clk_init_data init = {
+		.name = "cpu",
+		.ops = &airoha_cpufreq_clk_ops,
+		/* Clock with no set_rate, can't cache */
+		.flags = CLK_GET_RATE_NOCACHE,
+	};
+	struct generic_pm_domain *pd;
+	struct device *cpu_dev;
+	int ret;
+
+	/* CPUs refer to the same OPP table */
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Init and register a get-only clk for Cpufreq */
+	priv->hw.init = &init;
+	ret = devm_clk_hw_register(dev, &priv->hw);
+	if (ret)
+		return ret;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					  &priv->hw);
+	if (ret)
+		return ret;
+
+	/* Init and register a PD for Cpufreq */
+	pd = &priv->pd;
+	pd->name = "cpu_pd";
+	pd->flags = GENPD_FLAG_ALWAYS_ON;
+	pd->set_performance_state = airoha_cpufreq_set_performance_state;
+
+	ret = pm_genpd_init(pd, NULL, false);
+	if (ret)
+		return ret;
+
+	ret = of_genpd_add_provider_simple(dev->of_node, pd);
+	if (ret)
+		goto err_add_provider;
+
+	/* Set OPP table conf with NOP config_clks */
+	priv->opp_token = dev_pm_opp_set_config(cpu_dev, &config);
+	if (priv->opp_token < 0) {
+		ret = priv->opp_token;
+		dev_err(dev, "Failed to set OPP config\n");
+		goto err_set_config;
+	}
+
+	/* Attach PM for OPP */
+	ret = dev_pm_domain_attach_list(cpu_dev, &attach_data,
+					&priv->pd_list);
+	if (ret)
+		goto err_attach_pm;
+
+	cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(cpufreq_dt);
+	if (ret) {
+		dev_err(dev, "failed to create cpufreq-dt device: %d\n", ret);
+		goto err_register_cpufreq;
+	}
+
+	priv->cpufreq_dt = cpufreq_dt;
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+err_register_cpufreq:
+	dev_pm_domain_detach_list(priv->pd_list);
+err_attach_pm:
+	dev_pm_opp_clear_config(priv->opp_token);
+err_set_config:
+	of_genpd_del_provider(dev->of_node);
+err_add_provider:
+	pm_genpd_remove(pd);
+
+	return ret;
+}
+
+static void airoha_cpufreq_remove(struct platform_device *pdev)
+{
+	struct airoha_cpufreq_priv *priv = platform_get_drvdata(pdev);
+
+	platform_device_unregister(priv->cpufreq_dt);
+
+	dev_pm_domain_detach_list(priv->pd_list);
+
+	dev_pm_opp_clear_config(priv->opp_token);
+
+	of_genpd_del_provider(pdev->dev.of_node);
+	pm_genpd_remove(&priv->pd);
+}
+
+static const struct of_device_id airoha_cpufreq_of_match[] = {
+	{ .compatible = "airoha,en7581-cpufreq" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, airoha_cpufreq_of_match);
+
+static struct platform_driver airoha_cpufreq_driver = {
+	.probe = airoha_cpufreq_probe,
+	.remove = airoha_cpufreq_remove,
+	.driver = {
+		.name = "airoha-cpufreq",
+		.of_match_table = airoha_cpufreq_of_match,
+	},
+};
+module_platform_driver(airoha_cpufreq_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("CPUfreq driver for Airoha SoCs");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 9c198bd4f7e9..2aa00769cf09 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -103,6 +103,8 @@ static const struct of_device_id allowlist[] __initconst = {
  * platforms using "operating-points-v2" property.
  */
 static const struct of_device_id blocklist[] __initconst = {
+	{ .compatible = "airoha,en7581", },
+
 	{ .compatible = "allwinner,sun50i-a100" },
 	{ .compatible = "allwinner,sun50i-h6", },
 	{ .compatible = "allwinner,sun50i-h616", },
-- 
2.45.2


