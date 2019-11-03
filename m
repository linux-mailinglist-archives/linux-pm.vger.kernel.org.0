Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F6ED4D2
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfKCUmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:44 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38871 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfKCUmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id q28so10720138lfa.5;
        Sun, 03 Nov 2019 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vussPT96FtSPVjSwb6+813KWc5582WBbmxbN3o4f6zQ=;
        b=qi5NWGwpRx8CC3WhyqXde/QVyE216CXq7ThoLSEtQpHnKO9skfsgD74sc+ixnuvO9f
         d5iHPqFHqw8uWLaTFp62ivzZZEPNHPfBduQK/+ex6x7oANlAVgm35tCDdI048VBULW/3
         zdAhWL3c7VmJG83CjSMIIAMSRP9b5tGWAipMo0h0PliG3kntEnb2ZnHBdEM8TvvZsVJ5
         0KlvM0e3ZdLyB2yrcR6pF2waPKJVAVFlOgXSQmprlwXtxzwmcT1U87RrUqZpCKFxZRSr
         RRAiNC3IATBKhbQ6D1rv/mOq5l6AAS5f51yA5syaInZPBSZ+MLFxKfeU6A1zgCHPonGc
         vipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vussPT96FtSPVjSwb6+813KWc5582WBbmxbN3o4f6zQ=;
        b=FkCJ/BMCPeAgcp0oDUgsfhY/LZy+5znPA4ggkGoJkiMa15jTYCM8tEsWOgP0OtsB3q
         qd2vJJG0jox60KQFCHI6HfkKpjoWZjKaDTszmgCK+xiErIxK/sCVgpSVf52+UNevjcyI
         4SGp5yde1qm8OVk4yA/577GlrjoCQ8uGDUAxGsBmBsvjdCFCNGGqEDopFfbt9hcDxeFq
         LQYJ6utZ5M5r4kJHkkLztlY+m3yMiHqRc45tnqxHFSB9a947ikC9Qb0yuJG9htXXvEFZ
         UKBJ96m0OZkNOLvc5MJ+z4EDt6/VgXKpZINhdS4DcjVHa/2LGjaFt1phmxieXvOiouaM
         XfAQ==
X-Gm-Message-State: APjAAAXy9MCF4gHmn2j90O1PXYQnEk2SeE7KvgpovU9NcAjUgRIKJ2QF
        aYRwodeEHWdEyfmAEmcm9o0=
X-Google-Smtp-Source: APXvYqyGOZrKkCxmNJyvg9JaKS1KwK5/fHPFkJK5mY5hP7Kj5hHpEb0FQQTskP50q9BLe1elDZeLBg==
X-Received: by 2002:a05:6512:1cc:: with SMTP id f12mr14780530lfp.183.1572813736002;
        Sun, 03 Nov 2019 12:42:16 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:15 -0800 (PST)
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
Subject: [PATCH v8 14/18] PM / devfreq: tegra30: Disable consecutive interrupts when appropriate
Date:   Sun,  3 Nov 2019 23:41:26 +0300
Message-Id: <20191103204130.2172-15-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Consecutive interrupts should be disabled when boosting is completed.

Currently the disabling of "lower" interrupt happens only for MCCPU
monitor that uses dependency threshold, but even in a case of MCCPU the
interrupt isn't getting disabled if CPU's activity is above the threshold.
This results in a lot of dummy interrupt requests. The boosting feature is
used by both MCCPU and MCALL, boosting should be stopped once it reaches 0
for both of the monitors and regardless of the activity level.

The boosting stops to grow once the maximum limit is hit and thus the
"upper" interrupt needs to be disabled when the limit is reached.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 4a5d513904a2..852bde6249c7 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -259,8 +259,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 
 		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 
-		if (dev->boost_freq >= tegra->max_freq)
+		if (dev->boost_freq >= tegra->max_freq) {
+			dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 			dev->boost_freq = tegra->max_freq;
+		}
 	} else if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) {
 		/*
 		 * new_boost = old_boost * down_coef
@@ -271,15 +273,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 
 		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 
-		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
-			dev->boost_freq = 0;
-	}
-
-	if (dev->config->avg_dependency_threshold) {
-		if (dev->avg_count >= dev->config->avg_dependency_threshold)
-			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-		else if (dev->boost_freq == 0)
+		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1)) {
 			dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+			dev->boost_freq = 0;
+		}
 	}
 
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
-- 
2.23.0

