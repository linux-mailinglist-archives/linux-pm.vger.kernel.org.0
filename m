Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1811049
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfEAXmh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:42:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39649 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfEAXmL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:42:11 -0400
Received: by mail-io1-f68.google.com with SMTP id c3so467449iok.6;
        Wed, 01 May 2019 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTuFlSIz6bkK0a5mBGnRYSBE3s+oDC4vml4uTvDMuRg=;
        b=de09fenY50RKRe3K5eR55oJkX5NWKlqpOMAiQz5f2P5MEt/Z9uT2OlLpnwO8K12KaI
         BfrwIeVUO3xt7mGoDNN8BguVN+5KnNR5ngufVHMU9Ju1QUVulpUMBI9UZ+K3cu4tutAJ
         GnjRfxySy7QYwF98Tal9p5JRvK5l5a0VVjMRoU2OMsdAbSqACusjWR8BJDmQpyA0PZHm
         oZ2Zk8IxBg3qpNBm8d/5zV3/eND8tXtqOwI9S+GBwzm+XY+k/g9WaNFModLyMTZ7c6mP
         xf5TNou6TvD9IxIy9f+hjsOlzPx/Yg2tn37YXkW3Kc6XRpR9IaHGwCmT9zd1kOTenr1O
         9ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTuFlSIz6bkK0a5mBGnRYSBE3s+oDC4vml4uTvDMuRg=;
        b=qt0EZ4JPyLl3ygtwm/qJr3aVAcIwBZmGGPmkkTl3onr1yYYWtoNhV5+utfjrgeNi9F
         ytXSU8UjEud20rb7lAC2pcERzrRqbhq5eQBx+iid4FTovnnMk7rQdb3t6IY4ou7Itrmi
         9luX/hVGXzHeaSeUX6Emb0IHbtuLhP9kSPgxS+yh1m0pmBlPtd2+tKTksqo10nomXQ0c
         aZIA+YFP0p2lMuLS2vlGHfSXn2YOkFWydeczmgWW429Q2qHWOOcxYKNO9oUgqd3WLtAC
         ym0+fwLaELAkpmduIlaJ/Y+Y+zudfxBpNo0kw5ML18SQPkNdzNPSAv/toI0b5VDQYdL+
         Lx2Q==
X-Gm-Message-State: APjAAAUOq/9mypw84bRfgWqBoVlH7PxPo7ZEPBy+GAXJxVHGMlPAPcyF
        CyUkS1p7VOnQzvz1ol+oD00=
X-Google-Smtp-Source: APXvYqzssOLA80UvqhwkcOt6vcmSQs6dewsfluik7ArjyF010JzNWY9WL6O70VvYeUKkdBk4ExShwA==
X-Received: by 2002:a6b:7509:: with SMTP id l9mr394803ioh.129.1556754130333;
        Wed, 01 May 2019 16:42:10 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:42:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/16] PM / devfreq: tegra: Reconfigure hardware on governor's restart
Date:   Thu,  2 May 2019 02:38:11 +0300
Message-Id: <20190501233815.32643-13-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move hardware configuration to governor's start/resume methods.
This allows to re-initialize hardware counters and reconfigure
cleanly if governor was stopped/paused. That is needed because we
are not aware of all hardware changes that happened while governor
was stopped and the paused state may get out of sync with reality,
hence it's better to start with a clean slate after the pause. In
a result there is no memory bandwidth starvation after resume from
suspend-to-ram that results in display controller underflowing that
happens on resume because of improper decision made by devfreq about
the required memory frequency. This change also cleans up code a tad
by moving hardware-configuration code into a single location.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 98 ++++++++++++++-------------------
 1 file changed, 40 insertions(+), 58 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 40ce9881f144..2d9d53daedd8 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -392,55 +392,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static void tegra_actmon_enable_interrupts(struct tegra_devfreq *tegra)
-{
-	struct tegra_devfreq_device *dev;
-	u32 val;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		dev = &tegra->devices[i];
-
-		val = device_readl(dev, ACTMON_DEV_CTRL);
-		val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
-		val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-		val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-		val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
-
-		device_writel(dev, val, ACTMON_DEV_CTRL);
-	}
-
-	actmon_write_barrier(tegra);
-}
-
-static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
-{
-	struct tegra_devfreq_device *dev;
-	u32 val;
-	unsigned int i;
-
-	disable_irq(tegra->irq);
-
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		dev = &tegra->devices[i];
-
-		val = device_readl(dev, ACTMON_DEV_CTRL);
-		val &= ~ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
-		val &= ~ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
-
-		device_writel(dev, val, ACTMON_DEV_CTRL);
-
-		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
-			      ACTMON_DEV_INTR_STATUS);
-	}
-
-	actmon_write_barrier(tegra);
-
-	enable_irq(tegra->irq);
-}
-
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
@@ -464,11 +415,47 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_NUM_SHIFT;
 	val |= (ACTMON_ABOVE_WMARK_WINDOW - 1)
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
+	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
+	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
+	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
 	device_writel(dev, val, ACTMON_DEV_CTRL);
+}
+
+static void tegra_actmon_start(struct tegra_devfreq *tegra)
+{
+	unsigned int i;
+
+	disable_irq(tegra->irq);
+
+	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
+		      ACTMON_GLB_PERIOD_CTRL);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
+
+	actmon_write_barrier(tegra);
+
+	enable_irq(tegra->irq);
+}
+
+static void tegra_actmon_stop(struct tegra_devfreq *tegra)
+{
+	unsigned int i;
+
+	disable_irq(tegra->irq);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
+		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
+		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
+			      ACTMON_DEV_INTR_STATUS);
+	}
 
 	actmon_write_barrier(tegra);
+
+	enable_irq(tegra->irq);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -580,22 +567,22 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
-		tegra_actmon_enable_interrupts(tegra);
+		tegra_actmon_start(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
-		tegra_actmon_disable_interrupts(tegra);
+		tegra_actmon_stop(tegra);
 		devfreq_monitor_stop(devfreq);
 		break;
 
 	case DEVFREQ_GOV_SUSPEND:
-		tegra_actmon_disable_interrupts(tegra);
+		tegra_actmon_stop(tegra);
 		devfreq_monitor_suspend(devfreq);
 		break;
 
 	case DEVFREQ_GOV_RESUME:
 		devfreq_monitor_resume(devfreq);
-		tegra_actmon_enable_interrupts(tegra);
+		tegra_actmon_start(tegra);
 		break;
 	}
 
@@ -664,15 +651,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
 	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 
-	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
-		      ACTMON_GLB_PERIOD_CTRL);
-
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
 		dev->regs = tegra->regs + dev->config->offset;
-
-		tegra_actmon_configure_device(tegra, dev);
 	}
 
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
-- 
2.21.0

