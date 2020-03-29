Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36FCF1970AD
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 00:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgC2WFl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 18:05:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51653 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgC2WFk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 18:05:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id c187so17807283wme.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2020 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l9DHmEiKz6yupqFx9WrHI0MsNMx9mQaRHcz2cqVdZLE=;
        b=JdHU3Yx4CotTcRuN+C3coH9IrxLwc1AwW8NiUAnWcmXk5TtrHAGjqQBn0silebw7J4
         l4XGe0eMFs6Ui8GRvWBNUzK78urjhmai4UQb5Q90tDnbsBecUdLbd8X/WzhJ9rcVg3WT
         APZELnnGVyOYgnnyTYUlLXPgMr9EgpodhFeWe7BdvrFMz9LSGkQb+hXBrOnbFQRxBkQN
         RejdWpQJlcbotPcQFz4Ok7AZMiuNr3GDHz8A5JnAf/mYY9yeuyjX9RKQSgVWrU/+/ocf
         n+EJ603uDEC/JleiXvZL0Nny0W16xAFn8s9G/1ZcS3jdv3eLNJ5RbYyxEbLTqN/7fCgN
         flzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l9DHmEiKz6yupqFx9WrHI0MsNMx9mQaRHcz2cqVdZLE=;
        b=tBH61LhZ5QA6J3GCtxhaxDTjRQ+Ow74lbM0ntKZDsSSe4r7rnU2v1gKbEx1bgfO1JI
         fKc9pCOPNblmmB1oxHP++TXunAlJVzRcCUqHcwLFcXWzXTZkCGTpCs6qIrHC6bJ82jWZ
         9ueRWSodnhXM2NRlox7SGoRfNM6dknavJgRJ8IzDUKmJM88ZW/bR5ZkwBTJAN9h7Emxs
         kGVzTdfIBore44RCG4iaXk3909SYqk3ByHDZ6zhI05A5FGU2bLmH0jIqhB3t7WYngTRq
         5GU7hZUAzsWkO/wUii/pUNtJC0R2MPAUBR9/GwTmeMqzZylIU/NvwU6rC0OAQ5wylCpb
         xumQ==
X-Gm-Message-State: ANhLgQ2IhPY+sg+KuhwZ7RiheIHVYrQe8iXziGfWTKBAqg8ama+R57rR
        bFqt1a31dRMQcYqI5Tav0m/wNw==
X-Google-Smtp-Source: ADFU+vs9p9+pplq0E9rosSzTu+qVht5suK/2lWGberAjg4WP9toV2lrY6CJKiOWPz50Xv1bXJ2K65A==
X-Received: by 2002:a05:600c:21da:: with SMTP id x26mr9651227wmj.47.1585519538542;
        Sun, 29 Mar 2020 15:05:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:78b1:4459:6959:42d0])
        by smtp.gmail.com with ESMTPSA id j188sm20026740wmj.36.2020.03.29.15.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 15:05:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, robh@kernel.org
Cc:     daniel.lezcano@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 1/4] powercap/drivers/idle_inject: Specify idle state max latency
Date:   Mon, 30 Mar 2020 00:03:17 +0200
Message-Id: <20200329220324.8785-1-daniel.lezcano@linaro.org>
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
  - V2:
    - Remove the get_latency helper

---
 drivers/powercap/idle_inject.c | 16 +++++++++++++++-
 include/linux/idle_inject.h    |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index cd1270614cc6..49f42c475620 100644
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
@@ -169,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
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
 /**
  * idle_inject_start - start idle injections
  * @ii_dev: idle injection control device structure
@@ -297,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
+	ii_dev->latency_us = UINT_MAX;
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index a445cd1a36c5..91a8612b8bf9 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -26,4 +26,8 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 				 unsigned int *run_duration_us,
 				 unsigned int *idle_duration_us);
+
+void idle_inject_set_latency(struct idle_inject_device *ii_dev,
+			     unsigned int latency_ns);
+
 #endif /* __IDLE_INJECT_H__ */
-- 
2.17.1

