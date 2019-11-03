Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A139AED4EE
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfKCUnA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:43:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40765 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfKCUmM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so8825923ljg.7;
        Sun, 03 Nov 2019 12:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9+CHMZoGGQ0kyLUVsXDA/Tuh9oFzpRRT79bF9HX1WM=;
        b=TUqLQDiqv3xLDWlA1iKqmrWtizpsM0hTiM2kEHMtOkSgXplN8gDdNICP2vgGqK6PWx
         EWakDXBQ6W1DTYySfNp0ftYUn8EplzJS2owRJvis9dwPH+nk7zoIGpgHkWXEmTGGIE/n
         +6cntfMUOLLV5+gz8LvRjCsD090WfmUhwgEPC+olGa52x2PMdOJD6ihzSyS2LbFpna7J
         8pBT8R7NJTwOmYIoEVpyRiLCFLg+BxWFgw9BA+FAujcNrJbQs12fXBPyG/6zFh/FvutW
         LE3i3tR9RltCxCPpJqZ3kIQiMVU1lw0f7HhsOOv43Lkw8Z8jE3TkOqRBgOQi1FPZAf0u
         4sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9+CHMZoGGQ0kyLUVsXDA/Tuh9oFzpRRT79bF9HX1WM=;
        b=hMNSy3eXxhffLULo029e8czzJQiewai3+pOibtaY5s0JWkKHLqQphYLuDTC5u7uDuX
         jvcyAnwXWIdP7n1Zi24A7sE2LLBt3bfXoxDVp36HAUF/sBlpKkh+BLWzs/unq826AlMn
         8tpkZ4uHE+k+QqCcaqkaGFo6g8U+UVfplrqbaelXNVOHT4/hxvoi1zS8K5NdQrDGsjcu
         Mm5MEO2hqKZhhMyoVRTsJFuTT/W5iHNCPEJGiIO5mqzuGeKTy3IBvWkoU5SnTRwJcLeN
         ebftyZICRMOuwL6WuEm30EbupedJb/CNH2saf3gRswwBzZsfeip8LX2ypCDQyitwaDrS
         bUSA==
X-Gm-Message-State: APjAAAUo3/Ke4nG9PUnNAt0zWRTDGdA68Z2eNNV8m/50CYKpAn24U3Ci
        qMpjSDwccIZtMWD7CAN1IjY=
X-Google-Smtp-Source: APXvYqySs8z1GndldbAF6dJuniLNMKNLeR1pFr8/RYSTNzBtsN54Q6N4DkDftUWSLVckSuuXFlFd6A==
X-Received: by 2002:a2e:b0f3:: with SMTP id h19mr9203237ljl.153.1572813730098;
        Sun, 03 Nov 2019 12:42:10 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:09 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/18] PM / devfreq: tegra30: Move clk-notifier's registration to governor's start
Date:   Sun,  3 Nov 2019 23:41:20 +0300
Message-Id: <20191103204130.2172-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no point in receiving of the notifications while governor is
stopped, let's keep them disabled like we do for the CPU freq-change
notifications. This also fixes a potential use-after-free bug if
notification happens after device's removal.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 39 ++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 2d720e7e2236..6960d8ba0577 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -514,6 +514,21 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
 
+	/*
+	 * CLK notifications are needed in order to reconfigure the upper
+	 * consecutive watermark in accordance to the actual clock rate
+	 * to avoid unnecessary upper interrupts.
+	 */
+	err = clk_notifier_register(tegra->emc_clock,
+				    &tegra->clk_rate_change_nb);
+	if (err) {
+		dev_err(tegra->devfreq->dev.parent,
+			"Failed to register rate change notifier\n");
+		return err;
+	}
+
+	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
+
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
@@ -539,6 +554,8 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 err_stop:
 	tegra_actmon_stop_devices(tegra);
 
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
+
 	return err;
 }
 
@@ -552,6 +569,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 	cancel_delayed_work_sync(&tegra->cpufreq_update_work);
 
 	tegra_actmon_stop_devices(tegra);
+
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -768,7 +787,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return rate;
 	}
 
-	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 	tegra->max_freq = rate / KHZ;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
@@ -796,27 +814,20 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
+	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
 	tegra->cpu_rate_change_nb.notifier_call = tegra_actmon_cpu_notify_cb;
 
 	INIT_DELAYED_WORK(&tegra->cpufreq_update_work,
 			  tegra_actmon_delayed_update);
 
-	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
-	err = clk_notifier_register(tegra->emc_clock,
-				    &tegra->clk_rate_change_nb);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Failed to register rate change notifier\n");
-		goto remove_opps;
-	}
-
 	err = devfreq_add_governor(&tegra_devfreq_governor);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
-		goto unreg_notifier;
+		goto remove_opps;
 	}
 
-	tegra_devfreq_profile.initial_freq = tegra->cur_freq;
+	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
+	tegra_devfreq_profile.initial_freq /= KHZ;
 
 	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
 				     "tegra_actmon", NULL);
@@ -830,9 +841,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_governor:
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
-
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
@@ -849,7 +857,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.23.0

