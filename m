Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7846FCFDB
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 21:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKNUt1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 15:49:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39135 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNUt0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 15:49:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id l7so8291769wrp.6
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 12:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5UO3b7+pOXbKQaji65BpgDYXXrUz81W0W6/CufZYX7w=;
        b=ozQafBd1I7cil5n8Nyz0+8lhNXayRfGFBnzZ8U+zON4vTR67PpBduGPvBjVlvziPyg
         4DVcxl/ngqaqAM3fCyATM4tqVuQhcA8YW8GZ8sTlHk6p3ZmB7FS7uPWC6xqXTc/QgNVN
         z8novtZWy8NUr9yv4F4ozTIJxrXcJC+Uc2k+pS8DjDcZuKc/LhzBLN3uk1GxbfAltBjM
         r214BFFxkEtqPiMThhPT8Z6iYIDC3NzyItTff/7sWRHVfSgFDUHptGm3unxmjR2fA1o1
         Mmgdt2ztLhtIV2qlksU+q969bVkDhg9fitd9mAfPCz6uBW5oIprI1DltLUekqLkcZojN
         tGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5UO3b7+pOXbKQaji65BpgDYXXrUz81W0W6/CufZYX7w=;
        b=GX2ONvsrpj75d1w/cjLXL9fK8zuDVVtdDKYJ29nvfvG6HyleM0UWPPQWFPaCjptN2k
         aBrKi7X4Bm02SybbNBJ/cMfu7F3S12QC+YGEkLC/i+ggBPDfpXxD3kBVG3A7hEAL16Xr
         fXyl8VSWTw4mqKJYJLK747dJcRMBlfT03SQ6EySg5RfrovxU9Zm+KNGGyojsWNM+Fvj7
         vBY8llLT0T7xKQbc/7xPZqZyeZFp++J6KhX9e1nJY/omm61H0ij4T0A+aFsttx9AOVws
         S8VtkfZ/N7brBwy2uembsyrQ7CxNaQ+NjjPK+FGssQ7RSHstkgFlzw+dqtdd4aV+BzwY
         JH0g==
X-Gm-Message-State: APjAAAW65X1Ij2BzT4jOxu90beejevDVffNbXvdebT/M58U/MWe6XsU1
        facu5YgUse2kogJmigRnGU0QWQ==
X-Google-Smtp-Source: APXvYqwh24AwrMwwfFJeALDv3kLgGrmmSx+XnLCw4O+NgW0IL+/2nbs96V1uku/9bWVD9/z6d04VSw==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr10224219wrw.238.1573764565153;
        Thu, 14 Nov 2019 12:49:25 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:3115:aefb:2495:829a])
        by smtp.gmail.com with ESMTPSA id a206sm7954485wmf.15.2019.11.14.12.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:49:24 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V1 2/3] sched: idle: Add play_idle_precise function with latency
Date:   Thu, 14 Nov 2019 21:49:13 +0100
Message-Id: <20191114204914.21206-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191114204914.21206-1-daniel.lezcano@linaro.org>
References: <20191114204914.21206-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

By default the play_idle() function leads to the deepest idle state
selection which is not necessarily the state we are interested in when
forcing the CPU to go to idle.

Add the play_idle_precise() function which takes a latency parameter
so the caller can use the constraint to allow a shallower state.

Change the play_idle() function to be a wrapper passing an U64_MAX
latency to the play_idle_precise() function.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/cpu.h |  6 +++++-
 kernel/sched/idle.c | 10 +++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d0633ebdaa9c..4c9694e209a5 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -179,7 +179,11 @@ void arch_cpu_idle_dead(void);
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
-void play_idle(unsigned long duration_us);
+void play_idle_precise(u64 duration_ns, u64 latency_ns);
+static inline void play_idle(unsigned long duration_us)
+{
+	play_idle_precise(duration_us * NSEC_PER_USEC, U64_MAX);
+}
 
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d4681b3d7074..0a817e907192 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -311,7 +311,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle(unsigned long duration_us)
+void play_idle_precise(u64 duration_ns, u64 latency_ns)
 {
 	struct idle_timer it;
 
@@ -323,17 +323,17 @@ void play_idle(unsigned long duration_us)
 	WARN_ON_ONCE(current->nr_cpus_allowed != 1);
 	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
 	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
-	WARN_ON_ONCE(!duration_us);
+	WARN_ON_ONCE(!duration_ns);
 
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_deepest_state(1);
+	cpuidle_use_deepest_state(latency_ns);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	it.timer.function = idle_inject_timer_fn;
-	hrtimer_start(&it.timer, ns_to_ktime(duration_us * NSEC_PER_USEC),
+	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
 		      HRTIMER_MODE_REL_PINNED);
 
 	while (!READ_ONCE(it.done))
@@ -345,7 +345,7 @@ void play_idle(unsigned long duration_us)
 	preempt_fold_need_resched();
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(play_idle);
+EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
-- 
2.17.1

