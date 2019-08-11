Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5ED48944B
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfHKVYl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40545 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHKVYh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so72980648lff.7;
        Sun, 11 Aug 2019 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ox12S6Tw4A+nuZKMeS2Wc28MQmpMbXQ3Ba/CygAYf44=;
        b=Y8BTGfCGniq4bJ0CqppedXBe5j5ZegDHPgvitHCeO2ltxAHAc0aexmlIOYylWwQxQA
         PYteCTtF+VBNnQgTnn2tioReEaHOzGU42BZAtTdn/MY/YivKrnwPPdmE/YeDCppqbjr7
         dCiMduLU4wLfTGWUsVQuOv5kBIXqAJ1f4mqdoSdfa9ydD5n70hN1+fq1WQi51GFjJC2g
         u36Px93VW9V4axlTP6wcpQUa8LNQhomxOt45APgoPubNGJde+fj2WJmRJ/iimh34a+zf
         MkcXTDOItYFtuHngOX7vASQqt+7EfN2caD5hUKBQAHOC1FR1SlvgKZsaC/bduv1jfT6u
         f6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ox12S6Tw4A+nuZKMeS2Wc28MQmpMbXQ3Ba/CygAYf44=;
        b=Qkl0f0oT4rgLErB2MBWNuHcgckkSsMgHwPXx1adtqkhc/g+sTkzzTQmxZ3HSBCVukp
         2T8FLTV7oW4/4KyZYGbPTRGCXLN8WKKAp+DRKsLsLBzP2A13WUxbAymFrX9IE4nHb33I
         pz1EsAEomMVXoc7hA+RQhDRcIJEIgPerLZRKxYDqTtG2w009QUBmTFU+Mk21nadvBoa0
         NxbxPxnmI8aBYUuL/7+oJkIjkLMuzmT8kt9dbagSaL++u4YmqlHPyppXNhoFJEsxnBFZ
         5hjWVWhsPg7cJY+8w2JAY6+weDROWWMBzfGraPXihl+M52hdia50Y5K1Kxr5SSrIgMUR
         iqPw==
X-Gm-Message-State: APjAAAWiS5qTSFaoEK+NN7hYj0CFcKfuMxszGNunZnF9HehViXlWNbgX
        cMBBJcee61X1scQuUDKTrAM=
X-Google-Smtp-Source: APXvYqxYm1jADNAExQVyud8MIdtnf2FQEfrx6aLn1FkM5FMS+sO9pAHQE157Mq03gXG1po6oozVtHQ==
X-Received: by 2002:a19:6753:: with SMTP id e19mr18200363lfj.187.1565558675021;
        Sun, 11 Aug 2019 14:24:35 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/19] PM / devfreq: tegra30: Keep interrupt disabled while governor is stopped
Date:   Mon, 12 Aug 2019 00:22:58 +0300
Message-Id: <20190811212315.12689-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no real need to keep interrupt always-enabled, will be nicer
to keep it disabled while governor is inactive.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 47 ++++++++++++++++---------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a27300f40b0b..8be6a33beb9c 100644
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
2.22.0

