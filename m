Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945C112164
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 19:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEBR63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 13:58:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41862 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfEBR61 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 13:58:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 13200283428
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
Subject: [PATCH v5 3/6] devfreq: rk3399_dmc: Pass ODT and auto power down parameters to TF-A.
Date:   Thu,  2 May 2019 13:58:17 -0400
Message-Id: <20190502175820.25382-4-gael.portay@collabora.com>
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

Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
on-die termination (ODT) and auto power down parameters from kernel,
this patch adds the functionality to do this. Also, if DDR clock
frequency is lower than the on-die termination (ODT) disable frequency
this driver should disable the DDR ODT.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---

Changes in v5: None

Changes in v4:
- [PATCH v3 3/5] Add Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>.

Changes in v3:
- [PATCH v2 3/5] Add Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>.
		 Remove comments.
		 Move pmu dt parsing after dt-parsing of timings to fix
		  data->odt_dis_freq value.

Changes in v2: None

Changes in v1:
- [RFC 3/10] Add an explanation for platform SIP calls.
- [RFC 3/10] Change if statement for a switch.
- [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.

 drivers/devfreq/rk3399_dmc.c        | 71 ++++++++++++++++++++++++++++-
 include/soc/rockchip/rockchip_sip.h |  1 +
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e795ad2b3f6b..daf19e121c99 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -18,14 +18,17 @@
 #include <linux/devfreq.h>
 #include <linux/devfreq-event.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/rwsem.h>
 #include <linux/suspend.h>
 
+#include <soc/rockchip/rk3399_grf.h>
 #include <soc/rockchip/rockchip_sip.h>
 
 struct dram_timing {
@@ -69,8 +72,11 @@ struct rk3399_dmcfreq {
 	struct mutex lock;
 	struct dram_timing timing;
 	struct regulator *vdd_center;
+	struct regmap *regmap_pmu;
 	unsigned long rate, target_rate;
 	unsigned long volt, target_volt;
+	unsigned int odt_dis_freq;
+	int odt_pd_arg0, odt_pd_arg1;
 };
 
 static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
@@ -80,6 +86,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	struct dev_pm_opp *opp;
 	unsigned long old_clk_rate = dmcfreq->rate;
 	unsigned long target_volt, target_rate;
+	struct arm_smccc_res res;
+	bool odt_enable = false;
 	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
@@ -95,6 +103,19 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 
 	mutex_lock(&dmcfreq->lock);
 
+	if (target_rate >= dmcfreq->odt_dis_freq)
+		odt_enable = true;
+
+	/*
+	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
+	 * timings and to enable or disable the ODT (on-die termination)
+	 * resistors.
+	 */
+	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
+		      dmcfreq->odt_pd_arg1,
+		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
+		      odt_enable, 0, 0, 0, &res);
+
 	/*
 	 * If frequency scaling from low to high, adjust voltage first.
 	 * If frequency scaling from high to low, adjust frequency first.
@@ -294,11 +315,13 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 {
 	struct arm_smccc_res res;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node, *node;
 	struct rk3399_dmcfreq *data;
 	int ret, index, size;
 	uint32_t *timing;
 	struct dev_pm_opp *opp;
+	u32 ddr_type;
+	u32 val;
 
 	data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
 	if (!data)
@@ -354,10 +377,56 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		}
 	}
 
+	node = of_parse_phandle(np, "rockchip,pmu", 0);
+	if (node) {
+		data->regmap_pmu = syscon_node_to_regmap(node);
+		if (IS_ERR(data->regmap_pmu))
+			return PTR_ERR(data->regmap_pmu);
+	}
+
+	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
+	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
+		    RK3399_PMUGRF_DDRTYPE_MASK;
+
+	switch (ddr_type) {
+	case RK3399_PMUGRF_DDRTYPE_DDR3:
+		data->odt_dis_freq = data->timing.ddr3_odt_dis_freq;
+		break;
+	case RK3399_PMUGRF_DDRTYPE_LPDDR3:
+		data->odt_dis_freq = data->timing.lpddr3_odt_dis_freq;
+		break;
+	case RK3399_PMUGRF_DDRTYPE_LPDDR4:
+		data->odt_dis_freq = data->timing.lpddr4_odt_dis_freq;
+		break;
+	default:
+		return -EINVAL;
+	};
+
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
 		      ROCKCHIP_SIP_CONFIG_DRAM_INIT,
 		      0, 0, 0, 0, &res);
 
+	/*
+	 * In TF-A there is a platform SIP call to set the PD (power-down)
+	 * timings and to enable or disable the ODT (on-die termination).
+	 * This call needs three arguments as follows:
+	 *
+	 * arg0:
+	 *     bit[0-7]   : sr_idle
+	 *     bit[8-15]  : sr_mc_gate_idle
+	 *     bit[16-31] : standby idle
+	 * arg1:
+	 *     bit[0-11]  : pd_idle
+	 *     bit[16-27] : srpd_lite_idle
+	 * arg2:
+	 *     bit[0]     : odt enable
+	 */
+	data->odt_pd_arg0 = (data->timing.sr_idle & 0xff) |
+			    ((data->timing.sr_mc_gate_idle & 0xff) << 8) |
+			    ((data->timing.standby_idle & 0xffff) << 16);
+	data->odt_pd_arg1 = (data->timing.pd_idle & 0xfff) |
+			    ((data->timing.srpd_lite_idle & 0xfff) << 16);
+
 	/*
 	 * We add a devfreq driver to our parent since it has a device tree node
 	 * with operating points.
diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip/rockchip_sip.h
index 7e28092c4d3d..ad9482c56797 100644
--- a/include/soc/rockchip/rockchip_sip.h
+++ b/include/soc/rockchip/rockchip_sip.h
@@ -23,5 +23,6 @@
 #define ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE	0x05
 #define ROCKCHIP_SIP_CONFIG_DRAM_CLR_IRQ	0x06
 #define ROCKCHIP_SIP_CONFIG_DRAM_SET_PARAM	0x07
+#define ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD	0x08
 
 #endif
-- 
2.21.0

