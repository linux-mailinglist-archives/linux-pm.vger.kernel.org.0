Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C67756ED
	for <lists+linux-pm@lfdr.de>; Wed,  9 Aug 2023 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjHIKPP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Aug 2023 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIKPP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2023 06:15:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FB910D2
        for <linux-pm@vger.kernel.org>; Wed,  9 Aug 2023 03:15:14 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RLQpZ2Th7z1hwbM;
        Wed,  9 Aug 2023 18:12:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 18:15:11 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] thermal/drivers/db8500: Remove redundant of_match_ptr()
Date:   Wed, 9 Aug 2023 18:14:39 +0800
Message-ID: <20230809101439.2663042-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver depends on CONFIG_OF, it is not necessary to use
of_match_ptr() here.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/thermal/db8500_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index fca5c2c93bf9..576f88b6a1b3 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -229,7 +229,7 @@ MODULE_DEVICE_TABLE(of, db8500_thermal_match);
 static struct platform_driver db8500_thermal_driver = {
 	.driver = {
 		.name = "db8500-thermal",
-		.of_match_table = of_match_ptr(db8500_thermal_match),
+		.of_match_table = db8500_thermal_match,
 	},
 	.probe = db8500_thermal_probe,
 	.suspend = db8500_thermal_suspend,
-- 
2.34.1

