Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D358435E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiG1PmG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiG1PmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:42:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32A675B7
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:42:03 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:42:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFdzxsZWRAESjEDM923t6kSGMLwG2xo1Fkn7zUaRY5o=;
        b=hypiUcHcBrYrhw7Yo0SCbFyIHXmrdsW8xSXQ2ji0sL6/ZKv0Y9VyoF045BeDzQIublvJ0N
        iXXYGMS8v/prPMppZbvq+kb2awZL/AE6UnmBdytd+FKKOsjM41cYqxTzqR7CuiWjg4vZaT
        0a9Ebb8uxrC9xfzLVaQ7CEWuMcdWCb7qJeihv250teztgtSRDNpJg5WEaWAaRWXw52p0Ch
        bDj7i2aKVijhxRofH3A96rbdsi3U7Nc4U/aM3jrCCSOO5aoKhgaxzx42sR4y1VYlU+nG/9
        Z1mM0UwESHZ+avMfT6RVLNrCmGuLTAhiPlqjQYf5vUvpktuHtkiy0pQlf3gQLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFdzxsZWRAESjEDM923t6kSGMLwG2xo1Fkn7zUaRY5o=;
        b=oKlRZGoOr206h8av+CJqt2EyHtu2Nx7aVJKRtqoPgHVAaPYtn5JpBxWmOTMqeojhJnY6Ry
        SX3yJeYK2YaDN8CQ==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] drivers/thermal/devfreq_cooling: Extend the
 devfreq_cooling_device with ops
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220613124327.30766-5-lukasz.luba@arm.com>
References: <20220613124327.30766-5-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <165902292122.15455.14722779744580534059.tip-bot2@tip-bot2>
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

Commit-ID:     829f416643f9738b0fda9e3f1bf8712113f61a23
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//829f416643f9738b0fda9e3f1bf8712113f61a23
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Mon, 13 Jun 2022 13:43:27 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:43 +02:00

drivers/thermal/devfreq_cooling: Extend the devfreq_cooling_device with ops

Remove unneeded global variable devfreq_cooling_ops which is used only
as a copy pattern. Instead, extend the struct devfreq_cooling_device with
the needed ops structure. This also simplifies the allocation/free code
during the setup/cleanup.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20220613124327.30766-5-lukasz.luba@arm.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 8c76f96..67b618b 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -28,6 +28,7 @@
  * struct devfreq_cooling_device - Devfreq cooling device
  *		devfreq_cooling_device registered.
  * @cdev:	Pointer to associated thermal cooling device.
+ * @cooling_ops: devfreq callbacks to thermal cooling device ops
  * @devfreq:	Pointer to associated devfreq device.
  * @cooling_state:	Current cooling state.
  * @freq_table:	Pointer to a table with the frequencies sorted in descending
@@ -48,6 +49,7 @@
  */
 struct devfreq_cooling_device {
 	struct thermal_cooling_device *cdev;
+	struct thermal_cooling_device_ops cooling_ops;
 	struct devfreq *devfreq;
 	unsigned long cooling_state;
 	u32 *freq_table;
@@ -290,12 +292,6 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-static struct thermal_cooling_device_ops devfreq_cooling_ops = {
-	.get_max_state = devfreq_cooling_get_max_state,
-	.get_cur_state = devfreq_cooling_get_cur_state,
-	.set_cur_state = devfreq_cooling_set_cur_state,
-};
-
 /**
  * devfreq_cooling_gen_tables() - Generate frequency table.
  * @dfc:	Pointer to devfreq cooling device.
@@ -363,18 +359,18 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	char *name;
 	int err, num_opps;
 
-	ops = kmemdup(&devfreq_cooling_ops, sizeof(*ops), GFP_KERNEL);
-	if (!ops)
-		return ERR_PTR(-ENOMEM);
 
 	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
-	if (!dfc) {
-		err = -ENOMEM;
-		goto free_ops;
-	}
+	if (!dfc)
+		return ERR_PTR(-ENOMEM);
 
 	dfc->devfreq = df;
 
+	ops = &dfc->cooling_ops;
+	ops->get_max_state = devfreq_cooling_get_max_state;
+	ops->get_cur_state = devfreq_cooling_get_cur_state;
+	ops->set_cur_state = devfreq_cooling_set_cur_state;
+
 	em = em_pd_get(dev);
 	if (em && !em_is_artificial(em)) {
 		dfc->em_pd = em;
@@ -437,8 +433,6 @@ free_table:
 	kfree(dfc->freq_table);
 free_dfc:
 	kfree(dfc);
-free_ops:
-	kfree(ops);
 
 	return ERR_PTR(err);
 }
@@ -520,13 +514,11 @@ EXPORT_SYMBOL_GPL(devfreq_cooling_em_register);
 void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	struct devfreq_cooling_device *dfc;
-	const struct thermal_cooling_device_ops *ops;
 	struct device *dev;
 
 	if (IS_ERR_OR_NULL(cdev))
 		return;
 
-	ops = cdev->ops;
 	dfc = cdev->devdata;
 	dev = dfc->devfreq->dev.parent;
 
@@ -537,6 +529,5 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	kfree(dfc->freq_table);
 	kfree(dfc);
-	kfree(ops);
 }
 EXPORT_SYMBOL_GPL(devfreq_cooling_unregister);
