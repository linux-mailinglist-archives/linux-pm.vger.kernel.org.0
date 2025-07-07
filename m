Return-Path: <linux-pm+bounces-30317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4453DAFBD53
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 23:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8453D188CFB1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295C287272;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPmtZGiU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56BD286D7F;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923040; cv=none; b=CApgXc4GqEXo5VFyHes0vy4+uX8jQMYe97c0q4j2y25jm7o0Z4zD3kr393DQ5ltuxLJ5qMztYYyno83LtE23Y06AkHrZHyXErnkbfSqaaVf8fgwA9XDjOCZX8frXxNJOXsAxTvGEtyNb5FRgY38YPXxyIGZ0vf8zasySOMIc/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923040; c=relaxed/simple;
	bh=1stkMTJ1H5HREcQraMTxwxe87w8rCjp9IH3zgVqmKsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fb6tXtd3aqWpGpR3yhD0AxxsEL+noC7F27Q3BVTOXMGH4jHKHkv4ga0GLIQm/Zr27Js0usQJRB97YTn3s1J5Us1Ar+c3dWMOnwsEqJEKcfvBx+sQeYI9+LUJkhqOd4s/nNPofvZHhgRGhLgo1lK/3gYoQBcfZZqKiJiqDQFfijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPmtZGiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C185C4CEF8;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751923040;
	bh=1stkMTJ1H5HREcQraMTxwxe87w8rCjp9IH3zgVqmKsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uPmtZGiUsN/f343+DjjqSWq73PKErgdDg+mvKswVXJOMAIRd9imOR4apQiAK0+Q3m
	 HS+PqrlRjldihVbFzpQmTH3R1HbE42bPZYnPmj44riT/22wbXKA0bmsT0vcdVVk2WB
	 UkCM6kH0aRWOKeBF5s8pQffHE1lKt3VVeSroyHGeD6vdRhJvABvv4dT3j1gYb4uCm1
	 FQG2kds8hoesr9A5zpQ4Lo00dQwxn0y8DfUGthnPrh9vM/kZZMCFw2NJCReooQur7m
	 a54zGeKQEGHQKvbe2PkvjSX4ubIbbhqILtUyIy0sJRQoTcI9/fLG/eUeAwrUjNdUom
	 MnTzk5y5OQfsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3301CC71130;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 07 Jul 2025 16:17:15 -0500
Subject: [PATCH v6 3/3] cpufreq: tegra124: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-tegra124-cpufreq-v6-3-fe69c0f9bbab@gmail.com>
References: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>
In-Reply-To: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751923039; l=4409;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=ZKgE/EyIvhxsmDDP8cQEfrMMLR3Gs2c7Yzk8IoNf/gU=;
 b=6bjn+2RLCediVwC+wZESfmF16dryHZKRdOf6L2BL+5DI01hEAww/CxGJ2zmSC5nchrKLwGGf7
 c3O9fTdC55YDWoelMjR/RaC49B7i6hYwYSYTqspdSy5ncoKwEc9AdaR
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This requires four changes:
* Using the cpufreq-dt register helper to establish a hard dependency
  for depmod to track
* Adding a remove routine to remove the cpufreq-dt device
* Adding a exit routine to handle cleaning up the driver
* Populating module license

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/Kconfig.arm        |  2 +-
 drivers/cpufreq/tegra124-cpufreq.c | 44 +++++++++++++++++++++++++++++---------
 2 files changed, 35 insertions(+), 11 deletions(-)

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
index 514146d98bca2d8aa59980a14dff3487cd8045f6..b8bccde8b298a4920bfe6dc0d4c4a92704ecfcf5 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -16,6 +16,10 @@
 #include <linux/pm_opp.h>
 #include <linux/types.h>
 
+#include "cpufreq-dt.h"
+
+static struct platform_device *tegra124_cpufreq_pdev;
+
 struct tegra124_cpufreq_priv {
 	struct clk *cpu_clk;
 	struct clk *pllp_clk;
@@ -55,7 +59,6 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	struct device_node *np __free(device_node) = of_cpu_device_node_get(0);
 	struct tegra124_cpufreq_priv *priv;
 	struct device *cpu_dev;
-	struct platform_device_info cpufreq_dt_devinfo = {};
 	int ret;
 
 	if (!np)
@@ -95,11 +98,7 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_put_pllp_clk;
 
-	cpufreq_dt_devinfo.name = "cpufreq-dt";
-	cpufreq_dt_devinfo.parent = &pdev->dev;
-
-	priv->cpufreq_dt_pdev =
-		platform_device_register_full(&cpufreq_dt_devinfo);
+	priv->cpufreq_dt_pdev = cpufreq_dt_pdev_register(&pdev->dev);
 	if (IS_ERR(priv->cpufreq_dt_pdev)) {
 		ret = PTR_ERR(priv->cpufreq_dt_pdev);
 		goto out_put_pllp_clk;
@@ -173,6 +172,21 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
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
+
+	clk_put(priv->pllp_clk);
+	clk_put(priv->pllx_clk);
+	clk_put(priv->dfll_clk);
+	clk_put(priv->cpu_clk);
+}
+
 static const struct dev_pm_ops tegra124_cpufreq_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tegra124_cpufreq_suspend,
 				tegra124_cpufreq_resume)
@@ -182,12 +196,12 @@ static struct platform_driver tegra124_cpufreq_platdrv = {
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
@@ -201,15 +215,25 @@ static int __init tegra_cpufreq_init(void)
 	if (ret)
 		return ret;
 
-	pdev = platform_device_register_simple("cpufreq-tegra124", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
+	tegra124_cpufreq_pdev = platform_device_register_simple("cpufreq-tegra124", -1, NULL, 0);
+	if (IS_ERR(tegra124_cpufreq_pdev)) {
 		platform_driver_unregister(&tegra124_cpufreq_platdrv);
-		return PTR_ERR(pdev);
+		return PTR_ERR(tegra124_cpufreq_pdev);
 	}
 
 	return 0;
 }
 module_init(tegra_cpufreq_init);
 
+static void __exit tegra_cpufreq_module_exit(void)
+{
+	if (!IS_ERR_OR_NULL(tegra124_cpufreq_pdev))
+		platform_device_unregister(tegra124_cpufreq_pdev);
+
+	platform_driver_unregister(&tegra124_cpufreq_platdrv);
+}
+module_exit(tegra_cpufreq_module_exit);
+
 MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen@nvidia.com>");
 MODULE_DESCRIPTION("cpufreq driver for NVIDIA Tegra124");
+MODULE_LICENSE("GPL");

-- 
2.50.0



