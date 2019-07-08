Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6643661BC7
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 10:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfGHIkw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 04:40:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727976AbfGHIkw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 04:40:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9E8041D49CC49EB0025C;
        Mon,  8 Jul 2019 16:40:48 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 16:40:39 +0800
From:   ZhangXiaoxu <zhangxiaoxu5@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <linux-pm@vger.kernel.org>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] cpufreq: schedutil: Fix covert rate_limit_us to freq_update_delay_ns overflow
Date:   Mon, 8 Jul 2019 16:46:23 +0800
Message-ID: <1562575583-99575-1-git-send-email-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When covert rate_limit_us to freq_update_delay_ns, it maybe overflow
and lead an undefined behavior.

So, limit the rate_limit_us to UINT_MAX / NSEC_PER_USEC.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
---
 kernel/sched/cpufreq_schedutil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 962cf34..01e05f3 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -590,6 +590,9 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 	if (kstrtouint(buf, 10, &rate_limit_us))
 		return -EINVAL;
 
+	if (rate_limit_us > UINT_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
 	tunables->rate_limit_us = rate_limit_us;
 
 	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
-- 
2.7.4

