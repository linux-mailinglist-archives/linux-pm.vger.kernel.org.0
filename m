Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680256650A5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 01:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjAKAwb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 19:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjAKAwa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 19:52:30 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8DC52;
        Tue, 10 Jan 2023 16:52:29 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e129so7000109iof.3;
        Tue, 10 Jan 2023 16:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYO33xQyLeHUiQm6gJT5un0Xk3CunWxDGIhcimU5htQ=;
        b=PgVYscsn4lqSwm42Vg9KrJtSlP1ekmMXDj5M9DbbzIQDd16T0gz00RwKXSAMd5O6IX
         zU4sUckp4DO+tt2Qy/jC/IQRxzSEe29DQBCj2JCi0JInGbTZnTYCjSbEccUHblNmDf0l
         L9pr/qCBXwmJUfavkSrfgXmkUfHfX91EylE89U42PPSzyU9zOKF5nfYuQlMUNySb3frG
         NECPzBnJt+1E86+HHvw9yTbOXMvqF3VY7sLjIw8xZxklw2wNQdfG7npBToEFTNCkxuY/
         HqBb1MMUm8KD2R9qK3FCqkDJOzoWXHfcsMhAnwAK1RADzRHtg4xJRB+oXuo6r1+I6w+i
         DWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYO33xQyLeHUiQm6gJT5un0Xk3CunWxDGIhcimU5htQ=;
        b=Do14Rkbd2BkXo9rYz35M5RuP4sHY+K+y7Nm0bD+HRRcfyYXfYMr2s/+gz0XCvgKowH
         duAACsaPt2bOi0PST6Uj4pUkatvO8PJCHsiP+Vy4Nv1ur6ouRxzS9z6CZxAA/mglkdTl
         4pDyuQ/jqtkuAMiTfbL4Ba1zIKvBpJQWxt2VbBYYHRm9TjFYpQ6b1JVX37yO85er8Fum
         0VWbnxJaYoh8mcMp1O9tqkUDbBVV4HjCa43lO8cfbJKeiNOJ6us0n3+gLEEl/pOXNL8a
         BL6PQlzR8z0xJELwzpEQMc/QWotBnOvl+ADttmo6FY8rtJWQMMRNRnvt1FJxf9D72dMd
         dUQw==
X-Gm-Message-State: AFqh2koGmHPAY4tXyDA6Jp5cAO1MWE3LDUqmVDyvP4tFMIO1qGFYE2HK
        7K4j6iug+xl2wA/edrPb9j4=
X-Google-Smtp-Source: AMrXdXvtgKqrV98VbW6b+YMMRCc6QQG/nHj5daU32UL/glI15ThOvw4y1f8dZWF2/cmAe1LeQbITvg==
X-Received: by 2002:a6b:4a17:0:b0:6e3:27e8:5a87 with SMTP id w23-20020a6b4a17000000b006e327e85a87mr43848472iob.19.1673398348578;
        Tue, 10 Jan 2023 16:52:28 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::11ab])
        by smtp.gmail.com with ESMTPSA id o23-20020a02a1d7000000b0038437cba721sm4093347jah.7.2023.01.10.16.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 16:52:28 -0800 (PST)
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
Subject: [PATCH v4 4/4] arm64: dts: qcom: sdm670: add opps for peripherals
Date:   Tue, 10 Jan 2023 19:51:55 -0500
Message-Id: <20230111005155.50452-5-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111005155.50452-1-mailingradian@gmail.com>
References: <20230111005155.50452-1-mailingradian@gmail.com>
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

