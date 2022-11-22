Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8C63324B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Nov 2022 02:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiKVBmq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 20:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiKVBmo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 20:42:44 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F0811457;
        Mon, 21 Nov 2022 17:42:42 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NGRpS6tcHz8RV6L;
        Tue, 22 Nov 2022 09:42:40 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NGRpP3HKwz4y0vV;
        Tue, 22 Nov 2022 09:42:37 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AM1gR7S031422;
        Tue, 22 Nov 2022 09:42:27 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 22 Nov 2022 09:42:28 +0800 (CST)
Date:   Tue, 22 Nov 2022 09:42:28 +0800 (CST)
X-Zmail-TransId: 2afa637c29044ce033db
X-Mailer: Zmail v1.0
Message-ID: <202211220942288196359@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <cw00.choi@samsung.com>
Cc:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <krzysztof.kozlowski@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chi.minghao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBQTSAvIGRldmZyZXE6IGV2ZW50OiB1c2UKCiBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AM1gR7S031422
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 637C2910.000 by FangMail milter!
X-FangMail-Envelope: 1669081360/4NGRpS6tcHz8RV6L/637C2910.000/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637C2910.000/4NGRpS6tcHz8RV6L
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/devfreq/event/exynos-nocp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index ccc531ee6938..c1cc23bcb995 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -214,8 +214,7 @@ static int exynos_nocp_parse_dt(struct platform_device *pdev,
 		nocp->clk = NULL;

 	/* Maps the memory mapped IO to control nocp register */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-- 
2.25.1
