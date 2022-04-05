Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE434F5525
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 07:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiDFFcG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 01:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1851351AbiDFDDm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 23:03:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5F937037
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 16:59:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y32so1222077lfa.6
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsebzT0oQrb725QbvmQmdLGCPg2UaxczruLpvf9xIJ8=;
        b=nEzlP/Y5MWvuFOqwomUMzNMeA/Va+eKKfx9HVFAt1xnJSdqlTiKPo3wKxfrZoFmB5p
         179bIHxq3ijqXk+EVO+doWrxFNZZbBO86wpy2xNGVWdqMPlgnzEmRTUJ8ScGiSpoSrWP
         Anhsn+dHVQSC06lhw5jyljhvBajPfBwaiBzySJ5mo4GUDxWoFVQcapCHVlbHqUzUJJD7
         diClpHoqiCwEJfUcDuZiYO87OYFf5IYA1sRmhF8gCAZaS82Khq/yf/GW4fe8pjPe9mi/
         w/8zeU+1Jt1L8rAk6OzCDhwzlwRbGj7aqB7VeGhurvqu69bQaHI74xk+KVNTc+T2mYXo
         mdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsebzT0oQrb725QbvmQmdLGCPg2UaxczruLpvf9xIJ8=;
        b=j1Ftmh+7/62gP3PcwNQ/1QEQiGHuYe1LEXKsl0hTIdx/CAX0G8QUs8qTOxpgjntBGr
         0n1xwRSdO24xyTtv4i3DXyQeXuynERC5hQEh9kTjqZpvi5wE7k6H+unvoWjYJHAmj7c7
         Hlcphbf5CsgjK4jzqfdXGPDcU4SqyQ6c3PP5sak48JRi4xwoDbU42XU/M6S9jAd8Wzk4
         QjGWQjDEa2/6ROpf2vlpiL6+PUM/Tb9lTzmCtFJG+kG+ESU8WQVs0gXR5ZA4wzqO05Gp
         BdA4SJIWKRB8AB4weVRexBdIcxgbkqi6RQdkC624NMmJPAZJ3dwaHr6QssCkjOUj0j7U
         D8jQ==
X-Gm-Message-State: AOAM533bkzHCXRlxZF0cpKiX6BRo9vsgF5RcvkKE7evfbtBA0MjaIm2t
        BBs1KdG5AHYH/N8LQVNAViTCf5upEMVpgg==
X-Google-Smtp-Source: ABdhPJwi0L/OTO/Vf772gVlUgxAVowWOVkAO8aoGbTsia63tyHDt1Np2ZLlAMxuB24VrWMuzASrNMA==
X-Received: by 2002:a05:6512:3ca1:b0:44a:93f1:45cf with SMTP id h33-20020a0565123ca100b0044a93f145cfmr4362023lfv.542.1649203155487;
        Tue, 05 Apr 2022 16:59:15 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w14-20020a0565120b0e00b0044a9b61d2b3sm1646471lfu.221.2022.04.05.16.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 16:59:15 -0700 (PDT)
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
Subject: [PATCH 4/4] arm: dts: qcom-apq8064: create tsens device node
Date:   Wed,  6 Apr 2022 02:59:10 +0300
Message-Id: <20220405235910.373107-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405235910.373107-1-dmitry.baryshkov@linaro.org>
References: <20220405235910.373107-1-dmitry.baryshkov@linaro.org>
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

Create separate device node for thermal sensors on apq8064 platform.
Move related properties to the newly created device tree node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index b9e9a9f9d3e2..87e8861d647c 100644
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
@@ -812,12 +812,21 @@ tsens_backup: backup_calib {
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-apq8064";
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

