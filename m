Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7D82380
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfHERCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 13:02:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52258 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730011AbfHERCq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 13:02:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so75435231wms.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8seUtniCWRwFTJq4JInJW6atX1NHBdkEw579O8M2U9c=;
        b=rZuWM93zis34ydR/ncwm9ywfu2puMq373eHZDdgwqmtjXJXB1PEM9wVVrN1dGDB+Ey
         VV2wbneQrvNNZxmOELIEn9K+wnBS6lcBwOldd8Ic/DHqfynnRkVfUsKNa4KOKnetFmsS
         ZFYK5/OmE6emlTxZZ/UJkEjx6X1LwwrAhN+Eoss6ERTPRQ78FTgRpf3jCWG+R7dG2hay
         CbfdNRQanY9NIos3Zo17BWvTT8pmxSTIK7LMpKEa6FuMbCZtFj7iKiYQ2MoSAx1QM4LH
         oK1DzgT1Xm1vrsCLu7rfRFb/hZGZeCd+OAZMvD0K+14jUH4vIefXM50yCm35Q2lR92Ok
         RAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8seUtniCWRwFTJq4JInJW6atX1NHBdkEw579O8M2U9c=;
        b=AH4PGjyygE+bsYtUsOs/250qU/5DbSprJ/BZ7RreMSYSGlLYgru4HYgLWYUl8VgtbC
         h2VQJ7A1RDlzLPXB+JpKJnrss45Juk/lQ4hpDcR6NE15RVKxkk7c3Zyr7t/aQodZ5m/P
         slALjoCcpoGtD5vzhVWipJziRo9x4U8dJ8oJ1LDYojW+uPXCwZqWoulO60V6ayyMEu3p
         dSRiEkAzfOE0N0vNOUoOofjP3QdJglnYMWNpGw85k31n/1UJmPhFgf0DRtsebsLg1VEc
         6q22kHS9KUGdc0gyIJ5oZgFqPib2UWQFMapP09AgAfqNz63sXCrbQru/FWvdQg0uxAdE
         0m1w==
X-Gm-Message-State: APjAAAV2FUbzBV/6UVIP0o8RNG6i0DBmSFDDPOrsbD6INJO1+knjvLZO
        2zUnjafvem/zgw8MDNTwnb3xuU489uI=
X-Google-Smtp-Source: APXvYqwNMG6nkRMSEbp8tcPVmOdfLttrjljhraM67lgOekaFbI3CEyHmigGc/TLZS7gq3QrWAxIbgA==
X-Received: by 2002:a1c:a8c9:: with SMTP id r192mr20084425wme.43.1565024564444;
        Mon, 05 Aug 2019 10:02:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e5cb:2287:9bbb:b7eb])
        by smtp.gmail.com with ESMTPSA id v29sm28893685wrv.74.2019.08.05.10.02.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:02:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] powercap/drivers/idle_inject: Specify the idle state to inject
Date:   Mon,  5 Aug 2019 19:02:08 +0200
Message-Id: <20190805170208.26873-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805170208.26873-1-daniel.lezcano@linaro.org>
References: <20190805170208.26873-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the idle injection framework only allows to inject the
deepest idle state available on the system.

Give the opportunity to specify which idle state we want to inject by
adding a new function helper to set the state and use it when calling
play_idle().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/idle_inject.c | 15 ++++++++++++++-
 include/linux/idle_inject.h    |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 9b18667b9f26..a94ebab9ee21 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -38,6 +38,7 @@
 #define pr_fmt(fmt) "ii_dev: " fmt
 
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 #include <linux/hrtimer.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>
@@ -65,6 +66,7 @@ struct idle_inject_thread {
  */
 struct idle_inject_device {
 	struct hrtimer timer;
+	int state;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
 	unsigned long int cpumask[0];
@@ -139,7 +141,7 @@ static void idle_inject_fn(unsigned int cpu)
 	iit->should_run = 0;
 
 	play_idle(READ_ONCE(ii_dev->idle_duration_us),
-		  cpuidle_find_deepest_state());
+		  READ_ONCE(ii_dev->state));
 }
 
 /**
@@ -170,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
 
+/**
+ * idle_inject_set_state - set the idle state to inject
+ * @state: an integer for the idle state to inject
+ */
+void idle_inject_set_state(struct idle_inject_device *ii_dev, int state)
+{
+	if (state >= -1 && state < CPUIDLE_STATE_MAX)
+		WRITE_ONCE(ii_dev->state, state);
+}
+
 /**
  * idle_inject_start - start idle injections
  * @ii_dev: idle injection control device structure
@@ -298,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
+	ii_dev->state = cpuidle_find_deepest_state();
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index a445cd1a36c5..e2b26b9ccd34 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -26,4 +26,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 				 unsigned int *run_duration_us,
 				 unsigned int *idle_duration_us);
+
+void idle_inject_set_state(struct idle_inject_device *ii_dev, int state);
+
 #endif /* __IDLE_INJECT_H__ */
-- 
2.17.1

