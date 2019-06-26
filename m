Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2661655DB8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFZBf7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38815 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFZBfH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id b11so366462lfa.5;
        Tue, 25 Jun 2019 18:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMrqyA3dVoAUmu6/xP6uwJ3H5zVMfGxQwAxV4fMeRwc=;
        b=K4d5KgVinNO7et21nvIYMFzhKBqUhPWvQvHMQ81yZdOi4iKqyzzuo43yt/3Uj6EN15
         /gNUyFxF61KiSP2NZ4fLCAhdXaP/DgFY//1kAQUDymyQDgUxRFcE+ZqKPsG8eM4Ra3jr
         mN/Tvib54V1BkMk8I+Seu1E0vLwhGcvQDws5lvXMpg7QyEVR5JttAeBbpnWl5jVaJqAQ
         Fbw3DsSYUiUltlfnQG3j1FJmVN7V036k1rkaTFHcAioZ0Qhuvagw2fpL/1+N7Q6UuA+8
         QaV1RASQpD6UNspOkGGOCBZTl5SR4051O32EeOQZgVJ0fdAPxMS+77/ZqjCG2hz6Z5nl
         +kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMrqyA3dVoAUmu6/xP6uwJ3H5zVMfGxQwAxV4fMeRwc=;
        b=Vnq1K+BUjIZ6YS6bY2wK4H6et/6XDNoVMcJ6LtL7Hb7oLWb6dqGEz5F/g7etzMhTjj
         17WmeSq6e7ikSEUGjYtDlHNDBUZIHqa1DiF/UP+GJJWErdrknSsOKBo7xZGg2w0iTK5s
         rMLRz669CltKdYu6Wrf+WyNtOEhskhoFjE7Nnz3kYZdwTFs4N23rakI5gFxtIdj4ksWi
         zHqv/HlYsX08j8n+NLOu2bBXkhcJH+jguI0enfZIG+88iRATRoTFNxclVp6NtULkCv1X
         TNnAo5XcN2rzfmyQSI5WZWPcqW4pnJb4eaIFrznZwzUkjtzN0ljaAVMbqFz+ym8qDdiz
         jMaA==
X-Gm-Message-State: APjAAAWKQyAlBKwnl3gvqqvQU7TV1Ms6tKSqGTe63sS4qWFV7ooy5u00
        rT84AmGY5aJYEyFQS6pDmg8=
X-Google-Smtp-Source: APXvYqySCRWaoWHOvauaJ+7uXDruKOKdEVze4i+/RgchKVL4LBL8PkVxvwig19vtlQ4ZgGa59fVwaA==
X-Received: by 2002:a19:8116:: with SMTP id c22mr864971lfd.111.1561512903979;
        Tue, 25 Jun 2019 18:35:03 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/17] PM / devfreq: tegra30: Use CPUFreq notifier
Date:   Wed, 26 Jun 2019 04:32:41 +0300
Message-Id: <20190626013252.30470-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CPU's client need to take into account that CPUFreq may change
while memory activity not, staying high. Thus an appropriate frequency
notifier should be used in addition to the clk-notifier.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 105 +++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 9b172e2acd40..a2cae8348dce 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
+#include <linux/workqueue.h>
 
 #include "governor.h"
 
@@ -154,7 +155,10 @@ struct tegra_devfreq {
 
 	struct clk		*emc_clock;
 	unsigned long		max_freq;
-	struct notifier_block	rate_change_nb;
+	struct notifier_block	clk_rate_change_nb;
+
+	struct work_struct	update_work;
+	struct notifier_block	cpu_rate_change_nb;
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
 
@@ -454,8 +458,8 @@ static irqreturn_t actmon_thread_isr(int irq, void *data)
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
-				       unsigned long action, void *ptr)
+static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
+				      unsigned long action, void *ptr)
 {
 	struct clk_notifier_data *data = ptr;
 	struct tegra_devfreq_device *dev;
@@ -465,7 +469,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
 
-	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
+	tegra = container_of(nb, struct tegra_devfreq, clk_rate_change_nb);
 
 	/*
 	 * EMC rate could change due to three reasons:
@@ -494,6 +498,37 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void tegra_actmon_delayed_update(struct work_struct *work)
+{
+	struct tegra_devfreq *tegra = container_of(work, struct tegra_devfreq,
+						   update_work);
+
+	mutex_lock(&tegra->devfreq->lock);
+	update_devfreq(tegra->devfreq);
+	mutex_unlock(&tegra->devfreq->lock);
+}
+
+static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
+				      unsigned long action, void *ptr)
+{
+	struct tegra_devfreq *tegra;
+
+	if (action != CPUFREQ_POSTCHANGE)
+		return NOTIFY_OK;
+
+	tegra = container_of(nb, struct tegra_devfreq, cpu_rate_change_nb);
+
+	/*
+	 * CPUFreq driver should support CPUFREQ_ASYNC_NOTIFICATIO in order
+	 * to allow asynchronous notifications. This means we can't block
+	 * here for too long, otherwise CPUFreq core will complain with a
+	 * warning splat.
+	 */
+	schedule_work(&tegra->update_work);
+
+	return NOTIFY_OK;
+}
+
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
@@ -525,9 +560,16 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 	device_writel(dev, val, ACTMON_DEV_CTRL);
 }
 
-static void tegra_actmon_start(struct tegra_devfreq *tegra)
+static void tegra_actmon_stop_device(struct tegra_devfreq_device *dev)
+{
+	device_writel(dev, 0x00000000, ACTMON_DEV_CTRL);
+	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
+}
+
+static int tegra_actmon_start(struct tegra_devfreq *tegra)
 {
 	unsigned int i;
+	int err;
 
 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
@@ -535,7 +577,30 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
+	/*
+	 * We are estimating CPU's memory bandwidth requirement based on
+	 * amount of memory accesses and system's load, judging by CPU's
+	 * frequency. We also don't want to receive events about CPU's
+	 * frequency transaction when governor is stopped, hence notifier
+	 * is registered dynamically.
+	 */
+	err = cpufreq_register_notifier(&tegra->cpu_rate_change_nb,
+					CPUFREQ_TRANSITION_NOTIFIER);
+	if (err) {
+		dev_err(tegra->devfreq->dev.parent,
+			"Failed to register rate change notifier: %d\n", err);
+		goto err_stop;
+	}
+
 	enable_irq(tegra->irq);
+
+	return 0;
+
+err_stop:
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		tegra_actmon_stop_device(&tegra->devices[i]);
+
+	return err;
 }
 
 static void tegra_actmon_stop(struct tegra_devfreq *tegra)
@@ -544,11 +609,13 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
 	disable_irq(tegra->irq);
 
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
-		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
-			      ACTMON_DEV_INTR_STATUS);
-	}
+	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+
+	cancel_work_sync(&tegra->update_work);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		tegra_actmon_stop_device(&tegra->devices[i]);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -657,6 +724,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
+	int ret = 0;
 
 	/*
 	 * Couple device with the governor early as it is needed at
@@ -667,7 +735,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
-		tegra_actmon_start(tegra);
+		ret = tegra_actmon_start(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
@@ -682,11 +750,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 	case DEVFREQ_GOV_RESUME:
 		devfreq_monitor_resume(devfreq);
-		tegra_actmon_start(tegra);
+		ret = tegra_actmon_start(tegra);
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct devfreq_governor tegra_devfreq_governor = {
@@ -792,9 +860,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
-	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
+	tegra->cpu_rate_change_nb.notifier_call = tegra_actmon_cpu_notify_cb;
+	INIT_WORK(&tegra->update_work, tegra_actmon_delayed_update);
+
+	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
 	err = clk_notifier_register(tegra->emc_clock,
-				    &tegra->rate_change_nb);
+				    &tegra->clk_rate_change_nb);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to register rate change notifier\n");
@@ -821,7 +892,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
 unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
@@ -839,7 +910,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.22.0

