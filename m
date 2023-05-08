Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8216FB4AA
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjEHQFE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjEHQE4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:04:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D33259FC
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:04:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f14ec4efb0so3170780e87.2
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683561893; x=1686153893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9HN1H558PhfKYKfm5BiqgL21021Q6dT3PuvuWu0KWM=;
        b=iLpng3WcqMQNlVNEqhZ4dCAeWemAv+iJDE7RAguDue7qX0RWa2MZlXhrRoVamcdYXW
         VSFQ4iqKqYUK1BdRHmKmTlgpA6+UZPepC1ZVByB1wkt0pBsAorsKElpV1/2SUMKecTCV
         FxQMOAXZevACc7ZH3XH+CpxpJ4Ml2DcQllL3mLcSWP7jB3pIYKehm9YZUNyCJ9mUtjSj
         zFEDj5wrpW+iSnCQ/kd33MpPDIyW2UeeYthKDm7FY3HYTIKx/Y0QUO9I30sjFvlgskxb
         dMz610GjuwxeFxTAwWi6Q63/0D74UFOhO0c51wEjBNUFXpgdWepQNc0JMrkvH+IuwBwW
         25xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683561893; x=1686153893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9HN1H558PhfKYKfm5BiqgL21021Q6dT3PuvuWu0KWM=;
        b=RgzGE3vFkFAQUjtO4MQEEX0Qf/aFTRO8di376zh+dkwkBHtEj8zzDJtV9InfwhGlFN
         eAVM7OF10b1Qchto/UqjzbA4zr1DSg+u5sD2rRLBTDb8EZyJympahYEQ6STD5Q7zUkrN
         rTbJgKVDiByLjItri70grr7x+Q0IPetdBzBboQ+BJWx3g4VcQpMjAOp4ALo6P4Hih6/Z
         46yhUv9As1/5dww+OEH58dybMmRLGgiUi1HyV6ADoqBvXc4zFtJHq86P4xfxkNLe8giZ
         fFbdCw7HrQ5odDRGaPMVGckGQpMVOd5M4D5Xng0APNHsD/eunD+UMXEPqog2xDa7C6Vr
         OU6w==
X-Gm-Message-State: AC+VfDxaYtQAiHcLJPgpC+JdAzpkvjgrGKkX/OcCPtN10AYmQ+AXF17b
        /hXJH0ZiXpSqv6A6e64uZ9lXmQ==
X-Google-Smtp-Source: ACHHUZ7o3rILQZjtyfFGkXWHXnPp7L5F+dvYR/1OTkcyTvfZjoKIhEaUxgt0oVpr8ZFW3WVJUbAk6Q==
X-Received: by 2002:ac2:5399:0:b0:4f0:c0c:36d9 with SMTP id g25-20020ac25399000000b004f00c0c36d9mr2419614lfh.12.1683561893543;
        Mon, 08 May 2023 09:04:53 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id h3-20020ac25963000000b004eff4ea8dd3sm32372lfp.76.2023.05.08.09.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:04:52 -0700 (PDT)
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
Subject: [PATCH v2 5/6] ARM: dts: qcom: apq8074-dragonboard: add onboard leds
Date:   Mon,  8 May 2023 19:04:45 +0300
Message-Id: <20230508160446.2374438-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
References: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dragonboard as three LEDs: red, green and blue. Add corresponding
description.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../arm/boot/dts/qcom-apq8074-dragonboard.dts | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 630180edecfd..07db6451f273 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include "qcom-msm8974.dtsi"
 #include "qcom-pm8841.dtsi"
@@ -69,6 +70,29 @@ msm_keys_default: pm8941-gpio-keys-state {
         };
 };
 
+&pm8941_lpg {
+        qcom,power-source = <1>;
+	status = "okay";
+
+	led@5 {
+		reg = <5>;
+		color = <LED_COLOR_ID_BLUE>;
+		function = LED_FUNCTION_INDICATOR;
+	};
+
+	led@6 {
+		reg = <6>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_INDICATOR;
+	};
+
+	led@7 {
+		reg = <7>;
+		color = <LED_COLOR_ID_RED>;
+		function = LED_FUNCTION_INDICATOR;
+	};
+};
+
 &pm8941_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
-- 
2.39.2

