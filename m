Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F644F5640
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 08:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiDFFiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 01:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577539AbiDFEQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 00:16:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54122B519C
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 17:26:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h11so1173134ljb.2
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 17:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TglhxcqR03STbzjibn+QFjr2IBk8TX9fGS7Is5dPqiA=;
        b=VSOqfRZSyi2bDhEqMpwfhmUTxSpO93QuNf1r2r1kA8vmU1PFcwGo+5dcE1XmU8vDZr
         0VXJjErh2A4aB/N5wyqkJOD29EU0WIzLOdkfb0O4Z7679woH7vS1h7jwQkEWQpAbUV9W
         pKl/SseGLKhfsi+jq8P7CF94l/eRFT++tmbWGyN44JfaENT3ab80aYN51LlueeQq1Ptm
         +V6sqXG5ZU0nFjyHJY1r6VxaFXr9CaqPuOBMjiTr4GYiFv5GAjjDjmETbpThnaQyZkTs
         +T4TyUR21XW+d/8XJD63icnUkayvjQwtvs5OwHVaFNHgPdnd22De5Usm1JBN1nOBcXPE
         YgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TglhxcqR03STbzjibn+QFjr2IBk8TX9fGS7Is5dPqiA=;
        b=fA2zqYGI3lZZSEhkNPdZRlGxHanJU7yuO5XjEQjAiw/qmYxGb+IZDdDkWGd+E3lohb
         mcYrKN4DzYXmwGsZThmBXlPRrqgQ3l5C92OIlps82Fgbw0cpDuhfeE2x7LwrR9NAAQjO
         tklsGGpbwBVKiEBqxmL5Rk8HqNK3L0T020es3Pgl5ozuzW4MCZK/aR9xrT0PWNQkSgdU
         LEOzgmnaCiMANZIoMmsg5s9bdNjrDsYuqpg9EDfIXER6ih8uOkHcVkEOOigaVW7FnaaZ
         d+EEXBL79GOgd3y/La6RZKak0LJFvwCNvTv6nUnFfWKzztImELWQqy52tvmfI/CWtbTA
         7RUQ==
X-Gm-Message-State: AOAM530p6MMTS7W/on+eH7JcWamygmIPAUnIaHhgNyHQhUBLIJD3J/f0
        4zouTlKDnXfkNDF96lKzwJGk2w==
X-Google-Smtp-Source: ABdhPJzI/P+YX2UHUE6J2gC82zaz6t4+duksND2A3MAe65Wf5eLzAtmgNvF6Z1tG2I0qNw9uEzOSwQ==
X-Received: by 2002:a2e:82c5:0:b0:247:e81f:8b02 with SMTP id n5-20020a2e82c5000000b00247e81f8b02mr3684529ljh.90.1649204814030;
        Tue, 05 Apr 2022 17:26:54 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c21-20020a056512239500b0044aa21dadeasm1660270lfv.60.2022.04.05.17.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 17:26:53 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 4/4] arm: dts: qcom-apq8064: create tsens device node
Date:   Wed,  6 Apr 2022 03:26:48 +0300
Message-Id: <20220406002648.393486-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406002648.393486-1-dmitry.baryshkov@linaro.org>
References: <20220406002648.393486-1-dmitry.baryshkov@linaro.org>
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

Create separate device node for thermal sensors on apq8064 platform.
Move related properties to the newly created device tree node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index b9e9a9f9d3e2..40c65c921f96 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -105,7 +105,7 @@ cpu0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&gcc 7>;
+			thermal-sensors = <&tsens 7>;
 			coefficients = <1199 0>;
 
 			trips {
@@ -126,7 +126,7 @@ cpu1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&gcc 8>;
+			thermal-sensors = <&tsens 8>;
 			coefficients = <1132 0>;
 
 			trips {
@@ -147,7 +147,7 @@ cpu2-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&gcc 9>;
+			thermal-sensors = <&tsens 9>;
 			coefficients = <1199 0>;
 
 			trips {
@@ -168,7 +168,7 @@ cpu3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&gcc 10>;
+			thermal-sensors = <&tsens 10>;
 			coefficients = <1132 0>;
 
 			trips {
@@ -810,14 +810,23 @@ tsens_backup: backup_calib {
 		};
 
 		gcc: clock-controller@900000 {
-			compatible = "qcom,gcc-apq8064";
+			compatible = "qcom,gcc-apq8064", "syscon";
 			reg = <0x00900000 0x4000>;
-			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
-			nvmem-cell-names = "calib", "calib_backup";
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
-			#thermal-sensor-cells = <1>;
+
+			tsens: thermal-sensor@900000 {
+				compatible = "qcom,msm8960-tsens";
+
+				nvmem-cells = <&tsens_calib>, <&tsens_backup>;
+				nvmem-cell-names = "calib", "calib_backup";
+				interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "uplow";
+
+				#qcom,sensors = <11>;
+				#thermal-sensor-cells = <1>;
+			};
 		};
 
 		lcc: clock-controller@28000000 {
-- 
2.35.1

