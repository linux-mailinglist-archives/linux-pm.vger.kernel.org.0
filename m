Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECB9EEF10
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389839AbfKDWTB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:19:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35906 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388992AbfKDWBP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id a6so10055788lfo.3;
        Mon, 04 Nov 2019 14:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vussPT96FtSPVjSwb6+813KWc5582WBbmxbN3o4f6zQ=;
        b=YDYzQa8Fq+Cprh60WDBen1OPYtQavoJAh2WTKty0HKuU+Ya/dVRr1LhNdALp/lNEtp
         IvnLJvDnFeUYwEteM2JNxtogCvz8YfbW6I1oys7heTjlvG2SBcnC0ndVH3uF1B2bXw6s
         VZk5qpWkTTHzSKMdU4ONGbK/s+OxOh0JaUvnDtcutpmpABKeJQlg/6ybYeRWsdEiLxxJ
         C3iQLrq4cBZBqxm54Q/D7NltmXQITGUSSp550MSjTdqwfwdf59j7jRIWiqkCNjVJVakK
         +YaJpae6QZ6FzDBcH2DlvyCvtMwIv4ulHCVCKF3bWcl3/VFmvcJ64741t0cWKi9nFE+r
         hxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vussPT96FtSPVjSwb6+813KWc5582WBbmxbN3o4f6zQ=;
        b=ADXW5UBgLArlXPVmjsUKXcUdX3i+c+zIIOMppJ625z4fQcrPlghm3RvgMHvoha4awQ
         53ep+XzIa6YiWQRPl0VDUAe5i7aBekEg6ua45H2+DH787f87dr9CcW6H2xm03Zle2iQQ
         5fpiW3UnyZvTVl46vyzbmiOR7aMdfB67cCcfhig3baGzZzYbFajAh5Ul67HXvHHEp0kI
         oNSSxgxdtrvh8JSV9NUQ/F7xSq7GdCyPfne+7PIqLrVQxMJjFAXmqxXvE1BKHGG0ZBmu
         ydN/ZEwaNdBuosrg89tJ5Z8b2mLiEP0luRaUto86B0JnVpEDtx3/Rh6FUpD1Bm4nRnR1
         1whg==
X-Gm-Message-State: APjAAAWr4AGNUtFXlrMItXQj/ixWKHhxmg3dSYveVlNdZlBHmZHuEVHi
        Z1ddNQxrYgBJm3Hq1+975tE=
X-Google-Smtp-Source: APXvYqzszaal34wn8DMXeS1z/UAh6z+OO3f2A2KgXGOoTN1Lezkr4LrIPvW4BdwQzPzUoLshT4Qurw==
X-Received: by 2002:ac2:4357:: with SMTP id o23mr5831872lfl.51.1572904872931;
        Mon, 04 Nov 2019 14:01:12 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:12 -0800 (PST)
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
Subject: [PATCH v9 14/19] PM / devfreq: tegra30: Disable consecutive interrupts when appropriate
Date:   Tue,  5 Nov 2019 00:56:12 +0300
Message-Id: <20191104215617.25544-15-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
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

