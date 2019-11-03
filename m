Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F68ED4CE
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfKCUmi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37119 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfKCUmU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so10705449lfp.4;
        Sun, 03 Nov 2019 12:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18S1MVXqny9x+sCJNqOJnxi2tr2EoDCFRpoSlwu8aY0=;
        b=ORk+5q+K9+p2eI7EFPqQi1rfxdvpYqV2Ql77LLJIoYaJgQProqKO38e0hMrGy0nnN5
         RfBujqkDudwFMMO3k2JkFOeXwzi1YVivk584Rwwdaiy0/bY3kxlqHT5s8su6gnwARRTM
         tNiXdeoLDimAQzKfv2a7qF/rBuN/X4jD9ww5SO/pOWMOQX+NJ/LCQS/Oa4BKBknAi6cf
         YlQn0s+gw3QY9sht9rO+on80cL9lWh6ICwAotAOq/ZB+be9j9V2i2kDMXkKgpCuZqbh/
         OXejBnMi8ipyqSksdobEGCgGnBWpeO5+Tva3jzTBegL2GL8dKu5OqzceMRmvXQyuGpeJ
         Zmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18S1MVXqny9x+sCJNqOJnxi2tr2EoDCFRpoSlwu8aY0=;
        b=eKKPlLuMbVn9CIEMTKjeQxPBc8WPHrYyijIuSiDNfNWXRdWaTXdBUqWB7d/AC2uBg5
         WijeOxZeG1PCJGAQw52GWiwgCBVRr7QbDh2VOC733uTkPmNnVevqoC3Xsuw/qrl1TE9K
         R2z9NtvypqT6BdB3ezHUTBnO03SaFoCtH2e6EChAXsW4GcDTIvw/L9ale2ohAsXeq8A+
         Vzaq0vLickdw/SGi3xgvzMiOJH8R5HakEgH7f1AbG7OfkQ74TauFZBKgUvyS6u6Piw2d
         uHf6d51P/lF/7OK4qmcHKHzYwVxzLDMe+LJRgq1CfnFi9TJRGRvPopjnpVIWK2Vyof1T
         0fng==
X-Gm-Message-State: APjAAAXOwiuRMctT6dq/e7MQnqo1dREDO8RWVQ7zVgaZHXiyHmwZ9c26
        Od6VnYtm+0Uyg3DfU7hdnKs=
X-Google-Smtp-Source: APXvYqzPYt3BB/dSb8hMBNlUovU7+aunT5IMuHxsZKrZDYw52V6tptyh4iK9E2TRqQg+fYKzjiZEug==
X-Received: by 2002:ac2:5b47:: with SMTP id i7mr14133366lfp.82.1572813737838;
        Sun, 03 Nov 2019 12:42:17 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:17 -0800 (PST)
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
Subject: [PATCH v8 16/18] PM / devfreq: tegra30: Support variable polling interval
Date:   Sun,  3 Nov 2019 23:41:28 +0300
Message-Id: <20191103204130.2172-17-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ACTMON governor is interrupt-driven and currently hardware's polling
interval is fixed to 16ms in the driver. Devfreq supports variable polling
interval by the generic governors, let's re-use the generic interface for
changing of the polling interval. Now the polling interval can be changed
dynamically via /sys/class/devfreq/devfreq0/polling_interval.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 83 +++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 22 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 852bde6249c7..9c645e83ef8b 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -96,9 +96,10 @@ struct tegra_devfreq_device_config {
 	unsigned int	boost_down_threshold;
 
 	/*
-	 * Threshold of activity (cycles) below which the CPU frequency isn't
-	 * to be taken into account. This is to avoid increasing the EMC
-	 * frequency when the CPU is very busy but not accessing the bus often.
+	 * Threshold of activity (cycles translated to kHz) below which the
+	 * CPU frequency isn't to be taken into account. This is to avoid
+	 * increasing the EMC frequency when the CPU is very busy but not
+	 * accessing the bus often.
 	 */
 	u32		avg_dependency_threshold;
 };
@@ -126,7 +127,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.boost_down_coeff = 90,
 		.boost_up_threshold = 27,
 		.boost_down_threshold = 10,
-		.avg_dependency_threshold = 50000,
+		.avg_dependency_threshold = 5 * KHZ,
 	},
 };
 
@@ -208,9 +209,16 @@ static void device_writel(struct tegra_devfreq_device *dev, u32 val,
 	writel_relaxed(val, dev->regs + offset);
 }
 
-static unsigned long do_percent(unsigned long val, unsigned int pct)
+static unsigned long do_percent(unsigned long long val, unsigned int pct)
 {
-	return val * pct / 100;
+	val = val * pct;
+	do_div(val, 100);
+
+	/*
+	 * High freq + high boosting percent + large polling interval are
+	 * resulting in integer overflow when watermarks are calculated.
+	 */
+	return min_t(u64, val, U32_MAX);
 }
 
 static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
@@ -218,8 +226,9 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 {
 	u32 avg = dev->avg_count;
 	u32 avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
-	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
+	u32 band = avg_band_freq * tegra->devfreq->profile->polling_ms;
 
+	avg = min(dev->avg_count, U32_MAX - band);
 	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
 
 	avg = max(dev->avg_count, band);
@@ -229,7 +238,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 				       struct tegra_devfreq_device *dev)
 {
-	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
+	u32 val = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
 
 	device_writel(dev, do_percent(val, dev->config->boost_up_threshold),
 		      ACTMON_DEV_UPPER_WMARK);
@@ -308,10 +317,9 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
 	unsigned int avg_sustain_coef;
 	unsigned long target_freq;
 
-	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
+	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
 	target_freq = do_percent(target_freq, avg_sustain_coef);
-	target_freq += dev->boost_freq;
 
 	return target_freq;
 }
@@ -322,15 +330,18 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 	unsigned long cpu_freq = 0;
 	unsigned long static_cpu_emc_freq = 0;
 
-	if (dev->config->avg_dependency_threshold) {
+	dev->target_freq = actmon_device_target_freq(tegra, dev);
+
+	if (dev->config->avg_dependency_threshold &&
+	    dev->config->avg_dependency_threshold <= dev->target_freq) {
 		cpu_freq = cpufreq_quick_get(0);
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
-	}
 
-	dev->target_freq = actmon_device_target_freq(tegra, dev);
-
-	if (dev->avg_count >= dev->config->avg_dependency_threshold)
+		dev->target_freq += dev->boost_freq;
 		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
+	} else {
+		dev->target_freq += dev->boost_freq;
+	}
 }
 
 static irqreturn_t actmon_thread_isr(int irq, void *data)
@@ -396,15 +407,16 @@ static unsigned long
 tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
 				  unsigned int cpu_freq)
 {
+	struct tegra_devfreq_device *dev = &tegra->devices[MCCPU];
 	unsigned long static_cpu_emc_freq, dev_freq;
 
+	dev_freq = actmon_device_target_freq(tegra, dev);
+
 	/* check whether CPU's freq is taken into account at all */
-	if (tegra->devices[MCCPU].avg_count <
-	    tegra->devices[MCCPU].config->avg_dependency_threshold)
+	if (dev_freq < dev->config->avg_dependency_threshold)
 		return 0;
 
 	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
-	dev_freq = actmon_device_target_freq(tegra, &tegra->devices[MCCPU]);
 
 	if (dev_freq >= static_cpu_emc_freq)
 		return 0;
@@ -465,7 +477,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 
 	dev->target_freq = tegra->cur_freq;
 
-	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
+	dev->avg_count = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
 	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
 
 	tegra_devfreq_update_avg_wmark(tegra, dev);
@@ -506,7 +518,10 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	unsigned int i;
 	int err;
 
-	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
+	if (!tegra->devfreq->profile->polling_ms || tegra->cur_freq)
+		return 0;
+
+	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
 
 	/*
@@ -551,11 +566,16 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 
+	tegra->cur_freq = 0;
+
 	return err;
 }
 
 static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 {
+	if (!tegra->devfreq->profile->polling_ms || !tegra->cur_freq)
+		return;
+
 	disable_irq(tegra->irq);
 
 	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
@@ -566,6 +586,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 	tegra_actmon_stop_devices(tegra);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
+
+	tegra->cur_freq = 0;
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -625,7 +647,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
+	stat->total_time = tegra->devfreq->profile->polling_ms * cur_freq;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
@@ -633,7 +655,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 }
 
 static struct devfreq_dev_profile tegra_devfreq_profile = {
-	.polling_ms	= 0,
+	.polling_ms	= ACTMON_SAMPLING_PERIOD,
 	.target		= tegra_devfreq_target,
 	.get_dev_status	= tegra_devfreq_get_dev_status,
 };
@@ -673,6 +695,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
+	unsigned int *new_delay = data;
 	int ret = 0;
 
 	/*
@@ -692,6 +715,21 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 		devfreq_monitor_stop(devfreq);
 		break;
 
+	case DEVFREQ_GOV_INTERVAL:
+		/*
+		 * ACTMON hardware supports up to 256 milliseconds for the
+		 * sampling period.
+		 */
+		if (*new_delay > 256) {
+			ret = -EINVAL;
+			break;
+		}
+
+		tegra_actmon_stop(tegra);
+		devfreq_interval_update(devfreq, new_delay);
+		ret = tegra_actmon_start(tegra);
+		break;
+
 	case DEVFREQ_GOV_SUSPEND:
 		tegra_actmon_stop(tegra);
 		devfreq_monitor_suspend(devfreq);
@@ -711,6 +749,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
 	.get_target_freq = tegra_governor_get_target,
 	.event_handler = tegra_governor_event_handler,
 	.immutable = true,
+	.interrupt_driven = true,
 };
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
-- 
2.23.0

