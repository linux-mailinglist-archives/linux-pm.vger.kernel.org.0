Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB8F5EC797
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiI0PYQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiI0PYO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 11:24:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919121616DD
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 08:24:13 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McNbT287CzWgp9;
        Tue, 27 Sep 2022 23:20:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 23:24:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 23:24:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 4/4] cpufreq: sun50i: Switch to use dev_err_probe() helper
Date:   Tue, 27 Sep 2022 23:40:21 +0800
Message-ID: <20220927154021.816570-5-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927154021.816570-1-yangyingliang@huawei.com>
References: <20220927154021.816570-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the probe path, convert pr_err() to dev_err_probe() which will
check if error code is -EPROBE_DEFER and prints the error name.
It also sets the defer probe reason which can be checked later
through debugfs. It's more simple in error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index a4922580ce06..1583a370da39 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -56,12 +56,9 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 
 	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
 	of_node_put(np);
-	if (IS_ERR(speedbin_nvmem)) {
-		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
-			pr_err("Could not get nvmem cell: %ld\n",
-			       PTR_ERR(speedbin_nvmem));
-		return PTR_ERR(speedbin_nvmem);
-	}
+	if (IS_ERR(speedbin_nvmem))
+		return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
+				     "Could not get nvmem cell\n");
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 	nvmem_cell_put(speedbin_nvmem);
-- 
2.25.1

