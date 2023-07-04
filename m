Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECCA746D90
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 11:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjGDJel (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jul 2023 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjGDJeK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2023 05:34:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F0173F
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 02:33:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOw-0006u1-0c; Tue, 04 Jul 2023 11:32:50 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOv-00C0A7-3d; Tue, 04 Jul 2023 11:32:49 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOr-002Tye-BB; Tue, 04 Jul 2023 11:32:45 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 17/26] PM / devfreq: rockchip-dfi: make register stride SoC specific
Date:   Tue,  4 Jul 2023 11:32:33 +0200
Message-Id: <20230704093242.583575-18-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704093242.583575-1-s.hauer@pengutronix.de>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The currently supported RK3399 has a stride of 20 between the channel
specific registers. Upcoming RK3588 has a different stride, so put
the stride into driver data to make it configurable.
While at it convert decimal 20 to hex 0x14 for consistency with RK3588
which has a register stride 0x4000 and we want to write that in hex
as well.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 969b62f071b83..85ec93fd41858 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -112,6 +112,7 @@ struct rockchip_dfi {
 	int active_events;
 	int burst_len;
 	int buswidth[DMC_MAX_CHANNELS];
+	int ddrmon_stride;
 };
 
 static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
@@ -189,13 +190,13 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
 		c->c[i].read_access = readl_relaxed(dfi_regs +
-				DDRMON_CH0_RD_NUM + i * 20);
+				DDRMON_CH0_RD_NUM + i * dfi->ddrmon_stride);
 		c->c[i].write_access = readl_relaxed(dfi_regs +
-				DDRMON_CH0_WR_NUM + i * 20);
+				DDRMON_CH0_WR_NUM + i * dfi->ddrmon_stride);
 		c->c[i].access = readl_relaxed(dfi_regs +
-				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
+				DDRMON_CH0_DFI_ACCESS_NUM + i * dfi->ddrmon_stride);
 		c->c[i].clock_cycles = readl_relaxed(dfi_regs +
-				DDRMON_CH0_COUNT_NUM + i * 20);
+				DDRMON_CH0_COUNT_NUM + i * dfi->ddrmon_stride);
 	}
 }
 
@@ -664,6 +665,8 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 	dfi->buswidth[0] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH0, val) == 0 ? 4 : 2;
 	dfi->buswidth[1] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH1, val) == 0 ? 4 : 2;
 
+	dfi->ddrmon_stride = 0x14;
+
 	return 0;
 };
 
-- 
2.39.2

