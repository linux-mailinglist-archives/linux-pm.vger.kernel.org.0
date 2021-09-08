Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F3B403B2F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351774AbhIHOG7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 10:06:59 -0400
Received: from foss.arm.com ([217.140.110.172]:47156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhIHOG7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 10:06:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 589276D;
        Wed,  8 Sep 2021 07:05:51 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 097883F766;
        Wed,  8 Sep 2021 07:05:49 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v7 6/9] cpufreq: Add an interface to mark inefficient frequencies
Date:   Wed,  8 Sep 2021 15:05:27 +0100
Message-Id: <1631109930-290049-7-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
References: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some SoCs such as the sd855 have OPPs within the same policy whose cost is
higher than others with a higher frequency. Those OPPs are inefficients
and it might be interesting for a governor to not use them.

cpufreq_table_set_inefficient() allows the caller to identify a specified
frequency as being inefficient. Inefficient frequencies are only supported
on sorted tables.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c65a1d7385f8..18b486a1c816 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -661,10 +661,11 @@ struct governor_attr {
  *********************************************************************/
 
 /* Special Values of .frequency field */
-#define CPUFREQ_ENTRY_INVALID	~0u
-#define CPUFREQ_TABLE_END	~1u
+#define CPUFREQ_ENTRY_INVALID		~0u
+#define CPUFREQ_TABLE_END		~1u
 /* Special Values of .flags field */
-#define CPUFREQ_BOOST_FREQ	(1 << 0)
+#define CPUFREQ_BOOST_FREQ		(1 << 0)
+#define CPUFREQ_INEFFICIENT_FREQ	(1 << 1)
 
 struct cpufreq_frequency_table {
 	unsigned int	flags;
@@ -1003,6 +1004,36 @@ static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy
 
 	return count;
 }
+
+/**
+ * cpufreq_table_set_inefficient() - Mark a frequency as inefficient
+ * @policy:	the &struct cpufreq_policy containing the inefficient frequency
+ * @frequency:	the inefficient frequency
+ *
+ * The &struct cpufreq_policy must use a sorted frequency table
+ *
+ * Return:	%0 on success or a negative errno code
+ */
+
+static inline int
+cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
+			      unsigned int frequency)
+{
+	struct cpufreq_frequency_table *pos;
+
+	/* Not supported */
+	if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED)
+		return -EINVAL;
+
+	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
+		if (pos->frequency == frequency) {
+			pos->flags |= CPUFREQ_INEFFICIENT_FREQ;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
 #else
 static inline int cpufreq_boost_trigger_state(int state)
 {
@@ -1022,6 +1053,13 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 {
 	return false;
 }
+
+static inline int
+cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
+			      unsigned int frequency)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
-- 
2.7.4

