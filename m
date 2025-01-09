Return-Path: <linux-pm+bounces-20148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8497A076E5
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 14:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B977A3854
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69347218593;
	Thu,  9 Jan 2025 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIi58Qwo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C2217F4A;
	Thu,  9 Jan 2025 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428423; cv=none; b=j1Y6uf7Un03HaadtbNeT+u3rKAqgWzvhkLOWWXu9OLKvAqHajA+SZ8QFaDgBydQP9fAGwktwLo+dT4bCq4JRsOCM8IBHFBvUE/doZyV8HwIhl2pbg6a9Qt3W+MWNDnbXvHFTDEjtqP28owSWmFs/0QTmwCrE+JyxKe4ISwppWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428423; c=relaxed/simple;
	bh=X9fEQu1U/DATwj8d7JTI0Sb2r249lhohoCdKtFyFSMA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IrqAkbshZrS0P+jCBGCfDpeH6CI0yTr81fZsMStF1KqfzEUmf1OKO/FIOA8lDWigGPWAz3H6ioQhrbmREUyFgyMc+70ALLhfwbgW8VU35BHl8Tu9n8gWeQIgV6rkrLqGExOFz9dH2gW9Pxskdg/U9aQBPHGcHBV7KGjiordRmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIi58Qwo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso10296855e9.1;
        Thu, 09 Jan 2025 05:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736428420; x=1737033220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRM5j6Ot4ZAazzuIZoxOMebBYpgaQOV63uO0HmRhKhU=;
        b=PIi58QwonuQdsfZmlzhWdhv9Lez5/UqfVOKk6JGHAQFRpYhXkVgrD6IV4R+Sarv5A4
         uyCjElQ3GwbdacV+P8Zc2mCDLtDHiNBLlhWEj+6DhWJH9Gqy1xZ9b2cnSLkF/9mjFmFq
         yJ0TFLhi+QbFVnzJzEwj5WE+Fu/W182oAkktTzf1/J7RpFQWoFlT7NoQsuzIZhXnXZh/
         hBJO8JooxvOD+djejf2w5WD9yTAmlOb87QjNmhUAo8uDPBYWhe2eKwBBXvQiO/SDo8+3
         YJ/kA1cV9s2kdlOu1tDr5gtc+/tXL1U8yt+AMkKttvIs13gRuZfkJpZza7bxgmNq3vJn
         5Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736428420; x=1737033220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRM5j6Ot4ZAazzuIZoxOMebBYpgaQOV63uO0HmRhKhU=;
        b=t6MA3RqpAAWfIDgEU0Mcl4g0bB9tCtJ1YEBbW+Rcg6jNkH05oodO5yh50YGiNYAww6
         XQzld8/RBg94IQ1U149DQUDxya4Lb5O/qCGHJNecsI4y8YpPeVvnJJkuknv/2HU3QW3j
         JJdcr609GbBg0RvzX9Dr+ERXbkU7x4tGc7O08CydD/mrlG6RhDLDYIUFlzNQKlsglLlK
         fgrbg7psExO6895cTTpnZabUl2XrkNNsLbHusoXMPeMNM/Z3tEy+jVh/CTrRWiGO8+xh
         3U+XHcCLQlZsG1UbBQ6/0nnvkynHuuXiC8h48ihuBZeXKQKNkjxIvMupL0WWHqyLM39H
         9obw==
X-Forwarded-Encrypted: i=1; AJvYcCVHYY09JP2A5Hz/MV/e/wkrTN666cKqGPvxmG9xAZMvO1vJpB3AS/1uDdQ3IWE3oErEsqjrK0ChnoI=@vger.kernel.org, AJvYcCXn5Cf6ekys+L0v4rzmopYPJcCb8IyPpGCQUWiaVxAYqEWrcyBHnM2uJPzAGSi+zil+69ve5igDsRK7SKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMTpQFZCscXpVHCGasKm+HB6Pmm2iMxFUPMavpk1w6JF8JCOf
	NpSHY8UY41ZCqAzb3+/7PKM8iNGVF5sz1a7wN5tap7HOrld+h89w+8QWXg==
X-Gm-Gg: ASbGncud5j6e+95gmhkr/Ij7u0KHF4Pl4q1daZ/dNyS3s5RcgZHqIKInRwC940mLXRh
	8go1EwwP91hQ6qp8veMD6d7vQPnImNwwqf3z4Hp+mFANUidCF6eOEeNDB3wEmoel9H5OaeUtt5T
	TIzAqi4MsR/l3MzM5GIic2lQbIh3vIoWIuq6Mq+YKRGDksjv1+cvN7bwZUR2JQlaObKm9by6MS3
	uh50XuRf/3e6IUFKgd2YZJcncGzaB5AF268UUx9H79q90MDn5k9U97vwzKPr75PHZtrx6MOnoy2
	AfOzwP3+UDRb/CNAq7S6GZZTz4YFH08JPS9LrGpx/g==
X-Google-Smtp-Source: AGHT+IGYsdHXDWGW+Q3wxecp7JvcILTEtygYfayS/lnRgUKCfBKAXrNMj5q72OGDlEgPzx8re1XYdQ==
X-Received: by 2002:a05:600c:5112:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-436e267f77amr60316635e9.2.1736428419286;
        Thu, 09 Jan 2025 05:13:39 -0800 (PST)
Received: from localhost.localdomain (host-95-246-253-26.retail.telecomitalia.it. [95.246.253.26])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e385026sm1812286f8f.42.2025.01.09.05.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:13:38 -0800 (PST)
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
Subject: [PATCH v10 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
Date: Thu,  9 Jan 2025 14:12:57 +0100
Message-ID: <20250109131313.32317-1-ansuelsmth@gmail.com>
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
Changes v10:
- Depends on HAVE_ARM_SMCCC
Changes v9:
- Fix compile error targetting wrong branch (remove_new change)
Changes v8:
- Add this patch
- Use SMC invoke instead of 1.2

 drivers/pmdomain/mediatek/Kconfig             |  12 ++
 drivers/pmdomain/mediatek/Makefile            |   1 +
 .../pmdomain/mediatek/airoha-cpu-pmdomain.c   | 144 ++++++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c

diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediatek/Kconfig
index 21305c4f17fe..0e34a517ab7d 100644
--- a/drivers/pmdomain/mediatek/Kconfig
+++ b/drivers/pmdomain/mediatek/Kconfig
@@ -26,4 +26,16 @@ config MTK_SCPSYS_PM_DOMAINS
 	  Control Processor System (SCPSYS) has several power management related
 	  tasks in the system.
 
+config AIROHA_CPU_PM_DOMAIN
+	tristate "Airoha CPU power domain"
+	default ARCH_AIROHA
+	depends on HAVE_ARM_SMCCC
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


