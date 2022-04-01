Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED004EFB90
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 22:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352352AbiDAU3R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 16:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352921AbiDAU27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 16:28:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA99154C
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 13:27:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o10so8230830ejd.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc3RgWHjY2p/tsxxVAzB8ba7RaDO2fJGXxeAES8PpOI=;
        b=SVDXGE3XLq/KSmiUjaRHGDcvUd3VB9aFLp9A1T1si6A8krWfqdKqir6M2mu2L5xx4E
         cOSz7Gel6JSYnZrp8yVgnCgd8mnAeJUkTOYeMTIKq8rvHUFWscg+IRDD4f5DBN7INWjD
         zc4kENwU21T2z75Qf1xYSuWUuu7X6aX99FQHN3tMQhXMZaq8Z72/0j1zZDEcZJIxddmr
         NFyF7a24MFPHrrTgahe2RoeJvGer28t23TTwUBYr3iHGlZxri+lScy5F/biQSuIjpQCa
         BWONqVqYX076Iezm4fzyGbRoJvGGG0wiBd0GN1zL+ZXsdMzNQiw5INMn+3vGq3zgib8+
         5R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc3RgWHjY2p/tsxxVAzB8ba7RaDO2fJGXxeAES8PpOI=;
        b=D2zsFI4FAq1lrFhgQbIefH1kwMmVulJlOpG5cDwkAU6M04DoppajKUbeq9CMG+HqeE
         ZvD+MdA4QISYSo40sX6FnqRjeeXBO8zG2o7pjcjvQTDul4vCuR2rtIEPnMsb2vheuBlS
         N7P6vO7rp28Yr+C/sWvQSpPijN8LtdBKDw7rgTCs32/Pns9DIpT3m32BDuzjzxI2MbBk
         /b6jdeAzQs7Zss0acLyns8clJVYd73y45zMDDGct4fgfOapldw0LvlA7uUuV1SK67+O5
         SJTiqQ5fL1+Pl0pItItujOl+6bsRSMXnDBLhIzcYkcgE+OFhRKAkHpOoT6zpjZVgA29y
         kfzw==
X-Gm-Message-State: AOAM530Dn/2ofxNS4kkn4lLCWQAUGgRKITUENmNJPxDS9Ggc2OEmFRH0
        Us2LPaMyAhqTiaLtx+uulqXOIA==
X-Google-Smtp-Source: ABdhPJyDR6JG5CgQmBI7+eKNve5VCFxxv8uRCv92S6bNXYY+dcQdSxM0K3PsMRQnCHLe0zmLr2jzrg==
X-Received: by 2002:a17:907:3da9:b0:6db:f3f:33c2 with SMTP id he41-20020a1709073da900b006db0f3f33c2mr1253083ejc.735.1648844826728;
        Fri, 01 Apr 2022 13:27:06 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm1619346edl.22.2022.04.01.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:27:06 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 2/6] arm64: dts: qcom: pmi8998: add smb2 node
Date:   Fri,  1 Apr 2022 21:26:39 +0100
Message-Id: <20220401202643.877609-3-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401202643.877609-1-caleb.connolly@linaro.org>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
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

Add a node for the smb2 charger hardware found on the pmi8998.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index da10668c361d..b98dad166a0b 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -9,6 +9,21 @@ pmi8998_lsid0: pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmi8998_smb2: smb2@1000 {
+			compatible = "qcom,pmi8998-smb2";
+			reg = <0x1000>;
+
+			interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "usb-plugin";
+
+			io-channels = <&pmi8998_rradc 3>,
+				      <&pmi8998_rradc 4>;
+			io-channel-names = "usbin_i",
+					   "usbin_v";
+
+			status = "disabled";
+		};
+
 		pmi8998_gpio: gpios@c000 {
 			compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.35.1

