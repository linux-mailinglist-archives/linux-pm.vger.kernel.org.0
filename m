Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095F37ADC5
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbfG3Qcd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35782 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732810AbfG3Qc0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so57213824wmg.0;
        Tue, 30 Jul 2019 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdIejvgC5kaa3wn/Z/zklRDPf5qDMoTs2AWg86KAKyQ=;
        b=D5TqpdBRVqAqqkcVW611wKboN66wqHhvyBXZmkN5Cs4e273DzmFV+h4/GrtALNRUSJ
         x8khvlkAAoVOpQ37fPdwufK7IqfDMGCQEbzHxI01spFwtTO9d99DFHkrUkfKP+mlzMYn
         BYUHUt7DvdftF0gdAarEy+1uB5bpwhf1tiWZ5uKBB3mTZSC+bFm5Jb1FJ1KBpRt+zOCx
         vyySytsAR8QwcyYUaeHZvScc0u+5q90wKWaPlupXK+hMY3AWLLVhPtQ4paGV0hf+2NVo
         LMH8mwvn5uBMaV5Hly9PdVcj3y1I+rOVVx1ebaFbPL8HScoJTTJoFC76el6PQlrF8/0x
         qVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdIejvgC5kaa3wn/Z/zklRDPf5qDMoTs2AWg86KAKyQ=;
        b=ELQd/oE1py6q4e4qQzbIODyS8YUL2+WRj5P2oo6yx5iTFwyku4upL80hNqE0W23+9y
         5W9DrRgexbuLCQn8bTMeQENevTp8ankiLv+zZB9WAKXLpCUZaCVxsK+sIXEjArQAJynD
         kB9nzk//zCj+briBGf5Y7lwIOMsyNoQRlaor2/+kUhjE0TBjGjZP3BmQv1ok3a1OToBJ
         trt/WUBiM9ihx6ear94LhECRWyAhvOel8PCYsYEEtTMnxZkRKQR6w5kM+cYIoT5FDJds
         SV0UaKxYAqcZc16oWuOHOxc9hJVXjXKdqzIQV+3ilviiAUmRJdKw5PHjof6ZPdZtsDAI
         zjsw==
X-Gm-Message-State: APjAAAUFj4Ip3BVf4+3pkmhdKcp3zqKw/kQM2kUhOuJtKxF5+ei3MO8x
        rxSyznl1D6lQjkbuXm4NJ0g=
X-Google-Smtp-Source: APXvYqys4KDqUTalkll3A+irj2HQVD4jyQL/DSD/vHU0bHldNWGX4UeyFKyJSxwHIq1EgzEplK2QGQ==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr109441547wma.90.1564504343908;
        Tue, 30 Jul 2019 09:32:23 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/20] PM / devfreq: tegra30: Drop write-barrier
Date:   Tue, 30 Jul 2019 19:22:20 +0300
Message-Id: <20190730162236.6063-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
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
2.22.0

