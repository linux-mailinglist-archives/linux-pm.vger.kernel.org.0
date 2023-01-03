Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690FD65B930
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 02:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjACB7D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 20:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjACB7B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 20:59:01 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7C127;
        Mon,  2 Jan 2023 17:59:00 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 3so16015338iou.12;
        Mon, 02 Jan 2023 17:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYO33xQyLeHUiQm6gJT5un0Xk3CunWxDGIhcimU5htQ=;
        b=IPn3S5hrZZUHqH2eLt1cdEbspAOpjPuVC1FwrZ6QjjVq7PPSE6AdNEE5XZRKZsaV1+
         MqK1yyuXTqJzgDztLXVrmKbgzc7eoibHFrE9fP8oBv3N8Y86RX7lJiad289ZHmLjr5YZ
         hKSxIURcmkX2t+Sb38WmyU08m7ByBG/AkeZ0lwoDxsYwquW4lZlNEXvFUHDio3yB6WdH
         pqJn4PRBSsakfqbocQ1ySaEw+JptZCxf+Sqp/UiI+fogesz0+JkUSFSW+85N84upusPF
         YxHttHHz2o85XKxzlqqku8Sn+79BJhKCZpmBulet46HCKXXo2o0nWbj8sau1+FjSm+Q7
         EK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYO33xQyLeHUiQm6gJT5un0Xk3CunWxDGIhcimU5htQ=;
        b=3GF3iH/zNHwJQwI8IQE+UzOZm8oPhFNGXkEokZs6vCUL2YSUvjBXvLFKv1S2Vbjt3s
         MvZH1h688ZqLhNiTDFGjc449R9ePr+rLupeSSy/xLdYg695Kjy00/A7d69GkL1HLrvD0
         3B6DM7w8PPRRGBov1Jz1BqJf4fy5MPcoTCe8LsZOR5lmSGkPk+TT/JeVz9JBspUN2fM1
         SBnBGKuGs0DpDw80TskbVVkKJ4r5O1MIdnTksaizqYIjdS3cy2zUGm0jkG31e/T+xr1/
         s4K+ulxx8mreFE+AGMrw5TwtPAhKMfGEcKES/RvI6Tj7m7N6/xlz4wBRRW4MPVJM8W//
         V5Lg==
X-Gm-Message-State: AFqh2krgViwFbBvJR58DUyghrBrgEOX6AZ2GNCwGh0s19s3ctkhsHX2t
        Ruw5Ljlk7i2snzg2mtyD1so=
X-Google-Smtp-Source: AMrXdXsXzhiqBuFoCPOAkeY8p/OeEcHDnt2dbBw/u/S/dp5z8vqLzOUm3Qz6VL+EWKsn+eTEcQh82Q==
X-Received: by 2002:a6b:b4d1:0:b0:6ed:308f:f807 with SMTP id d200-20020a6bb4d1000000b006ed308ff807mr30825882iof.21.1672711139826;
        Mon, 02 Jan 2023 17:58:59 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::d097])
        by smtp.gmail.com with ESMTPSA id e21-20020a6bf115000000b006d8b7bcaa6esm11089077iog.4.2023.01.02.17.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:58:59 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 4/4] arm64: dts: qcom: sdm670: add opps for peripherals
Date:   Mon,  2 Jan 2023 20:58:45 -0500
Message-Id: <20230103015845.314551-5-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103015845.314551-1-mailingradian@gmail.com>
References: <20230103015845.314551-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interconnects are now in place. Add Operating Performance Points for
them to allow the kernel to properly manage them.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index 02f14692dd9d..c5f839dd1c6e 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,sdm670-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -430,6 +431,10 @@ sdhc_1: mmc@7c4000 {
 				 <&gcc GCC_SDCC1_ICE_CORE_CLK>,
 				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>;
 			clock-names = "iface", "core", "xo", "ice", "bus";
+			interconnects = <&aggre1_noc MASTER_EMMC 0 &aggre1_noc SLAVE_A1NOC_SNOC 0>,
+					<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_EMMC_CFG 0>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+			operating-points-v2 = <&sdhc1_opp_table>;
 
 			iommus = <&apps_smmu 0x140 0xf>;
 
@@ -442,6 +447,38 @@ sdhc_1: mmc@7c4000 {
 			non-removable;
 
 			status = "disabled";
+
+			sdhc1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-20000000 {
+					opp-hz = /bits/ 64 <20000000>;
+					required-opps = <&rpmhpd_opp_min_svs>;
+					opp-peak-kBps = <80000 80000>;
+					opp-avg-kBps = <52286 80000>;
+				};
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <200000 100000>;
+					opp-avg-kBps = <130718 100000>;
+				};
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <200000 130000>;
+					opp-avg-kBps = <130718 130000>;
+				};
+
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <4096000 4096000>;
+					opp-avg-kBps = <1338562 1338562>;
+				};
+			};
 		};
 
 		gpi_dma0: dma-controller@800000 {
@@ -477,6 +514,8 @@ qupv3_id_0: geniqup@8c0000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>;
+			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c0: i2c@880000 {
@@ -490,6 +529,10 @@ i2c0: i2c@880000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -507,6 +550,10 @@ i2c1: i2c@884000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -524,6 +571,10 @@ i2c2: i2c@888000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -541,6 +592,10 @@ i2c3: i2c@88c000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -558,6 +613,10 @@ i2c4: i2c@890000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -575,6 +634,10 @@ i2c5: i2c@894000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -592,6 +655,10 @@ i2c6: i2c@898000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -609,6 +676,10 @@ i2c7: i2c@89c000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
+						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma0 0 7 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -649,6 +720,8 @@ qupv3_id_1: geniqup@ac0000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>;
+			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c8: i2c@a80000 {
@@ -662,6 +735,10 @@ i2c8: i2c@a80000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -679,6 +756,10 @@ i2c9: i2c@a84000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -696,6 +777,10 @@ i2c10: i2c@a88000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -713,6 +798,10 @@ i2c11: i2c@a8c000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -730,6 +819,10 @@ i2c12: i2c@a90000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -747,6 +840,10 @@ i2c13: i2c@a94000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -764,6 +861,10 @@ i2c14: i2c@a98000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 6 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -781,6 +882,10 @@ i2c15: i2c@a9c000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SDM670_CX>;
+				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
+						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
+						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				dmas = <&gpi_dma1 0 7 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 7 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1028,6 +1133,10 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
+			interconnects = <&aggre2_noc MASTER_USB3 0 &mem_noc SLAVE_EBI_CH0 0>,
+					<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
 			status = "disabled";
 
 			usb_1_dwc3: usb@a600000 {
-- 
2.39.0

