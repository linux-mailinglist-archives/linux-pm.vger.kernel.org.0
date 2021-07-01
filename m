Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318733B9962
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhGAXcp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbhGAXbX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF290C0613E6;
        Thu,  1 Jul 2021 16:28:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bq39so2194516lfb.12;
        Thu, 01 Jul 2021 16:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RekyBfBintqJokGqa527rR7uRCGvzBIYRbH+O3vZH14=;
        b=n45aUXrxLIcebbTN5AuKImRGkBqeRyQ4SaQ83SPxLmEqEpGfV2MMm7sUYgqhZHKQiD
         43e+6qGuE3iYLAhZ5StpatWI6MsaJzvMmpgufWu6nUho8dR4NpfuKWhVCXuQtb1a9h4Q
         Cy+Z2fyW29QdzGFpyX1eODCmrnpgfz6N8Mp7Mj5FSe0k9HSLxhsQvON5vbkB7ieVUI8D
         ppAJCfdYCA8rWDiHJS9wL7J5CQiix7c+xfEB7NX2RjUAIzHzDltAiAqIPPQmTKtwIOWQ
         N+BHRfn6RD8CN4cWbt3Yk/flnONKfuEC5CyN0+OBTStHgBCXiTFpKRSNEnkNl+7JgAcl
         jxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RekyBfBintqJokGqa527rR7uRCGvzBIYRbH+O3vZH14=;
        b=Np3Q+HkYIDFd8RK85aZr1leBDp4id4f8XUcIsMj1mX0qY3Be26FCj8oULoOj6Njryg
         ArAGZE5932IRF2wtP2q5I7tu+Dbs4+A7bM+6IhFVHGPBy4wibcgKtrKpJ27gsOl+vbIU
         LPwgvuYNXXHgI8hNfXgochAUIoJkiPjcd9j1yh35KrB89byaSbMa4jHGyRVSN28XzUUb
         n8tk95Dtv4MJp+piRDF+EEPk9+OTNyM1XkUrXPBk3GYo5TCoxlFXlqE2HimxIpG42SJN
         Y+GlP7l/tZMeA5E/rgJ8s9kScR7GCZ2FgWnxIROEfqhOZWEvbo+zvBN4F/QULeFXhKsr
         n+0Q==
X-Gm-Message-State: AOAM531T0UeW/ydS7NSZIkPYFreapMGzzGkK7+PRWas/vq5yNHJvmlTq
        +htEjWRAnZTiesacd7v7GXI=
X-Google-Smtp-Source: ABdhPJxjKu905uqf7M3n7oq27QD5R/rHcruB4sIYAHYSxYTp9qTJAeXyvwlNT9zjKFsyDGKfT5ESVQ==
X-Received: by 2002:a05:6512:3155:: with SMTP id s21mr1460942lfi.358.1625182129156;
        Thu, 01 Jul 2021 16:28:49 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 32/37] media: staging: tegra-vde: Support generic power domain
Date:   Fri,  2 Jul 2021 02:27:23 +0300
Message-Id: <20210701232728.23591-33-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently driver supports legacy power domain API, this patch adds generic
power domain support. This allows us to utilize a modern GENPD API for
newer device-trees and support DVFS of the video decoder hardware.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/vde.c | 59 ++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
index ed4c1250b303..fc7a32ed1821 100644
--- a/drivers/staging/media/tegra-vde/vde.c
+++ b/drivers/staging/media/tegra-vde/vde.c
@@ -15,6 +15,8 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -920,13 +922,17 @@ static __maybe_unused int tegra_vde_runtime_suspend(struct device *dev)
 	struct tegra_vde *vde = dev_get_drvdata(dev);
 	int err;
 
-	err = tegra_powergate_power_off(TEGRA_POWERGATE_VDEC);
-	if (err) {
-		dev_err(dev, "Failed to power down HW: %d\n", err);
-		return err;
+	if (!dev->pm_domain) {
+		err = tegra_powergate_power_off(TEGRA_POWERGATE_VDEC);
+		if (err) {
+			dev_err(dev, "Failed to power down HW: %d\n", err);
+			return err;
+		}
 	}
 
 	clk_disable_unprepare(vde->clk);
+	reset_control_release(vde->rst);
+	reset_control_release(vde->rst_mc);
 
 	return 0;
 }
@@ -936,14 +942,41 @@ static __maybe_unused int tegra_vde_runtime_resume(struct device *dev)
 	struct tegra_vde *vde = dev_get_drvdata(dev);
 	int err;
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_VDEC,
-						vde->clk, vde->rst);
+	err = reset_control_acquire(vde->rst_mc);
 	if (err) {
-		dev_err(dev, "Failed to power up HW : %d\n", err);
+		dev_err(dev, "Failed to acquire mc reset: %d\n", err);
 		return err;
 	}
 
+	err = reset_control_acquire(vde->rst);
+	if (err) {
+		dev_err(dev, "Failed to acquire reset: %d\n", err);
+		goto release_mc_reset;
+	}
+
+	if (!dev->pm_domain) {
+		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_VDEC,
+							vde->clk, vde->rst);
+		if (err) {
+			dev_err(dev, "Failed to power up HW : %d\n", err);
+			goto release_reset;
+		}
+	}
+
+	err = clk_prepare_enable(vde->clk);
+	if (err) {
+		dev_err(dev, "Failed to enable clock: %d\n", err);
+		goto release_reset;
+	}
+
 	return 0;
+
+release_reset:
+	reset_control_release(vde->rst);
+release_mc_reset:
+	reset_control_release(vde->rst_mc);
+
+	return err;
 }
 
 static int tegra_vde_probe(struct platform_device *pdev)
@@ -1001,14 +1034,14 @@ static int tegra_vde_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	vde->rst = devm_reset_control_get(dev, NULL);
+	vde->rst = devm_reset_control_get_exclusive_released(dev, NULL);
 	if (IS_ERR(vde->rst)) {
 		err = PTR_ERR(vde->rst);
 		dev_err(dev, "Could not get VDE reset %d\n", err);
 		return err;
 	}
 
-	vde->rst_mc = devm_reset_control_get_optional(dev, "mc");
+	vde->rst_mc = devm_reset_control_get_optional_exclusive_released(dev, "mc");
 	if (IS_ERR(vde->rst_mc)) {
 		err = PTR_ERR(vde->rst_mc);
 		dev_err(dev, "Could not get MC reset %d\n", err);
@@ -1133,8 +1166,12 @@ static void tegra_vde_shutdown(struct platform_device *pdev)
 	 * On some devices bootloader isn't ready to a power-gated VDE on
 	 * a warm-reboot, machine will hang in that case.
 	 */
-	if (pm_runtime_status_suspended(&pdev->dev))
-		tegra_vde_runtime_resume(&pdev->dev);
+	if (pm_runtime_status_suspended(&pdev->dev)) {
+		if (pdev->dev.pm_domain)
+			dev_pm_genpd_resume(&pdev->dev);
+		else
+			tegra_vde_runtime_resume(&pdev->dev);
+	}
 }
 
 static __maybe_unused int tegra_vde_pm_suspend(struct device *dev)
-- 
2.30.2

