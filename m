Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D9E33F09A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCQMjr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhCQMjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:15 -0400
Date:   Wed, 17 Mar 2021 12:39:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oPnFdNbHEsEq/M2YuF7OM/IzuBggAFxdXSyi0X7DA/Y=;
        b=I2ibSZrB0M9wFfS0/TGSrv3+ObI8aG3fQzufJ1Zp8uXH/M3NphcnNlu4a9aHItAC135HmR
        6CGe9gOb5cM+kBs38ypd1kYuAErPBPEc6Wwr8D8bxVZYn6K55ys6bupEfEwES2zTGEewxi
        eLCC5OXsWtPKf/8KWtg5tgPZkP98PV1Y3yl3M50Uf2ld+IaZ/wCJ5hm+NQseG4DQAL6c0x
        c//Ir470W50OaBqNpXKztWRMABjnWyv/zAxMwjlyeCGY7CibWXpcM6ZqT+aTaAGDorPvq7
        2zcNcI+1WKEI88ojrDI33q4mXmHMWhaXD09XUWXAZD2RHnh+W4o7cEgV1ut7Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oPnFdNbHEsEq/M2YuF7OM/IzuBggAFxdXSyi0X7DA/Y=;
        b=YzIntaTHd84MaMKEGOzpfi4S6ytyC4Py2gpB725VnPb0aVSjLBSwO+hgvqsB7xjvW4Mb/Q
        oDRR7lpAYQRX3hBw==
From:   "thermal-bot for Tang Bin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: amlogic: Omit superfluous error
 message in amlogic_thermal_probe()
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210222061105.6008-1-tangbin@cmss.chinamobile.com>
References: <20210222061105.6008-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Message-ID: <161598475428.398.3612109304676778220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e042e95bcab34b2265b0aaeb497030ea13c6c251
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e042e95bcab34b2265b0aaeb497030ea13c6c251
Author:        Tang Bin <tangbin@cmss.chinamobile.com>
AuthorDate:    Mon, 22 Feb 2021 14:11:05 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 10 Mar 2021 12:52:55 +01:00

thermal: amlogic: Omit superfluous error message in amlogic_thermal_probe()

The function devm_platform_ioremap_resource has already contains error
message, so remove the redundant dev_err here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210222061105.6008-1-tangbin@cmss.chinamobile.com
---
 drivers/thermal/amlogic_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index dffe3ba..e61b91d 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -254,10 +254,8 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pdata);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
-		dev_err(dev, "failed to get io address\n");
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	pdata->regmap = devm_regmap_init_mmio(dev, base,
 					      pdata->data->regmap_config);
