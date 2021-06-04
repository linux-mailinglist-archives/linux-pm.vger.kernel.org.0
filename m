Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1839B78C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhFDLIO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:08:14 -0400
Received: from foss.arm.com ([217.140.110.172]:36202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhFDLIO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Jun 2021 07:08:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F07E6143B;
        Fri,  4 Jun 2021 04:06:27 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CD4C3F73D;
        Fri,  4 Jun 2021 04:06:26 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient frequencies
Date:   Fri,  4 Jun 2021 12:05:58 +0100
Message-Id: <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some SoCs such as the sd855 have OPPs within the same policy whose cost is
higher than others with a higher frequency. Those OPPs are inefficients and
it might be interesting for a governor to not use them.

Adding a flag, CPUFREQ_INEFFICIENT_FREQ, to mark such OPPs into the
frequency table, as well as a new cpufreq_frequency_table member
"efficient". This new member will allow a governor to quickly resolve an
inefficient frequency to an efficient one.

Efficient OPPs point to themselves. Governors must also ensure that the
efficiency resolution does not break the policy maximum.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 67e56cf..0756d7d6 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -351,6 +351,53 @@ static int set_freq_table_sorted(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static void set_freq_table_efficiencies(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
+	enum cpufreq_table_sorting sort = policy->freq_table_sorted;
+	int efficient, idx;
+
+	/* Not supported */
+	if (sort == CPUFREQ_TABLE_UNSORTED) {
+		cpufreq_for_each_entry_idx(pos, table, idx)
+			pos->efficient = idx;
+		return;
+	}
+
+	/* The highest frequency is always efficient */
+	cpufreq_for_each_entry_idx(pos, table, idx) {
+		if (pos->frequency == CPUFREQ_ENTRY_INVALID)
+			continue;
+
+		efficient = idx;
+
+		if (sort == CPUFREQ_TABLE_SORTED_DESCENDING)
+			break;
+	}
+
+	for (;;) {
+		pos = &table[idx];
+
+		if (pos->frequency == CPUFREQ_ENTRY_INVALID)
+			continue;
+
+		if (pos->flags & CPUFREQ_INEFFICIENT_FREQ) {
+			pos->efficient = efficient;
+		} else {
+			pos->efficient = idx;
+			efficient = idx;
+		}
+
+		if (sort == CPUFREQ_TABLE_SORTED_ASCENDING) {
+			if (--idx < 0)
+				break;
+		} else {
+			if (table[++idx].frequency == CPUFREQ_TABLE_END)
+				break;
+		}
+	}
+}
+
 int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 {
 	int ret;
@@ -362,7 +409,13 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
-	return set_freq_table_sorted(policy);
+	ret = set_freq_table_sorted(policy);
+	if (ret)
+		return ret;
+
+	set_freq_table_efficiencies(policy);
+
+	return ret;
 }
 
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 353969c..d10784c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -666,13 +666,15 @@ struct governor_attr {
 #define CPUFREQ_ENTRY_INVALID	~0u
 #define CPUFREQ_TABLE_END	~1u
 /* Special Values of .flags field */
-#define CPUFREQ_BOOST_FREQ	(1 << 0)
+#define CPUFREQ_BOOST_FREQ	 (1 << 0)
+#define CPUFREQ_INEFFICIENT_FREQ (1 << 1)
 
 struct cpufreq_frequency_table {
 	unsigned int	flags;
 	unsigned int	driver_data; /* driver specific data, not used by core */
 	unsigned int	frequency; /* kHz - doesn't need to be in ascending
 				    * order */
+	unsigned int	efficient; /* idx of an efficient frequency */
 };
 
 #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
-- 
2.7.4

