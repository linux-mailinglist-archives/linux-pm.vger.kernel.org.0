Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79D03AE669
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFUJtX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43346 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFUJtG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:06 -0400
Date:   Mon, 21 Jun 2021 09:46:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+9pNou686dyE/eOVRvPSAsL0lqsoNiJQJCxLfNh15k=;
        b=PittTHTZwTPeTfVlLuoOs6RjRc3TOCqAED2GcTFgroQct9iXv2q5x4U83XN1vQgtSIKxZq
        H2aVzLWAX2vvvTYMcJr+V/eohb4fJCLFMz9tT2jC0PdMJMmk0Dcbkc7gG+zpngNpMl7fTn
        Se47MEDxhiW1EF0zPcNi/2F+lbzMHOlnwAA9oFDDXfu2sRVGW4c9tbLxYwKVzvBfeOrEUk
        TVGLK/JrsQaeT0yyb76geY05eIkf3n2kGy3Q5ayWiKMEr+M6uyB0fLZ9FssKCmb+FdudoM
        ZXFz4l8/eCZkHLhYoNSPmQNY5OKJGY66MBgwFNMK5vI5cPBVPK+j8WxJA4gOMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+9pNou686dyE/eOVRvPSAsL0lqsoNiJQJCxLfNh15k=;
        b=PtBq8AGVn8dtnQelAgqoas+j6JuGwImRbxtJq2HUCBZWxRGnwQUrXxXvqjSRJXRG3jaRTW
        kargQMP5jiP7wIAg==
From:   "thermal-bot for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/st: Use
 devm_platform_get_and_ioremap_resource()
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210605120205.2459578-1-yangyingliang@huawei.com>
References: <20210605120205.2459578-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <162426880735.395.10957573054359964451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d7539260cd9ad9c18eaf2a1ff71401abdbdfb5cb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d7539260cd9ad9c18eaf2a1ff71401abdbdfb5cb
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Sat, 05 Jun 2021 20:02:05 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 14 Jun 2021 19:01:15 +02:00

thermal/drivers/st: Use devm_platform_get_and_ioremap_resource()

Use devm_platform_get_and_ioremap_resource() to simplify
code and remove error message which within
devm_platform_get_and_ioremap_resource() already.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210605120205.2459578-1-yangyingliang@huawei.com
---
 drivers/thermal/st/st_thermal_memmap.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index a011445..d68596c 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -119,19 +119,10 @@ static int st_mmap_regmap_init(struct st_thermal_sensor *sensor)
 {
 	struct device *dev = sensor->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *res;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "no memory resources defined\n");
-		return -ENODEV;
-	}
-
-	sensor->mmio_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(sensor->mmio_base)) {
-		dev_err(dev, "failed to remap IO\n");
+	sensor->mmio_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(sensor->mmio_base))
 		return PTR_ERR(sensor->mmio_base);
-	}
 
 	sensor->regmap = devm_regmap_init_mmio(dev, sensor->mmio_base,
 				&st_416mpe_regmap_config);
