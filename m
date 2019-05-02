Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC112178
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 19:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfEBR6Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 13:58:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41834 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfEBR6X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 13:58:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 8C7A428422A
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH v5 1/6] devfreq: rockchip-dfi: Move GRF definitions to a common place.
Date:   Thu,  2 May 2019 13:58:15 -0400
Message-Id: <20190502175820.25382-2-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502175820.25382-1-gael.portay@collabora.com>
References: <20190502175820.25382-1-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Some rk3399 GRF (Generic Register Files) definitions can be used for
different drivers. Move these definitions to a common include so we
don't need to duplicate these definitions.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---

Changes in v5: None

Changes in v4:
- [PATCH v3 1/5] Add Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>.

Changes in v3:
- [PATCH v2 1/5] Add Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>.

Changes in v2:
- [PATCH 1/8] Really add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>.

Changes in v1:
- [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
- [RFC 1/10] s/Generic/General/ (Robin Murphy)
- [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
- [RFC 7/10] Removed from the series. I did not found a use case where this matters.

 drivers/devfreq/event/rockchip-dfi.c | 23 +++++++----------------
 include/soc/rockchip/rk3399_grf.h    | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 16 deletions(-)
 create mode 100644 include/soc/rockchip/rk3399_grf.h

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 22b113363ffc..2fbbcbeb644f 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -26,6 +26,8 @@
 #include <linux/list.h>
 #include <linux/of.h>
 
+#include <soc/rockchip/rk3399_grf.h>
+
 #define RK3399_DMC_NUM_CH	2
 
 /* DDRMON_CTRL */
@@ -43,18 +45,6 @@
 #define DDRMON_CH1_COUNT_NUM		0x3c
 #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
 
-/* pmu grf */
-#define PMUGRF_OS_REG2	0x308
-#define DDRTYPE_SHIFT	13
-#define DDRTYPE_MASK	7
-
-enum {
-	DDR3 = 3,
-	LPDDR3 = 6,
-	LPDDR4 = 7,
-	UNUSED = 0xFF
-};
-
 struct dmc_usage {
 	u32 access;
 	u32 total;
@@ -83,16 +73,17 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
 	u32 ddr_type;
 
 	/* get ddr type */
-	regmap_read(info->regmap_pmu, PMUGRF_OS_REG2, &val);
-	ddr_type = (val >> DDRTYPE_SHIFT) & DDRTYPE_MASK;
+	regmap_read(info->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
+	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
+		    RK3399_PMUGRF_DDRTYPE_MASK;
 
 	/* clear DDRMON_CTRL setting */
 	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
 
 	/* set ddr type to dfi */
-	if (ddr_type == LPDDR3)
+	if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
 		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
-	else if (ddr_type == LPDDR4)
+	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
 		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
 
 	/* enable count, use software mode */
diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
new file mode 100644
index 000000000000..3eebabcb2812
--- /dev/null
+++ b/include/soc/rockchip/rk3399_grf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Rockchip General Register Files definitions
+ *
+ * Copyright (c) 2018, Collabora Ltd.
+ * Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
+ */
+
+#ifndef __SOC_RK3399_GRF_H
+#define __SOC_RK3399_GRF_H
+
+/* PMU GRF Registers */
+#define RK3399_PMUGRF_OS_REG2		0x308
+#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
+#define RK3399_PMUGRF_DDRTYPE_MASK	7
+#define RK3399_PMUGRF_DDRTYPE_DDR3	3
+#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
+#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
+#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
+
+#endif
-- 
2.21.0

