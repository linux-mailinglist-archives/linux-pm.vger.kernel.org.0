Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF2A1CA6EB
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 11:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgEHJR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 05:17:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4297 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbgEHJR3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 05:17:29 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BE68A22B3D822B2B4BE1;
        Fri,  8 May 2020 17:17:26 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:17:19 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <Souvik.Chakravarty@arm.com>, <Thanu.Rangarajan@arm.com>
CC:     <Sudeep.Holla@arm.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH 2/3] cpufreq: Add SW BOOST support for drivers without frequency table
Date:   Fri, 8 May 2020 17:11:03 +0800
Message-ID: <1588929064-30270-3-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1588929064-30270-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1588929064-30270-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Software-managed BOOST get the boost frequency by check the flag
CPUFREQ_BOOST_FREQ at driver's frequency table. But some cpufreq driver
don't have frequency table and use other methods to get the frequency
range, such CPPC cpufreq driver.

To add SW BOOST support for drivers without frequency table, we add
members in 'cpufreq_policy.cpufreq_cpuinfo' to record the max frequency
of boost mode and non-boost mode. The cpufreq driver initialize these two
members when probing.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 23 +++++++++++++++--------
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 475fb1b..a299426 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2508,15 +2508,22 @@ static int cpufreq_boost_set_sw(int state)
 	int ret = -EINVAL;
 
 	for_each_active_policy(policy) {
-		if (!policy->freq_table)
-			continue;
-
-		ret = cpufreq_frequency_table_cpuinfo(policy,
+		if (policy->freq_table) {
+			ret = cpufreq_frequency_table_cpuinfo(policy,
 						      policy->freq_table);
-		if (ret) {
-			pr_err("%s: Policy frequency update failed\n",
-			       __func__);
-			break;
+			if (ret) {
+				pr_err("%s: Policy frequency update failed\n",
+				       __func__);
+				break;
+			}
+		} else if (policy->cpuinfo.boost_max_freq) {
+			if (state)
+				policy->max = policy->cpuinfo.boost_max_freq;
+			else
+				policy->max = policy->cpuinfo.nonboost_max_freq;
+			policy->cpuinfo.max_freq = policy->max;
+		} else {
+			continue;
 		}
 
 		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 018dce8..c3449e6 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -43,6 +43,8 @@ enum cpufreq_table_sorting {
 struct cpufreq_cpuinfo {
 	unsigned int		max_freq;
 	unsigned int		min_freq;
+	unsigned int		boost_max_freq;
+	unsigned int		nonboost_max_freq;
 
 	/* in 10^(-9) s = nanoseconds */
 	unsigned int		transition_latency;
-- 
1.7.12.4

