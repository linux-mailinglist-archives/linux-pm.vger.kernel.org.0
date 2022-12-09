Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7514D64852F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiLIP06 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiLIP0j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619368F73F
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:34 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ay1QYZd/DWdr5Xhl49laL2dx6B+wC08VW4bdDpGe7Ok=;
        b=4h85Pt3587TrZ7vx9HVcUm9kYxs1SLx3EQ02tSjH4oVSEKTB86j7nvfJa5aTwXV0fuIi8c
        2OMXw9VSypGdYkitlQmQDq8sf8VLHbB27FTs8CIA5Aa2EqfqTkT/Y39byIqWNoCOubi1kO
        0WYgoV8n7u9nw8qiOJo7d9G72Z8YnSZY0V7Ev3Nr6dCAJHRIJJpR7B9Msljopv/RQkocel
        /VRwk6DDhSQa54TtAm1Tx9yxMJaqr8vIcQpCSiIZ0RL6lbpl500ia4HkBaj1ey8dRJWzbG
        xQ4nWPF8x6PMmW0LlVJOnHRXdDx2fNH37W/LGCj2wRmR3Sn4PodNTKjqR7yO0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ay1QYZd/DWdr5Xhl49laL2dx6B+wC08VW4bdDpGe7Ok=;
        b=gUF1AvnvoTVN1IDi8ZwNcHyS4yy087rE/hWM89hXX9vYLofMW1k4KjKDmieUuw4HbT3IFu
        /HtF04aGO1naY6Cw==
From:   "thermal-bot for Ido Schimmel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/of: Fix memory leak on
 thermal_of_zone_register() failure
Cc:     Ido Schimmel <idosch@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221020103658.802457-1-idosch@nvidia.com>
References: <20221020103658.802457-1-idosch@nvidia.com>
MIME-Version: 1.0
Message-ID: <167059959040.4906.12545259120227523646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     35deafe88f5a5f509f87960a9fe726acc1fe9506
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//35deafe88f5a5f509f87960a9fe726acc1fe9506
Author:        Ido Schimmel <idosch@nvidia.com>
AuthorDate:    Thu, 20 Oct 2022 13:36:58 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/of: Fix memory leak on thermal_of_zone_register() failure

The function does not free 'of_ops' upon failure, leading to a memory
leak [1].

Fix by freeing 'of_ops' in the error path.

[1]
unreferenced object 0xffff8ee846198c80 (size 128):
  comm "swapper/0", pid 1, jiffies 4294699704 (age 70.076s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    d0 3f 6e 8c ff ff ff ff 00 00 00 00 00 00 00 00  .?n.............
  backtrace:
    [<00000000d136f562>] __kmalloc_node_track_caller+0x42/0x120
    [<0000000063f31678>] kmemdup+0x1d/0x40
    [<00000000e6d24096>] thermal_of_zone_register+0x49/0x520
    [<000000005e78c755>] devm_thermal_of_zone_register+0x54/0x90
    [<00000000ee6b209e>] pmbus_add_sensor+0x1b4/0x1d0
    [<00000000896105e3>] pmbus_add_sensor_attrs_one+0x123/0x440
    [<0000000049e990a6>] pmbus_add_sensor_attrs+0xfe/0x1d0
    [<00000000466b5440>] pmbus_do_probe+0x66b/0x14e0
    [<0000000084d42285>] i2c_device_probe+0x13b/0x2f0
    [<0000000029e2ae74>] really_probe+0xce/0x2c0
    [<00000000692df15c>] driver_probe_device+0x19/0xd0
    [<00000000547d9cce>] __device_attach_driver+0x6f/0x100
    [<0000000020abd24b>] bus_for_each_drv+0x76/0xc0
    [<00000000665d9563>] __device_attach+0xfc/0x180
    [<000000008ddd4d6a>] bus_probe_device+0x82/0xa0
    [<000000009e61132b>] device_add+0x3fe/0x920

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Link: https://lore.kernel.org/r/20221020103658.802457-1-idosch@nvidia.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index bd87218..ff4d12e 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -493,13 +493,15 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 	if (IS_ERR(np)) {
 		if (PTR_ERR(np) != -ENODEV)
 			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(np);
+		ret = PTR_ERR(np);
+		goto out_kfree_of_ops;
 	}
 
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+		ret = PTR_ERR(trips);
+		goto out_kfree_of_ops;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -543,6 +545,8 @@ out_kfree_tzp:
 	kfree(tzp);
 out_kfree_trips:
 	kfree(trips);
+out_kfree_of_ops:
+	kfree(of_ops);
 
 	return ERR_PTR(ret);
 }
