Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DBF3018A9
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 23:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAWWUA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 17:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWWT7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 17:19:59 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF005C061786
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:18 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a8so12572011lfi.8
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zILsjb5YiuKMvmLjiNfcPgv+rGP6ByymYCZbye6VpE=;
        b=cwFFGxmY7lcebdOAfzrILpwepw6xR+OIFYwYXDB73h7JjCJqDMIDYZfQOKd2CvEziA
         a2s0E6VgLGwLKLAFAYJfmu+yAIQglpswYqmAkl2vLcx+hicPqRNn0rN56dTIh8eTY+h0
         EMoqWJuooRqpZbhD3h+GUT2YDxOCoHp6cX4/q5FqrEEG7B1/0ktOnuYXx84Lzvj92BMG
         lCcAwbpd2sF8dzScj3i8XTuCm6SoFovh+cHjmExiQxOvLLMeqVwTOPPL9JR//Vy6zYV2
         B9uGvuu1qRzqaN0hzoKm33RhB6rYEKZlZiTj/HEuneD8alX2QR8jCNsgKOCCbqvnIg78
         P7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zILsjb5YiuKMvmLjiNfcPgv+rGP6ByymYCZbye6VpE=;
        b=PiQH/w7K4P+0eDZNxD/wRN6hkBoCbqbbEOa0E7jCKI94izg4/3WlE2R8Vpab8W2ye1
         PH9nA/WvX9pJrrARcCMgIv+bQlGY0LMMaUlMQygixPNMg07hw+ZUfc1kma89mWhPz/ij
         NvH1YC1KOUIJ/KMYcx1WvPblOi5/ZXVzJI9z/YB0Ku1KPGU5LXSYPSw55DKBfMA+G4ZN
         LENPfQMrF4Hbnb+JrSQDwPJ2kCsm2rrSMZuDpCemD6Xz6uUyeLsx1HxkTQdpFdm23ZCF
         siYND81rnCrzCPIOROPk1EE6Ca2e4JFLZnxZnDcVmNysa/JZBgBEGtjGjeJtO/LRsTys
         OnRw==
X-Gm-Message-State: AOAM531z2F0brifiymtlzFXsdUgVQX/0s5GcQR9HfuPvnl4IuNVL6ECP
        O1/JRB1Ws/molEHNC6DpX2SlOA==
X-Google-Smtp-Source: ABdhPJwCOtQ1JZOvGYsIFLJn2nMFT/1DOoqTEVKJ/Wq/lKX1C4/CzTKGiOfDQhFHg2Dgk6UufiU5IQ==
X-Received: by 2002:ac2:52a8:: with SMTP id r8mr183707lfm.17.1611440357440;
        Sat, 23 Jan 2021 14:19:17 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x17sm1313956lfg.0.2021.01.23.14.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 14:19:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 01/10] power: supply: ab8500: Require device tree
Date:   Sat, 23 Jan 2021 23:18:59 +0100
Message-Id: <20210123221908.2993388-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123221908.2993388-1-linus.walleij@linaro.org>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The core AB8500 driver and the whole platform is completely
dependent on being probed from device tree so remove the
non-DT probe paths.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/Kconfig           |  2 +-
 drivers/power/supply/ab8500_btemp.c    | 10 ++++------
 drivers/power/supply/ab8500_charger.c  | 15 ++++++---------
 drivers/power/supply/ab8500_fg.c       | 10 ++++------
 drivers/power/supply/abx500_chargalg.c | 10 ++++------
 5 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index eec646c568b7..0f617e10dfb7 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -677,7 +677,7 @@ config BATTERY_GAUGE_LTC2941
 
 config AB8500_BM
 	bool "AB8500 Battery Management Driver"
-	depends on AB8500_CORE && AB8500_GPADC && (IIO = y)
+	depends on AB8500_CORE && AB8500_GPADC && (IIO = y) && OF
 	help
 	  Say Y to include support for AB8500 battery management.
 
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index d20345386b1e..3cec0affd866 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -1008,12 +1008,10 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	}
 	di->bm = plat;
 
-	if (np) {
-		ret = ab8500_bm_of_probe(dev, np, di->bm);
-		if (ret) {
-			dev_err(dev, "failed to get battery information\n");
-			return ret;
-		}
+	ret = ab8500_bm_of_probe(dev, np, di->bm);
+	if (ret) {
+		dev_err(dev, "failed to get battery information\n");
+		return ret;
 	}
 
 	/* get parent data */
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index ac77c8882d17..aa573cd299e2 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3360,15 +3360,12 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	}
 	di->bm = plat;
 
-	if (np) {
-		ret = ab8500_bm_of_probe(dev, np, di->bm);
-		if (ret) {
-			dev_err(dev, "failed to get battery information\n");
-			return ret;
-		}
-		di->autopower_cfg = of_property_read_bool(np, "autopower_cfg");
-	} else
-		di->autopower_cfg = false;
+	ret = ab8500_bm_of_probe(dev, np, di->bm);
+	if (ret) {
+		dev_err(dev, "failed to get battery information\n");
+		return ret;
+	}
+	di->autopower_cfg = of_property_read_bool(np, "autopower_cfg");
 
 	/* get parent data */
 	di->dev = dev;
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 3873e4857e3d..9d734fd2b48f 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3043,12 +3043,10 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	}
 	di->bm = plat;
 
-	if (np) {
-		ret = ab8500_bm_of_probe(dev, np, di->bm);
-		if (ret) {
-			dev_err(dev, "failed to get battery information\n");
-			return ret;
-		}
+	ret = ab8500_bm_of_probe(dev, np, di->bm);
+	if (ret) {
+		dev_err(dev, "failed to get battery information\n");
+		return ret;
 	}
 
 	mutex_init(&di->cc_lock);
diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index a9d84d845f24..591ddd2987a3 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -1997,12 +1997,10 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	}
 	di->bm = plat;
 
-	if (np) {
-		ret = ab8500_bm_of_probe(&pdev->dev, np, di->bm);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to get battery information\n");
-			return ret;
-		}
+	ret = ab8500_bm_of_probe(&pdev->dev, np, di->bm);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get battery information\n");
+		return ret;
 	}
 
 	/* get device struct and parent */
-- 
2.29.2

