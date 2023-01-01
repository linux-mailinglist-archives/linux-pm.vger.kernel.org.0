Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6783565AB66
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjAATlI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjAATk7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:40:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1702BEE
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:52 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m6so28506876lfj.11
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH0PwA5vfkofJztQV4SK2pw+e40R1Lbej9mCPr9ocw8=;
        b=tLn3Df5XiZn8DGY4sGaYKFxMDqQSpF5pTwza28IJkpEFpfgQ18xvmfExvQIYLrw6e4
         w1YQX24AlNbjzrxIb9Qxy04Qa7N3Fyn5I1q/PrhY8K0pdcC15jbW4KkdHkRb6plN8Ny9
         iJFW3DaZH7fYflCWO9Ok/JHRZVrRrpMbPOnB1dygrhmcRKDKoeRiSIYazeVkP6uOkUkn
         245uMrVLxi48SD7i2PTMsDwCpjLrAZ3OtKz+f4Hct3YwvxL0P2ujaHq2eEosP3sSe6Js
         XLwwNuCFDpj+I5JhhH3EOO+jfJNH5gHvFLnX1fMr2QHls4NUG81rmgVtpHV/ZuLjx49P
         4Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH0PwA5vfkofJztQV4SK2pw+e40R1Lbej9mCPr9ocw8=;
        b=gjZ4GcZPQkQ0vNmfMgqeNZ8HmEUjiuqEcFN7vwNE09GrkS5Tj0lConC0POZIXiDf+x
         4DbRtPGno23Pc0pTGVcH+a5Ki6jU5BqQPHI7jK7u2/tXI2b4ZIqqz7/qJxEHoaWdXCqz
         X3spRxIcsPxpxOCa+Fs1EY+/VnYIS0A1Fcc/jSv/5V6GMNviHB74ABnS5S0JYJLpb7kY
         Hf4H1U1e4sa8eKJqGew9hvTAjaXrUDCGPMfO7vvoeEkDp7YBCdLA1cJJck6d7WlYLIQu
         SU4fB6Y1pIBkC7lsgXoAkg+gGM+pJWiitxRwrXXnPK+cExS9xtrMyW+YSe/D+FMevTWJ
         EzQg==
X-Gm-Message-State: AFqh2kqfuAk03Yne2DAVA4KuEmWnn2opjh9x0OAKdHkEmnV0MFs1Id6j
        7Cny7dovdNoZ1d9x/f0muLhQyQ==
X-Google-Smtp-Source: AMrXdXu1aRTBYhdSDVri0fNdXyjI/TiYG+UaCrCP2OY7XQ3uC45aTm5NKhA1soSt5cuFaiCFOUklUw==
X-Received: by 2002:a05:6512:1285:b0:4b5:b937:7896 with SMTP id u5-20020a056512128500b004b5b9377896mr12679549lfs.46.1672602052287;
        Sun, 01 Jan 2023 11:40:52 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:40:51 -0800 (PST)
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
Subject: [PATCH v6 18/20] arm64: dts: qcom: qcs404: specify per-sensor calibration cells
Date:   Sun,  1 Jan 2023 21:40:32 +0200
Message-Id: <20230101194034.831222-19-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
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

