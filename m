Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8406268A4
	for <lists+linux-pm@lfdr.de>; Sat, 12 Nov 2022 10:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiKLJmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Nov 2022 04:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiKLJmc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Nov 2022 04:42:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE01E73C
        for <linux-pm@vger.kernel.org>; Sat, 12 Nov 2022 01:42:16 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N8Vw56dPxzmV6t;
        Sat, 12 Nov 2022 17:41:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 17:42:14 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 17:42:14 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH] powercap: fix possible name leak while device_register() fails
Date:   Sat, 12 Nov 2022 17:40:48 +0800
Message-ID: <20221112094048.3614365-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If device_register() returns error, the name allocated by
dev_set_name() need be freed. In technical, we should call
put_device() to give up the reference and free the name in
driver core, but in some cases the device is not intizalized,
put_device() can not be called, so don't complicate the code,
just call kfree_const() to free name in the error path.

Fixes: 75d2364ea0ca ("PowerCap: Add class driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/powercap/powercap_sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index f0654a932b37..11e742dc83b9 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -572,6 +572,7 @@ struct powercap_zone *powercap_register_zone(
 err_name_alloc:
 	idr_remove(power_zone->parent_idr, power_zone->id);
 err_idr_alloc:
+	kfree_const(dev_name(&power_zone->dev));
 	if (power_zone->allocated)
 		kfree(power_zone);
 	mutex_unlock(&control_type->lock);
@@ -622,6 +623,7 @@ struct powercap_control_type *powercap_register_control_type(
 	dev_set_name(&control_type->dev, "%s", name);
 	result = device_register(&control_type->dev);
 	if (result) {
+		kfree_const(dev_name(&control_type->dev));
 		if (control_type->allocated)
 			kfree(control_type);
 		return ERR_PTR(result);
-- 
2.25.1

