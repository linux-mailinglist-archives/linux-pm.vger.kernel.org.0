Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E836FB4A6
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjEHQFC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjEHQEz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:04:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A68759D8
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:04:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f139de8cefso28658755e87.0
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683561892; x=1686153892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnmYe/rfjlFDwKC2E96nnEEwnllE4sqeDHA7mWjMQiY=;
        b=cmp37D61hWml6a51Z27nYwA4HADUospjypZtS0cEKwgfVX+5fJGJJ3VOH/nlVOYHPZ
         OjkdFNS/LvKPaJeOzmhwBH49RCIEPqfdX/1i895RQfY/pnSEVt5BcTeuqHrIOyc/ytuc
         s/Xiz3WWiCFQa9uMvntLX4I37mAFS/Gnhk5B83xD35YHzbglM6ukVEpXP4rWp+0i4y6x
         vsae/NEEa04MVlS8C+XbDKpq7KmCsQsrXhJUA1ornTgzp2ItrUOPZO9T3ioBcvIG+s8f
         +mkPwtMqCoAUVEU9B3BNdJau+hIJ/v1GcPJAN11lhcrLCm0ndv3cMsqUt0VsRkRgIns8
         Ic0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683561892; x=1686153892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnmYe/rfjlFDwKC2E96nnEEwnllE4sqeDHA7mWjMQiY=;
        b=Fq0P90nmszAwAjcrkkhG7u3a7IvXcYjLUQUDjHj+dDU/F3BqZvL9yqy+XUcSan+Hrk
         4ODwlugAhQIVwilY2qHEWfjHvb5OZhoEvKJgkK7CWhKfT84drpvh8kokw0PBNrPW0bYM
         QZWdtonXiPdgpluvXJbMzqhFxXzKP91gJ5Q64HN/FGWFEhez2r6wTcz7wAADm/zoo9ai
         iCGyCU7blrdSW+0Pue2/qRnuxQiW+Xj2zJGKjuJlTEmgJf6aP0Xkgjm8tUp/2me55C7v
         SCO2QfqD8P3o9KZbWIaYBjjxDqH9GdsMMGnsdoNsD+epSrFJpKhy6X20eyZQ+1N6qgAt
         lsbg==
X-Gm-Message-State: AC+VfDxgTv9v97jQQkhHm5vyHNLhG2sxa50/ryXRkxPn4EJoXiGusZ3m
        jAYff505W7cYOINZo1fHIvzf3GR6VmFOTyIC344=
X-Google-Smtp-Source: ACHHUZ55UN8LocS9K5LB+b6IEOtnUml9blYqaysfVDqZ0xzxCIa6A3ORKmaMdJPH0sxE7WfahSlYXg==
X-Received: by 2002:ac2:4c36:0:b0:4f1:4a5f:8595 with SMTP id u22-20020ac24c36000000b004f14a5f8595mr2106021lfq.15.1683561892555;
        Mon, 08 May 2023 09:04:52 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id h3-20020ac25963000000b004eff4ea8dd3sm32372lfp.76.2023.05.08.09.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:04:51 -0700 (PDT)
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
Subject: [PATCH v2 4/6] ARM: dts: qcom: apq8074-dragonboard: add resin and gpio keys
Date:   Mon,  8 May 2023 19:04:44 +0300
Message-Id: <20230508160446.2374438-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
References: <20230508160446.2374438-1-dmitry.baryshkov@linaro.org>
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
 .../arm/boot/dts/qcom-apq8074-dragonboard.dts | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 1345df7cbd00..630180edecfd 100644
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
@@ -17,6 +19,26 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-0 = <&msm_keys_default>;
+		pinctrl-names = "default";
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
 };
 
 &blsp1_uart2 {
@@ -35,6 +57,23 @@ eeprom: eeprom@52 {
 	};
 };
 
+&pm8941_gpios {
+        msm_keys_default: pm8941-gpio-keys-state {
+		pins = "gpio5", "gpio23";
+		function = "normal";
+		input-enable;
+		drive-push-pull;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+		power-source = <PM8941_GPIO_S3>; /* 1.8V */
+        };
+};
+
+&pm8941_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &rpm_requests {
 	regulators-0 {
 		compatible = "qcom,rpm-pm8841-regulators";
-- 
2.39.2

