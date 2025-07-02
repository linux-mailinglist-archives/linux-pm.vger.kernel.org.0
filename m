Return-Path: <linux-pm+bounces-29961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96111AF0CE4
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 09:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744063BE648
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EA6233151;
	Wed,  2 Jul 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWPG3TAM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6823182D;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442409; cv=none; b=p/sv586Fo+wX+TrmIsHYxprLdwDH7qvZw7Ey6OlFd/EY7SsiziTYunKmxP5FfsFtN+J3yY/onmB172lUjHn7/4+BBKeKTygZSr7nlx/9p3gEk5ZD0HTkMmmPByTNzcvHA/2Fac/sFe6iNrIkk8W08tATTbh0niGyzUAnXJhT2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442409; c=relaxed/simple;
	bh=CCT5ACpN4bOrIoFhtMjKzW9kbni6iu0szWJHP/pcWaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNKK0XtsbxTSEOhr9sg9Wx4hdW8CCDGsl41bEiLrBpjnYdS2Qar0ct2m98NQOHOdvKutW9cfaXn39W3nbeSe0y1apaTfrL4ccMFwkyGn5B09buLoabIObMApnMt/ouyzUdQZMDClBkswGK8JEcPkQDOieITbj94GGRGH7Xv+8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWPG3TAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AA66C4CEF2;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751442408;
	bh=CCT5ACpN4bOrIoFhtMjKzW9kbni6iu0szWJHP/pcWaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rWPG3TAMeXfN1DWpY9KU50ZAXL8Xeby4SVD94ze5D7xXGI/eqNHSPFKjAx8AHKAgD
	 xM+RWN2zrqSGponOWrVZj7izjQ1ZqmCJINPmxLjsSKJnLj3ceUCHnXs2w+uY0gKCWQ
	 eCkQN3UcvWCwgt+GJ5rSmN9d5d0lk3qfdoYPWFTppSnVIqZLfasnAX1lKksaONGnXZ
	 QBXQPAJM7nMWrNhJhNbo+QaJKnTsRlXu8D5h7thoyY1JOK7fQnRhYjiCRhCIfYIWWE
	 2UhEh1QrFsdQUJUNXuPOf3cKnE1QmSUlzzmBvB1T8Xk742ooh0pvnFPuW7LKdT+e7T
	 V62dcEnHFv3Zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3B5C8303F;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 02 Jul 2025 02:46:26 -0500
Subject: [PATCH v5 3/3] cpufreq: tegra124: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-tegra124-cpufreq-v5-3-66ab3640a570@gmail.com>
References: <20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com>
In-Reply-To: <20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751442407; l=4356;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=9YZ0nqGE5aiW/b0NHl7GJtHyqEJaSop9yzdt0kviJuE=;
 b=jgSpInoztgv7fEM71kFrbW8fbsIyKN/iuw2frQLeJN0xB3/tYBdYcyPpz1yQ58NIcGyWlMjYm
 JXdU31Ah099ClQZBb8E69C1pv0Kvd8mS/QiXbcZP3VrgX0UkVeYmxv3
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This requires three changes:
* Using the cpufreq-dt register helper to establish a hard dependency
  for depmod to track
* Adding a remove routine to remove the cpufreq-dt device
* Adding a exit routine to handle cleaning up the driver

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
index 514146d98bca2d8aa59980a14dff3487cd8045f6..ebce62be9a9c17724d50dadeea1bb2ec81538421 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -16,6 +16,10 @@
 #include <linux/pm_opp.h>
 #include <linux/types.h>
 
+#include "cpufreq-dt.h"
+
+static struct platform_device *platform_device;
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
 MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen@nvidia.com>");
 MODULE_DESCRIPTION("cpufreq driver for NVIDIA Tegra124");
+MODULE_LICENSE("GPL");

-- 
2.50.0



