Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FA1746D8A
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 11:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjGDJeX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jul 2023 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGDJdw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2023 05:33:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E811F
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 02:33:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOv-0006tr-RY; Tue, 04 Jul 2023 11:32:49 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOt-00C09Z-6L; Tue, 04 Jul 2023 11:32:47 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qGcOr-002TyJ-7N; Tue, 04 Jul 2023 11:32:45 +0200
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
Subject: [PATCH v7 13/26] PM / devfreq: rockchip-dfi: Pass private data struct to internal functions
Date:   Tue,  4 Jul 2023 11:32:29 +0200
Message-Id: <20230704093242.583575-14-s.hauer@pengutronix.de>
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

The internal functions do not need the struct devfreq_event_dev *,
so pass them the struct rockchip_dfi *. This is a preparation for
adding perf support later which doesn't have a struct devfreq_event_dev *.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 0a568c5551699..d39db5de7f19c 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -72,9 +72,8 @@ struct rockchip_dfi {
 	unsigned int channel_mask;
 };
 
-static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
+static void rockchip_dfi_start_hardware_counter(struct rockchip_dfi *dfi)
 {
-	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 	void __iomem *dfi_regs = dfi->regs;
 
 	/* clear DDRMON_CTRL setting */
@@ -102,18 +101,16 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
 		       dfi_regs + DDRMON_CTRL);
 }
 
-static void rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev *edev)
+static void rockchip_dfi_stop_hardware_counter(struct rockchip_dfi *dfi)
 {
-	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 	void __iomem *dfi_regs = dfi->regs;
 
 	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
 		       dfi_regs + DDRMON_CTRL);
 }
 
-static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev, struct dmc_count *count)
+static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_count *count)
 {
-	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 	u32 i;
 	void __iomem *dfi_regs = dfi->regs;
 
@@ -131,7 +128,7 @@ static int rockchip_dfi_disable(struct devfreq_event_dev *edev)
 {
 	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 
-	rockchip_dfi_stop_hardware_counter(edev);
+	rockchip_dfi_stop_hardware_counter(dfi);
 	clk_disable_unprepare(dfi->clk);
 
 	return 0;
@@ -148,7 +145,7 @@ static int rockchip_dfi_enable(struct devfreq_event_dev *edev)
 		return ret;
 	}
 
-	rockchip_dfi_start_hardware_counter(edev);
+	rockchip_dfi_start_hardware_counter(dfi);
 	return 0;
 }
 
@@ -166,7 +163,7 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
 	u32 access = 0, total = 0;
 	int i;
 
-	rockchip_dfi_read_counters(edev, &count);
+	rockchip_dfi_read_counters(dfi, &count);
 
 	/* We can only report one channel, so find the busiest one */
 	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
-- 
2.39.2

