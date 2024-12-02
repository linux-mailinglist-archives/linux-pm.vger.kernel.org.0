Return-Path: <linux-pm+bounces-18359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977C9E071F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 16:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1AD16486E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C820C029;
	Mon,  2 Dec 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/ag1EWL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03B20A5E1;
	Mon,  2 Dec 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152393; cv=none; b=WiEvYaqptO/MkFV/e0Dp384wezlKiNtkyrJeo3LodWefyclcZVwVZgcJjHSjzaTODeLHW86csTXEc5xS0UVLLlEL9LU5GoJbyMzSMU2nrmy3aXCjN2NhhsbOUBj+D3ff/aWt4a4QkIbrbtLRsgmNeInTAgJf9gZeuwdIZn3rFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152393; c=relaxed/simple;
	bh=hgyWZH4F62jNxavKD66RRs0vHTyEatO7/IFqiiAsdUo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imsKS5JqimC4xuB3KoTgjdUXi6G+1H+QeeCYDpJdc75N0vqY9HNX9Fgk+iolrXS7d6tnbjTeJlziYapxRONreLKyCWv/nBFdntIMK8CDmCDFkfKUbf3Dgvuq3cD50NeGMd9bhd7gyUr29shycMClOXmhM+E6Z0qRjUs8lvA6FSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/ag1EWL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-432d86a3085so36430705e9.2;
        Mon, 02 Dec 2024 07:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733152389; x=1733757189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbreFTMSILvFmiIjtGhpGrlLSi8p4N40sJ7ueFzO6Sk=;
        b=Y/ag1EWLdHqTT/RO6v75+6to+n/0dPTT8+ybL9hkrkGgZ6sDQdq0R/k0g08ixhcMDl
         CFMPMM/DWJEEjvt+18b0nNH0Lerhw7W9QzvIVKYid4df11/OD3fJdy8UeAwFFDxCfkTR
         iF0ZSMVm5m0WD+3t48yD7oCSA9TXQWGXGUCjIF8BLoAjrV0msoSd2f5pbrXbhOfjT8PC
         qyzVhAo9vbtyHXGmF4ybBv0r+qKgH1yP3/gF6YPPsA5Cg+I/KcnDSKx45L3gKAcFYahH
         SfoKzkuLaBR56lj64rlnRh5d6txGrUZ+jLZxpmuaqadWY0qxfrq7uvu1uKmWbISsB0WV
         HU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152389; x=1733757189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbreFTMSILvFmiIjtGhpGrlLSi8p4N40sJ7ueFzO6Sk=;
        b=j8hWXq5SXmxq63ITII3YH5miL2ESlDY3Bg0c27wKPizv22iJ6C1sGh5V54Yf48Bwsf
         1nAt0lWJziCtM2fz9pWdMKGpVjW/hSQMUkBp2FROXqRoOuPm+EmZhUzc8U1nOpl5Xlsi
         sG2oyqN3GxFZwzUTXtOE2yD9rhjrmNHv8LDgkliGVQmBloZ2SnlIXgKxp/tdrZqL1e9C
         ipNI0mTbyU5OImMzcJi85RxLNLdONkW5fRI2UHEX+pKdWKZDsuF1owaHp9YwVd6IRu0L
         dZyTFSlc21YltVni7dwQueeEcNvnxnNyMY8S6aBRxz1xEMTC3p6SbQsAB2uEbjoBq18T
         A5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0fEvrs4ap18nTFHGk9FKSKNGHMlHBYmmOIYicizVOiK6ly3oCZDf5E0HbgnLU4UoMjTjO97xYEI77@vger.kernel.org, AJvYcCVHaP4XIbCmOmq86bqhNu1+mi57xosRwglsf6cb1ql4+p4EBxERN+gex2o8GgdIHDCnlZsb448P/p0=@vger.kernel.org, AJvYcCXrYaJ0Z+jD5fGXBJ93t4oHKileyCHGqQ4eGyjewnH7Si2PhmqWEKWVVzNPIz8AxS/pymuQ9Uw6HylDRd5B@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYJ6tksS2OBOD9N2M8yVHcD7UXkYbSBtbora7SXwcni+lcVAd
	hV/Zh1GDjYaOJcaCibrycXD6Y8b6otXypFdQzB50oyfePfcvIuUs
X-Gm-Gg: ASbGncuTmhtyC7HJhxp7kgue1rTGbMZUHm60LU2XvIE5BGB8ke7mvVO9+v6swVNNVtt
	iynaZJXYlHNw3fcpVpSZt/MmDXelKyiEGr2MC2TqPR4BNkpM7p+NfbVHPwvz8Ch/xowtdWIMdS4
	saqIoOLKWOsEYfqNbmzLXQJHI77ZUT7d9arDZCFMAFfmg5lgWJu/0Cm+lyN7pZlIp1do7SAJ+Jk
	Upw26YJVpPh6m+cwhs+ZWimRFZtY3vBWHEmjsjdWATn6vWKrgTeBM4up0GdorjqhgNRrI2G8WTE
	t7xZ4MsUzhpziS/IlAE=
X-Google-Smtp-Source: AGHT+IGSsRVgA0BiMHuiHxh7Njn4BSULa5d7LgbN5teLIdHLWcwjTW+pXzYn9yV3HoT3hxIyL8yCYA==
X-Received: by 2002:a05:6000:1787:b0:382:4ab4:b43c with SMTP id ffacd0b85a97d-385c6eb736dmr17380038f8f.21.1733152388287;
        Mon, 02 Dec 2024 07:13:08 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434b0dc6831sm154173915e9.20.2024.12.02.07.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:13:07 -0800 (PST)
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
Subject: [PATCH v4 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Date: Mon,  2 Dec 2024 16:12:04 +0100
Message-ID: <20241202151228.32609-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202151228.32609-1-ansuelsmth@gmail.com>
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
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
index 0f184031dd12..8e5a37a95d36 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_AIROHA_SOC_CPUFREQ)	+= airoha-cpufreq.o
 obj-$(CONFIG_ARM_APPLE_SOC_CPUFREQ)	+= apple-soc-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
new file mode 100644
index 000000000000..46f57236c4db
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
+static const char * const airoha_cpufreq_pd_names[] = { "cpu_pd" };
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
+	.remove_new = airoha_cpufreq_remove,
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
index 18942bfe9c95..5ecd8234bfac 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -103,6 +103,8 @@ static const struct of_device_id allowlist[] __initconst = {
  * platforms using "operating-points-v2" property.
  */
 static const struct of_device_id blocklist[] __initconst = {
+	{ .compatible = "airoha,en7581", },
+
 	{ .compatible = "allwinner,sun50i-h6", },
 	{ .compatible = "allwinner,sun50i-h616", },
 	{ .compatible = "allwinner,sun50i-h618", },
-- 
2.45.2


