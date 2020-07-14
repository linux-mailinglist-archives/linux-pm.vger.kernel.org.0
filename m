Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A89B21F3A1
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgGNOOE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:14:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbgGNOOD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 10:14:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 51AE2774C1BD5835F576;
        Tue, 14 Jul 2020 22:14:02 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Jul 2020 22:13:52 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH -next] cpufreq: powernv: Make some symbols static
Date:   Tue, 14 Jul 2020 22:23:55 +0800
Message-ID: <20200714142355.29819-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sparse tool complains as follows:

drivers/cpufreq/powernv-cpufreq.c:88:1: warning:
 symbol 'pstate_revmap' was not declared. Should it be static?
drivers/cpufreq/powernv-cpufreq.c:383:18: warning:
 symbol 'cpufreq_freq_attr_cpuinfo_nominal_freq' was not declared. Should it be static?
drivers/cpufreq/powernv-cpufreq.c:669:6: warning:
 symbol 'gpstate_timer_handler' was not declared. Should it be static?
drivers/cpufreq/powernv-cpufreq.c:902:6: warning:
 symbol 'powernv_cpufreq_work_fn' was not declared. Should it be static?

Those symbols are not used outside of this file, so mark
them static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 8646eb197cd9..cf118263ec65 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -85,7 +85,7 @@ struct global_pstate_info {
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 
-DEFINE_HASHTABLE(pstate_revmap, POWERNV_MAX_PSTATES_ORDER);
+static DEFINE_HASHTABLE(pstate_revmap, POWERNV_MAX_PSTATES_ORDER);
 /**
  * struct pstate_idx_revmap_data: Entry in the hashmap pstate_revmap
  *				  indexed by a function of pstate id.
@@ -380,7 +380,7 @@ static ssize_t cpuinfo_nominal_freq_show(struct cpufreq_policy *policy,
 		powernv_freqs[powernv_pstate_info.nominal].frequency);
 }
 
-struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
+static struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
 	__ATTR_RO(cpuinfo_nominal_freq);
 
 #define SCALING_BOOST_FREQS_ATTR_INDEX		2
@@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
  * according quadratic equation. Queues a new timer if it is still not equal
  * to local pstate
  */
-void gpstate_timer_handler(struct timer_list *t)
+static void gpstate_timer_handler(struct timer_list *t)
 {
 	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
 	struct cpufreq_policy *policy = gpstates->policy;
@@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
-void powernv_cpufreq_work_fn(struct work_struct *work)
+static void powernv_cpufreq_work_fn(struct work_struct *work)
 {
 	struct chip *chip = container_of(work, struct chip, throttle);
 	struct cpufreq_policy *policy;

