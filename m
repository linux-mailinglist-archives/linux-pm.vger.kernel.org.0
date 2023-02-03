Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3F4689912
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 13:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjBCMub (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 07:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjBCMua (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 07:50:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7209AFFF
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 04:50:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWE-0000bM-5M; Fri, 03 Feb 2023 13:50:18 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWB-002Opm-7r; Fri, 03 Feb 2023 13:50:16 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvW9-000ZkG-RA; Fri, 03 Feb 2023 13:50:13 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pegutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 01/18] PM / devfreq: rockchip-dfi: Embed desc into private data struct
Date:   Fri,  3 Feb 2023 13:49:55 +0100
Message-Id: <20230203125012.3804008-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230203125012.3804008-1-s.hauer@pengutronix.de>
References: <20230203125012.3804008-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

No need for an extra allocation, just embed the struct
devfreq_event_desc into the private data struct.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 39ac069cabc75..570f1b36c3153 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -49,7 +49,7 @@ struct dmc_usage {
  */
 struct rockchip_dfi {
 	struct devfreq_event_dev *edev;
-	struct devfreq_event_desc *desc;
+	struct devfreq_event_desc desc;
 	struct dmc_usage ch_usage[RK3399_DMC_NUM_CH];
 	struct device *dev;
 	void __iomem *regs;
@@ -203,14 +203,10 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	}
 	data->dev = dev;
 
-	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
-	if (!desc)
-		return -ENOMEM;
-
+	desc = &data->desc;
 	desc->ops = &rockchip_dfi_ops;
 	desc->driver_data = data;
 	desc->name = np->name;
-	data->desc = desc;
 
 	data->edev = devm_devfreq_event_add_edev(&pdev->dev, desc);
 	if (IS_ERR(data->edev)) {
-- 
2.30.2

