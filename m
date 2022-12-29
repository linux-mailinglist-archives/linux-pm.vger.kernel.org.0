Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C536F658907
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiL2DBn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiL2DB2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:28 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E642312760
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p36so25883863lfa.12
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH0PwA5vfkofJztQV4SK2pw+e40R1Lbej9mCPr9ocw8=;
        b=lyEOC4HY/deWOSwatwc5N/UVgKsdd8KYq8lJR1ZUPcytt/8DHhtiNWbhdWOZLK2RNS
         tvFWxIn0yhw0hCRHl51+VfIBZY3lAcF6Kr6VHbxKCdatTPAIJyK/GMbGLway5ZZZd1+b
         DkVFP+vz9Gst8FjplMarDT7NqKaSgZnGXMFHzmIDOg8qlVsNvPp+d5L2BtL8CYQ60Pt8
         6HzXVUPWQz8ySnDSvtmJSZmyuN69KOYVYJOWzBvB0fl8m38xqNa+cUL/SGaLD5ztcgFC
         ooAhmkAfRB1VFdIm4NvUS04IwTf+PhPnVOxx278rXyRWy9FUsQpOb0G5GWzEQd2HQKHE
         xZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH0PwA5vfkofJztQV4SK2pw+e40R1Lbej9mCPr9ocw8=;
        b=xVONTqmLte5WVGQxItuk6YhRaYguzZugHl/vI8hWZIA0iOcywf9RgxsHo0XCG0J1+m
         QN+mbyVJZkM3653199FfSF4tYoXBfFuFi6rBc1y9mvY33iT6ujXnCtPyZew/1A1riycu
         QAZtC2DuIKsOsTJd7pH8LHgVfIPpMCMLIoh6JeAnqgargJxDKF+qTaqbOt1hkEBBVj8Z
         v5TIixdGaUqOG/mlTKZINorwzpq2QGn29pyCZSxRFfpmuXHFQ5YmVa8KCYhUioGDsAG7
         eu9qB0/5KGoiRQ1IY0nejB0s87G0Cp71ra9UZFdYRzQcO2D3BNBROQeGgA23lt/PwdDX
         pl1g==
X-Gm-Message-State: AFqh2krg7Aie+YBFfXIz2Oy9xZZDAB3zLvkRFuPjdU8zesgXnztzHiNT
        yY2B70WEPENOLEW2CYs/VAzwCw==
X-Google-Smtp-Source: AMrXdXuDVI21Ex1K34nUMUJweMXilQp7x3eikZxQVLLD8djbaH7Hix6pnea8dp4Ib7QUvBE1J+Clhg==
X-Received: by 2002:ac2:414b:0:b0:4b5:3505:d7f9 with SMTP id c11-20020ac2414b000000b004b53505d7f9mr7045077lfi.35.1672282883089;
        Wed, 28 Dec 2022 19:01:23 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:22 -0800 (PST)
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
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 18/20] arm64: dts: qcom: qcs404: specify per-sensor calibration cells
Date:   Thu, 29 Dec 2022 05:01:04 +0200
Message-Id: <20221229030106.3303205-19-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
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
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 145 ++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index a5324eecb50a..84ff9df2b904 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -366,13 +366,126 @@ qfprom: qfprom@a4000 {
 			reg = <0x000a4000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			tsens_caldata: caldata@d0 {
-				reg = <0x1f8 0x14>;
-			};
 			cpr_efuse_speedbin: speedbin@13c {
 				reg = <0x13c 0x4>;
 				bits = <2 3>;
 			};
+
+			tsens_s0_p1: s0-p1@1f8 {
+				reg = <0x1f8 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s0_p2: s0-p2@1f8 {
+				reg = <0x1f8 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s1_p1: s1-p1@1f9 {
+				reg = <0x1f9 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s1_p2: s1-p2@1fa {
+				reg = <0x1fa 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s2_p1: s2-p1@1fb {
+				reg = <0x1fb 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s2_p2: s2-p2@1fb {
+				reg = <0x1fb 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s3_p1: s3-p1@1fc {
+				reg = <0x1fc 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s3_p2: s3-p2@1fd {
+				reg = <0x1fd 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s4_p1: s4-p1@1fe {
+				reg = <0x1fe 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s4_p2: s4-p2@1fe {
+				reg = <0x1fe 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s5_p1: s5-p1@200 {
+				reg = <0x200 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s5_p2: s5-p2@200 {
+				reg = <0x200 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s6_p1: s6-p1@201 {
+				reg = <0x201 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s6_p2: s6-p2@202 {
+				reg = <0x202 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s7_p1: s7-p1@203 {
+				reg = <0x203 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s7_p2: s7-p2@203 {
+				reg = <0x203 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s8_p1: s8-p1@204 {
+				reg = <0x204 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s8_p2: s8-p2@205 {
+				reg = <0x205 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s9_p1: s9-p1@206 {
+				reg = <0x206 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s9_p2: s9-p2@206 {
+				reg = <0x206 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_mode: mode@208 {
+				reg = <0x208 1>;
+				bits = <0 3>;
+			};
+
+			tsens_base1: base1@208 {
+				reg = <0x208 2>;
+				bits = <3 8>;
+			};
+
+			tsens_base2: base2@208 {
+				reg = <0x209 2>;
+				bits = <3 8>;
+			};
+
 			cpr_efuse_quot_offset1: qoffset1@231 {
 				reg = <0x231 0x4>;
 				bits = <4 7>;
@@ -447,8 +560,30 @@ tsens: thermal-sensor@4a9000 {
 			compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
 			reg = <0x004a9000 0x1000>, /* TM */
 			      <0x004a8000 0x1000>; /* SROT */
-			nvmem-cells = <&tsens_caldata>;
-			nvmem-cell-names = "calib";
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
+				      <&tsens_s9_p1>, <&tsens_s9_p2>;
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
+					   "s9_p1", "s9_p2";
 			#qcom,sensors = <10>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow";
-- 
2.39.0

