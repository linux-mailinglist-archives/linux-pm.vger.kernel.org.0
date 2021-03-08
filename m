Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F435331B08
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 00:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhCHXk0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 18:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhCHXjf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 18:39:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD02C061760
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 15:39:35 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b18so13257555wrn.6
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 15:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3n06U8mdhrzmpR+haJF9/pQTaor6n5rQHvjEBzX2gU=;
        b=kWi+A3IgqRtBD4WQ1kzOkBiV5S2EZ52U8te+6WygJldm1JsY3gMHw7ggielE/Jdvfq
         b9Pt0Lylqd0tZYzQE83aoe0OqIbov8zLbdiXGzq7j5useTLzwSo++IL9XqMqWj817HMS
         1k/xAhE7+HhvVyMYhJ7bbkTPPrEH9ReX45TxdZ1tD9qcDhovcS33CxAfiWqx0UG5lVRP
         5vB+ylkCN7jpTtrFtwqyYjoB+59FLT9DHw4GJPEYJnx3TG8/gLvmSQ62J6Q+O57LvP3N
         Zx1wpoQ1lWiVYRBbHXnpyBrVnUXSb4oxXVNALg1o8t3uY6B01TlV36amLwi3dA4BrVul
         luXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3n06U8mdhrzmpR+haJF9/pQTaor6n5rQHvjEBzX2gU=;
        b=JPOoL0LxFTqDp158s6+6fWVaj6ygvRPmSQFtVE5+eJM8YErL+YzqCLalRhq1Tu5GQk
         v7zPN/k6asZQHFEk3jW2cyK1wgjG7kOJ6bY0w4hht7QE8nTW4AqtLq75vOy4B0ihZ4TN
         nq/vZZXDiztNmd55JfKfbL/5RBwxYUj3xOvkAdXcaF6FLTZDTpsEzeoZQEJTDAgio2x7
         yFzhL2hW0G1FByvR/7/QI8k/lI/3mne2PtFyjfq6DgzqVaNmJR+8T3cDef+fowS5H5W/
         86DhonqG8yDvvM/oqMbnIq+GART68Iw0DSDSc+/AKwT9EvAHgiULjm8JDD2he2GYjSKu
         ou6w==
X-Gm-Message-State: AOAM531Hi/o6rxb48izCb/vrIgTHRCrWqwqjjPpDaIhygAtkbWHjXbsH
        fKgcLOVWUtbQtUXIAv3YnBWC/4kOb5X3Cg==
X-Google-Smtp-Source: ABdhPJzNblR46qqGnnTdUuxv4aM1NdGteNBgZmf27AlmJiQBbrnyDxa9Xvpb2UGZFEeSMPazdvbbtw==
X-Received: by 2002:a5d:658d:: with SMTP id q13mr25309365wru.388.1615246774116;
        Mon, 08 Mar 2021 15:39:34 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id b186sm1145408wmc.44.2021.03.08.15.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:39:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v5 4/4] dt-bindings: devfreq: rk3399_dmc: Remove references of unexistant defines
Date:   Tue,  9 Mar 2021 00:38:58 +0100
Message-Id: <20210308233858.24741-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308233858.24741-1-daniel.lezcano@linaro.org>
References: <20210308233858.24741-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gaël PORTAY <gael.portay@collabora.com>

Those DDR related defines do not exist. Replace their references with
their numerical constant.

Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/devfreq/rk3399_dmc.txt           | 73 +++++++++----------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index a41bcfef95c8..ddde2c4f97df 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -79,24 +79,23 @@ Following properties relate to DDR timing:
 
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
@@ -106,25 +105,23 @@ Following properties relate to DDR timing:
 
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
@@ -134,32 +131,30 @@ Following properties relate to DDR timing:
 
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
@@ -195,23 +190,23 @@ Example:
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
2.17.1

