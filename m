Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FDD50FA0F
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 12:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348655AbiDZKUQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 06:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348662AbiDZKSH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 06:18:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9BD13661D
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 02:41:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w19so30893185lfu.11
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 02:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXxEWz9ph7hZzty+IVLu4r/Lu3ntcZ7V7lGeIzMptng=;
        b=E2/HluKgyiXLdYDOfyHAwmCOrwxVIALwLVbKlkUwybwaWhxG3LMJSEBcvxOnhFoTzO
         xBQ6LdB0XjW6T5nRyOnD/xI0bqmF91VSknBrvxcthquxT+aWVH31JiuIeawtmenTx19P
         OTsutZW0a9fGyaNlpl9abIZPaEJUCrwsG9boAJ8Cxp1ZUjIsSDuj6unKFv7+xxIXXf66
         iUt0jbtAMQDBXkVGCTrLlJ5JVYFns0VnbhbeJYKAyAIdDBr1vLmd8ydiV/VcighzftXz
         eqvP0MYWjwB4r5q25bxp32ZbxCw9oyAqUOXYaezEE/Ot/hZoOXEfea/btqCErcPMEhNp
         lecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXxEWz9ph7hZzty+IVLu4r/Lu3ntcZ7V7lGeIzMptng=;
        b=qKbJog//AY9snDpxUCBFLeDG+aYhrSXRfR9xWOo1tVGb6V2wicUEuMthtsdMOf4CoJ
         ITqoLBSwopqL0VAvlbeUuVWQocVkfKVIRUz1cIFI6pKeuAEdbsIqjbfgGyQO6kPgAABK
         qTD7C5r7Y0Pu6i8CKUm8Ryg3UTeRC1mxSkYxdDA2lVmf7iHP6ELBbtDM9ZnzSEsojfGT
         lYDLLXtyO6OhJj+3igXWqI2YPjgV2yTOp5rjkC0J2FM8c3Ncp4MwMG5+oQZgFLbaPjET
         NDhN7rQgF4S0yy+mknlqalA7dY0u0TEpE6bhT2mOgCcJxvrdRzwPT2lffLbUTpaKjkA9
         20ew==
X-Gm-Message-State: AOAM532dJ61gJzO8IYeg3WIQorBM9B6vTDN0N3RawLcfNRHu65gXsuyu
        iz9DqgM8sezrsITej+8YVRSjQw==
X-Google-Smtp-Source: ABdhPJx560TnpZorQwQp+vKzzMme+Q/ceGs74CziC3q96vrIc2i+zuav7ucgFyWa7lFsEX+rb5AgkQ==
X-Received: by 2002:a05:6512:2311:b0:472:c48:5b3b with SMTP id o17-20020a056512231100b004720c485b3bmr5250125lfu.159.1650966109269;
        Tue, 26 Apr 2022 02:41:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([188.162.64.30])
        by smtp.gmail.com with ESMTPSA id y28-20020a19641c000000b00471f6806403sm1330117lfb.16.2022.04.26.02.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:41:48 -0700 (PDT)
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
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_tdas@quicinc.com
Subject: [PATCH v4 2/3] arm: dts: qcom-apq8064: create tsens device node
Date:   Tue, 26 Apr 2022 12:41:43 +0300
Message-Id: <20220426094144.2958416-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426094144.2958416-1-dmitry.baryshkov@linaro.org>
References: <20220426094144.2958416-1-dmitry.baryshkov@linaro.org>
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

