Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE5F89454
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfHKVZd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:25:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40547 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfHKVYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so72980744lff.7;
        Sun, 11 Aug 2019 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KvKm2ALIBuaggfliWdwhYglH+E1CmsiYLiIW5ZnHiw=;
        b=i7nkqieV28ECsAU15gQst7GR5+WrTIgIn6hUZKd3JOyPaIM6piA0CDkLJWcrX0sojx
         zxET6p0DiM7f1fn7ZlaEBqmoIq2zVYQv9LcdNC2sbcZ4f9v1yoFF0RGSXqJ/guaQST7n
         Erd4CuOd2zv4JYYH5RzXcGAF7O0G+paaJjcUIVzAmyCAd4fl0hlouunbd2S2xf93B/uk
         hm/LCkJs7MI9Ekmrd+60w16wfYBObKq7dw8bhbXaMwpftaXPHJtBpHiaodzl8t0DszMY
         fpnAAwbwnUHNXjPPUTnKZoF4byZcYoK/2jasxttOYwDnOh3KqR/sLYhiwZVnPL1cKEY8
         fl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KvKm2ALIBuaggfliWdwhYglH+E1CmsiYLiIW5ZnHiw=;
        b=o2Vs490kAy6lvtS/K9h1UHbUJkZfFbotCnObKvbMH2s0A3Zgyj3y6yaZ9VI7lGgS5A
         dnNbwWlhF4E5+riXRR/N0pCXGv9XuSwwoazClngtuyQg4xPeP/JfyBAR1I9r8gSgkiJ8
         DR5An2zCL1PPCcb6jWtqBSLcvZCkKHYVZy+tjuI5+nivm+OToJ0xOGYAzXxM6/9c8Cyu
         Znt+f6PH2gNcNr8hZFQApwEJxSfjHaQvu4X3OPrTMuBjeF1pOxcRlOrZwQE6dkRrfmg/
         nwxUwbtu/3itHHhuJeWcXVfObIL3znOUggXL07OPZZKbsuev8vBAtFIO7nqSn7544AgU
         Jg9w==
X-Gm-Message-State: APjAAAXHgEkMuHsYoxZBGfLXQpG6f24eTM/9lOyGRyhvItoFOeXr5hQj
        PbL3BPzX6voxOU52eHGJHpg=
X-Google-Smtp-Source: APXvYqy2fHl3qx5OpLM91UBPOUTnASL3+aNkDgeQaGhAh9dGQbYQGvwN6DVov6i303yJ07+oo4o+xg==
X-Received: by 2002:ac2:47e8:: with SMTP id b8mr15652944lfp.84.1565558682361;
        Sun, 11 Aug 2019 14:24:42 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/19] PM / devfreq: tegra30: Use kHz units uniformly in the code
Date:   Mon, 12 Aug 2019 00:23:05 +0300
Message-Id: <20190811212315.12689-10-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
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
 drivers/devfreq/tegra30-devfreq.c | 81 +++++++++++++++++++------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index ca499368ee81..43d50b4366dd 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -137,8 +137,11 @@ struct tegra_devfreq_device {
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
@@ -222,6 +225,14 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
 	return 0;
 }
 
+static unsigned long
+tegra_actmon_dev_avg_dependency_freq(struct tegra_devfreq *tegra,
+				     struct tegra_devfreq_device *dev)
+{
+	return dev->config->avg_dependency_threshold /
+		ACTMON_SAMPLING_PERIOD;
+}
+
 static unsigned long
 tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev,
@@ -229,13 +240,15 @@ tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
 {
 	unsigned long static_cpu_emc_freq;
 
-	if (dev->config->avg_dependency_threshold &&
-	    dev->config->avg_dependency_threshold < dev->avg_count) {
+	if (!dev->config->avg_dependency_threshold)
+		return target_freq;
+
+	if (dev->avg_freq > tegra_actmon_dev_avg_dependency_freq(tegra, dev))
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
-		target_freq = max(target_freq, static_cpu_emc_freq);
-	}
+	else
+		static_cpu_emc_freq = 0;
 
-	return target_freq;
+	return max(target_freq, static_cpu_emc_freq);
 }
 
 static unsigned long tegra_actmon_lower_freq(struct tegra_devfreq *tegra,
@@ -261,7 +274,7 @@ static unsigned long tegra_actmon_upper_freq(struct tegra_devfreq *tegra,
 
 	opp = dev_pm_opp_find_freq_ceil(tegra->devfreq->dev.parent, &upper);
 	if (IS_ERR(opp))
-		upper = ULONG_MAX;
+		upper = KHZ_MAX;
 	else
 		dev_pm_opp_put(opp);
 
@@ -280,15 +293,12 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 	 * range in a case where target_freq falls into a range of
 	 * next_possible_opp_freq - 1MHz.
 	 */
-	target_freq = round_down(target_freq, 1000000);
+	target_freq = round_down(target_freq, 1000);
 
 	/* watermarks are set at the borders of the corresponding OPPs */
 	*lower = tegra_actmon_lower_freq(tegra, target_freq);
 	*upper = tegra_actmon_upper_freq(tegra, target_freq);
 
-	*lower /= KHZ;
-	*upper /= KHZ;
-
 	/*
 	 * The upper watermark should take into account CPU's frequency
 	 * because cpu_to_emc_rate() may override the target_freq with
@@ -304,10 +314,11 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 					   struct tegra_devfreq_device *dev)
 {
-	unsigned long lower, upper, freq;
+	unsigned long avg_dependency_freq, lower, upper;
+
+	tegra_actmon_get_lower_upper(tegra, dev, dev->avg_freq, &lower, &upper);
 
-	freq = dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
-	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower, &upper);
+	avg_dependency_freq = tegra_actmon_dev_avg_dependency_freq(tegra, dev);
 
 	/*
 	 * We want to get interrupts when MCCPU client crosses the
@@ -316,7 +327,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 	 */
 	if (lower < dev->config->avg_dependency_threshold &&
 	    upper > dev->config->avg_dependency_threshold) {
-		if (dev->avg_count < dev->config->avg_dependency_threshold)
+		if (dev->avg_freq < avg_dependency_freq)
 			upper = dev->config->avg_dependency_threshold;
 		else
 			lower = dev->config->avg_dependency_threshold;
@@ -358,8 +369,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 	 * device. Once that mark is hit and boosting is stopped, the
 	 * interrupt is disabled by ISR.
 	 */
-	freq = dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
-	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower, &upper);
+	tegra_actmon_get_lower_upper(tegra, dev, dev->avg_freq, &lower, &upper);
 
 	delta = do_percent(upper - lower, dev->config->boost_down_threshold);
 	device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK);
@@ -368,12 +378,14 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
-	u32 intr_status, dev_ctrl, avg_intr_mask;
+	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
 
-	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
+	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
 
+	dev->avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
+
 	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
 			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
 
@@ -427,7 +439,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
 {
 	unsigned long target_freq;
 
-	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
+	target_freq = dev->avg_freq + dev->boost_freq;
 	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
 
 	return min(target_freq, tegra->max_freq);
@@ -464,6 +476,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	struct clk_notifier_data *data = ptr;
 	struct tegra_devfreq_device *dev;
 	struct tegra_devfreq *tegra;
+	unsigned long freq;
 	unsigned int i;
 
 	if (action != POST_RATE_CHANGE)
@@ -471,6 +484,8 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 
 	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
 
+	freq = data->new_rate / KHZ;
+
 	/*
 	 * EMC rate could change due to three reasons:
 	 *
@@ -492,7 +507,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 		dev = &tegra->devices[i];
 
 		tegra_devfreq_update_avg_wmark(tegra, dev);
-		tegra_devfreq_update_wmark(tegra, dev, data->new_rate);
+		tegra_devfreq_update_wmark(tegra, dev, freq);
 	}
 
 	return NOTIFY_OK;
@@ -501,14 +516,14 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
-	u32 val = 0, target_freq;
+	u32 val = 0;
 
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
@@ -572,7 +587,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	rate = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
-	err = clk_set_min_rate(tegra->emc_clock, rate);
+	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
 	if (err)
 		return err;
 
@@ -595,7 +610,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	struct tegra_devfreq_device *actmon_dev;
 	unsigned long cur_freq;
 
-	cur_freq = clk_get_rate(tegra->emc_clock);
+	cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
@@ -612,7 +627,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = cur_freq / KHZ * ACTMON_SAMPLING_PERIOD;
+	stat->total_time = cur_freq * ACTMON_SAMPLING_PERIOD;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
@@ -652,7 +667,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 		target_freq = max(target_freq, dev_target_freq);
 	}
 
-	*freq = target_freq * KHZ;
+	*freq = target_freq;
 
 	return 0;
 }
@@ -787,7 +802,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 			goto remove_opps;
 		}
 
-		err = dev_pm_opp_add(&pdev->dev, rate, 0);
+		err = dev_pm_opp_add(&pdev->dev, rate / KHZ, 0);
 		if (err) {
 			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
 			goto remove_opps;
@@ -812,6 +827,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
+	tegra_devfreq_profile.initial_freq /= KHZ;
+
 	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
 				     "tegra_actmon", NULL);
 	if (IS_ERR(devfreq)) {
-- 
2.22.0

