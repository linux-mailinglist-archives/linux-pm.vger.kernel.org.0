Return-Path: <linux-pm+bounces-290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9877FA4AA
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAAE1C20CDE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE5332C76;
	Mon, 27 Nov 2023 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHCedPKZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076FF1BEC
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:29:23 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so5746742a12.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098962; x=1701703762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DFGDMbVRO34D0rwNcwL3fZ3HlqOpwc3rrc9FYjKLyI=;
        b=gHCedPKZjK8LW41TBDRrJo+YMH1WEn03KYwDJsYCBceTezm4o0/JLYbDAmIHs2o4gb
         dwkRY2eA8mmmtuujC5ep6CYx6MDrxDA/q/13vIVMaMq+x+3AtqsU7bp/9U/uUai4QsFd
         IyLYN3Y0jx5LFxEXvUTvmZ5jybUo89nvYW0BEWwJnynsy+O7UzSPtXhr3cLhN0pcCuar
         RXBBO4rdMqw3XTSTr456pEUvcpPjAdbsQGQglvkoZTT7AwAHmLtqSuaV3t5KLgOCuOPb
         YSNPgBYDXbnTd+JRKBbTNYH1wJc7qw5HWB9CGDh0HxpyzYDC1w7GAVbgMouqXkJSpGZ7
         JjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098962; x=1701703762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DFGDMbVRO34D0rwNcwL3fZ3HlqOpwc3rrc9FYjKLyI=;
        b=Fl4CXXEe9ZBOBBsLstzDVizclMC3kCHxUCWbAuck44LdE8HjJo6Bx7iNFLB/yWtMAR
         uH6+hhOT3IOF6BLHGFjQPsD+VE1/pB3h+rLFJSKv5PLQLvysDEln7VJxgPDR3G/PYKwT
         1b1DulLK85Ckiv7RO+TF1v+HN/SMvxjNYX4s5IiJX3Dhd0H1yFKy8nTJ7CKlYgyMDoN9
         ksYt+C9qggA3DnSD4eLDxTp3Jcqo/9C+syp3XS0Ftog2P9s8aKIlSCfYSan+AWXlZYNB
         CCp5Lh3K2lfN+rCumTnBtRaPRXwiVO2L2JR/8SmW0/aAzxV3lGzwjfzAO2iaJwhakYMi
         gI0w==
X-Gm-Message-State: AOJu0Yzh6PC+3T8CiJKo8bNOVu3LHbIpmVDd3Kd28F2LfiB8VNc0p7PQ
	C/0IGJ0V0L5a32bNjjuwJKvOhg==
X-Google-Smtp-Source: AGHT+IHJXDT5NN7DwU5Pfcpfr/ZDGs0PZP//5f+srGFcC6TXlpyDPJInNcKOKf4MQz5jN0uCTR+DPQ==
X-Received: by 2002:a50:9e0f:0:b0:547:b96:1172 with SMTP id z15-20020a509e0f000000b005470b961172mr8219050ede.28.1701098962069;
        Mon, 27 Nov 2023 07:29:22 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:29:21 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 16:28:49 +0100
Subject: [PATCH v2 09/12] arm64: dts: qcom: qcm2290: Hook up interconnects
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-9-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=14818;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ldwUkmN/d0nEA5rH0T4Lp0JlzbHnDDZfoK2dQJvE38o=;
 b=Bue3hxcT+jH9yJHM6JBqW19j7l7WrAsyXRT4jaIy/luxf9PdYnvTsNVeLs3YKbxAbIskig0Kv
 e+zhbQlgPPSAbDc5DPpGu4s4IUswMcMUOMWQzNNAzmPynPUwp797o3d
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add interconnect provider nodes and hook up interconnects to consumer
devices, including bwmon.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 248 ++++++++++++++++++++++++++++++++++
 1 file changed, 248 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index a3edc4667cc5..ce04d0acdede 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -12,6 +12,8 @@
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interconnect/qcom,qcm2290.h>
+#include <dt-bindings/interconnect/qcom,rpm-icc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 
 / {
@@ -151,6 +153,8 @@ scm: scm {
 			clocks = <&rpmcc RPM_SMD_CE1_CLK>;
 			clock-names = "core";
 			#reset-cells = <1>;
+			interconnects = <&system_noc MASTER_CRYPTO_CORE0 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
 		};
 	};
 
@@ -669,6 +673,33 @@ usb_qmpphy: phy@1615000 {
 			status = "disabled";
 		};
 
+		system_noc: interconnect@1880000 {
+			compatible = "qcom,qcm2290-snoc";
+			reg = <0x0 0x01880000 0x0 0x60200>;
+			#interconnect-cells = <2>;
+
+			qup_virt: interconnect-qup {
+				compatible = "qcom,qcm2290-qup-virt";
+				#interconnect-cells = <2>;
+			};
+
+			mmnrt_virt: interconnect-mmnrt {
+				compatible = "qcom,qcm2290-mmnrt-virt";
+				#interconnect-cells = <2>;
+			};
+
+			mmrt_virt: interconnect-mmrt {
+				compatible = "qcom,qcm2290-mmrt-virt";
+				#interconnect-cells = <2>;
+			};
+		};
+
+		config_noc: interconnect@1900000 {
+			compatible = "qcom,qcm2290-cnoc";
+			reg = <0x0 0x01900000 0x0 0x8200>;
+			#interconnect-cells = <2>;
+		};
+
 		qfprom@1b44000 {
 			compatible = "qcom,qcm2290-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b44000 0x0 0x3000>;
@@ -681,6 +712,60 @@ qusb2_hstx_trim: hstx-trim@25b {
 			};
 		};
 
+		pmu@1b8e300 {
+			compatible = "qcom,qcm2290-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0x0 0x01b8e300 0x0 0x600>;
+			interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+			interconnects = <&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
+					 &bimc SLAVE_EBI1 RPM_ACTIVE_TAG>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <(200 * 4 * 1000)>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <(300 * 4 * 1000)>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <(451 * 4 * 1000)>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <(547 * 4 * 1000)>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <(681 * 4 * 1000)>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <(768 * 4 * 1000)>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <(1017 * 4 * 1000)>;
+				};
+
+				opp-7 {
+					opp-peak-kBps = <(1353 * 4 * 1000)>;
+				};
+
+				opp-8 {
+					opp-peak-kBps = <(1555 * 4 * 1000)>;
+				};
+
+				opp-9 {
+					opp-peak-kBps = <(1804 * 4 * 1000)>;
+				};
+			};
+		};
+
 		spmi_bus: spmi@1c40000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0 0x01c40000 0x0 0x1100>,
@@ -721,6 +806,12 @@ rng: rng@4453000 {
 			clock-names = "core";
 		};
 
+		bimc: interconnect@4480000 {
+			compatible = "qcom,qcm2290-bimc";
+			reg = <0x0 0x04480000 0x0 0x80000>;
+			#interconnect-cells = <2>;
+		};
+
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;
@@ -756,13 +847,45 @@ sdhc_1: mmc@4744000 {
 			resets = <&gcc GCC_SDCC1_BCR>;
 
 			power-domains = <&rpmpd QCM2290_VDDCX>;
+			operating-points-v2 = <&sdhc1_opp_table>;
 			iommus = <&apps_smmu 0xc0 0x0>;
+			interconnects = <&system_noc MASTER_SDCC_1 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+					<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+					 &config_noc SLAVE_SDCC_1 RPM_ALWAYS_TAG>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
 
 			qcom,dll-config = <0x000f642c>;
 			qcom,ddr-config = <0x80040868>;
 			bus-width = <8>;
 
 			status = "disabled";
+
+			sdhc1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <250000 133320>;
+					opp-avg-kBps = <102400 65000>;
+				};
+
+				opp-192000000 {
+					opp-hz = /bits/ 64 <192000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <800000 300000>;
+					opp-avg-kBps = <204800 200000>;
+				};
+
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+					opp-peak-kBps = <800000 300000>;
+					opp-avg-kBps = <204800 200000>;
+				};
+			};
 		};
 
 		sdhc_2: mmc@4784000 {
@@ -786,6 +909,12 @@ sdhc_2: mmc@4784000 {
 			power-domains = <&rpmpd QCM2290_VDDCX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			iommus = <&apps_smmu 0xa0 0x0>;
+			interconnects = <&system_noc MASTER_SDCC_2 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+					<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+					 &config_noc SLAVE_SDCC_2 RPM_ALWAYS_TAG>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
 
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
@@ -799,11 +928,15 @@ sdhc2_opp_table: opp-table {
 				opp-100000000 {
 					opp-hz = /bits/ 64 <100000000>;
 					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <250000 133320>;
+					opp-avg-kBps = <261438 150000>;
 				};
 
 				opp-202000000 {
 					opp-hz = /bits/ 64 <202000000>;
 					required-opps = <&rpmpd_opp_svs_plus>;
+					opp-peak-kBps = <800000 300000>;
+					opp-avg-kBps = <261438 300000>;
 				};
 			};
 		};
@@ -851,6 +984,15 @@ i2c0: i2c@4a80000 {
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -867,6 +1009,12 @@ spi0: spi@4a80000 {
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -880,6 +1028,12 @@ uart0: serial@4a80000 {
 				clock-names = "se";
 				pinctrl-0 = <&qup_uart0_default>;
 				pinctrl-names = "default";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				status = "disabled";
 			};
 
@@ -894,6 +1048,15 @@ i2c1: i2c@4a84000 {
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -910,6 +1073,12 @@ spi1: spi@4a84000 {
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -926,6 +1095,15 @@ i2c2: i2c@4a88000 {
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -942,6 +1120,12 @@ spi2: spi@4a88000 {
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -958,6 +1142,15 @@ i2c3: i2c@4a8c000 {
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -974,6 +1167,12 @@ spi3: spi@4a8c000 {
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -990,6 +1189,15 @@ i2c4: i2c@4a90000 {
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1006,6 +1214,12 @@ spi4: spi@4a90000 {
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1019,6 +1233,12 @@ uart4: serial@4a90000 {
 				clock-names = "se";
 				pinctrl-0 = <&qup_uart4_default>;
 				pinctrl-names = "default";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				status = "disabled";
 			};
 
@@ -1033,6 +1253,15 @@ i2c5: i2c@4a94000 {
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1049,6 +1278,12 @@ spi5: spi@4a94000 {
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1081,6 +1316,13 @@ usb: usb@4ef8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
+			/* TODO: USB<->IPA path */
+			interconnects = <&system_noc MASTER_USB3_0 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+					<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+					 &config_noc SLAVE_USB3 RPM_ALWAYS_TAG>;
+			interconnect-names = "usb-ddr",
+					     "apps-usb";
 			wakeup-source;
 
 			#address-cells = <2>;
@@ -1127,6 +1369,12 @@ mdss: display-subsystem@5e00000 {
 
 			iommus = <&apps_smmu 0x420 0x2>,
 				 <&apps_smmu 0x421 0x0>;
+			interconnects = <&mmrt_virt MASTER_MDP0 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+					<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+					 &config_noc SLAVE_DISPLAY_CFG RPM_ALWAYS_TAG>;
+			interconnect-names = "mdp0-mem",
+					     "cpu-cfg";
 
 			#address-cells = <2>;
 			#size-cells = <2>;

-- 
2.43.0


