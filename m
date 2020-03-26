Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A26D1941EC
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 15:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgCZOst (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 10:48:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37778 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZOst (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 10:48:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so8177062wrm.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VjZPz6gNRy+HKuPVRsIUCX6v0qqfQqCeDyDKuH2Fc6Y=;
        b=CzKLV+U8excn0ZlDehTqAqC8OpRyele35n2KY/KR4YH8uoGXziz1qrZLlnBFq23u0V
         tkHzDpeX7fqdUgIEXkQYEYTaUSQsU5cFZN95e6K0ihzluBJLu1xyELeMklqxJeHSY28d
         7tVmAYlshj6kQ4zlg/GhBbm9rI6BIwV8k0EjIctT8RrmoEFl3r69eUnVlImvI75HP6uy
         Tj0W/v5N7T106VOztY4NSn9F0SQbk1gO6YOkNpd3vV+rOFviGkHGtV/2hsqDe3+hs6t8
         Xb+5bg1VCwEpreZ6JWkRkt8lJPxFoTG58wdTdeCisROBa1M2K5ZDI/Ah/QUYJSzl8s9J
         G2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VjZPz6gNRy+HKuPVRsIUCX6v0qqfQqCeDyDKuH2Fc6Y=;
        b=mC4KzWRxQyR/yYnY0E4bAM27s10krb9qbDnkI+DbDtTpIf+hEjHng7uaRb6cjOeoW+
         Aj/Fdpswa8CQ1l9ZkISgszM0O4/YzjRuGSAeWoqoAkY5XTqZQKgVgeP0USXRY5yjHb72
         fcIk7RMg/cO5RmTgRpGsqI0v8T9pZZYBGhrLTVKmW0nnDvmuxaQFHtCGOduCqMwMHwVc
         ZpxdIVjW1EfRpjZuxS+f6Ast1jBeri9wfNt/9fb2VjoZHbGhUC8lyW4Yv+yyaU7ZbVb9
         Txoh5dbmR/vKfxVHUPzAR0uioOFfOgtUErFx4U/4KbX5YddYzZpebLTfC4QaZ/dbZyZW
         kg+A==
X-Gm-Message-State: ANhLgQ1JoYcEeaI9FjGCZJClcljTNVVN2V88fP9/3bAqrKKTbOm/LqTV
        9Wa9m9bJAQi1sDjio2ehyu25JA==
X-Google-Smtp-Source: ADFU+vvsIUVbNG7cb7Biho+bWS/MelZlhfzehAM+r/hladbvposUqs123z5VJYVN/eodv8UaEPw2jg==
X-Received: by 2002:adf:f50d:: with SMTP id q13mr10092175wro.374.1585234127462;
        Thu, 26 Mar 2020 07:48:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:c0b:a340:75e5:7701])
        by smtp.gmail.com with ESMTPSA id v8sm3980984wrw.2.2020.03.26.07.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:48:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powercap/drivers/idle_inject: Specify idle state max latency
Date:   Thu, 26 Mar 2020 15:46:25 +0100
Message-Id: <20200326144630.15011-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the idle injection framework uses the play_idle() function
which puts the current CPU in an idle state. The idle state is the
deepest one, as specified by the latency constraint when calling the
subsequent play_idle_precise() function with the INT_MAX.

The idle_injection is used by the cpuidle_cooling device which
computes the idle / run duration to mitigate the temperature by
injecting idle cycles. The cooling device has no control on the depth
of the idle state.

Allow finer control of the idle injection mechanism by allowing to
specify the latency for the idle state. Thus the cooling device has
the ability to have a guarantee on the exit latency of the idle states
it is injecting.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/idle_inject.c | 27 ++++++++++++++++++++++++++-
 include/linux/idle_inject.h    |  6 ++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index cd1270614cc6..15e6f9b8023f 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -61,12 +61,14 @@ struct idle_inject_thread {
  * @timer: idle injection period timer
  * @idle_duration_us: duration of CPU idle time to inject
  * @run_duration_us: duration of CPU run time to allow
+ * @latency_us: max allowed latency
  * @cpumask: mask of CPUs affected by idle injection
  */
 struct idle_inject_device {
 	struct hrtimer timer;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
+	unsigned int latency_us;
 	unsigned long int cpumask[0];
 };
 
@@ -138,7 +140,8 @@ static void idle_inject_fn(unsigned int cpu)
 	 */
 	iit->should_run = 0;
 
-	play_idle(READ_ONCE(ii_dev->idle_duration_us));
+	play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
+			  READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
 }
 
 /**
@@ -169,6 +172,27 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
 
+/**
+ * idle_inject_set_latency - set the maximum latency allowed
+ * @latency_us: set the latency requirement for the idle state
+ */
+void idle_inject_set_latency(struct idle_inject_device *ii_dev,
+			     unsigned int latency_us)
+{
+	WRITE_ONCE(ii_dev->latency_us, latency_us);
+}
+
+/**
+ * idle_inject_get_latency - get the allowed latency
+ *
+ * Return: an unsigned int corresponding to the latency requirement
+ * for the idle state
+ */
+unsigned int idle_inject_get_latency(struct idle_inject_device *ii_dev)
+{
+	return READ_ONCE(ii_dev->latency_us);
+}
+
 /**
  * idle_inject_start - start idle injections
  * @ii_dev: idle injection control device structure
@@ -297,6 +321,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
+	ii_dev->latency_us = UINT_MAX;
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index a445cd1a36c5..b573fee589b9 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -26,4 +26,10 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 				 unsigned int *run_duration_us,
 				 unsigned int *idle_duration_us);
+
+void idle_inject_set_latency(struct idle_inject_device *ii_dev,
+			     unsigned int latency_ns);
+
+unsigned int idle_inject_get_latency(struct idle_inject_device *ii_dev);
+
 #endif /* __IDLE_INJECT_H__ */
-- 
2.17.1

