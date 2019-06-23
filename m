Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB754FECF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFXB5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 21:57:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34995 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFXB5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 21:57:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id a25so8779735lfg.2;
        Sun, 23 Jun 2019 18:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pV5FdcPTSttSNilu3xNSfhA13rB7Fsv+D3UEkNB3Vao=;
        b=j2nVHNaUaDmfaQ1v1oLYjsmWH4Df86NddlNnTBVZhahWGH9Zc67quvXy3RLaAd0Pir
         ggQdukCgt0XpA265FRrSxiGfdna2OAN1QQke71K6IxsCI3xmUX8VzGedX6a2TnuYn3JE
         pxMrQgt5fjZVg+W0uaNQY4L3Hq7FXf5FsB/PZ91+L9TJ8DSHg+uKpqXaKWtB3O9Uowl1
         4yJOpwpxg3O90trBwwKW8SOicbyrNfjRBkR8Xw619Kx9txpoTG8/WWmefBRkHfECNLTc
         62Aaa1UEWhH+uSiTSjC5gPT0AiZrjyBoeeqZGkLy6Grcf66W4youuigcOACjMRNYq57F
         kxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pV5FdcPTSttSNilu3xNSfhA13rB7Fsv+D3UEkNB3Vao=;
        b=I1X7ig1xmtIDoT0FvT2kDwuXtK7bvyex1a+uVv4RxhdxEbFxIYlkytMPPyN4aKg7EX
         O19VV34wk8ADb43/eY1WAQBuPPSJox2qxTOi+o6Fyix7Afhh8YH/QmUyUU+0oRSlwpqj
         /5JbNKkXv75RlWCx3HgKE7hZ8YSskw5nKCsy5z2ejv/917knPqHVPlYXOQ2/4ejLWrGv
         8MUMZOTUA1dwXsTWlb4FEA+9FidAIrKvxtqlsasaUWxrC17i2kAwgLG9kzZBsPqxTdXS
         +woFOCG4vRX49+oq2Pm6YPRfZaupOvD/iHEalCbTfkRwPfN4octYzdBGsaLvDmJNO43l
         AsWg==
X-Gm-Message-State: APjAAAUJjAs6WDBeIAtKoCt+CKh6XRtTcSIKJ2zXj4KNF5yB6OEi/7wb
        juAGWUOhgR1yQe4mA6c+7AJI60OI
X-Google-Smtp-Source: APXvYqy5FOHHOhNqhyIhilPgU90c5BWnM5hPhlqihQdHBJxpUWliCMm3uFA+tTpj7sz2NYHuedEoBA==
X-Received: by 2002:a19:f808:: with SMTP id a8mr10291071lff.29.1561326516944;
        Sun, 23 Jun 2019 14:48:36 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/11] PM / devfreq: tegra30: Keep interrupt disabled while governor is stopped
Date:   Mon, 24 Jun 2019 00:46:49 +0300
Message-Id: <20190623214658.11680-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no real need to keep interrupt always-enabled, will be nicer
to keep it disabled where appropriate.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 43 ++++++++++++++++---------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a27300f40b0b..5e2b133babdd 100644
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
+	 * Couple device with the governor early as it is needed at
+	 * the moment of governor's start (used by ISR).
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
+	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
+				     "tegra_actmon", NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
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
2.22.0

