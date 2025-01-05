Return-Path: <linux-pm+bounces-19965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75433A019BB
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEA9162885
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 14:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B646154C0C;
	Sun,  5 Jan 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTw9kW1A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C07143C40;
	Sun,  5 Jan 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736087243; cv=none; b=JLuQ1GGWQ92kJxfC3v2RsQuVR0STgHt9FKeEbIPCFYslMd4zGHFl5ruD8vns9vJQ4qsQlx8hel/KpDcWQH6CT4e8A9/tDOrozDklDNGH2r9QfBq1f7yc7vLFHrHUWaeb4LXHi7EM2L6mg7u79i4JCVCaNBrQl4sN5S23KMUKY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736087243; c=relaxed/simple;
	bh=ZoMjs5DAVSEUM4aXZoP5QL1XQrxcQrOmBY3ytHVShpw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ohn10BO8M6Ygq9V0oqL8MVMto4DpCBibBtlRvKHR9GGlswil5dx4jxkjG9ocUScaqDBD+dJ6h3/M0fib13W4Mk9k4unmXCz1/D+RMaKZWcEmw+8UKof++goMw7+utHXf5zU2NsKP3zVlXpH7jpldclsrapRQ00ia+eMBY+TuWD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTw9kW1A; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43618283d48so98071755e9.1;
        Sun, 05 Jan 2025 06:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736087237; x=1736692037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c1Z478PFccNSln7dWMuQv7DfZOcfEI4cNLlL4tJQu2w=;
        b=YTw9kW1A3kPTsXlstk2myftEfixJI6TmTIDo4C+lUE57qmTPsU9MllTLAslrNrnLFz
         5XFoRJxUlw0d1eJRe/Aq+1MfkBJ2WmLko5NGTg7izdccXKv+8qL4juj4D3U+p10xTcaW
         85trz3iKXejdnZeMq221pBUs+kRjdnJ00vABjHR2o0nbuMSIVvlrkT1DNvGt6e6mps21
         dsIwfJd1TstU3PUSwufcMS+f1s8Jdla+lBKKNwDihzN9I+83UQxCYvzQ4+wSTnJ3b+Bf
         1wWAj/hgBY+DcGyPt2Z6DGA8DCJNhkyhbSAIcv9BPDeuQ4dvMgaBLNRq4OSp40WBpUFb
         EjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736087237; x=1736692037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1Z478PFccNSln7dWMuQv7DfZOcfEI4cNLlL4tJQu2w=;
        b=jSYWXLns+Tqq0uJz2JL8WKuXvECY7+w6WrCjQeR95YwqGpl1Vhe3imQk3u7/d12fOo
         /Mvt+sJtqyoO+J/NKGWsw7fHlmQsqSs1EHfst4DOh7AQ3TZf7qW3MDVCfJqwV5OQHKdr
         2sXOHqndml3H5eVF840vRj+TcoYSHbjSzO+TxpqTi3uBCq0Zqz7rdAkykDpXFzMjR4AZ
         hTzT7I3ZMPlF0kD4KPpPTohbSNyAeqGiz8MYG/oI0v8FO5kKrlZcGka/t4MViaNmO047
         Uh2AyqdTPy3arjHi24N+sDmIJVHoXpApaqLiF9rWPrLzdKul4oE4MRWQZToIxAI1aPvy
         lKbw==
X-Forwarded-Encrypted: i=1; AJvYcCW1o9zENjRk6zZfpWam2vy04XQNByNkSg8bNKBwYivnvIRGfmAsKdTnwmKij0GTLguYq9rKyv10ptzoBT0=@vger.kernel.org, AJvYcCXaKiT2xCXiz31HZsvtFOfCBE5/RG441YjMPJkFSCPdCff6hbs+bfb+e8APveU1l1Gw1dsES5aqTn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWU0/d5jFK+wkONkBbBf6B16nqjaBGjzeif7qRmoMUxMU+Jlw0
	KM+pkbWxXmjl34owQhh09+qfCHXxo+hEalvd+zCuvCl1AbrjCLcH
X-Gm-Gg: ASbGncvGvZ4mPqAiH2RaUK9jR4bm+MpIA8KNSGNcP+vTpf1qImwLAWPzAGYFM3waO1S
	nS1HJBL9Nysu1HkPQCTWDVw3O14VB0ZJWahzv4enuuZQhNoFBNrsuQv2/W2OfBB4EHqMrcx5xP7
	5aL3pc6uf77oGtjoPLlZm1e9MTZAE+WtaZR9sMMIEeAjlkA2+mx+UtVWdZ4ZpEgwkK8oYSIJspR
	uC4UAUeYu89V55QBgZGFw/JVJsCY2D+xR2Zi2q77k4KdFf4kBi4X43mg127UZAFJfRlacsLIjTd
	BZ7JNdbZojJsiLlBvz/o2J6Dj0y8kpHAJnPq5xRt+g==
X-Google-Smtp-Source: AGHT+IH3TVvLO6Boo/d3hFJnZXriXGGLDYi9SEG0+9a0+qMMbDXLIu9FNeyFJd/B1BVWtRAPfZfTiA==
X-Received: by 2002:a05:6000:186e:b0:386:378c:b7ec with SMTP id ffacd0b85a97d-38a22405d3emr48026648f8f.58.1736087236583;
        Sun, 05 Jan 2025 06:27:16 -0800 (PST)
Received: from localhost.localdomain (host-95-246-253-26.retail.telecomitalia.it. [95.246.253.26])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a1c846ca4sm46438420f8f.43.2025.01.05.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 06:27:15 -0800 (PST)
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
Subject: [PATCH v9 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
Date: Sun,  5 Jan 2025 15:26:03 +0100
Message-ID: <20250105142645.20128-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha CPU PM Domain support to control frequency and power of CPU
present on Airoha EN7581 SoC.

Frequency and power can be controlled with the use of the SMC command by
passing the performance state. The driver also expose a read-only clock
that expose the current CPU frequency with SMC command.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v9:
- Fix compile error targetting wrong branch (remove_new change)
Changes v8:
- Add this patch
- Use SMC invoke instead of 1.2

 drivers/pmdomain/mediatek/Kconfig             |  11 ++
 drivers/pmdomain/mediatek/Makefile            |   1 +
 .../pmdomain/mediatek/airoha-cpu-pmdomain.c   | 144 ++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c

diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediatek/Kconfig
index 21305c4f17fe..049e599a5b57 100644
--- a/drivers/pmdomain/mediatek/Kconfig
+++ b/drivers/pmdomain/mediatek/Kconfig
@@ -26,4 +26,15 @@ config MTK_SCPSYS_PM_DOMAINS
 	  Control Processor System (SCPSYS) has several power management related
 	  tasks in the system.
 
+config AIROHA_CPU_PM_DOMAIN
+	tristate "Airoha CPU power domain"
+	default ARCH_AIROHA
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y here to enable CPU power domain support for Airoha SoC.
+
+	  CPU frequency and power is controlled by ATF with SMC command to
+	  set performance states.
+
 endmenu
diff --git a/drivers/pmdomain/mediatek/Makefile b/drivers/pmdomain/mediatek/Makefile
index 8cde09e654b3..0f6edce9239b 100644
--- a/drivers/pmdomain/mediatek/Makefile
+++ b/drivers/pmdomain/mediatek/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_MTK_SCPSYS)		+= mtk-scpsys.o
 obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) 	+= mtk-pm-domains.o
+obj-$(CONFIG_AIROHA_CPU_PM_DOMAIN) 	+= airoha-cpu-pmdomain.o
diff --git a/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c b/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
new file mode 100644
index 000000000000..0fd88d2f9ac2
--- /dev/null
+++ b/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+
+#define AIROHA_SIP_AVS_HANDLE			0x82000301
+#define AIROHA_AVS_OP_BASE			0xddddddd0
+#define AIROHA_AVS_OP_MASK			GENMASK(1, 0)
+#define AIROHA_AVS_OP_FREQ_DYN_ADJ		(AIROHA_AVS_OP_BASE | \
+						 FIELD_PREP(AIROHA_AVS_OP_MASK, 0x1))
+#define AIROHA_AVS_OP_GET_FREQ			(AIROHA_AVS_OP_BASE | \
+						 FIELD_PREP(AIROHA_AVS_OP_MASK, 0x2))
+
+struct airoha_cpu_pmdomain_priv {
+	struct clk_hw hw;
+	struct generic_pm_domain pd;
+};
+
+static long airoha_cpu_pmdomain_clk_round(struct clk_hw *hw, unsigned long rate,
+					  unsigned long *parent_rate)
+{
+	return rate;
+}
+
+static unsigned long airoha_cpu_pmdomain_clk_get(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_GET_FREQ,
+			     0, 0, 0, 0, 0, 0, &res);
+
+	/* SMCCC returns freq in MHz */
+	return (int)(res.a0 * 1000 * 1000);
+}
+
+/* Airoha CPU clk SMCC is always enabled */
+static int airoha_cpu_pmdomain_clk_is_enabled(struct clk_hw *hw)
+{
+	return true;
+}
+
+static const struct clk_ops airoha_cpu_pmdomain_clk_ops = {
+	.recalc_rate = airoha_cpu_pmdomain_clk_get,
+	.is_enabled = airoha_cpu_pmdomain_clk_is_enabled,
+	.round_rate = airoha_cpu_pmdomain_clk_round,
+};
+
+static int airoha_cpu_pmdomain_set_performance_state(struct generic_pm_domain *domain,
+						     unsigned int state)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(AIROHA_SIP_AVS_HANDLE, AIROHA_AVS_OP_FREQ_DYN_ADJ,
+			     0, state, 0, 0, 0, 0, &res);
+
+	/* SMC signal correct apply by unsetting BIT 0 */
+	return res.a0 & BIT(0) ? -EINVAL : 0;
+}
+
+static int airoha_cpu_pmdomain_probe(struct platform_device *pdev)
+{
+	struct airoha_cpu_pmdomain_priv *priv;
+	struct device *dev = &pdev->dev;
+	const struct clk_init_data init = {
+		.name = "cpu",
+		.ops = &airoha_cpu_pmdomain_clk_ops,
+		/* Clock with no set_rate, can't cache */
+		.flags = CLK_GET_RATE_NOCACHE,
+	};
+	struct generic_pm_domain *pd;
+	int ret;
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
+	/* Init and register a PD for CPU */
+	pd = &priv->pd;
+	pd->name = "cpu_pd";
+	pd->flags = GENPD_FLAG_ALWAYS_ON;
+	pd->set_performance_state = airoha_cpu_pmdomain_set_performance_state;
+
+	ret = pm_genpd_init(pd, NULL, false);
+	if (ret)
+		return ret;
+
+	ret = of_genpd_add_provider_simple(dev->of_node, pd);
+	if (ret)
+		goto err_add_provider;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+err_add_provider:
+	pm_genpd_remove(pd);
+
+	return ret;
+}
+
+static void airoha_cpu_pmdomain_remove(struct platform_device *pdev)
+{
+	struct airoha_cpu_pmdomain_priv *priv = platform_get_drvdata(pdev);
+
+	of_genpd_del_provider(pdev->dev.of_node);
+	pm_genpd_remove(&priv->pd);
+}
+
+static const struct of_device_id airoha_cpu_pmdomain_of_match[] = {
+	{ .compatible = "airoha,en7581-cpufreq" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, airoha_cpu_pmdomain_of_match);
+
+static struct platform_driver airoha_cpu_pmdomain_driver = {
+	.probe = airoha_cpu_pmdomain_probe,
+	.remove = airoha_cpu_pmdomain_remove,
+	.driver = {
+		.name = "airoha-cpu-pmdomain",
+		.of_match_table = airoha_cpu_pmdomain_of_match,
+	},
+};
+module_platform_driver(airoha_cpu_pmdomain_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("CPU PM domain driver for Airoha SoCs");
+MODULE_LICENSE("GPL");
-- 
2.45.2


