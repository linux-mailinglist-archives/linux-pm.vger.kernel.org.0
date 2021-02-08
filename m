Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA78731292E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 04:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBHDId (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Feb 2021 22:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBHDIc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2021 22:08:32 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF7C061756;
        Sun,  7 Feb 2021 19:07:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id j5so485596pgb.11;
        Sun, 07 Feb 2021 19:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EhtEZeeEA+VVGotJ/o1in6C2esDFRE7ssaKSW/qYRbY=;
        b=YmYvKX+L0bfETG6+6bpLt3y/HSDuSQk3Gq05qlSFDHBFkRMo9Y3BnbtN/WUeq9cFM9
         koSeSVrfnx8tatKAkY+9jTRFF5ZxXHhxbnVaE099SHlBdNqx/cM9m+w1AlJl4DN2/pV7
         ULCXsnbxrMlKDyM9gaG5bS1urhv+VTZOrt/irFNXZVkcdkYY4lHlK1+Jlgy47dJf/IHW
         5rdOy+uszR/LmrrqiQxnhVTSrEVNL7Z126BLa8mCzVdkY0kXPRoOs4sPfQojj+s02eAK
         ovhEIAgTUf74b1k+S9IiTjTd6pCPwO9n29p+Bynb9BeQrsst9tTywgKTM+059gfez8Xc
         UbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EhtEZeeEA+VVGotJ/o1in6C2esDFRE7ssaKSW/qYRbY=;
        b=h/mt6aggwe+HqZmRg941/35GD8ltRvzhzq5BYLiZlyyaZ8smK7FTegwY5OnMMZ3OuU
         yErP+9gxvxcsWPxY0zwT+A4Tf6TzOQCOf552TQ01Q347kFkQli1qGsQA3f1J2yt3SI1B
         +/IDfDQBFTZ1YMdbXaseyZQwb4r9n/Fe943zLzT53/2/rDy0DQ65w/jvuTUH1BpFDfEY
         yinAt49wnc6uWwaALh6v/h7r2MgGFjWKbXRUXXEDYXFzwQ+jZIuqsnJIMpyADE4qH32n
         zE44NCOHiGjVa0GpHJLR+U0jUhPr4qncD8A2amEoCJfylgkLtYnUUECwMe2FapK2a7va
         lPrA==
X-Gm-Message-State: AOAM533wRmqWRENCpvKfwtZLnQThbN+bVy74Bo5V5ExfrAdaVsUUHFoc
        UstxEtL6YWd77ELYZBt4pOQ=
X-Google-Smtp-Source: ABdhPJzR9UCjMHew/cXX0RbLB0aUFOgi9xX9rIP7bs5xgXu2ARIJ60PNqofThIfqxUxxOqGKLwt/5Q==
X-Received: by 2002:a63:c911:: with SMTP id o17mr15023146pgg.102.1612753672326;
        Sun, 07 Feb 2021 19:07:52 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id q17sm16970213pfl.143.2021.02.07.19.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 19:07:51 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com,
        zhangwen@yulong.com
Subject: [PATCH] cpufreq: schedutil: Don't use the limits_changed flag any more
Date:   Mon,  8 Feb 2021 11:07:23 +0800
Message-Id: <20210208030723.781-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

The limits_changed flag was introduced by commit 600f5badb78c
("cpufreq: schedutil: Don't skip freq update when limits change") due
to race condition where need_freq_update is cleared in get_next_freq()
which causes reducing the CPU frequency is ineffective while busy.

But now, the race condition above is gone because get_next_freq()
doesn't clear the flag any more after commit 23a881852f3e ("cpufreq:
schedutil: Don't skip freq update if need_freq_update is set").

Moreover, need_freq_update currently will be set to true only in
sugov_should_update_freq() if CPUFREQ_NEED_UPDATE_LIMITS is not set
for the driver. However, limits may have changed at any time. And
subsequent frequence update is depending on need_freq_update. So, we
may skip this update.

Hence, let's remove it to avoid above issue and make code more simple.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 kernel/sched/cpufreq_schedutil.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 41e498b..7dd85fb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -40,7 +40,6 @@ struct sugov_policy {
 	struct task_struct	*thread;
 	bool			work_in_progress;
 
-	bool			limits_changed;
 	bool			need_freq_update;
 };
 
@@ -89,11 +88,8 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	if (!cpufreq_this_cpu_can_update(sg_policy->policy))
 		return false;
 
-	if (unlikely(sg_policy->limits_changed)) {
-		sg_policy->limits_changed = false;
-		sg_policy->need_freq_update = true;
+	if (unlikely(sg_policy->need_freq_update))
 		return true;
-	}
 
 	delta_ns = time - sg_policy->last_freq_update_time;
 
@@ -323,7 +319,7 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
-		sg_policy->limits_changed = true;
+		sg_policy->need_freq_update = true;
 }
 
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
@@ -759,7 +755,6 @@ static int sugov_start(struct cpufreq_policy *policy)
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
-	sg_policy->limits_changed		= false;
 	sg_policy->cached_raw_freq		= 0;
 
 	sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
@@ -813,7 +808,7 @@ static void sugov_limits(struct cpufreq_policy *policy)
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
-	sg_policy->limits_changed = true;
+	sg_policy->need_freq_update = true;
 }
 
 struct cpufreq_governor schedutil_gov = {
-- 
1.9.1

