Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE4EEF28
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbfKDWT2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:19:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42076 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388940AbfKDWBD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id z12so13447331lfj.9;
        Mon, 04 Nov 2019 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1E19zvKxqtuRF5nZpIuuGaKt1sQQwAAlPwmfDp5qZb0=;
        b=hUvXLO2en2ir1OJvEzvTaj11+D9mFnkU+iL1cyFm9s/5Mf7pKmALKVeZLbJL6k9ks0
         9FvwYFTOtJi64qbJCGt49QLaTDUAqnrTs41lfTX8XaCWVVOoDaiti6awh7Ku4GF3VhFc
         IImnYIQwbcU+dlox+9zulkKOy9dXulv2RoK6NUUqlmUKXj0OLFRMd52GM1cxxTQTXb5E
         3DDc0O0zfaOyMeY0MhyNeJ5xlfrJvKT/9IxrXqg74PFKXxbkKU2m1ZjiYmZxMfNBPXw4
         JGjje8RpqZnhLuvwpk8NOPUqSBTceh/afDJze738AIzR0NXW0laZQmX0fsytncxPanaB
         PNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1E19zvKxqtuRF5nZpIuuGaKt1sQQwAAlPwmfDp5qZb0=;
        b=EH3XBFg1lfy//4VISm1VE0n98FCtoxTeG81V0K14Mot2P+lYA9fLTt3iSzOimEl+YC
         CONsaORHGmKFQrsngrtAi8MvofLSFBfnL/xvW2Duk8UFDd48LoLgz3bpqjaXBKFjjG1U
         ScjxbQH1j7KJzahbes3UIuzUeoEFJ+LSl3VvnT0/Fo4wANqnFuSgjtUvUrzG+Y2hWvdW
         sXSxrdiVxMtD2E1WxRFou5FyoT5alNRXIgVjHViwZQO/rs2pvyeLDcWUy9r5BHZG+mI+
         8oyhkMWXpBQZiKzuXOH+djVC9IzwtSJPkYIWoV5/wlLwb45NL+s75Wa2q7oZ8iAlGSMx
         Z21w==
X-Gm-Message-State: APjAAAXQiKZKlvZVeC07106z9mPH6jxht4ckmIjL0oNYPT8zPOPhJVoJ
        +w5Vk1qZhC0e5Kpkhp3kRnw=
X-Google-Smtp-Source: APXvYqwCbJB4zr4XOec3vtnnq33ivcluW8B/Mejq2uuMJszRbNpWFQAsnfhlCDn2J0RB2IL1R4zpZQ==
X-Received: by 2002:ac2:48b5:: with SMTP id u21mr18489251lfg.75.1572904861102;
        Mon, 04 Nov 2019 14:01:01 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:00 -0800 (PST)
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
Subject: [PATCH v9 02/19] PM / devfreq: tegra30: Keep interrupt disabled while governor is stopped
Date:   Tue,  5 Nov 2019 00:56:00 +0300
Message-Id: <20191104215617.25544-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no real need to keep interrupt always-enabled, will be nicer
to keep it disabled while governor is inactive.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 47 ++++++++++++++++---------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a27300f40b0b..a0a5f3f7b789 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -11,6 +11,7 @@
 #include <linux/devfreq.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
@@ -416,8 +417,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
 {
 	unsigned int i;
 
-	disable_irq(tegra->irq);
-
 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
 		      ACTMON_GLB_PERIOD_CTRL);
 
@@ -442,8 +441,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 	}
 
 	actmon_write_barrier(tegra);
-
-	enable_irq(tegra->irq);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -552,6 +549,12 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
 
+	/*
+	 * Couple devfreq-device with the governor early because it is
+	 * needed at the moment of governor's start (used by ISR).
+	 */
+	tegra->devfreq = devfreq;
+
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
@@ -586,10 +589,11 @@ static struct devfreq_governor tegra_devfreq_governor = {
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
 {
-	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
-	unsigned int i;
+	struct tegra_devfreq *tegra;
+	struct devfreq *devfreq;
 	unsigned long rate;
+	unsigned int i;
 	int err;
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
@@ -625,6 +629,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 	tegra->irq = err;
 
+	irq_set_status_flags(tegra->irq, IRQ_NOAUTOEN);
+
+	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
+					actmon_thread_isr, IRQF_ONESHOT,
+					"tegra-devfreq", tegra);
+	if (err) {
+		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
+		return err;
+	}
+
 	reset_control_assert(tegra->reset);
 
 	err = clk_prepare_enable(tegra->clock);
@@ -672,28 +686,15 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra->devfreq = devfreq_add_device(&pdev->dev,
-					    &tegra_devfreq_profile,
-					    "tegra_actmon",
-					    NULL);
-	if (IS_ERR(tegra->devfreq)) {
-		err = PTR_ERR(tegra->devfreq);
+	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
+				     "tegra_actmon", NULL);
+	if (IS_ERR(devfreq)) {
+		err = PTR_ERR(devfreq);
 		goto remove_governor;
 	}
 
-	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
-					actmon_thread_isr, IRQF_ONESHOT,
-					"tegra-devfreq", tegra);
-	if (err) {
-		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
-		goto remove_devfreq;
-	}
-
 	return 0;
 
-remove_devfreq:
-	devfreq_remove_device(tegra->devfreq);
-
 remove_governor:
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-- 
2.23.0

