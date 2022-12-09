Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FCF648527
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiLIP0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiLIP0h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E678F70A
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:32 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIw0gePhQ+zRlzkmXPM5mXiUEwXtOxLnUPpwurNnLsA=;
        b=C+cl/03aKpowcjBGC/iGo3WF6xygyPMarZGEyO5QYoDJ8y9c+UKcvQz0fVzlVobZsHuQcm
        nvb65U2gSX11fYSyGCAexQr8a/naEXbbc4XMxhwAw8Qi8lJsRtzHRBgRr/Ekm5Xsoxr9mw
        djn3bHK2R2prkZX1Tm0WGlLaVf1pnlk9NCnLu9YIUeBfx4vtTNns6HbbanWApCaXXkcXHn
        bMTFqtVSzVAbDXwqp0rdCq3YFOyK5qSS57dtjbhaF7S6uZwBzsTAJXcUcSf6fSzfRKMwSV
        v8cRXRw1JE/YPUVFWl0kKIHH5nEvYlX4+ux99HXd8/34bGQT+j9T5+fWutq2nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIw0gePhQ+zRlzkmXPM5mXiUEwXtOxLnUPpwurNnLsA=;
        b=fp49ft3eM1Edqv1hhtCN7NhXqc97u+n+ymnrZxA+UmoHRAtLHEeb3BShpt+uEEw0ft85UG
        mGQDkwO4Gz/No/CQ==
From:   "thermal-bot for Christian Marangi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/tsens: Rework debugfs
 file structure
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221022125657.22530-4-ansuelsmth@gmail.com>
References: <20221022125657.22530-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <167059958905.4906.3276458499915937604.tip-bot2@tip-bot2>
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

Commit-ID:     c6a32aca175ef04adcfe6344145d1857c917dde4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c6a32aca175ef04adcfe6344145d1857c917dde4
Author:        Christian Marangi <ansuelsmth@gmail.com>
AuthorDate:    Sat, 22 Oct 2022 14:56:57 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/qcom/tsens: Rework debugfs file structure

The current tsens debugfs structure is composed by:
- a tsens dir in debugfs with a version file
- a directory for each tsens istance with sensors file to dump all the
  sensors value.

This works on the assumption that we have the same version for each
istance but this assumption seems fragile and with more than one tsens
istance results in the version file not tracking each of them.

A better approach is to just create a subdirectory for each tsens
istance and put there version and sensors debugfs file.

Using this new implementation results in less code since debugfs entry
are created only on successful tsens probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Link: https://lore.kernel.org/r/20221022125657.22530-4-ansuelsmth@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/qcom/tsens.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 5f8d8f0..b5b136f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -725,21 +725,14 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
 static void tsens_debug_init(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
-	struct dentry *root, *file;
 
-	root = debugfs_lookup("tsens", NULL);
-	if (!root)
+	priv->debug_root = debugfs_lookup("tsens", NULL);
+	if (!priv->debug_root)
 		priv->debug_root = debugfs_create_dir("tsens", NULL);
-	else
-		priv->debug_root = root;
-
-	file = debugfs_lookup("version", priv->debug_root);
-	if (!file)
-		debugfs_create_file("version", 0444, priv->debug_root,
-				    pdev, &dbg_version_fops);
 
 	/* A directory for each instance of the TSENS IP */
 	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
+	debugfs_create_file("version", 0444, priv->debug, pdev, &dbg_version_fops);
 	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
 }
 #else
