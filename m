Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932C17CFD4
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfGaVMp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:12:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17135 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfGaVLI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:11:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4203eb0004>; Wed, 31 Jul 2019 14:11:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2019 14:11:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 31 Jul 2019 14:11:06 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:06 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 21:11:06 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.167]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4203e90003>; Wed, 31 Jul 2019 14:11:05 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v7 01/20] pinctrl: tegra: Add suspend and resume support
Date:   Wed, 31 Jul 2019 14:10:44 -0700
Message-ID: <1564607463-28802-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564607467; bh=i0yGaARJzhLfAdYdkF3iw0CpJzNURBZHKur85bMdI2I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=BFAuzPINxrc8hq3bWWpvca8KVwH326SUjvT+ACXjOfTAReQM5dwpL0LEAHa0Gyozv
         PpbzzXlBZs4NpPNnjXK234pvXIkvfZ8gHM/xPaYtqNzOUBFgJQGp0sh7KZY07wARnf
         EsinBF6xr86vviQd9J/Hwy7CgVpxI3uBQxlAXdo953XxvCwASKTIp7gWuHQ6T9/HJg
         mQJ/zQayPDALfy9CkUDgbHEcAlV8TZtVD+nAwKef/U0qGmFdXHjddH6ZUU5QeZ2DeE
         Qw9yYjUvDy8spnImjKCQ2KxDQtBUPMnd9AFYR72mzGdIuR7aL796PtoZk3TZbt6sOQ
         M369ZmNri+Eag==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds support for Tegra pinctrl driver suspend and resume.

During suspend, context of all pinctrl registers are stored and
on resume they are all restored to have all the pinmux and pad
configuration for normal operation.

Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c | 59 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/tegra/pinctrl-tegra.h |  3 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 186ef98e7b2b..e3a237534281 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -631,6 +631,58 @@ static void tegra_pinctrl_clear_parked_bits(struct tegra_pmx *pmx)
 	}
 }
 
+static size_t tegra_pinctrl_get_bank_size(struct device *dev,
+					  unsigned int bank_id)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, bank_id);
+
+	return resource_size(res) / 4;
+}
+
+static int tegra_pinctrl_suspend(struct device *dev)
+{
+	struct tegra_pmx *pmx = dev_get_drvdata(dev);
+	u32 *backup_regs = pmx->backup_regs;
+	u32 *regs;
+	size_t bank_size;
+	unsigned int i, k;
+
+	for (i = 0; i < pmx->nbanks; i++) {
+		bank_size = tegra_pinctrl_get_bank_size(dev, i);
+		regs = pmx->regs[i];
+		for (k = 0; k < bank_size; k++)
+			*backup_regs++ = readl_relaxed(regs++);
+	}
+
+	return pinctrl_force_sleep(pmx->pctl);
+}
+
+static int tegra_pinctrl_resume(struct device *dev)
+{
+	struct tegra_pmx *pmx = dev_get_drvdata(dev);
+	u32 *backup_regs = pmx->backup_regs;
+	u32 *regs;
+	size_t bank_size;
+	unsigned int i, k;
+
+	for (i = 0; i < pmx->nbanks; i++) {
+		bank_size = tegra_pinctrl_get_bank_size(dev, i);
+		regs = pmx->regs[i];
+		for (k = 0; k < bank_size; k++)
+			writel_relaxed(*backup_regs++, regs++);
+	}
+
+	return 0;
+}
+
+const struct dev_pm_ops tegra_pinctrl_pm = {
+	.suspend = &tegra_pinctrl_suspend,
+	.resume = &tegra_pinctrl_resume
+};
+
 static bool gpio_node_has_range(const char *compatible)
 {
 	struct device_node *np;
@@ -655,6 +707,7 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 	int i;
 	const char **group_pins;
 	int fn, gn, gfn;
+	unsigned long backup_regs_size = 0;
 
 	pmx = devm_kzalloc(&pdev->dev, sizeof(*pmx), GFP_KERNEL);
 	if (!pmx)
@@ -707,6 +760,7 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
 		if (!res)
 			break;
+		backup_regs_size += resource_size(res);
 	}
 	pmx->nbanks = i;
 
@@ -715,6 +769,11 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 	if (!pmx->regs)
 		return -ENOMEM;
 
+	pmx->backup_regs = devm_kzalloc(&pdev->dev, backup_regs_size,
+					GFP_KERNEL);
+	if (!pmx->backup_regs)
+		return -ENOMEM;
+
 	for (i = 0; i < pmx->nbanks; i++) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
 		pmx->regs[i] = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.h b/drivers/pinctrl/tegra/pinctrl-tegra.h
index 105309774079..0fc82eea9cf1 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.h
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.h
@@ -17,6 +17,7 @@ struct tegra_pmx {
 
 	int nbanks;
 	void __iomem **regs;
+	u32 *backup_regs;
 };
 
 enum tegra_pinconf_param {
@@ -193,6 +194,8 @@ struct tegra_pinctrl_soc_data {
 	bool drvtype_in_mux;
 };
 
+extern const struct dev_pm_ops tegra_pinctrl_pm;
+
 int tegra_pinctrl_probe(struct platform_device *pdev,
 			const struct tegra_pinctrl_soc_data *soc_data);
 #endif
-- 
2.7.4

