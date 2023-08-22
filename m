Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9291078413A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjHVMv3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Aug 2023 08:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjHVMv3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 08:51:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3523FCC6;
        Tue, 22 Aug 2023 05:51:27 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVTdn53VSztRwS;
        Tue, 22 Aug 2023 20:47:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 20:51:24 +0800
From:   Jie Zhan <zhanjie9@hisilicon.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
        <xuwei5@huawei.com>, <wanghuiqiang@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH v2] cpufreq: Support per-policy performance boost
Date:   Tue, 22 Aug 2023 20:48:37 +0800
Message-ID: <20230822124837.3016641-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The boost control currently applies to the whole system.  However, users
may prefer to boost a subset of cores in order to provide prioritized
performance to workloads running on the boosted cores.

Enable per-policy boost by adding a 'boost' sysfs interface under each
policy path.  This can be found at:

	/sys/devices/system/cpu/cpufreq/policy<*>/boost

Same to the global boost switch, writing 1/0 to the per-policy 'boost'
enables/disables boost on a cpufreq policy respectively.

The user view of global and per-policy boost controls should be:

1. Enabling global boost initially enables boost on all policies, and
per-policy boost can then be enabled or disabled individually, given that
the platform does support so.

2. Disabling global boost makes the per-policy boost interface illegal.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: Wei Xu <xuwei5@hisilicon.com>
---
A possible question could be: why not just limiting 'scaling_max_freq'?
Well, the fundamental difference is that per-policy boost could be more
user-friendly.  When global boost is enabled, it is not straightforward
to figure out the base frequency for setting 'scaling_max_freq' to a
non-boost value. Also, this is supposed to take effect on the physical
upper frequency limit, reflected through 'cpuinfo_max_freq'.

v1->v2:
- Rename the interface from 'local_boost' to 'boost'.
- Illegalize writing 0 to per-policy even if global boost is off.
- Show the per-policy 'boost' file only when ->set_boost() is available.

v1: https://lore.kernel.org/linux-pm/20230724075827.4160512-1-zhanjie9@hisilicon.com/

 drivers/cpufreq/cpufreq.c | 43 +++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50bbc969ffe5..81e21fa070e1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -86,6 +86,7 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy);
 static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      struct cpufreq_governor *new_gov,
 			      unsigned int new_pol);
+static bool cpufreq_boost_supported(void);
 
 /*
  * Two notifier lists: the "policy" list is involved in the
@@ -621,6 +622,40 @@ static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
 }
 define_one_global_rw(boost);
 
+static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", policy->boost_enabled);
+}
+
+static ssize_t store_local_boost(struct cpufreq_policy *policy,
+				 const char *buf, size_t count)
+{
+	int ret, enable;
+
+	ret = kstrtoint(buf, 10, &enable);
+	if (ret || enable < 0 || enable > 1)
+		return -EINVAL;
+
+	if (!cpufreq_driver->boost_enabled)
+		return -EINVAL;
+
+	if (policy->boost_enabled == enable)
+		return count;
+
+	cpus_read_lock();
+	ret = cpufreq_driver->set_boost(policy, enable);
+	cpus_read_unlock();
+
+	if (ret)
+		return ret;
+
+	policy->boost_enabled = enable;
+
+	return count;
+}
+
+static struct freq_attr local_boost = __ATTR(boost, 0644, show_local_boost, store_local_boost);
+
 static struct cpufreq_governor *find_governor(const char *str_governor)
 {
 	struct cpufreq_governor *t;
@@ -1055,6 +1090,12 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
 			return ret;
 	}
 
+	if (cpufreq_boost_supported()) {
+		ret = sysfs_create_file(&policy->kobj, &local_boost.attr);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -2716,6 +2757,8 @@ int cpufreq_boost_trigger_state(int state)
 		ret = cpufreq_driver->set_boost(policy, state);
 		if (ret)
 			goto err_reset_state;
+
+		policy->boost_enabled = state;
 	}
 	cpus_read_unlock();
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 172ff51c1b2a..fa02f2fa88c4 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -140,6 +140,9 @@ struct cpufreq_policy {
 	 */
 	bool			dvfs_possible_from_any_cpu;
 
+	/* Per policy boost enabled flag. */
+	bool			boost_enabled;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;
-- 
2.30.0

