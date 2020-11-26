Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E262C4C6E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 02:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgKZBM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 20:12:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8587 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKZBM5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 20:12:57 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ChKVg01mhzLtxk;
        Thu, 26 Nov 2020 09:12:27 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 09:12:46 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <rjw@rjwysocki.net>
CC:     <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <cj.chengjian@huawei.com>, <bobo.shaobowang@huawei.com>
Subject: [PATCH v2] cpufreq: Fix error return code in cpufreq_online()
Date:   Thu, 26 Nov 2020 09:12:39 +0800
Message-ID: <20201126011239.42294-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix to return proper error code instead of 0 in cpufreq_online(), as done
elsewhere in this function.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1e7e3f2ff09f..d3a28de35593 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1391,8 +1391,10 @@ static int cpufreq_online(unsigned int cpu)
 
 		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
 					       GFP_KERNEL);
-		if (!policy->min_freq_req)
+		if (!policy->min_freq_req) {
+			ret = -ENOMEM;
 			goto out_destroy_policy;
+		}
 
 		ret = freq_qos_add_request(&policy->constraints,
 					   policy->min_freq_req, FREQ_QOS_MIN,
@@ -1429,6 +1431,7 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->get && has_target()) {
 		policy->cur = cpufreq_driver->get(policy->cpu);
 		if (!policy->cur) {
+			ret = -EIO;
 			pr_err("%s: ->get() failed\n", __func__);
 			goto out_destroy_policy;
 		}
-- 
2.17.1

