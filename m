Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58603B4F70
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jun 2021 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFZQ0P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Jun 2021 12:26:15 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:43586 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229890AbhFZQ0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Jun 2021 12:26:15 -0400
X-UUID: 9c6cadf2445d4918b45d29e5eb155797-20210627
X-UUID: 9c6cadf2445d4918b45d29e5eb155797-20210627
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <tung-chen.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2102777713; Sun, 27 Jun 2021 00:23:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 27 Jun 2021 00:23:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Jun 2021 00:23:47 +0800
From:   TungChen Shih <tung-chen.shih@mediatek.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        TungChen Shih <tung-chen.shih@mediatek.com>
Subject: [PATCH v2 1/1] cpufreq: fix the target freq not in the range of policy->min & max
Date:   Sun, 27 Jun 2021 00:23:25 +0800
Message-ID: <20210626162324.8236-1-tung-chen.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

    The function cpufreq_driver_resolve_freq() should return the lowest
supported freq greater than or equal to the given target_freq, subject
to policy (min/max) and driver limitations. However, the index returned
by cpufreq_frequency_table_target() won't subject to policy min/max in
some cases.

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
 drivers/cpufreq/cpufreq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 802abc925b2a..8e3a17781618 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -544,8 +544,23 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 	if (cpufreq_driver->target_index) {
 		unsigned int idx;
 
+		/*  to find the frequency >= target_freq */
 		idx = cpufreq_frequency_table_target(policy, target_freq,
 						     CPUFREQ_RELATION_L);
+
+		/* frequency should subject to policy (min/max) */
+		if (policy->freq_table[idx].frequency > policy->max) {
+			if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
+				idx--;
+			else
+				idx++;
+		} else if (policy->freq_table[idx].frequency < policy->min) {
+			if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
+				idx++;
+			else
+				idx--;
+		}
+
 		policy->cached_resolved_idx = idx;
 		return policy->freq_table[idx].frequency;
 	}
-- 
2.18.0

