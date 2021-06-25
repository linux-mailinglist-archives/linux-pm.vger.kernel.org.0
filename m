Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6F03B44A9
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFYNoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 09:44:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40834 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229498AbhFYNoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 09:44:12 -0400
X-UUID: 23ea012c1ad045c08f9b12ad6cce49c5-20210625
X-UUID: 23ea012c1ad045c08f9b12ad6cce49c5-20210625
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tung-chen.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 798672426; Fri, 25 Jun 2021 21:41:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Jun 2021 21:41:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Jun 2021 21:41:46 +0800
From:   TungChen Shih <tung-chen.shih@mediatek.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        TungChen Shih <tung-chen.shih@mediatek.com>
Subject: [PATCH v1 1/1] cpufreq: fix the target freq not in the range of policy->min & max
Date:   Fri, 25 Jun 2021 21:41:30 +0800
Message-ID: <20210625134129.11885-1-tung-chen.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

    In cpufreq_frequency_table_target(), this function will try to find
an index for @target_freq in freq_table, and the frequency of selected
index should be in the range [policy->min, policy->max], which means:

    policy->min <= policy->freq_table[idx].frequency <= policy->max

    Though "clamp_val(target_freq, policy->min, policy->max);" would
have been called to check this condition, when policy->max or min is
not exactly one of the frequency in the frequency table,
policy->freq_table[idx].frequency may still go out of the range

    For example, if our sorted freq_table is [3000, 2000, 1000], and
suppose we have:

    @target_freq = 2500
    @policy->min = 2000
    @policy->max = 2200
    @relation = CPUFREQ_RELATION_L

1. After clamp_val(target_freq, policy->min, policy->max); @target_freq
becomes 2200
2. Since we use CPUFREQ_REALTION_L, final selected freq will be 3000 which
beyonds policy->max

Signed-off-by: TungChen Shih <tung-chen.shih@mediatek.com>
---
 include/linux/cpufreq.h | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 353969c7acd3..60cb15740fdf 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -975,21 +975,40 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
 						 unsigned int relation)
 {
+	int idx = 0;
 	if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
 		return cpufreq_table_index_unsorted(policy, target_freq,
 						    relation);
 
 	switch (relation) {
 	case CPUFREQ_RELATION_L:
-		return cpufreq_table_find_index_l(policy, target_freq);
+		idx = cpufreq_table_find_index_l(policy, target_freq);
+		break;
 	case CPUFREQ_RELATION_H:
-		return cpufreq_table_find_index_h(policy, target_freq);
+		idx = cpufreq_table_find_index_h(policy, target_freq);
+		break;
 	case CPUFREQ_RELATION_C:
-		return cpufreq_table_find_index_c(policy, target_freq);
+		idx = cpufreq_table_find_index_c(policy, target_freq);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
 	}
+
+	/* target index verification */
+	if (policy->freq_table[idx].frequency > policy->max) {
+		if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
+			idx--;
+		else
+			idx++;
+	} else if (policy->freq_table[idx].frequency < policy->min) {
+		if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
+			idx++;
+		else
+			idx--;
+	}
+
+	return idx;
 }
 
 static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
-- 
2.18.0

