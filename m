Return-Path: <linux-pm+bounces-19957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453EEA01637
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2025 19:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22D53A3DBE
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2025 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0B01D47AE;
	Sat,  4 Jan 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHuCsZLp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FE1CEEBB;
	Sat,  4 Jan 2025 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736014419; cv=none; b=c75niljRq2iMbK2IoNWLaznHkXpjuL3vc7qTUq771p1fIjb+U2MkChi9SUz+x729hE7uYPaGi/jysXyWskyy0ewNgRp0rGhwJUKw0LfRz0cZyu2p+Nx6TyFZ4z3qe2FllOW8t+lzeXLL3TYWv1wlBfGA2gO4rxikQF/KwH9BeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736014419; c=relaxed/simple;
	bh=86STLew9OYjgvQAEMohndkUfIZugWpR00NROPl9Bg1U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q28zi3KIhoJG+6YLfH+bUd85/mJAIzUPFJsU7+OEpseRko8zYNOHsB5XhsQk6HegJeLwj0QLDMouqBFvP441kjEGiWFMLprWWmhBugpZSCERkO0v0E+2nOqnbbc9mUY4Qvf6kepIWZipj6vDpIQtActSJHQ2P6AkgynPrDIFmlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHuCsZLp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361815b96cso87139545e9.1;
        Sat, 04 Jan 2025 10:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736014415; x=1736619215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IC3C3Jj0ECPtMGXUDy4JdjvWVRz6QWTlZAY+EqQiUks=;
        b=eHuCsZLpe0HjM3OGMjeYXLR8tpU77nBZ7efo9ZHFX9jSlWP+bZBwmirH/qvNJDqb3Z
         u3X47JZPclhn7fS5lpSgspNOuM6PiLZpa8z5bUwwky84Jbevx6svk8wNnCLTLOEfFgRJ
         VByIrnBgDUEmTxQz6Ib9He4zhaIUS5CmYW5P+PcrFfxRgaiyMk2tgLqBPd0GNSkGkTGu
         KWikc9jjP4uKTfxzDiSuGWdwnCJgkpuOtHd+bNAyoGbzIAF8Y3jVFMfnmU4El/YYnuDp
         +FyMUBCKH4vV9pTc9Hjy3udwaLmdsscxr5uH7Ap64seTFZw7W0l4BXe74HH3eEDFH7lv
         cCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736014415; x=1736619215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IC3C3Jj0ECPtMGXUDy4JdjvWVRz6QWTlZAY+EqQiUks=;
        b=LhnUgAU49ulsotO/ZpIeg21JsL1sh4anOTj7vr/+iS7dCvFUMfXJvEgCbt/HHy3p2D
         hD4GKC3j9eDsjum1cS004bT4ORJyXUimpzS4z7BA/PyjFBPQu4LoSzU4d4hzrjbVKPod
         kjEhyk8UGcuBrju5OI9PSdfcD/bjFamqLkK86zkKT/xEDDugVM9/Mtc31/xKqmSUythg
         1DdPodlVbphrfjJg4S8d6RGs7RccRVdKOePy8wOwCafJs+S1e0DzV7xrYV5tOwXOMv0J
         MEDBB92+pWCJ/3G66+Z2nbq36/z5AnV7T/b9367NF3svePXJ1NytKYhidAtqDe2b2sMC
         QEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVRRlRyh6/injmqJhYIXo1mx2NqnkkKTkygfbSbvCviZhkd6QrfNyk9iTJOyapg3ZLRkBgKF6lF4A=@vger.kernel.org, AJvYcCX8ftYvVuuRAcIjKTRpbNN1v49Jp4I71ovLhmPBjWUqCUqkS8APlXcU163sE/iQ/ihk5js7tBjfdj9OjF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpbglmwZKW0euvFtr8TAXVlSvrw0DQjDrKdcloOPSvy/Kj7J9g
	lZbDsAbqLHiHrei1hFxWLEtdUyWSEJReYjvlayq779WXCSeX+0Iv
X-Gm-Gg: ASbGncsNY8GWLeGbjlYFUT/dRr+iVIu2lquunFe/T/NVoleQT3i9HDA3aBJ2BqHyBLN
	9mmoV8L1hBsXyQu9xSYQP+6S1snfOUksMECLm87enmesCJ4mUWe+3sPKbODiYdTvar+4RfSJu5c
	vwoRCPhsQY6WLyK/Nan2m2aSsfzw2vddancUa/lyONChFNbm1mNZB3loUDCPLCMRdLPmfJBmFIs
	H5I/Ko6bRmo1cdSnFAwTy/4QzQCKzEMl9HIkDAmh0V2+2fD8eYXxC0hg1I2MuLrh5zmVyMudwr3
	SdkT4XDPKwqAcFqggXu8AiEn+Gc+juZzZ5JfUukEXg==
X-Google-Smtp-Source: AGHT+IEVj8J7H0x2CN9xCT2uuvbsbjXurGVCUw1JaW7uQYexZR/wM6uGfcvvWBNsskg0jDWDee4VCQ==
X-Received: by 2002:a05:6000:1785:b0:386:930:fad4 with SMTP id ffacd0b85a97d-38a221fab43mr45454220f8f.19.1736014415317;
        Sat, 04 Jan 2025 10:13:35 -0800 (PST)
Received: from localhost.localdomain (host-95-246-253-26.retail.telecomitalia.it. [95.246.253.26])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4366128a3c9sm520167595e9.40.2025.01.04.10.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 10:13:34 -0800 (PST)
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
Subject: [PATCH v8 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
Date: Sat,  4 Jan 2025 19:12:37 +0100
Message-ID: <20250104181305.28185-1-ansuelsmth@gmail.com>
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
Changes v8:
- Add this patch
- Use SMC invoke instead of 1.2

 drivers/pmdomain/mediatek/Kconfig             |  11 ++
 drivers/pmdomain/mediatek/Makefile            |   1 +
 .../pmdomain/mediatek/airoha-cpu-pmdomain.c   | 145 ++++++++++++++++++
 3 files changed, 157 insertions(+)
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
index 000000000000..a57855459b64
--- /dev/null
+++ b/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
@@ -0,0 +1,145 @@
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
+	struct clk_init_data init = { };
+	struct generic_pm_domain *pd;
+	struct clk_hw *hw;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Init and register a get-only clk for Cpufreq */
+	init.name = "cpu";
+	init.ops = &airoha_cpu_pmdomain_clk_ops;
+	/* Clock with no set_rate, can't cache */
+	init.flags = CLK_GET_RATE_NOCACHE;
+
+	hw = &priv->hw;
+	hw->init = &init;
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
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
+	.remove_new = airoha_cpu_pmdomain_remove,
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


