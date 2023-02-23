Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A795B6A037C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Feb 2023 09:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjBWIFC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Feb 2023 03:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBWIFB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2023 03:05:01 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4F2B634
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 00:04:59 -0800 (PST)
Received: from dggpeml500004.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PMlqk5z9Xz16Nwt;
        Thu, 23 Feb 2023 16:02:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500004.china.huawei.com
 (7.185.36.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 23 Feb
 2023 16:04:57 +0800
From:   qinyu <qinyu32@huawei.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <hewenliang4@huawei.com>,
        <linfeilong@huawei.com>
Subject: [PATCH] power: supply: fix null pointer check order in __power_supply_register
Date:   Thu, 23 Feb 2023 16:10:47 +0800
Message-ID: <20230223081047.219326-1-qinyu32@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

There is an null pointer check order issue here: if we have to
check !desc and !desc->name anyway, check it before dereferencing it in
pr_warn().

Signed-off-by: qinyu <qinyu32@huawei.com>
---
 drivers/power/supply/power_supply_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index cc5b2e22b..f3d7c1da2 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1207,13 +1207,13 @@ __power_supply_register(struct device *parent,
 	struct power_supply *psy;
 	int rc;
 
+	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
+		return ERR_PTR(-EINVAL);
+
 	if (!parent)
 		pr_warn("%s: Expected proper parent device for '%s'\n",
 			__func__, desc->name);
 
-	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
-		return ERR_PTR(-EINVAL);
-
 	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
 	    (!desc->usb_types || !desc->num_usb_types))
 		return ERR_PTR(-EINVAL);
-- 
2.33.0

