Return-Path: <linux-pm+bounces-20149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9F4A076E8
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 14:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5D17A3571
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 13:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E61218838;
	Thu,  9 Jan 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiidcQdH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B05BA2E;
	Thu,  9 Jan 2025 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428424; cv=none; b=WhB1kLTO49+ZFlR+yPe4DS0O3hUwrmXNcFk3+/UQpashSqiYpSvEDcxtnbgXZ+jdypIZNvXBXGzdyQnD5ctPTgExUyt9PFNxhwdPtuawgGrFaNLhoRjz7RshWn6Rqp94+WgzbNxvppYE6qVnwItiCfyARRGh16GN41wPJU8YmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428424; c=relaxed/simple;
	bh=cY0IdA4avr/XmHZshF+96+n3p60epuelvtE/f+Gg9Qw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGObIWn/GEvzzQV/mpypycRdtczH5vBBP/7rl6+g0xui0eofROcq7dzEcqlZqtwE1qg721LkdAKR3HmkGt79QrR6rXHlZMIhQQK8SSnV3dH1wDN3TWys3pWzdK/DuaTAYhajVGXziwnK/lDXRPPGLp8qS9dng/vTMtJSW0VyYgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiidcQdH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so593993f8f.1;
        Thu, 09 Jan 2025 05:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736428421; x=1737033221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkN0Zbqriw5PzthPVlNgEaF6B8Bg927+i+ccWjtK+W4=;
        b=UiidcQdHhVL4m3Z3oJZUuqL+XRQowdqbYMa7/2vJJpgA04WhrrLLDeGuoOGkKwhLFY
         DWn1dv2s3r0lYNGIDdSxIL4JGkPV+gWbDmeL0bRESkHT6O0a7prG2bm013KhWyo6t7e/
         QwfBj8hQN9tvDbBbZuCNvwsgCo5BwootY+/b3LWA0mxi7ZHbPxUE5tvFeiVDCriCAtU9
         Xa9wJiQq1dX977TlcEpBVP/fdyRJ8R4s0NME7r2X1JDXy8Ff6/ifcED8KBV6XHyUrbec
         kWgPnFDDUgEteqIl+KHbmsAjqw9lVmqAmMGefvLU0Yem/nWkDn9+Ma5db1t7oy63CCwf
         9slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736428421; x=1737033221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkN0Zbqriw5PzthPVlNgEaF6B8Bg927+i+ccWjtK+W4=;
        b=PZm8mNCFUKUfcB/UWWHoVLKt/OPuhxcgumnaGP79e2GzWsN1ib/TvAj343dmD77ump
         BEu/iZJcJ3SUmGfeXBfu6YmLvSGxmm+Gj3AXDR8nmRgXfo1mH89m5yDxs+QnPvzFDBUs
         rQAoF39cBwC9HTrjjkIzji85+0a2yxAjMXt3a5lXlU1o0Jpflo2Wz1U675qc2AkyF6qn
         Fz1RWflXGZ7gC82TFFfvCib7Q1luUdO2ESS1vMC/H8DUVbATTNH4VLBgwHvA4tlf4XWt
         o/x6gBqLJpGZQACl3eYjpCqgfNFlTvyz0Nm4BOMaA8rTv52qO06OaWGczy0BuVMrC+2C
         r7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd8UxZvkorf2i6stDCbksRQf/Ne+INQ0fp1h289L0wJMlWPHbW6NSNXuMbb9EcYY7dfk2Va3bENW3NkJ0=@vger.kernel.org, AJvYcCXi0i7ol7+rfL2prwx61thLyLpE60jpW8IYkDGSA3H/A2FPHqtDaRZwoL5w0oPg7NwmzgNdYmTxZSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl96FY5w6zgx/u/Xr7sFWL+hXs4M+y2ztvXAt0GNGj6SKEEE/9
	4A56TVTD6Ape46cfXAyUnlEtuC0TxJ5kqJ+vGqHH3lsGvvs+QdPJ
X-Gm-Gg: ASbGncvEfPIbR9Qcnfl0o4PuQJ3jp6Mib9Oe1M6d20k1nAqXBDDSxrjnzhYA7r+aO6x
	ZdLYqbwCG4+O8R58dwMPnkyHmEhFu+3TjLL+n6G2WgXg/7sfok/QojfcELZQjtWSRG0T9XuYZ3A
	lt8ywkMd0Arf5IqEb5uJ/f34e6cC9/aLZg2M+p8U2XZrotnKtGTIfqh6JidxXgBY2i5j8WXl45Q
	jYFRXFu8x0WX3kSmroWc2EtgVOiO/wBf/7lYgPj0TvZVoOnAv80bygqdtoZDDtGpC5seKbrPs+R
	gpTaTWJgGpucx7/fHqurRZXkzD+1v2KentLY5tTKTw==
X-Google-Smtp-Source: AGHT+IG5cCytUXF99jwAAoz8fgNKe08AHoWKQCCBRKl1wIMKmBm470WFU6Boe0ZshyUraZJN3IFmMw==
X-Received: by 2002:a5d:47c9:0:b0:385:f470:c2c6 with SMTP id ffacd0b85a97d-38a872fad4fmr5657737f8f.11.1736428420644;
        Thu, 09 Jan 2025 05:13:40 -0800 (PST)
Received: from localhost.localdomain (host-95-246-253-26.retail.telecomitalia.it. [95.246.253.26])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e385026sm1812286f8f.42.2025.01.09.05.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:13:40 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v10 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Date: Thu,  9 Jan 2025 14:12:58 +0100
Message-ID: <20250109131313.32317-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109131313.32317-1-ansuelsmth@gmail.com>
References: <20250109131313.32317-1-ansuelsmth@gmail.com>
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

All CPU share the same frequency and can't be controlled independently.
CPU frequency is controlled by the attached PM domain.

Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
driver is needed with OPP v2 nodes declared in DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v9:
- Fix compile error targetting wrong branch (remove_new change and new PM OPs)
Changes v8:
- Split in dedicated PM domain driver
Changes v7:
- No changes
Changes v6:
- Improve Kconfig depends logic
- Select PM (PM_GENERIC_DOMAINS depends on it)
- Drop (int) cast for 
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

 drivers/cpufreq/Kconfig.arm          |   8 ++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/airoha-cpufreq.c     | 152 +++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 4 files changed, 163 insertions(+)
 create mode 100644 drivers/cpufreq/airoha-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 5f7e13e60c80..704e84d00639 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -15,6 +15,14 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun50i-cpufreq-nvmem.
 
+config ARM_AIROHA_SOC_CPUFREQ
+	tristate "Airoha EN7581 SoC CPUFreq support"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	select PM_OPP
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
index 000000000000..4fe39eadd163
--- /dev/null
+++ b/drivers/cpufreq/airoha-cpufreq.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitfield.h>
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include "cpufreq-dt.h"
+
+struct airoha_cpufreq_priv {
+	int opp_token;
+	struct dev_pm_domain_list *pd_list;
+	struct platform_device *cpufreq_dt;
+};
+
+static struct platform_device *cpufreq_pdev;
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
+static const char * const airoha_cpufreq_clk_names[] = { "cpu", NULL };
+static const char * const airoha_cpufreq_pd_names[] = { "perf" };
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
+	/* Set OPP table conf with NOP config_clks */
+	priv->opp_token = dev_pm_opp_set_config(cpu_dev, &config);
+	if (priv->opp_token < 0)
+		return dev_err_probe(dev, priv->opp_token, "Failed to set OPP config\n");
+
+	/* Attach PM for OPP */
+	ret = dev_pm_domain_attach_list(cpu_dev, &attach_data,
+					&priv->pd_list);
+	if (ret)
+		goto clear_opp_config;
+
+	cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(cpufreq_dt);
+	if (ret) {
+		dev_err(dev, "failed to create cpufreq-dt device: %d\n", ret);
+		goto detach_pm;
+	}
+
+	priv->cpufreq_dt = cpufreq_dt;
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+detach_pm:
+	dev_pm_domain_detach_list(priv->pd_list);
+clear_opp_config:
+	dev_pm_opp_clear_config(priv->opp_token);
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
+}
+
+static struct platform_driver airoha_cpufreq_driver = {
+	.probe = airoha_cpufreq_probe,
+	.remove = airoha_cpufreq_remove,
+	.driver = {
+		.name = "airoha-cpufreq",
+	},
+};
+
+static const struct of_device_id airoha_cpufreq_match_list[] __initconst = {
+	{ .compatible = "airoha,en7581" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, airoha_cpufreq_match_list);
+
+static int __init airoha_cpufreq_init(void)
+{
+	struct device_node *np = of_find_node_by_path("/");
+	const struct of_device_id *match;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	match = of_match_node(airoha_cpufreq_match_list, np);
+	of_node_put(np);
+	if (!match)
+		return -ENODEV;
+
+	ret = platform_driver_register(&airoha_cpufreq_driver);
+	if (unlikely(ret < 0))
+		return ret;
+
+	cpufreq_pdev = platform_device_register_data(NULL, "airoha-cpufreq",
+						     -1, match, sizeof(*match));
+	ret = PTR_ERR_OR_ZERO(cpufreq_pdev);
+	if (ret)
+		platform_driver_unregister(&airoha_cpufreq_driver);
+
+	return ret;
+}
+module_init(airoha_cpufreq_init);
+
+static void __exit airoha_cpufreq_exit(void)
+{
+	platform_device_unregister(cpufreq_pdev);
+	platform_driver_unregister(&airoha_cpufreq_driver);
+}
+module_exit(airoha_cpufreq_exit);
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


