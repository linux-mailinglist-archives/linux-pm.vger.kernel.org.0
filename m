Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6CD36531D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 09:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhDTHVZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 03:21:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhDTHVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 03:21:24 -0400
Date:   Tue, 20 Apr 2021 07:20:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618903252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2uKb1MpYIMa0U3+pn6rToHXX0LxC5/yXqNXyA1WDfQ=;
        b=gdqsdBw+2k1yNVpW7PVI25QohGSyoAFqHywBhYLBW0kzJ3aSuaHKfCQXXo2X/RNewSIlEp
        uUCFn/1YxKJW3AUnC4tuuJIDjVdQZ7QYK3GpWwqQte6OKSbGC//MNWTRZpngXFj47RtDHX
        vMNH4lKZOxUPCeROk2Zr1nnhaR+h1hL+U3LtLAK7/epNrE6Z0p1Fa9zNHJNhe+7dJK4Ek0
        Ds9lbas2DGdGuTAqKQuhWw6zO5cazHTzPMaE5PBuukiMlSu9/Lk9KjBj6SR2LndOvvj0pS
        Itb34WYyZm34KrgVFAzGciOrDn31byNZu2XL87BXwQ3f6fiH/75xNQ7CVE+Gvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618903252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2uKb1MpYIMa0U3+pn6rToHXX0LxC5/yXqNXyA1WDfQ=;
        b=ioV3HeYJoxI5YAWHr/wP1od/jrqXInKwkfSJxWNFSUAcdVP+sjjsyonH45LpcMjmi3bxoh
        plVkCqipUnU4SFAA==
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
Message-ID: <161890325164.29796.18016540711647128822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d1ab7c3a33d27e7b63fd6207d88852561072ae36
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d1ab7c3a33d27e7b63fd6207d88852561072ae36
Author:        Ruiqi Gong <gongruiqi1@huawei.com>
AuthorDate:    Thu, 08 Apr 2021 06:03:29 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Apr 2021 08:58:47 +02:00

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
 
