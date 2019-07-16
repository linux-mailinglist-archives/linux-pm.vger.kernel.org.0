Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5D36A5F7
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 11:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfGPJzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 05:55:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40921 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733186AbfGPJzY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 05:55:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so9180753pgj.7
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igbw8Lq9b0TFNBWb47jJMKCAo+bPsNo96FEJcJLrXVc=;
        b=H1uaGUoAeqRk6S2i3GDT8ntkwDm5cC2Flj+OsmfRqTVZQOoqEeOTDCKsdr3QFfWCQA
         jIPdgK/siD6VGKOf89ZSbHQ+j1jPeChgW95ao4XWPlukec3p7kpdOUigGHiApEVT7fAi
         EafM7d2Qy7MqOBAe6k5q7qDDPhMD7AdzffO+i9yl3vvgOzpHm4gVd5lgQ58XayNvMuhh
         4UHcVXOZ220ePO6/sNBsel0AOBBiS4C4rr5kGcrP7M+qOUm5wTvGLrYjEKbctD6LwlTU
         SwW+LMRxd/hv3ImIN9xUrJOoCbpaTxkwlDmUIlUNaY9z8ypRk3RqDmqs5LVX7Tr8mz87
         okiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igbw8Lq9b0TFNBWb47jJMKCAo+bPsNo96FEJcJLrXVc=;
        b=S4wrekG4jWCbRl0HezNDT6qsLuiU/LrqF2WYUyzwf9aA+LwMZuXyPys92/J7wzI2f9
         jpHwvcalkCwRHCXp1COzR3Osfd0goAne1v+h+WGuhBXRRucMXZKx1a7eOc4Fb3o336v2
         OoB6xrG4VaWe96tXcUbQPEvooozTthN5PRLDW2ou0ycBGwENXeYnSCvpjGpwrZWwXCJL
         yNBvbIZXXR0+VR3qryB2qtuQHcoHPF1auS9YVlNutGLQpvSO2Hdi4s+Edd79uuiUFsfv
         CyL1znsZebd3+07SFeWAnLIYef6uZYp0tEB5yhBIV+K/RICpA84mjGGMQL5m6ACfp11U
         7gRg==
X-Gm-Message-State: APjAAAUI8LN2DDKAwRRap9y0hIPa6b1KQYJ+3A8h6O69CFdGOcN8oyCm
        RbD4Nor5adxsZFsj9BZyupZxvfMg9Fs=
X-Google-Smtp-Source: APXvYqyE+7Bc3mdRY/8YtnwTZaQfSALWQTjULeSe8UmU3bSLLn/OuNURlj4XozcnY0IUCtzfztxAaA==
X-Received: by 2002:a17:90a:d14b:: with SMTP id t11mr34976911pjw.79.1563270923963;
        Tue, 16 Jul 2019 02:55:23 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id d14sm27038469pfo.154.2019.07.16.02.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:55:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] cpufreq: Remove CPUFREQ_ADJUST and CPUFREQ_NOTIFY policy notifier events
Date:   Tue, 16 Jul 2019 15:24:53 +0530
Message-Id: <77857b9eadc26c57de2637fcca014239a93551e4.1563270828.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563270828.git.viresh.kumar@linaro.org>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

No driver makes reference to these events now, remove them and the code
related to them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 36 +++++++-----------------------------
 include/linux/cpufreq.h   |  6 ++----
 2 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8a7eff2a3771..bd91091ed6b8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2362,15 +2362,13 @@ EXPORT_SYMBOL(cpufreq_get_policy);
  * @policy: Policy object to modify.
  * @new_policy: New policy data.
  *
- * Pass @new_policy to the cpufreq driver's ->verify() callback, run the
- * installed policy notifiers for it with the CPUFREQ_ADJUST value, pass it to
- * the driver's ->verify() callback again and run the notifiers for it again
- * with the CPUFREQ_NOTIFY value.  Next, copy the min and max parameters
- * of @new_policy to @policy and either invoke the driver's ->setpolicy()
- * callback (if present) or carry out a governor update for @policy.  That is,
- * run the current governor's ->limits() callback (if the governor field in
- * @new_policy points to the same object as the one in @policy) or replace the
- * governor for @policy with the new one stored in @new_policy.
+ * Pass @new_policy to the cpufreq driver's ->verify() callback. Next, copy the
+ * min and max parameters of @new_policy to @policy and either invoke the
+ * driver's ->setpolicy() callback (if present) or carry out a governor update
+ * for @policy.  That is, run the current governor's ->limits() callback (if the
+ * governor field in @new_policy points to the same object as the one in
+ * @policy) or replace the governor for @policy with the new one stored in
+ * @new_policy.
  *
  * The cpuinfo part of @policy is not updated by this function.
  */
@@ -2398,26 +2396,6 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	/*
-	 * The notifier-chain shall be removed once all the users of
-	 * CPUFREQ_ADJUST are moved to use the QoS framework.
-	 */
-	/* adjust if necessary - all reasons */
-	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-			CPUFREQ_ADJUST, new_policy);
-
-	/*
-	 * verify the cpu speed can be set within this limit, which might be
-	 * different to the first one
-	 */
-	ret = cpufreq_driver->verify(new_policy);
-	if (ret)
-		return ret;
-
-	/* notification of the new policy */
-	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-			CPUFREQ_NOTIFY, new_policy);
-
 	policy->min = new_policy->min;
 	policy->max = new_policy->max;
 	trace_cpu_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index e28c8af697d2..cb1e86a14c7a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -456,10 +456,8 @@ static inline void cpufreq_resume(void) {}
 #define CPUFREQ_POSTCHANGE		(1)
 
 /* Policy Notifiers  */
-#define CPUFREQ_ADJUST			(0)
-#define CPUFREQ_NOTIFY			(1)
-#define CPUFREQ_CREATE_POLICY		(2)
-#define CPUFREQ_REMOVE_POLICY		(3)
+#define CPUFREQ_CREATE_POLICY		(0)
+#define CPUFREQ_REMOVE_POLICY		(1)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-- 
2.21.0.rc0.269.g1a574e7a288b

