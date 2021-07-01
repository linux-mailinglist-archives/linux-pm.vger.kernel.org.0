Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF2A3B9922
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhGAXb0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbhGAXbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD558C061765;
        Thu,  1 Jul 2021 16:28:41 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d25so10785078lji.7;
        Thu, 01 Jul 2021 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DE8Tz4+kKGpK05W/OqJGLseaEMpLvysZKdQlKLU7qdo=;
        b=I1uKwbTNLWqKcS3ArnWjjMQAB6Ht3OTHgScGlrcEYx7xMC9Rs5GyYP5FcZtkUC5JX1
         9cwokjJBJNXHFhDKwQOIl44icyta+u/SHT7P4cba5h9qhrsNkvrBoo6gCSzbA7vdIVMI
         p2/9i2672O+igtoSyDT7zSiL+hn58zgtFvFue7ZDRJ/Ut7LUN9/uMjiCfakclu/yGBYW
         ZiYeciSX1Qyvk/AkLfHGogQ7pBIDcsqubNE8AcBoxvPwRNpUyRL4FrGJYC3+Yx1UUVA7
         WkltlqsD+0SieYke4FI51f36vVFdRU17NnhYsEWV/kKDXNjoKg1S7RnnP7CTBoiZo0mM
         r4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DE8Tz4+kKGpK05W/OqJGLseaEMpLvysZKdQlKLU7qdo=;
        b=hcyjSej4zGnZLPsZv90Qt3H8viK/aMsq/7CfDR/+ZiDuef4OnMhZ3DOfRWP2ABYvQU
         7ly/Xc5Rkza/JSB51tfabXN1VeLNA7xdEPfccUp7u0ZDXlJ1oT+JW3WAJNEbnFuyQpaN
         WoHXZKU5mPgnXbiYYSpl1Oq9ArmMAqL/rsym+Wt8MRwB/ejI3PbpIFKmXE5Yayg/mkoG
         aCvLAgQQUfaY9HZLNBlFSRbo6MJK6NVhJ3uQOVIWEOqlPUgX70T4bOxiRIFaeHcvi+RI
         93nfdJKscxlEQh4/iKqGR657bRfLA9fdtInlfc74AexvSITKfX88eUqlp21Pp/GDxZnN
         r1Aw==
X-Gm-Message-State: AOAM530EYGIPjlFbsuJyy4ZMIl+yzt/qSnBSAOhcbGzDo0JPik9ZPt6I
        D9D17/CQ7YOPBGPvj5WaSQ8=
X-Google-Smtp-Source: ABdhPJwU1LjOsF0IFpvzHk0VXIHvZR1FEJ07uf2trJ4pjUHlaU/cbefwQ0hcHh08jftYZr1WBH+UcA==
X-Received: by 2002:a2e:5855:: with SMTP id x21mr1485640ljd.117.1625182120237;
        Thu, 01 Jul 2021 16:28:40 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.39
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
Subject: [PATCH v7 17/37] usb: chipidea: tegra: Add runtime PM support
Date:   Fri,  2 Jul 2021 02:27:08 +0300
Message-Id: <20210701232728.23591-18-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra USB controller belongs to the core power domain and we're going
to enable GENPD support for the core domain. Now USB controller must be
resumed using runtime PM API in order to initialize the USB power state.
We already support runtime PM for the CI device, but CI's PM is separated
from the RPM managed by tegra-usb driver. Add runtime PM support to the
main USB driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 50 +++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 60361141ac04..456628d72706 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -7,6 +7,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <linux/usb.h>
@@ -278,6 +279,8 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	if (!usb)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, usb);
+
 	soc = of_device_get_match_data(&pdev->dev);
 	if (!soc) {
 		dev_err(&pdev->dev, "failed to match OF data\n");
@@ -296,11 +299,10 @@ static int tegra_usb_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = clk_prepare_enable(usb->clk);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable clock: %d\n", err);
-		return err;
-	}
+	pm_runtime_enable(&pdev->dev);
+	err = pm_runtime_resume_and_get(&pdev->dev);
+	if (err)
+		goto disable_pm;
 
 	if (device_property_present(&pdev->dev, "nvidia,needs-double-reset"))
 		usb->needs_double_reset = true;
@@ -320,8 +322,6 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_power_off;
 
-	platform_set_drvdata(pdev, usb);
-
 	/* setup and register ChipIdea HDRC device */
 	usb->soc = soc;
 	usb->data.name = "tegra-usb";
@@ -350,7 +350,10 @@ static int tegra_usb_probe(struct platform_device *pdev)
 phy_shutdown:
 	usb_phy_shutdown(usb->phy);
 fail_power_off:
-	clk_disable_unprepare(usb->clk);
+	pm_runtime_put(&pdev->dev);
+disable_pm:
+	pm_runtime_disable(&pdev->dev);
+
 	return err;
 }
 
@@ -360,15 +363,46 @@ static int tegra_usb_remove(struct platform_device *pdev)
 
 	ci_hdrc_remove_device(usb->dev);
 	usb_phy_shutdown(usb->phy);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused tegra_usb_runtime_resume(struct device *dev)
+{
+	struct tegra_usb *usb = dev_get_drvdata(dev);
+	int err;
+
+	err = clk_prepare_enable(usb->clk);
+	if (err < 0) {
+		dev_err(dev, "failed to enable clock: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_usb_runtime_suspend(struct device *dev)
+{
+	struct tegra_usb *usb = dev_get_drvdata(dev);
+
 	clk_disable_unprepare(usb->clk);
 
 	return 0;
 }
 
+static const struct dev_pm_ops tegra_usb_pm = {
+	SET_RUNTIME_PM_OPS(tegra_usb_runtime_suspend, tegra_usb_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver tegra_usb_driver = {
 	.driver = {
 		.name = "tegra-usb",
 		.of_match_table = tegra_usb_of_match,
+		.pm = &tegra_usb_pm,
 	},
 	.probe = tegra_usb_probe,
 	.remove = tegra_usb_remove,
-- 
2.30.2

