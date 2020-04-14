Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6032E1A8E3C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 00:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634149AbgDNWI6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 18:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729934AbgDNWIy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 18:08:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD5AC061A0C
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 15:08:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a201so15848043wme.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/VXMLsnEdFtu7k13O3hijxHV9EAnp9rCBMScPJUvt8E=;
        b=Xz/FKi3/eo2Z0NCI7DXFsCyI9TYATBR3mGQdjcgmFYX9ph6KDEJhtXW9U1VnGKp/99
         hoqWR9eEs20GbKQXi4Ipn26cyGerMwRUG3qRO/wxioCpikbHucOK/iZv5YtufGZNwBpt
         TyXATbJ/6YyeJj1XM1GYCK3xdBnMim6r9DxTfG+3aRSCujE67NQFsgJPJzF9L5Nnwz+l
         N4gjmw84GGRvKMftMdT58jt19o3nmhrfjSnmGHrz3zRbXGq2qW/l3+O4wNsXRTyxGlz+
         cl2JFr0bXA90LG1It9IIZDKpKd+dQy3ogcA58sLmxVnXGArNbBdf3h3B3dNJjT0j1qWp
         zCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/VXMLsnEdFtu7k13O3hijxHV9EAnp9rCBMScPJUvt8E=;
        b=OiS7njeIrJvP/PLumuStSkLrOVfZo6nLk4+xh3PJtBCIk8koDd+hi6NA6vNPRMEHL7
         O13M+0h1gcvILdpUa//qUuq5ZOzoOEKeHiFOP/LxvfRkQSJGTWhWFFGsrNegj14DHqPA
         zz/AFqDwzO3TduLpt360fH+QP7J8lY/ewrqI9+JAbyhMxa98rvAC9xyCv0Uc4Dqgj0HN
         WdE8lhwb4stZNCjP7KrRrZBUwoNFFezmKJrVUxLTC7g+stgM976BlpWP1ROKrBMQoW0i
         TjuOYX0M1c5kpO2vFLHPi3REtb7fFFuzyzucUZiKJEauzG7ruIpTEPq1aSrBKfrhHATH
         KXow==
X-Gm-Message-State: AGi0PuZW+FrEb56f8Ob+R2mbLnaAFilKY01SaWdbMOqTZheTnjcNODXQ
        8h2kBU0jQ8BbyixBToSTJVJM9w==
X-Google-Smtp-Source: APiQypIR0YCUcj0f3UMEytiFmfxblPOyEvh9SW2C+KGbKy7Bv1gp+ctMoW+5Hl14SjZpskRV0vYXsA==
X-Received: by 2002:a7b:c5cb:: with SMTP id n11mr2067920wmk.160.1586902132760;
        Tue, 14 Apr 2020 15:08:52 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id a7sm4099973wrs.61.2020.04.14.15.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:08:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/4] powercap/drivers/idle_inject: Specify idle state max latency
Date:   Wed, 15 Apr 2020 00:08:30 +0200
Message-Id: <20200414220837.9284-1-daniel.lezcano@linaro.org>
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

