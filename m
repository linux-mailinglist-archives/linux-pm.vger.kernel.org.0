Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BBC3608C6
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhDOMEX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhDOMEX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F97C061574
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 05:04:00 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:03:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/k+R2cLU3CaoOh0dTSm4LTGFEXxYWR4oBhAeJZPoAQ=;
        b=3vdW67P083SGEkOHBmHavVCvBX7v28euVODQiC4HjVtlhbs/WbdtX1Agb/zRC87bmqw7nv
        /WgrYQdKTRPnhVUx+PK1hKgVW9/0Cn2TXdMa9ofs/Wx1f0dPtQmo5kEKdU2IVvhunlGe04
        du8FeHTuzJdqZQoy04bnMaXg4KrZOaP3YPUfvNNFeIQlw/zRfQ6YnaS4TXcCDYYokcKs4y
        5Zx+RsO7gkkhrJ/ueijoAgSQNHmv+iWV5t8BVt54RULXYSRau+krS7+k7KZYzqHB/ZwYs7
        hetDRjuNVktf1i/IDemmItVnMsanerAXXH6QipsmCqrARHPAM22sMm+lCXhHxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/k+R2cLU3CaoOh0dTSm4LTGFEXxYWR4oBhAeJZPoAQ=;
        b=IVgh34+/UjiUO97WE7exO5PW/r0jWA9nLQgqxxZM9IZGcT1YShO95nDV6vRo0O+nJ7IikD
        ysSieWMMeOCFi4Cg==
From:   "thermal-bot for Ruiqi Gong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/bcm2835: Remove redundant
 dev_err call in bcm2835_thermal_probe()
Cc:     Hulk Robot <hulkci@huawei.com>, Ruiqi Gong <gongruiqi1@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210408100329.7585-1-gongruiqi1@huawei.com>
References: <20210408100329.7585-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Message-ID: <161848823524.29796.2023940646427405695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     70955f08376c9812594730fb397dd6c5439c24fd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//70955f08376c9812594730fb397dd6c5439c24fd
Author:        Ruiqi Gong <gongruiqi1@huawei.com>
AuthorDate:    Thu, 08 Apr 2021 06:03:29 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:43 +02:00

thermal/drivers/bcm2835: Remove redundant dev_err call in bcm2835_thermal_probe()

There is a error message within devm_ioremap_resource already, so
remove the dev_err call to avoid redundant error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210408100329.7585-1-gongruiqi1@huawei.com
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 3199977..c8e4344 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -184,7 +184,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	data->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(data->regs)) {
 		err = PTR_ERR(data->regs);
-		dev_err(&pdev->dev, "Could not get registers: %d\n", err);
 		return err;
 	}
 
