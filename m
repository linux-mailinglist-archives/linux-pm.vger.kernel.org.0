Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB811E928E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfJ2WGO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35180 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfJ2WGN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id y6so11721245lfj.2;
        Tue, 29 Oct 2019 15:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJbbmSkJxlV8NtqyjIaLW9Dj6j3YmXwewmjIh5nKOvo=;
        b=Hdm35bQwGTOkebo2y3HS/ZzLBK0jNQaWlVLOnsWk32OwcnKiPDlE35b+tmVEZBQ/MT
         yUF2KdlzLu+TD4edFq3pVRaqGhnacfGMNBYsvsytWVWH9Np+Z+qhHHZD/pcWFd/tb1xc
         4VcM2SA05FV/SdyymD60thZnb3VObiMOzZcasFIT37YPUKgh7IcK0q0BMN9HRWf0BHuF
         8KRM3oCx1cIifkU7YkqrEU5grhkKfxuMN/SkBpXvlkyMcCSd2Tr1vTMc//LaLRJ46u/f
         Y0YtzLoOZJYxII8XlgzRAl2IeoPzoJknmyJXbmnTL6Bx7F0NjlixGlSsu81EDuUdKCmM
         oobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJbbmSkJxlV8NtqyjIaLW9Dj6j3YmXwewmjIh5nKOvo=;
        b=GQ/wf/7RMauxwni2HT3bJhIveRlJlMqtBRlBlfNMCrpaba3Qki1B+5J7AjB/mDiH/C
         yyI/p+F5gYrWFWqzu0BCxPdeV9WeULLtmJ+dt/MBlflPZgdF7u3kTdZl+U3jXemv+dWX
         C6PRYI08WHETStzwy1Zy/BK0tGDa7aLMG9Px6GJCMaDwqSez7hmC5HzI9VwzKU2z7rgl
         7x1t1w+rFy6BCSaOLywe3Xfs/BBagrfI1TNshehzDz8KkOgzJjs0+0FhZlv86QAa7Hev
         AD0ytkm7O/jVhyBM6z+fxHK1ZZ6scYH28hvlZi5SJkZOlQrvJrDrj6pWx45x1bIqhTKk
         AN+Q==
X-Gm-Message-State: APjAAAWL21mL9jR6TM9LSWl2T/7tafa+E1m+I83xSoop7Dls3f/edHJE
        6NQiT1v+EPFWiO73LgCRPXw=
X-Google-Smtp-Source: APXvYqwaWX3dv0Hs+x5U4t/iKaz5bHIxIskIYRdZPYKrcjuQroOqyFJQAoQfLirya1uOL4YxuSWj2A==
X-Received: by 2002:a19:6759:: with SMTP id e25mr3682429lfj.80.1572386771175;
        Tue, 29 Oct 2019 15:06:11 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/19] PM / devfreq: tegra30: Keep interrupt disabled while governor is stopped
Date:   Wed, 30 Oct 2019 01:00:02 +0300
Message-Id: <20191029220019.26773-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no real need to keep interrupt always-enabled, will be nicer
to keep it disabled while governor is inactive.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 47 ++++++++++++++++---------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a27300f40b0b..8be6a33beb9c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -11,6 +11,7 @@
 #include <linux/devfreq.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
@@ -416,8 +417,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
 {
 	unsigned int i;
 
-	disable_irq(tegra->irq);
-
 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
 
@@ -442,8 +441,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 	}
 
 	actmon_write_barrier(tegra);
-
-	enable_irq(tegra->irq);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -552,6 +549,12 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
 
+	/*
+	 * Couple device with the governor early as it is needed at
+	 * the moment of governor's start (used by ISR).
+	 */
+	tegra->devfreq = devfreq;
+
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
@@ -586,10 +589,11 @@ static struct devfreq_governor tegra_devfreq_governor = {
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
 {
-	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
-	unsigned int i;
+	struct tegra_devfreq *tegra;
+	struct devfreq *devfreq;
 	unsigned long rate;
+	unsigned int i;
 	int err;
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
@@ -625,6 +629,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 	tegra->irq = err;
 
+	irq_set_status_flags(tegra->irq, IRQ_NOAUTOEN);
+
+	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
+					actmon_thread_isr, IRQF_ONESHOT,
+					"tegra-devfreq", tegra);
+	if (err) {
+		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
+		return err;
+	}
+
 	reset_control_assert(tegra->reset);
 
 	err = clk_prepare_enable(tegra->clock);
@@ -672,28 +686,15 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra->devfreq = devfreq_add_device(&pdev->dev,
-					    &tegra_devfreq_profile,
-					    "tegra_actmon",
-					    NULL);
-	if (IS_ERR(tegra->devfreq)) {
-		err = PTR_ERR(tegra->devfreq);
+	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
+				     "tegra_actmon", NULL);
+	if (IS_ERR(devfreq)) {
+		err = PTR_ERR(devfreq);
 		goto remove_governor;
 	}
 
-	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
-					actmon_thread_isr, IRQF_ONESHOT,
-					"tegra-devfreq", tegra);
-	if (err) {
-		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
-		goto remove_devfreq;
-	}
-
 	return 0;
 
-remove_devfreq:
-	devfreq_remove_device(tegra->devfreq);
-
 remove_governor:
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-- 
2.23.0

