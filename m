Return-Path: <linux-pm+bounces-25806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3632A9554C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 19:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9175B188DE73
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 17:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A161E411C;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiFPa4QF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9EC1DE8B6;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745256839; cv=none; b=Enmb730jdVvm5NeToOGjBR962rNAB1lkkSu+zXVJUZ1npgWjpc6Bngw5BiGS916olk1DWhKJRgAiXHPyKgVQZg3hjf+vblSDq6H90CcaNSRC6hawK1XqoqJLn7zSnduZD4JTp/cJxEwJJGMDnjgakNFrr/7lDCi/m0vOLpVQ0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745256839; c=relaxed/simple;
	bh=MS/k+Ac6wPR5MqzXEad/tDvZpthxXQ3F4JdDJuN1wzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJZtb5bBApBIwaBxtG/KEt6sAFP60vtbFJK33H4C38ZjMcBwUM+G660XJ/f25da+dE6jD97duUXrS2Muoh1ej+8q1Wl2Veo876UJ9qick7wouP1SvVovPPkQsWGaGbc8LVUHcR5/Gth8iGsIQkfDNDvkNg3XhwxnPp8/d//OIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiFPa4QF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E9F7C4CEEC;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745256839;
	bh=MS/k+Ac6wPR5MqzXEad/tDvZpthxXQ3F4JdDJuN1wzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BiFPa4QFv1C3PjoIrXKipJNJeUnszXWK91TYJyKiMgaWsI85Rh+D8yDtY8f4zQ34I
	 h9AsEJAG6CrbCjKbMUJ+NZhZaJcu8dBLMoRbwkpIjd1eksElVgRuOUXqsCW84uhBDW
	 LBKbSseQCfgNLNYgPnxLjRAVKyzzHG29jYCJ8+Hbi0/1QXuoSI9NLiN8fgj5Uu8vsV
	 PCPoqeuVs4lgWmn3e+n/xYqfx0m1q3elT3V1YRMQnIZIkBdRi0yYKkKoDOAuxx3IZ+
	 iI0HwVUC4GhWIuuS7g9+X8pIQNZg2Sd9VciBr24v3OaUDw/xK6alQVa8g457PRgRQ3
	 dUOr/kGRF3Z6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1D3C369D7;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 21 Apr 2025 12:33:54 -0500
Subject: [PATCH v3 2/2] cpufreq: tegra124: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-tegra124-cpufreq-v3-2-95eaba968467@gmail.com>
References: <20250421-tegra124-cpufreq-v3-0-95eaba968467@gmail.com>
In-Reply-To: <20250421-tegra124-cpufreq-v3-0-95eaba968467@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745256838; l=3719;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=D+kPWHn1qUpp0y6NQcTSF4Kd8P3v3+DDEwXwGP2fPj0=;
 b=sVGuqfppBYiBhvFOlQq305mwF1Ea9z/lFiRV5QQJi0POv22yD251Lgb4iTPOxoul1LuCmKVRd
 YL2/+QMOcmEDCCCmLtVnYw3EM3lvfawlUG4XwoR9Y74cVWYvmc1IFZi
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This requires three changes:
* A soft dependency on cpufreq-dt as this driver only handles power
  management and cpufreq-dt does the real operations
* Adding a remove routine to remove the cpufreq-dt device
* Adding a exit routine to handle cleaning up the driver

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/Kconfig.arm        |  2 +-
 drivers/cpufreq/tegra124-cpufreq.c | 41 ++++++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4f9cb943d945c244eb2b29f543d14df6cac4e5d4..625f6fbdaaf5fd774e3b0bb996eb7ce980da41ee 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -238,7 +238,7 @@ config ARM_TEGRA20_CPUFREQ
 	  This adds the CPUFreq driver support for Tegra20/30 SOCs.
 
 config ARM_TEGRA124_CPUFREQ
-	bool "Tegra124 CPUFreq support"
+	tristate "Tegra124 CPUFreq support"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on CPUFREQ_DT
 	default y
diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index bc0691e8971f9454def37f489e4a3e244100b9f4..b1de59a6bd5009981f4739456e08f5b110f1540f 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -16,6 +16,8 @@
 #include <linux/pm_opp.h>
 #include <linux/types.h>
 
+static struct platform_device *platform_device;
+
 struct tegra124_cpufreq_priv {
 	struct clk *cpu_clk;
 	struct clk *pllp_clk;
@@ -176,6 +178,16 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
 	return err;
 }
 
+static void tegra124_cpufreq_remove(struct platform_device *pdev)
+{
+	struct tegra124_cpufreq_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	if (!IS_ERR(priv->cpufreq_dt_pdev)) {
+		platform_device_unregister(priv->cpufreq_dt_pdev);
+		priv->cpufreq_dt_pdev = ERR_PTR(-ENODEV);
+	}
+}
+
 static const struct dev_pm_ops tegra124_cpufreq_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tegra124_cpufreq_suspend,
 				tegra124_cpufreq_resume)
@@ -185,12 +197,12 @@ static struct platform_driver tegra124_cpufreq_platdrv = {
 	.driver.name	= "cpufreq-tegra124",
 	.driver.pm	= &tegra124_cpufreq_pm_ops,
 	.probe		= tegra124_cpufreq_probe,
+	.remove		= tegra124_cpufreq_remove,
 };
 
 static int __init tegra_cpufreq_init(void)
 {
 	int ret;
-	struct platform_device *pdev;
 
 	if (!(of_machine_is_compatible("nvidia,tegra124") ||
 		of_machine_is_compatible("nvidia,tegra210")))
@@ -204,15 +216,36 @@ static int __init tegra_cpufreq_init(void)
 	if (ret)
 		return ret;
 
-	pdev = platform_device_register_simple("cpufreq-tegra124", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
+	platform_device = platform_device_register_simple("cpufreq-tegra124", -1, NULL, 0);
+	if (IS_ERR(platform_device)) {
 		platform_driver_unregister(&tegra124_cpufreq_platdrv);
-		return PTR_ERR(pdev);
+		return PTR_ERR(platform_device);
 	}
 
 	return 0;
 }
 module_init(tegra_cpufreq_init);
 
+static void __exit tegra_cpufreq_module_exit(void)
+{
+	struct tegra124_cpufreq_priv *priv;
+
+	if (platform_device && !IS_ERR(platform_device)) {
+		priv = dev_get_drvdata(&platform_device->dev);
+
+		clk_put(priv->pllp_clk);
+		clk_put(priv->pllx_clk);
+		clk_put(priv->dfll_clk);
+		clk_put(priv->cpu_clk);
+
+		platform_device_unregister(platform_device);
+	}
+
+	platform_driver_unregister(&tegra124_cpufreq_platdrv);
+}
+module_exit(tegra_cpufreq_module_exit);
+
+MODULE_SOFTDEP("pre: cpufreq-dt");
 MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen@nvidia.com>");
 MODULE_DESCRIPTION("cpufreq driver for NVIDIA Tegra124");
+MODULE_LICENSE("GPL");

-- 
2.48.1



