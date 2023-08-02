Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8959C76C1FD
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 03:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjHBBQF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 21:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjHBBQE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 21:16:04 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603FF2708;
        Tue,  1 Aug 2023 18:16:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58419517920so71466777b3.0;
        Tue, 01 Aug 2023 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690938961; x=1691543761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUttVkYPVUVU3N89+Zx8zJHpQPnjY7KVRIbxNy+rJtI=;
        b=re6KF/msUSgy1SZJn5mnslj89vAbvAunZ9CDmOPyyY7irQHYMW0VWKRod+nYn3ji4S
         8gTPTUks9ti/A/5CySdoCKwtngVdMSTDS98t0fRUkJZTaPO6UgJ9SHJGtRx3JOtPHjI0
         N9LXTx32l+vP8IiolCfqeLmVwH9rxu06M3isgHHll9ME5zI0f5K9Wnn631uN94MBknHA
         hO0m4xv4iRW0ueBnqk4b3tjB+GE+/HOVEov4GVTEqk/Rh8sXZlPWIYqGnlebaG2DYKck
         Crj8I6ZjtovbTmjaaa246UuMcUwnwLb1tbufY/N8mHuc6wuNE8OVP8zcq+f98lLUit5c
         W5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690938961; x=1691543761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUttVkYPVUVU3N89+Zx8zJHpQPnjY7KVRIbxNy+rJtI=;
        b=KLQB6NFpOl2Xq0QpeiBZFsynmAcr22R13jJhLowplpuhMJNEZt9mTn+hiGm24GNSkd
         udLzdePhaH81zHpsS+naZlb/WBITsJqQqrCKz0WYP1XMipvzJ5pznAsXu63ILZG+2ePu
         eRSiK/P6Xaf3jgJQYco6aJSmvbE3aZfACTAKKnAzvS89I7ZHC5K4oabr/q23d9I5CJGI
         EHbTfe7HZk2LMZ7dr72xqLdrKAXcPtUfnG1BUQca2kWFItTg6bxWQTvJty+ngBIANWNl
         TrweqIRPNP9lhK1znusdL80rVnkk2XjYYP331fVUeID1YIGiGuxBnhok1/HeiwEu6PeR
         bsqw==
X-Gm-Message-State: ABy/qLbzXZFbD9A+H6MDgCgC0qaI/dQCQiU+EX2t/O97vqSbNsYyWcD3
        3bts+M0/NLyMPNmOGpo/4hc=
X-Google-Smtp-Source: APBJJlG+T+48cDWQgSBCXMYe60+rbAbSTSNBpFGPnI5bXY+fR2FnjJ53siN5dBNvVTf6HoWFk+JPTg==
X-Received: by 2002:a81:6c56:0:b0:56c:f916:a8a9 with SMTP id h83-20020a816c56000000b0056cf916a8a9mr16851289ywc.22.1690938961516;
        Tue, 01 Aug 2023 18:16:01 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::7cda])
        by smtp.gmail.com with ESMTPSA id x3-20020a814a03000000b0057d24f8278bsm4141383ywa.104.2023.08.01.18.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 18:16:00 -0700 (PDT)
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
Subject: [PATCH v2 3/4] arm64: dts: qcom: sdm670: add cpu frequency scaling
Date:   Tue,  1 Aug 2023 21:15:51 -0400
Message-ID: <20230802011548.387519-9-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802011548.387519-6-mailingradian@gmail.com>
References: <20230802011548.387519-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add CPU frequency scaling, and also add the corresponding memory and
cache bandwidths for each frequency.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 149 +++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index 45f9633d2d2c..e1ef3fc2ace0 100644
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
@@ -246,6 +279,111 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <400000 4800000>;
+		};
+
+		cpu0_opp2: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <400000 4800000>;
+		};
+
+		cpu0_opp3: opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			opp-peak-kBps = <1200000 4800000>;
+		};
+
+		cpu0_opp4: opp-998400000 {
+			opp-hz = /bits/ 64 <998400000>;
+			opp-peak-kBps = <1804000 8908800>;
+		};
+
+		cpu0_opp5: opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-peak-kBps = <2188000 8908800>;
+		};
+
+		cpu0_opp6: opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <2188000 13516800>;
+		};
+
+		cpu0_opp7: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <3072000 15052800>;
+		};
+
+		cpu0_opp8: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			opp-peak-kBps = <3072000 22118400>;
+		};
+
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
+		cpu6_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <400000 4800000>;
+		};
+
+		cpu6_opp2: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-peak-kBps = <400000 4800000>;
+		};
+
+		cpu6_opp3: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			opp-peak-kBps = <1200000 4800000>;
+		};
+
+		cpu6_opp4: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			opp-peak-kBps = <1200000 4800000>;
+		};
+
+		cpu6_opp5: opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-peak-kBps = <2188000 8908800>;
+		};
+
+		cpu6_opp6: opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-peak-kBps = <4068000 12902400>;
+		};
+
+		cpu6_opp7: opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			opp-peak-kBps = <4068000 12902400>;
+		};
+
+		cpu6_opp8: opp-1747200000 {
+			opp-hz = /bits/ 64 <1747200000>;
+			opp-peak-kBps = <4068000 15052800>;
+		};
+
+		cpu6_opp9: opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			opp-peak-kBps = <4068000 15052800>;
+		};
+
+		cpu6_opp10: opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			opp-peak-kBps = <6220000 19046400>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -1364,5 +1502,16 @@ osm_l3: interconnect@17d41000 {
 
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

