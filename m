Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB5C4FEC3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 03:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFXBz4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 21:55:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34341 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFXBz4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 21:55:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so10955507ljg.1;
        Sun, 23 Jun 2019 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/7wNA8MAMSp7e/mZW/Vod5RtNn1ZWLvCZTV21PmCFE=;
        b=L0ZP1Du4UJarUZc83p78D1vv5rbMa++Zecy9gf2C/sEmE38z1CUDYNZtbdqay4oXjv
         wtksAbW8ZJBl1zkRqiyZxBgkX8zxclNP3TDtki7UUCskO8f0x8dF/zo+PGkI3o1Wnqi/
         i6i1VOtCbFLD/F3Q2v741iVE01LGiwX1OIlGCx2rdKdMxEs8UUvQzcLOIZkHeFzPEMmf
         O+7ntMgJr7LbUvO4wcmhMT1Nfm4+tdl01l7NalOAjFOQbmQ3xeWcBteQdGUGixM2iFP7
         l+1oKfaS1UXi747QDN2CI6R7McQFdu+ARuSVc4sAmUOw+bz4W9mIzlxY4kcIkY8+Jjrs
         6Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/7wNA8MAMSp7e/mZW/Vod5RtNn1ZWLvCZTV21PmCFE=;
        b=eZjr3sCktWJDTIrLc0rBRoTeZ2d4QbmRI0P8IOZS4UWqt0pyU7djDWyxHsPV5GzsX6
         hNmivaXrFz4nAeKJPTaXuq1Clf4clmwglvAVRV8Sk65jSZmK/3f0iCPM5N99byduvUxJ
         MXJ+v7GClFYjNnsk8Qaz2MstWrI0+K2oPDlJhbe0rKuix/UNYJ11wC6LZsQp7RUX/mjG
         Jjwnfh9nU0PIrtBj9RCzlvl54rU24ksnLFg6V0KVAx1CTZbyzVibh/C4cS+Hyg72/K42
         23PL4duwgJV2EP3q8EkneumOPjY/YXUqxCGsSlU0eypzBPqAG7DM4COCV2hPY4B0roOZ
         899Q==
X-Gm-Message-State: APjAAAXoLoDZTga7CEoJJVbpDBKKf1vaRNHci3Uu1OT1WN8bUkecRpUX
        F9tanAbAj0UVRlXDcElpZvD3LiDZ
X-Google-Smtp-Source: APXvYqye4V5QSFOGkNtJMg/FAidBFWD3G9IlC1/a8d7S+Cona5FygRmeQ/8Dbd9tuc2t39l5UnZS1w==
X-Received: by 2002:a2e:9250:: with SMTP id v16mr30382163ljg.89.1561326518772;
        Sun, 23 Jun 2019 14:48:38 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/11] PM / devfreq: tegra30: Drop write-barrier
Date:   Mon, 24 Jun 2019 00:46:51 +0300
Message-Id: <20190623214658.11680-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 5e606ae3f238..4be7858c33bc 100644
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
2.22.0

