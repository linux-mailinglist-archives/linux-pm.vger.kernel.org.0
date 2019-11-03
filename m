Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82FED4F0
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfKCUnI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:43:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32961 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfKCUmJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so15413718ljk.0;
        Sun, 03 Nov 2019 12:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TJlQkVC15YK1Mmhxs/rkGDrxgdE3q8G1rLTH1Ltzd0=;
        b=TwWa4wMnI3xZVNYvMO2/XPDoCdALbFiFHZpjPFX/nvKf3i+DtFUXsOXyHt64D+w7E0
         zL+EMdy7SKm3TGv8WnzT3lkJVQqIdbQL6sR8YmbuWBZdWrV6Jxyu6eHjrUNpBokjDvto
         hPG2gj724tiCX8XzCzMuFeEhu1QAlyZTZtURLWD3hB2eeDTfrY1Wc3+8hX0i7VqPNnjU
         okh1FVxnSReQAW/sTDB6FnfddQg7zSk6bhbqpwYiuvibLhxyj9NoEo4/JZSRvplx9vYi
         tVtzwQcJfJ2/42/qVobJINcep55gqyU2O42YonPOkG/c4UAr8x+oVZGTH+aYePzse5/+
         EIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TJlQkVC15YK1Mmhxs/rkGDrxgdE3q8G1rLTH1Ltzd0=;
        b=o7ENDz181H87aV6lkYjYEYODzVm+1hTy+f1la8l1HKBxkWuWRvoySpnWz2V4sBRU4i
         o18o7Q0/z8WX2P2NZ0T7zPMgvVHD/Og+c0Bk4anhtTDZONmPD0qV+vbTvQ3TI+ES8A4F
         wnagxjS6L4nhcWbIeFPJFVgOw2Ty/iOHlAvdSMozL8xhVYUIAGPS1V6vnE/p3bnJwrYX
         e2zhA4Tw+OSbtmaO02bLw74c3kcjfuyV8nM38JOkgDnUqOJqsZdHBPYeZxrPzlQDu3Fa
         BzkOzsDNqCZMlgH4LkKFl548/l22LOzspJKD/NboeOnkL4JYUmNMqauUxLPirsyaJA5u
         JThw==
X-Gm-Message-State: APjAAAX62J5lKKoaDQa/qWPRSmnVUvxPm4jTeW5XqfYzsWiLxPPYTGxw
        YjVPS8++lN4bfVn8QnM06nE=
X-Google-Smtp-Source: APXvYqyeUh0mG8EweUNk1W/dHbMzUHqX5gD/XSFr+xyWpWq9bAmZsfgW7Al7ktR7PhQ384gMSqvRig==
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr2313536ljj.248.1572813726175;
        Sun, 03 Nov 2019 12:42:06 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:05 -0800 (PST)
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
Subject: [PATCH v8 04/18] PM / devfreq: tegra30: Drop write-barrier
Date:   Sun,  3 Nov 2019 23:41:16 +0300
Message-Id: <20191103204130.2172-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need in a write-barrier now, given that interrupt masking is
handled by CPU's GIC now. Hence we know exactly that interrupt won't fire
after stopping the devfreq's governor. In other cases we don't care about
potential buffering of the writes to hardware and thus there is no need to
stall CPU.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 66dfa98d8c6b..b50bd1615010 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -230,12 +230,6 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 		      ACTMON_DEV_LOWER_WMARK);
 }
 
-static void actmon_write_barrier(struct tegra_devfreq *tegra)
-{
-	/* ensure the update has reached the ACTMON */
-	readl(tegra->regs + ACTMON_GLB_STATUS);
-}
-
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
@@ -287,8 +281,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
-
-	actmon_write_barrier(tegra);
 }
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
@@ -376,8 +368,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 		tegra_devfreq_update_wmark(tegra, dev);
 	}
 
-	actmon_write_barrier(tegra);
-
 	return NOTIFY_OK;
 }
 
@@ -423,8 +413,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
 		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
-	actmon_write_barrier(tegra);
-
 	enable_irq(tegra->irq);
 }
 
@@ -439,8 +427,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
 		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
 			      ACTMON_DEV_INTR_STATUS);
 	}
-
-	actmon_write_barrier(tegra);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
-- 
2.23.0

