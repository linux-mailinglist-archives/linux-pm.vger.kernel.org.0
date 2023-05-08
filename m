Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFEE6F9D05
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 02:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjEHAdV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 May 2023 20:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjEHAdR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 May 2023 20:33:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809893CD
        for <linux-pm@vger.kernel.org>; Sun,  7 May 2023 17:33:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f13ef4ad91so4485408e87.3
        for <linux-pm@vger.kernel.org>; Sun, 07 May 2023 17:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683505993; x=1686097993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1wI9viazUk4MMRKC5k2TgaknGOtp8xfB+NZ3J6gsmc=;
        b=nLabFqI7hTdKlm1IOb+KK/Nehh3xTJNzcDQ+59LuNs4UBVDgAMuVHD6O3FwUi0C2Kw
         u//lmqQoxDv0tmFklaKfIUeSVIU3QTgDXW1O0t+0WK2j7hYjhGEr32IdynKFzgg6xA/d
         ox7TAFbZnfAR/BwYozAG+ie/MFkatbzoYY4TETIrW4CK4RpdqvVQK5aXkRjWmvOprd+l
         AvIGMgQ3soKaSkCZ8le8wPBzRiAQLz/IjiJFy7plu6lq5cfhc+LLWE3zVABIqNz8O5c7
         UTXwT5mI+6R9KUIRxfQAzW4PIO+IV0t4N45hLwjeARiiwzniW/M6RyB/yMU4tKvuxyLH
         GvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683505993; x=1686097993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1wI9viazUk4MMRKC5k2TgaknGOtp8xfB+NZ3J6gsmc=;
        b=e+iPVq48/6wbr7E2nEVb8UB3ncdRwVStaChxxT9+ywIalUS2LQACsDHGOS80WSsX1R
         O8TRKt2RcnUVTAWzDOdxaAUhtTTe4fI8fqlXka1aAS1S7oIOLhFYSPwKU2+zehtV2Gqt
         xM2BLx87/KyJiW3yO4zTlfWg0mRVGB1gzsUgo2Kr2YIy1e19MNjmN4Akn0O/pn0V9F2m
         WrhhsinrO8EBe8UmY8THEMDklKLs+YmzXF3WaHErhpGHvrGe57DL7DBkdINfB2LfHJUg
         5N94hgfBsaNH40ETi7o4T+kzDlwjubtFf65dFr+t5iTU4LIMiu6ZcjulEWPcZQoJfjf8
         WJ0g==
X-Gm-Message-State: AC+VfDwDRczOU1DP9cq+gBdEXrYw4QZTFKloHOmm0vwqWLiidAZ6A+AH
        S33Rk6EVls39Vgo+nWllyRnXzpNoImenalyNvSU=
X-Google-Smtp-Source: ACHHUZ6/q1j48+E9petP95PUM7S1AuOFAS4TsIXUxGaajCHK9jzPr1hWaEAujUmJR7acyKn2NLQrow==
X-Received: by 2002:ac2:4428:0:b0:4ef:f670:3bd with SMTP id w8-20020ac24428000000b004eff67003bdmr2115844lfl.18.1683505993013;
        Sun, 07 May 2023 17:33:13 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id m22-20020ac24256000000b004eca2b8b6bdsm1114807lfl.4.2023.05.07.17.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 17:33:12 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/6] ARM: dts: qcom: apq8074-dragonboard: add resin and gpio keys
Date:   Mon,  8 May 2023 03:33:07 +0300
Message-Id: <20230508003309.2363787-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508003309.2363787-1-dmitry.baryshkov@linaro.org>
References: <20230508003309.2363787-1-dmitry.baryshkov@linaro.org>
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

Add device nodes for resin (reset, volume-down) and gpio-keys
(volume-up, general key) device nodes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../arm/boot/dts/qcom-apq8074-dragonboard.dts | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 72f7e09a5bbf..2017bdf81677 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include "qcom-msm8974.dtsi"
 #include "qcom-pm8841.dtsi"
 #include "qcom-pm8941.dtsi"
@@ -20,6 +22,26 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&msm_keys_default>;
+
+		button-volup {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;
+		};
+
+		button-general {
+			label = "General";
+			linux,code = <KEY_PROG1>;
+			gpios = <&pm8941_gpios 23 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	reserved-memory {
 		mpss_region: mpss@ac00000 {
 			reg = <0x0ac00000 0x2500000>;
@@ -90,6 +112,25 @@ &mdss {
 	status = "okay";
 };
 
+&pm8941_gpios {
+        msm_keys_default: pm8941-gpio-keys-state {
+                pinconf {
+                        pins = "gpio5", "gpio23";
+                        function = "normal";
+                        input-enable;
+                        drive-push-pull;
+                        bias-pull-up;
+                        qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+                        power-source = <PM8941_GPIO_S3>; /* 1.8V */
+                };
+        };
+};
+
+&pm8941_resin {
+	status = "okay";
+	linux,code = <KEY_VOLUMEDOWN>;
+};
+
 &pm8941_wled {
 	qcom,cs-out;
 	qcom,switching-freq = <3200>;
-- 
2.39.2

