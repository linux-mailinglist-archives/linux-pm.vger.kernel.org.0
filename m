Return-Path: <linux-pm+bounces-26909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D0FAB06EF
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 02:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4C69E3ED3
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 00:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF001FDA;
	Fri,  9 May 2025 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO6vYxph"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BAC15D1;
	Fri,  9 May 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746749058; cv=none; b=LRQPzxzSZNA51+7rDc76H7ud9/jsu+oj1n0JFlY+lT+J32w2gsg2ILplmED+Tgh1OQCPhRPGAgooWIUQcGhU2DzilseYPeEts35l+70CPZzY+vgxZfEN1oiAC8eRAmBcRSA4Yay4PAGCTrGCE6OuA+GYqyQw3fu2XI/VMmm66wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746749058; c=relaxed/simple;
	bh=r5zkEwxjoL0+NNxOaNBoLCbgtG/F6X1uA1eX8tm2Wuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tl2OqVpER4bmTGJsJe/Y9oeHtPzvv8gYbrk6rhUumAP2ErodJTM4nGmzoX5FdqP11V1APRjsemv0OTTHtZtk0KToprBUngGnfyOR95qGhZvGgvnEQTzSsFzEow9GgQZF9FZ3wruH6lvFrTxvjgJzBRX+NDfFJ9BLoeqaQ+bcDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO6vYxph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CD37C4CEED;
	Fri,  9 May 2025 00:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746749057;
	bh=r5zkEwxjoL0+NNxOaNBoLCbgtG/F6X1uA1eX8tm2Wuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nO6vYxphKItDtZdp45eL7yOnSHXYL0Txrgedo4Naak3mltli+LQbDJvSne6vX4ayO
	 7XYlB+KufPjYgBkpYjNaM/OArS3jEi/RT5o5SEB242eK2GTDkahSh+52g8kokysGP9
	 NyLvuvK5qiQPsDiMTxBn8tG/ibAF7LMhR2MjLTTxmBDJmpKWKdBmyMBLTviTmE3zjw
	 z2mZHUhy60yaDeRvsDzpJ9iEQ8FPOM7oCp87vQ9bmoU2iRC31RwdSAZ10rX9a8TEP7
	 SkYIigfHXVsPp04Yrefylyg51KTNtk3LP7qgNOZJfFyeeDch9bbB4PU8dIw+IscEoG
	 f/iG+Um2oOn/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E01DC3ABC5;
	Fri,  9 May 2025 00:04:17 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 08 May 2025 19:04:15 -0500
Subject: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
In-Reply-To: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746749056; l=3610;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=/ta4TLDuSTaVozvCsRbtscGiPJkWXh8Tz02WJdfc8qs=;
 b=w9Upaw1g3ZCYqAGCiiekKKHNFRo6mO/2oiym5DOronvn7ESk6T10EaSCidYnzRK2ER1lNuxcW
 Q0ZXEYTe8o5B0BqreTb8rEv0TEDdHAaesa+E8xSMqPTksSXl40WH0rn
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
 drivers/cpufreq/tegra124-cpufreq.c | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)

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
index bc0691e8971f9454def37f489e4a3e244100b9f4..b6059c91f2474c56809c403eca94eacf51df734f 100644
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
@@ -176,6 +178,21 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
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
@@ -185,12 +202,12 @@ static struct platform_driver tegra124_cpufreq_platdrv = {
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
@@ -204,15 +221,26 @@ static int __init tegra_cpufreq_init(void)
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
+	if (platform_device && !IS_ERR(platform_device))
+		platform_device_unregister(platform_device);
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



