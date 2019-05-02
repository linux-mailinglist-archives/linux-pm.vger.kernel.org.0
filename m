Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E029412171
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 19:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfEBR6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 13:58:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfEBR6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 13:58:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 7C0FA2834A8
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
Subject: [PATCH v5 5/6] arm64: dts: rockchip: Enable dmc and dfi nodes on gru.
Date:   Thu,  2 May 2019 13:58:19 -0400
Message-Id: <20190502175820.25382-6-gael.portay@collabora.com>
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

From: Lin Huang <hl@rock-chips.com>

Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY
Interface) nodes on gru boards so we can support DDR DVFS.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---

Changes in v5:
- [PATCH v4 5/5] Remove use of DRAM setting defines.
		 Remove new DRAM setting header.

Changes in v4:
- [PATCH v3 5/5] Add board related DDR settings (moved from 4/5).

Changes in v3:
- [PATCH v2 5/5] Remove display_subsystem nodes.

Changes in v2:
- [PATCH 8/8] Move center-supply attribute of dmc node in file
              rk3399-gru-chromebook.dtsi (where ppvar_centerlogic is
	      defined).

Changes in v1: None

 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 ++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 45 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 931640e9aed4..cfb81356c61e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -400,3 +400,7 @@ ap_i2c_tp: &i2c5 {
 		rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_none>;
 	};
 };
+
+&dmc {
+	center-supply = <&ppvar_centerlogic>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index da03fa9c5662..f3ff3dd689c7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -289,6 +289,12 @@
 	status = "okay";
 };
 
+&dmc_opp_table {
+	opp04 {
+		opp-suspend;
+	};
+};
+
 /*
  * Set some suspend operating points to avoid OVP in suspend
  *
@@ -489,6 +495,45 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 };
 
+&dfi {
+	status = "okay";
+};
+
+&dmc {
+	status = "okay";
+	upthreshold = <25>;
+	downdifferential = <15>;
+	rockchip,ddr3_speed_bin = <21>;
+	rockchip,pd_idle = <0x40>;
+	rockchip,sr_idle = <0x2>;
+	rockchip,sr_mc_gate_idle = <0x3>;
+	rockchip,srpd_lite_idle	= <0x4>;
+	rockchip,standby_idle = <0x2000>;
+	rockchip,dram_dll_dis_freq = <300000000>;
+	rockchip,phy_dll_dis_freq = <125000000>;
+	rockchip,auto_pd_dis_freq = <666000000>;
+	rockchip,ddr3_odt_dis_freq = <333000000>;
+	rockchip,ddr3_drv = <40>;
+	rockchip,ddr3_odt = <120>;
+	rockchip,phy_ddr3_ca_drv = <40>;
+	rockchip,phy_ddr3_dq_drv = <40>;
+	rockchip,phy_ddr3_odt = <240>;
+	rockchip,lpddr3_odt_dis_freq = <333000000>;
+	rockchip,lpddr3_drv = <34>;
+	rockchip,lpddr3_odt = <240>;
+	rockchip,phy_lpddr3_ca_drv = <40>;
+	rockchip,phy_lpddr3_dq_drv = <40>;
+	rockchip,phy_lpddr3_odt = <240>;
+	rockchip,lpddr4_odt_dis_freq = <333000000>;
+	rockchip,lpddr4_drv = <60>;
+	rockchip,lpddr4_dq_odt = <40>;
+	rockchip,lpddr4_ca_odt = <40>;
+	rockchip,phy_lpddr4_ca_drv = <40>;
+	rockchip,phy_lpddr4_ck_cs_drv = <80>;
+	rockchip,phy_lpddr4_dq_drv = <80>;
+	rockchip,phy_lpddr4_odt = <60>;
+};
+
 &sdhci {
 	/*
 	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
index 69cc9b05baa5..c9e7032b01a8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
@@ -110,6 +110,31 @@
 			opp-microvolt = <1075000>;
 		};
 	};
+
+	dmc_opp_table: dmc_opp_table {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <666000000>;
+			opp-microvolt = <900000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <928000000>;
+			opp-microvolt = <900000>;
+		};
+	};
 };
 
 &cpu_l0 {
@@ -139,3 +164,7 @@
 &gpu {
 	operating-points-v2 = <&gpu_opp_table>;
 };
+
+&dmc {
+	operating-points-v2 = <&dmc_opp_table>;
+};
-- 
2.21.0

