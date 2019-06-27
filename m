Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F045258C99
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfF0VMn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:12:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36154 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfF0VMn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so3821198ljj.3;
        Thu, 27 Jun 2019 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G76qvKaetWsSadt4nJNkJSbuj0AsUyOJi+e4NJP6r3w=;
        b=hP0ZEPCVuyZhwjJbFhEBVUxJD+fpx6vFDNLFdNRsIbA/oMeX9bJLbcS9qOq6lCBeu7
         iYIJPRNUeQyZxmJjWGVZkGZkPtUcKhcg+5OCfyReF9di7xbWAbIbO1KjAVERMJP6KhX2
         QT6VVd8KeahKkKHX/p8wZ62oX/keGRRXO31fbYFs+tCg0mxOg6SZ9WiKLqdi6VimE40O
         HnXqoAkDtrv14uMkKPwZLBiqKmkh5EsdowG/4k3xCU+IsndB7/6IrSArBLPg5U0q7SDl
         G9EfCT6EaX3xL77E21/rwyiHWfCbCYYxyRZv1AsmORrUruCpGmlPfu0RFpGPPxYEf3qf
         BDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G76qvKaetWsSadt4nJNkJSbuj0AsUyOJi+e4NJP6r3w=;
        b=gv6zzAkUVps0O2MKxA9BRVyJF/vC1cFYbSRJ/3M+im3kcgAx2wjuFA3swZ+QKr/1GE
         XldL3UaReQkYcZF0R6Nhk7UF8tP0xMGAP7einrGe181EeuQnGJqzTs6UirpAyo0QkfFc
         8J2QR6R/JF1VQfFPsij6ySTaYKk+tFeQh1kZT8T3LxBiObE6rhd9HTRa88cz9eiFVOcH
         fDz+pGQiizDHu+SB6ZF4P9rQVqtGvZdSZZV7SmKCN41fmCNBnlY6ySNPTBkzUwDzdxCg
         SaPDQjgRtrwWe0oL0gpHDX5jnmBQMh/VUrO+QKNfjw50KISvEewRhuxlb0btaRbMXwy2
         mkWw==
X-Gm-Message-State: APjAAAWQdEP8Zi6sJX68w4cKQh4/kPAMg2JcCQ+BYo451eCisW8rAeB4
        NOvzxIYSS3gE3GGGtR7BIkA=
X-Google-Smtp-Source: APXvYqy122tCoxzZ7XlbZeYVamdQIWTse/74dutrkOduiZT7GVjv+NeA5oMT9nwIUTLphb8YsTlm4Q==
X-Received: by 2002:a2e:9158:: with SMTP id q24mr4002017ljg.119.1561669960088;
        Thu, 27 Jun 2019 14:12:40 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/22] PM / devfreq: tegra30: Use kHz units uniformly in the code
Date:   Fri, 28 Jun 2019 00:11:09 +0300
Message-Id: <20190627211115.21138-17-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that all kHz-conversion related bugs are fixed, we can use the kHz
uniformly. This makes code cleaner and avoids integer divisions in the
code, which is useful in a case of Tegra30 that has Cortex A9 CPU that
doesn't support integer division instructions, hence all divisions are
actually made in software mode. Another small benefit from this change
is that now powertop utility correctly displays devfreq's stats, for
some reason it expects them to be in kHz.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 78 +++++++++++++++++--------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 9a6ede689991..61d9601766fc 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -72,6 +72,8 @@
 
 #define KHZ							1000
 
+#define KHZ_MAX						(ULONG_MAX / KHZ)
+
 /* Assume that the bus is saturated if the utilization is 25% */
 #define BUS_SATURATION_RATIO					25
 
@@ -124,7 +126,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.boost_down_coeff = 90,
 		.boost_up_threshold = 27,
 		.boost_down_threshold = 10,
-		.avg_dependency_threshold = 50000,
+		.avg_dependency_threshold = 50000 / ACTMON_SAMPLING_PERIOD,
 	},
 };
 
@@ -137,8 +139,11 @@ struct tegra_devfreq_device {
 	const struct tegra_devfreq_device_config *config;
 	void __iomem *regs;
 
-	/* Average event count sampled in the last interrupt */
-	u32 avg_count;
+	/*
+	 * Average event count sampled in the last interrupt and converted
+	 * to frequency value.
+	 */
+	u32 avg_freq;
 
 	/*
 	 * Extra frequency to increase the target by due to consecutive
@@ -172,7 +177,7 @@ struct tegra_actmon_emc_ratio {
 };
 
 static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000, ULONG_MAX / KHZ },
+	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
 	{ 1000000,    500000 },
@@ -234,7 +239,7 @@ tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
 	unsigned long static_cpu_emc_freq;
 
 	if (dev->config->avg_dependency_threshold &&
-	    dev->config->avg_dependency_threshold < dev->avg_count) {
+	    dev->config->avg_dependency_threshold < dev->avg_freq) {
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
 		target_freq = max(target_freq, static_cpu_emc_freq);
 	}
@@ -265,7 +270,7 @@ static unsigned long tegra_actmon_upper_freq(struct tegra_devfreq *tegra,
 
 	opp = dev_pm_opp_find_freq_ceil(tegra->devfreq->dev.parent, &upper);
 	if (IS_ERR(opp))
-		upper = ULONG_MAX;
+		upper = KHZ_MAX;
 	else
 		dev_pm_opp_put(opp);
 
@@ -287,7 +292,7 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 	 * range in a case where target_freq falls into a range of
 	 * next_possible_opp_freq - 1MHz.
 	 */
-	target_freq = round_down(target_freq, 1000000);
+	target_freq = round_down(target_freq, 1000);
 
 	/* watermarks are set at the borders of the corresponding OPPs */
 	*lower = tegra_actmon_lower_freq(tegra, target_freq);
@@ -296,9 +301,6 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 	dev_dbg(ddev, "%03x: target_freq %lu lower freq %lu upper freq %lu\n",
 		offset, target_freq, *lower, *upper);
 
-	*lower /= KHZ;
-	*upper /= KHZ;
-
 	/*
 	 * The upper watermark should take into account CPU's frequency
 	 * because cpu_to_emc_rate() may override the target_freq with
@@ -314,22 +316,23 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 					   struct tegra_devfreq_device *dev)
 {
-	unsigned long lower, upper, freq;
+	unsigned long avg_threshold, lower, upper;
 
-	freq = dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
-	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower, &upper);
+	tegra_actmon_get_lower_upper(tegra, dev, dev->avg_freq, &lower, &upper);
+
+	avg_threshold = dev->config->avg_dependency_threshold;
+	avg_threshold = avg_threshold * ACTMON_SAMPLING_PERIOD;
 
 	/*
 	 * We want to get interrupts when MCCPU client crosses the
 	 * dependency threshold in order to take into / out of account
 	 * the CPU's freq.
 	 */
-	if (lower < dev->config->avg_dependency_threshold &&
-	    upper > dev->config->avg_dependency_threshold) {
-		if (dev->avg_count < dev->config->avg_dependency_threshold)
-			upper = dev->config->avg_dependency_threshold;
+	if (lower < avg_threshold && upper > avg_threshold) {
+		if (dev->avg_freq < dev->config->avg_dependency_threshold)
+			upper = avg_threshold;
 		else
-			lower = dev->config->avg_dependency_threshold;
+			lower = avg_threshold;
 	}
 
 	device_writel(dev, lower, ACTMON_DEV_AVG_LOWER_WMARK);
@@ -368,8 +371,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 	 * device. Once that mark is hit and boosting is stopped, the
 	 * interrupt is disabled by ISR.
 	 */
-	freq = dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
-	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower, &upper);
+	tegra_actmon_get_lower_upper(tegra, dev, dev->avg_freq, &lower, &upper);
 
 	delta = do_percent(upper - lower, dev->config->boost_down_threshold);
 	device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK);
@@ -396,14 +398,16 @@ static void actmon_device_debug(struct tegra_devfreq *tegra,
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
-	u32 intr_status, dev_ctrl, avg_intr_mask;
+	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
 
 	actmon_device_debug(tegra, dev, "isr+");
 
-	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
+	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
 
+	dev->avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
+
 	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
 			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
 
@@ -458,8 +462,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {	unsigned long target_freq;
 
-	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
-	target_freq = min(target_freq, ULONG_MAX / KHZ);
+	target_freq = min(dev->avg_freq + dev->boost_freq, KHZ_MAX);
 	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
 
 	return target_freq;
@@ -496,6 +499,7 @@ static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
 	struct clk_notifier_data *data = ptr;
 	struct tegra_devfreq_device *dev;
 	struct tegra_devfreq *tegra;
+	unsigned long freq;
 	unsigned int i;
 
 	if (action != POST_RATE_CHANGE)
@@ -503,6 +507,8 @@ static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
 
 	tegra = container_of(nb, struct tegra_devfreq, clk_rate_change_nb);
 
+	freq = data->new_rate / KHZ;
+
 	/*
 	 * EMC rate could change due to three reasons:
 	 *
@@ -524,7 +530,7 @@ static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
 		dev = &tegra->devices[i];
 
 		tegra_devfreq_update_avg_wmark(tegra, dev);
-		tegra_devfreq_update_wmark(tegra, dev, data->new_rate);
+		tegra_devfreq_update_wmark(tegra, dev, freq);
 	}
 
 	return NOTIFY_OK;
@@ -564,17 +570,17 @@ static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
-	u32 val = 0, target_freq;
+	u32 val = 0;
 
 	/* we don't want boosting on restart */
 	dev->boost_freq = 0;
 
-	target_freq = clk_get_rate(tegra->emc_clock) / KHZ;
-	dev->avg_count = target_freq * ACTMON_SAMPLING_PERIOD;
-	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
+	dev->avg_freq = clk_get_rate(tegra->emc_clock) / KHZ;
+	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
+		      ACTMON_DEV_INIT_AVG);
 
 	tegra_devfreq_update_avg_wmark(tegra, dev);
-	tegra_devfreq_update_wmark(tegra, dev, target_freq);
+	tegra_devfreq_update_wmark(tegra, dev, dev->avg_freq);
 
 	device_writel(dev, ACTMON_COUNT_WEIGHT, ACTMON_DEV_COUNT_WEIGHT);
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
@@ -686,7 +692,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	rate = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
-	err = clk_set_min_rate(tegra->emc_clock, rate);
+	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
 	if (err)
 		return err;
 
@@ -709,7 +715,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	struct tegra_devfreq_device *actmon_dev;
 	unsigned long cur_freq;
 
-	cur_freq = clk_get_rate(tegra->emc_clock);
+	cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
@@ -726,7 +732,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = cur_freq / KHZ * ACTMON_SAMPLING_PERIOD;
+	stat->total_time = cur_freq * ACTMON_SAMPLING_PERIOD;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
@@ -772,7 +778,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 		actmon_device_debug(tegra, dev, "upd");
 	}
 
-	*freq = target_freq * KHZ;
+	*freq = target_freq;
 
 	return 0;
 }
@@ -908,7 +914,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 			goto remove_opps;
 		}
 
-		err = dev_pm_opp_add(&pdev->dev, rate, 0);
+		err = dev_pm_opp_add(&pdev->dev, rate / KHZ, 0);
 		if (err) {
 			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
 			goto remove_opps;
@@ -928,6 +934,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
+	tegra_devfreq_profile.initial_freq /= KHZ;
+
 	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
 				     "tegra_actmon", NULL);
 	if (IS_ERR(tegra->devfreq)) {
-- 
2.22.0

