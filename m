Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC5B780627
	for <lists+linux-pm@lfdr.de>; Fri, 18 Aug 2023 09:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbjHRHKl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Aug 2023 03:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358130AbjHRHK3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Aug 2023 03:10:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E230D1
        for <linux-pm@vger.kernel.org>; Fri, 18 Aug 2023 00:10:27 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRtGD6NH1ztRtk;
        Fri, 18 Aug 2023 15:06:44 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500019.china.huawei.com
 (7.221.188.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 15:10:22 +0800
From:   Zhang Zekun <zhangzekun11@huawei.com>
To:     <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
        <ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>
CC:     <zhangzekun11@huawei.com>
Subject: [PATCH] soc: ti: Use for_each_node_with_property() simplify code logic
Date:   Fri, 18 Aug 2023 15:01:49 +0800
Message-ID: <20230818070149.23103-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduct for_each_node_with_property() to iterate through the
nodes, this can simplify the code logic a bit, no functional
change here.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/genpd/ti/ti_sci_pm_domains.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/genpd/ti/ti_sci_pm_domains.c b/drivers/genpd/ti/ti_sci_pm_domains.c
index a33ec7eaf23d..34645104fe45 100644
--- a/drivers/genpd/ti/ti_sci_pm_domains.c
+++ b/drivers/genpd/ti/ti_sci_pm_domains.c
@@ -119,7 +119,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ti_sci_genpd_provider *pd_provider;
 	struct ti_sci_pm_domain *pd;
-	struct device_node *np = NULL;
+	struct device_node *np;
 	struct of_phandle_args args;
 	int ret;
 	u32 max_id = 0;
@@ -138,11 +138,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&pd_provider->pd_list);
 
 	/* Find highest device ID used for power domains */
-	while (1) {
-		np = of_find_node_with_property(np, "power-domains");
-		if (!np)
-			break;
-
+	for_each_node_with_property(np, "power-domains") {
 		index = 0;
 
 		while (1) {
-- 
2.17.1

