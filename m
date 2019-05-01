Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1330911054
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfEAXl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:41:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54932 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfEAXl4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:41:56 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so335361ite.4;
        Wed, 01 May 2019 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJSuD9SpQlwu3/p0ZbmwC/KpKlX3tNAhcs99zQTbKNs=;
        b=qzlGEgSBoiTbzlYa04+ILv1d4tlysuLRMRuFEk94TmuctRSAPgmoE6l7iHXeUMqXr6
         wHR79enASCkvuC8D6bj36asaiJq1gd5W7PFVoGGOT0kFOz2zjsVrcLchZ+gXZUG1A1BL
         NVZchepAd32kycLCVyT/xZorPUgVGs9VI9ltLTGOrojlappc7b70z5Bv/gIUgFXAUoHi
         y6dSSm3RPZ+MM3XU4tcIpIpeMIYuEBZW0kT2gvnmQqg+KCp3alwVrDhn7RjmlLYj9oT+
         1L4DHr7AK/SElPa9YKwSnu2bWH0/rUrALc5CtV2ThzHfcDPdEZuE2maS0rLnuAEwwKFy
         AWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJSuD9SpQlwu3/p0ZbmwC/KpKlX3tNAhcs99zQTbKNs=;
        b=J+h7hHPdsl5C+0P7ydEFmOBpQu/lwPqVO6Z+XmUIdM9V5FkBF/qA2+wiYv8yrH+hGp
         GhCA7Bdk0p0GrT56XFcH4vH1f+belNQH6Vn0Pvq1PnVBOH8Rg+ra7NmHnj7faQ0v3NAz
         FdEnVuB0JNn7G3qiiNxLz6GbNbOoZFO7VCZgHFP+NeL95/Qbu/s4PgDxFi3tMAOyl7ny
         q+LVbR7+GEQbvXQpr/++HEJVkiKoDfldG/V/k/g3XToTjL3Go1DPpysU7W+TlZsX5ELT
         YRQLW1/UaF7naE+7I7f+ZED+XC93ydSowciQx49XS5IlZavmre5rEvMConrYrz9av1F9
         aqzQ==
X-Gm-Message-State: APjAAAX28d/C3FrMr5Imw198UKQUPWie/y7R86sM1P0uEsi9n1bDYrNm
        4bvQeZEO/su3p+4O1SLdqiI=
X-Google-Smtp-Source: APXvYqwM7xUBNLg8guV1YwWwg+iUDuE4OlLzqZZ55QPxA1K6z1sM/PZZ3m7vRiclwWCiCfkqU7QwZg==
X-Received: by 2002:a02:5143:: with SMTP id s64mr349332jaa.54.1556754115872;
        Wed, 01 May 2019 16:41:55 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:41:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/16] PM / devfreq: tegra: Drop primary interrupt handler
Date:   Thu,  2 May 2019 02:38:05 +0300
Message-Id: <20190501233815.32643-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no real need in the primary interrupt handler, hence move
everything to the secondary (threaded) handler. In a result locking
is consistent now and there are no potential races with the interrupt
handler because it is protected with the devfreq's mutex.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 55 +++++++++++----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 24ec65556c39..b65313fe3c2e 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -144,7 +144,6 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
 struct tegra_devfreq_device {
 	const struct tegra_devfreq_device_config *config;
 	void __iomem *regs;
-	spinlock_t lock;
 
 	/* Average event count sampled in the last interrupt */
 	u32 avg_count;
@@ -249,11 +248,8 @@ static void actmon_write_barrier(struct tegra_devfreq *tegra)
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
-	unsigned long flags;
 	u32 intr_status, dev_ctrl;
 
-	spin_lock_irqsave(&dev->lock, flags);
-
 	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	tegra_devfreq_update_avg_wmark(tegra, dev);
 
@@ -302,26 +298,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
 
 	actmon_write_barrier(tegra);
-
-	spin_unlock_irqrestore(&dev->lock, flags);
-}
-
-static irqreturn_t actmon_isr(int irq, void *data)
-{
-	struct tegra_devfreq *tegra = data;
-	bool handled = false;
-	unsigned int i;
-	u32 val;
-
-	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		if (val & tegra->devices[i].config->irq_mask) {
-			actmon_isr_device(tegra, tegra->devices + i);
-			handled = true;
-		}
-	}
-
-	return handled ? IRQ_WAKE_THREAD : IRQ_NONE;
 }
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
@@ -348,15 +324,12 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 	unsigned long cpu_freq = 0;
 	unsigned long static_cpu_emc_freq = 0;
 	unsigned int avg_sustain_coef;
-	unsigned long flags;
 
 	if (dev->config->avg_dependency_threshold) {
 		cpu_freq = cpufreq_get(0);
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
 	}
 
-	spin_lock_irqsave(&dev->lock, flags);
-
 	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
 	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
@@ -364,19 +337,31 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 
 	if (dev->avg_count >= dev->config->avg_dependency_threshold)
 		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
-
-	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
 static irqreturn_t actmon_thread_isr(int irq, void *data)
 {
 	struct tegra_devfreq *tegra = data;
+	bool handled = false;
+	unsigned int i;
+	u32 val;
 
 	mutex_lock(&tegra->devfreq->lock);
-	update_devfreq(tegra->devfreq);
+
+	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
+		if (val & tegra->devices[i].config->irq_mask) {
+			actmon_isr_device(tegra, tegra->devices + i);
+			handled = true;
+		}
+	}
+
+	if (handled)
+		update_devfreq(tegra->devfreq);
+
 	mutex_unlock(&tegra->devfreq->lock);
 
-	return IRQ_HANDLED;
+	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
@@ -386,7 +371,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
 	unsigned int i;
-	unsigned long flags;
 
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
@@ -398,9 +382,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		spin_lock_irqsave(&dev->lock, flags);
 		tegra_devfreq_update_wmark(tegra, dev);
-		spin_unlock_irqrestore(&dev->lock, flags);
 	}
 
 	actmon_write_barrier(tegra);
@@ -682,7 +664,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
 		dev->regs = tegra->regs + dev->config->offset;
-		spin_lock_init(&dev->lock);
 
 		tegra_actmon_configure_device(tegra, dev);
 	}
@@ -700,8 +681,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
-					actmon_thread_isr, IRQF_SHARED,
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
 	if (err) {
 		dev_err(&pdev->dev, "Interrupt request failed\n");
-- 
2.21.0

