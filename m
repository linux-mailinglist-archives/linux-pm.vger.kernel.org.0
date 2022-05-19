Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8566A52D2BE
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiESMoK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiESMoJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C63ABA57A
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:08 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCa/KSNbjnK6O9VgiZpsL/eX4a2K+USLvRmLNLTKJx4=;
        b=SLKGyOuh2fUjbEtRhicAAsc08LEUkvMpjQuOQQBL8G/v/JAiLc1KT1xlrCiADe9T1m3Z0x
        bvXiB6w0O4jCxXS5wNAjO1JNrJxcuc/H3o47CNCmi4BrQp24h9qfqAWtxCBvAuZE94pEUu
        +xjrAKfSNw5VoMAStVekwFM3aPckhwbPG7sSWNgA+ycquVnl7zp/b8/WVhfnqBuF+PPXsz
        xV8uRMJdRY4pv0G345XoJtmnYhb03NOen6JbnpcyEEMO6rBLZ9/G5S0IBJG7NJd4m+Ub5b
        KO5sAuaQ5UYkU6RwKh5lFKCqsRiZeC+SBeykb9oeFyuM5nB7tt5ju+moqH5rGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCa/KSNbjnK6O9VgiZpsL/eX4a2K+USLvRmLNLTKJx4=;
        b=J9B/Kk1hxCJUM5ghtmSKB0Z+YqiInpObHdCS991ICr7DpaAo0pK4ZiP7ei9x2ZMRf9Izcu
        FB8ZycFbZvwvLrAQ==
From:   "thermal-bot for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Fix memory leak in
 __thermal_cooling_device_register()
Cc:     Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220511020605.3096734-1-yangyingliang@huawei.com>
References: <20220511020605.3096734-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <165296424564.4207.5876769207032745575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     98a160e898c0f4a979af9de3ab48b4b1d42d1dbb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//98a160e898c0f4a979af9de3ab48b4b1d42d1dbb
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Wed, 11 May 2022 10:06:05 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:53 +02:00

thermal/core: Fix memory leak in __thermal_cooling_device_register()

I got memory leak as follows when doing fault injection test:

unreferenced object 0xffff888010080000 (size 264312):
  comm "182", pid 102533, jiffies 4296434960 (age 10.100s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 40 7f 1f b9 ff ff ff ff  ........@.......
  backtrace:
    [<0000000038b2f4fc>] kmalloc_order_trace+0x1d/0x110 mm/slab_common.c:969
    [<00000000ebcb8da5>] __kmalloc+0x373/0x420 include/linux/slab.h:510
    [<0000000084137f13>] thermal_cooling_device_setup_sysfs+0x15d/0x2d0 include/linux/slab.h:586
    [<00000000352b8755>] __thermal_cooling_device_register+0x332/0xa60 drivers/thermal/thermal_core.c:927
    [<00000000fb9f331b>] devm_thermal_of_cooling_device_register+0x6b/0xf0 drivers/thermal/thermal_core.c:1041
    [<000000009b8012d2>] max6650_probe.cold+0x557/0x6aa drivers/hwmon/max6650.c:211
    [<00000000da0b7e04>] i2c_device_probe+0x472/0xac0 drivers/i2c/i2c-core-base.c:561

If device_register() fails, thermal_cooling_device_destroy_sysfs() need be called
to free the memory allocated in thermal_cooling_device_setup_sysfs().

Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20220511020605.3096734-1-yangyingliang@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 82654dc..cdc0552 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -947,6 +947,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	return cdev;
 
 out_kfree_type:
+	thermal_cooling_device_destroy_sysfs(cdev);
 	kfree(cdev->type);
 	put_device(&cdev->device);
 	cdev = NULL;
