Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6162B569A65
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jul 2022 08:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiGGGVd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 02:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiGGGVc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 02:21:32 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7DE11EAFD
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gcja/
        n51b4UOFzNtpwpg1wg3peoyUe8l/P+wpk2qG14=; b=ox7RAkv7iUanyfy2ygRzU
        7tvuHRPCw5fJdy0qDuIYLR3KHoWst2vhiYYB2sIYGgsTWzeqXX2H7zKck2W7Uizx
        WKNECOmTtsMl6ho3dgR7BrSWlz82jg3yT6dn/U546Av5cdaSb6sAZmPbNCz14BiK
        kEL7gZ5TNgyq0SSzM2XBZw=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgAnt4NZe8ZifC2qHQ--.27085S2;
        Thu, 07 Jul 2022 14:21:14 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org, windhl@126.com
Subject: [PATCH] thermal/core: Fix refcount bugs in __thermal_cooling_device_register()
Date:   Thu,  7 Jul 2022 14:21:12 +0800
Message-Id: <20220707062112.308239-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgAnt4NZe8ZifC2qHQ--.27085S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1fGFyfAFy5urW7Jw45trb_yoW8uF45pa
        y5Ga45ArWDWr48C3yYyFy8WFZF9ay2yayrZry8GF90kwsxJ343tryUuFy7Z34rGFW8CF4r
        Ar45trn8uF1DZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi4rWxUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgI3F1-HZdBzHQAAs7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For each new reference of 'device_node', we should increase its
refcount. Otherwise, there will be premature free.

For example, in drivers\thermal\tegra\soctherm.c, the function
soctherm_init_hw_throt_cdev() will use for_each_child_of_node() to
iterate its child device_node which will be then passed into
 __thermal_cooling_device_register(). As for_each_xxx OF APIs will
automatically increase and decrease the refcount of 'device_node',
we should use additional of_node_get() to record the new refernece.

NOTE, we should also call the corresponding of_node_put() in fail path
or when the *_unregister() function is called.

Fixes: a116b5d44f14 ("thermal: core: introduce thermal_of_cooling_device_register")
Signed-off-by: Liang He <windhl@126.com>
---
 I cannot confirm, in *_unregister, we should put of_node_put() in or
out of the *_lock/*_unlock functions. Please check it carefully.

 drivers/thermal/thermal_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cdc0552e8c42..c459e2958b7b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -919,7 +919,7 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
-	cdev->np = np;
+	cdev->np = of_node_get(np);
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
@@ -947,6 +947,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	return cdev;
 
 out_kfree_type:
+	of_node_put(cdev->np);
 	thermal_cooling_device_destroy_sysfs(cdev);
 	kfree(cdev->type);
 	put_device(&cdev->device);
@@ -1111,6 +1112,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_list_lock);
 
+	of_node_put(cdev->np);
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
 	device_del(&cdev->device);
 	thermal_cooling_device_destroy_sysfs(cdev);
-- 
2.25.1

