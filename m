Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778113B6E43
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 08:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhF2G3l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 02:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhF2G3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 02:29:40 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13DDC061760
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 23:27:12 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id a7so6859416pga.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90DPEws+T5jbJDd5gSYlJAos9OyAfId3/wh6BJdGeVI=;
        b=BXLrq2CSiwTpbmLAXk57CIlMkOyaNg5YEcH48MFFMMUWhOFMXWcMF81PHkXPhFuc5q
         YlgnxZIl/ml6fq4dN4aiod0P2+VePzZvb+klia3wsWgAUhxHjvJEAFpOdgLjnp4S3Gzq
         7Gn6nkDfGeHzRmFi6WVfP4/Wu41okjMWGRV0HeZZmEeVpvsqDc+XM4QAPut+zVOx++jP
         G11/y8c2VcWGe+hHRiknlfhuTw8vlZw73LnNEiCa6Kky0mmqEjrbVC8CH55wUMEqvaxk
         jWVLw7DDgKqOjSgUaefXDD8vWktxm5nySRMRwnCtNYz9Pbwajx44QlMZgG47ey1UKzeE
         Bc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90DPEws+T5jbJDd5gSYlJAos9OyAfId3/wh6BJdGeVI=;
        b=MuhOPKGdUh0vMYni7jxGVW8PApfNwm+WBT/0c0KkX5mTu71vO8GjaCNT6bM0bdqLxC
         /DnA+BFuEDE2O2rWfrQyFhWIo3Qb4/3fqboBys09Ga0xMPazMBhHbiAF+CbbjJf0Zjpt
         LiL1Mu0dDmRaojauOsb2di/vZ8D+sWrGRJKLP5W+ou69Z4pPOFR1BOIAf5/2dbxxjPrc
         ZlZH0FS9Ke5ZptgvBwds6CwN0G4P46CGsjsEh+5l+ilgY+EQBnCPd0fXc3x700evT3Mr
         xqWiuvXsDqd6D2dUPMb03bUDnuCWpdZCoJ86908hB8ouZgf+pOewtO7+OZ/i06GwZoRO
         GujA==
X-Gm-Message-State: AOAM531dEhmg5rhyE9tB58NVDCJOq08IPHLQyxxeKmZ3Q65+/6/YXC04
        XFQ/N+DXVeLzljEi4sQlW0uJBw==
X-Google-Smtp-Source: ABdhPJwpU8Uo6U+mr+4LRxDD+wDTAEcCdIuFFMYkrRmgzvpxu3FHb6UmJo1eXZpAAsHTPzIN+30Esg==
X-Received: by 2002:a05:6a00:21c7:b029:2ec:2bfa:d0d1 with SMTP id t7-20020a056a0021c7b02902ec2bfad0d1mr28683696pfj.14.1624948032234;
        Mon, 28 Jun 2021 23:27:12 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id n4sm16811702pfo.188.2021.06.28.23.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:27:11 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        TungChen Shih <tung-chen.shih@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()
Date:   Tue, 29 Jun 2021 11:57:07 +0530
Message-Id: <b5ac439050ab3c5b92621e20490fe7f46d631ef6.1624946983.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

__cpufreq_driver_target() open codes cpufreq_driver_resolve_freq(), lets
make the former reuse the later.

Separate out __resolve_freq() to accept relation as well as an argument
and use it at both the locations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 42 ++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 802abc925b2a..d691c6c97c79 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -524,19 +524,8 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
-/**
- * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
- * one.
- * @policy: associated policy to interrogate
- * @target_freq: target frequency to resolve.
- *
- * The target to driver frequency mapping is cached in the policy.
- *
- * Return: Lowest driver-supported frequency greater than or equal to the
- * given target_freq, subject to policy (min/max) and driver limitations.
- */
-unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
-					 unsigned int target_freq)
+static unsigned int __resolve_freq(struct cpufreq_policy *policy,
+		unsigned int target_freq, unsigned int relation)
 {
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 	policy->cached_target_freq = target_freq;
@@ -545,7 +534,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 		unsigned int idx;
 
 		idx = cpufreq_frequency_table_target(policy, target_freq,
-						     CPUFREQ_RELATION_L);
+						     relation);
 		policy->cached_resolved_idx = idx;
 		return policy->freq_table[idx].frequency;
 	}
@@ -555,6 +544,23 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 
 	return target_freq;
 }
+
+/**
+ * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
+ * one.
+ * @policy: associated policy to interrogate
+ * @target_freq: target frequency to resolve.
+ *
+ * The target to driver frequency mapping is cached in the policy.
+ *
+ * Return: Lowest driver-supported frequency greater than or equal to the
+ * given target_freq, subject to policy (min/max) and driver limitations.
+ */
+unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
+					 unsigned int target_freq)
+{
+	return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_L);
+}
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
 unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
@@ -2225,13 +2231,11 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
-	int index;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	/* Make sure that target_freq is within supported range */
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = __resolve_freq(policy, target_freq, relation);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
@@ -2252,9 +2256,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	index = cpufreq_frequency_table_target(policy, target_freq, relation);
-
-	return __target_index(policy, index);
+	return __target_index(policy, policy->cached_resolved_idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
-- 
2.31.1.272.g89b43f80a514

