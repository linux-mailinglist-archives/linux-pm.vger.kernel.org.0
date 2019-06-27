Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F2C58CD8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfF0VMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:12:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34112 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF0VM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so3821868ljg.1;
        Thu, 27 Jun 2019 14:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/7wNA8MAMSp7e/mZW/Vod5RtNn1ZWLvCZTV21PmCFE=;
        b=gLge2vHo5do+7r4r0bL26vMpLajr9TZVUjJJhfcWTalxPfqAAXR6a2uko7j3HNl/D2
         peyYszztdWgalKra2DCx8Ymi+4tyPA2VD/Pzk7Wa69c7W9z+xWKPV1dkwMCTtWqscVnW
         WqXQ5Bnh56bbvNg5LNwuhN1N/jpuPK4VDAzeJXOAepHMapnDyW6/9lB3Eu/9GLM4uFNK
         DjjGj4tyNqqnCn1N0Vq/YNdA8I+OoIM8m1nMYYKagAxHStunPMGgjYwwV5QPj4nzD6gY
         97+tP61FsaCin9HIxmdJyhNdWikqSWss+NnjuhuCiwDdIHqvU84jGfg5UtJlEPOTK6o2
         bUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/7wNA8MAMSp7e/mZW/Vod5RtNn1ZWLvCZTV21PmCFE=;
        b=H76Gr7gA/Pv+HloAox+jOD0Za+7m8l/KkMCFaM+zoumx6kzswqw8W21TNm+uuIJXUo
         WxlKO7gKdhGHbz86+bHJyAz98lI9NnqR6+3EYXfgw0iwoO0s7dVS8LKn573U7svHV+Ad
         WnqJ96RQdnKe9No0rWLOvDVP4TDLQ2sJ97Z2fiSd9oHqlm3Tn3UIh0+QyivX1ugy4THw
         mqNEipSYlDiswyWWqtsjUQctFSuFfcp3EF95ZssqI5ymf585IZ5mKK4Xsr7b/Unbar2q
         W1gfXZZryWV6d19IJCZ0TS97ULApKATPqOkjuO/rLSWrwxuHZHnnKZnTLtIjm/rYA83y
         HLAA==
X-Gm-Message-State: APjAAAX1XY0/ORH4KWJTN05rE++r75hykI482sYEqp1jorgc1ITPFCk1
        vk3G4xkAXBhPeiv5ir0RLNk=
X-Google-Smtp-Source: APXvYqzIRuCGJFX5UC7LkYRyrVE4Nnb5+zepyOmw8cyh2c/Bfir+ZPRGdgN+WhVofsm9OxssC1CxUQ==
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr3924653ljs.54.1561669947669;
        Thu, 27 Jun 2019 14:12:27 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/22] PM / devfreq: tegra30: Drop write-barrier
Date:   Fri, 28 Jun 2019 00:10:57 +0300
Message-Id: <20190627211115.21138-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
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

