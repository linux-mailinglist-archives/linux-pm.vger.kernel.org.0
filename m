Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9E352655
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 06:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBE4V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 00:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhDBE4V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 00:56:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA235C0613E6;
        Thu,  1 Apr 2021 21:56:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id y3so146588pgi.0;
        Thu, 01 Apr 2021 21:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kVdcgww23VdErQfrCwBlNpGo/FOajrGJ912n2nUaTcE=;
        b=qIE+CxChq8Pd5YUAkG3mWlCe/XJ9vL3eagK5/HekCLLfGabaqENuMTuTEFOO866xGL
         1pRFGxSJ5MJJL6e8/cFcguS+N9tbV92JGtm0hNSn7i4x6z5v3qIlRH1NgrhzKqSw8p+a
         nGPs6f13SSbIlLWiIVYLKg1Rj493pvEQLPi7Uf0Hh2I+rni4igNUKVWGk+1xWJrpgEbv
         5WQm5Tr7vwMOpULUdN9695I3Ze3P5bEHnT2SjY1lKJFDP84mpN3iWcquZLdtAzS5UdR1
         zSFx4r5otwXfdRBJHfQOHuihEcN7LRWVbyigxD7HOYLVE2GrmjFDIXzutHYFkwh/n1op
         orwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kVdcgww23VdErQfrCwBlNpGo/FOajrGJ912n2nUaTcE=;
        b=cJuZdSRhxMg2YMXFI0+mTnvL5OpD/eVcJZUBz6pRbRj29pVlPH5Lo1TrpdBGNKeS19
         f0Zs0A5sPxTs9z8KmszLHKlQYnVoElqT8r+xWi9eGS3rlX2W1pa7Ta0ZRM7GtJ3B7vtL
         wdTtU3PgcEFWQYixagKpWExhFHJbz/aEO1jYltlFCqZ5EmfVWJN82KmErCA6o9iaiI2l
         BIRoga8BRb0tsI+9O+huQ6UTBq44DgFvgWjYCL0EbPZck06TxI0f6ZjFRrotaU+SjBMh
         0K5Xvk40F3eZhjp3J6F1axF1aVEJGPA44iW+JlKfuEKr3NH7m6B5nPIRUI/Ug+XX59Ez
         nFgg==
X-Gm-Message-State: AOAM532HWcFe/WmMgHjjaT7a9JTKBFMBS9g80/5YRs9xvEOCp4YiTf8I
        Lj8iSMz/SdoV6eLt+Kp7BJo=
X-Google-Smtp-Source: ABdhPJxu0ecpZKFkEfVjbKD6wzATRCTM0JlUiM/CtZULrBPTOEH1SQ6FJIbB+dtdWd+t9yIWpZhUPA==
X-Received: by 2002:aa7:96f0:0:b029:1f3:97a4:19d2 with SMTP id i16-20020aa796f00000b02901f397a419d2mr10422788pfq.73.1617339380302;
        Thu, 01 Apr 2021 21:56:20 -0700 (PDT)
Received: from localhost.localdomain ([96.44.140.50])
        by smtp.gmail.com with ESMTPSA id o4sm6942987pfk.15.2021.04.01.21.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 21:56:19 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: [PATCH] thermal/drivers/cpuidle_cooling: Make sure that idle_duration is larger than residency
Date:   Fri,  2 Apr 2021 12:56:14 +0800
Message-Id: <20210402045615.22630-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Guangqing Zhu <zhuguangqing83@gmail.com>

The injected idle duration should be greater than the idle state min
residency, otherwise we end up consuming more energy and potentially invert
the mitigation effect.

In function __cpuidle_cooling_register(), if
of_property_read_u32(np, "exit-latency-us", &latency_us) is failed, then
maybe we should not use latency_us. In this case, a zero latency_us for
forced_idle_latency_limit_ns is better than UMAX_INT. It means to use
governors in the usual way.

Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
 drivers/powercap/idle_inject.c    | 1 -
 drivers/thermal/cpuidle_cooling.c | 8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 6e1a0043c411..d76eef1e9387 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -309,7 +309,6 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
-	ii_dev->latency_us = UINT_MAX;
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 7ecab4b16b29..de770eb5b2ba 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -175,7 +175,8 @@ static int __cpuidle_cooling_register(struct device_node *np,
 	struct cpuidle_cooling_device *idle_cdev;
 	struct thermal_cooling_device *cdev;
 	unsigned int idle_duration_us = TICK_USEC;
-	unsigned int latency_us = UINT_MAX;
+	unsigned int latency_us = 0;
+	unsigned int residency_us = UINT_MAX;
 	char dev_name[THERMAL_NAME_LENGTH];
 	int id, ret;
 
@@ -199,6 +200,11 @@ static int __cpuidle_cooling_register(struct device_node *np,
 
 	of_property_read_u32(np, "duration-us", &idle_duration_us);
 	of_property_read_u32(np, "exit-latency-us", &latency_us);
+	of_property_read_u32(np, "min-residency-us", &residency_us);
+	if (idle_duration_us <= residency_us) {
+		ret = -EINVAL;
+		goto out_unregister;
+	}
 
 	idle_inject_set_duration(ii_dev, TICK_USEC, idle_duration_us);
 	idle_inject_set_latency(ii_dev, latency_us);
-- 
2.17.1

