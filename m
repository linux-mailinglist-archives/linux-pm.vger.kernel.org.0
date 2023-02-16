Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894D06991A2
	for <lists+linux-pm@lfdr.de>; Thu, 16 Feb 2023 11:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBPKh2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Feb 2023 05:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjBPKhL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Feb 2023 05:37:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C027354543
        for <linux-pm@vger.kernel.org>; Thu, 16 Feb 2023 02:36:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pSbcs-0003dk-1y; Thu, 16 Feb 2023 11:36:30 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pSbcq-005KnB-0g; Thu, 16 Feb 2023 11:36:29 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pSbco-002WiS-1K; Thu, 16 Feb 2023 11:36:26 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 10/19] PM / devfreq: rockchip-dfi: Add RK3568 support
Date:   Thu, 16 Feb 2023 11:36:15 +0100
Message-Id: <20230216103624.591901-11-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230216103624.591901-1-s.hauer@pengutronix.de>
References: <20230216103624.591901-1-s.hauer@pengutronix.de>
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

This adds RK3568 support to the DFI driver. The driver itself doesn't
need a change, only initialization differs from the currently supported
RK3399.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 24 ++++++++++++++++++++++++
 include/soc/rockchip/rk3568_grf.h    | 12 ++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 include/soc/rockchip/rk3568_grf.h

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 035984d3c7b01..78cb594bd2a81 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -23,6 +23,7 @@
 
 #include <soc/rockchip/rockchip_grf.h>
 #include <soc/rockchip/rk3399_grf.h>
+#include <soc/rockchip/rk3568_grf.h>
 
 #define DMC_MAX_CHANNELS	2
 
@@ -209,6 +210,24 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 	return 0;
 };
 
+static int rk3568_dfi_init(struct rockchip_dfi *dfi)
+{
+	struct regmap *regmap_pmu = dfi->regmap_pmu;
+	u32 reg2, reg3;
+
+	regmap_read(regmap_pmu, RK3568_PMUGRF_OS_REG2, &reg2);
+	regmap_read(regmap_pmu, RK3568_PMUGRF_OS_REG3, &reg3);
+
+	dfi->ddr_type = FIELD_GET(RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO, reg2);
+
+	if (FIELD_GET(RK3568_PMUGRF_OS_REG3_SYSREG_VERSION, reg3) >= 0x3)
+		dfi->ddr_type |= FIELD_GET(RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3, reg3) << 3;
+
+	dfi->channel_mask = 1;
+
+	return 0;
+};
+
 struct rockchip_dfi_devtype_data {
 	int (*init)(struct rockchip_dfi *dfi);
 };
@@ -217,8 +236,13 @@ static struct rockchip_dfi_devtype_data rk3399_devtype_data = {
 	.init = rk3399_dfi_init,
 };
 
+static struct rockchip_dfi_devtype_data rk3568_devtype_data = {
+	.init = rk3568_dfi_init,
+};
+
 static const struct of_device_id rockchip_dfi_id_match[] = {
 	{ .compatible = "rockchip,rk3399-dfi", .data = &rk3399_devtype_data },
+	{ .compatible = "rockchip,rk3568-dfi", .data = &rk3568_devtype_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_dfi_id_match);
diff --git a/include/soc/rockchip/rk3568_grf.h b/include/soc/rockchip/rk3568_grf.h
new file mode 100644
index 0000000000000..575584e9d8834
--- /dev/null
+++ b/include/soc/rockchip/rk3568_grf.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __SOC_RK3568_GRF_H
+#define __SOC_RK3568_GRF_H
+
+#define RK3568_PMUGRF_OS_REG2		0x208
+#define RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO		GENMASK(15, 13)
+
+#define RK3568_PMUGRF_OS_REG3		0x20c
+#define RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13, 12)
+#define RK3568_PMUGRF_OS_REG3_SYSREG_VERSION		GENMASK(31, 28)
+
+#endif /* __SOC_RK3568_GRF_H */
-- 
2.30.2

