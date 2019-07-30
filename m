Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1989E7ADA3
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbfG3Qcr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54367 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732917AbfG3Qcp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so57746940wme.4;
        Tue, 30 Jul 2019 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYF3Rqm4TqMv387u1JVvYrQ9Rm4YuzrDkdXu+uqilyI=;
        b=KS+e420+NAu/dA7XB01CZop138T8v8ZzBqAG2nsZlEVYlOZZbIUuQ9PgtmVM+8O7qN
         Ij4zZ9czjaP0LVOdlYcjxHhnWBHqSjoK8RXV7zBkIdtslqV4d6t35Ixo0BtiXCTX1MJc
         fF9L4DaPRZEPsZ7OPiyuU86xPYf71Xr+Uq+7RU+Vetc4+naBARLo7tXi7d2vd33XY81b
         U4jod+KIowK1nyKOh9PRW3fp8FSKZ84W5ItdSYmByHDMywviSbdz5j7KAsMgOgEJNUNC
         +QT/bc3Lvzu5Ly+mPhiUM+p/T+xqxBmzdZE04YonfbVA0Awv2C9ITRzxBtpcArvdpwqd
         nsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYF3Rqm4TqMv387u1JVvYrQ9Rm4YuzrDkdXu+uqilyI=;
        b=mlpW6gVs0o9aEXwCl0rV+vachVVX+QDOjBCaM7or2oMk+colXDNqA9XQYfYtQH1EPq
         ddgCP4XiSXgAG6un7qJC/ZD80OI9mOdNdcclEwgSzsClngxc8245xiP0tNxDWNbCulsW
         rXWXGk+ZjdEDTfKOAIPRiZbn3cJdHHoKgPnaQkgNxUCabnnyQ2GNKu/JkfyDLa0qeuP8
         qDiqYlr4eqEuna2c9f1bXRvP9GpK2jxasPmFPSCYuOoej8Hg/H8/4CG9Ajy5y1omwU3u
         eX3q+jHbuQdZbbEgoA4DJi0uretai2cxkVmbM7B2vWnseSZOL8CRPbwtwIvrNcxPwfaw
         1MZQ==
X-Gm-Message-State: APjAAAUXXxjccfB3a14Ft60RC7JhmxiW5jkiNY+BxV9LnEWKfKL9BrgS
        yxHXSIrUaa9TUJ+bmxYJv+Y=
X-Google-Smtp-Source: APXvYqyPRW+Jojt4iy78Skxns5lXBELJz+XeZ2TxYpXSmBSpylqCOUIWGxrnrc9douRXk6dolQpfZg==
X-Received: by 2002:a1c:9e90:: with SMTP id h138mr109721512wme.67.1564504363244;
        Tue, 30 Jul 2019 09:32:43 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 19/20] PM / devfreq: tegra30: Support variable polling interval
Date:   Tue, 30 Jul 2019 19:22:35 +0300
Message-Id: <20190730162236.6063-20-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
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
 drivers/devfreq/tegra30-devfreq.c | 71 ++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 8adc0ff48b45..e30314bd571a 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -236,7 +237,7 @@ tegra_actmon_dev_avg_dependency_freq(struct tegra_devfreq *tegra,
 				     struct tegra_devfreq_device *dev)
 {
 	return dev->config->avg_dependency_threshold /
-		ACTMON_SAMPLING_PERIOD;
+		tegra->devfreq->profile->polling_ms;
 }
 
 static unsigned long
@@ -314,8 +315,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 	 */
 	*upper = tegra_actmon_account_cpu_freq(tegra, dev, *upper);
 
-	*lower *= ACTMON_SAMPLING_PERIOD;
-	*upper *= ACTMON_SAMPLING_PERIOD;
+	*lower *= tegra->devfreq->profile->polling_ms;
+	*upper *= tegra->devfreq->profile->polling_ms;
 }
 
 static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
@@ -341,8 +342,8 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 	 * result, but this one is probably the least churning, although
 	 * it may look a bit convoluted.
 	 */
-	if (freq * ACTMON_SAMPLING_PERIOD > upper)
-		upper = freq * ACTMON_SAMPLING_PERIOD;
+	if (freq * tegra->devfreq->profile->polling_ms > upper)
+		upper = freq * tegra->devfreq->profile->polling_ms;
 
 	/*
 	 * We want to get interrupts when MCCPU client crosses the
@@ -420,7 +421,7 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
 
-	dev->avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
+	dev->avg_freq = avg_count / tegra->devfreq->profile->polling_ms;
 
 	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
 			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
@@ -499,7 +500,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
 	 * outdated.
 	 */
 	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
-	avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
+	avg_freq = avg_count / tegra->devfreq->profile->polling_ms;
 
 	old_upper = tegra_actmon_upper_freq(tegra, dev->avg_freq);
 	new_upper = tegra_actmon_upper_freq(tegra, avg_freq);
@@ -675,7 +676,7 @@ static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
 	 * here for too long, otherwise CPUFreq's core will complain with a
 	 * warning splat.
 	 */
-	delay = msecs_to_jiffies(ACTMON_SAMPLING_PERIOD);
+	delay = msecs_to_jiffies(tegra->devfreq->profile->polling_ms);
 	schedule_delayed_work(&tegra->cpufreq_update_work, delay);
 
 	return NOTIFY_OK;
@@ -690,7 +691,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 	dev->boost_freq = 0;
 
 	dev->avg_freq = clk_get_rate(tegra->emc_clock) / KHZ;
-	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
+	device_writel(dev, dev->avg_freq * tegra->devfreq->profile->polling_ms,
 		      ACTMON_DEV_INIT_AVG);
 
 	tegra_devfreq_update_avg_wmark(tegra, dev, dev->avg_freq);
@@ -725,7 +726,14 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
 	unsigned int i;
 	int err;
 
-	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
+	if (!tegra->devfreq->stop_polling)
+		return 0;
+
+	tegra->devfreq->previous_freq = clk_get_rate(tegra->emc_clock) / KHZ;
+	tegra->devfreq->last_stat_updated = jiffies;
+	tegra->devfreq->stop_polling = false;
+
+	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
 
 	/*
@@ -776,6 +784,11 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 {
 	unsigned int i;
 
+	if (tegra->devfreq->stop_polling)
+		return;
+
+	mutex_unlock(&tegra->devfreq->lock);
+
 	disable_irq(tegra->irq);
 
 	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
@@ -783,10 +796,16 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 
 	cancel_delayed_work_sync(&tegra->cpufreq_update_work);
 
+	mutex_lock(&tegra->devfreq->lock);
+
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_stop_device(&tegra->devices[i]);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
+
+	devfreq_update_status(tegra->devfreq, tegra->devfreq->previous_freq);
+
+	tegra->devfreq->stop_polling = true;
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -846,7 +865,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = cur_freq * ACTMON_SAMPLING_PERIOD;
+	stat->total_time = cur_freq * tegra->devfreq->profile->polling_ms;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
@@ -854,7 +873,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 }
 
 static struct devfreq_dev_profile tegra_devfreq_profile = {
-	.polling_ms	= 0,
+	.polling_ms	= ACTMON_SAMPLING_PERIOD,
 	.target		= tegra_devfreq_target,
 	.get_dev_status	= tegra_devfreq_get_dev_status,
 };
@@ -895,8 +914,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
+	unsigned int new_delay, *delay_ptr = data;
 	int ret = 0;
 
+	mutex_lock(&devfreq->lock);
+
 	/*
 	 * Couple device with the governor early as it is needed at
 	 * the moment of governor's start (used by ISR).
@@ -905,26 +927,33 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 	switch (event) {
 	case DEVFREQ_GOV_START:
-		devfreq_monitor_start(devfreq);
+		devfreq->stop_polling = true;
+		/* fall through */
+	case DEVFREQ_GOV_RESUME:
 		ret = tegra_actmon_start(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
-		tegra_actmon_stop(tegra);
-		devfreq_monitor_stop(devfreq);
-		break;
-
+		/* fall through */
 	case DEVFREQ_GOV_SUSPEND:
 		tegra_actmon_stop(tegra);
-		devfreq_monitor_suspend(devfreq);
 		break;
 
-	case DEVFREQ_GOV_RESUME:
-		devfreq_monitor_resume(devfreq);
-		ret = tegra_actmon_start(tegra);
+	case DEVFREQ_GOV_INTERVAL:
+		new_delay = *delay_ptr;
+
+		if (!new_delay || new_delay > 256) {
+			ret = -EINVAL;
+		} else {
+			tegra_actmon_stop(tegra);
+			devfreq->profile->polling_ms = new_delay;
+			ret = tegra_actmon_start(tegra);
+		}
 		break;
 	}
 
+	mutex_unlock(&devfreq->lock);
+
 	return ret;
 }
 
-- 
2.22.0

