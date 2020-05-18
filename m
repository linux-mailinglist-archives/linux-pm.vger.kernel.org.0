Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC11D7196
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgERHQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 03:16:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4809 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726800AbgERHQr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 03:16:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E4EDE43FD8761C7DB1C1;
        Mon, 18 May 2020 15:16:43 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 18 May 2020 15:16:35 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <Souvik.Chakravarty@arm.com>, <Thanu.Rangarajan@arm.com>
CC:     <Sudeep.Holla@arm.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH v2 2/3] cpufreq: export 'cpufreq_policy_list' and make macro 'for_each_*_policy' public
Date:   Mon, 18 May 2020 15:10:07 +0800
Message-ID: <1589785808-12138-3-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1589785808-12138-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1589785808-12138-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export variable 'cpufreq_policy_list' and make macro 'for_each_*_policy"
public. This is preparation for adding SW BOOST support for CPPC.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 16 ++--------------
 include/linux/cpufreq.h   | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bb6746e..953e163 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -30,20 +30,8 @@
 #include <linux/tick.h>
 #include <trace/events/power.h>
 
-static LIST_HEAD(cpufreq_policy_list);
-
-/* Macros to iterate over CPU policies */
-#define for_each_suitable_policy(__policy, __active)			 \
-	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
-		if ((__active) == !policy_is_inactive(__policy))
-
-#define for_each_active_policy(__policy)		\
-	for_each_suitable_policy(__policy, true)
-#define for_each_inactive_policy(__policy)		\
-	for_each_suitable_policy(__policy, false)
-
-#define for_each_policy(__policy)			\
-	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
+LIST_HEAD(cpufreq_policy_list);
+EXPORT_SYMBOL_GPL(cpufreq_policy_list);
 
 /* Iterate over governors */
 static LIST_HEAD(cpufreq_governor_list);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 018dce8..27a2a7f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -222,6 +222,20 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
+
+extern struct list_head cpufreq_policy_list;
+
+/* Macros to iterate over CPU policies */
+#define for_each_suitable_policy(__policy, __active)			 \
+	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
+		if ((__active) == !policy_is_inactive(__policy))
+#define for_each_active_policy(__policy)		\
+	for_each_suitable_policy(__policy, true)
+#define for_each_inactive_policy(__policy)		\
+	for_each_suitable_policy(__policy, false)
+#define for_each_policy(__policy)			\
+	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
+
 #else
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
-- 
1.7.12.4

