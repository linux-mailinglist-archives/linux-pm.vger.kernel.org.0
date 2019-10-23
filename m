Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C75FE1884
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 13:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391107AbfJWLIn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 07:08:43 -0400
Received: from [217.140.110.172] ([217.140.110.172]:48428 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2391006AbfJWLIn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Oct 2019 07:08:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FA35497;
        Wed, 23 Oct 2019 04:08:22 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E32C3F718;
        Wed, 23 Oct 2019 04:08:21 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: vexpress-spc: find and skip duplicates when merging frequencies
Date:   Wed, 23 Oct 2019 12:08:11 +0100
Message-Id: <20191023110811.15086-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023110811.15086-1-sudeep.holla@arm.com>
References: <20191023110811.15086-1-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the cpufreq core aborts the validation and return error
immediately when it encounter duplicate frequency table entries.
This change was introduced long back since commit da0c6dc00c69
("cpufreq: Handle sorted frequency tables more efficiently").

However, this missed the testing with modified firmware for long time.
Inorder to make it work with default settings, we need to ensure the
merged table for bL switcher contains no duplicates. Find the duplicates
and skip them when merging the frequenct tables of A15 and A7 clusters.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 35 ++++++++++++++++++++------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 093ef8d3a8d4..921dbd42b3bb 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -242,6 +242,19 @@ static inline u32 get_table_max(struct cpufreq_frequency_table *table)
 	return max_freq;
 }
 
+static bool search_frequency(struct cpufreq_frequency_table *table, int size,
+			     unsigned int freq)
+{
+	int count;
+
+	for (count = 0; count < size; count++) {
+		if (table[count].frequency == freq)
+			return true;
+	}
+
+	return false;
+}
+
 static int merge_cluster_tables(void)
 {
 	int i, j, k = 0, count = 1;
@@ -256,13 +269,21 @@ static int merge_cluster_tables(void)
 
 	freq_table[MAX_CLUSTERS] = table;
 
-	/* Add in reverse order to get freqs in increasing order */
-	for (i = MAX_CLUSTERS - 1; i >= 0; i--) {
-		for (j = 0; freq_table[i][j].frequency != CPUFREQ_TABLE_END;
-		     j++, k++) {
-			table[k].frequency =
-				VIRT_FREQ(i, freq_table[i][j].frequency);
-		}
+	/* Add A7_CLUSTER first to get freqs in increasing order */
+	for (j = 0; freq_table[A7_CLUSTER][j].frequency != CPUFREQ_TABLE_END;
+	     j++, k++) {
+		table[k].frequency =
+			VIRT_FREQ(A7_CLUSTER, freq_table[A7_CLUSTER][j].frequency);
+	}
+	count = k;
+
+	/* And then A15_CLUSTER checking for duplicates */
+	for (j = 0; freq_table[A15_CLUSTER][j].frequency != CPUFREQ_TABLE_END;
+	     j++) {
+		if (search_frequency(table, count,
+				     freq_table[A15_CLUSTER][j].frequency))
+			continue; /* skip duplicates */
+		table[k++].frequency = freq_table[A15_CLUSTER][j].frequency;
 	}
 
 	table[k].driver_data = k;
-- 
2.17.1

