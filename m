Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4031E7EF
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhBRJXN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 04:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhBRJNo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 04:13:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7069C061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:03:07 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a9so888748plh.8
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5z9B2u088uQ+CohgqkwMdMY/blM4RoQ7vFqpPfdVHw=;
        b=OtcLmuWCNewhWmnrjUzb3RNC15cdO7NSP19GGnxWEfRsuj2kgxfLKa7fTsrqPNCIVT
         iaPJ3dU0vMTv0ws3fcfiT/JepGFXYefDdupU8Pjch/2bsHLquagq41dCXMR26xAt3o3K
         ER+kDfVrHaUc9GTmn/1uGO27ObxQp72xBVeUMXAxEFTLxAZscRntwqyGbnxrzEJ2X/A6
         XoDh5d02czk08ZrvmLFEOaTllXjTKJMMtQKP70IjBp9rqK+6xzLXeWNb/VmmQJJ/Mriu
         Tyhqdq40BXBJREDnFgKC9hXuhV8U1kp6GE67piS2bz45oxgiRJEwlRWC7thgBS9amVju
         Hr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5z9B2u088uQ+CohgqkwMdMY/blM4RoQ7vFqpPfdVHw=;
        b=ayHN0Hp8NUbMmw/k9fBiOV0vpmdJqsIhFR2ywB3MgPrD78VSMJDhWDLZlpmLZ2MCs/
         M5De9pXvTAHMdibqjaSo0/VcTWB6+MBWDfynCIeUE3NBubywDNZf9p3RMe1W38bjkNZP
         b5MBV9OqgMzfTfWfiuzgjNH5C6Djxf+XgDH7UR5v8+sOxV4yw/KSU/PofXG60K7Iqxt5
         Jb/XA1XDrfN2/LTQq6zV6rsUvPjENr/tnsuaIOLL7wJXC5ZmTPByNKzw2ogGN0+3hySq
         MX7U6uMkfrlwWfxITxw/cnam+hrpXx6mzGgToI62eAEQhzdI2XV16G0J2KNk/9PWTcba
         wl2A==
X-Gm-Message-State: AOAM532+Da2qFObsaAtumFWhIgA4zxeWKUudgOxFSgsgP1iT4rwZD1+l
        4OGJA8k3n0AWI4fKDLqjJwc=
X-Google-Smtp-Source: ABdhPJyeHjmLysdmjZH+HJxKFAApGSoiEbnYRpns+wnU0ycyr78E8IoDcU5LGQn/Uop8PblDQaXRgg==
X-Received: by 2002:a17:90a:eb02:: with SMTP id j2mr3196790pjz.226.1613638987498;
        Thu, 18 Feb 2021 01:03:07 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id 14sm5335540pfy.55.2021.02.18.01.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 01:03:06 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-pm@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] cpufreq: schedutil: Remove the needless sg_policy parameter to ignore_dl_rate_limit()
Date:   Thu, 18 Feb 2021 17:01:32 +0800
Message-Id: <20210218090132.1556-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Since sg_policy is a member of struct sugov_cpu. Also remove the local
variable in sugov_update_single_common() to make the code more clean.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 kernel/sched/cpufreq_schedutil.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5906ae5..add8081 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -320,23 +320,21 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
  * Make sugov_should_update_freq() ignore the rate limit when DL
  * has increased the utilization.
  */
-static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
+static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
-		sg_policy->limits_changed = true;
+		sg_cpu->sg_policy->limits_changed = true;
 }
 
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned int flags)
 {
-	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
-
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	ignore_dl_rate_limit(sg_cpu, sg_policy);
+	ignore_dl_rate_limit(sg_cpu);
 
-	if (!sugov_should_update_freq(sg_policy, time))
+	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
 		return false;
 
 	sugov_get_util(sg_cpu);
@@ -452,7 +450,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	ignore_dl_rate_limit(sg_cpu, sg_policy);
+	ignore_dl_rate_limit(sg_cpu);
 
 	if (sugov_should_update_freq(sg_policy, time)) {
 		next_f = sugov_next_freq_shared(sg_cpu, time);
-- 
1.9.1

