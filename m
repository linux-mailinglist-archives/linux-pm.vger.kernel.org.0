Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81FF3E9011
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 14:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhHKMGm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 08:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbhHKMGm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 08:06:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A22FC0613D3
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a8so2970994pjk.4
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCfZOEpIhIENyNI7NFl9TKqagaadd2OPxUYrFvWYUZk=;
        b=N0+z2ZI5wdHwMuZJpOC52Yxq1cpcYeyyFJ06OSD2lZSHVAZCISKIzdeDukQ/oN3CdI
         J9+ZezPKKCSnLLTT2NIyKVcXd10uZFruG8Ua5ul1sPmziqln/pUVioG3h5r6/t0PSxxe
         NhbXigYmE1MR4lQcoFkv3RlIrh59Z6HqJAj6qSpAx2alGFTB2bQ4/WBYp6nLJ0it96gM
         ShOiv7G4wLXTUBSeCm3rB32YwyiBVLTcG5LIdbdsCZRM1WANgE8bhilW3B1RvzODpMgh
         v+Sd/Aw5n3sLZ8qvJWO+O1ToWi+GZA7NkO7kqyBLOzDwy2qQEZS9oRY6u6SIk2loGcrH
         6K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCfZOEpIhIENyNI7NFl9TKqagaadd2OPxUYrFvWYUZk=;
        b=jrNsEfBdzqMaTXHo3naHjEh0Odhd5tGHOQelYDJbYiPs3Pp5YcIzY0q6+QjW1N6kXD
         ZcKU+I/EHtz4JS3epfXRS5MJ5J2vdO0LzJrOCK47ILBj9PIx2B0BHJ84w8QQGAQ4cXhS
         9IHYmL2uE8vopz1aENe3+Bh9Q9U26oReU79DT+Q8kt2xtrA1bkMC1sqCgQ0vl7gHQmWF
         4Y76xrHCKMv/Pn5etJ/QwOL5e4OkSIbRYXFJ00yncSUamNrUS5NjBcXL6ncY7BULmmd8
         UUZS50oPuHStmWNgUWU2rNgBXFniEbHGEfRwi5AzRF63mZnrjl03NEbQA6KeAx/73LtW
         0pHg==
X-Gm-Message-State: AOAM530Z/6Oa3+PDWk4cWpf9ZjUBNW2ppTQk+8pCc0lsEQds8iS2BlPj
        PQMjTiGq2/feN0ObR1dptRwRwt8QbIuNXg==
X-Google-Smtp-Source: ABdhPJxHBqNN5skaJW8GQ3jHypuv+OW68o8tbmOwa0rhZSrf35/HxLpJsLkxJnu6Ao+gpfxV1Wi3Mw==
X-Received: by 2002:a17:903:2309:b029:12c:f6bd:23a4 with SMTP id d9-20020a1709032309b029012cf6bd23a4mr4014927plh.75.1628683577546;
        Wed, 11 Aug 2021 05:06:17 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id o22sm26851065pfu.87.2021.08.11.05.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:06:17 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/9] cpufreq: Auto-register with energy model if asked
Date:   Wed, 11 Aug 2021 17:28:39 +0530
Message-Id: <9ca302a02d6b51240af8668634c93972183b593f.1628682874.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628682874.git.viresh.kumar@linaro.org>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Many cpufreq drivers register with the energy model for each policy and
do exactly the same thing. Follow the footsteps of thermal-cooling, to
get it done from the cpufreq core itself.

Provide a new callback, which will be called, if present, by the cpufreq
core at the right moment (more on that in the code's comment). Also
provide a generic implementation that uses dev_pm_opp_of_register_em().

This also allows us to register with the EM at a later point of time,
compared to ->init(), from where the EM core can access cpufreq policy
directly using cpufreq_cpu_get() type of helpers and perform other work,
like marking few frequencies inefficient, this will be done separately.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 12 ++++++++++++
 include/linux/cpufreq.h   | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 06c526d66dd3..75974e7d6cc5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1493,6 +1493,18 @@ static int cpufreq_online(unsigned int cpu)
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 	}
 
+	/*
+	 * Register with the energy model before sched_cpufreq_governor_change()
+	 * is called, which will result in rebuilding of the sched domains,
+	 * which should only be done once the energy model is properly
+	 * initialized for the policy first.
+	 *
+	 * Also, this should be called before the policy is registered with
+	 * cooling framework.
+	 */
+	if (cpufreq_driver->register_em)
+		cpufreq_driver->register_em(policy);
+
 	ret = cpufreq_init_policy(policy);
 	if (ret) {
 		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9fd719475fcd..1295621f6c28 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -9,10 +9,12 @@
 #define _LINUX_CPUFREQ_H
 
 #include <linux/clk.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/completion.h>
 #include <linux/kobject.h>
 #include <linux/notifier.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
@@ -373,6 +375,12 @@ struct cpufreq_driver {
 	/* platform specific boost support code */
 	bool		boost_enabled;
 	int		(*set_boost)(struct cpufreq_policy *policy, int state);
+
+	/*
+	 * Set by drivers that want the core to automatically register the
+	 * policy's devices with Energy Model.
+	 */
+	void		(*register_em)(struct cpufreq_policy *policy);
 };
 
 /* flags */
@@ -1046,4 +1054,10 @@ unsigned int cpufreq_generic_get(unsigned int cpu);
 void cpufreq_generic_init(struct cpufreq_policy *policy,
 		struct cpufreq_frequency_table *table,
 		unsigned int transition_latency);
+
+static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
+{
+	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
+				  policy->related_cpus);
+}
 #endif /* _LINUX_CPUFREQ_H */
-- 
2.31.1.272.g89b43f80a514

