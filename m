Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A9B3B9929
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhGAXb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhGAXbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2DBC061764;
        Thu,  1 Jul 2021 16:28:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q16so14836197lfr.4;
        Thu, 01 Jul 2021 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4W3ILiVgyd1ED+oBeZTN1Ck++ELFr33lONulkCFhb04=;
        b=FnTE15xANM03LuI8cIUYogLzNgj2xnLMkFA3qN8/CSHWL595dgNu7uee50L1AJw/Yh
         yxx4UHnzdZ33qGzJBQE8xmlUoqVbiDcR9NgNU+E+SR0gAbdwdwqmYMCf8KZN8A4VAbWR
         /a+0c0wsjwE8rBpw1CP4xLFd0cxzQMjHJI+EwLlY5Ml2dkmWmMPYFmxSW8i2hitLvHR5
         3U2w6HUOS6fA+7tF4BOvvDwxpIcKkgtsUgobyYTFa7yKlMs6FWa7m+tZ73pNV6DzYu11
         Uicz4SPo+sXD7kvYvlGmwfqxgZ4/vzYzHpuCRZlYiSlYg8VWgvpPyX6/g7nCSvkh5QqX
         /4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4W3ILiVgyd1ED+oBeZTN1Ck++ELFr33lONulkCFhb04=;
        b=d1BKSekbsYbOUA6+GVPPWFvBDFEV2apSmh/z8Y+6KW8B5dy3ad07oqpU1mDtYV+UlP
         fJW//GoF7ENaS7ZDf2v/5Z5R0ZBKWcivwxEpFpzuxQaWB+2U8RmZFaDCY7z+LlKwukbw
         lFhlkBBbyJnaidEpuMSAlJ8Y2w9PDiolYEmivj5q+FMAMv7ge7KQZdR7daXARcXYZMll
         ao12c6uBWOnZC6F2HG84eFfOTOd3T/e2be6LTvGb4aVvASPylSCJocyZZgE5173lcWb7
         ZhJmbGbdMRguXARIeLUZaCC187IDhP5/6tBSvv0WWC+f/f3OcMnGy/NgBY61NRjpmx1F
         cm2A==
X-Gm-Message-State: AOAM5311tCBj/K0eLpkxzCPEJTyfaWmKLP6kRdQgwscmDF/QLLxOSzwC
        TqVHjctx8uiJCGb+Iyx3vk0=
X-Google-Smtp-Source: ABdhPJwglAAc1lVAeuzHAN7Eza1H8cYMI02fxljfbrKkDHWeEJeVQetYnB/yhgDtgUVt9GpOHV7YCg==
X-Received: by 2002:ac2:4c8a:: with SMTP id d10mr1537744lfl.359.1625182122619;
        Thu, 01 Jul 2021 16:28:42 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 21/37] mtd: rawnand: tegra: Add runtime PM support
Date:   Fri,  2 Jul 2021 02:27:12 +0300
Message-Id: <20210701232728.23591-22-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The NAND on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now NAND must be resumed using
runtime PM API in order to initialize the NAND power state. Add runtime PM
support to the NAND driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mtd/nand/raw/tegra_nand.c | 44 ++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index fbf67722a049..044c7143af7a 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #define COMMAND					0x00
@@ -1152,6 +1153,7 @@ static int tegra_nand_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctrl->dev = &pdev->dev;
+	platform_set_drvdata(pdev, ctrl);
 	nand_controller_init(&ctrl->controller);
 	ctrl->controller.ops = &tegra_nand_controller_ops;
 
@@ -1168,14 +1170,15 @@ static int tegra_nand_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->clk))
 		return PTR_ERR(ctrl->clk);
 
-	err = clk_prepare_enable(ctrl->clk);
+	pm_runtime_enable(ctrl->dev);
+	err = pm_runtime_resume_and_get(ctrl->dev);
 	if (err)
-		return err;
+		goto err_disable_pm;
 
 	err = reset_control_reset(rst);
 	if (err) {
 		dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
-		goto err_disable_clk;
+		goto err_put_pm;
 	}
 
 	writel_relaxed(HWSTATUS_CMD_DEFAULT, ctrl->regs + HWSTATUS_CMD);
@@ -1190,21 +1193,21 @@ static int tegra_nand_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), ctrl);
 	if (err) {
 		dev_err(ctrl->dev, "Failed to get IRQ: %d\n", err);
-		goto err_disable_clk;
+		goto err_put_pm;
 	}
 
 	writel_relaxed(DMA_MST_CTRL_IS_DONE, ctrl->regs + DMA_MST_CTRL);
 
 	err = tegra_nand_chips_init(ctrl->dev, ctrl);
 	if (err)
-		goto err_disable_clk;
-
-	platform_set_drvdata(pdev, ctrl);
+		goto err_put_pm;
 
 	return 0;
 
-err_disable_clk:
-	clk_disable_unprepare(ctrl->clk);
+err_put_pm:
+	pm_runtime_put(ctrl->dev);
+err_disable_pm:
+	pm_runtime_disable(ctrl->dev);
 	return err;
 }
 
@@ -1221,11 +1224,33 @@ static int tegra_nand_remove(struct platform_device *pdev)
 
 	nand_cleanup(chip);
 
+	pm_runtime_put(ctrl->dev);
+	pm_runtime_disable(ctrl->dev);
+
+	return 0;
+}
+
+static int __maybe_unused tegra_nand_runtime_resume(struct device *dev)
+{
+	struct tegra_nand_controller *ctrl = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(ctrl->clk);
+}
+
+static int __maybe_unused tegra_nand_runtime_suspend(struct device *dev)
+{
+	struct tegra_nand_controller *ctrl = dev_get_drvdata(dev);
+
 	clk_disable_unprepare(ctrl->clk);
 
 	return 0;
 }
 
+static const struct dev_pm_ops tegra_nand_pm = {
+	SET_RUNTIME_PM_OPS(tegra_nand_runtime_suspend, tegra_nand_runtime_resume,
+			   NULL)
+};
+
 static const struct of_device_id tegra_nand_of_match[] = {
 	{ .compatible = "nvidia,tegra20-nand" },
 	{ /* sentinel */ }
@@ -1236,6 +1261,7 @@ static struct platform_driver tegra_nand_driver = {
 	.driver = {
 		.name = "tegra-nand",
 		.of_match_table = tegra_nand_of_match,
+		.pm = &tegra_nand_pm,
 	},
 	.probe = tegra_nand_probe,
 	.remove = tegra_nand_remove,
-- 
2.30.2

