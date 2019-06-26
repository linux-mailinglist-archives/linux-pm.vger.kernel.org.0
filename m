Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC855DAE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfFZBf7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35645 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfFZBfH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so436085ljh.2;
        Tue, 25 Jun 2019 18:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rkIjugB4w8xYWi6r3cGW1MkswK/7WFKc1Uo0CWzihn8=;
        b=SIFhCJF4Z6BiFc34bYLSckvy/AB49CHacHOPR7hpYSwDZpILwa2ihcheHlVh5Ds/Gy
         0tvwHQ1M0ZHn6Gl5Hnnvxdd/UERQ7q+X7HOGgWlZZ1AkWTs3cwX7k8Vq+IfBtaQlc9c+
         808b6Ouq8TBwr+6B2yzuRNEh5zP+Ey3+S6qkMdPXPO0bhO3cqo3AahU69WqiRlt3hrY+
         YFXcuttt578UHLBtC7uJIA5wots5EQ8NU/dnIlRzFICMNZ00Oi3D+Nv4179eTP0fXu5f
         QERyEYrsEW0YMxuc4zWo7dOojyfqWuygXyuYcueR2GH7IgMG52iXOzYyg7zPpb5l5371
         jWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rkIjugB4w8xYWi6r3cGW1MkswK/7WFKc1Uo0CWzihn8=;
        b=jh4D//DYrV6AvsgFaxd36V2QLotT1l0MDaInudDIwkquoHRjrNFbfS18jBOEkCAy5j
         vAmL4Z0TFeP/vg+4BiIiFEqSlYZ9DbiNEv+yrT3mQPaRf3es6nozNazyXyOzFgTqsp4y
         m/41zatmftnyRpo96pV8CTkVXovrxB+h4mD3ggFBKSI93eO6rP6/yoRAaQWsNVzKQ7hN
         QqRkWk/KHPXUJBN+O6jgHGbijLSqkCwg5JfsT/8SO4oNmar5p9KbLUvwVZfcdfIQt1Hp
         T+Wt52AM/2iSXOsbg6aOphLnwnGPtim+mQ8fNXwTGXU1JaOsdTd8TINu6rBMBXWcmXzu
         ZIqg==
X-Gm-Message-State: APjAAAUFvbNScATUywdi5UUMa6YEydlx8dxPSotSECm0wml7poOvMTKZ
        HU3ycerPMjfVTmbEi8Jx6zs=
X-Google-Smtp-Source: APXvYqwGz4l+lBPFgkGFhrerCzKAmXHf1BrmDmDxFJJbN18QE/xJRcRgn4A/rDs5UlSkNKwFiV0q3A==
X-Received: by 2002:a2e:9116:: with SMTP id m22mr883680ljg.216.1561512904939;
        Tue, 25 Jun 2019 18:35:04 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/17] PM / devfreq: tegra30: Move clk-notifier's registration to governor's start
Date:   Wed, 26 Jun 2019 04:32:42 +0300
Message-Id: <20190626013252.30470-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 33 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a2cae8348dce..8e1c56790ac3 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -574,6 +574,19 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
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
 
@@ -600,6 +613,8 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
 
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
+
 	return err;
 }
 
@@ -616,6 +631,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
+
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -860,22 +877,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
+	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
 	tegra->cpu_rate_change_nb.notifier_call = tegra_actmon_cpu_notify_cb;
 	INIT_WORK(&tegra->update_work, tegra_actmon_delayed_update);
 
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
@@ -891,9 +900,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_governor:
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
-
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
@@ -910,7 +916,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.22.0

