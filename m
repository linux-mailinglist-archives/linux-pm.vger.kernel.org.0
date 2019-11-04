Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE0EECE3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbfKDWBK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:01:10 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39040 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388187AbfKDWBK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id 195so13431602lfj.6;
        Mon, 04 Nov 2019 14:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTSoWegEEojY/0rzNbV3L5iathds+zVoar3/WKcCtmk=;
        b=QbdJAVhX7nZh3/EK5AdgeT89M2Fcgot2EArIUhRFqleku19Ewn5ZNoYZT2OC9fqy/K
         fz+hmHjK/xClFzLUXPJo5li83f2YB9xMJMOgqp5QvbWk0lolHXzaVuYp2I9MQlaV1+j9
         s0zOLBBcnBft1emukkCUV3UKf+qt/hn17MU2LlyQsuX+DU25A/CJwWvcnK6OCpzjNCur
         SDAnSAUFrcXqmdK+giQQDaKaoTjSU21rAbBUNf48FdxIJ245Jb1z/twhXocUiyWq5MFq
         /jz5pQ+PfjzMMcmfN9KD7dpcInax7qbh7I9gZTD+Y2kHLf9d3DUq/7AIWNE6VUVciLzm
         jx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTSoWegEEojY/0rzNbV3L5iathds+zVoar3/WKcCtmk=;
        b=NOVB04avUO6HJRoxXoNUuPIg+3GGJpLbVj1IuubzjtZvBwDQhMqc4WjhnEVUqCRiKt
         qEWMY9nVmuopyNnXnfW3R0lhio8pTXd8qfDwoNyvs04aeT5iymSEwR2iqk6mK5JYCo/X
         bIxcIpw6FWTKzd+fmMxLqZnlOu1xgQs813u+TMhtXjyzdYMX6p7q22emh7OEKe5Izn3J
         U0lJIBJthc5RLlQZjQ3qsP6l8Mto7PO1gz+XOxDfFFUzDtfokSPanuHidAcUTMm2gZgQ
         cvzbuFakbjD8RszqjOLBPZ7aUMIkkeQ2mK9JHLFFD7OOlZPbbmWMOBLJaLAZrQKGDYVl
         n+BA==
X-Gm-Message-State: APjAAAVrS0MxFeCxyBwa3V+rl0bpf98wAUnpnSYBDSZRsbEmC7KpTen2
        A6P06wVglVogUTMypNGR4IU=
X-Google-Smtp-Source: APXvYqzwNM2fcLYNL+RvNGwhxMCtGYZy/dKmH9Rn7ZGGpP5XWqeX49Rq0Nkvb/aspWr5ndJa+Oe5vg==
X-Received: by 2002:ac2:5dc1:: with SMTP id x1mr17745656lfq.177.1572904866101;
        Mon, 04 Nov 2019 14:01:06 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:05 -0800 (PST)
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
Subject: [PATCH v9 07/19] PM / devfreq: tegra30: Use CPUFreq notifier
Date:   Tue,  5 Nov 2019 00:56:05 +0300
Message-Id: <20191104215617.25544-8-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CPU's client need to take into account that CPUFreq may change
while memory activity not, staying high. Thus an appropriate frequency
notifier should be used in addition to the clk-notifier.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 180 +++++++++++++++++++++++++-----
 1 file changed, 155 insertions(+), 25 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 9ccde64be0a0..2d720e7e2236 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
+#include <linux/workqueue.h>
 
 #include "governor.h"
 
@@ -34,6 +35,8 @@
 #define ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN		BIT(30)
 #define ACTMON_DEV_CTRL_ENB					BIT(31)
 
+#define ACTMON_DEV_CTRL_STOP					0x00000000
+
 #define ACTMON_DEV_UPPER_WMARK					0x4
 #define ACTMON_DEV_LOWER_WMARK					0x8
 #define ACTMON_DEV_INIT_AVG					0xc
@@ -159,7 +162,10 @@ struct tegra_devfreq {
 	struct clk		*emc_clock;
 	unsigned long		max_freq;
 	unsigned long		cur_freq;
-	struct notifier_block	rate_change_nb;
+	struct notifier_block	clk_rate_change_nb;
+
+	struct delayed_work	cpufreq_update_work;
+	struct notifier_block	cpu_rate_change_nb;
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
 
@@ -303,22 +309,32 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
 	return 0;
 }
 
+static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
+					       struct tegra_devfreq_device *dev)
+{
+	unsigned int avg_sustain_coef;
+	unsigned long target_freq;
+
+	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
+	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
+	target_freq = do_percent(target_freq, avg_sustain_coef);
+	target_freq += dev->boost_freq;
+
+	return target_freq;
+}
+
 static void actmon_update_target(struct tegra_devfreq *tegra,
 				 struct tegra_devfreq_device *dev)
 {
 	unsigned long cpu_freq = 0;
 	unsigned long static_cpu_emc_freq = 0;
-	unsigned int avg_sustain_coef;
 
 	if (dev->config->avg_dependency_threshold) {
-		cpu_freq = cpufreq_get(0);
+		cpu_freq = cpufreq_quick_get(0);
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
 	}
 
-	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
-	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
-	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
-	dev->target_freq += dev->boost_freq;
+	dev->target_freq = actmon_device_target_freq(tegra, dev);
 
 	if (dev->avg_count >= dev->config->avg_dependency_threshold)
 		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
@@ -349,8 +365,8 @@ static irqreturn_t actmon_thread_isr(int irq, void *data)
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
-				       unsigned long action, void *ptr)
+static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
+				      unsigned long action, void *ptr)
 {
 	struct clk_notifier_data *data = ptr;
 	struct tegra_devfreq *tegra;
@@ -360,7 +376,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
 
-	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
+	tegra = container_of(nb, struct tegra_devfreq, clk_rate_change_nb);
 
 	tegra->cur_freq = data->new_rate / KHZ;
 
@@ -373,6 +389,79 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void tegra_actmon_delayed_update(struct work_struct *work)
+{
+	struct tegra_devfreq *tegra = container_of(work, struct tegra_devfreq,
+						   cpufreq_update_work.work);
+
+	mutex_lock(&tegra->devfreq->lock);
+	update_devfreq(tegra->devfreq);
+	mutex_unlock(&tegra->devfreq->lock);
+}
+
+static unsigned long
+tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
+				  unsigned int cpu_freq)
+{
+	unsigned long static_cpu_emc_freq, dev_freq;
+
+	/* check whether CPU's freq is taken into account at all */
+	if (tegra->devices[MCCPU].avg_count <
+	    tegra->devices[MCCPU].config->avg_dependency_threshold)
+		return 0;
+
+	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
+	dev_freq = actmon_device_target_freq(tegra, &tegra->devices[MCCPU]);
+
+	if (dev_freq >= static_cpu_emc_freq)
+		return 0;
+
+	return static_cpu_emc_freq;
+}
+
+static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
+				      unsigned long action, void *ptr)
+{
+	struct cpufreq_freqs *freqs = ptr;
+	struct tegra_devfreq *tegra;
+	unsigned long old, new, delay;
+
+	if (action != CPUFREQ_POSTCHANGE)
+		return NOTIFY_OK;
+
+	tegra = container_of(nb, struct tegra_devfreq, cpu_rate_change_nb);
+
+	/*
+	 * Quickly check whether CPU frequency should be taken into account
+	 * at all, without blocking CPUFreq's core.
+	 */
+	if (mutex_trylock(&tegra->devfreq->lock)) {
+		old = tegra_actmon_cpufreq_contribution(tegra, freqs->old);
+		new = tegra_actmon_cpufreq_contribution(tegra, freqs->new);
+		mutex_unlock(&tegra->devfreq->lock);
+
+		/*
+		 * If CPU's frequency shouldn't be taken into account at
+		 * the moment, then there is no need to update the devfreq's
+		 * state because ISR will re-check CPU's frequency on the
+		 * next interrupt.
+		 */
+		if (old == new)
+			return NOTIFY_OK;
+	}
+
+	/*
+	 * CPUFreq driver should support CPUFREQ_ASYNC_NOTIFICATION in order
+	 * to allow asynchronous notifications. This means we can't block
+	 * here for too long, otherwise CPUFreq's core will complain with a
+	 * warning splat.
+	 */
+	delay = msecs_to_jiffies(ACTMON_SAMPLING_PERIOD);
+	schedule_delayed_work(&tegra->cpufreq_update_work, delay);
+
+	return NOTIFY_OK;
+}
+
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
@@ -405,9 +494,22 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 	device_writel(dev, val, ACTMON_DEV_CTRL);
 }
 
-static void tegra_actmon_start(struct tegra_devfreq *tegra)
+static void tegra_actmon_stop_devices(struct tegra_devfreq *tegra)
+{
+	struct tegra_devfreq_device *dev = tegra->devices;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++, dev++) {
+		device_writel(dev, ACTMON_DEV_CTRL_STOP, ACTMON_DEV_CTRL);
+		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
+			      ACTMON_DEV_INTR_STATUS);
+	}
+}
+
+static int tegra_actmon_start(struct tegra_devfreq *tegra)
 {
 	unsigned int i;
+	int err;
 
 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
@@ -415,20 +517,41 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
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
+	tegra_actmon_stop_devices(tegra);
+
+	return err;
 }
 
 static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 {
-	unsigned int i;
-
 	disable_irq(tegra->irq);
 
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
-		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
-			      ACTMON_DEV_INTR_STATUS);
-	}
+	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+
+	cancel_delayed_work_sync(&tegra->cpufreq_update_work);
+
+	tegra_actmon_stop_devices(tegra);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -536,6 +659,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
+	int ret = 0;
 
 	/*
 	 * Couple devfreq-device with the governor early because it is
@@ -546,7 +670,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
-		tegra_actmon_start(tegra);
+		ret = tegra_actmon_start(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
@@ -561,11 +685,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
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
@@ -672,8 +796,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
-	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
-	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
+	tegra->cpu_rate_change_nb.notifier_call = tegra_actmon_cpu_notify_cb;
+
+	INIT_DELAYED_WORK(&tegra->cpufreq_update_work,
+			  tegra_actmon_delayed_update);
+
+	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
+	err = clk_notifier_register(tegra->emc_clock,
+				    &tegra->clk_rate_change_nb);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to register rate change notifier\n");
@@ -701,7 +831,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
 unreg_notifier:
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
@@ -719,7 +849,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
-- 
2.23.0

