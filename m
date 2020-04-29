Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99721BD9BB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 12:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD2Kg7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 06:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2Kg6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 06:36:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B331C03C1AD
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:36:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t14so1855308wrw.12
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RpkQwwv6S0Hyop47yUIyj7qzO0Gz5frqaukBd604NtU=;
        b=HvZKeFCiIZIbg9p8zSxsOH+vfjJYTpNd7ikWWMoiC9fUQnU3lJZrK/HjgHkrXfAGl8
         kKjxcmVZBsVlU9se+EDFZaNgIL7tInM2qcvknFXbRx7PPNAUCapOFMGy3+CCu06kFtIN
         bALyb19P6Vhsoz8PmCDVrRfIGNpHwM9Vcz5MJ/MHdsbbC+LmcnjePrPc2Ci4eXgj78oe
         OhDu1GZqAGs5VcSSGdbqLKXa6OhDMEJtaPSqpr2VZhyxZQxoU+YFOv9smMLSWLelb/QT
         qO357mN+Z85gSAOFj8Lm1ULKeIRKatqPYmrikW1XJuLP2oaUvg0wPaCUcmjtt3Bek+xU
         GIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RpkQwwv6S0Hyop47yUIyj7qzO0Gz5frqaukBd604NtU=;
        b=WWG4lhqLJ4MMfYyF1vWR9TXQusOBf8bXjF6/Yj6nOg+LbsCKVMja0J2eqC80aoNljw
         tq/UusXVMlnLQOhkBtwrDbbn8KFi5FK8lO7t2KoLaeiSo79aZIRX/TKKMWO8cdLRLLf/
         VXdrwVQGiK00u1jRhqZPWKuiOdZKbyUSNBPqx1oq79qpzu1ec8b/6UHab5RiFFTaWseH
         OnNTI2+1TNvbwJp7E7jINtjed/o/4d7SvLnqR6CFWj9olWGB9GQTtUrlsMozlX7qTxbI
         KuZeGhXCki0qxzHK2q+AWMlMtAms6XNuGIB05z4ZB7QJUi7p83A1uIMOgWRAACv5GLiZ
         EwHQ==
X-Gm-Message-State: AGi0PuYnTfivHYDlY1xaLoaMQz+lEok8oSAFFj+G3MkeYW0/NyzKGzR/
        /9JkhIbT4SxlTwDsyeHrYeSDV5e4tx8=
X-Google-Smtp-Source: APiQypIQcyBJmQi7ofyqwA5mlDq2HNSja9bfSA5sY2q8vZceL0ijeX6bNqvvblyjWbpnSczn8Rg39w==
X-Received: by 2002:a5d:4f0d:: with SMTP id c13mr37135690wru.49.1588156617262;
        Wed, 29 Apr 2020 03:36:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d494:5741:b700:698f])
        by smtp.gmail.com with ESMTPSA id f23sm6899576wml.4.2020.04.29.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:36:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     lukasz.luba@arm.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/4] powercap/drivers/idle_inject: Specify idle state max latency
Date:   Wed, 29 Apr 2020 12:36:39 +0200
Message-Id: <20200429103644.5492-1-daniel.lezcano@linaro.org>
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

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
  - V4:
    - Respin against v5.7-rc1
---
 drivers/powercap/idle_inject.c | 16 +++++++++++++++-
 include/linux/idle_inject.h    |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index e9bbd3c42eef..c90f0990968b 100644
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
 	unsigned long cpumask[];
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

