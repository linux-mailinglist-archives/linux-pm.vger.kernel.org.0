Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 632F0E92BC
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfJ2WHV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:07:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41298 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfJ2WGT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id m9so331864ljh.8;
        Tue, 29 Oct 2019 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATBz9OC2ipALdlsnwi4Ros5q/bGo+4QXvvj0K/ozFUk=;
        b=SRnKuNM3IZFIDtfzzEYA3cc0bXarQ8nuJRMkmdba1Y1Mu0Vi4yrUG4n8WfWSE6nFut
         gn3KAmXBLkiedhlzhfT4GyBAoDLKXLW3MM4A2hbN34O2L9racJlRsTKUnF4HFR5+oC3v
         t0Iob/vmyT07pEFhHx5K5mFQ18a3HQmuAYZu12v+Qv780clkD8ie75huYM3EhsljuZ/q
         drzHnBg7LUNP4rSLxXUIIxvljC/Ho1ghbhlJTHiyMoWBdlMU2dGnbXkQ0vdG1BN51DdT
         U+KBkilDmAx4N1HEADrd3SvCf3g2ofJA7d5ru29RwX/lNs8c0MRds/RMmz/PXoCB1cM6
         v7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATBz9OC2ipALdlsnwi4Ros5q/bGo+4QXvvj0K/ozFUk=;
        b=UEaItSzVnC0zy+4ZdOXJwZp1mKOb44AgTJpmj/0ZQpImWd5MCc+ep/vI4L4jTy/HKU
         ckkMCfcPJDQFtdPesjuBpyUmIL2RxGzVYM6bas0+wu/Eae/Qq84L8UG/vAf9UBqwC4OM
         H2M3sEg4b8jFdT+vvgPk/X56XoQWUeYdzJDAPhjkNOZ8Z4LWGzNRCKdynl/XYrkH61T3
         ziyryR2xLWixoPH5SgU9CVgK8plZrldIW5R6HT/wDEc/+Yi5I6bl630h9XW2sOUtU+C6
         CEy+BFcs1ErWJXKf6buV2+P3tYaXrhYwsBcIk7TZeB0bK41vlPtPUNW3sGh63Cj7cbEK
         eobQ==
X-Gm-Message-State: APjAAAWVxkE8qg2C3h15l70iJpNVcvTBoqD3ku4p/42G9w596SQ2neqF
        u6GcVoymK9sLNUK2REQXKUs=
X-Google-Smtp-Source: APXvYqwsL5lm7TW7JQTNJJPvU6cLXTivV1OXvL4Wjxx51i/AQGDYzBxFrrw1F63a0OeXgP8gubvGkg==
X-Received: by 2002:a2e:8007:: with SMTP id j7mr4186473ljg.19.1572386777401;
        Tue, 29 Oct 2019 15:06:17 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:16 -0700 (PDT)
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
Subject: [PATCH v7 08/19] PM / devfreq: tegra30: Move clk-notifier's registration to governor's start
Date:   Wed, 30 Oct 2019 01:00:08 +0300
Message-Id: <20191029220019.26773-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
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
 drivers/devfreq/tegra30-devfreq.c | 33 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 3f2f2223da8c..1934b4eb4e78 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -514,6 +514,19 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
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
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
@@ -539,6 +552,8 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 err_stop:
 	tegra_actmon_stop_devices(tegra);
 
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
+
 	return err;
 }
 
@@ -552,6 +567,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 	cancel_delayed_work_sync(&tegra->cpufreq_update_work);
 
 	tegra_actmon_stop_devices(tegra);
+
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -796,24 +813,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
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
 
 	tegra_devfreq_profile.initial_freq = tegra->cur_freq;
@@ -830,9 +839,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_governor:
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
-
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
@@ -849,7 +855,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.23.0

