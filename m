Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B25EC796
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiI0PYP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiI0PYM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 11:24:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB01616CD
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 08:24:11 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4McNbG2gK6zlVjH;
        Tue, 27 Sep 2022 23:19:54 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 23:24:09 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 23:24:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 3/4] cpufreq: qcom-nvmem: Switch to use dev_err_probe() helper
Date:   Tue, 27 Sep 2022 23:40:20 +0800
Message-ID: <20220927154021.816570-4-yangyingliang@huawei.com>
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

In the probe path, dev_err() can be replaced with dev_err_probe()
which will check if error code is -EPROBE_DEFER and prints the
error name. It also sets the defer probe reason which can be
checked later through debugfs. It's more simple in error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 863548f59c3e..8bf2808f0181 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -295,11 +295,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	if (drv->data->get_version) {
 		speedbin_nvmem = of_nvmem_cell_get(np, NULL);
 		if (IS_ERR(speedbin_nvmem)) {
-			if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
-				dev_err(cpu_dev,
-					"Could not get nvmem cell: %ld\n",
-					PTR_ERR(speedbin_nvmem));
-			ret = PTR_ERR(speedbin_nvmem);
+			ret = dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
+					    "Could not get nvmem cell\n");
 			goto free_drv;
 		}
 
-- 
2.25.1

