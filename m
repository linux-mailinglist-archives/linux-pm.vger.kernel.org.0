Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE303B9938
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhGAXbe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhGAXbT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E541C061762;
        Thu,  1 Jul 2021 16:28:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t17so14910781lfq.0;
        Thu, 01 Jul 2021 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f56Gl+ceHFtd9FMQz3NaesahiaueeMULsgTKbMKIYQo=;
        b=SdNCQn0FFDA6k/40jxgLbTbVVFYmDroPebW2HXLlJBmSXRIaDLc4QO4AuhWzydGz+6
         1LEbWc/Z2SPy/JhfB5gXufzWpylYia2K+M4VMejnYhzPghQcUSta+2/wbKcFERty1CDS
         kvknN7py3WDkNmrYRd5VYLTdtMwvkkv8q7+OCpaA/XVDglg8lUITDUq/7OBNHsi6vWln
         EqstazKpbMfds3Euu+kMrrns0tNA3o9l3Qd/fy8bDyadjNsKn5VKYtu6xu1bOfeJmezS
         ovGrlOFDNfOo97Vh1sjETcfNZaqdN63LZrG8uiEcMvpDcYwcgShqIRlGyZWBiXznj/xz
         PW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f56Gl+ceHFtd9FMQz3NaesahiaueeMULsgTKbMKIYQo=;
        b=L+gQMq2RLDPqoytR9ZkJ2MMQV3b4Jp5vhLYevX6ucNGxlNWOA+0v9Wi2VaE9XDSYPg
         dX5U+ZN1rfAOv3sbMUv2iomaBG7bHXyfNSwck3JrEFug26v4ejnJuCcn1apkNeCiuMIZ
         gOMIQIeSeQ18nGUBE80ZNsoZngHmnbPkeecm2biepUx7q0IcBvl7rU/xEYv5xMxPt1zb
         QrjWNwsxWJPHIVGl97LMlSTsh3+yM0Pj3Xmry7MLbHDwnOTooJYX1Ys5hp2Bbrt6TOaR
         +TAxUR1DexRrYiOtjX1Rzeu18WKQLSrcFgv3GxttIPMaUdIVeEX6U+j6Vs1ACZ8tESP7
         AInw==
X-Gm-Message-State: AOAM530sW5M5Ou8qN/UQL7M7FxhgT+FpUpOx+boiRA4PmHOwAbZUQjzs
        31vH6KxBvbiXcDY7Y3Lqfl4=
X-Google-Smtp-Source: ABdhPJwXT4i9jbxEI5E8Hp5psSkLR3WlVB0RiPNuvR6S0Oq5icrEw0qeI7L580aRDTIIsqXfid1hLA==
X-Received: by 2002:a05:6512:33d2:: with SMTP id d18mr1494314lfg.234.1625182125577;
        Thu, 01 Jul 2021 16:28:45 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 26/37] spi: tegra20-slink: Improve runtime PM usage
Date:   Fri,  2 Jul 2021 02:27:17 +0300
Message-Id: <20210701232728.23591-27-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra SPI driver supports runtime PM, which controls the clock
enable state, but the clk is also enabled separately from the RPM
at the driver probe time, and thus, stays always on. Fix it.

Runtime PM now is always available on Tegra, hence there is no need to
check the RPM presence in the driver anymore. Remove these checks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 67 +++++++++++----------------------
 1 file changed, 22 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 6a726c95ac7a..cbf0b4a0820a 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1061,27 +1061,6 @@ static int tegra_slink_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Can not get clock %d\n", ret);
 		goto exit_free_master;
 	}
-	ret = clk_prepare(tspi->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Clock prepare failed %d\n", ret);
-		goto exit_free_master;
-	}
-	ret = clk_enable(tspi->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Clock enable failed %d\n", ret);
-		goto exit_clk_unprepare;
-	}
-
-	spi_irq = platform_get_irq(pdev, 0);
-	tspi->irq = spi_irq;
-	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
-			tegra_slink_isr_thread, IRQF_ONESHOT,
-			dev_name(&pdev->dev), tspi);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
-					tspi->irq);
-		goto exit_clk_disable;
-	}
 
 	tspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(tspi->rst)) {
@@ -1106,16 +1085,9 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	init_completion(&tspi->xfer_completion);
 
 	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		ret = tegra_slink_runtime_resume(&pdev->dev);
-		if (ret)
-			goto exit_pm_disable;
-	}
-
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret) {
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
-		pm_runtime_put_noidle(&pdev->dev);
 		goto exit_pm_disable;
 	}
 
@@ -1123,33 +1095,43 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	udelay(2);
 	reset_control_deassert(tspi->rst);
 
+	spi_irq = platform_get_irq(pdev, 0);
+	tspi->irq = spi_irq;
+	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
+				   tegra_slink_isr_thread, IRQF_ONESHOT,
+				   dev_name(&pdev->dev), tspi);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
+			tspi->irq);
+		goto exit_pm_put;
+	}
+
 	tspi->def_command_reg  = SLINK_M_S;
 	tspi->def_command2_reg = SLINK_CS_ACTIVE_BETWEEN;
 	tegra_slink_writel(tspi, tspi->def_command_reg, SLINK_COMMAND);
 	tegra_slink_writel(tspi, tspi->def_command2_reg, SLINK_COMMAND2);
-	pm_runtime_put(&pdev->dev);
 
 	master->dev.of_node = pdev->dev.of_node;
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
-		goto exit_pm_disable;
+		goto exit_free_irq;
 	}
+
+	pm_runtime_put(&pdev->dev);
+
 	return ret;
 
+exit_free_irq:
+	free_irq(spi_irq, tspi);
+exit_pm_put:
+	pm_runtime_put(&pdev->dev);
 exit_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_slink_runtime_suspend(&pdev->dev);
+
 	tegra_slink_deinit_dma_param(tspi, false);
 exit_rx_dma_free:
 	tegra_slink_deinit_dma_param(tspi, true);
-exit_free_irq:
-	free_irq(spi_irq, tspi);
-exit_clk_disable:
-	clk_disable(tspi->clk);
-exit_clk_unprepare:
-	clk_unprepare(tspi->clk);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
@@ -1162,9 +1144,6 @@ static int tegra_slink_remove(struct platform_device *pdev)
 
 	free_irq(tspi->irq, tspi);
 
-	clk_disable(tspi->clk);
-	clk_unprepare(tspi->clk);
-
 	if (tspi->tx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, false);
 
@@ -1172,8 +1151,6 @@ static int tegra_slink_remove(struct platform_device *pdev)
 		tegra_slink_deinit_dma_param(tspi, true);
 
 	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_slink_runtime_suspend(&pdev->dev);
 
 	return 0;
 }
-- 
2.30.2

