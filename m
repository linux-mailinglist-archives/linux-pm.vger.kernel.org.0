Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538BAE9297
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfJ2WG3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34535 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbfJ2WG3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id 139so376071ljf.1;
        Tue, 29 Oct 2019 15:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9nv631nFuLy5OJibO3p1uW2P7i1XSSankw4lPH7rnQ=;
        b=JfAa04wg4G8CI5e5eM72nVTogB/eZpxAQd2plw8wQ1xf9Rfzyv+VYYL8PKe/KNvPGR
         WMT4ziDQle0g3iD6zta3MaFA6FBhGxnAh082t3DGY5Z/iZ2b+zWXD1KvdUDHFyTo3+eo
         Urp6pw6LfL21IBvcyUxvDxhZ8UdmiNAfcBB/V65xcPcZXQ81Z/f5ajd91YIgtd5FBoRb
         BGsmj3WK3NYqIAzIopHCrjeHtXqdSiCB2wpWPDRNgoIeMo9YUOr8qK4FC/CCW/WI//JF
         5cua0hw+1q0X9uR6uzpH7ugjDcWZNDoilsPgtjX12UegQN+S2jB/84OvcTc9ZbUx5EWi
         zMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9nv631nFuLy5OJibO3p1uW2P7i1XSSankw4lPH7rnQ=;
        b=QsgB4/vd4Koe37xvVdYM88GVv94lv53DGt+05p5yzgnQ8Lbr8kIkoFhbzQRRi6RJ8P
         mDGESXKLbalGHFptTHWz5PvhlphwX+4NxenU7g0+UyCV5XjU0Y6dx9bURXbk1MYH5kJ3
         T40HGZF0WxzQuzuTMqyxYXqht+K9zEJkeEFxLdG75nALdobzkBPgCdiGRyCRnuHdr0NB
         sp7ovtTPb0/w+Bbu0a6bbmDtIf3k24uOy6FQKm8QmXRPnF8iGUU1xC+YBefZAO51Ishp
         GaAxO/wt6rXK5dXkfiU8ia7MHuzLwxaRYRFNizlGly5S3gVI1tL2Z7QHXUH2JIK6u9gO
         at3w==
X-Gm-Message-State: APjAAAW905YIjEvrZB6dz3w/suabAz5SMEZtACh7zE+bW0BKm0nVemcI
        VBJh398ku0uhMs/Ls3cQqXY=
X-Google-Smtp-Source: APXvYqxWQ2y+0houpulghTFa8uMZXHz2Ku3ouH0/FDPZ4X7HuKeVuH1EfxK6mHFSNTY4WUCzeYoezw==
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr4057544ljg.178.1572386786709;
        Tue, 29 Oct 2019 15:06:26 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:26 -0700 (PDT)
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
Subject: [PATCH v7 17/19] PM / devfreq: tegra30: Support variable polling interval
Date:   Wed, 30 Oct 2019 01:00:17 +0300
Message-Id: <20191029220019.26773-18-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
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
 drivers/devfreq/tegra30-devfreq.c | 35 ++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index b745a973c35a..d0dd42856e5b 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -218,7 +218,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 {
 	u32 avg = dev->avg_count;
 	u32 avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
-	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
+	u32 band = avg_band_freq * tegra->devfreq->profile->polling_ms;
 
 	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
 
@@ -229,7 +229,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 				       struct tegra_devfreq_device *dev)
 {
-	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
+	u32 val = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
 
 	device_writel(dev, do_percent(val, dev->config->boost_up_threshold),
 		      ACTMON_DEV_UPPER_WMARK);
@@ -308,7 +308,7 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
 	unsigned int avg_sustain_coef;
 	unsigned long target_freq;
 
-	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
+	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
 	target_freq = do_percent(target_freq, avg_sustain_coef);
 	target_freq += dev->boost_freq;
@@ -465,7 +465,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 
 	dev->target_freq = tegra->cur_freq;
 
-	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
+	dev->avg_count = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
 	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
 
 	tegra_devfreq_update_avg_wmark(tegra, dev);
@@ -506,7 +506,11 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	unsigned int i;
 	int err;
 
-	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
+	if (!tegra->devfreq->profile->polling_ms ||
+	    tegra->devfreq->stop_polling)
+		return 0;
+
+	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
 
 	/*
@@ -554,6 +558,10 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 
 static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 {
+	if (!tegra->devfreq->profile->polling_ms ||
+	    tegra->devfreq->stop_polling)
+		return;
+
 	disable_irq(tegra->irq);
 
 	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
@@ -623,7 +631,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
+	stat->total_time = tegra->devfreq->profile->polling_ms * cur_freq;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
@@ -631,7 +639,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 }
 
 static struct devfreq_dev_profile tegra_devfreq_profile = {
-	.polling_ms	= 0,
+	.polling_ms	= ACTMON_SAMPLING_PERIOD,
 	.target		= tegra_devfreq_target,
 	.get_dev_status	= tegra_devfreq_get_dev_status,
 };
@@ -671,6 +679,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
+	unsigned int *new_delay = data;
 	int ret = 0;
 
 	/*
@@ -690,6 +699,17 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 		devfreq_monitor_stop(devfreq);
 		break;
 
+	case DEVFREQ_GOV_INTERVAL:
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
@@ -709,6 +729,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
 	.get_target_freq = tegra_governor_get_target,
 	.event_handler = tegra_governor_event_handler,
 	.immutable = true,
+	.interrupt_driven = true,
 };
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
-- 
2.23.0

