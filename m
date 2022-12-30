Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4F06593BA
	for <lists+linux-pm@lfdr.de>; Fri, 30 Dec 2022 01:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiL3AP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Dec 2022 19:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiL3APb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2022 19:15:31 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62C513D55;
        Thu, 29 Dec 2022 16:15:29 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id m15so10575273ilq.2;
        Thu, 29 Dec 2022 16:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkZ+PKnZ9zC6hJW2sW9KfOgcHNO14IZMmtWMgFUq8Bo=;
        b=cuRBB5ocUgyUdn+uWFiyIzTGHbpGjZwq6OmTeg+07najxJiWevlPnjRXJr5jXg5JNW
         WXJHTHcsSGsgVtwqhQ+ylrtMDytoqv3AosH2pLlFLI+PbjEQxanSEKmmXuTn0OaCZIuu
         0rEs8WH4Em6LiTG+GLoJ4hm+493ZJ4+d75ZWjuHlyOLhLtXnI7xzDCaP2Nn/AzSgEEaA
         4CL3MdG2VvrgODBrbw9m1RUH84iolOEDL/PiiSsYKMpbo31A9w4m7FeKBmXPtOuZRZNW
         TRUZE52iEHfctTKarXQS3AHUjqC1kt0TKr282sh9ZiH7ojASAuhc7bsZGovFOfMZFfn8
         BhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkZ+PKnZ9zC6hJW2sW9KfOgcHNO14IZMmtWMgFUq8Bo=;
        b=1Ue7+oZCQJ4jwxVhbAxYfDCh7Xk1fmpljcnOVponT9NpBsoq8h0MNBhBWaQPtmfjpq
         pEckUU/yNWF4J6plzxcGFyeI9ICbvTju+9++4l/SGexqkwQrAMoxQ6bWt4vtUPdIuCNJ
         MtiWT5xYfbzhBODhJAyTcBdVHCau3nr8uALxNLeWNeT4+qkYV8o7m6s8bHY3RArNw+Zu
         486E0lXyazVGIbhWF5C6g7jVKqiV4uO3K4Frmo+WmHwUeIYJ/YXCLNwEA9nWG+ffaKlc
         WDSZxvy63VKL//IUYhF2HHTw6IwjcHya/Y/AJPw3P6quOPfshb2QCjZpCY03GKORr9QP
         SDcw==
X-Gm-Message-State: AFqh2ko82OCfRS4tlZDzv2dgfIvlQVWfTJ/LYl/3/QDu0NoVM879aEh6
        zs5btWm3JlvGSGs49MkD9Uo=
X-Google-Smtp-Source: AMrXdXshEsmayg0SikWGMAX2Yd/eqJAJVIcEYR7VzPq8vyM9AZjgoJAzDHpgg7GiUIEkQOpmO6FCQw==
X-Received: by 2002:a92:d02:0:b0:30c:2a33:78a7 with SMTP id 2-20020a920d02000000b0030c2a3378a7mr1978587iln.21.1672359329188;
        Thu, 29 Dec 2022 16:15:29 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::b8e2])
        by smtp.gmail.com with ESMTPSA id d5-20020a92ddc5000000b002faf6559e90sm6126416ilr.51.2022.12.29.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 16:15:28 -0800 (PST)
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
Subject: [PATCH v2 4/4] arm64: dts: qcom: sdm670: add opps for peripherals
Date:   Thu, 29 Dec 2022 19:14:42 -0500
Message-Id: <20221230001442.369608-5-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221230001442.369608-1-mailingradian@gmail.com>
References: <20221230001442.369608-1-mailingradian@gmail.com>
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
index 67a7428291e2..78a99c549486 100644
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
@@ -418,6 +419,10 @@ sdhc_1: mmc@7c4000 {
 				 <&gcc GCC_SDCC1_ICE_CORE_CLK>,
 				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>;
 			clock-names = "iface", "core", "xo", "ice", "bus";
+			interconnects = <&aggre1_noc MASTER_EMMC 0 &aggre1_noc SLAVE_A1NOC_SNOC 0>,
+					<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_EMMC_CFG 0>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+			operating-points-v2 = <&sdhc1_opp_table>;
 
 			iommus = <&apps_smmu 0x140 0xf>;
 
@@ -430,6 +435,38 @@ sdhc_1: mmc@7c4000 {
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
@@ -465,6 +502,8 @@ qupv3_id_0: geniqup@8c0000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>;
+			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c0: i2c@880000 {
@@ -478,6 +517,10 @@ i2c0: i2c@880000 {
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
@@ -495,6 +538,10 @@ i2c1: i2c@884000 {
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
@@ -512,6 +559,10 @@ i2c2: i2c@888000 {
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
@@ -529,6 +580,10 @@ i2c3: i2c@88c000 {
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
@@ -546,6 +601,10 @@ i2c4: i2c@890000 {
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
@@ -563,6 +622,10 @@ i2c5: i2c@894000 {
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
@@ -580,6 +643,10 @@ i2c6: i2c@898000 {
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
@@ -597,6 +664,10 @@ i2c7: i2c@89c000 {
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
@@ -637,6 +708,8 @@ qupv3_id_1: geniqup@ac0000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>;
+			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c8: i2c@a80000 {
@@ -650,6 +723,10 @@ i2c8: i2c@a80000 {
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
@@ -667,6 +744,10 @@ i2c9: i2c@a84000 {
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
@@ -684,6 +765,10 @@ i2c10: i2c@a88000 {
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
@@ -701,6 +786,10 @@ i2c11: i2c@a8c000 {
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
@@ -718,6 +807,10 @@ i2c12: i2c@a90000 {
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
@@ -735,6 +828,10 @@ i2c13: i2c@a94000 {
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
@@ -752,6 +849,10 @@ i2c14: i2c@a98000 {
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
@@ -769,6 +870,10 @@ i2c15: i2c@a9c000 {
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
@@ -1014,6 +1119,10 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
+			interconnects = <&aggre2_noc MASTER_USB3 0 &mem_noc SLAVE_EBI_CH0 0>,
+					<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
 			status = "disabled";
 
 			usb_1_dwc3: usb@a600000 {
-- 
2.39.0

