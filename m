Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B153B993C
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhGAXbe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhGAXbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66532C061765;
        Thu,  1 Jul 2021 16:28:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t17so14910697lfq.0;
        Thu, 01 Jul 2021 16:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yseaQW+MaeBCwD6ZauN1QagZb1MK1zpaTRkjvaZq/jc=;
        b=Qw9oBSACWA/WgYkqpH/fhhk1Yyn5shydRzAVulVS1c5cXRvoIbDYaP0zbifxPCwoLX
         bCSWeQQwQXZ7beBm5QTw+ay5otV2KFYku+qkoejNpAg+7b1BzGHOp10t1z1TAmlpT6g/
         QL3VTyWuwngVEiiX/4JKMXXGJtgWUw2HfFcArWIjbhhuWrqM0lnuvpLSxNv7iDbzj1QK
         RS4di3PNvrwHYNc5UtDINbr5/hnFIDT2vrJrhOqrks83HiOSkjbyk4y5UP4NRty/OjLn
         IgxHHq/rvvCo0FIH3LmcySMSqQc4IOARSnWbcDW5GiIKAd7LeSaiQuYFkNWHGOFjWp5x
         msfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yseaQW+MaeBCwD6ZauN1QagZb1MK1zpaTRkjvaZq/jc=;
        b=Qm7NJtYBtfkv0UNrZRmGgTuI7Ky8n7YsfNW58onwpyHweFYIBCMMEOC3FGSRV//zoc
         WKZKM7MGyw7RXBFuT34mpo7/JcPAVT8P6oh8v7FmweR8HMq1NkL1E7dAgdS+aMP8n/Dz
         uNG7iftIycQjWKwFNIGDbLUUXfBsCae65/jtxNqIfE3dljofVfAqOAuYDILx38yqVu+u
         sI2EiuyLPEQ2Ou9a5mNniy6yOBCR6jGEgCt1WldVMW90SyR1s4kyzZUgxplFGmyqKIwf
         MKw9iJO/0q2VqxVnXFsRLb10l7rlbnam5NgDjuSiIcDIBkKOR/Fqmg/eUosunlg2yaXI
         m1qw==
X-Gm-Message-State: AOAM531VxwhNXN1C5yq4iC1HG5UNIOS4ARsAjVC/ZEKG90/NMrye3GZ4
        x931AuXPM8zDxnUg6lIN3j4=
X-Google-Smtp-Source: ABdhPJwXttkhDKkaCqXDWX3QMMqdlEOYjPyKkqkz/1O7JxhDdTnqwwP39b6C8Hym6+CioMK/ueVF0Q==
X-Received: by 2002:a19:4842:: with SMTP id v63mr1527718lfa.417.1625182123789;
        Thu, 01 Jul 2021 16:28:43 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 23/37] soc/tegra: fuse: Add runtime PM support
Date:   Fri,  2 Jul 2021 02:27:14 +0300
Message-Id: <20210701232728.23591-24-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra FUSE belongs to the core power domain and we're going to enable
GENPD support for the core domain. Now FUSE device must be resumed using
runtime PM API in order to initialize the FUSE power state. Add runtime PM
support to the FUSE driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c   | 30 +++++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse-tegra20.c | 10 +++++----
 drivers/soc/tegra/fuse/fuse-tegra30.c |  9 ++++----
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 2434c570b53c..747237865aff 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
@@ -210,6 +211,8 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fuse);
 	fuse->dev = &pdev->dev;
 
+	pm_runtime_enable(&pdev->dev);
+
 	if (fuse->soc->probe) {
 		err = fuse->soc->probe(fuse);
 		if (err < 0)
@@ -248,13 +251,40 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 restore:
 	fuse->clk = NULL;
 	fuse->base = base;
+	pm_runtime_disable(&pdev->dev);
 	return err;
 }
 
+static int __maybe_unused tegra_fuse_runtime_resume(struct device *dev)
+{
+	int err;
+
+	err = clk_prepare_enable(fuse->clk);
+	if (err < 0) {
+		dev_err(dev, "failed to enable FUSE clock: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_fuse_runtime_suspend(struct device *dev)
+{
+	clk_disable_unprepare(fuse->clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tegra_fuse_pm = {
+	SET_RUNTIME_PM_OPS(tegra_fuse_runtime_suspend, tegra_fuse_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver tegra_fuse_driver = {
 	.driver = {
 		.name = "tegra-fuse",
 		.of_match_table = tegra_fuse_match,
+		.pm = &tegra_fuse_pm,
 		.suppress_bind_attrs = true,
 	},
 	.probe = tegra_fuse_probe,
diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index 16aaa28573ac..cd6a273707fe 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -16,6 +16,7 @@
 #include <linux/kobject.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/random.h>
 
 #include <soc/tegra/fuse.h>
@@ -46,6 +47,10 @@ static u32 tegra20_fuse_read(struct tegra_fuse *fuse, unsigned int offset)
 	u32 value = 0;
 	int err;
 
+	err = pm_runtime_resume_and_get(fuse->dev);
+	if (err)
+		return err;
+
 	mutex_lock(&fuse->apbdma.lock);
 
 	fuse->apbdma.config.src_addr = fuse->phys + FUSE_BEGIN + offset;
@@ -66,8 +71,6 @@ static u32 tegra20_fuse_read(struct tegra_fuse *fuse, unsigned int offset)
 
 	reinit_completion(&fuse->apbdma.wait);
 
-	clk_prepare_enable(fuse->clk);
-
 	dmaengine_submit(dma_desc);
 	dma_async_issue_pending(fuse->apbdma.chan);
 	time_left = wait_for_completion_timeout(&fuse->apbdma.wait,
@@ -78,10 +81,9 @@ static u32 tegra20_fuse_read(struct tegra_fuse *fuse, unsigned int offset)
 	else
 		value = *fuse->apbdma.virt;
 
-	clk_disable_unprepare(fuse->clk);
-
 out:
 	mutex_unlock(&fuse->apbdma.lock);
+	pm_runtime_put(fuse->dev);
 	return value;
 }
 
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index c1aa7815bd6e..dd03565a39a4 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/random.h>
 
 #include <soc/tegra/fuse.h>
@@ -52,15 +53,13 @@ static u32 tegra30_fuse_read(struct tegra_fuse *fuse, unsigned int offset)
 	u32 value;
 	int err;
 
-	err = clk_prepare_enable(fuse->clk);
-	if (err < 0) {
-		dev_err(fuse->dev, "failed to enable FUSE clock: %d\n", err);
+	err = pm_runtime_resume_and_get(fuse->dev);
+	if (err)
 		return 0;
-	}
 
 	value = readl_relaxed(fuse->base + FUSE_BEGIN + offset);
 
-	clk_disable_unprepare(fuse->clk);
+	pm_runtime_put(fuse->dev);
 
 	return value;
 }
-- 
2.30.2

