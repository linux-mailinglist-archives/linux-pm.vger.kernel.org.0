Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368A4658902
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiL2DBl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiL2DBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626A12741
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:21 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf42so25931067lfb.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKkMnuQ5SojDaY5hYIWgCCfvVjdyKx2GWzmqbTIcADY=;
        b=G0DEPIdHUs2w91vxcuYrzJucK4SKkER6MX33KrgCLLAajKa8O6uA2h+whEOFD+1CUf
         z9oL3Fxxnjc+JogjJlFLKqY7jqjVbzx5RUBjx41DwWxx7yTB1s6IJzDmP+aH8rMGmeqI
         MVgVHTaJWF2XGL0I1V/MdcRnmb9nZRloE5/I41a6Wd8MVfQy2Q5dre5W/WtowZ+HR5LY
         1wy2rWaObJxn74YNYbiqqsSoQxtceOZZdEPRdmGJmQQNdQfm/N3f2BrNIq27FOgJgSxO
         tU6ezbBnRxHiWgYJafU1nRPwWjsgCSWEoyF5wHxnvZPunlcF0f1E2JXxfG/SYXOQ+Xn1
         F9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKkMnuQ5SojDaY5hYIWgCCfvVjdyKx2GWzmqbTIcADY=;
        b=wyTwkh6vZDjoqctkDTP3q4wYAW48XMwzg59XTcn2M89KPKxbq9hCaeq5WMf020pNAe
         mV8A3EIRb9UtzKmqvg1Okd0astztKu2Rm1GUkgzjsSAJwitd2fQsmWFfYzNQzzlwYcnB
         wZSC951wCoIKIz/GHtfX7rehZKCY9lPW1c+u59Wah+AKCcA+Ts4b6kBx57kxzqvaLGI/
         WPiMtPxenlO8FYB59GsbxVs0wgfZzR8FcZJI0Et8uxK17y/jWvbQ5O7g5BHCd4AuL3Xb
         06ZqbboBIKHruVBKZEuwQNNxcrQ4DalU9K8YQ+NjXcffI5MRAotza7RNwvJiZH6bqNj0
         9kew==
X-Gm-Message-State: AFqh2ko5lv+Y8VZMnOZgoCRGNKtVGpQzPcDrfi52DVHP0kxl3Ub4xX+e
        TslbeaGl5SsFepi4rjrMUA9btg==
X-Google-Smtp-Source: AMrXdXuKDiQ27gfhgx4T8WY5sY+U3o6Fljsn/pTIeA7oUaDZBx9sZ42elYgeNogCRnjwMgCja9p7rw==
X-Received: by 2002:a05:6512:708:b0:4ca:f992:6a1d with SMTP id b8-20020a056512070800b004caf9926a1dmr8118428lfs.69.1672282881298;
        Wed, 28 Dec 2022 19:01:21 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:20 -0800 (PST)
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
Subject: [PATCH v5 16/20] arm64: dts: qcom: msm8916: specify per-sensor calibration cells
Date:   Thu, 29 Dec 2022 05:01:02 +0200
Message-Id: <20221229030106.3303205-17-dmitry.baryshkov@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 85 +++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 2ca8e977fc2a..2ae21c5ade03 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -442,11 +442,70 @@ qfprom: qfprom@5c000 {
 			reg = <0x0005c000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			tsens_caldata: caldata@d0 {
-				reg = <0xd0 0x8>;
+
+			tsens_base1: base1@d0 {
+				reg = <0xd0 0x1>;
+				bits = <0 7>;
+			};
+
+			tsens_s0_p1: s0-p1@d0 {
+				reg = <0xd0 0x2>;
+				bits = <7 5>;
+			};
+
+			tsens_s0_p2: s0-p2@d1 {
+				reg = <0xd1 0x2>;
+				bits = <4 5>;
+			};
+
+			tsens_s1_p1: s1-p1@d2 {
+				reg = <0xd2 0x1>;
+				bits = <1 5>;
+			};
+			tsens_s1_p2: s1-p2@d2 {
+				reg = <0xd2 0x2>;
+				bits = <6 5>;
+			};
+			tsens_s2_p1: s2-p1@d3 {
+				reg = <0xd3 0x1>;
+				bits = <3 5>;
+			};
+
+			tsens_s2_p2: s2-p2@d4 {
+				reg = <0xd4 0x1>;
+				bits = <0 5>;
+			};
+
+			// no tsens with hw_id 3
+
+			tsens_s4_p1: s4-p1@d4 {
+				reg = <0xd4 0x2>;
+				bits = <5 5>;
+			};
+
+			tsens_s4_p2: s4-p2@d5 {
+				reg = <0xd5 0x1>;
+				bits = <2 5>;
+			};
+
+			tsens_s5_p1: s5-p1@d5 {
+				reg = <0xd5 0x2>;
+				bits = <7 5>;
 			};
-			tsens_calsel: calsel@ec {
-				reg = <0xec 0x4>;
+
+			tsens_s5_p2: s5-p2@d6 {
+				reg = <0xd6 0x2>;
+				bits = <4 5>;
+			};
+
+			tsens_base2: base2@d7 {
+				reg = <0xd7 0x1>;
+				bits = <1 7>;
+			};
+
+			tsens_mode: mode@ec {
+				reg = <0xef 0x1>;
+				bits = <5 3>;
 			};
 		};
 
@@ -473,8 +532,22 @@ tsens: thermal-sensor@4a9000 {
 			compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
 			reg = <0x004a9000 0x1000>, /* TM */
 			      <0x004a8000 0x1000>; /* SROT */
-			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
-			nvmem-cell-names = "calib", "calib_sel";
+
+			// no hw_id 3
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>, <&tsens_base2>,
+				      <&tsens_s0_p1>, <&tsens_s0_p2>,
+				      <&tsens_s1_p1>, <&tsens_s1_p2>,
+				      <&tsens_s2_p1>, <&tsens_s2_p2>,
+				      <&tsens_s4_p1>, <&tsens_s4_p2>,
+				      <&tsens_s5_p1>, <&tsens_s5_p2>;
+			nvmem-cell-names = "mode",
+					   "base1", "base2",
+					   "s0_p1", "s0_p2",
+					   "s1_p1", "s1_p2",
+					   "s2_p1", "s2_p2",
+					   "s4_p1", "s4_p2",
+					   "s5_p1", "s5_p2";
 			#qcom,sensors = <5>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow";
-- 
2.39.0

