Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA226DCBF2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDJUAZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjDJUAX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:00:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B71FCA
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:00:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bx15so4358277ljb.7
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681156819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0geAgYGsx7hni60w58j8pf3w02X0TfqWpWQ/tBRl5U=;
        b=NqnD+jrw7+RXAsVwGIRPwaxViB2r8/2TdGuVY+U107vm+nI+2BJMljjvcE4uFQ4UQW
         Hyr1JXMfYzYv2sYMvs9gtdUMZn53VpJ6/uOyDbXDKtfyAWnpCiq0dKXnlSgcFZtGgWVk
         KNmtih7AAxtEqKRVjJbTU6k+qalqSPjSMes3QL9xKYGBECIvp4wx6fXRhIt8WMpggi1i
         cQQ7dt72gbCdjhKPBaN6MNvcY/CevORJuRNWdiZgqE1JQ4N5Or90VQruXoXzdwoyxGd9
         9H4RsNwIY2nY/5z7iWkfuZ3QAeHWM+dswl0fS5+iVOkgepK/sUXYlxJmhubNaGwRBS2P
         dwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681156819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0geAgYGsx7hni60w58j8pf3w02X0TfqWpWQ/tBRl5U=;
        b=NBbH8wjbGhtSl+OL5GEne9MDjr/oTCYSojw+Oyqm3fDxTDI59L8oA42yy9ItbZp73/
         MSwoclT3w39/8UK30xPi1HpztP1XP7zohE18CPXwrYpd9VYfZY1b7hDEaEp54nNJnKRj
         Tu/Ga3rFXzhmvAVbZ12nwmm1zrv1rZEtOk85j+Ot6qIVE/g+/15Tpv7Bma5G70Bk/c5F
         0RrqvBq8mufqDkcBiR34nV2ST7WvhocGhAZsR6tlG6bBGFcKlklXBwGk8FaID8dGKp/f
         3oBfgS7OCAr6g1JGxHZP9w5XTEsdkg3STmKW2WCSTIVHTx43Ncg3xIUnsY1DSrwze0Bc
         ROwA==
X-Gm-Message-State: AAQBX9fEO4bY7TB1FcKckVkW+IOxamG29QSUbjkyupdyQ76c6CN6KQzB
        0YS+IA2fEwX+TRWCkY4qxGtbcQ==
X-Google-Smtp-Source: AKy350YUHFD6pY+nPSycqRbgigFpxzSPu51Z7SVtyBDxm6qFZ4tlnErf1MqyM0AyZltWdbesTHeyjw==
X-Received: by 2002:a2e:80c3:0:b0:293:4c17:9998 with SMTP id r3-20020a2e80c3000000b002934c179998mr2620173ljg.11.1681156818894;
        Mon, 10 Apr 2023 13:00:18 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z2-20020a2e8e82000000b002a7729eea3dsm973482ljk.88.2023.04.10.13.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:00:18 -0700 (PDT)
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
Subject: [PATCH v5 4/4] arm64: dts: qcom: msm8996: scale CBF clock according to the CPUfreq
Date:   Mon, 10 Apr 2023 23:00:14 +0300
Message-Id: <20230410200014.432418-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230410200014.432418-1-dmitry.baryshkov@linaro.org>
References: <20230410200014.432418-1-dmitry.baryshkov@linaro.org>
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

