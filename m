Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353BA648525
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiLIP0t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiLIP0h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C525C8F0BF
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:32 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=464kAP3bXu9jbNWQOT6aJi5FVrJbCMlzBfw/A21xNYM=;
        b=Sm2JSX+zKnQxlv3unIF67kZZL5MKhEsYKgK0fTrCKtHjiHd7R7B/RSfxyXo+0OitsJ31LT
        /5CGvTTA635LoNyMAyN+NeV9lqXYd8T9wNRr2+IICiHB5qttkkP93d2jjEr89TmphXKMky
        3yOuJ8WGpC7rJ15vb8Q1/N5YNdddwbCJh5X25uO/oJyfWKvXQtoSPhAEg6ByeV/5QEk7Xs
        yTIp/dpEZNKE1qOSuzVIek+q9IaaQqozK/y7dfDKKGYBDFWniVB8zhfZaXt5JhV1OyeYDn
        K3QUmReEOHkfDATnwTXrA1Un2o9DlToDk53++dth1B25/5hRqPELsssESHvagQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=464kAP3bXu9jbNWQOT6aJi5FVrJbCMlzBfw/A21xNYM=;
        b=K6ucULKHJ93eBFDrbFMFOCygREYZg5ENsCiPA1Ls/wrPfCBUigzOUY6NA8aLVnm1BE4W0o
        nS/ofYDrvVbXQPAw==
From:   "thermal-bot for Alexander Stein" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/imx8mm: Add hwmon support
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20220726122331.323093-1-alexander.stein@ew.tq-group.com>
References: <20220726122331.323093-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Message-ID: <167059958815.4906.3651022751204904731.tip-bot2@tip-bot2>
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

Commit-ID:     7dccad3e0d79edc7a5b3947dc6d63ec683114c51
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//7dccad3e0d79edc7a5b3947dc6d63ec683114c51
Author:        Alexander Stein <alexander.stein@ew.tq-group.com>
AuthorDate:    Tue, 26 Jul 2022 14:23:31 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/imx8mm: Add hwmon support

Expose thermal sensors as HWMON devices.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://lore.kernel.org/r/20220726122331.323093-1-alexander.stein@ew.tq-group.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/imx8mm_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e709c03..d247b48 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -18,6 +18,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define TER			0x0	/* TMU enable */
 #define TPS			0x4
@@ -342,6 +343,9 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 			goto disable_clk;
 		}
 		tmu->sensors[i].hw_id = i;
+
+		if (devm_thermal_add_hwmon_sysfs(tmu->sensors[i].tzd))
+			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
 	}
 
 	platform_set_drvdata(pdev, tmu);
