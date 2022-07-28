Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87214584353
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiG1Ply (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiG1Plx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B47D68DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:53 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FRQV/ao8/fyUkgL5lk7a9rmHdtd9yKJ8vS9dSOahuDM=;
        b=NQeSemQfxnziXDqj/K9MFoUcXi/I98gMh+tsrORvFWtfeXsTWbceCIcLo3Gs4yJG+BxKmf
        AoTCJsU/+jDdEa40LZ/lJK8cDmpr1aZ83+9hTqjBWSZZoEuJHECewjWXDlvM0q0s7FFBjI
        ymqi0L7Wp8bT8KT6DrrfIJ+lSvkQTvrdtOjVkeXNb/ytDWN/pHKFkZG5xRMh/EnoBvY4JC
        Gu5E08c21f/cP2gFTXaR9Mb8BnH/QzoHvqiBNw5S3qtwdVKrP1oAjZvPAkpGKLflKg712z
        UhCDlXYbJ/IONwbKwSIir3bNwW7ZIPaqzzY+I7fDSxIAkEngiZHrHEJp+glMLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FRQV/ao8/fyUkgL5lk7a9rmHdtd9yKJ8vS9dSOahuDM=;
        b=g/KX8Wai6NpCinyzw60B+JUGUrj6C8wb/HavUp6il2ykc0sQOPFm10hcAtrGAI+fKTImcc
        Ma3eEhe8ELE3GgCQ==
From:   "thermal-bot for Bryan Brattlof" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/k3_j72xx_bandgap: Fix
 ref_table memory leak during probe
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bryan Brattlof <bb@ti.com>, Keerthy <j-keerthy@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220525213617.30002-1-bb@ti.com>
References: <20220525213617.30002-1-bb@ti.com>
MIME-Version: 1.0
Message-ID: <165902291063.15455.8263730895299210540.tip-bot2@tip-bot2>
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

Commit-ID:     99a049aace3257cf7644c3bbf67cb1a655248cc2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//99a049aace3257cf7644c3bbf67cb1a655248cc2
Author:        Bryan Brattlof <bb@ti.com>
AuthorDate:    Wed, 25 May 2022 16:36:17 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:47 +02:00

thermal/drivers/k3_j72xx_bandgap: Fix ref_table memory leak during probe

If an error occurs in the k3_j72xx_bandgap_probe() function the memory
allocated to the 'ref_table' will not be released.

Add a err_free_ref_table step to the error path to free 'ref_table'

Fixes: 72b3fc61c752 ("thermal: k3_j72xx_bandgap: Add the bandgap driver support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Keerthy <j-keerthy@ti.com>
Link: https://lore.kernel.org/r/20220525213617.30002-1-bb@ti.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/k3_j72xx_bandgap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 64e3231..3a35aa3 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -433,7 +433,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 				     GFP_KERNEL);
 	if (!derived_table) {
 		ret = -ENOMEM;
-		goto err_alloc;
+		goto err_free_ref_table;
 	}
 
 	/* Workaround not needed if bit30/bit31 is set even for J721e */
@@ -483,7 +483,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		if (IS_ERR(ti_thermal)) {
 			dev_err(bgp->dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(ti_thermal);
-			goto err_alloc;
+			goto err_free_ref_table;
 		}
 	}
 
@@ -514,6 +514,9 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free_ref_table:
+	kfree(ref_table);
+
 err_alloc:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
