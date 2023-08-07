Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196B6772589
	for <lists+linux-pm@lfdr.de>; Mon,  7 Aug 2023 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjHGNYj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Aug 2023 09:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjHGNX6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 09:23:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C482694
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 06:23:11 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKH373ghlzNmrY;
        Mon,  7 Aug 2023 21:19:15 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 21:22:43 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 21:22:42 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>
CC:     <sre@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 4/5] power: reset: axxia-reset: use builtin_platform_driver() to simplify code
Date:   Mon, 7 Aug 2023 21:19:50 +0800
Message-ID: <20230807131951.3443880-5-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807131951.3443880-1-yangyingliang@huawei.com>
References: <20230807131951.3443880-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The axxia_reset_init() doesn't do anything special, so it can use the
builtin_platform_driver() macro to eliminate boilerplate code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/power/reset/axxia-reset.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/power/reset/axxia-reset.c b/drivers/power/reset/axxia-reset.c
index f7b40be5d6b6..24946766760c 100644
--- a/drivers/power/reset/axxia-reset.c
+++ b/drivers/power/reset/axxia-reset.c
@@ -80,9 +80,4 @@ static struct platform_driver axxia_reset_driver = {
 		.of_match_table = of_match_ptr(of_axxia_reset_match),
 	},
 };
-
-static int __init axxia_reset_init(void)
-{
-	return platform_driver_register(&axxia_reset_driver);
-}
-device_initcall(axxia_reset_init);
+builtin_platform_driver(axxia_reset_driver);
-- 
2.25.1

