Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2759E70C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244682AbiHWQWt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbiHWQWb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6871D10C809
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:21 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HIHd/mfTo8vwhkQ8G11si9cVT5h4vE1Qms6knbERiA=;
        b=hDZGXweezdvNBooF6ljugDK3SXCjsWjgIEHFNqkrEmUUCcGVdk4mgere5ax6/H4cX4N/6z
        N3oO3G8lH+wIV+/n2jJwva8LD4VXU68DPoXfvYrABlbC5oYsmM6jEnyOOWFrZDWfQMn5Rq
        G8oP7ZroRLq20wpe7Z++sh7Lp2J6en6BsIRP6itmVAGbrfzYL0CMiSKYdyEZafL6QYFZ1d
        rJtyV2sb8AYDxqeCYMFgArQe/BXUeSwzkDtjzwvG++Wg6UjiqxBII5LYjnWgYcFGsioSKi
        ppvEeVC6kf6xliVmhjg8Riila1JqO/+XQasEkHWYumS8rlK6ZjUpido77GDrKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HIHd/mfTo8vwhkQ8G11si9cVT5h4vE1Qms6knbERiA=;
        b=z4CixMR+uRZz+wQWuU4DCSaav/Gk7v9rYTGZoa6+4vF2HK6Oo6F3X83XCtyDUCkmTDObJl
        +feA3DceiWq/NnAw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Fix free after use in
 thermal_of_unregister()
Cc:     Michael Walle <michael@walle.cc>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220809085629.509116-4-daniel.lezcano@linaro.org>
References: <20220809085629.509116-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <166125859864.401.4569735736264895171.tip-bot2@tip-bot2>
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

Commit-ID:     8fb5b71ed37dbe469eaa930e2ddc93ec9e305f3c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8fb5b71ed37dbe469eaa930e2ddc93ec9e305f3c
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 09 Aug 2022 10:56:29 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:37 +02:00

thermal/of: Fix free after use in thermal_of_unregister()

The thermal zone is freed after being unregistered. The release method
devm_thermal_zone_device_register() calls
  -> thermal_of_zone_device_unregister()

This one calls thermal_zone_device_unregister() which frees the
thermal zone. However, thermal_of_zone_device_unregister() does access
this freed pointer to free different resources allocated by the
thermal_of framework which is invalid.

It results in a kernel panic:

[    1.915140] thermal_sys: Failed to find thermal zone for tmu id=2
[    1.921279] qoriq_thermal 1f80000.tmu: Failed to register sensors
[    1.927395] qoriq_thermal: probe of 1f80000.tmu failed with error -22
[    1.934189] Unable to handle kernel paging request at virtual address 01adadadadadad88
[    1.942146] Mem abort info:
[    1.944948]   ESR = 0x0000000096000004
[    1.948708]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.954042]   SET = 0, FnV = 0
[    1.957107]   EA = 0, S1PTW = 0
[    1.960253]   FSC = 0x04: level 0 translation fault
[    1.965147] Data abort info:
[    1.968030]   ISV = 0, ISS = 0x00000004
[    1.971878]   CM = 0, WnR = 0
[    1.974852] [01adadadadadad88] address between user and kernel address ranges
[    1.982016] Internal error: Oops: 96000004 [#1] SMP
[    1.986907] Modules linked in:
[    1.989969] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-next-20220808-00080-g1c46f44502e0 #1697
[    1.999135] Hardware name: Kontron KBox A-230-LS (DT)
[    2.004199] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.011185] pc : kfree+0x5c/0x3c0
[    2.014516] lr : devm_thermal_of_zone_release+0x38/0x60
[    2.019761] sp : ffff80000a22bad0
[    2.023081] x29: ffff80000a22bad0 x28: 0000000000000000 x27: ffff800009960464
[    2.030245] x26: ffff800009a16960 x25: 0000000000000006 x24: ffff800009f09a40
[    2.037407] x23: ffff800009ab9008 x22: ffff800008d0eea8 x21: 01adadadadadad80
[    2.044569] x20: 6b6b6b6b6b6b6b6b x19: ffff00200232b800 x18: 00000000fffffffb
[    2.051731] x17: ffff800008d0eea0 x16: ffff800008d07d44 x15: ffff800008d0d154
[    2.056647] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    2.058893] x14: ffff800008d0cddc x13: ffff8000088d1c2c x12: ffff8000088d5034
[    2.072597] x11: ffff8000088d46d4 x10: 0000000000000000 x9 : ffff800008d0eea8
[    2.079759] x8 : ffff002000b1a158 x7 : bbbbbbbbbbbbbbbb x6 : ffff80000a0f53b8
[    2.086921] x5 : ffff80000a22b960 x4 : 0000000000000000 x3 : 0000000000000000
[    2.094082] x2 : fffffc0000000000 x1 : ffff002000838040 x0 : 01adb1adadadad80
[    2.101244] Call trace:
[    2.103692]  kfree+0x5c/0x3c0
[    2.106666]  devm_thermal_of_zone_release+0x38/0x60
[    2.111561]  release_nodes+0x64/0xd0
[    2.115146]  devres_release_all+0xbc/0x350
[    2.119253]  device_unbind_cleanup+0x20/0x70
[    2.123536]  really_probe+0x1a0/0x2e4
[    2.127208]  __driver_probe_device+0x80/0xec
[    2.131490]  driver_probe_device+0x44/0x130
[    2.135685]  __driver_attach+0x104/0x1b4
[    2.139619]  bus_for_each_dev+0x7c/0xe0
[    2.143465]  driver_attach+0x30/0x40
[    2.147048]  bus_add_driver+0x160/0x210
[    2.150894]  driver_register+0x84/0x140
[    2.154741]  __platform_driver_register+0x34/0x40
[    2.159461]  qoriq_tmu_init+0x28/0x34
[    2.163133]  do_one_initcall+0x50/0x250
[    2.166979]  kernel_init_freeable+0x278/0x31c
[    2.171349]  kernel_init+0x30/0x140
[    2.174847]  ret_from_fork+0x10/0x20
[    2.178433] Code: b25657e2 d34cfc00 d37ae400 8b020015 (f94006a1)
[    2.184546] ---[ end trace 0000000000000000 ]---

Store the allocated resource pointers before the thermal zone is free
and use them to release the resource after unregistering the thermal
zone.

Fixes: 3bd52ac87347 ("thermal/of: Rework the thermal device tree initialization")
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Michael Walle <michael@walle.cc>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220809085629.509116-4-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_of.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 072e054..c5cbe25 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1330,11 +1330,15 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
  */
 void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
+	struct thermal_trip *trips = tz->trips;
+	struct thermal_zone_params *tzp = tz->tzp;
+	struct thermal_zone_device_ops *ops = tz->ops;
+
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
-	kfree(tz->trips);
-	kfree(tz->tzp);
-	kfree(tz->ops);
+	kfree(trips);
+	kfree(tzp);
+	kfree(ops);
 }
 EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
 
