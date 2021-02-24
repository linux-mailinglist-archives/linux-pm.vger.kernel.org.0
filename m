Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39F5323777
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 07:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhBXGlD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 01:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhBXGk4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 01:40:56 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA24C061574;
        Tue, 23 Feb 2021 22:40:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k22so603003pll.6;
        Tue, 23 Feb 2021 22:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tnfLHKb8PnK3wMlFGuTjuy8dr5DaMueUKDvEoOo23ts=;
        b=ooV/NUuBeLTvju2bqo2BCkPvu05YTvy0x7E73rn1ZUvznH6in3YIWeAXT53Qp4Sxh2
         uTBTm7Mw88eUKg4etJTddRf8oBZVSLq5ACgufuLGL+mrVc1wrsK56LDWcry0H5Z2k9SQ
         NKKTJ68GTXUtn+BtwuyzZ0cBTT2ov+CS/7+tO0mYSk2DSTzIctCC5DmtnX1N4KTlieCp
         V6EldqiK8B3VjR77gw9I5prYLD0lJmJmuRZPI2xHbz+94k0mo4pkZcbOPrvpdpzPiuMz
         LS7PZZESW1NXOWju32bBDCnoVAgfcIXGnSbKFJL7pcifC8ROK883tpzAqAC0kYW0OO+X
         ecUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tnfLHKb8PnK3wMlFGuTjuy8dr5DaMueUKDvEoOo23ts=;
        b=WVlspZ1sCdH9dp2KDB9DBJcAxVGV3jlUY4wRVvugMSbLPzbSA6I9dyr21AKYH+Sp5T
         TABGHwJrUkPTaK0U7ejJ6mvrVg7MH9fOgORyZbwJOKVc+kOl44UDD+GgxE5uwDwYSGxc
         bqyflvcorjuf1eDOQx7lQoxG91CLgOZMbTw25LwrxyB4vcaELjZKsqXEyqkB+b937iOg
         k3+QDoSyRgidDV+i3pjfvL/QMAevh0ELK3oqNHkvAhZh9jbWDfrwFV16O9JPBrU65xbH
         qa4LsrdEQZqQtqTxcV+eL59LAIpyPHHz1bjh0HAICfmn4eECXqfL+tEUHM2vilB0yBvq
         uGFQ==
X-Gm-Message-State: AOAM5338WYE6Ldqf8bQbj3dlWy7IOaynDOOTp9SDGFBeHHcpSFud8Sc1
        Yz2AMC+O2Eys/mIw2psq4VY=
X-Google-Smtp-Source: ABdhPJzfhIpP9eycfEJuLWaIZNlnuFikw6LElUxgzlG551RSSIOJFdm8o9rLnJOCyV/asXs202apfA==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr2899624pjh.141.1614148815593;
        Tue, 23 Feb 2021 22:40:15 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id w2sm1132973pgh.54.2021.02.23.22.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 22:40:15 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH v2] cpufreq: schedutil: Call sugov_update_next_freq() before check to fast_switch_enabled
Date:   Wed, 24 Feb 2021 14:39:27 +0800
Message-Id: <20210224063927.1298-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Note that sugov_update_next_freq() may return false, that means the
caller sugov_fast_switch() will do nothing except fast switch check.

Similarly, sugov_deferred_update() also has unnecessary operations
of raw_spin_{lock,unlock} in sugov_update_single_freq() for that case.

So, let's call sugov_update_next_freq() before the fast switch check
to avoid unnecessary behaviors above. Accordingly, update interface
definition to sugov_deferred_update() and remove sugov_fast_switch()
since we will call cpufreq_driver_fast_switch() directly instead.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: remove sugov_fast_switch() and call cpufreq_driver_fast_switch()
    directly instead, also update minor log message.

 kernel/sched/cpufreq_schedutil.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 41e498b..65fe2c8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -114,19 +114,8 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 	return true;
 }
 
-static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
-			      unsigned int next_freq)
+static void sugov_deferred_update(struct sugov_policy *sg_policy)
 {
-	if (sugov_update_next_freq(sg_policy, time, next_freq))
-		cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
-}
-
-static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
-				  unsigned int next_freq)
-{
-	if (!sugov_update_next_freq(sg_policy, time, next_freq))
-		return;
-
 	if (!sg_policy->work_in_progress) {
 		sg_policy->work_in_progress = true;
 		irq_work_queue(&sg_policy->irq_work);
@@ -368,16 +357,19 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 		sg_policy->cached_raw_freq = cached_freq;
 	}
 
+	if (!sugov_update_next_freq(sg_policy, time, next_f))
+		return;
+
 	/*
 	 * This code runs under rq->lock for the target CPU, so it won't run
 	 * concurrently on two different CPUs for the same target and it is not
 	 * necessary to acquire the lock in the fast switch case.
 	 */
 	if (sg_policy->policy->fast_switch_enabled) {
-		sugov_fast_switch(sg_policy, time, next_f);
+		cpufreq_driver_fast_switch(sg_policy->policy, next_f);
 	} else {
 		raw_spin_lock(&sg_policy->update_lock);
-		sugov_deferred_update(sg_policy, time, next_f);
+		sugov_deferred_update(sg_policy);
 		raw_spin_unlock(&sg_policy->update_lock);
 	}
 }
@@ -456,12 +448,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	if (sugov_should_update_freq(sg_policy, time)) {
 		next_f = sugov_next_freq_shared(sg_cpu, time);
 
+		if (!sugov_update_next_freq(sg_policy, time, next_f))
+			goto unlock;
+
 		if (sg_policy->policy->fast_switch_enabled)
-			sugov_fast_switch(sg_policy, time, next_f);
+			cpufreq_driver_fast_switch(sg_policy->policy, next_f);
 		else
-			sugov_deferred_update(sg_policy, time, next_f);
+			sugov_deferred_update(sg_policy);
 	}
-
+unlock:
 	raw_spin_unlock(&sg_policy->update_lock);
 }
 
-- 
1.9.1

