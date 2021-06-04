Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F1839B78F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFDLIQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:08:16 -0400
Received: from foss.arm.com ([217.140.110.172]:36216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhFDLIP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Jun 2021 07:08:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80F7F1478;
        Fri,  4 Jun 2021 04:06:29 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E76C3F73D;
        Fri,  4 Jun 2021 04:06:28 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v3 4/6] cpufreq: Skip inefficient frequencies in cpufreq_driver_resolve_freq()
Date:   Fri,  4 Jun 2021 12:05:59 +0100
Message-Id: <1622804761-126737-5-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Avoid using frequencies marked as inefficient. This change affects
schedutil, which is the only in-tree governor using the function
cpufreq_driver_resolve_freq().

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 802abc9..7431f40a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -546,6 +546,10 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 
 		idx = cpufreq_frequency_table_target(policy, target_freq,
 						     CPUFREQ_RELATION_L);
+
+		/* Replace the target with an efficient one */
+		idx = cpufreq_frequency_find_efficient(policy, idx);
+
 		policy->cached_resolved_idx = idx;
 		return policy->freq_table[idx].frequency;
 	}
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d10784c..0ca4c9a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -994,6 +994,17 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 	}
 }
 
+static inline unsigned int
+cpufreq_frequency_find_efficient(struct cpufreq_policy *policy,
+				 unsigned int idx)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	unsigned int efficient_idx = table[idx].efficient;
+
+	return table[efficient_idx].frequency <= policy->max ? efficient_idx :
+							       idx;
+}
+
 static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *pos;
-- 
2.7.4

