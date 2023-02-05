Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE0A68B096
	for <lists+linux-pm@lfdr.de>; Sun,  5 Feb 2023 16:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBEP2S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Feb 2023 10:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBEP2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Feb 2023 10:28:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D58A1C32E
        for <linux-pm@vger.kernel.org>; Sun,  5 Feb 2023 07:28:15 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cw4so9344138edb.13
        for <linux-pm@vger.kernel.org>; Sun, 05 Feb 2023 07:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJQ4+vVVfIiwsqJL1jHVf4HQJXzmpL5PhIiluvXpcdo=;
        b=Bjz8RFUufYfaamOoUqHuiXfogDYCabOM6GHy9aUGVz5PEiEBwcT5Ih5VyDJ6/7rDa8
         vcY/LKeEUdRnDdYlHMIVqmdjoDfLQlaFaGQ5l5nYUxPHiHbkgrMH3tsSX8m8sdDbmQF4
         +nvRcb70WLGWv+F9Vg4LLf7+m72z+FtGe6RUyJ5J0+D6+m7pXxVDJGoZlOKK+qS/A0OH
         2WxewonLu6apqnQ7M+CUkJa2/OghIZPMqKwf7WDhHnirvp//gF9hI/gZMQrJdnNIGmFo
         tQvHrHYf0oiYpf3oXYUi7XJJiLaLwf3r2T+BjFeNqCqE+DESGcQWJLzJEFSUJuPJ4Eo8
         72Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJQ4+vVVfIiwsqJL1jHVf4HQJXzmpL5PhIiluvXpcdo=;
        b=vdrmZNC7XjXVDeyIUBFUEMS/6ClFlPgIlyAttvMwnYtDUYbx/9G/J2pLy6WePMKdZ0
         WvUo9Z2aicwp6LMDzGLgbVTSus/PKieFQTA3VHkfcSGnubqW+5AssEYbTzhT36hMhGYk
         NAiVeD9Ce2U+RDARYQbugHjWCcLZpYJhj/ZFc7AmTDzHnJG/lx0uO8nu1DukHijFhigc
         d2YC6D889u/9qDOPLvbGepvpS98SibRgw5PBYGzcKEXXix6vH4xtJUKF4wKeUhPMi4rM
         /hUTooGUl8MyUH9qKU0fVrOIG9v/zqOCoHpjyCdUtO/zTIOMGUuHKiXhPSq+rsORbShY
         uNKQ==
X-Gm-Message-State: AO0yUKXBXSm1pWscmDVTiMTTxGILjaiOiXd5rU8dW2d86hgTwZG4SYI/
        q8W3jILDojXRn8rswpq9jSKklA==
X-Google-Smtp-Source: AK7set+3Fb2EMnrFZahVqGbiiGODshvsphyuVVjKZvXkTiIi5E8gMj2Yjnn4h0MWpYSdYKSZsk4J7g==
X-Received: by 2002:a50:a41a:0:b0:4aa:abe2:7d01 with SMTP id u26-20020a50a41a000000b004aaabe27d01mr2042806edb.36.1675610893808;
        Sun, 05 Feb 2023 07:28:13 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id fg10-20020a056402548a00b004a23558f01fsm3889178edb.43.2023.02.05.07.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 07:28:13 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: c630: Add Embedded Controller node
Date:   Sun,  5 Feb 2023 17:28:09 +0200
Message-Id: <20230205152809.2233436-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230205152809.2233436-1-dmitry.baryshkov@linaro.org>
References: <20230205152809.2233436-1-dmitry.baryshkov@linaro.org>
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

From: Bjorn Andersson <bjorn.andersson@linaro.org>

The Embedded Controller in the Lenovo Yoga C630 is accessible on &i2c1
and provides battery and adapter status, as well as altmode
notifications for the second USB Type-C port.

Add a definition for the EC.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 7038a0f7c06e..cf56ce68081c 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -352,6 +352,33 @@ zap-shader {
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
+
+	embedded-controller@70 {
+		compatible = "lenovo,yoga-c630-ec";
+		reg = <0x70>;
+
+		interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ec_int_state>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "source";
+			data-role = "host";
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "source";
+			data-role = "host";
+		};
+	};
 };
 
 &i2c3 {
@@ -652,6 +679,14 @@ mode_pin_active: mode-pin-state {
 		input-enable;
 		bias-disable;
 	};
+
+	ec_int_state: ec-int-state {
+		pins = "gpio20";
+		function = "gpio";
+
+		input-enable;
+		bias-disable;
+	};
 };
 
 &uart6 {
-- 
2.39.1

