Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7073C6C0BC5
	for <lists+linux-pm@lfdr.de>; Mon, 20 Mar 2023 09:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjCTIJ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Mar 2023 04:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjCTIJX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2023 04:09:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915E4EF8
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 01:09:17 -0700 (PDT)
Received: from dggpeml500004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pg6kX2rmRz17MWC;
        Mon, 20 Mar 2023 16:06:12 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500004.china.huawei.com
 (7.185.36.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 20 Mar
 2023 16:09:15 +0800
From:   qinyu <qinyu32@huawei.com>
To:     <rafael@kernel.org>
CC:     <hewenliang4@huawei.com>, <linfeilong@huawei.com>,
        <linux-pm@vger.kernel.org>, <qinyu32@huawei.com>,
        <viresh.kumar@linaro.org>, <zhangxiaofeng46@huawei.com>,
        <yumpusamongus@gmail.com>
Subject: [PATCH v2] cpufreq: warn about invalid vals to scaling_max/min_freq interfaces
Date:   Mon, 20 Mar 2023 16:17:02 +0800
Message-ID: <20230320081702.203843-1-qinyu32@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAJZ5v0gFpdWih3Z4Jy6O8t9qz64w1md00ZcQY_exEn9+rC1BOw@mail.gmail.com>
References: <CAJZ5v0gFpdWih3Z4Jy6O8t9qz64w1md00ZcQY_exEn9+rC1BOw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500004.china.huawei.com (7.185.36.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
tests may do. Also, maybe it's better to inform people if input is
invalid.

After this:
> echo 123abc123 > scaling_min_freq
> -bash: echo: write error: Invalid argument

Signed-off-by: qinyu <qinyu32@huawei.com>
Tested-by: zhangxiaofeng <zhangxiaofeng46@huawei.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
v2:
- reword commit message to match the actual code changes.
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

