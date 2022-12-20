Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93165191C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 03:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiLTCrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 21:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiLTCri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 21:47:38 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D29C13D3B
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j4so16668882lfk.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgEl1QgJAnir83j0OfRdnDA9rDDVUEe3uvaK49+gggc=;
        b=NyhANU/vD+kOWN1PNpwYBayZ/Sh1AODhEWks1KC+bQ9+SDiL3N1mwq/oKhU6zD0er8
         CzjxKsx4ImwQSex/H+hQl44bPADhvu9RqcqsJqZHfmsoWDoGE6OezKCtdb3PnmvjI3Gq
         CeoUzU1c505LvcR1Ea8IH1Wy5TUGVpXM4tBA1wA89sA3oaRvaigh9pE0KrdTYJ9kW+NM
         x7PNNZjdVCI5v+6WOmxwDPkjfWUGlciyUSztauNmB2qh0cOFcUef7bahfu/VhtJNTRZV
         xakA94iPcokWVj16YCACMBg1xHDSyEdct1u4v3dd/wmaQmDZmP9bnfGqERsogkN4NqSE
         40gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgEl1QgJAnir83j0OfRdnDA9rDDVUEe3uvaK49+gggc=;
        b=NZHqX3GGE8TxIvttdYeM09qBhRGA5jIGqOEXI2F5ynLchpYvhy+eToHXOQsATZYNO1
         LN6M+fwPNiUU+hVsb4NtwUvF9W+9cCIHc+fm0b4RErpzB3y8gj6MH/G2wk5LU5z7VIkM
         YMTFkotfMUF7c7HFi7y5MFXxCAU3MM09voqAqj3xP/pybgjPEraaz+xc7jzRIT+DBrHs
         GQjsmaswSvUbtACKIgHAjEZJ40tcq7ntS5ZfCAQj5b6T9Y4nSSI2yGlZs41KfleAf2zj
         uCP2v8ObEqmC+7GjBLGmouFDatHYu/QVLTbPhAtrCrar8mUKSJnY6NRZJtFR20IKW5C3
         U6tA==
X-Gm-Message-State: AFqh2kpWZdTCj6J8DvdqIa6Hgis4PttrCtrt2Jy/awjK7zupBh+ljEuC
        a4Unzrhs0r+cvKMUhr5oTsiJfw==
X-Google-Smtp-Source: AMrXdXu30Sf4ANVp9Rh+LDEk6VdRX/6hioF7y862fAl+kCMtMNXPIkYlPWUTdbmUqBUAB6YjqyzMXQ==
X-Received: by 2002:a05:6512:3d26:b0:4bb:710e:bf8 with SMTP id d38-20020a0565123d2600b004bb710e0bf8mr7353173lfv.16.1671504454654;
        Mon, 19 Dec 2022 18:47:34 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1274866lfs.252.2022.12.19.18.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:47:34 -0800 (PST)
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
Subject: [PATCH v3 13/15] arm64: dts: qcom: qcs404: specify per-sensor calibration cells
Date:   Tue, 20 Dec 2022 04:47:19 +0200
Message-Id: <20221220024721.947147-14-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Specify pre-parsed per-sensor calibration nvmem cells in the tsens
device node rather than parsing the whole data blob in the driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 121 +++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index a5324eecb50a..362764347006 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -366,13 +366,102 @@ qfprom: qfprom@a4000 {
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
+			tsens_s0_p1: s0_p1@1f8 {
+				reg = <0x1f8 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s0_p2: s0_p2@1f8 {
+				reg = <0x1f8 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s1_p1: s1_p1@1f9 {
+				reg = <0x1f9 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s1_p2: s1_p2@1fa {
+				reg = <0x1fa 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s2_p1: s2_p1@1fb {
+				reg = <0x1fb 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s2_p2: s2_p2@1fb {
+				reg = <0x1fb 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s3_p1: s3_p1@1fc {
+				reg = <0x1fc 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s3_p2: s3_p2@1fd {
+				reg = <0x1fd 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s4_p1: s4_p1@1fe {
+				reg = <0x1fe 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s4_p2: s4_p2@1fe {
+				reg = <0x1fe 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s5_p1: s5_p1@200 {
+				reg = <0x200 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s5_p2: s5_p2@200 {
+				reg = <0x200 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s6_p1: s6_p1@201 {
+				reg = <0x201 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s6_p2: s6_p2@202 {
+				reg = <0x202 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s7_p1: s7_p1@203 {
+				reg = <0x203 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s7_p2: s7_p2@203 {
+				reg = <0x203 0x2>;
+				bits = <6 6>;
+			};
+			tsens_s8_p1: s8_p1@204 {
+				reg = <0x204 0x2>;
+				bits = <4 6>;
+			};
+			tsens_s8_p2: s8_p2@205 {
+				reg = <0x205 0x1>;
+				bits = <2 6>;
+			};
+			tsens_s9_p1: s9_p1@206 {
+				reg = <0x206 0x1>;
+				bits = <0 6>;
+			};
+			tsens_s9_p2: s9_p2@206 {
+				reg = <0x206 0x2>;
+				bits = <6 6>;
+			};
+			tsens_mode: mode@208 {
+				reg = <0x208 1>;
+				bits = <0 3>;
+			};
+			tsens_base1: base1@208 {
+				reg = <0x208 2>;
+				bits = <3 8>;
+			};
+			tsens_base2: base2@208 {
+				reg = <0x209 2>;
+				bits = <3 8>;
+			};
 			cpr_efuse_quot_offset1: qoffset1@231 {
 				reg = <0x231 0x4>;
 				bits = <4 7>;
@@ -447,8 +536,30 @@ tsens: thermal-sensor@4a9000 {
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
2.35.1

