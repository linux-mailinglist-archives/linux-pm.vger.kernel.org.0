Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F4789447
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfHKVYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35774 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfHKVYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so6678598lje.2;
        Sun, 11 Aug 2019 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VR4VQoyRWVM0Kw8sF0Cq63P0RsRTjzSwRUSf5aLb+kM=;
        b=ZD/9ixO25odQdlnP4wfN5pSIBJzFoN79VQ84W5O5/0W/602i12KKrq3AsGAffSVnNX
         b3jqMr7jMP2uMO7vdcKztaWoiQrQIsTu9PRrRP/Rwxyx10LaBfj9uvOf6qhnJjtpAZdf
         jv+eqSyquBJnavRHhunKsIMYJN8f3Jn5bSvL910ThcmxSmLnmC6mtQTd1ARJdfvqBj/N
         cAWVJG+E5LEx/JCTKOoT5SGuPycYxOavoVcf5CrXQy9tbUe/3SBN47ywftcK8aDn8Y7x
         cOuoA/rmv0vGbhhpR8rMydXUz4OcrtXHjxPFfJc+r8SPWOWuljknhyNUyhylc1G1X4KK
         cflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VR4VQoyRWVM0Kw8sF0Cq63P0RsRTjzSwRUSf5aLb+kM=;
        b=UpSWunk9z5bmFdk5bmysvjjAT0EP09iqS2yP7YLLzrNfiOW50BPX+MArDvnR23n3cE
         syMz5fXmKN8XV7pEZvq9Tkqegj1LgI+v7vIIOMH97TSDHcmCuRWcMPwLxmHGB9UBDn0o
         gcmvPlSUZtehJzC4lJa2LZ8Scq2xcN5siwxkw7gRYPoXkqkdeFFFGkU+gONw1e3QOMYe
         ugEyByD5hlJE7xRUpJAEAatEesP7lWcKHvjX/ne9tWTTSvUCZlEssoqpwnbkldHJMeWv
         FwTdjcIEf2Asd72CnhJZfAyq3qk4kf4ZVsy5e+4J/cTTINaW/Gilatiy3B75Ney5Qhlt
         3IVA==
X-Gm-Message-State: APjAAAVlF3WG+GMu1rifqnbOV+GtqsNRN/biZWjkNR5rpZBlkfm4+IL4
        ZrLF+scPnVtJxIDa2MuQu5w=
X-Google-Smtp-Source: APXvYqzhyQl+7fxoJDBOnfUxFOmPXVKfEdfg4c2MXCtDsNm6WqSrcaY8GI2PzXK5vs6aawbeBZ6yAQ==
X-Received: by 2002:a2e:534a:: with SMTP id t10mr16278040ljd.109.1565558683337;
        Sun, 11 Aug 2019 14:24:43 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/19] PM / devfreq: tegra30: Reduce unnecessary interrupts activity
Date:   Mon, 12 Aug 2019 00:23:06 +0300
Message-Id: <20190811212315.12689-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are cases where unnecessary ACTMON interrupts could be avoided,
like when one memory client device requests higher clock rate than the
other or when clock rate is manually limited using sysfs devfreq
parameters. These cases could be avoided by tuning upper watermark or
disabling hardware events when min/max boosting thresholds are reached.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 87 ++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 43d50b4366dd..a2623de56d20 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -312,7 +312,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 }
 
 static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
-					   struct tegra_devfreq_device *dev)
+					   struct tegra_devfreq_device *dev,
+					   unsigned long freq)
 {
 	unsigned long avg_dependency_freq, lower, upper;
 
@@ -320,6 +321,22 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 
 	avg_dependency_freq = tegra_actmon_dev_avg_dependency_freq(tegra, dev);
 
+	/*
+	 * If cumulative EMC frequency selection (MCALL / min_freq) is
+	 * higher than the device's, then there is no need to set upper
+	 * watermark to a lower value because it will result in unnecessary
+	 * upper interrupts.
+	 *
+	 * Note that average watermarks are also updated after EMC
+	 * clock rate change, hence if clock rate goes down, then the
+	 * watermarks will be set in accordance to the new rate after
+	 * changing the rate. There are other ways to achieve the same
+	 * result, but this one is probably the least churning, although
+	 * it may look a bit convoluted.
+	 */
+	if (freq * ACTMON_SAMPLING_PERIOD > upper)
+		upper = freq * ACTMON_SAMPLING_PERIOD;
+
 	/*
 	 * We want to get interrupts when MCCPU client crosses the
 	 * dependency threshold in order to take into / out of account
@@ -361,7 +378,18 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 	tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower, &upper);
 
 	delta = do_percent(upper - lower, dev->config->boost_up_threshold);
-	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);
+
+	/*
+	 * The memory events count could go a bit higher than the maximum
+	 * defined by the OPPs, hence make the upper watermark infinitely
+	 * high to avoid unnecessary upper interrupts in that case.
+	 */
+	if (freq == tegra->max_freq)
+		upper = ULONG_MAX;
+	else
+		upper = lower + delta;
+
+	device_writel(dev, upper, ACTMON_DEV_UPPER_WMARK);
 
 	/*
 	 * Meanwhile the lower mark is based on the average value
@@ -379,6 +407,7 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
 	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
+	unsigned long freq;
 
 	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
 	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
@@ -389,8 +418,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
 			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
 
-	if (intr_status & avg_intr_mask)
-		tegra_devfreq_update_avg_wmark(tegra, dev);
+	if (intr_status & avg_intr_mask) {
+		freq = clk_get_rate(tegra->emc_clock) / KHZ;
+		tegra_devfreq_update_avg_wmark(tegra, dev, freq);
+	}
 
 	if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_UPPER) {
 		/*
@@ -412,6 +443,8 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 		dev->boost_freq = do_percent(dev->boost_freq,
 					     dev->config->boost_down_coeff);
 
+		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+
 		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
 			dev->boost_freq = 0;
 	}
@@ -427,8 +460,16 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	}
 
 	/* no boosting => no need for consecutive-down interrupt */
-	if (dev->boost_freq == 0)
+	if (dev->boost_freq == 0) {
 		dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+	}
+
+	/* boosting max-out => no need for consecutive-up interrupt */
+	if (dev->boost_freq == tegra->max_freq) {
+		dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+	}
 
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
@@ -437,8 +478,40 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
+	u32 avg_count, avg_freq, old_upper, new_upper, dev_ctrl;
 	unsigned long target_freq;
 
+	/*
+	 * The avg_count / avg_freq is getting snapshoted on device's
+	 * interrupt, but there are cases where actual value need to
+	 * be utilized on target's update, like CPUFreq boosting and
+	 * overriding the min freq via /sys/class/devfreq/devfreq0/min_freq
+	 * because we're optimizing the upper watermark based on the
+	 * actual EMC frequency. This means that interrupt may be
+	 * inactive for a long time and thus making snapshoted value
+	 * outdated.
+	 */
+	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
+	avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
+
+	old_upper = tegra_actmon_upper_freq(tegra, dev->avg_freq);
+	new_upper = tegra_actmon_upper_freq(tegra, avg_freq);
+
+	/* similar to ISR, see comments in actmon_isr_device() */
+	if (old_upper != new_upper) {
+		if (dev->boost_freq == tegra->max_freq) {
+			dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
+
+			dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
+
+			device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
+		}
+
+		dev->avg_freq = avg_freq;
+		dev->boost_freq = 0;
+	}
+
 	target_freq = dev->avg_freq + dev->boost_freq;
 	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
 
@@ -506,7 +579,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		tegra_devfreq_update_avg_wmark(tegra, dev);
+		tegra_devfreq_update_avg_wmark(tegra, dev, freq);
 		tegra_devfreq_update_wmark(tegra, dev, freq);
 	}
 
@@ -522,7 +595,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
 		      ACTMON_DEV_INIT_AVG);
 
-	tegra_devfreq_update_avg_wmark(tegra, dev);
+	tegra_devfreq_update_avg_wmark(tegra, dev, dev->avg_freq);
 	tegra_devfreq_update_wmark(tegra, dev, dev->avg_freq);
 
 	device_writel(dev, ACTMON_COUNT_WEIGHT, ACTMON_DEV_COUNT_WEIGHT);
-- 
2.22.0

