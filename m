Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985443955E1
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 09:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhEaHTy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 03:19:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3302 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhEaHTy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 03:19:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FtmjS2wj1z1BGrB;
        Mon, 31 May 2021 15:13:32 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 15:18:12 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 15:18:12 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-pm@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2] cpufreq: stats: Clean up local variable of cpufreq_stats_create_table
Date:   Mon, 31 May 2021 15:16:07 +0800
Message-ID: <1622445367-37754-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Local variable 'count' will be initialized and 'ret' also is not required,
so remove the redundant initialization and get rid of 'ret'.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
ChangeLog:
v1-->v2:
    1. Address Viresh's comment, get rid of 'ret'

 drivers/cpufreq/cpufreq_stats.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index da717f7cd9a9..1570d6f3e75d 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -211,7 +211,7 @@ void cpufreq_stats_free_table(struct cpufreq_policy *policy)
 
 void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 {
-	unsigned int i = 0, count = 0, ret = -ENOMEM;
+	unsigned int i = 0, count;
 	struct cpufreq_stats *stats;
 	unsigned int alloc_size;
 	struct cpufreq_frequency_table *pos;
@@ -253,8 +253,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	stats->last_index = freq_table_get_index(stats, policy->cur);
 
 	policy->stats = stats;
-	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
-	if (!ret)
+	if (!sysfs_create_group(&policy->kobj, &stats_attr_group))
 		return;
 
 	/* We failed, release resources */
-- 
2.7.4

