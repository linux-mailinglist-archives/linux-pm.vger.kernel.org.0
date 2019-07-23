Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796C4711BB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 08:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbfGWGOp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 02:14:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44993 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbfGWGOo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 02:14:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so20151856plr.11
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 23:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSy97MHTyvjB+tNxNcL94WmxX39zNt2juy/xtyGFT8Y=;
        b=qtTFfvyZQ+n3BuQV5HhEc01LRgT8Q3RVePNpiuu1aFBWLZo5PygfiqyPF5qZVn9kMs
         Ap/gS6I2/VtC79MvUUIFxAKz6PdL+jGvXs+qAQdfW+vWgCs0L5x6oMb817ZLrMRe+HJQ
         WQpmjP9g8/XywOFL87iUm1K0rWmzH6s0K/FknZkn08PcKHDV9j9derGTZZzn51hs2CvT
         bcbSjLS3S1IYcrl3kb/7UKnHwtQZcYDaFH2WL5o7WNBYy0kLw3qMjxeMVKpIO/5avxle
         slCcswwRW/HdUXQIyAaM/e+zokBpHfS8HYwRX12Njthf0f1F944t4XBK4n+1xmq6SCdT
         dckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSy97MHTyvjB+tNxNcL94WmxX39zNt2juy/xtyGFT8Y=;
        b=D3hMW8dQu2mJAM8D+ffHsulU2q6/sE2RclTn9JodSY+lIRcg2FxpKAIyF2ilB+xx9P
         14y8VXYaDWCo4a16AkYeHBPjQXHAQ00PAKgLc8PZ7yKtfu+kKGCicyMVud2jYTF7nWF/
         Gt/TCncsys4AXf89akmVakDWZ20xAVDaI8E0zIdIOB3tT0nxoGNLnMd2JM4y3fVugPvK
         zQpPToVD4gRYyceR0cvBJxLiGOLl3NAsoWWCX9w9be2VPrYqCCi7kQDDgXOYElDCI4Cb
         POVcY7q8IWBbqEnlgagaVrF2CJ2cOZI+NSvUQDORxZOIfL17NzSaU5dDQKRYGD+peA+F
         pgUQ==
X-Gm-Message-State: APjAAAVvr493ay6ZmcBvSma4/vpI8SUhSi1VVeQQ5B2HqxjsJ7q9U0Zu
        y2kqbFdN+qs69HWocy57aqvX1w==
X-Google-Smtp-Source: APXvYqzUcFU3wsNIG8Q7OYgyK85j0SXIDJZX0XAXT4Zwbjja4zDuD7rUEYw8CerpGmcATZitxlwbIA==
X-Received: by 2002:a17:902:a504:: with SMTP id s4mr56706631plq.117.1563862483299;
        Mon, 22 Jul 2019 23:14:43 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id o3sm76723419pje.1.2019.07.22.23.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/10] video: sa1100fb: Remove cpufreq policy notifier
Date:   Tue, 23 Jul 2019 11:44:07 +0530
Message-Id: <b8ed154787c6930c9d098fe549fcfe52c82ad762.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
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

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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

