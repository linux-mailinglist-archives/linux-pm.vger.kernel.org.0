Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FD6180B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfGGWfV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37757 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbfGGWfV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so11883031qkl.4;
        Sun, 07 Jul 2019 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afdqxa+MI/Zw9XC1saAD57FYuQTdjrhBAxQl2lE5kwU=;
        b=EFEU5R4COaEDjeex0WlKiCc51R3hdmHjEC20GWJCpbDajImycEiX1LMcORx6vGRCL0
         HPPWBmEqAxxF6Ocx/ihM/zzmwC2h2srVnSSA1aIcSQv6lzGtAfALHGIp1S5/8LHbZQxx
         lImteqP48gxV8e8KTWVu1B1t0ikGnXivYS/oy6MqfpCycpPV9mfyQPjs7Ja0daTloK93
         nhcEmjs7b6IDC4I8HajdZCunaoXCm58oOEl3fDAKdI4PRuWtbUMrWRIAc3OM7bvVbF4l
         HNJo9XA+Nxc7sN/i45D3YTY3wGM+iKP5E1wxDdNWSIRDGmmzvVnYe+MLP8kzrmdqglDe
         Q4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afdqxa+MI/Zw9XC1saAD57FYuQTdjrhBAxQl2lE5kwU=;
        b=GSQKqqLjjHn9jE2POCN+EWEBll3Jkkyq/vcj7gymgQedsBX91mn8J7TsbukpqtnYy3
         MYiirA/dzKKKj8aj8TMOPzhvsW1eIG+bG4ArQmLhrhAy+v/Fp8kX0XU/12eWSCmKcmts
         EOZjhl1nhlOUWH8DahKTEXwijpzq3OlbsVZ/WQJ12DVEZwyuPRivB0pttwQeltVbZ3L/
         x9MkPqPUTDuyUla4Yb7fA+rZeIhul0HC5qpJdBX05zlWExJ9pEbbRRlNnqtNwyJ9Q3A9
         V2oc3tVZXcna0YGmuNRsGV968ORZwgMFQN0j7qbiMjr4UjRZAkGVmSe75Uxu46++pIaJ
         lz1Q==
X-Gm-Message-State: APjAAAWgqlklYA3Vah/EpQoErkyS713VhYQhXZW4e5A/+t62vxtvdW2D
        WPyF5lY/3fD2VKnBoYGU60c=
X-Google-Smtp-Source: APXvYqxHp7VhhyzeNDnrQQCZsAcNoKzAF1AriyX55Ijsd0g+arUfu3GNnCuin97MXjhzQOo05K6ARg==
X-Received: by 2002:ae9:f209:: with SMTP id m9mr11452571qkg.251.1562538920307;
        Sun, 07 Jul 2019 15:35:20 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/24] PM / devfreq: tegra30: Move clk-notifier's registration to governor's start
Date:   Mon,  8 Jul 2019 01:32:47 +0300
Message-Id: <20190707223303.6755-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
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
index 48a799fa5f63..d5d04c25023b 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -576,6 +576,19 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
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
 
@@ -602,6 +615,8 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
 
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
+
 	return err;
 }
 
@@ -618,6 +633,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
+
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -862,22 +879,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
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
@@ -893,9 +902,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_governor:
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
-
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
@@ -912,7 +918,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.22.0

