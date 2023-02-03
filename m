Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73910689914
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 13:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjBCMu2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 07:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjBCMu0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 07:50:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6055F9AFC3
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 04:50:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWE-0000bQ-5I; Fri, 03 Feb 2023 13:50:18 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvWB-002Opp-An; Fri, 03 Feb 2023 13:50:16 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pNvW9-000Zky-Uq; Fri, 03 Feb 2023 13:50:13 +0100
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
Subject: [PATCH 05/18] PM / devfreq: rockchip-dfi: dfi store raw values in counter struct
Date:   Fri,  3 Feb 2023 13:49:59 +0100
Message-Id: <20230203125012.3804008-6-s.hauer@pengutronix.de>
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

When adding perf support to the DFI driver the perf part will
need the raw counter values, so move the fixed * 4 factor to
rockchip_dfi_get_event().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index f317d3d063e9c..383fe8a17a512 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -97,7 +97,7 @@ static int rockchip_dfi_get_busier_ch(struct devfreq_event_dev *edev)
 	/* Find out which channel is busier */
 	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
 		dfi->ch_usage[i].access = readl_relaxed(dfi_regs +
-				DDRMON_CH0_DFI_ACCESS_NUM + i * 20) * 4;
+				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
 		dfi->ch_usage[i].total = readl_relaxed(dfi_regs +
 				DDRMON_CH0_COUNT_NUM + i * 20);
 		tmp = dfi->ch_usage[i].access;
@@ -149,7 +149,7 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
 
 	busier_ch = rockchip_dfi_get_busier_ch(edev);
 
-	edata->load_count = dfi->ch_usage[busier_ch].access;
+	edata->load_count = dfi->ch_usage[busier_ch].access * 4;
 	edata->total_count = dfi->ch_usage[busier_ch].total;
 
 	return 0;
-- 
2.30.2

