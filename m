Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A276DBE0E
	for <lists+linux-pm@lfdr.de>; Sun,  9 Apr 2023 01:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjDHXtl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Apr 2023 19:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjDHXtk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Apr 2023 19:49:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167B87EFD
        for <linux-pm@vger.kernel.org>; Sat,  8 Apr 2023 16:49:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t20so2432634lfd.5
        for <linux-pm@vger.kernel.org>; Sat, 08 Apr 2023 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680997776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0geAgYGsx7hni60w58j8pf3w02X0TfqWpWQ/tBRl5U=;
        b=Bz4zi/RgCQ0yWgP+h4LCoqcQQd1OUAkaET8POWAMuDhI3tmjpbRYvTZVXmeH1Zy++I
         Ftx3W/gcaEEyKAFxByB/1CwL5Bj0EabmldWHk+z5p5dSFuiEWyl1voRz42Mb7MIR2bg/
         FLfcPhfSk78MsivQHhzzkPc1jZAEu/0vd7/Y5tnk6FwvRbVUWyadBqT5YqiyORAWZzqW
         /5MF2c6xaFbf3p0flL2BqezW6TTm6ERMzBQEUt33Xwww61T7XyDDD/OKXE+yUInGiuGM
         hP6+QX4a86Jq1AiqKjNrcvmbu+7zVHntEUvHkGx9Ve1WXmhFKaT3RiO9utwFh4lkkFAy
         95rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680997776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0geAgYGsx7hni60w58j8pf3w02X0TfqWpWQ/tBRl5U=;
        b=VSqj2spJQr2xwizKHXVxI5Fyl8Z8nzSqVU3S5MjFxEUtI/gUhMq7SbFx0kWPWSGs5A
         4ZmU55lAUdTe5FBEF3nOaAjGM8VxxZ254v4wCWwue5VXXcQWzJdgJmLPbEi8HxeTTl1h
         4sFqsmNV/xQjD1ZHYyJu2tHmaSZ93fQb7c1/X7NHgjvbJgQlukZ2ru4ErTzlQarHuV3V
         X/uABFopV/kjvQsKZy2ubr0zjR0JrYihHtvMaEjrFdcGIFMMXhdc06Vi6wZXmQiMMgqG
         k1wfvfvvDMdDW+6xALFrAL+sq8xLByqnhT+DuxYuEWGbbCwKDG4V1Z6mHfh5N5lzeTuO
         YiRg==
X-Gm-Message-State: AAQBX9cX/LXjQhKA2iXYR9fbX1fMOxQr31TyYXGhVgn6QTrVLjI7Jq4+
        1c2ldeZkMJs81q3lcxlM8l/1mQ==
X-Google-Smtp-Source: AKy350Z1IxDiaASWws70iUmpYB9YL6Ec16nl3W3bcMa5R1GiAEqS34XBdfpOia2apUxa4JHAtXBnvA==
X-Received: by 2002:ac2:48b7:0:b0:4b6:eca8:f6ca with SMTP id u23-20020ac248b7000000b004b6eca8f6camr1895807lfg.67.1680997776266;
        Sat, 08 Apr 2023 16:49:36 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q26-20020ac2529a000000b004e7fa99f3f4sm1353008lfm.265.2023.04.08.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 16:49:35 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 4/4] arm64: dts: qcom: msm8996: scale CBF clock according to the CPUfreq
Date:   Sun,  9 Apr 2023 02:49:32 +0300
Message-Id: <20230408234932.2363302-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230408234932.2363302-1-dmitry.baryshkov@linaro.org>
References: <20230408234932.2363302-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Turn CBF into the interconnect provider. Scale CBF frequency (bandwidth)
according to CPU frequencies.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4661a556772e..7c65e9955365 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/interconnect/qcom,msm8996.h>
+#include <dt-bindings/interconnect/qcom,msm8996-cbf.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,apr.h>
@@ -49,6 +50,7 @@ CPU0: cpu@0 {
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&kryocc 0>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
 			operating-points-v2 = <&cluster0_opp>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
@@ -66,6 +68,7 @@ CPU1: cpu@1 {
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&kryocc 0>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
 			operating-points-v2 = <&cluster0_opp>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
@@ -79,6 +82,7 @@ CPU2: cpu@100 {
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&kryocc 1>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
 			operating-points-v2 = <&cluster1_opp>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_1>;
@@ -96,6 +100,7 @@ CPU3: cpu@101 {
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&kryocc 1>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
 			operating-points-v2 = <&cluster1_opp>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_1>;
@@ -147,91 +152,109 @@ opp-307200000 {
 			opp-hz = /bits/ 64 <307200000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-422400000 {
 			opp-hz = /bits/ 64 <422400000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-480000000 {
 			opp-hz = /bits/ 64 <480000000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-556800000 {
 			opp-hz = /bits/ 64 <556800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-652800000 {
 			opp-hz = /bits/ 64 <652800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <384000>;
 		};
 		opp-729600000 {
 			opp-hz = /bits/ 64 <729600000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <460800>;
 		};
 		opp-844800000 {
 			opp-hz = /bits/ 64 <844800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <537600>;
 		};
 		opp-960000000 {
 			opp-hz = /bits/ 64 <960000000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
 		};
 		opp-1036800000 {
 			opp-hz = /bits/ 64 <1036800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
 		};
 		opp-1113600000 {
 			opp-hz = /bits/ 64 <1113600000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <825600>;
 		};
 		opp-1190400000 {
 			opp-hz = /bits/ 64 <1190400000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <825600>;
 		};
 		opp-1228800000 {
 			opp-hz = /bits/ 64 <1228800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <902400>;
 		};
 		opp-1324800000 {
 			opp-hz = /bits/ 64 <1324800000>;
 			opp-supported-hw = <0xd>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1056000>;
 		};
 		opp-1363200000 {
 			opp-hz = /bits/ 64 <1363200000>;
 			opp-supported-hw = <0x2>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1132800>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 <1401600000>;
 			opp-supported-hw = <0xd>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1132800>;
 		};
 		opp-1478400000 {
 			opp-hz = /bits/ 64 <1478400000>;
 			opp-supported-hw = <0x9>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1190400>;
 		};
 		opp-1497600000 {
 			opp-hz = /bits/ 64 <1497600000>;
 			opp-supported-hw = <0x04>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
 		};
 		opp-1593600000 {
 			opp-hz = /bits/ 64 <1593600000>;
 			opp-supported-hw = <0x9>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1382400>;
 		};
 	};
 
@@ -245,136 +268,163 @@ opp-307200000 {
 			opp-hz = /bits/ 64 <307200000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-403200000 {
 			opp-hz = /bits/ 64 <403200000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-480000000 {
 			opp-hz = /bits/ 64 <480000000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-556800000 {
 			opp-hz = /bits/ 64 <556800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-652800000 {
 			opp-hz = /bits/ 64 <652800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-729600000 {
 			opp-hz = /bits/ 64 <729600000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-806400000 {
 			opp-hz = /bits/ 64 <806400000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <384000>;
 		};
 		opp-883200000 {
 			opp-hz = /bits/ 64 <883200000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <460800>;
 		};
 		opp-940800000 {
 			opp-hz = /bits/ 64 <940800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <537600>;
 		};
 		opp-1036800000 {
 			opp-hz = /bits/ 64 <1036800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <595200>;
 		};
 		opp-1113600000 {
 			opp-hz = /bits/ 64 <1113600000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
 		};
 		opp-1190400000 {
 			opp-hz = /bits/ 64 <1190400000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
 		};
 		opp-1248000000 {
 			opp-hz = /bits/ 64 <1248000000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <748800>;
 		};
 		opp-1324800000 {
 			opp-hz = /bits/ 64 <1324800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <825600>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 <1401600000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <902400>;
 		};
 		opp-1478400000 {
 			opp-hz = /bits/ 64 <1478400000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <979200>;
 		};
 		opp-1555200000 {
 			opp-hz = /bits/ 64 <1555200000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1056000>;
 		};
 		opp-1632000000 {
 			opp-hz = /bits/ 64 <1632000000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1190400>;
 		};
 		opp-1708800000 {
 			opp-hz = /bits/ 64 <1708800000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1228800>;
 		};
 		opp-1785600000 {
 			opp-hz = /bits/ 64 <1785600000>;
 			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
 		};
 		opp-1804800000 {
 			opp-hz = /bits/ 64 <1804800000>;
 			opp-supported-hw = <0xe>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
 		};
 		opp-1824000000 {
 			opp-hz = /bits/ 64 <1824000000>;
 			opp-supported-hw = <0x1>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1382400>;
 		};
 		opp-1900800000 {
 			opp-hz = /bits/ 64 <1900800000>;
 			opp-supported-hw = <0x4>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
 		};
 		opp-1920000000 {
 			opp-hz = /bits/ 64 <1920000000>;
 			opp-supported-hw = <0x1>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1459200>;
 		};
 		opp-1996800000 {
 			opp-hz = /bits/ 64 <1996800000>;
 			opp-supported-hw = <0x1>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
 		};
 		opp-2073600000 {
 			opp-hz = /bits/ 64 <2073600000>;
 			opp-supported-hw = <0x1>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
 		};
 		opp-2150400000 {
 			opp-hz = /bits/ 64 <2150400000>;
 			opp-supported-hw = <0x1>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
 		};
 	};
 
@@ -3550,6 +3600,7 @@ cbf: clock-controller@9a11000 {
 			reg = <0x09a11000 0x10000>;
 			clocks = <&rpmcc RPM_SMD_XO_A_CLK_SRC>, <&apcs_glb>;
 			#clock-cells = <0>;
+			#interconnect-cells = <1>;
 		};
 
 		intc: interrupt-controller@9bc0000 {
-- 
2.30.2

