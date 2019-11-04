Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E46EECE0
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbfKDWBG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:01:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42651 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388949AbfKDWBF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id n5so8386053ljc.9;
        Mon, 04 Nov 2019 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TJlQkVC15YK1Mmhxs/rkGDrxgdE3q8G1rLTH1Ltzd0=;
        b=Lk22YzHxOA6nZMYEhNYYDGLVMMEMhzir8xS5idni7f5IYzZjCZaj9Q+YYENzfL3p8u
         /2x4vO7g6qfU9AKhXo3a6xsK4ILwpqI8ZNXpQqbhMHDMxOJBkO8QA3FKfY6EkFFKXaUa
         9jY1Pccw7Lt/+YlxE1jxTXtSkQv8IrFX4g7UJUnBX0iD8NfdRfTWHkMJg30WjyohxBhA
         5Wvam17LnlDk9ofTk3gN/hh1HBQeBMXksrzqUqF8uaycRGuplTTvh+MQhl41hYjMtXAV
         mkj1pcUwWHqiS/I72/mpSuZXeAT2lowh/fmrr4PLF9bp1TofO8MPBc9Cj3A7XV7Fnwah
         Cewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TJlQkVC15YK1Mmhxs/rkGDrxgdE3q8G1rLTH1Ltzd0=;
        b=HJgRhDN3ORM1ermy/0i78s2G9gHqNREXsqnICV7tK7Ps1Dk1RSmNheF2Y2XbTVzLpU
         D1JF+UUu97EE/HKvdojshQ1NaUiTrKGcVU8mhD+6s7aN+iGAZE1l0UY+i6RELEl3gliD
         tCa9gANANnxSZN8mnc6YgVsLYCd0M8UldYVPyW/V6IU4utBxLGfyzlkvLm2eNy2Mti/7
         cA/PAtbt0lERZKDjiTAIKnargO1b5pVBXzGi6GcQulAKNAMgoutVIIAm9OvbPAnENog/
         T/hwd6es1PbHSci46Lb7ARW/9J/4KJh3uMVf7UXuvD9c9FuIArumYUBSqaFp8X3UKXpd
         OzNA==
X-Gm-Message-State: APjAAAX97n8rdl3ITVLtfCWgKpxMUhDoK9TP0uJw+SjTZNGyM1DT/u/m
        TotowGEQLjQ+8B1LyY/En9M=
X-Google-Smtp-Source: APXvYqznNX5QtPgSIWUNQdtXRtK+09ntEdga9YULTtdrABGJbd7AMffoE6v9Xpm/JZ5MjpMFW7hlOA==
X-Received: by 2002:a05:651c:313:: with SMTP id a19mr20494836ljp.199.1572904862997;
        Mon, 04 Nov 2019 14:01:02 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:02 -0800 (PST)
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
Subject: [PATCH v9 04/19] PM / devfreq: tegra30: Drop write-barrier
Date:   Tue,  5 Nov 2019 00:56:02 +0300
Message-Id: <20191104215617.25544-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
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

