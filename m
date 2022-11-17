Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D28462D418
	for <lists+linux-pm@lfdr.de>; Thu, 17 Nov 2022 08:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbiKQHaN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Nov 2022 02:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiKQHaN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2022 02:30:13 -0500
X-Greylist: delayed 4816 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 23:30:12 PST
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA0FBCB8
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 23:30:12 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCWll1QzZz8R041
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 15:30:11 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NCWlh5S5Tz4y0vM;
        Thu, 17 Nov 2022 15:30:08 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH7U1AM099425;
        Thu, 17 Nov 2022 15:30:01 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 15:30:03 +0800 (CST)
Date:   Thu, 17 Nov 2022 15:30:03 +0800 (CST)
X-Zmail-TransId: 2af96375e2fbffffffff94654c76
X-Mailer: Zmail v1.0
Message-ID: <202211171530030836446@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <sre@kernel.org>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBvd2VyOiBzdXBwbHk6IGNvcmU6IFVzZSBkZXZpY2VfbWF0Y2hfb2Zfbm9kZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH7U1AM099425
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6375E303.000 by FangMail milter!
X-FangMail-Envelope: 1668670211/4NCWll1QzZz8R041/6375E303.000/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6375E303.000/4NCWll1QzZz8R041
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with device_match_of_node().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 9035e349bf53..46d0cb0c5026 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -203,7 +203,7 @@ static int  __power_supply_find_supply_from_node(struct device *dev,
 	struct power_supply *epsy = dev_get_drvdata(dev);

 	/* returning non-zero breaks out of class_for_each_device loop */
-	if (epsy->of_node == np)
+	if (device_match_of_node(epsy, np))
 		return 1;

 	return 0;
-- 
2.25.1
