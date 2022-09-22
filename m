Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EAC5E61D5
	for <lists+linux-pm@lfdr.de>; Thu, 22 Sep 2022 13:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIVL52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Sep 2022 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIVL52 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2022 07:57:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C66A5735
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 04:57:27 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYDDV61svzMn6Q;
        Thu, 22 Sep 2022 19:52:42 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:57:25 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 19:57:24 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>,
        <srinivas.pandruvada@linux.intel.com>, <atenart@kernel.org>,
        <sumeet.r.pawnikar@intel.com>, <linux-pm@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next] thermal/drivers/int340x/processor_thermal: Switch to use module_pci_driver() macro
Date:   Thu, 22 Sep 2022 20:31:41 +0800
Message-ID: <20220922123141.24042-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since pci provides the helper macro module_pci_driver(), we may replace
the module_init/exit with it.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 .../int340x_thermal/processor_thermal_device_pci.c  | 13 +------------
 .../processor_thermal_device_pci_legacy.c           | 13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index c2dc4c158b9d..bf1b1cdfade4 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -373,18 +373,7 @@ static struct pci_driver proc_thermal_pci_driver = {
 	.driver.pm	= &proc_thermal_pci_pm,
 };
 
-static int __init proc_thermal_init(void)
-{
-	return pci_register_driver(&proc_thermal_pci_driver);
-}
-
-static void __exit proc_thermal_exit(void)
-{
-	pci_unregister_driver(&proc_thermal_pci_driver);
-}
-
-module_init(proc_thermal_init);
-module_exit(proc_thermal_exit);
+module_pci_driver(proc_thermal_pci_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
index 4571a1a53b84..09e032f822f3 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
@@ -151,18 +151,7 @@ static struct pci_driver proc_thermal_pci_driver = {
 	.driver.pm	= &proc_thermal_pci_pm,
 };
 
-static int __init proc_thermal_init(void)
-{
-	return pci_register_driver(&proc_thermal_pci_driver);
-}
-
-static void __exit proc_thermal_exit(void)
-{
-	pci_unregister_driver(&proc_thermal_pci_driver);
-}
-
-module_init(proc_thermal_init);
-module_exit(proc_thermal_exit);
+module_pci_driver(proc_thermal_pci_driver);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
-- 
2.17.1

