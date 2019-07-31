Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA48E7CF8A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbfGaVLk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:11:40 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9201 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfGaVLL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:11:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4203f50001>; Wed, 31 Jul 2019 14:11:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2019 14:11:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 31 Jul 2019 14:11:08 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:08 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 21:11:08 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.167]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4203eb0009>; Wed, 31 Jul 2019 14:11:07 -0700
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
Subject: [PATCH v7 10/20] clk: tegra: clk-dfll: Add suspend and resume support
Date:   Wed, 31 Jul 2019 14:10:53 -0700
Message-ID: <1564607463-28802-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564607477; bh=4G70xSSFBdn+ucK5NYBOMsVuSgfy5Xwx34Mlryu6Q1o=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Fg/b9b9zEK6Pv8eQv26SvC/nR0E+00q/ba6owdHS34Z7ahAFik3goW6LgqEV0JUL/
         E/SE7YBY33DhqySjAY1LW4dQd2je4xitS+/qAc9fbE0mDhcF1pGiL6VpjHmMmtoMUP
         boh0aRe4+afG9/Tuj9nHfchHwsoWLonfOmKk2/bJmKs29jJiirVEkR+L7kKGQhpCGK
         CO0kUXtQ3dzxjRzqz4Oouwgb2ahsMq3lCzyxyFJwDjVPzyw01m7Cn2LX12DCQHSRaE
         x2khlvUcJRgiLahsQGPpUnc9q8wN3mEh3sIEtbxGQyrdMKk60SL0biwdH2L26SobqH
         oUwSVhh3Nnjpg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch implements DFLL suspend and resume operation.

During system suspend entry, CPU clock will switch CPU to safe
clock source of PLLP and disables DFLL clock output.

DFLL driver suspend confirms DFLL disable state and errors out on
being active.

DFLL is re-initialized during the DFLL driver resume as it goes
through complete reset during suspend entry.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-dfll.c               | 56 ++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h               |  2 ++
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c |  1 +
 3 files changed, 59 insertions(+)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index f8688c2ddf1a..9900097ec2aa 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -1513,6 +1513,62 @@ static int dfll_init(struct tegra_dfll *td)
 	return ret;
 }
 
+/**
+ * tegra_dfll_suspend - check DFLL is disabled
+ * @dev: DFLL device *
+ *
+ * DFLL clock should be disabled by the CPUFreq driver. So, make
+ * sure it is disabled and disable all clocks needed by the DFLL.
+ */
+int tegra_dfll_suspend(struct device *dev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(dev);
+
+	if (dfll_is_running(td)) {
+		dev_err(td->dev, "dfll is enabled while shouldn't be\n");
+		return -EBUSY;
+	}
+
+	reset_control_assert(td->dvco_rst);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dfll_suspend);
+
+/**
+ * tegra_dfll_resume - reinitialize DFLL on resume
+ * @dev: DFLL instance
+ *
+ * DFLL is disabled and reset during suspend and resume.
+ * So, reinitialize the DFLL IP block back for use.
+ * DFLL clock is enabled later in closed loop mode by CPUFreq
+ * driver before switching its clock source to DFLL output.
+ */
+int tegra_dfll_resume(struct device *dev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(dev);
+
+	reset_control_deassert(td->dvco_rst);
+
+	pm_runtime_irq_safe(td->dev);
+	pm_runtime_get_sync(td->dev);
+
+	dfll_set_mode(td, DFLL_DISABLED);
+	dfll_set_default_params(td);
+
+	if (td->soc->init_clock_trimmers)
+		td->soc->init_clock_trimmers();
+
+	dfll_set_open_loop_config(td);
+
+	dfll_init_out_if(td);
+
+	pm_runtime_put_sync(td->dev);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dfll_resume);
+
 /*
  * DT data fetch
  */
diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h
index 1b14ebe7268b..fb209eb5f365 100644
--- a/drivers/clk/tegra/clk-dfll.h
+++ b/drivers/clk/tegra/clk-dfll.h
@@ -42,5 +42,7 @@ int tegra_dfll_register(struct platform_device *pdev,
 struct tegra_dfll_soc_data *tegra_dfll_unregister(struct platform_device *pdev);
 int tegra_dfll_runtime_suspend(struct device *dev);
 int tegra_dfll_runtime_resume(struct device *dev);
+int tegra_dfll_suspend(struct device *dev);
+int tegra_dfll_resume(struct device *dev);
 
 #endif /* __DRIVERS_CLK_TEGRA_CLK_DFLL_H */
diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index e84b6d52cbbd..2ac2679d696d 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -631,6 +631,7 @@ static int tegra124_dfll_fcpu_remove(struct platform_device *pdev)
 static const struct dev_pm_ops tegra124_dfll_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_dfll_runtime_suspend,
 			   tegra_dfll_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(tegra_dfll_suspend, tegra_dfll_resume)
 };
 
 static struct platform_driver tegra124_dfll_fcpu_driver = {
-- 
2.7.4

