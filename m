Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75AE92A4
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfJ2WG1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44547 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfJ2WG0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id c4so311403lja.11;
        Tue, 29 Oct 2019 15:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGeUVMV8ROYKw/oLDpG/CxKvBJadBoWlFhWc+EbGo7w=;
        b=WPuZrbXsLzMAMPaUeCy5etQUwyAs4e071WGXX8LqfZgY3zrcS+uUMxmFZVWRULGOyV
         jK1ExE2ZZ4lAM0cpuUgBSBavNFfc1nwV6hCRQ/EJlZTpWJERqxnGNffCPO16xaCvHm7j
         PvBS3nvrqg/s36goYNNbnBtl6ZSuPfkc6jeTr1PGdXpEkQ0THUaznFxhtbbcFWWdrd4K
         LDm+N6aX1PTEXU+n5ll+8UYPil7nfF+pwFyBagMwikAooQjtLeppvexzcTOJvRoiBzLN
         V1wxxC6nv7MDe/nWf+YC7PDuV05CUaiGl0JoVqK703zuacj9csoMJXJ7XBCyuUl/AEDB
         YYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGeUVMV8ROYKw/oLDpG/CxKvBJadBoWlFhWc+EbGo7w=;
        b=qi5Zxrpzh5RpOvMKoWmDQbWdHNp7vOMm3suPPZFWnv//1AM10WeJa1t5ezQjCGCO5x
         ip7Iz6ugaeC+uQpIGM8x3UIrQEC5tST5kyPAl5vkMuDtPUEmQNPCpycoRM59KJSAs64b
         UxjX5M97pSsvalQVATH10aeLb35xXUDTP27Cr4rE0HWPvJQ+Oaue2PFhSZtIJq1/Neod
         rDZthyxYdfO/OJuWz3yCMAKEWAfRG2+dZaGRS/NvHSEHjCfq7fBH128HlDuaNUI2A7Mr
         XgEX6HgLP46i0xc6woM1kOHdwSANo3Y0xYndUOoC4Ah4XpzheiRZVP4o3Ls3cFvGafaY
         9D0A==
X-Gm-Message-State: APjAAAWWWkVYJW+Ntfb8bigMuTZ4vzXZ4S/i/KKietKOUNhzDS1KVCq1
        vzrzZW6S3P4bZu9oFZM60pA=
X-Google-Smtp-Source: APXvYqxd8ygyVgCkH30sQd3KvccIzGTZtJe+30zsw3vKic9q7M015G7Qmih3cFQIOPqNqTKnLdN3Jg==
X-Received: by 2002:a2e:7004:: with SMTP id l4mr4195778ljc.158.1572386784592;
        Tue, 29 Oct 2019 15:06:24 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:24 -0700 (PDT)
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
Subject: [PATCH v7 15/19] PM / devfreq: tegra30: Disable consecutive interrupts when appropriate
Date:   Wed, 30 Oct 2019 01:00:15 +0300
Message-Id: <20191029220019.26773-16-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a9336cf4b37a..b745a973c35a 100644
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

