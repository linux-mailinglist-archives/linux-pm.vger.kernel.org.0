Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F48EEEF0
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbfKDWBT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:01:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44166 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388932AbfKDWBT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id g3so13275877ljl.11;
        Mon, 04 Nov 2019 14:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVyypLWArLwRMapvcjjP++4okNfEsrnb9+mcTr4Flpc=;
        b=nIngTQUlQTRyU7ARgBuzQfHFolIxtzhXr0aLpOY4V7VOempJFhPd1fPk3ZnKlnEBWM
         9/juwJqdqdJOpWW6q7b/nlRyIEVStBUmsLbFl/C1QojE8z1NUYIJw1yjG8+9MEUxa1pd
         db3Sz4cSEi7LjO/ZL99/lwE9RThbvwo6/4w92uR5NjFd6Y0SHCMt7akWQTb0yd3s1bMt
         wfMcRT8Qw2jj6SPs70s/ptnXMxGAKJHTaXaQtethoFyEl0S9BRe9FsTNZNOTWv3sT739
         DnAC1VctXSN6Neg8wMJtW+7Vt0UBqQ2c1tpN8BhBDQRklpvxr7xb9JOOLRfuLZ343L7r
         c1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVyypLWArLwRMapvcjjP++4okNfEsrnb9+mcTr4Flpc=;
        b=hsOnYuBKDS4l/jX2wQUOGwC7RMHfRp8aaNtNXlLeZH5tWVran4rkYp4cf6VlDqTDU6
         3Ba2qLypmC9oLz5VkiC5158eIcsUPh6tmp/npg13hVSZ1Jm0zjIB61vCvpiIywR+/tyE
         LjwI+eajllHKOrg7Rw6tNjr+Qu2B2bU5gSSAGY6NnMUPmU9d5wh+8JJ05e8cL3HQ3nid
         z7u5zoWCmiBUf4E1Crxw03WnM+e4WaMLtCqQrk6/BEcRXuLJ1lGl8V0lDDvG7U6BMpxg
         jbH+MjqE+48neWpCKp/QBVe5WXJ0QB9SIc8Gj3pv5YqtYw4VZpUAI1MogHEHRsR81FUY
         jNbg==
X-Gm-Message-State: APjAAAVeZM++R7D3PykoHQDsSRIyESf4sIm9r5F9DgltA/wMZKaBtBnZ
        McAO7HO35Of8obb8hWzHfO4=
X-Google-Smtp-Source: APXvYqzS+RU1VFsp3K24na/Ur5f7fxpvKpLm/W/sjywk+cCqIvKy+rPUIRp/8bXx6WiTCnfFAJwZsQ==
X-Received: by 2002:a2e:7c16:: with SMTP id x22mr21064365ljc.94.1572904875747;
        Mon, 04 Nov 2019 14:01:15 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:15 -0800 (PST)
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
Subject: [PATCH v9 17/19] PM / devfreq: tegra30: Support variable polling interval
Date:   Tue,  5 Nov 2019 00:56:15 +0300
Message-Id: <20191104215617.25544-18-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
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
 drivers/devfreq/tegra30-devfreq.c | 78 ++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 3bd920829bfd..e44f1a48f838 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -171,6 +171,8 @@ struct tegra_devfreq {
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
 
 	unsigned int		irq;
+
+	bool			started;
 };
 
 struct tegra_actmon_emc_ratio {
@@ -209,18 +211,26 @@ static void device_writel(struct tegra_devfreq_device *dev, u32 val,
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
 					   struct tegra_devfreq_device *dev)
 {
-	u32 avg = dev->avg_count;
 	u32 avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
-	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
+	u32 band = avg_band_freq * tegra->devfreq->profile->polling_ms;
+	u32 avg;
 
+	avg = min(dev->avg_count, U32_MAX - band);
 	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
 
 	avg = max(dev->avg_count, band);
@@ -230,7 +240,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 				       struct tegra_devfreq_device *dev)
 {
-	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
+	u32 val = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
 
 	device_writel(dev, do_percent(val, dev->config->boost_up_threshold),
 		      ACTMON_DEV_UPPER_WMARK);
@@ -309,7 +319,7 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
 	unsigned int avg_sustain_coef;
 	unsigned long target_freq;
 
-	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
+	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
 	target_freq = do_percent(target_freq, avg_sustain_coef);
 
@@ -469,7 +479,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 
 	dev->target_freq = tegra->cur_freq;
 
-	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
+	dev->avg_count = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
 	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
 
 	tegra_devfreq_update_avg_wmark(tegra, dev);
@@ -505,12 +515,15 @@ static void tegra_actmon_stop_devices(struct tegra_devfreq *tegra)
 	}
 }
 
-static int tegra_actmon_start(struct tegra_devfreq *tegra)
+static int tegra_actmon_resume(struct tegra_devfreq *tegra)
 {
 	unsigned int i;
 	int err;
 
-	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
+	if (!tegra->devfreq->profile->polling_ms || !tegra->started)
+		return 0;
+
+	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
 
 	/*
@@ -558,8 +571,26 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	return err;
 }
 
-static void tegra_actmon_stop(struct tegra_devfreq *tegra)
+static int tegra_actmon_start(struct tegra_devfreq *tegra)
 {
+	int ret = 0;
+
+	if (!tegra->started) {
+		tegra->started = true;
+
+		ret = tegra_actmon_resume(tegra);
+		if (ret)
+			tegra->started = false;
+	}
+
+	return ret;
+}
+
+static void tegra_actmon_pause(struct tegra_devfreq *tegra)
+{
+	if (!tegra->devfreq->profile->polling_ms || !tegra->started)
+		return;
+
 	disable_irq(tegra->irq);
 
 	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
@@ -572,6 +603,12 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
 }
 
+static void tegra_actmon_stop(struct tegra_devfreq *tegra)
+{
+	tegra_actmon_pause(tegra);
+	tegra->started = false;
+}
+
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 				u32 flags)
 {
@@ -629,7 +666,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
+	stat->total_time = tegra->devfreq->profile->polling_ms * cur_freq;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
@@ -637,7 +674,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 }
 
 static struct devfreq_dev_profile tegra_devfreq_profile = {
-	.polling_ms	= 0,
+	.polling_ms	= ACTMON_SAMPLING_PERIOD,
 	.target		= tegra_devfreq_target,
 	.get_dev_status	= tegra_devfreq_get_dev_status,
 };
@@ -677,6 +714,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
+	unsigned int *new_delay = data;
 	int ret = 0;
 
 	/*
@@ -696,6 +734,21 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
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
+		tegra_actmon_pause(tegra);
+		devfreq_interval_update(devfreq, new_delay);
+		ret = tegra_actmon_resume(tegra);
+		break;
+
 	case DEVFREQ_GOV_SUSPEND:
 		tegra_actmon_stop(tegra);
 		devfreq_monitor_suspend(devfreq);
@@ -715,6 +768,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
 	.get_target_freq = tegra_governor_get_target,
 	.event_handler = tegra_governor_event_handler,
 	.immutable = true,
+	.interrupt_driven = true,
 };
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
-- 
2.23.0

