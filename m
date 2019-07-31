Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 762797CFB9
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfGaVMM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:12:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9198 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfGaVLK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:11:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4203f50002>; Wed, 31 Jul 2019 14:11:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2019 14:11:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 31 Jul 2019 14:11:08 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:08 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 21:11:08 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.167]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4203eb000c>; Wed, 31 Jul 2019 14:11:08 -0700
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
Subject: [PATCH v7 11/20] cpufreq: tegra124: Add suspend and resume support
Date:   Wed, 31 Jul 2019 14:10:54 -0700
Message-ID: <1564607463-28802-12-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564607477; bh=DlH5zne7afUgvFVw41nMXdKzqNL2H6Ti9hK3hgmeweE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=TpXfYas1/NZmHok+0jyolcmYnCO/Np11LlxeZJGrjzymjbFR50F1o17o/IaszP5Jq
         fMm08KqsGMkoA4ZYs0wv758n3eilTy8eXjo5FWHu8ZPzUwQ5iMHWV69nffZ2j+bqXX
         xSZ6sc4VXFfx1ViZ7keuMafx1QJzFhYCDRAcLBnqAfI93tY+vTZC2VGChsl90pDzl0
         q7VXeU3jTdAH/ud/uv29GXdUJFzBJizEZb3eaFt9pJbP3bboqFFUEqKWfwnLXYWbC+
         7RIzyoJEabNfgk/p9HX80MuXv9wcoNSXkMAMUUQVIDK1gpXhhs75w8ZZ+4WusHCTb8
         kz7LmmARqC0TA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds suspend and resume pm ops for cpufreq driver.

PLLP is the safe clock source for CPU during system suspend and
resume as PLLP rate is below the CPU Fmax at Vmin.

CPUFreq driver suspend switches the CPU clock source to PLLP and
disables the DFLL clock.

During system resume, warmboot code powers up the CPU with PLLP
clock source. So CPUFreq driver resume enabled DFLL clock and
switches CPU back to DFLL clock source.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/cpufreq/tegra124-cpufreq.c | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 4f0c637b3b49..e979a3370988 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
+#include <linux/cpufreq.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -128,8 +129,67 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __maybe_unused tegra124_cpufreq_suspend(struct device *dev)
+{
+	struct tegra124_cpufreq_priv *priv = dev_get_drvdata(dev);
+	int err;
+
+	/*
+	 * PLLP rate 408Mhz is below the CPU Fmax at Vmin and is safe to
+	 * use during suspend and resume. So, switch the CPU clock source
+	 * to PLLP and disable DFLL.
+	 */
+	err = clk_set_parent(priv->cpu_clk, priv->pllp_clk);
+	if (err < 0) {
+		dev_err(dev, "failed to reparent to PLLP: %d\n", err);
+		return err;
+	}
+
+	/* disable DFLL clock */
+	clk_disable_unprepare(priv->dfll_clk);
+
+	return 0;
+}
+
+static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
+{
+	struct tegra124_cpufreq_priv *priv = dev_get_drvdata(dev);
+	int err;
+
+	/*
+	 * Warmboot code powers up the CPU with PLLP clock source.
+	 * Enable DFLL clock and switch CPU clock source back to DFLL.
+	 */
+	err = clk_prepare_enable(priv->dfll_clk);
+	if (err < 0) {
+		dev_err(dev, "failed to enable DFLL clock for CPU: %d\n", err);
+		goto disable_cpufreq;
+	}
+
+	err = clk_set_parent(priv->cpu_clk, priv->dfll_clk);
+	if (err < 0) {
+		dev_err(dev, "failed to reparent to DFLL clock: %d\n", err);
+		goto disable_dfll;
+	}
+
+	return 0;
+
+disable_dfll:
+	clk_disable_unprepare(priv->dfll_clk);
+disable_cpufreq:
+	disable_cpufreq();
+
+	return err;
+}
+
+static const struct dev_pm_ops tegra124_cpufreq_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(tegra124_cpufreq_suspend,
+				tegra124_cpufreq_resume)
+};
+
 static struct platform_driver tegra124_cpufreq_platdrv = {
 	.driver.name	= "cpufreq-tegra124",
+	.driver.pm	= &tegra124_cpufreq_pm_ops,
 	.probe		= tegra124_cpufreq_probe,
 };
 
-- 
2.7.4

