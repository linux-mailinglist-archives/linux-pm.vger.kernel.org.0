Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA7297FFB4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 19:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404979AbfHBRen (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Aug 2019 13:34:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43288 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405108AbfHBRen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2019 13:34:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so3433421wru.10
        for <linux-pm@vger.kernel.org>; Fri, 02 Aug 2019 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0fi+tf4mocFects4W1qB+ILglAU2h75cNGvOkBkXnCw=;
        b=eB6aZQI/IjQTND3nHH2Mbiko4BR079ISpu76KHnHP9Opum3jv6hIW6nvjgbDkUiqkS
         U6vwn/Dl8FKfDj87ObLUNTFjPwc/MCuWhojBfFhgwrCoutJPyYrznB8xllpeRfPaRxIQ
         jJlHoUYg1JHYfsAXCEb/YpbISV8oOa8E9UJaJh1U4aNVF67Pz0KwDy4i5+NIKq1o6FZI
         OT3DAdo1A3/otiUMW8hRQbNhlWyfbbH3D9zQkzd17twl833m1ovJsHSeO+6x8mz0O7nl
         O2M8y6pYPo69zmucxwDrF39Klf5AO/gP9Akx/IO8VZ+0cY4ckCIVOHrnPlfJnxa6/Pw8
         yT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0fi+tf4mocFects4W1qB+ILglAU2h75cNGvOkBkXnCw=;
        b=QfpwQtpUBp2zl6Y1mb3lN+z5kgN3G9HZE7An4gcv/dZjpsINmfCuSzMNBh+MYa1XhZ
         Vik9jCy0RKvmbmMjD3FkaQ7NX9p7Rr4AqxizufVCKXb9vrXKlrt8wriAuuhNjkzk57y1
         BSK/aEKAfRAUGQS/z3dZon5knhOst0VNBhulwipUTAjnVcxNPdrnUNm5gdAuuGlkrO1+
         C6Dkths1nzfUENyIRImnZISZzDhKc5b9JmB+NaJbajrJ2NCTxhwPL98dlZny6WUuIddU
         kOZUCpjKJRygAz0Vs4pbugTcmHc3R8wu35nmmBXTrumtvEuF7CxeqsMNx9moYDrX7k4Y
         VqNw==
X-Gm-Message-State: APjAAAU9zhuvARX/ckuvUZjPiOO8M2xtn0rNPs5DKFssjIbdS6ZP2I82
        Y7vIM+3YCDcxaJNVEPrq+pTRAQ==
X-Google-Smtp-Source: APXvYqwoLqt9fvTcc4sbvdiZ165AJhCisVUSgt0jB8/L1b60MYfVj/X2gw+rAUzbnX8g+MQQlgIlbA==
X-Received: by 2002:a05:6000:1148:: with SMTP id d8mr131175810wrx.354.1564767280712;
        Fri, 02 Aug 2019 10:34:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:7d60:82f1:6b3e:4a0])
        by smtp.gmail.com with ESMTPSA id s188sm70856194wmf.40.2019.08.02.10.34.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 10:34:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 2/2] powercap/drivers/idle_inject: Use a higher resolution for the idle injection
Date:   Fri,  2 Aug 2019 19:34:24 +0200
Message-Id: <20190802173424.5844-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802173424.5844-1-daniel.lezcano@linaro.org>
References: <20190802173424.5844-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The resolution of the idle injection is limited to 1ms. If there is a
need for an injection of 1.2ms, it is not possible.

The idle injection API is not yet used, so it is safe to convert the
existing API to the new time unit instead of adding more functions.

Convert to microsecond in order to use a finer grain time unit when
injecting idle cycles.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/idle_inject.c | 53 +++++++++++++++++-----------------
 include/linux/idle_inject.h    |  8 ++---
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 10601f4bdf72..cd1270614cc6 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -59,14 +59,14 @@ struct idle_inject_thread {
 /**
  * struct idle_inject_device - idle injection data
  * @timer: idle injection period timer
- * @idle_duration_ms: duration of CPU idle time to inject
- * @run_duration_ms: duration of CPU run time to allow
+ * @idle_duration_us: duration of CPU idle time to inject
+ * @run_duration_us: duration of CPU run time to allow
  * @cpumask: mask of CPUs affected by idle injection
  */
 struct idle_inject_device {
 	struct hrtimer timer;
-	unsigned int idle_duration_ms;
-	unsigned int run_duration_ms;
+	unsigned int idle_duration_us;
+	unsigned int run_duration_us;
 	unsigned long int cpumask[0];
 };
 
@@ -104,16 +104,16 @@ static void idle_inject_wakeup(struct idle_inject_device *ii_dev)
  */
 static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 {
-	unsigned int duration_ms;
+	unsigned int duration_us;
 	struct idle_inject_device *ii_dev =
 		container_of(timer, struct idle_inject_device, timer);
 
-	duration_ms = READ_ONCE(ii_dev->run_duration_ms);
-	duration_ms += READ_ONCE(ii_dev->idle_duration_ms);
+	duration_us = READ_ONCE(ii_dev->run_duration_us);
+	duration_us += READ_ONCE(ii_dev->idle_duration_us);
 
 	idle_inject_wakeup(ii_dev);
 
-	hrtimer_forward_now(timer, ms_to_ktime(duration_ms));
+	hrtimer_forward_now(timer, ns_to_ktime(duration_us * NSEC_PER_USEC));
 
 	return HRTIMER_RESTART;
 }
@@ -138,35 +138,35 @@ static void idle_inject_fn(unsigned int cpu)
 	 */
 	iit->should_run = 0;
 
-	play_idle(READ_ONCE(ii_dev->idle_duration_ms) * USEC_PER_MSEC);
+	play_idle(READ_ONCE(ii_dev->idle_duration_us));
 }
 
 /**
  * idle_inject_set_duration - idle and run duration update helper
- * @run_duration_ms: CPU run time to allow in milliseconds
- * @idle_duration_ms: CPU idle time to inject in milliseconds
+ * @run_duration_us: CPU run time to allow in microseconds
+ * @idle_duration_us: CPU idle time to inject in microseconds
  */
 void idle_inject_set_duration(struct idle_inject_device *ii_dev,
-			      unsigned int run_duration_ms,
-			      unsigned int idle_duration_ms)
+			      unsigned int run_duration_us,
+			      unsigned int idle_duration_us)
 {
-	if (run_duration_ms && idle_duration_ms) {
-		WRITE_ONCE(ii_dev->run_duration_ms, run_duration_ms);
-		WRITE_ONCE(ii_dev->idle_duration_ms, idle_duration_ms);
+	if (run_duration_us && idle_duration_us) {
+		WRITE_ONCE(ii_dev->run_duration_us, run_duration_us);
+		WRITE_ONCE(ii_dev->idle_duration_us, idle_duration_us);
 	}
 }
 
 /**
  * idle_inject_get_duration - idle and run duration retrieval helper
- * @run_duration_ms: memory location to store the current CPU run time
- * @idle_duration_ms: memory location to store the current CPU idle time
+ * @run_duration_us: memory location to store the current CPU run time
+ * @idle_duration_us: memory location to store the current CPU idle time
  */
 void idle_inject_get_duration(struct idle_inject_device *ii_dev,
-			      unsigned int *run_duration_ms,
-			      unsigned int *idle_duration_ms)
+			      unsigned int *run_duration_us,
+			      unsigned int *idle_duration_us)
 {
-	*run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
-	*idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);
+	*run_duration_us = READ_ONCE(ii_dev->run_duration_us);
+	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
 
 /**
@@ -181,10 +181,10 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
  */
 int idle_inject_start(struct idle_inject_device *ii_dev)
 {
-	unsigned int idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);
-	unsigned int run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
+	unsigned int idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
+	unsigned int run_duration_us = READ_ONCE(ii_dev->run_duration_us);
 
-	if (!idle_duration_ms || !run_duration_ms)
+	if (!idle_duration_us || !run_duration_us)
 		return -EINVAL;
 
 	pr_debug("Starting injecting idle cycles on CPUs '%*pbl'\n",
@@ -193,7 +193,8 @@ int idle_inject_start(struct idle_inject_device *ii_dev)
 	idle_inject_wakeup(ii_dev);
 
 	hrtimer_start(&ii_dev->timer,
-		      ms_to_ktime(idle_duration_ms + run_duration_ms),
+		      ns_to_ktime((idle_duration_us + run_duration_us) *
+				  NSEC_PER_USEC),
 		      HRTIMER_MODE_REL);
 
 	return 0;
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index bdc0293fb6cb..a445cd1a36c5 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -20,10 +20,10 @@ int idle_inject_start(struct idle_inject_device *ii_dev);
 void idle_inject_stop(struct idle_inject_device *ii_dev);
 
 void idle_inject_set_duration(struct idle_inject_device *ii_dev,
-				 unsigned int run_duration_ms,
-				 unsigned int idle_duration_ms);
+				 unsigned int run_duration_us,
+				 unsigned int idle_duration_us);
 
 void idle_inject_get_duration(struct idle_inject_device *ii_dev,
-				 unsigned int *run_duration_ms,
-				 unsigned int *idle_duration_ms);
+				 unsigned int *run_duration_us,
+				 unsigned int *idle_duration_us);
 #endif /* __IDLE_INJECT_H__ */
-- 
2.17.1

