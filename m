Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC9689452
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfHKVZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:25:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46098 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfHKVYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id n19so4571023lfe.13;
        Sun, 11 Aug 2019 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lns2F1Z8CpqknymSvh5W98Sjrak+4HxbHPvWO55eGpU=;
        b=rTUtHuiPNe7o8K8j17CoKUgmNGCABvr1V/0mZfK2hx64sgNJ+Qe4d/ATdBExamK5D3
         RuO65xa1Ct4j53rk86GHcJ4W+7VfZTUdGt+AISGhyzWM/ycpbVooGbcwv+yYdJSRDQhK
         anGvprizBk8gK8rUieCSjbMGgN1TOwxDTl3weYZy1yTgknWaMv1dcm5td+zRi2asDz6Y
         cOLCu38Y/itGS2aQHzU3iiVmB22kZsTVUOZzq2qUVyUB0MAibJFX0N6Y2NFWQAWJFzhK
         2+45C7oSyI72RM2uAAc1hEEwHMA/LyjbIj5/SmEa/WSWmiYPcsaIj8YmxfsNaEphl5vD
         ImPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lns2F1Z8CpqknymSvh5W98Sjrak+4HxbHPvWO55eGpU=;
        b=S6WBbP6VNOgA2a+v9NrR7EgB1cQL+skIiwo0d4C+zZn7vaVBQVlggRc/1RB5HB2rgN
         ZrPeGehDAF/Xui7EuAH+i248Fneyo+8lolxGwt6V+mCUizkOeUeMfwO9FuSfAPzflqIB
         +PX+4LgLhKpg1+ypz8qA8eSpapQPXJXGnVd5rqJ/C1mvkeV13natemFPM15nGHI7Lnn+
         iYoFxNBmLq24HatOCo/6B+tf2IlQq1nMYBd5sJV5RlpB8TvUd+v21iGrhYl8oS9JNe8K
         TvcXSQE3dMr/+LMJuMgu3p+azW1+kQttfGL/JlSQDoFgBFd+7HFUk578rYDxhONYzekM
         mvPw==
X-Gm-Message-State: APjAAAVE6VHQC8j3/AUwYusBwoq0HiqXv1Le2UzM6BX9Pf9iT2Xd7etl
        BT6h2Jd7jRaYnvMIPuaqsdg=
X-Google-Smtp-Source: APXvYqzVb1EudV5q+8upA2GUBirn8Fc7LPgdchyfJk8YU0+8PpxmVn2hfZm4lkVV8o1NdDfH1RaC3g==
X-Received: by 2002:ac2:5dfb:: with SMTP id z27mr18248162lfq.128.1565558685294;
        Sun, 11 Aug 2019 14:24:45 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/19] PM / devfreq: tegra30: Move clk-notifier's registration to governor's start
Date:   Mon, 12 Aug 2019 00:23:08 +0300
Message-Id: <20190811212315.12689-13-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
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
index a260812f7744..bad9836b1eea 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -726,6 +726,19 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
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
 
@@ -752,6 +765,8 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
 
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
+
 	return err;
 }
 
@@ -768,6 +783,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
+
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -1012,24 +1029,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
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
@@ -1047,9 +1056,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_governor:
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
-
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
@@ -1066,7 +1072,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.22.0

