Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E314ED4CC
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfKCUmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35619 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfKCUmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id r7so6698866ljg.2;
        Sun, 03 Nov 2019 12:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1R8aUcZkIlTPITklCBswnMHd9GSu3KTIu0/oTyANNB4=;
        b=tyHT74I0qqP4BwK4y53uUcNEFhqPMhLoCqa13AUlJT7dRyyHotgHnEN+ActR/Bho+0
         um4QRxG7C8+Q9V8rVa9q4II8DMZOT0FhLuczmigj038OSIdkbZHMO3TBPgj7T9k9f1jr
         lk/QUMCW6TD4qDZxg3UuIthIiAVlXk2bCAxojsbuNiXE6WiqAGYOypQLQ42cmVbq+X9V
         O6J3NZ5ObveWNqQP64il/axxgZHuj1giZ/bOBNr0BA9FEXNSaHWGoA7pwYCKPKRRpv+z
         K2m471i+bSNvERDzow5COmmVJ19f+LF+ddwqxBJRpZ6E5llD9uCqUcDg6XEnhbzlYoen
         3hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1R8aUcZkIlTPITklCBswnMHd9GSu3KTIu0/oTyANNB4=;
        b=PYU1GKO7qW5DPp2SFuFM/GLPU1HK2jTwa9vViCuesz7dmureQmN+EcDanW2+JVvSsL
         4K0jzvimqoo3EvC1PywJbGXn94qn6IX8D1wkPKzEolZY4+bH9IC7Zq28+sWJ1XB+0kp+
         kl2MjtPgsNeoH1x6zaGy6freS4Qnj+4uJNlmvLN46LJ35AgVWuUlCQwwTjfqBlmoxduK
         5QZgX32g7pCIG6kmKHPe6goNfjd8FIvEHsQlPtYEjDtPySnxtZblu97skUw6nDVIhRSX
         6CsMglkwUAXxOhlzndbqdSfrjYX4I1HpFE8+QyVWBomse8nWE8HXDd9lavhosm5SMIOf
         8wxw==
X-Gm-Message-State: APjAAAWejuUfRjZ6y4wGqxeietdazaLMBxeo102jEp2+CjRmq95POSS+
        06Iz0lluouvBYqi3WYO7KcTYpDzA
X-Google-Smtp-Source: APXvYqy8dKjwqpq8cW2Xiq/f626EVsnBl0Ei94GtbUr8hK2HPh1b5iQE9LjCeHKuoFoc9NoWqK3a2Q==
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr16366102ljn.88.1572813735048;
        Sun, 03 Nov 2019 12:42:15 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:14 -0800 (PST)
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
Subject: [PATCH v8 13/18] PM / devfreq: tegra30: Don't enable already enabled consecutive interrupts
Date:   Sun,  3 Nov 2019 23:41:25 +0300
Message-Id: <20191103204130.2172-14-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Consecutive up/down interrupt-bit is set in the interrupt status register
only if that interrupt was previously enabled. Thus enabling the already
enabled interrupt doesn't do much for us.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 7c8126e74750..4a5d513904a2 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -261,8 +261,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 
 		if (dev->boost_freq >= tegra->max_freq)
 			dev->boost_freq = tegra->max_freq;
-		else
-			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	} else if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) {
 		/*
 		 * new_boost = old_boost * down_coef
@@ -275,8 +273,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 
 		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
 			dev->boost_freq = 0;
-		else
-			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	}
 
 	if (dev->config->avg_dependency_threshold) {
-- 
2.23.0

