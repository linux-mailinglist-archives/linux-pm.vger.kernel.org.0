Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AF211037
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfEAXmA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:42:00 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36585 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEAXl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:41:59 -0400
Received: by mail-it1-f194.google.com with SMTP id v143so368681itc.1;
        Wed, 01 May 2019 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9QwYS9bQr6zIIDqya7O/hmsOjlwL0wV6gZaAMteb584=;
        b=Rz9S0GfFzc4A8XwKvKPWK6NWM+Fk4CbRC4AjmdPpebD+IyRoyUNo8UtMP3eud+Gmd+
         0LDLFW+zPi79Qhx0IsMKsm6N/r/kMUkAMWk+q9xvzb1Wk9a4oYRKQdTFSxZUxUwgZFgw
         A8WUnIo4QskgtncNIWH/o/ccSNsfenYWLniVnSfoyeseiBtqm0E+OME3u2fGCkfM74h6
         PK43lbzQwsRXWszK0zpVQCoDHr0BgB5n1Hg5aSDJMNN42m/HCJoymqOf8AKzc696Kfcz
         7iGli+QVjl1mb+HR7hE3PODcOeDlOS51YsKsw4FasBsgT3THaFPV2DoBI8ACGd6GhPRH
         dyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9QwYS9bQr6zIIDqya7O/hmsOjlwL0wV6gZaAMteb584=;
        b=VHRydZdE9g09bewRdJN6zDt03UASCshxHCx/M3XBG2N/jzPGYfmN8xoMRGLr6Y1gQ4
         7wEQSvxvbGTYrf4dBjEQfWi47cQRjrO8UoDBK7TfWfRnp1BwVCwKAGSVv9j7d8GkcvmE
         1Xpxx7DdTerdxs254+zVAxu1MeNIEWvbKUz0++ZtiK6OpGA2YorJG9cjDoBEo+CSQ0Ug
         QPYor4xMd/bHiFPzCfWdHictgjwZwPh6qtJ7CAkKo6lueLFSB+SWflON07aaw69AHdvk
         axllYJRyMvhQ8rUA7QizYh708zhJEDcTHies3mIJT8hMnfg5Mf1oMEKk6n+dYMmfiS2V
         YJgw==
X-Gm-Message-State: APjAAAUdu/1MrtMHZ0W7461pXNYwv7YWOO0yOiveGWC4yfTo0kF8Cufr
        D6JAqOjrTIzr7t6bRQbsDxte20fx
X-Google-Smtp-Source: APXvYqzUOhe67dmWZblJCILuzz0Q+Hxn0lkadBy1Jtd2JFyAMJSq9relHK3Vbaj5fue+xqd7U1jFBw==
X-Received: by 2002:a02:4482:: with SMTP id o124mr305454jaa.121.1556754118389;
        Wed, 01 May 2019 16:41:58 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:41:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/16] PM / devfreq: tegra: Properly disable interrupts
Date:   Thu,  2 May 2019 02:38:06 +0300
Message-Id: <20190501233815.32643-8-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no guarantee that interrupt handling isn't running in parallel
with tegra_actmon_disable_interrupts(), hence it is necessary to protect
DEV_CTRL register accesses and clear IRQ status with ACTMON's IRQ being
disabled in the Interrupt Controller in order to ensure that device
interrupt is indeed being disabled.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index b65313fe3c2e..ce1eb97a2090 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -171,6 +171,8 @@ struct tegra_devfreq {
 	struct notifier_block	rate_change_nb;
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
+
+	int irq;
 };
 
 struct tegra_actmon_emc_ratio {
@@ -417,6 +419,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
 	u32 val;
 	unsigned int i;
 
+	disable_irq(tegra->irq);
+
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
@@ -427,9 +431,14 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
 		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 
 		device_writel(dev, val, ACTMON_DEV_CTRL);
+
+		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
+			      ACTMON_DEV_INTR_STATUS);
 	}
 
 	actmon_write_barrier(tegra);
+
+	enable_irq(tegra->irq);
 }
 
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
@@ -604,7 +613,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	struct resource *res;
 	unsigned int i;
 	unsigned long rate;
-	int irq;
 	int err;
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
@@ -673,15 +681,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		dev_pm_opp_add(&pdev->dev, rate, 0);
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
-		return irq;
+	tegra->irq = platform_get_irq(pdev, 0);
+	if (tegra->irq < 0) {
+		err = tegra->irq;
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
+		return err;
 	}
 
 	platform_set_drvdata(pdev, tegra);
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
 					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
 	if (err) {
-- 
2.21.0

