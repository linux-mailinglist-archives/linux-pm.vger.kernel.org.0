Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6A5B4663
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIJMrQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 08:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIJMrO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 08:47:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044A3578BE
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m15so7230161lfl.9
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Xnrwle//1aq5NGhF/qMEZvbwwoMwpjLog3bunzgx6rM=;
        b=BVd/bJ7kuaUOUaXMcU3dQZTD6lIj6NGmKFCMIH5ED55WCea78YSjfASq9DfQcf6d1q
         /6JbDNWgopU84NuCLP0JLoEhzqTc9IMaD6z8XeVB2FxNvh27Djbo3U8/ymNglT8fV+44
         OQ+u9ZXS4ojSAuB0FuBdDY3HW6yodwsxcCuA6E2iaIZBgxO9cIuE7urMT8JD5pTB8vsj
         ZOFJtDQNTfWJBTpdNu9X607Xn8DaNfASia4uRZIz5Tlk8VgN19TWQFL6dgUfVGiNjFhi
         yUEOmGPLsFNGLPN2m9MPMwLrsMvJcMTKZ4JkxuAxLCwxXiX9myaZf8WozF3qFApWIKY1
         iIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Xnrwle//1aq5NGhF/qMEZvbwwoMwpjLog3bunzgx6rM=;
        b=t7sW5bbjxhxt6oRq66Sd+uq1bZNhAbClL6iBtjM+cVPRmXP4Daq+W2vVE4WF1bSkQv
         IMrAs6RlCZeV4K+iHEc75OmUFLStS09gveESPN/gK6g9GtlCb+j2OdA+12xrNcQynorj
         kfpZpaKnp/uicUD6NYBzmOm/wtUTzDjlx59/SFToMEVKsJhelQ9IBUaE8SUnsvLSgyQr
         P3rN++Q26YMQ/w0CT884TEWotkZjk4vZ4Tkv1BsczLQIPSFuElvFwWBhwr/zU8wVv0s5
         hVIxH/Ry5AvlCwQH6CEkqzdkMxZwCplNtEJhNsWscy76ieFdHme5+E/kABT6EE2RwVRr
         BUjA==
X-Gm-Message-State: ACgBeo0PcRqOwCScrOu6DRykI2yQVnRPGsO2ZiSlOr5rJUCvoFwuxRPc
        hrNAnMtH0UvgzMhajfIFj0WAyA==
X-Google-Smtp-Source: AA6agR6s148d4YerVeBrqBSEgZ0fxuXqADDlmf/69Y+9zvQwmWUbnDleLVGwNxVrSGTTZpEEJ4sVrw==
X-Received: by 2002:a05:6512:31cc:b0:494:6815:a81b with SMTP id j12-20020a05651231cc00b004946815a81bmr6365824lfe.511.1662814029971;
        Sat, 10 Sep 2022 05:47:09 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k14-20020a2e920e000000b002677a3ad1d9sm327463ljg.76.2022.09.10.05.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 05:47:09 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 09/10] arm64: dts: qcom: msm8916: specify per-sensor calibration cells
Date:   Sat, 10 Sep 2022 15:47:00 +0300
Message-Id: <20220910124701.4060321-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Specify pre-parsed per-sensor calibration nvmem cells in the tsens
device node rather than parsing the whole data blob in the driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 70 ++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 48bc2e09128d..d2cce8f75fb6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -442,11 +442,57 @@ qfprom: qfprom@5c000 {
 			reg = <0x0005c000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			tsens_caldata: caldata@d0 {
-				reg = <0xd0 0x8>;
+			tsens_base1: base1@d0 {
+				reg = <0xd0 0x1>;
+				bits = <0 7>;
 			};
-			tsens_calsel: calsel@ec {
-				reg = <0xec 0x4>;
+			tsens_s0_p1: s0_p1@d0 {
+				reg = <0xd0 0x2>;
+				bits = <7 5>;
+			};
+			tsens_s0_p2: s0_p2@d1 {
+				reg = <0xd1 0x2>;
+				bits = <4 5>;
+			};
+			tsens_s1_p1: s1_p1@d2 {
+				reg = <0xd2 0x1>;
+				bits = <1 5>;
+			};
+			tsens_s1_p2: s1_p2@d2 {
+				reg = <0xd2 0x2>;
+				bits = <6 5>;
+			};
+			tsens_s2_p1: s2_p1@d3 {
+				reg = <0xd3 0x1>;
+				bits = <3 5>;
+			};
+			tsens_s2_p2: s2_p2@d4 {
+				reg = <0xd4 0x1>;
+				bits = <0 5>;
+			};
+			tsens_s3_p1: s3_p1@d4 {
+				reg = <0xd4 0x2>;
+				bits = <5 5>;
+			};
+			tsens_s3_p2: s3_p2@d5 {
+				reg = <0xd5 0x1>;
+				bits = <2 5>;
+			};
+			tsens_s4_p1: s4_p1@d5 {
+				reg = <0xd5 0x2>;
+				bits = <7 5>;
+			};
+			tsens_s4_p2: s4_p2@d6 {
+				reg = <0xd6 0x2>;
+				bits = <4 5>;
+			};
+			tsens_base2: base2@d7 {
+				reg = <0xd7 0x1>;
+				bits = <1 7>;
+			};
+			tsens_mode: mode@ec {
+				reg = <0xef 0x1>;
+				bits = <5 3>;
 			};
 		};
 
@@ -473,8 +519,20 @@ tsens: thermal-sensor@4a9000 {
 			compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
 			reg = <0x004a9000 0x1000>, /* TM */
 			      <0x004a8000 0x1000>; /* SROT */
-			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
-			nvmem-cell-names = "calib", "calib_sel";
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>, <&tsens_base2>,
+				      <&tsens_s0_p1>, <&tsens_s0_p2>,
+				      <&tsens_s1_p1>, <&tsens_s1_p2>,
+				      <&tsens_s2_p1>, <&tsens_s2_p2>,
+				      <&tsens_s3_p1>, <&tsens_s3_p2>,
+				      <&tsens_s4_p1>, <&tsens_s4_p2>;
+			nvmem-cell-names = "mode",
+					   "base1", "base2",
+					   "s0_p1", "s0_p2",
+					   "s1_p1", "s1_p2",
+					   "s2_p1", "s2_p2",
+					   "s3_p1", "s3_p2",
+					   "s4_p1", "s4_p2";
 			#qcom,sensors = <5>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow";
-- 
2.35.1

