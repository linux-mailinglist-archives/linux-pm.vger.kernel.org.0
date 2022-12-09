Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25522648573
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiLIP1x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiLIP0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0477F8F711
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:43 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9fJuK9JOfdNzSKi3ZL2CJivZHeONURg+hRiQr1HYle4=;
        b=4THGJTQ5sRVTgEYPa8uikco3NbrzQS3RZyQtYh166lzvECQNcqA9jdjchQpiN1+RQnPvxF
        xMNOItNiCbUb5sIGx483838GyeoWAeWYsi/0StbK4TxrBnCMiyfN1aZ2voUj1E5R5XeMcs
        JI7YnPNmUq7YyspYZaHza6EOvHPqm5EJHb72EyhzCzI6NAaNrHQXzSQuxFWnjrtjffBEMG
        fITf8eRDUi5RRCWe624Zkive/AHeq6vKfix/aBBG65I1oDneALSNgHwvRjw52nh6xvdNP3
        VnOA9csxv1fWiAK8v6EQwhL7E8Qm7++RObi3Csfw733/JnPhSjo8id7g9pqbhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9fJuK9JOfdNzSKi3ZL2CJivZHeONURg+hRiQr1HYle4=;
        b=nDETW9HHZ79L6tJoTlMrsigC0Tmf2/0pCIvdLpC0x3R5vKEaEjjOEaNEVgsEjm2+os1/wn
        1r8FCXaF7ckb4wAA==
From:   "thermal-bot for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: fix error code in
 __thermal_cooling_device_register()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959957.4906.9470621151778548023.tip-bot2@tip-bot2>
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

Commit-ID:     e49a1e1ee078aee21006192076a8d93335e0daa9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e49a1e1ee078aee21006192076a8d93335e0daa9
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Fri, 28 Oct 2022 18:02:34 +03:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Fri, 28 Oct 2022 19:59:51 +02:00

thermal/core: fix error code in __thermal_cooling_device_register()

Return an error pointer if ->get_max_state() fails.  The current code
returns NULL which will cause an oops in the callers.

Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 08de593..e0ca631 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -896,7 +896,8 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 
-	if (cdev->ops->get_max_state(cdev, &cdev->max_state))
+	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
+	if (ret)
 		goto out_kfree_type;
 
 	thermal_cooling_device_setup_sysfs(cdev);
