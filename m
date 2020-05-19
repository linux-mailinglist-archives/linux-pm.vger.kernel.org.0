Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65A1D9592
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 13:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgESLsE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 07:48:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4868 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728730AbgESLr5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 07:47:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BDB311AD85804D11C374;
        Tue, 19 May 2020 19:47:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 19:47:46 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <Souvik.Chakravarty@arm.com>, <Thanu.Rangarajan@arm.com>
CC:     <Sudeep.Holla@arm.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH v3 1/2] cpufreq: change '.set_boost' to act on only one policy
Date:   Tue, 19 May 2020 19:41:28 +0800
Message-ID: <1589888489-13828-2-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1589888489-13828-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1589888489-13828-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Macro 'for_each_active_policy()' is defined internally. To avoid some
cpufreq driver needing this macro to iterate over all the policies in
'.set_boost' callback, we redefine '.set_boost' to act on only one
policy and pass the policy as an argument.
'cpufreq_boost_trigger_state()' iterate over all the policies to set
boost for the system. This is preparation for adding SW BOOST support
for CPPC.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/cpufreq/acpi-cpufreq.c |  4 ++--
 drivers/cpufreq/cpufreq.c      | 53 +++++++++++++++++++++---------------------
 include/linux/cpufreq.h        |  2 +-
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 289e8ce..b0a9eb5 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -126,7 +126,7 @@ static void boost_set_msr_each(void *p_en)
 	boost_set_msr(enable);
 }
 
-static int set_boost(int val)
+static int set_boost(struct cpufreq_policy *policy, int val)
 {
 	get_online_cpus();
 	on_each_cpu(boost_set_msr_each, (void *)(long)val, 1);
@@ -162,7 +162,7 @@ static ssize_t store_cpb(struct cpufreq_policy *policy, const char *buf,
 	if (ret || val > 1)
 		return -EINVAL;
 
-	set_boost(val);
+	set_boost(policy, val);
 
 	return count;
 }
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d03f250..d0d86b1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2532,34 +2532,29 @@ void cpufreq_update_limits(unsigned int cpu)
 /*********************************************************************
  *               BOOST						     *
  *********************************************************************/
-static int cpufreq_boost_set_sw(int state)
+static int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 {
-	struct cpufreq_policy *policy;
-
-	for_each_active_policy(policy) {
-		int ret;
-
-		if (!policy->freq_table)
-			return -ENXIO;
+	int ret;
 
-		ret = cpufreq_frequency_table_cpuinfo(policy,
-						      policy->freq_table);
-		if (ret) {
-			pr_err("%s: Policy frequency update failed\n",
-			       __func__);
-			return ret;
-		}
+	if (!policy->freq_table)
+		return -ENXIO;
 
-		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
-		if (ret < 0)
-			return ret;
+	ret = cpufreq_frequency_table_cpuinfo(policy, policy->freq_table);
+	if (ret) {
+		pr_err("%s: Policy frequency update failed\n", __func__);
+		return ret;
 	}
 
+	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
 int cpufreq_boost_trigger_state(int state)
 {
+	struct cpufreq_policy *policy;
 	unsigned long flags;
 	int ret = 0;
 
@@ -2570,16 +2565,22 @@ int cpufreq_boost_trigger_state(int state)
 	cpufreq_driver->boost_enabled = state;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	ret = cpufreq_driver->set_boost(state);
-	if (ret) {
-		write_lock_irqsave(&cpufreq_driver_lock, flags);
-		cpufreq_driver->boost_enabled = !state;
-		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
-		pr_err("%s: Cannot %s BOOST\n",
-		       __func__, state ? "enable" : "disable");
+	for_each_active_policy(policy) {
+		ret = cpufreq_driver->set_boost(policy, state);
+		if (ret)
+			goto err_reset_state;
 	}
 
+	return 0;
+
+err_reset_state:
+	write_lock_irqsave(&cpufreq_driver_lock, flags);
+	cpufreq_driver->boost_enabled = !state;
+	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
+	pr_err("%s: Cannot %s BOOST\n",
+	       __func__, state ? "enable" : "disable");
+
 	return ret;
 }
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 67d5950..3494f67 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -367,7 +367,7 @@ struct cpufreq_driver {
 
 	/* platform specific boost support code */
 	bool		boost_enabled;
-	int		(*set_boost)(int state);
+	int		(*set_boost)(struct cpufreq_policy *policy, int state);
 };
 
 /* flags */
-- 
1.7.12.4

