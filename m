Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE2C9EBE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfJCMqF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 08:46:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45633 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfJCMqF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2019 08:46:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so2713053wrm.12
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2019 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IG+vDw300IL0IbtzmhjNYjwnPaOLEIM27ya6uOhzNAI=;
        b=Yw3Fb7VvQEAwRgQNhw8YaLBJ8QzyQHjf8Wx0M/su1ne/rhZIA8027t+SYL4eZgzoZm
         SevMQnQURcCKwRVoXBga5prFrx8Gp+OjC3sz1udJN0i+uAXBIIT4Gc/UVe8uyNwkW9pZ
         Ntt9ciaZG5stpg2FtznGLkotIRIzH46H0/GPCxxVm6fXMLvhShmxXmKtlx1N56tRFz58
         +TpbINQw+0OC0i+Ll13PRBUwoQpLSiyrBaJv3yNUs7efx/pC4ZmKbzncE0Hz+T+Oa4az
         Ii0/d0pEt2RV4Q0JNpQN1Sg8HeSDez/lfXhQJtlqxRlNkJQqkOOXKc5QtrrpqyPvArBg
         MqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IG+vDw300IL0IbtzmhjNYjwnPaOLEIM27ya6uOhzNAI=;
        b=L0d0NZsaAoXpI7+w/hUmU/8/pNcUHdnK+FZElj7jgaZZVaXfUB0gQgohWYl+4GJ+1S
         m56eG0SNG5oJ7HAzjgI9Yh0XsifSvoXkDulXXU4f9z2ymsNz/5WN60wfhjnjXHGMKH2Q
         aXZsoFkwvva9Gp85SmrD0rQGn7GBTpaanI2RUW0L5MM06AsPkmVMPue/x5ha9JNd+iT9
         FUbbfobwWr3frqhsBczCTuRlWvqxlWq5TXO+83Bj1vDPk01s1JPMP9LenLLEC/mxvjsh
         ovfT/cz4yY7QR73FFgXdVXgWU28A2hmW6rZk5m9z2xYg9wfrPQqDMDm19u570dY55xT8
         vpzg==
X-Gm-Message-State: APjAAAWBR/tKVA+Jc+y6DIFw8NWqK6u8BEfMYt5ijD83BvN7TjDFSkPJ
        7JB6z7IVm6BQK8vyY1wl9kLTKg==
X-Google-Smtp-Source: APXvYqx2nYMQ+9l7470EkPvSGaMkZD61jQYTD5Gg1ujHw6nDgyqqMglpAUCSDGVRI1DxBPY+6IBeFA==
X-Received: by 2002:adf:e542:: with SMTP id z2mr2099471wrm.134.1570106762783;
        Thu, 03 Oct 2019 05:46:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:7990:8bfa:5771:282b])
        by smtp.gmail.com with ESMTPSA id m62sm2453586wmm.35.2019.10.03.05.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 05:46:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 2/3] cpuidle: play_idle: Specify play_idle with an idle state
Date:   Thu,  3 Oct 2019 14:45:40 +0200
Message-Id: <20191003124541.27147-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003124541.27147-1-daniel.lezcano@linaro.org>
References: <20191003124541.27147-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, the play_idle function does not allow to tell which idle
state we want to go. Improve this by passing the idle state as
parameter to the function.

There is no functional changes, the cpuidle state is the deepest one.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 * V3 :
   - Add missing cpuidle.h header
---
 drivers/powercap/idle_inject.c           | 4 +++-
 drivers/thermal/intel/intel_powerclamp.c | 4 +++-
 include/linux/cpu.h                      | 2 +-
 kernel/sched/idle.c                      | 4 ++--
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index cd1270614cc6..233c878cbf46 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -38,6 +38,7 @@
 #define pr_fmt(fmt) "ii_dev: " fmt
 
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 #include <linux/hrtimer.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>
@@ -138,7 +139,8 @@ static void idle_inject_fn(unsigned int cpu)
 	 */
 	iit->should_run = 0;
 
-	play_idle(READ_ONCE(ii_dev->idle_duration_us));
+	play_idle(READ_ONCE(ii_dev->idle_duration_us),
+		  cpuidle_find_deepest_state());
 }
 
 /**
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 53216dcbe173..b55786c169ae 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 #include <linux/thermal.h>
 #include <linux/slab.h>
 #include <linux/tick.h>
@@ -430,7 +431,8 @@ static void clamp_idle_injection_func(struct kthread_work *work)
 	if (should_skip)
 		goto balance;
 
-	play_idle(jiffies_to_usecs(w_data->duration_jiffies));
+	play_idle(jiffies_to_usecs(w_data->duration_jiffies),
+		  cpuidle_find_deepest_state());
 
 balance:
 	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 88dc0c653925..76e3038b63ce 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -179,7 +179,7 @@ void arch_cpu_idle_dead(void);
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
-void play_idle(unsigned long duration_us);
+void play_idle(unsigned long duration_us, int state);
 
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 17da9cb309e1..ead439dab2b5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -311,7 +311,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle(unsigned long duration_us)
+void play_idle(unsigned long duration_us, int state)
 {
 	struct idle_timer it;
 
@@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_state(cpuidle_find_deepest_state());
+	cpuidle_use_state(state);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
2.17.1

