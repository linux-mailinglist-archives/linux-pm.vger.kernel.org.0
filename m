Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F36BC444
	for <lists+linux-pm@lfdr.de>; Thu, 16 Mar 2023 04:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCPDLF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 23:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCPDLE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 23:11:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FBE211E0
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 20:11:03 -0700 (PDT)
Received: from dggpeml500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PcXJL4430znWsN;
        Thu, 16 Mar 2023 11:08:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500004.china.huawei.com
 (7.185.36.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 16 Mar
 2023 11:11:01 +0800
From:   qinyu <qinyu32@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <zhangxiaofeng46@huawei.com>,
        <hewenliang4@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH] cpufreq: warn about invalid vals to scaling_max/min_freq interfaces
Date:   Thu, 16 Mar 2023 11:15:49 +0800
Message-ID: <20230316031549.1343340-1-qinyu32@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500004.china.huawei.com (7.185.36.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When echo an invalid val to scaling_min_freq:
> echo 123abc123 > scaling_min_freq
It looks weird to have a return val of 0:
> echo $?
> 0

Sane people won't echo strings like that into these interfaces but fuzz
tests may do. Also, maybe it's better to inform people if input is invalid
or out of range.

After this:
> echo 123abc123 > scaling_min_freq
> -bash: echo: write error: Invalid argument

Signed-off-by: qinyu <qinyu32@huawei.com>
Tested-by: zhangxiaofeng <zhangxiaofeng46@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6d8fd3b8d..d61f7308f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -725,9 +725,9 @@ static ssize_t store_##file_name					\
 	unsigned long val;						\
 	int ret;							\
 									\
-	ret = sscanf(buf, "%lu", &val);					\
-	if (ret != 1)							\
-		return -EINVAL;						\
+	ret = kstrtoul(buf, 0, &val);					\
+	if (ret)							\
+		return ret;						\
 									\
 	ret = freq_qos_update_request(policy->object##_freq_req, val);\
 	return ret >= 0 ? count : ret;					\
-- 
2.33.0

