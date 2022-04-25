Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBDE50EBB3
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 00:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiDYWYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbiDYVbB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 17:31:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81448220CE
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 14:27:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m23so6737853ljb.8
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXxEWz9ph7hZzty+IVLu4r/Lu3ntcZ7V7lGeIzMptng=;
        b=J7LwFVdypzqqNGCQlbUPqJ6I+gWa1Q3AcFx9ax7yovcfzTh/TDP4OedEtffokKV+nk
         r7uOnbTuL3pi4rFmF09EK10JaJUxGHy/y+Ztw1a08pNtr+u8bTUvVou/p5cbHdeqQmE+
         1yrw5X9w5TzKlapzkI6vdaYsb/POXINlR9Hqd38DRAUuVhF1J5GAZiIcAbmVGsn7trYY
         mn4XBBio/5B0ZuNsgAxfc4EUkuDtI9Agv3Ktyh64J0SEfG5mvRnomzeKjkShtlcxJ2VR
         JETexRcWh1zizKxN/gjpOW6jx+FxovJAaDG8+bh1FUhYhifZRcywUX6FJ+Go+64IaIdv
         QBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXxEWz9ph7hZzty+IVLu4r/Lu3ntcZ7V7lGeIzMptng=;
        b=8Qk6ynWW8D9J3FHII1820POAPjv7OF1Gz2C7x0b2aTz8YAmRI1oqrdg/eMN//hEfv6
         /Nf6/h5xuqiBH3MuRrcGbUECIdA04zY3yKaoC1NmwvKRyRcm8jqQ2w5t0Cpz7Dh1ef4j
         A/xF4cjgPhvU26zo/qQjOd5OOxzan13BVC4W41O+GNv5kJfSbj0clS7mXfITcNME4yM6
         2ISQ2cupwrsKknF06btxuDN8fJm0XgaftWqTfjoBKBKw/fICZDge5QwDPZB57nErvVe8
         K8ntalSm2dl27twPjS7btpIfNJdlsaz7b71y4HQuyQ6PJyqL8Ocqt1cGRJuAG+UiDEO/
         rYpw==
X-Gm-Message-State: AOAM530aJgctgfLJ6I2zqUu5vOQ9PuzvTNH379jh+omr0e3HWysD+QCK
        WbAgJ576aZE3TRc5pq/jQFNDgNVHgmxQ3g==
X-Google-Smtp-Source: ABdhPJyQDQuDj/qKWJgepq6T0b+QMiTd0tOI4Iyd2PrajDxowUn7iKa1OPXNYyJlzxYVDvdaGw5mLg==
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id d18-20020a05651c089200b002499e230015mr12578480ljq.492.1650922074615;
        Mon, 25 Apr 2022 14:27:54 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l13-20020a19494d000000b0046ba0e38750sm1533314lfj.3.2022.04.25.14.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:27:54 -0700 (PDT)
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
Subject: [PATCH v3 2/3] arm: dts: qcom-apq8064: create tsens device node
Date:   Tue, 26 Apr 2022 00:27:49 +0300
Message-Id: <20220425212750.2749135-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425212750.2749135-1-dmitry.baryshkov@linaro.org>
References: <20220425212750.2749135-1-dmitry.baryshkov@linaro.org>
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

Create separate device node for thermal sensors on apq8064 platform.
Move related properties to the newly created device tree node.
This harmonizes apq8064 and ipq8064 device trees and allows gcc device
to be probed earlier by removing dependency on QFPROM nodes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a1c8ae516d21..389191ca5a69 100644
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
+			tsens: thermal-sensor {
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

