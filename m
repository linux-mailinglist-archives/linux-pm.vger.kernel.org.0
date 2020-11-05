Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1742A8004
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 14:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgKENwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 08:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbgKENwP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 08:52:15 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACEC0613D3
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 05:52:14 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b8so1865563wrn.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 05:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3y3h8Gt2B3dQV3uiCceEQJtTal2gmWJav/I0Vj+GOyU=;
        b=T25OkuUQXDWnngtej/+9ragOdTSWZdRg8+VnVRzO8J9CMxdJQRU2S2L2EpTfD5eyxo
         RMmVa35GY1K4ilU0FQiNMd1hs0CCVCKg1O12tX5cevu654FOwqI2vn8vlSNj6RDg8nX6
         xGcwQNwhFXrDH6oy39zN1kOYELMUcIAzAoKqd2RAxF8mbS1EuU1tCTc+QO5AqrFI7C6j
         PlZerPoMdwkDLm9GZIV40/kwt+3ekNDKdFGfLAACyoVNISDlGeYNHJtaAfe0vKRb+wvF
         QXLCqSQ7VOUJesPd5YDlDZvPtNDJnCyHKO9bDMQFS6ugQdrQqxUczCidGWLYNtEd+6dp
         mx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3y3h8Gt2B3dQV3uiCceEQJtTal2gmWJav/I0Vj+GOyU=;
        b=XHPlmzd78cZG33SrPqsOURfXwZ36SOGRLIHLq7egz0zxLjttQ1J6L0XpfX40GjMeN1
         it79qu/0J4h1Vl5TFBjRaAIwaz1NP9vvr/bWaXbcEKYlKa5L/i6gxmlLm2HRXhV4NdKh
         U6+oaSlqJtWSgqjfFRoBb7eJBTv7uZ9klTJUw6jqOcJeWpBK499vst20NemMWzFy5y6u
         VPph4E9bTCIyOZAgESpUNOD3ea/yOJ3m9EDoYUUNX7MEkLvBgG/W5Qww4C53cDDuM088
         WIONlAayYOrP0Wgt+9DqeD8S/njr5/gJCNQdP3pmf6aCqsAYCe/Db0y2FAmrVOE3E+5w
         A6CQ==
X-Gm-Message-State: AOAM532h1/rudBtOeMQg5iFMVii2UNIFmYU8GEvKfmHcpKBzGI2uKp+5
        aLmhZ9pn7O/RUPaD0F3Lu/Mh7ldwYW07mA==
X-Google-Smtp-Source: ABdhPJz7/5ii7HK5bMoAedQL1YRUoj6Okm1V4pgzv17MB4XJKIgWAqVCA3hJO4rrgBuiUa0w9UrzLg==
X-Received: by 2002:a5d:4bd1:: with SMTP id l17mr3305932wrt.38.1604584332989;
        Thu, 05 Nov 2020 05:52:12 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h4sm2648541wrq.3.2020.11.05.05.52.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 05:52:12 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        mdtipton@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        akashast@codeaurora.org, georgi.djakov@linaro.org
Subject: [PATCH 3/3] arm64: dts: sdm845: Add interconnect properties for QUP
Date:   Thu,  5 Nov 2020 15:52:11 +0200
Message-Id: <20201105135211.7160-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105135211.7160-1-georgi.djakov@linaro.org>
References: <20201105135211.7160-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the interconnects DT property to describe the ports for GENI QUPs
on the sdm845 platform.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 160 +++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index aca7e9c954e0..14e74ba889c3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1123,6 +1123,8 @@ qupv3_id_0: geniqup@8c0000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>;
+			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c0: i2c@880000 {
@@ -1137,6 +1139,10 @@ i2c0: i2c@880000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1150,6 +1156,9 @@ spi0: spi@880000 {
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1163,6 +1172,9 @@ uart0: serial@880000 {
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1178,6 +1190,10 @@ i2c1: i2c@884000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1191,6 +1207,9 @@ spi1: spi@884000 {
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1204,6 +1223,9 @@ uart1: serial@884000 {
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1219,6 +1241,10 @@ i2c2: i2c@888000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1232,6 +1258,9 @@ spi2: spi@888000 {
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1245,6 +1274,9 @@ uart2: serial@888000 {
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1260,6 +1292,10 @@ i2c3: i2c@88c000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1273,6 +1309,9 @@ spi3: spi@88c000 {
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1286,6 +1325,9 @@ uart3: serial@88c000 {
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1301,6 +1343,10 @@ i2c4: i2c@890000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1314,6 +1360,9 @@ spi4: spi@890000 {
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1327,6 +1376,9 @@ uart4: serial@890000 {
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1342,6 +1394,10 @@ i2c5: i2c@894000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1355,6 +1411,9 @@ spi5: spi@894000 {
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1368,6 +1427,9 @@ uart5: serial@894000 {
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1383,6 +1445,10 @@ i2c6: i2c@898000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1396,6 +1462,9 @@ spi6: spi@898000 {
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1409,6 +1478,9 @@ uart6: serial@898000 {
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1437,6 +1509,9 @@ spi7: spi@89c000 {
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1450,6 +1525,9 @@ uart7: serial@89c000 {
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 		};
@@ -1463,6 +1541,8 @@ qupv3_id_1: geniqup@ac0000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>;
+			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c8: i2c@a80000 {
@@ -1477,6 +1557,10 @@ i2c8: i2c@a80000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1490,6 +1574,9 @@ spi8: spi@a80000 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1503,6 +1590,9 @@ uart8: serial@a80000 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1518,6 +1608,10 @@ i2c9: i2c@a84000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1531,6 +1625,9 @@ spi9: spi@a84000 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1544,6 +1641,9 @@ uart9: serial@a84000 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1559,6 +1659,10 @@ i2c10: i2c@a88000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1572,6 +1676,9 @@ spi10: spi@a88000 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1585,6 +1692,9 @@ uart10: serial@a88000 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1600,6 +1710,10 @@ i2c11: i2c@a8c000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1613,6 +1727,9 @@ spi11: spi@a8c000 {
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1626,6 +1743,9 @@ uart11: serial@a8c000 {
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1641,6 +1761,10 @@ i2c12: i2c@a90000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1654,6 +1778,9 @@ spi12: spi@a90000 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1667,6 +1794,9 @@ uart12: serial@a90000 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1682,6 +1812,10 @@ i2c13: i2c@a94000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1695,6 +1829,9 @@ spi13: spi@a94000 {
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1708,6 +1845,9 @@ uart13: serial@a94000 {
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1723,6 +1863,10 @@ i2c14: i2c@a98000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -1736,6 +1880,9 @@ spi14: spi@a98000 {
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1749,6 +1896,9 @@ uart14: serial@a98000 {
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1765,6 +1915,10 @@ i2c15: i2c@a9c000 {
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 			};
 
 			spi15: spi@a9c000 {
@@ -1777,6 +1931,9 @@ spi15: spi@a9c000 {
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -1790,6 +1947,9 @@ uart15: serial@a9c000 {
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SDM845_CX>;
 				operating-points-v2 = <&qup_opp_table>;
+				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 		};
