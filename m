Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7F7ADC2
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfG3Qdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:33:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38882 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732866AbfG3Qcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so66484294wrr.5;
        Tue, 30 Jul 2019 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5ThkyaRUgULktlNTFDDxUH47fhVBKZuE6estEo8LTA=;
        b=Ed0osdwNwWTYs35A6MBKD50ixU+VAc2yIrHy1zd9Z1OGpwNim0xnBnN23/nFdU6wuX
         biWECficVlZjnMje7wxxatwe9kPxkBUA9n0EJ1GHUu5DplNn/+g+kRT2ZnuFEPnPxmHm
         vcy5gaOEU5KZsa7e3yFR/2vUqjhuIJ2L1XvKlK/jda2PYasZ95dAT5fKtIM+EFSfRE8y
         NGQBfwVhQNYXnykiD3AVj+2TWeRl3VC02ZL5R0+vmEAYfd6wZ6lbUa8MZzo9xxSMYyBW
         ntwp66F6WDEYGtCzM45NTHgkal5oi7UQtCgwtjYNsP+0Vdh/g6rLDlrTz9cqiJU58Zmn
         7GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5ThkyaRUgULktlNTFDDxUH47fhVBKZuE6estEo8LTA=;
        b=XcvlgqTa9u/wx/h1P21qdkpZcvpdG818RDMbEtnDH/idtlB5ZbcwhPWmCb6oNY5suE
         e2LFo69ljwrFxTnP8xQXk8aLRCwKVySH9J10lGKP5tN0/vVFJzKC3gP7oQsyd01LAMbW
         VBFvjPxCO9TAmNe+z2aVO7++vR0fkNhYcX6S7YXWZMJhdvJE8wHj+CCGIIbhhiAdzBBR
         2K6wz9OqQBWQ0T2KvdZFp5xvxEEm6Ry1GBc2bYzudZlMSuREwszniGP52RWKVkDCHk8N
         z4OzqS79hJ12qFDsujRZbdcRTvB4vxaS/GqGrhL9GNhZs9cRVz+7z/iJO/d908Fsp1a/
         wu4Q==
X-Gm-Message-State: APjAAAUsWAC4D/u3FvcD0sREQQslfUkb2l9j4rb27+kM2AHoT8DXTn2b
        whluvHEf6UebAxKmHyOLVOo=
X-Google-Smtp-Source: APXvYqyMIeVTb36FM3vbkQArOFuuIzsuV2kzdOr+VE6k6QiY1AKWaNGhzPHg75im1hfdp+05z6YV+A==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr99169710wrv.39.1564504354344;
        Tue, 30 Jul 2019 09:32:34 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/20] PM / devfreq: tegra30: Move clk-notifier's registration to governor's start
Date:   Tue, 30 Jul 2019 19:22:28 +0300
Message-Id: <20190730162236.6063-13-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
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
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 33 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 17de24d2ae32..762e17323095 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -724,6 +724,19 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
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
 
@@ -750,6 +763,8 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
 
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
+
 	return err;
 }
 
@@ -766,6 +781,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
+
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -1010,24 +1027,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
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
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
@@ -1045,9 +1054,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_governor:
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
-
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
@@ -1064,7 +1070,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.22.0

