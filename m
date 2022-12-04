Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA89641B01
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 06:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLDF7f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 00:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiLDF7Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 00:59:24 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23191AF35
        for <linux-pm@vger.kernel.org>; Sat,  3 Dec 2022 21:59:22 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id x6so9941191lji.10
        for <linux-pm@vger.kernel.org>; Sat, 03 Dec 2022 21:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgEl1QgJAnir83j0OfRdnDA9rDDVUEe3uvaK49+gggc=;
        b=HEiKXnxIP4jBSapp8XhacWKlr38B2iX2ojh7B/jiiJ/4J74u6eCD2ucvK89nWVV2dy
         cftqv3f9GEWSyqEg+eHK9C7wI/NPacOrSBhcZ0EtxvqeKmsJtB7uaAf15Bfr7HjpI3Z9
         ipGr6moksiNfrbmp7BhcxBUFXZDMgXBZbbCuUefRVQnnuWJF7/LTf9rNpPql40k70J9z
         xM7UBNhE9eSezen45RGjJuEqnV9XOYDgCLs0W3/ep08ve3mllfoLrMn8SztfW/yuWAOR
         czrrh1lz4zBO5CKyruk7n2UxjqpyOWGxQF9aua/yF+GbaWTCEC56UhS3Xt6+UUIuZ39c
         j3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgEl1QgJAnir83j0OfRdnDA9rDDVUEe3uvaK49+gggc=;
        b=iI/IgtKOylNLf2VgChM+JTLuUiDRkVQUDKNpTly+aWewy2JHHd7oXImoHZtJxhcz4B
         576B7P1HoDocgVX5Hn4Pd/VjF1ZNuAgdQt6LHuPQTQeIf9dQHDJ4Mc9KlINKwSbnYhbR
         RETRgz9UwxIW3I5wtHWXzT981Z53QquoOZdMudBjwAnnzrae41je1BtSxxLvgXRlOmMS
         d5wzgF17C5g+J/Q1YpbA7PwuDOM5A5+esgbb7hnkPKXZHcrHJ6XUKtSCzOOOJhc3TUhL
         2yewIt9Ct8jwpAURf+959LVYjqr+4kKPvG3L1qYEwmm/SNzFQWuAd3jiEoQa4Fp10vbj
         mNdQ==
X-Gm-Message-State: ANoB5pmJIu90rhmOywNMIoXRkdK/5Slw0O9JYAiJgQEYwODcriOqvYkQ
        yGqzH9oBglhGy8X7KKhKAb9mQg==
X-Google-Smtp-Source: AA0mqf4gdbSLH1Sjh/VzCARbpwx7kS3XiMU9AGq3+5RuV1sEqYAAxcueAuWAREOH+T2SPVX6I67PFQ==
X-Received: by 2002:a2e:bd17:0:b0:277:50a:bd5c with SMTP id n23-20020a2ebd17000000b00277050abd5cmr24251389ljq.6.1670133560990;
        Sat, 03 Dec 2022 21:59:20 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004917a30c82bsm1650028lfo.153.2022.12.03.21.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 21:59:20 -0800 (PST)
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
Subject: [PATCH v2 13/15] arm64: dts: qcom: qcs404: specify per-sensor calibration cells
Date:   Sun,  4 Dec 2022 07:59:07 +0200
Message-Id: <20221204055909.1351895-14-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
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

