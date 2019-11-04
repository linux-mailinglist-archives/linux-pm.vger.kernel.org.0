Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F83EEF1F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbfKDWTW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:19:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39562 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388964AbfKDWBK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id y3so19415472ljj.6;
        Mon, 04 Nov 2019 14:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9+CHMZoGGQ0kyLUVsXDA/Tuh9oFzpRRT79bF9HX1WM=;
        b=lzdhgMlslFq88r285yeohrSBNwz0mZz4md7IYZEAyWOfJc+0BOETETJaNikVjB8roy
         IMOPf+0ygt/ubO3DjmC+apNhJMrpi5kXCbJ56BNAdSvKD3UWkx2Bvql/58JjEgvudsBY
         wQ1lUQlrPXMlS21gcygP1DDkIk6ZL/n3jT8Q/ZHCQ9WKJDCRyj5RG0MnAvv+yram/SNi
         QhY4xhwjl/7ebsXnAOC9QLlgKyaNXuqh2c/fsZzvQ8ifWjjiY1MIVymSBeWdQ98rJXmr
         spIJTz82MyD9ce+ntGG5cOyuwQPnv5/27LRuZ/YcZNOkgUy4fNffgD6eLdB5c2JERwQW
         5G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9+CHMZoGGQ0kyLUVsXDA/Tuh9oFzpRRT79bF9HX1WM=;
        b=GLXOHh9K9O1Ff5Htp3954efiaslMnJehTrGL2nkucm0tqPl9GXoSP5sxJ193giucAF
         8rzgS2zraEbn0t5JRjChZvMIc+m8pfmaJKR6aAtL3ve+418gUuT9Ac+nMVSr9Wg4ftcn
         mbxtepWEScBg0h6IzBK68KcJYjeQhu+DiyJ3FVGqHK+t14aiAGZQk65U0FDxLZUlJiO7
         yeMCmFEm79lWQ227eqe8newJAo7pmcmqe+/MwfjKGnsG4Tl9osjRya2ewwPW7MuaO7L5
         OgOZOQ1RsTApjlCCS80yoDP4pEw4q08b4QqoclctEf8VfmRlbJ7R7ulHfEJnQUk7Gjch
         +pUA==
X-Gm-Message-State: APjAAAVNXInm7bGs6ii+1QWrZ94ksM2r41gRBWQ4ILsy3wrgJb3mFLxp
        k+mAc4IcETDft1kAYN+hyYc=
X-Google-Smtp-Source: APXvYqzY6mre08rYa4mbbMCq9jRRTThhJNVYu3dpnIW9ndgbbH9qrwSEqU3nSH70Yx3Ge3a2W+RIVw==
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr192095ljq.20.1572904867264;
        Mon, 04 Nov 2019 14:01:07 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:06 -0800 (PST)
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
Subject: [PATCH v9 08/19] PM / devfreq: tegra30: Move clk-notifier's registration to governor's start
Date:   Tue,  5 Nov 2019 00:56:06 +0300
Message-Id: <20191104215617.25544-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
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

