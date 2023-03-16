Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE8D6BD20E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Mar 2023 15:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCPOOK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Mar 2023 10:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjCPONp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2023 10:13:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3315DABAC1
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 07:13:22 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l22so1824047ljc.11
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678976002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piy00ze27cjmP3sGzL7P6bitkrLZh8ic/pO7qFj7OPM=;
        b=Bh1hxScNUZDwRSRTQn//qBTILDXyyQwMC4kYaXpzqk2hB82rnzKtO8PO/swehYNbUN
         n33LC0ZB18/x/hrBJEwOnBTTYdfHONNjONchKWMmUZN8b76GS2U83J8BvsKdp6/Gql3K
         bATEpiI2h6Xr+4QG1FtFfksi7BdCwEqpVr3Ibksw5R7uS2WdVPaS9As9HVbRDnU72ayY
         +l9BXgVgw/Oo+FD5qWUsFmCwgnK4W9dJNcBU92za7IE/TLb5mbAy0yduOLWX0pptlakI
         vtwb6/+88SWs1JpAcw5V0DsCg9llwoY/8T2tDRIhuMLZKtvm/0BvqFnpovoegXcg3eNO
         ACBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678976002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piy00ze27cjmP3sGzL7P6bitkrLZh8ic/pO7qFj7OPM=;
        b=SxQ84VM79gFRbW9A2asKCKvn+OTHLl/v75QJWv2d/UB5bBhoeDBDcVNTEUdPu8pP3z
         B0WPfWxhPvRf/rur+CNneY/hENXOjrSNJS0U3wZTRoOagI75tzxycXqtnN5EqZMkEvwh
         NqETYwbpxYGOGqd497dKcRb+mafvCRiPGScq6FZqTzVv2GI0VsBKNDZcZuiQ8ysWHClV
         OLKv0ZYvWVaLq1TxDgPEHOTzbo4KOBKRN5lY5YAo4L6BK0szshpaEMyWt41NEVI33ytK
         kGlmirX3NNxXV5AFvTAobbD2tiWxHkmAoLbFtlJwC4Gm3iHivEMot2tXVKAbcudrXIQj
         WJtg==
X-Gm-Message-State: AO0yUKXlICO28HdnHJlduGRmybkd1l9hRTiCiY1Yo6yk+CRCL3rJMAPF
        omZwBHNuqaEkbykLnEGNf9n+1Q==
X-Google-Smtp-Source: AK7set9Hpl/z7MnJUp36/maR2mCB6ZRxpD7AZ4o8yJBa0qE4onNKcSgKX+qfcXq4bSTrWQTCW6aKwg==
X-Received: by 2002:a2e:9682:0:b0:299:aa9d:cea1 with SMTP id q2-20020a2e9682000000b00299aa9dcea1mr736947lji.47.1678976002152;
        Thu, 16 Mar 2023 07:13:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:13:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 15:13:02 +0100
Subject: [PATCH v2 13/14] arm64: dts: qcom: sm6375: Introduce C3 power
 state for both ARM clusters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v2-13-708b8191f7eb@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=3486;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=UTbmkp3WiwW+dRCBFpoWA3Dx76pcDEsLxGUPbgpPkms=;
 b=gCDDJGxaHaFaoA1Q1yXkbwsAPqik9mDAOA4+iE8WuLxR/oTio+6KB2PC3tQdI9UJyw+DXZb3LvG4
 K5XPI6yoDNAX+LCYL+JUhIDEolOtkgHRFO8kob55LXPKT3gv3m4p
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the C3 power state, which - to the best of my understanding -
gates the CPU clock, but does not shut off the power rail.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index d9b8c8b921be..bab64034a8d5 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -207,6 +207,16 @@ core7 {
 		idle-states {
 			entry-method = "psci";
 
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <549>;
+				exit-latency-us = <901>;
+				min-residency-us = <1774>;
+				local-timer-stop;
+			};
+
 			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "silver-rail-power-collapse";
@@ -217,6 +227,16 @@ LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
 				local-timer-stop;
 			};
 
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <523>;
+				exit-latency-us = <1244>;
+				min-residency-us = <2207>;
+				local-timer-stop;
+			};
+
 			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "gold-rail-power-collapse";
@@ -268,49 +288,49 @@ psci {
 		CPU_PD0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_1>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 		};
 
 		CPU_PD7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_1>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 		};
 
 		CLUSTER_PD: power-domain-cpu-cluster0 {

-- 
2.39.2

