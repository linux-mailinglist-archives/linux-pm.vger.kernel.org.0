Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578B976FD31
	for <lists+linux-pm@lfdr.de>; Fri,  4 Aug 2023 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjHDJZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Aug 2023 05:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjHDJYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2023 05:24:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EA04C28
        for <linux-pm@vger.kernel.org>; Fri,  4 Aug 2023 02:23:54 -0700 (PDT)
Received: from dggpemm100008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RHKxh4B8yz1KCGK;
        Fri,  4 Aug 2023 17:22:48 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 17:23:53 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 17:23:52 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] thermal/drivers/int340x: simplify the code with module_platform_driver
Date:   Fri, 4 Aug 2023 17:21:01 +0800
Message-ID: <20230804092101.1354476-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The init/exit() of driver only calls platform_driver_register/unregister,
it can be simpilfied with module_platform_driver.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 .../thermal/intel/int340x_thermal/int3401_thermal.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
index 217786fba185..c93a28eec4db 100644
--- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
@@ -70,18 +70,7 @@ static struct platform_driver int3401_driver = {
 	},
 };
 
-static int __init proc_thermal_init(void)
-{
-	return platform_driver_register(&int3401_driver);
-}
-
-static void __exit proc_thermal_exit(void)
-{
-	platform_driver_unregister(&int3401_driver);
-}
-
-module_init(proc_thermal_init);
-module_exit(proc_thermal_exit);
+module_platform_driver(int3401_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
-- 
2.25.1

