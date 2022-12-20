Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77537651923
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 03:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiLTCrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 21:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLTCrk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 21:47:40 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F513D17
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p36so16543398lfa.12
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jyq4dFoSz2Fyu1tkmi8RjA5wzVwQNYzG7qMhqzsEhY=;
        b=FNWIFKKBVLk17DLcDUk1ZGnkJd3wfgsQHo6SNX0nZXQmeJ0fGHhjJDAtNK9zAJaTn0
         IEhO4UBfN3jPgxdsiyIDGjVBmWliQ+CrRoBls4oWydSB46l6DwrqpUfvlnC1Igmin64B
         uD1gRRAhw7VsAAQmO6x3lF582eiBLBZ39EO3bvUUwHDsAIlqkeUSqlldhoiLtltIOMyA
         hvP9SaB5LX8kl7AbeGFq7tY3MrfflcFKhx3/0qUER3zILjribrVQW1JBfrlXF+TVbGEz
         fS4U6RtnogdU0X8Zvptu7dBEmsoIPiHazx709uQP48RoyGHQ4fCXnciCLBMCVx1zAhWT
         jtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jyq4dFoSz2Fyu1tkmi8RjA5wzVwQNYzG7qMhqzsEhY=;
        b=6LbpNfm27XJ2YwN6Dqwu+X8kDtc/0lTAuebfyFDaQPOpTaAdnJBoValDfjOpmzhdm8
         egeEx4u3MI+vXV3zZhroAfy1Fsqpg9xjBEXA/QMG/fQHX6UrhEZLxif9Z6WlTjLMR08s
         r2ZXYpQzhvbkFe2TV/DEWxjmLfYnkVkjduFr3aNRBEKizlCvpsDI5nXifpmhDGnIjukF
         ReBOLaVTKcbzX9hIQcy/D66Me9RDQel6KTrTpUDDM4+eTgyed5LOtEEARcKdgeug52pq
         Gwaq6k+sLOWi0UGTGHKL9CQxvrGIhMVqsK5lL0LI+6rnBnLj/dqPleHDYD2wljFznFMk
         xqDg==
X-Gm-Message-State: ANoB5pnKBpBW9sF5ZIcbl629b7TkFbIhcVcVtV0hzXmDlMlO/I7HJ01Z
        MmrKeFS8gIBp5KahKXBPqq8ujA==
X-Google-Smtp-Source: AA0mqf76yiNtw9TGeAreezsItZkhKL8GugSrmc2SrKe06FMU3WojFzNMNnolYg/FpQXopOUfvI13Qg==
X-Received: by 2002:a05:6512:13a2:b0:4a4:68b7:d61d with SMTP id p34-20020a05651213a200b004a468b7d61dmr15172886lfa.4.1671504456458;
        Mon, 19 Dec 2022 18:47:36 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1274866lfs.252.2022.12.19.18.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:47:36 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 15/15] ARM: dts: qcom-apq8084: specify per-sensor calibration cells
Date:   Tue, 20 Dec 2022 04:47:21 +0200
Message-Id: <20221220024721.947147-16-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Specify pre-parsed per-sensor calibration nvmem cells in the tsens
device node rather than parsing the whole data blob in the driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 262 +++++++++++++++++++++++++++-
 1 file changed, 256 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index fe30abfff90a..f0f788ac38f0 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -249,11 +249,209 @@ qfprom: qfprom@fc4bc000 {
 			reg = <0xfc4bc000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			tsens_calib: calib@d0 {
-				reg = <0xd0 0x18>;
+			tsens_base1: base1@d0 {
+				reg = <0xd0 0x1>;
+				bits = <0 8>;
 			};
-			tsens_backup: backup@440 {
-				reg = <0x440 0x10>;
+			tsens_s0_p1: s0_p1@d1 {
+				reg = <0xd1 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s1_p1: s1_p1@d2 {
+				reg = <0xd1 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s2_p1: s2_p1@d2 {
+				reg = <0xd2 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s3_p1: s3_p1@d3 {
+				reg = <0xd3 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s4_p1: s4_p1@d4 {
+				reg = <0xd4 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s5_p1: s5_p1@d4 {
+				reg = <0xd4 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s6_p1: s6_p1@d5 {
+				reg = <0xd5 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s7_p1: s7_p1@d6 {
+				reg = <0xd6 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s8_p1: s8_p1@d7 {
+				reg = <0xd7 0x1>;
+				bits = <0 6>;
+			};
+			tsens_mode: mode@d7 {
+				reg = <0xd7 0x1>;
+				bits = <6 2>;
+			};
+			tsens_s9_p1: s9_p1@d8 {
+				reg = <0xd8 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s10_p1: s10_p1@d8 {
+				reg = <0xd8 0x2>;
+				bits = <6 6>;
+			};
+			tsens_base2: base2@d9 {
+				reg = <0xd9 0x2>;
+				bits = <4 8>;
+			};
+			tsens_s0_p2: s0_p2@da {
+				reg = <0xda 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s1_p2: s1_p2@db {
+				reg = <0xdb 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s2_p2: s2_p2@dc {
+				reg = <0xdc 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s3_p2: s3_p2@dc {
+				reg = <0xdc 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s4_p2: s4_p2@dd {
+				reg = <0xdd 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s5_p2: s5_p2@de {
+				reg = <0xde 0x2>;
+				bits = <2 6>;
+			};
+			tsens_s6_p2: s6_p2@df {
+				reg = <0xdf 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s7_p2: s7_p2@e0 {
+				reg = <0xe0 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s8_p2: s8_p2@e0 {
+				reg = <0xe0 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s9_p2: s9_p2@e1 {
+				reg = <0xe1 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s10_p2: s10_p2@e2 {
+				reg = <0xe2 0x2>;
+				bits = <2 6>;
+			};
+			tsens_s5_p2_backup: s5_p2_backup@e3 {
+				reg = <0xe3 0x2>;
+				bits = <0 6>;
+			};
+			tsens_mode_backup: mode_backup@e3 {
+				reg = <0xe3 0x1>;
+				bits = <6 2>;
+			};
+			tsens_s6_p2_backup: s6_p2_backup@e4 {
+				reg = <0xe4 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s7_p2_backup: s7_p2_backup@e4 {
+				reg = <0xe4 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s8_p2_backup: s8_p2_backup@e5 {
+				reg = <0xe5 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s9_p2_backup: s9_p2_backup@e6 {
+				reg = <0xe6 0x2>;
+				bits = <2 6>;
+			};
+			tsens_s10_p2_backup: s10_p2_backup@e7 {
+				reg = <0xe7 0x1>;
+				bits = <0 6>;
+			};
+			tsens_base1_backup: base1_backup@440 {
+				reg = <0x440 0x1>;
+				bits = <0 8>;
+			};
+			tsens_s0_p1_backup: s0_p1_backup@441 {
+				reg = <0x441 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s1_p1_backup: s1_p1_backup@442 {
+				reg = <0x441 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s2_p1_backup: s2_p1_backup@442 {
+				reg = <0x442 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s3_p1_backup: s3_p1_backup@443 {
+				reg = <0x443 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s4_p1_backup: s4_p1_backup@444 {
+				reg = <0x444 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s5_p1_backup: s5_p1_backup@444 {
+				reg = <0x444 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s6_p1_backup: s6_p1_backup@445 {
+				reg = <0x445 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s7_p1_backup: s7_p1_backup@446 {
+				reg = <0x446 0x1>;
+				bits = <2 6>;
+			};
+			tsens_use_backup: use_backup@447 {
+				reg = <0x447 0x1>;
+				bits = <5 3>;
+			};
+			tsens_s8_p1_backup: s8_p1_backup@448 {
+				reg = <0x448 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s9_p1_backup: s9_p1_backup@448 {
+				reg = <0x448 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s10_p1_backup: s10_p1_backup@449 {
+				reg = <0x449 0x2>;
+				bits = <4 6>;
+			};
+			tsens_base2_backup: base2_backup@44a {
+				reg = <0x44a 0x2>;
+				bits = <2 8>;
+			};
+			tsens_s0_p2_backup: s0_p2_backup@44b {
+				reg = <0x44b 0x3>;
+				bits = <2 6>;
+			};
+			tsens_s1_p2_backup: s1_p2_backup@44c {
+				reg = <0x44c 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s2_p2_backup: s2_p2_backup@44c {
+				reg = <0x44c 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s3_p2_backup: s3_p2_backup@44d {
+				reg = <0x44d 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s4_p2_backup: s4_p2_backup@44e {
+				reg = <0x44e 0x1>;
+				bits = <2 6>;
 			};
 		};
 
@@ -261,8 +459,60 @@ tsens: thermal-sensor@fc4a8000 {
 			compatible = "qcom,msm8974-tsens", "qcom,tsens-v0_1";
 			reg = <0xfc4a9000 0x1000>, /* TM */
 			      <0xfc4a8000 0x1000>; /* SROT */
-			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
-			nvmem-cell-names = "calib", "calib_backup";
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>, <&tsens_base2>,
+				      <&tsens_s0_p1>, <&tsens_s0_p2>,
+				      <&tsens_s1_p1>, <&tsens_s1_p2>,
+				      <&tsens_s2_p1>, <&tsens_s2_p2>,
+				      <&tsens_s3_p1>, <&tsens_s3_p2>,
+				      <&tsens_s4_p1>, <&tsens_s4_p2>,
+				      <&tsens_s5_p1>, <&tsens_s5_p2>,
+				      <&tsens_s6_p1>, <&tsens_s6_p2>,
+				      <&tsens_s7_p1>, <&tsens_s7_p2>,
+				      <&tsens_s8_p1>, <&tsens_s8_p2>,
+				      <&tsens_s9_p1>, <&tsens_s9_p2>,
+				      <&tsens_s10_p1>, <&tsens_s10_p2>,
+				      <&tsens_use_backup>,
+				      <&tsens_mode_backup>,
+				      <&tsens_base1_backup>, <&tsens_base2_backup>,
+				      <&tsens_s0_p1_backup>, <&tsens_s0_p2_backup>,
+				      <&tsens_s1_p1_backup>, <&tsens_s1_p2_backup>,
+				      <&tsens_s2_p1_backup>, <&tsens_s2_p2_backup>,
+				      <&tsens_s3_p1_backup>, <&tsens_s3_p2_backup>,
+				      <&tsens_s4_p1_backup>, <&tsens_s4_p2_backup>,
+				      <&tsens_s5_p1_backup>, <&tsens_s5_p2_backup>,
+				      <&tsens_s6_p1_backup>, <&tsens_s6_p2_backup>,
+				      <&tsens_s7_p1_backup>, <&tsens_s7_p2_backup>,
+				      <&tsens_s8_p1_backup>, <&tsens_s8_p2_backup>,
+				      <&tsens_s9_p1_backup>, <&tsens_s9_p2_backup>,
+				      <&tsens_s10_p1_backup>, <&tsens_s10_p2_backup>;
+			nvmem-cell-names = "mode",
+					   "base1", "base2",
+					   "s0_p1", "s0_p2",
+					   "s1_p1", "s1_p2",
+					   "s2_p1", "s2_p2",
+					   "s3_p1", "s3_p2",
+					   "s4_p1", "s4_p2",
+					   "s5_p1", "s5_p2",
+					   "s6_p1", "s6_p2",
+					   "s7_p1", "s7_p2",
+					   "s8_p1", "s8_p2",
+					   "s9_p1", "s9_p2",
+					   "s10_p1", "s10_p2",
+					   "use_backup",
+					   "mode_backup",
+					   "base1_backup", "base2_backup",
+					   "s0_p1_backup", "s0_p2_backup",
+					   "s1_p1_backup", "s1_p2_backup",
+					   "s2_p1_backup", "s2_p2_backup",
+					   "s3_p1_backup", "s3_p2_backup",
+					   "s4_p1_backup", "s4_p2_backup",
+					   "s5_p1_backup", "s5_p2_backup",
+					   "s6_p1_backup", "s6_p2_backup",
+					   "s7_p1_backup", "s7_p2_backup",
+					   "s8_p1_backup", "s8_p2_backup",
+					   "s9_p1_backup", "s9_p2_backup",
+					   "s10_p1_backup", "s10_p2_backup";
 			#qcom,sensors = <11>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow";
-- 
2.35.1

