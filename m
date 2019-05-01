Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 836B811055
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfEAXmC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:42:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43406 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfEAXmC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:42:02 -0400
Received: by mail-io1-f67.google.com with SMTP id v9so448001iol.10;
        Wed, 01 May 2019 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Urbgjf6ObOt4aJ4US+ZHY6pwQYAco+BhwHPT+aOOMeQ=;
        b=PFs4MVzlJ7x+4UrblL5kGZ5ttLwSc2vzdb9PqajVVnp4YjfegMdz37kdn5RvmPuM8N
         q3rJmx4YRs4ngstuh0yuWZTMt2zHPspX8XlVSiR4Bkse9HPPFUZuaFop1GNQwELyhWcV
         HFtXnmuUXnHx17ln5ucuUwt1BalXvAs6bSfbpGx40a2yxNP6BU8AZNMgdbM2/n3tF+wz
         gKXEL31a9uVBdM+q2qwY78k+JdHiXItXRD/H++duw7leeidcBZNZJdW8+6o4aQipEtbA
         afndXf2+ltRTSBNC1sqJgzmcd3mlFMIR7zLEInrvxvpQHcvdksSCm51hXL8RktmwIrh5
         b14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Urbgjf6ObOt4aJ4US+ZHY6pwQYAco+BhwHPT+aOOMeQ=;
        b=Z8eRWcECK9TR0AduNUXpQOlpoOw5G5t3VAcovy038iLscLF8T4xAztBZq+ZUTU3QK7
         85BKeI6q5pctJN6NFojLImUSfLUik8VbzoK5TxVyLKKz9bpOAcoinYDQiqv/oJW8J5bc
         ENb/wktiNrgrbJvJS3jbfez9ombAloYwzn/QuAcl3nvOvCHB+Ilio6BfEfSn2gXDdf3B
         bn3qSEmpxUdiCvhtNxY84dju9vxhum/m2h/qXTJblrHM4vCAuVbnJY0HNifn9mC//G7b
         6UZ6YMTIhRHVbIaEqkoWxj2XIG+XMkCpkO7VqsyOcOZFHtr2G9DzGG/pgU3AeYEEKPMJ
         4DOw==
X-Gm-Message-State: APjAAAUpDWC6eKneP/Il+RBCfb1Zo0pEPhAjJN5ACCENq4QtD4omhGEl
        w9q+toA+a/L65Ra2wJ7XK20=
X-Google-Smtp-Source: APXvYqyS7u8zzMW3mEYseQbkK8L6FaqaWQ05t39Vq1OTGD5aYcFvWmMjqKBYpkD513zq7BCwvCnH+g==
X-Received: by 2002:a5d:9317:: with SMTP id l23mr380129ion.261.1556754120794;
        Wed, 01 May 2019 16:42:00 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:42:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/16] PM / devfreq: tegra: Clean up driver's probe / remove
Date:   Thu,  2 May 2019 02:38:07 +0300
Message-Id: <20190501233815.32643-9-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reset hardware, disable ACTMON clock, release OPP's and handle all
possible error cases correctly, maintaining the correct tear down
order. Also use devm_platform_ioremap_resource() which is now available
in the kernel.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 83 +++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index ce1eb97a2090..ea0da05cd7f2 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -610,7 +610,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
-	struct resource *res;
 	unsigned int i;
 	unsigned long rate;
 	int err;
@@ -619,9 +618,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (!tegra)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
+	tegra->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tegra->regs))
 		return PTR_ERR(tegra->regs);
 
@@ -643,11 +640,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
-	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Failed to register rate change notifier\n");
+	tegra->irq = platform_get_irq(pdev, 0);
+	if (tegra->irq < 0) {
+		err = tegra->irq;
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
 		return err;
 	}
 
@@ -678,54 +674,69 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
 		rate = clk_round_rate(tegra->emc_clock, rate);
-		dev_pm_opp_add(&pdev->dev, rate, 0);
-	}
 
-	tegra->irq = platform_get_irq(pdev, 0);
-	if (tegra->irq < 0) {
-		err = tegra->irq;
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
-		return err;
+		err = dev_pm_opp_add(&pdev->dev, rate, 0);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
+			goto remove_opps;
+		}
 	}
 
 	platform_set_drvdata(pdev, tegra);
 
+	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
+	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Failed to register rate change notifier\n");
+		goto remove_opps;
+	}
+
+	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
+	tegra->devfreq = devfreq_add_device(&pdev->dev,
+					    &tegra_devfreq_profile,
+					    "tegra_actmon",
+					    NULL);
+	if (IS_ERR(tegra->devfreq)) {
+		err = PTR_ERR(tegra->devfreq);
+		goto unreg_notifier;
+	}
+
 	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
 					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
 	if (err) {
-		dev_err(&pdev->dev, "Interrupt request failed\n");
-		return err;
+		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
+		goto remove_devfreq;
 	}
 
-	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
-						 &tegra_devfreq_profile,
-						 "tegra_actmon",
-						 NULL);
-
 	return 0;
+
+remove_devfreq:
+	devfreq_remove_device(tegra->devfreq);
+
+unreg_notifier:
+	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+
+remove_opps:
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
+	reset_control_reset(tegra->reset);
+	clk_disable_unprepare(tegra->clock);
+
+	return err;
 }
 
 static int tegra_devfreq_remove(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
-	u32 val;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
-		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
-		val &= ~ACTMON_DEV_CTRL_ENB;
-		device_writel(&tegra->devices[i], val, ACTMON_DEV_CTRL);
-	}
-
-	actmon_write_barrier(tegra);
 
-	devm_free_irq(&pdev->dev, irq, tegra);
+	devfreq_remove_device(tegra->devfreq);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
+	reset_control_reset(tegra->reset);
 	clk_disable_unprepare(tegra->clock);
 
 	return 0;
-- 
2.21.0

