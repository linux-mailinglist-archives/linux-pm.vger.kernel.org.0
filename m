Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4DB36531F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 09:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhDTHV3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 03:21:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhDTHVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 03:21:24 -0400
Date:   Tue, 20 Apr 2021 07:20:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618903252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJbS32oBSAsT2KJqAxvUHf6T8PNIMf5MpjTqmuKm6QU=;
        b=D+jmXVfPjSYJ1YbWCGU/5M0ip24cwz+pNA3DVEUMRkcMlzXVBAIXx4hXuJnDL7TEnEub8a
        PqVrm8LH4Wgp0JLVK5C7cB4TCg48FSvtSEzDXmJGZXJ+P24CMta6deKVZGAgdyoc4Y2V8D
        izZwiYiyDm5S7kU0BZFtJya0pTFeyq1ld4Nu/uK4irYdMWRwIdyF6gT1GHWH6hcO2K6eO2
        81ddxrk+b43w2g/MtWWGYZRj9CIaZf03rFF//5mkhzj4taD1GlCFWYrOGJ08mVu7ikXnhz
        Rav+YKEAeG1316pv9yaCT83f0OxEH4aSrByDNoZeJCn77/rpO3N6dRmXtinYtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618903252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJbS32oBSAsT2KJqAxvUHf6T8PNIMf5MpjTqmuKm6QU=;
        b=GnE27GYOPiTAF5EMP/MxobOh6tRxPzMBbcXUgPdpDrLGB7KgnNLloWAsNf+K88MPIkpP7e
        eWpst7NQK4gfkZDw==
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
Message-ID: <161890325221.29796.9260467038094585375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8cd7ab2a1a393f37f2e2f4b3ff595d98c245b854
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8cd7ab2a1a393f37f2e2f4b3ff595d98c245b854
Author:        Ruiqi Gong <gongruiqi1@huawei.com>
AuthorDate:    Thu, 08 Apr 2021 06:01:44 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Apr 2021 08:58:47 +02:00

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
