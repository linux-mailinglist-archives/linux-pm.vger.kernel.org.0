Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4ED25D1A8
	for <lists+linux-pm@lfdr.de>; Fri,  4 Sep 2020 08:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgIDGrX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Sep 2020 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIDGrO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2020 02:47:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F029C061244
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 23:47:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w3so6637678ljo.5
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 23:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tl35yEj3vFr4lnpqN2LCmv10aMtv5m1NyZfC1pcrNgQ=;
        b=W9cO6wDPQmVC6TMWa3OLr8vvizINHhKHQQvTZcqdUDxYXdku/2CJvJNpa6dx6+YkVu
         dO2tOFB3HdlunJUXuMoUUWdq6FvJXkagED+vRYec3XJ68yYFvz0z3iqsnvstsdvSKIaC
         9xKognRHjxbN+TNh2UmvRpJJRwqS7+LM1oZHCZusR8ycuJQGREPLm7lF9yhKX2h5i5wq
         7W2RBRVViUpQcG9lRwQzt49a4v+wJ9UfXTeesKcbNqeZYPSNkIsFIJ2ADvfnR+/5un87
         lmefxlS6wYbvw233vY2cmBNHnoVdfQ8ak+KtZ6cblmnEO5x5IobyqOH2yTQer8hVTHrK
         xTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tl35yEj3vFr4lnpqN2LCmv10aMtv5m1NyZfC1pcrNgQ=;
        b=Yb+ZqHhmmCwxWXs2UYNc6pRkSpDmMRuDPIySK6SoH7at8hqNY6GQtv9NGt2R7E0DIV
         iXiW4A9lCwpX96Dmcas2OVabSdAsXvAkUqLHUgUDcr4Y3XgrLQxrRItu63wYx1ZVWb76
         iWosZzPqrw5FlsKZrOfBeVc8QA/zHNcjbLjD9PxZUsp3E3BpS0xEqHFnSiCR0SP2pjYp
         0NCLyt05jbgvtM4xU7XmU9FwI5hFZpqYxyWSW7hSy8vKLZzUjPhIU21JI0/4/Jf944b2
         KdaTsUV9ZEruHIHsUzQEWjfs47qqk382fkLSgvMlgGOsZ5pYS6oOw0C4dilXqSsGFqRT
         D8Kg==
X-Gm-Message-State: AOAM532RQG+VxDVV9aciXf5NAFUH9DvSJh+WMNsB07+w/oQDozx62RU8
        /6+6FQnuKs79+hsMikpnW938tQ==
X-Google-Smtp-Source: ABdhPJwjM49j8i+XfHoLwy4HR+g/2ZH8aBtwHU+BHE59zLWfNJxe4UQH2hQRFNB6IWCLyPf2wxUnUA==
X-Received: by 2002:a2e:2a83:: with SMTP id q125mr3223909ljq.242.1599202031489;
        Thu, 03 Sep 2020 23:47:11 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id i187sm1100194lfd.65.2020.09.03.23.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 23:47:10 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@kernel.org>, linux-pm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] cpuidle: psci: Fix suspicious RCU usage
Date:   Fri,  4 Sep 2020 08:47:05 +0200
Message-Id: <20200904064705.239614-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The commit eb1f00237aca ("lockdep,trace: Expose tracepoints"), started to
expose us for tracepoints. This lead to the following RCU splat on an ARM64
Qcom board.

[    5.529634] WARNING: suspicious RCU usage
[    5.537307] sdhci-pltfm: SDHCI platform and OF driver helper
[    5.541092] 5.9.0-rc3 #86 Not tainted
[    5.541098] -----------------------------
[    5.541105] ../include/trace/events/lock.h:37 suspicious rcu_dereference_check() usage!
[    5.541110]
[    5.541110] other info that might help us debug this:
[    5.541110]
[    5.541116]
[    5.541116] rcu_scheduler_active = 2, debug_locks = 1
[    5.541122] RCU used illegally from extended quiescent state!
[    5.541129] no locks held by swapper/0/0.
[    5.541134]
[    5.541134] stack backtrace:
[    5.541143] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #86
[    5.541149] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    5.541157] Call trace:
[    5.568185] sdhci_msm 7864900.sdhci: Got CD GPIO
[    5.574186]  dump_backtrace+0x0/0x1c8
[    5.574206]  show_stack+0x14/0x20
[    5.574229]  dump_stack+0xe8/0x154
[    5.574250]  lockdep_rcu_suspicious+0xd4/0xf8
[    5.574269]  lock_acquire+0x3f0/0x460
[    5.574292]  _raw_spin_lock_irqsave+0x80/0xb0
[    5.574314]  __pm_runtime_suspend+0x4c/0x188
[    5.574341]  psci_enter_domain_idle_state+0x40/0xa0
[    5.574362]  cpuidle_enter_state+0xc0/0x610
[    5.646487]  cpuidle_enter+0x38/0x50
[    5.650651]  call_cpuidle+0x18/0x40
[    5.654467]  do_idle+0x228/0x278
[    5.657678]  cpu_startup_entry+0x24/0x70
[    5.661153]  rest_init+0x1a4/0x278
[    5.665061]  arch_call_rest_init+0xc/0x14
[    5.668272]  start_kernel+0x508/0x540

Following the path in pm_runtime_put_sync_suspend() from
psci_enter_domain_idle_state(), it seems like we end up using the RCU.
Therefore, let's simply silence the splat by informing the RCU about it
with RCU_NONIDLE.

Note that, this is a temporary solution. Instead we should strive to avoid
using RCU_NONIDLE (and similar), but rather push rcu_idle_enter|exit()
further down, closer to the arch specific code. However, as the CPU PM
notifiers are also using the RCU, additional rework is needed.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 74463841805f..d928b37718bd 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -66,7 +66,7 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 		return -1;
 
 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
-	pm_runtime_put_sync_suspend(pd_dev);
+	RCU_NONIDLE(pm_runtime_put_sync_suspend(pd_dev));
 
 	state = psci_get_domain_state();
 	if (!state)
@@ -74,7 +74,7 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
 
-	pm_runtime_get_sync(pd_dev);
+	RCU_NONIDLE(pm_runtime_get_sync(pd_dev));
 
 	cpu_pm_exit();
 
-- 
2.25.1

