Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D3FE92C6
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfJ2WGQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35597 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfJ2WGP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so368588lji.2;
        Tue, 29 Oct 2019 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5RDHttLYpRIWmCZzU40M1zvd0KRUNdeaYzRKxYm1SU=;
        b=mONUh6YxY5t7lIxPWLeFb5JNclTFd4SjnQyVIVMtt5heFA9MKKbFEFLrqglj83ObLO
         eXOcBgyzwKGg5l40EhYHVwp9nQ54oD7tvnN7PFuUB29JGUdAZ0CQSR7sGKlTTeBW1bfi
         usreYB+HWWYD8WPgAKU2qM4PjcL/SRqhNboVeQsKmaf7x18gs6P5d0lDc6C/Hhlll2P2
         PTTCbDGsjSbUrsYA8cxXNG0wipzlvkWIjNDYn7Oc8ZgYeT95DEuEoS3D96sn2ua+e/oW
         znSO2cpmD9LKFsaHdBXPjK3dAfDPb5a6VNufpqtyHvy7zmfdcU3bfwyb9m3/n0T2Iycg
         LxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5RDHttLYpRIWmCZzU40M1zvd0KRUNdeaYzRKxYm1SU=;
        b=FwIjDi74Q+eujkh28/QWGdOuWdqPrGheViZJrkbB6Ond0nCHEeyaW7bmeMW9mNFw03
         PnbQSpK+ytj+rqyvAq9/Q4BT4REpz7MlIaM2wbgHoWMpX6lzQv5X6Ih95SQyEOu2242T
         8X+httQts9dccMMyBlOZ9l/rTQG5/216Rmi8kGpgXZDnbd0uwylOowvp8FsI8VrJIcpa
         lYVQjf4qOK6zcLRE8AuHctOV66Qv6ofbpl0rp61+9DBBxog9o4WBj7RPMlm9EvIGaXXY
         SKeSYilZHl/qFotQ12K9Ct1oLMahNRufDFXJqvGo1lzmQma4b4OldxTu2jNRBmR/rEw1
         A1aA==
X-Gm-Message-State: APjAAAWKGS4TCvjwe/+592mpZkExPayPgb5g76tCYkwIS6j0J9GJTwQZ
        k8zGn5iQc8ZX+y6gcNYuzYg=
X-Google-Smtp-Source: APXvYqxg+DLZ0k/kOaXnO9ZV+ga2ZJvdf99///a1inLEtPjAbdsNuJofxm7NUE/68EG2mCpHhm31xg==
X-Received: by 2002:a2e:494:: with SMTP id a20mr4069890ljf.108.1572386773066;
        Tue, 29 Oct 2019 15:06:13 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/19] PM / devfreq: tegra30: Drop write-barrier
Date:   Wed, 30 Oct 2019 01:00:04 +0300
Message-Id: <20191029220019.26773-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
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
index bfee9d43de1e..ee14bf534c0d 100644
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

