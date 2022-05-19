Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4917B52D2C7
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiESMoT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiESMoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E93BA98C
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:16 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pVJqs8upnbXXkCV59v8imVkt+tD39Y0RsI4kQWHhkb4=;
        b=mxdvAEP7lYYryBzvztmaFD+8zCdlu3zwjWIriV45wR37fcW9PxL9dOmR/JzlfmGG0L2tGL
        Kof4OVhxg66u10G4Sww6s/01HPHMI7+sSthBmXnsjOM+Fh5SquEXeTyYX4e4EAej9RpSSy
        m/p2YrOGbZTQoyuVLTfa26/dNTbouyEgGFpiO9ZKGR969c6HmcF9X6DN+wzf+RC4qlrM9e
        CipWd5dRzxFxvO3X2OVM/amWVnyqvUAJqYjtUTxgxFlI+Ms++okRG2CS2L34eUONt9v3ed
        XDzC/Ya0Ri2d/vwtxmkNlyOKP9rzaICC2AwPR0WMG+qx+R30M5cz3ERHTuedNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pVJqs8upnbXXkCV59v8imVkt+tD39Y0RsI4kQWHhkb4=;
        b=xdKJ+HXEuMMtWYg9rfZZ5JiOxrJYi3Du989wJa4Z5htQ2wbD4E6XRUX6hNb/adBF7kgZX7
        Lp1Cy29VRcOSb3DQ==
From:   "thermal-bot for Zheng Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/broadcom: Fix potential NULL
 dereference in sr_thermal_probe
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220425092929.90412-1-zhengyongjun3@huawei.com>
References: <20220425092929.90412-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Message-ID: <165296425371.4207.10296133140962930839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e20d136ec7d6f309989c447638365840d3424c8e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e20d136ec7d6f309989c447638365840d3424c8e
Author:        Zheng Yongjun <zhengyongjun3@huawei.com>
AuthorDate:    Mon, 25 Apr 2022 09:29:29 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

thermal/drivers/broadcom: Fix potential NULL dereference in sr_thermal_probe

platform_get_resource() may return NULL, add proper check to
avoid potential NULL dereferencing.

Fixes: 250e211057c72 ("thermal: broadcom: Add Stingray thermal driver")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Link: https://lore.kernel.org/r/20220425092929.90412-1-zhengyongjun3@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/broadcom/sr-thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
index 475ce29..85ab9ed 100644
--- a/drivers/thermal/broadcom/sr-thermal.c
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -60,6 +60,9 @@ static int sr_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOENT;
+
 	sr_thermal->regs = (void __iomem *)devm_memremap(&pdev->dev, res->start,
 							 resource_size(res),
 							 MEMREMAP_WB);
