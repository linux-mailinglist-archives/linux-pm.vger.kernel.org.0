Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633191216D
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 19:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEBR6i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 13:58:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41930 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfEBR6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 13:58:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id A95F328348F
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
        =?utf-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH v5 6/6] dt-bindings: devfreq: rk3399_dmc: Remove references of unexistant defines
Date:   Thu,  2 May 2019 13:58:20 -0400
Message-Id: <20190502175820.25382-7-gael.portay@collabora.com>
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

Those DDR related defines do not exist. Replace their references with
their numerical constant.

Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---

Changes in v5: New

 .../bindings/devfreq/rk3399_dmc.txt           | 73 +++++++++----------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index 951789c0cdd6..3ea856970e46 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -77,24 +77,23 @@ Following properties relate to DDR timing:
 
 - rockchip,ddr3_drv :		  When the DRAM type is DDR3, this parameter defines
 				  the DRAM side driver strength in ohms. Default
-				  value is DDR3_DS_40ohm.
+				  value is 40.
 
 - rockchip,ddr3_odt :		  When the DRAM type is DDR3, this parameter defines
 				  the DRAM side ODT strength in ohms. Default value
-				  is DDR3_ODT_120ohm.
+				  is 120.
 
 - rockchip,phy_ddr3_ca_drv :	  When the DRAM type is DDR3, this parameter defines
 				  the phy side CA line (incluing command line,
 				  address line and clock line) driver strength.
-				  Default value is PHY_DRV_ODT_40.
+				  Default value is 40.
 
 - rockchip,phy_ddr3_dq_drv :	  When the DRAM type is DDR3, this parameter defines
 				  the PHY side DQ line (including DQS/DQ/DM line)
-				  driver strength. Default value is PHY_DRV_ODT_40.
+				  driver strength. Default value is 40.
 
 - rockchip,phy_ddr3_odt : 	  When the DRAM type is DDR3, this parameter defines
-				  the PHY side ODT strength. Default value is
-				  PHY_DRV_ODT_240.
+				  the PHY side ODT strength. Default value is 240.
 
 - rockchip,lpddr3_odt_dis_freq : When the DRAM type is LPDDR3, this parameter defines
 				  then ODT disable frequency in MHz (Mega Hz).
@@ -104,25 +103,23 @@ Following properties relate to DDR timing:
 
 - rockchip,lpddr3_drv :		  When the DRAM type is LPDDR3, this parameter defines
 				  the DRAM side driver strength in ohms. Default
-				  value is LP3_DS_34ohm.
+				  value is 34.
 
 - rockchip,lpddr3_odt :		  When the DRAM type is LPDDR3, this parameter defines
 				  the DRAM side ODT strength in ohms. Default value
-				  is LP3_ODT_240ohm.
+				  is 240.
 
 - rockchip,phy_lpddr3_ca_drv :	  When the DRAM type is LPDDR3, this parameter defines
 				  the PHY side CA line (including command line,
 				  address line and clock line) driver strength.
-				  Default value is PHY_DRV_ODT_40.
+				  Default value is 40.
 
 - rockchip,phy_lpddr3_dq_drv :	  When the DRAM type is LPDDR3, this parameter defines
 				  the PHY side DQ line (including DQS/DQ/DM line)
-				  driver strength. Default value is
-				  PHY_DRV_ODT_40.
+				  driver strength. Default value is 40.
 
 - rockchip,phy_lpddr3_odt : 	  When dram type is LPDDR3, this parameter define
-				  the phy side odt strength, default value is
-				  PHY_DRV_ODT_240.
+				  the phy side odt strength, default value is 240.
 
 - rockchip,lpddr4_odt_dis_freq : When the DRAM type is LPDDR4, this parameter
 				  defines the ODT disable frequency in
@@ -132,32 +129,30 @@ Following properties relate to DDR timing:
 
 - rockchip,lpddr4_drv :		  When the DRAM type is LPDDR4, this parameter defines
 				  the DRAM side driver strength in ohms. Default
-				  value is LP4_PDDS_60ohm.
+				  value is 60.
 
 - rockchip,lpddr4_dq_odt : 	  When the DRAM type is LPDDR4, this parameter defines
 				  the DRAM side ODT on DQS/DQ line strength in ohms.
-				  Default value is LP4_DQ_ODT_40ohm.
+				  Default value is 40.
 
 - rockchip,lpddr4_ca_odt :	  When the DRAM type is LPDDR4, this parameter defines
 				  the DRAM side ODT on CA line strength in ohms.
-				  Default value is LP4_CA_ODT_40ohm.
+				  Default value is 40.
 
 - rockchip,phy_lpddr4_ca_drv :	  When the DRAM type is LPDDR4, this parameter defines
 				  the PHY side CA line (including command address
-				  line) driver strength. Default value is
-				  PHY_DRV_ODT_40.
+				  line) driver strength. Default value is 40.
 
 - rockchip,phy_lpddr4_ck_cs_drv : When the DRAM type is LPDDR4, this parameter defines
 				  the PHY side clock line and CS line driver
-				  strength. Default value is PHY_DRV_ODT_80.
+				  strength. Default value is 80.
 
 - rockchip,phy_lpddr4_dq_drv :	  When the DRAM type is LPDDR4, this parameter defines
 				  the PHY side DQ line (including DQS/DQ/DM line)
-				  driver strength. Default value is PHY_DRV_ODT_80.
+				  driver strength. Default value is 80.
 
 - rockchip,phy_lpddr4_odt :	  When the DRAM type is LPDDR4, this parameter defines
-				  the PHY side ODT strength. Default value is
-				  PHY_DRV_ODT_60.
+				  the PHY side ODT strength. Default value is 60.  
 
 Example:
 	dmc_opp_table: dmc_opp_table {
@@ -193,23 +188,23 @@ Example:
 		rockchip,phy_dll_dis_freq = <125>;
 		rockchip,auto_pd_dis_freq = <666>;
 		rockchip,ddr3_odt_dis_freq = <333>;
-		rockchip,ddr3_drv = <DDR3_DS_40ohm>;
-		rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
-		rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
-		rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
-		rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
+		rockchip,ddr3_drv = <40>;
+		rockchip,ddr3_odt = <120>;
+		rockchip,phy_ddr3_ca_drv = <40>;
+		rockchip,phy_ddr3_dq_drv = <40>;
+		rockchip,phy_ddr3_odt = <240>;
 		rockchip,lpddr3_odt_dis_freq = <333>;
-		rockchip,lpddr3_drv = <LP3_DS_34ohm>;
-		rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
-		rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
-		rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
-		rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
+		rockchip,lpddr3_drv = <34>;
+		rockchip,lpddr3_odt = <240>;
+		rockchip,phy_lpddr3_ca_drv = <40>;
+		rockchip,phy_lpddr3_dq_drv = <40>;
+		rockchip,phy_lpddr3_odt = <240>;
 		rockchip,lpddr4_odt_dis_freq = <333>;
-		rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
-		rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
-		rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
-		rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
-		rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
-		rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
-		rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;
+		rockchip,lpddr4_drv = <60>;
+		rockchip,lpddr4_dq_odt = <40>;
+		rockchip,lpddr4_ca_odt = <40>;
+		rockchip,phy_lpddr4_ca_drv = <40>;
+		rockchip,phy_lpddr4_ck_cs_drv = <80>;
+		rockchip,phy_lpddr4_dq_drv = <80>;
+		rockchip,phy_lpddr4_odt = <60>;
 	};
-- 
2.21.0

