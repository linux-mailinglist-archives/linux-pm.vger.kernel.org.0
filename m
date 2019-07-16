Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4906A5E7
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfGPJzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 05:55:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35074 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732315AbfGPJzC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 05:55:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so8870643pfn.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wglnm+6yqzntyC9h13b4Wh3S/G9NJM2x5q1vPNkqSgU=;
        b=Dnnh+kwHRtS9hSr7z8dtYzFB/z6nWaIrUpsWPzeEf7Pb6hhhWP8YrQn6phTamDKNCJ
         r5ZsKcNuHQ+Eu35xX8eqMfOOc2GB9DW4slEjuF3JodDKrfbAZJm9l1Ooet/IVl5P6S6U
         Sz0UkF/tUwYvWd5MgI9me+GK3bjcCp8fr/g4H4xmlOpIqjjnkxFBhnxIteeX/R5pvcTo
         fFbz3ZpTfK6TPS/8AIdScSwOH9C9MzZ0EwKDGaxCnoaw6xQARQ5I0erDT6lXSXHRppbI
         cXuEmVGUB4B7r+3GGUarHf2AwnUa4MWpRJhKm59XYpfXh8j4IV3qZ+BtA2LAN7z6OqmG
         mGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wglnm+6yqzntyC9h13b4Wh3S/G9NJM2x5q1vPNkqSgU=;
        b=gxzUQ9LlHWOdPFwm8WBxH9Bq9Ni0vSz5Kx8AKwKSy3PttNHHKRwtTxWmqHP71KG3F0
         buvszFk7bMiSJdp3R66eHHQkOMW0GUVOBqvtWFmJO1nL1kLmALBw8fPkwhI89jFkFM5L
         aB662W4ue/9tjR4cunYu0w+dq4310xsBnbCsx3SJ1LDXhLA3ZRSXW3bZhEIgpzev9BOX
         DVGqA+zVmEZyi1tPSRFEDKQTXFVO4CN/DBw3BYKJwPesCDv36FckUQn3coiH7g5w5keu
         Pu4jgz8m0UMetcd43YIzF4k8ghm3CML6r5DR08fbxATo3BLp+0fptlo9UkUHPOuxk83Y
         5Omw==
X-Gm-Message-State: APjAAAWNvfoR9e43cczODbza/jaR5GqMsl1qmb2hU0LQzdab21c+q3Wh
        SGNujWcMCtEFZuVZBK/gfQYemg==
X-Google-Smtp-Source: APXvYqwE4djRSjudt1aj7hnAPyyjlo+Rw7Ep4ui1p1jCkZWoK7MWPCNdhvgpR/DouQUGSOiXwWBkjg==
X-Received: by 2002:a17:90a:8c90:: with SMTP id b16mr34610804pjo.133.1563270901894;
        Tue, 16 Jul 2019 02:55:01 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id o14sm42384517pfh.153.2019.07.16.02.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:55:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] video: sa1100fb: Remove cpufreq policy notifier
Date:   Tue, 16 Jul 2019 15:24:46 +0530
Message-Id: <7163e57cfa1780d42732fa6b5ec424c24d1d4dc8.1563270828.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563270828.git.viresh.kumar@linaro.org>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq policy notifier's CPUFREQ_ADJUST notification is going to
get removed soon.

The notifier callback sa1100fb_freq_policy() isn't doing anything apart
from printing a debug message on CPUFREQ_ADJUST notification. There is
no point in keeping an otherwise empty callback and registering the
notifier.

Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/video/fbdev/sa1100fb.c | 27 ---------------------------
 drivers/video/fbdev/sa1100fb.h |  1 -
 2 files changed, 28 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index f7f8dee044b1..ae2bcfee338a 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1005,31 +1005,6 @@ sa1100fb_freq_transition(struct notifier_block *nb, unsigned long val,
 	}
 	return 0;
 }
-
-static int
-sa1100fb_freq_policy(struct notifier_block *nb, unsigned long val,
-		     void *data)
-{
-	struct sa1100fb_info *fbi = TO_INF(nb, freq_policy);
-	struct cpufreq_policy *policy = data;
-
-	switch (val) {
-	case CPUFREQ_ADJUST:
-		dev_dbg(fbi->dev, "min dma period: %d ps, "
-			"new clock %d kHz\n", sa1100fb_min_dma_period(fbi),
-			policy->max);
-		/* todo: fill in min/max values */
-		break;
-	case CPUFREQ_NOTIFY:
-		do {} while(0);
-		/* todo: panic if min/max values aren't fulfilled 
-		 * [can't really happen unless there's a bug in the
-		 * CPU policy verififcation process *
-		 */
-		break;
-	}
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PM
@@ -1242,9 +1217,7 @@ static int sa1100fb_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_CPU_FREQ
 	fbi->freq_transition.notifier_call = sa1100fb_freq_transition;
-	fbi->freq_policy.notifier_call = sa1100fb_freq_policy;
 	cpufreq_register_notifier(&fbi->freq_transition, CPUFREQ_TRANSITION_NOTIFIER);
-	cpufreq_register_notifier(&fbi->freq_policy, CPUFREQ_POLICY_NOTIFIER);
 #endif
 
 	/* This driver cannot be unloaded at the moment */
diff --git a/drivers/video/fbdev/sa1100fb.h b/drivers/video/fbdev/sa1100fb.h
index 7a1a9ca33cec..d0aa33b0b88a 100644
--- a/drivers/video/fbdev/sa1100fb.h
+++ b/drivers/video/fbdev/sa1100fb.h
@@ -64,7 +64,6 @@ struct sa1100fb_info {
 
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
-	struct notifier_block	freq_policy;
 #endif
 
 	const struct sa1100fb_mach_info *inf;
-- 
2.21.0.rc0.269.g1a574e7a288b

