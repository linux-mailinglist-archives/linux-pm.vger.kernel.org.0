Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4E394B75
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 11:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhE2J41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 05:56:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2464 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2J41 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 05:56:27 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FscK73BSBz67nh;
        Sat, 29 May 2021 17:51:55 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:54:49 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:54:49 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-pm@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: stats: Remove redundant initialization of local variable
Date:   Sat, 29 May 2021 17:54:39 +0800
Message-ID: <1622282079-52196-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Local variable 'count' and 'ret' will be initialized, so remove the
redundant initialization.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/cpufreq/cpufreq_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index da717f7cd9a9..2af6c5b43c43 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -211,7 +211,7 @@ void cpufreq_stats_free_table(struct cpufreq_policy *policy)
 
 void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 {
-	unsigned int i = 0, count = 0, ret = -ENOMEM;
+	unsigned int i = 0, count, ret;
 	struct cpufreq_stats *stats;
 	unsigned int alloc_size;
 	struct cpufreq_frequency_table *pos;
-- 
2.7.4

