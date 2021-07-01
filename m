Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F303B9920
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhGAXbZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhGAXbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C78AC061764;
        Thu,  1 Jul 2021 16:28:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q4so10751092ljp.13;
        Thu, 01 Jul 2021 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S99qbf+0qvVK4fXlXmOrPbkXxPkxsOQatEqE3v5SvJc=;
        b=QJP6tWMLfddtKrkdVCx8PW8dawqdRJkXi3EV1hr1q6NxdvInVuV/rRir0NehBg5FLd
         e4aqmHQ60sEzFNnu252HTbSYL3uGXih9nObZXnge+x4x+voSnjPgjAB1IAxKYnn7caGI
         hPU4v/4dVwQddlPC4+9auTnU0GUDXuvGQTDjJs9DGng3rExyk8pj0MJe2g3QLIhHE6wE
         az9C3UvPvxXikowZR+MklHS0SUJK8d/r22W4JX+Lt+euGQPLfXRsiRRc3GvSjp7+aJjo
         7uu5jdioLVoO9N55tyCHx9eEnLK77mO5w0sCU0ZfMMpwNmQc/+uz/UAJKlTNdyPiKiE0
         1D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S99qbf+0qvVK4fXlXmOrPbkXxPkxsOQatEqE3v5SvJc=;
        b=BpeD4uRbromwseytZCD6B5QWe6Gzv/t59Z+YlzD58XgFtwvr2cbkXa0vRIBmqEMoM8
         VCCXrD/rcRHR0LJdu8Kfr7p9NbIpsDetC31uOnMr90/hFb4xuQ/dfgeaWfzIwrJY08Nv
         i7DMmBhJj5YDFaZCAnV/hkftSzORirRyPsUjWj/qoRNQQzf4GL/6r1H0cg3Lrusvx/Hp
         BPLt9acfry0TCChY5BAIdk7iBFtHja0jCSL7q1cTRKg5K9GeXy0C+k//Tr89VqkiRlTF
         sMFFwkDZ58rAd5X4VSfrLwm2Jx+Y5qeUACuBkNcjqZ0NyROkofqSW9ljTeUQtB0Aubx4
         ShPQ==
X-Gm-Message-State: AOAM533Dh28+k5ml2xAJ1mZtTJp6IjCHFm576lgYKt8KwW0ylTx7UiUm
        6voqkMolDG1/hSKceg5j+zg=
X-Google-Smtp-Source: ABdhPJy+o9hNGPTPN2Bx4y/Uwc9fOsw0namwjnBE2eo+CJJS/3WpYP0KbjtbZDm9vFoGGOXvh9P1Qw==
X-Received: by 2002:a2e:921a:: with SMTP id k26mr1525110ljg.252.1625182120848;
        Thu, 01 Jul 2021 16:28:40 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 18/37] bus: tegra-gmi: Add runtime PM support
Date:   Fri,  2 Jul 2021 02:27:09 +0300
Message-Id: <20210701232728.23591-19-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The GMI bus on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now GMI must be resumed using
runtime PM API in order to initialize the GMI power state. Add runtime PM
support to the GMI driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/bus/tegra-gmi.c | 44 +++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/tegra-gmi.c b/drivers/bus/tegra-gmi.c
index a6570789f7af..c3ff84e05de9 100644
--- a/drivers/bus/tegra-gmi.c
+++ b/drivers/bus/tegra-gmi.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #define TEGRA_GMI_CONFIG		0x00
@@ -54,9 +55,10 @@ static int tegra_gmi_enable(struct tegra_gmi *gmi)
 {
 	int err;
 
-	err = clk_prepare_enable(gmi->clk);
-	if (err < 0) {
-		dev_err(gmi->dev, "failed to enable clock: %d\n", err);
+	pm_runtime_enable(gmi->dev);
+	err = pm_runtime_resume_and_get(gmi->dev);
+	if (err) {
+		pm_runtime_disable(gmi->dev);
 		return err;
 	}
 
@@ -83,7 +85,9 @@ static void tegra_gmi_disable(struct tegra_gmi *gmi)
 	writel(config, gmi->base + TEGRA_GMI_CONFIG);
 
 	reset_control_assert(gmi->rst);
-	clk_disable_unprepare(gmi->clk);
+
+	pm_runtime_put(gmi->dev);
+	pm_runtime_disable(gmi->dev);
 }
 
 static int tegra_gmi_parse_dt(struct tegra_gmi *gmi)
@@ -213,6 +217,7 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 	if (!gmi)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, gmi);
 	gmi->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -247,8 +252,6 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, gmi);
-
 	return 0;
 }
 
@@ -262,6 +265,34 @@ static int tegra_gmi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused tegra_gmi_runtime_resume(struct device *dev)
+{
+	struct tegra_gmi *gmi = dev_get_drvdata(dev);
+	int err;
+
+	err = clk_prepare_enable(gmi->clk);
+	if (err < 0) {
+		dev_err(gmi->dev, "failed to enable clock: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_gmi_runtime_suspend(struct device *dev)
+{
+	struct tegra_gmi *gmi = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(gmi->clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tegra_gmi_pm = {
+	SET_RUNTIME_PM_OPS(tegra_gmi_runtime_suspend, tegra_gmi_runtime_resume,
+			   NULL)
+};
+
 static const struct of_device_id tegra_gmi_id_table[] = {
 	{ .compatible = "nvidia,tegra20-gmi", },
 	{ .compatible = "nvidia,tegra30-gmi", },
@@ -275,6 +306,7 @@ static struct platform_driver tegra_gmi_driver = {
 	.driver = {
 		.name		= "tegra-gmi",
 		.of_match_table	= tegra_gmi_id_table,
+		.pm = &tegra_gmi_pm,
 	},
 };
 module_platform_driver(tegra_gmi_driver);
-- 
2.30.2

