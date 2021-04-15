Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A61B3608C7
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhDOMEX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhDOMEX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219F4C061760
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 05:04:00 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:03:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Zoi7uAxQI7t3/pg/qB7tJq81RwtXNVqzKpwgjt4zOU=;
        b=fCbdP+VfkSuxENzBXWWQvPTqUgQ0cjaG9gvAVZHMuKnozncTKy+z7ctHt7ZUJjeodk9uKi
        zTRexhLIfBUKRtc9nN5RS6CheXaW5vn57YTH2fx/cJivZlz0IKutlIyG5xQ+W5imWcoq/I
        q2Q4tvU9wpO2UciT75ffKOcdFtGt6KaM6AhhBWj3n72bbhqiY45kt/7CATGYSkhbeNe1Qq
        Bbf2hBbsNK/5fW0+baKciTlYlRsxVc5pDdT4ILsWITAUwTwp7JKQEG0fGH2AYVAgTM/RBe
        a5KVqDmk0zJDx2h0j5HWcoTpUPimE3c5MuKGLci0rIrYUQljAM652S9Op5sTTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Zoi7uAxQI7t3/pg/qB7tJq81RwtXNVqzKpwgjt4zOU=;
        b=UU9IXggu8xUeViSD0uevL9lXwnO5/AEJcaOc04p9d9/SHxt0LX2QcnZljyoyP/rMeWTql1
        7cdkej7tItejKJBg==
From:   "thermal-bot for Ruiqi Gong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/thermal_mmio: Remove
 redundant dev_err call in thermal_mmio_probe()
Cc:     Hulk Robot <hulkci@huawei.com>, Ruiqi Gong <gongruiqi1@huawei.com>,
        Talel Shenhar <talel@amazon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210408100144.7494-1-gongruiqi1@huawei.com>
References: <20210408100144.7494-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Message-ID: <161848823574.29796.18397657370026509312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c8671d70b29d72d590678eee59d5891eee8d9d2e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c8671d70b29d72d590678eee59d5891eee8d9d2e
Author:        Ruiqi Gong <gongruiqi1@huawei.com>
AuthorDate:    Thu, 08 Apr 2021 06:01:44 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:43 +02:00

thermal/drivers/thermal_mmio: Remove redundant dev_err call in thermal_mmio_probe()

There is a error message within devm_ioremap_resource already, so
remove the dev_err call to avoid redundant error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
Acked-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210408100144.7494-1-gongruiqi1@huawei.com
---
 drivers/thermal/thermal_mmio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index d0bdf1e..ded1dd0 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -54,11 +54,8 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 
 	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sensor->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
-	if (IS_ERR(sensor->mmio_base)) {
-		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
-			PTR_ERR(sensor->mmio_base));
+	if (IS_ERR(sensor->mmio_base))
 		return PTR_ERR(sensor->mmio_base);
-	}
 
 	sensor_init_func = device_get_match_data(&pdev->dev);
 	if (sensor_init_func) {
