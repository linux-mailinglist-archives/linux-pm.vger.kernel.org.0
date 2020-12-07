Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A992D1271
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgLGNrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgLGNrz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 08:47:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED7C0613D1
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 05:47:14 -0800 (PST)
Date:   Mon, 07 Dec 2020 13:47:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607348833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H5GyNcDdrtWIkbkgB5h9SW32h0q18cUEmAfdXCjCuBE=;
        b=kd3rMPq5YZ78lS/9hL2vo4aNSE9kOXh+1UaG3UTlaKTXOdE/gWtrQ0bsTGliP86nIGJka8
        +0oBrqJmU069tYGIaNJyH15YNq54lv377p+geoUdT0Cptpp0vaHkIqVkXSTGMkiPQSYvC/
        kT5wTKomS+x798NjOfPjoOiMnFrDkQsDUY7PPDATEx+/sVJcTyQnf0hP/4L6z7ZgPZO8HI
        m/XfZUBcbImSXpmkiVN/1kTqG38WPQVIE9nNsXsnpUudeGlPBY0oTrXlLvlU/rds/4TzJl
        1IGcTDq1UcrSJUjLCautD3zrAonWcNSKXoS0DY636tGRZgC0ZlICD3jKNQmu6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607348833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H5GyNcDdrtWIkbkgB5h9SW32h0q18cUEmAfdXCjCuBE=;
        b=YC3kqHIAjDFd+yiH6ySZW5Ok0dbGebrcAkqj7gIYdAN81JRBNp+7a6hmn7CAA6iwZOu4y2
        CnVKJsUAro5pePDw==
From:   "thermal-bot for Fabio Estevam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: imx8mm: Disable the clock on probe failure
Cc:     Fabio Estevam <festevam@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201202232448.2692-2-festevam@gmail.com>
References: <20201202232448.2692-2-festevam@gmail.com>
MIME-Version: 1.0
Message-ID: <160734883220.3364.9536508391090819279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e57eb8b5050c9b6d63eea26b194d96744fe4018a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e57eb8b5050c9b6d63eea26b194d96744fe4018a
Author:        Fabio Estevam <festevam@gmail.com>
AuthorDate:    Wed, 02 Dec 2020 20:24:48 -03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 04 Dec 2020 20:46:03 +01:00

thermal: imx8mm: Disable the clock on probe failure

Prior to returning an error in probe, disable the previously
enabled clock.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201202232448.2692-2-festevam@gmail.com
---
 drivers/thermal/imx8mm_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index ce7cb64..7442e01 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -170,7 +170,7 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to register thermal zone sensor[%d]: %d\n",
 				i, ret);
-			return ret;
+			goto disable_clk;
 		}
 		tmu->sensors[i].hw_id = i;
 	}
@@ -185,6 +185,10 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	imx8mm_tmu_enable(tmu, true);
 
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(tmu->clk);
+	return ret;
 }
 
 static int imx8mm_tmu_remove(struct platform_device *pdev)
