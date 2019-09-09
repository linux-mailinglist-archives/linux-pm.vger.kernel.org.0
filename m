Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486DFADB85
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfIIOur (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 10:50:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38113 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfIIOuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 10:50:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id o184so15035958wme.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2019 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QWTOc9pzhOZfgZC7q4BsqP5nZGvuPUC3FrVHOgCj9sE=;
        b=Qh900W4WCA/saKFC7Jgj35zRRdwzkHDtcm8hsjyS3aBg7t/sfTw1+RJ85PhNMA8Pyg
         C4g4c6c70EmSjEGdswpILDeyJUb3qEOFGQCDFA7x0lcH650oB9E5BO1jEfcSf50seLv+
         3nW7oN2zl2PrP7aOaYHU/EZo7uVkA4FRlWCrAv43la1CTyj0KIkt/uGSDlnE5zBlbroO
         zraFW9eln2tSZqy0I0/VGKBgDv6VsqIZUZN4+9dYp6CPwpDk9h3uEJuZJ1sYrY+e2wZd
         aYj6RO3Z7liTmDZOHNGREw3Q0X5HSWXlnYa2l8O3dWrMO6eZNc2s5Adi+rMknTjSRzUc
         deGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QWTOc9pzhOZfgZC7q4BsqP5nZGvuPUC3FrVHOgCj9sE=;
        b=Z2Gq+ygXv1sirb+8lTbeU54mpA/UEwthz/gWUuZvMRJZqXCHBLoUuNpeJoF4W14pmI
         qINRc0YJIkhjeMSOCMajQLkfxqEvNHpqPsdMFOS15qTRQiV7KSEBARFtyNVIF1Oli972
         pIyhtjoQUXfRr5KYUeAWj7F41yWBemcBo+simn5YY2exTag5EDKD49sHxDe65LmgPL7O
         pxmlm16SpOlzGBwUKFLIHZaXx9GfagnwdcJS+MgiLLf6USGP9/cBALdpYtW00QSOtfix
         mjg77UQK7TBt4LWz9Falay7XmjnG6aOm0P+lY4l+IcwdCpNwbS/CP1a/z7cDBbK77tjQ
         tMFw==
X-Gm-Message-State: APjAAAVERIYiwecP45G62oAM51abjncmVC6ywqwp4q6Gb3LqJ9vaH1Sl
        wNjtJ90wc4KcgfT0GNxT4fFrPg==
X-Google-Smtp-Source: APXvYqxVD4als1QedRaHkSvS6MV28kH4s34zPdMci9jFoOITuCOWZB9WaIZnfekab/kG46hMSwG4zw==
X-Received: by 2002:a05:600c:307:: with SMTP id q7mr13157988wmd.6.1568040643849;
        Mon, 09 Sep 2019 07:50:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:a060:80d2:1467:e511])
        by smtp.gmail.com with ESMTPSA id v2sm31921147wmf.18.2019.09.09.07.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:50:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] powercap/drivers/idle_inject: Specify the idle state to inject
Date:   Mon,  9 Sep 2019 16:50:15 +0200
Message-Id: <20190909145015.26317-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190909145015.26317-1-daniel.lezcano@linaro.org>
References: <20190909145015.26317-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the idle injection framework only allows to inject the
deepest idle state available on the system.

Give the opportunity to specify which idle state we want to inject by
adding a new function helper to set the state and use it when calling
play_idle().

There is no functional changes, the cpuidle state is the deepest one.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/idle_inject.c | 15 ++++++++++++++-
 include/linux/idle_inject.h    |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 9b18667b9f26..a612c425d74c 100644
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
+	if (state >= CPUIDLE_STATE_NOUSE && state < CPUIDLE_STATE_MAX)
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

