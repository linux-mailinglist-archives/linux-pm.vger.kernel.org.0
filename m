Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7DF58CAC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF0VNK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:13:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36177 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfF0VMq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so2544870lfc.3;
        Thu, 27 Jun 2019 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CApR5RnFgkj1lNrJ3+P+rh0qEwqZf8rqu3g+uGcoerA=;
        b=kSZjzkUKhbodnAJy29xQLSiRQKlkmwFGuujRPyzcy9T1bmzhVuu7/MRRg0+XlBuJxB
         DeDQdRdqcnQsZw8ugl6OhYGvA33uwhXO0zL0k4eYbPpFn9A9vfZ7GwkiQgX7D9nHlTS6
         Aq7gLdSg/W8MXQ1X2cxFkwK09ZFcn7cylia4VScUEfQylS8Q8Tm7soZNakYoJCfBHLdS
         /L21w6iNyQbOx50Poznnu9+1fLqPoCMeL+PyPxa1zeOLccTl7wL8NuXOZH4dnB8V830R
         tc/0A/MjYOqPW6geFYR/CvIDrQbGikllMdWOklC8iunFijMfQqohRdhz7JlxzGL9hDG6
         kmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CApR5RnFgkj1lNrJ3+P+rh0qEwqZf8rqu3g+uGcoerA=;
        b=KtaLnkikYoOtDgGRAhmQZZ1Vv+iSVF5Bz/g7f6IFwnkuffVh2K1fWUr1t5JyZUiX9G
         hZVMnG6IPQ6oE3Y0L3MqIiXc6o01P2bJP5JEgx25XjyPOXgKOa+gOrPlDoBgriL+re1p
         UAaLwu2yyohycRPOOooghOFF6OH3R3/6fAj00UbC8zJb71y0mycU82lhtDIzYeXWjmz3
         1KY42hqvnoiAw2wjscR4XRZg5kbmeMpOXnSJEJYdxdyYx5nSwfrSaqnisHW6ZtTwbLBh
         CqaboC2dl78efyCSjpdc0QoMhkG0An62NaPOijRyJWK26omdgUVEHXE1jbu1fJidZcXO
         zh6w==
X-Gm-Message-State: APjAAAVWJYRprAmojucAavKksv0+aMqNKIr/qDI4mlWZJKF6ZyTRuLVN
        dooijUYdF81yWNJbXFMIPP4=
X-Google-Smtp-Source: APXvYqwhctAhMBbikuBkZQPxApASrboO5ecmrX2kEZwRuC6bOLHQWzlOvZkQKNocVovnwSqqYwQp+w==
X-Received: by 2002:a19:ccc6:: with SMTP id c189mr3105454lfg.160.1561669964134;
        Thu, 27 Jun 2019 14:12:44 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/22] PM / devfreq: tegra30: Optimize upper average watermark selection
Date:   Fri, 28 Jun 2019 00:11:13 +0300
Message-Id: <20190627211115.21138-21-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I noticed that CPU may be crossing the dependency threshold very
frequently for some workloads and this results in a lot of interrupts
which could be avoided if MCALL client is keeping actual EMC frequency
at a higher rate.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 1105104445a9..5b1feaf8c16e 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -314,7 +314,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 }
 
 static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
-					   struct tegra_devfreq_device *dev)
+					   struct tegra_devfreq_device *dev,
+					   unsigned long freq)
 {
 	unsigned long avg_threshold, lower, upper;
 
@@ -323,6 +324,15 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
 	avg_threshold = dev->config->avg_dependency_threshold;
 	avg_threshold = avg_threshold * ACTMON_SAMPLING_PERIOD;
 
+	/*
+	 * If cumulative EMC frequency selection is higher than the
+	 * device's, then there is no need to set upper watermark to
+	 * a lower value because it will result in unnecessary upper
+	 * interrupts.
+	 */
+	if (freq * ACTMON_SAMPLING_PERIOD > upper)
+		upper = freq * ACTMON_SAMPLING_PERIOD;
+
 	/*
 	 * We want to get interrupts when MCCPU client crosses the
 	 * dependency threshold in order to take into / out of account
@@ -392,6 +402,7 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
 	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
+	unsigned long freq;
 
 	trace_device_isr_enter(tegra->regs, dev->config->offset,
 			       dev->boost_freq, cpufreq_get(0));
@@ -405,8 +416,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
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
@@ -524,7 +537,7 @@ static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		tegra_devfreq_update_avg_wmark(tegra, dev);
+		tegra_devfreq_update_avg_wmark(tegra, dev, freq);
 		tegra_devfreq_update_wmark(tegra, dev, freq);
 	}
 
@@ -629,7 +642,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
 		      ACTMON_DEV_INIT_AVG);
 
-	tegra_devfreq_update_avg_wmark(tegra, dev);
+	tegra_devfreq_update_avg_wmark(tegra, dev, dev->avg_freq);
 	tegra_devfreq_update_wmark(tegra, dev, dev->avg_freq);
 
 	device_writel(dev, ACTMON_COUNT_WEIGHT, ACTMON_DEV_COUNT_WEIGHT);
-- 
2.22.0

