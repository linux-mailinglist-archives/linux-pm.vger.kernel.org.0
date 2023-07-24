Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5D2760170
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 23:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjGXVnH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGXVm4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 17:42:56 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ECB122;
        Mon, 24 Jul 2023 14:42:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-583e91891aeso21886407b3.1;
        Mon, 24 Jul 2023 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234973; x=1690839773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngiLZG73zdZJGD5Bsu6BbcrxMVGagfGuOIrnngJsOqE=;
        b=P+g7dL9lAYTRtjnEfSydRhfujHNt5e0WHo1OiYLat1ma91WTlmOQlrP4oHt9rMhJ92
         zFtm36ern/Egr91P0tOzoMLXe1hCJuS7ABdPnTcWUPFy4ZP1rLlkZP0uPNAJy6PEpsbp
         IQ27LwdLW6QUplgvJ448xzAB8VJ+Y3/n4Zd0GZe2C+CHt3s3x4WBwlivEVeq3m2ORXnO
         dwHItd++kA4n+zwVpUzmXRtf+CDFZinF936KbLL0mm/5JLeNB+jYuUIrL5AqBLbcIQ33
         HT6qClujUzALQMI2MTVQ3X8cFSBQnuiwMdZvM6oADFNqIHohBXXQDJ9vZYeuoiSB1CPW
         Q/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234973; x=1690839773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngiLZG73zdZJGD5Bsu6BbcrxMVGagfGuOIrnngJsOqE=;
        b=NS+SUn0nKJ4g9mHfffvfYwHJRlRMu60UiWEB7+ACWP453HLdkNaxap8V3VcoxV+FCQ
         q7I3tDPeppHc4g0ir8svLTSLZNlCBGOBR+yEnczfPqRp+tJcUIBBHhpsme5JrwYsIOgd
         eaKKnQf88ebdDFuFdh8abp+Ty+gsMb9olq9wi96HYSeKy2G00J5oDaA0UAjAkH1Tl4DN
         26EcFZa9IsR2qHxH/NhLx4KwEUbfyPuigBtpFKCwBgs352iBCN6+DwsRgtaDQnpiz1e6
         qi9Cf+L5KHRLEUN5DaTPb8G9vD4xHaLtOxGTqWwE24DLnxrgeJQ5H9PCKRbrHpFWLRfV
         RHrw==
X-Gm-Message-State: ABy/qLYqgD32W5QGOdP1kzAstJ8lHzAHPcqdDeySbEXsRJLwe+/V5Xp7
        yv4uuNV1U1LR4eV/QaLg5peP+CfAk55tzA==
X-Google-Smtp-Source: APBJJlEVNwW9WdKbiE+69ffJnYJ+9V26rxlHtUbAt5CuaU/t3rjY6PpvCooDY4Tw7EpxKhkdXrCCew==
X-Received: by 2002:a81:66c4:0:b0:568:d63e:dd2c with SMTP id a187-20020a8166c4000000b00568d63edd2cmr9626068ywc.11.1690234973112;
        Mon, 24 Jul 2023 14:42:53 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::3cbb])
        by smtp.gmail.com with ESMTPSA id q187-20020a8175c4000000b0058390181d16sm2698538ywc.30.2023.07.24.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:42:52 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 3/4] arm64: dts: qcom: sdm670: add cpu frequency scaling
Date:   Mon, 24 Jul 2023 17:42:13 -0400
Message-ID: <20230724214209.208699-9-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724214209.208699-6-mailingradian@gmail.com>
References: <20230724214209.208699-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add CPU frequency scaling and the operating performance points for the
CPUs.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 168 +++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index 45f9633d2d2c..d013d0279dc9 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sdm670-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
@@ -35,6 +36,10 @@ CPU0: cpu@0 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_0>;
@@ -56,6 +61,10 @@ CPU1: cpu@100 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_100>;
@@ -72,6 +81,10 @@ CPU2: cpu@200 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_200>;
@@ -88,6 +101,10 @@ CPU3: cpu@300 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_300>;
@@ -104,6 +121,10 @@ CPU4: cpu@400 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_400>;
@@ -120,6 +141,10 @@ CPU5: cpu@500 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_500>;
@@ -136,6 +161,10 @@ CPU6: cpu@600 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_600>;
@@ -152,6 +181,10 @@ CPU7: cpu@700 {
 			compatible = "qcom,kryo360";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu6_opp_table>;
+			interconnects = <&gladiator_noc MASTER_AMPSS_M0 3 &mem_noc SLAVE_EBI_CH0 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_700>;
@@ -246,6 +279,130 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		// 576 mV
+		cpu0_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <400000 4800000>;
+		};
+
+		// 576 mV
+		cpu0_opp2: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <400000 4800000>;
+		};
+
+		// 576 mV
+		cpu0_opp3: opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			opp-peak-kBps = <1200000 4800000>;
+		};
+
+		// 636 mV
+		cpu0_opp4: opp-998400000 {
+			opp-hz = /bits/ 64 <998400000>;
+			opp-peak-kBps = <1804000 8908800>;
+		};
+
+		// 672 mV
+		cpu0_opp5: opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-peak-kBps = <2188000 8908800>;
+		};
+
+		// 688 mV
+		cpu0_opp6: opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <2188000 13516800>;
+		};
+
+		// 716 mV
+		cpu0_opp7: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <3072000 15052800>;
+		};
+
+		// 740 mV
+		cpu0_opp8: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			opp-peak-kBps = <3072000 22118400>;
+		};
+
+		// 772 mV
+		cpu0_opp9: opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <4068000 23040000>;
+		};
+	};
+
+	cpu6_opp_table: opp-table-cpu6 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		// 584 mV
+		cpu6_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <400000 4800000>;
+		};
+
+		// 584 mV
+		cpu6_opp2: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-peak-kBps = <400000 4800000>;
+		};
+
+		// 584 mV
+		cpu6_opp3: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			opp-peak-kBps = <1200000 4800000>;
+		};
+
+		// 616 mV
+		cpu6_opp4: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			opp-peak-kBps = <1200000 4800000>;
+		};
+
+		// 648 mV
+		cpu6_opp5: opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-peak-kBps = <2188000 8908800>;
+		};
+
+		// 680 mV
+		cpu6_opp6: opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-peak-kBps = <4068000 12902400>;
+		};
+
+		// 720 mV
+		cpu6_opp7: opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			opp-peak-kBps = <4068000 12902400>;
+		};
+
+		// 768 mV
+		cpu6_opp8: opp-1747200000 {
+			opp-hz = /bits/ 64 <1747200000>;
+			opp-peak-kBps = <4068000 15052800>;
+		};
+
+		// 776 mV
+		cpu6_opp9: opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			opp-peak-kBps = <4068000 15052800>;
+		};
+
+		// 816 mV
+		cpu6_opp10: opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			opp-peak-kBps = <6220000 19046400>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -1364,5 +1521,16 @@ osm_l3: interconnect@17d41000 {
 
 			#interconnect-cells = <1>;
 		};
+
+		cpufreq_hw: cpufreq@17d43000 {
+			compatible = "qcom,cpufreq-hw";
+			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
+			reg-names = "freq-domain0", "freq-domain1";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+		};
 	};
 };
-- 
2.41.0

