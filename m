Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C8A789DB5
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjH0LvV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjH0Lu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:50:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E87CDE
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500b3f7f336so1026536e87.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137048; x=1693741848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGL0BWRJKPfl8oger7j3JrfqT3+nXc/9EFQqXlrE5Ig=;
        b=QPgOAQIumn8IWNtnwbrmxegPRxzIXf/bCEdQVjz85Sy8RmLJeNxcrXpIYkQXFt/Yjr
         +mhFW4s0tsJg2YoTm+2Xqw+AvUufoA1tRhiPshQicm/MpMD5Kw4L1253Tj6c0Wd2w6mD
         V2acviL0t9rAehVMpRKEyYt+k7ksI95uEIn9VcmJuVpJFJHPidsm9xji8hpfnishrz9S
         WAYCu5FacM2pGFrIOXg2DsCIehEWBgSpwd+J8OHlY1kslMHyU8OgGXtBVbXuJAHjfJKv
         d8wOg1XNp1zcUhPkBGiXQ0I51JhYolLOLrqh00xDEHhGBse+s0f4DfIaDPCOTLxbRBja
         0dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137048; x=1693741848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGL0BWRJKPfl8oger7j3JrfqT3+nXc/9EFQqXlrE5Ig=;
        b=TqHKeTlXZDi0TepNcTDdne/OTLnXIWxeave8HfMgdJN3JmUywvwqHg9+7643+rP1l3
         vfaR5Oj0eAqLYO19VjuXxgAJIuTeZhATJ0Uh6SL4n0z3ThDvdEFTtxr1/B7/3E56OBli
         sNjmsRjXssNSz8KjutoQ7Otlkp7onFpZf6v1XPuYPQDxI64mdXBGi8PgwcsVkYZbbEae
         NlBZSJJYj/1anISxd5QjuTdO5CJZAnUTeTPyym3Zfk4oMVsDN7a17Djlp43ShF+H51zG
         C3xI8Xnf7UUIM+lGloGOTOa/Xndi9HDEhMrBVjtntMNqxpPFuIYUYziHsa+2OhJYMEwV
         b6oQ==
X-Gm-Message-State: AOJu0YyVOx0u+y26e0LkYoVlzNMI1sEmbamJwaHuZqaAuzwvZWBLYpLF
        uj2az8B1VGX+SQue+tj2LvfUHw==
X-Google-Smtp-Source: AGHT+IEL2U8FotRdtR+0JKbrKDc/HrSAwGHsKFfKUOe/JBFKtQwwvTjjHXf8Zt+r+f/AzI4NLQifRA==
X-Received: by 2002:a05:6512:2256:b0:500:808c:9ee6 with SMTP id i22-20020a056512225600b00500808c9ee6mr15671753lfu.6.1693137048073;
        Sun, 27 Aug 2023 04:50:48 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:47 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v4 16/23] ARM: dts: qcom: apq8064: add L2 cache scaling
Date:   Sun, 27 Aug 2023 14:50:26 +0300
Message-Id: <20230827115033.935089-17-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Populate L2 cache node with clock, supplies and OPP information to
facilitate scaling L2 frequency.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../dts/qcom/qcom-apq8064-asus-nexus7-flo.dts |   5 +
 .../boot/dts/qcom/qcom-apq8064-cm-qs600.dts   |   5 +
 .../boot/dts/qcom/qcom-apq8064-ifc6410.dts    |   5 +
 .../qcom-apq8064-sony-xperia-lagan-yuga.dts   |   5 +
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      | 100 +++++++++++++++++-
 5 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
index b60761290156..a8f826f0479a 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
@@ -78,6 +78,11 @@ reboot-mode {
 	};
 };
 
+&L2 {
+	vdd-mem-supply = <&pm8921_l24>;
+	vdd-dig-supply = <&pm8921_s3>;
+};
+
 &dsi0 {
 	vdda-supply = <&pm8921_l2>;/*VDD_MIPI1 to 4*/
 	vdd-supply = <&pm8921_l8>;
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
index ee071aed9b8d..7372f62fa31d 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
@@ -35,6 +35,11 @@ v3p3_fixed: regulator-v3p3 {
 	};
 };
 
+&L2 {
+	vdd-mem-supply = <&pm8921_l24>;
+	vdd-dig-supply = <&pm8921_s3>;
+};
+
 &gsbi1 {
 	qcom,mode = <GSBI_PROT_I2C>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
index 062c9cf4ec77..ddc69496100a 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
@@ -69,6 +69,11 @@ ext_3p3v: regulator-ext-3p3v {
 	};
 };
 
+&L2 {
+	vdd-mem-supply = <&pm8921_l24>;
+	vdd-dig-supply = <&pm8921_s3>;
+};
+
 &gsbi1 {
 	qcom,mode = <GSBI_PROT_I2C>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
index 5b911e5f0b55..8e0c12d406f6 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
@@ -57,6 +57,11 @@ key-volume-up {
 	};
 };
 
+&L2 {
+	vdd-mem-supply = <&pm8921_l24>;
+	vdd-dig-supply = <&pm8921_s3>;
+};
+
 &gsbi5 {
 	qcom,mode = <GSBI_PROT_I2C_UART>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index a05e64bff07f..21990ca5851a 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -2,6 +2,7 @@
 /dts-v1/;
 
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+#include <dt-bindings/clock/qcom,krait-cc.h>
 #include <dt-bindings/clock/qcom,lcc-msm8960.h>
 #include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
@@ -81,9 +82,106 @@ CPU3: cpu@3 {
 		};
 
 		L2: l2-cache {
-			compatible = "cache";
+			compatible = "qcom,krait-l2-cache", "cache";
 			cache-level = <2>;
 			cache-unified;
+			clocks = <&kraitcc KRAIT_L2>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&l2_opp_table>;
+
+			l2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					opp-microvolt = <1050000 1050000 1150000>,
+							<950000 950000 1150000>;
+				};
+
+				opp-432000000 {
+					opp-hz = /bits/ 64 <432000000>;
+					opp-microvolt = <1050000 1050000 1150000>,
+							<1050000 1050000 1150000>;
+				};
+
+				opp-486000000 {
+					opp-hz = /bits/ 64 <486000000>;
+					opp-microvolt = <1050000 1050000 1150000>,
+							<1050000 1050000 1150000>;
+				};
+
+				opp-540000000 {
+					opp-hz = /bits/ 64 <540000000>;
+					opp-microvolt = <1050000 1050000 1150000>,
+							<1050000 1050000 1150000>;
+				};
+
+				opp-594000000 {
+					opp-hz = /bits/ 64 <594000000>;
+					opp-microvolt = <1050000 1050000 1150000>,
+							<1050000 1050000 1150000>;
+				};
+
+				opp-648000000 {
+					opp-hz = /bits/ 64 <648000000>;
+					opp-microvolt = <1050000 1050000 1150000>,
+							<1050000 1050000 1150000>;
+				};
+
+				opp-702000000 {
+					opp-hz = /bits/ 64 <702000000>;
+					opp-microvolt = <1150000 1150000 1150000>,
+							<1150000 1150000 1150000>;
+				};
+
+				opp-756000000 {
+					opp-hz = /bits/ 64 <756000000>;
+					opp-microvolt = <1150000 1150000 1150000>,
+							<1150000 1150000 1150000>;
+				};
+
+				opp-810000000 {
+					opp-hz = /bits/ 64 <810000000>;
+					opp-microvolt = <1150000 1150000 1150000>,
+							<1150000 1150000 1150000>;
+				};
+
+				opp-864000000 {
+					opp-hz = /bits/ 64 <864000000>;
+					opp-microvolt = <1150000 1150000 1150000>,
+							<1150000 1150000 1150000>;
+				};
+
+				opp-918000000 {
+					opp-hz = /bits/ 64 <918000000>;
+					opp-microvolt = <1150000 1150000 1150000>,
+							<1150000 1150000 1150000>;
+				};
+
+				opp-972000000 {
+					opp-hz = /bits/ 64 <972000000>;
+					opp-microvolt = <1150000 1150000 1150000>,
+							<1150000 1150000 1150000>;
+				};
+
+				opp-1026000000 {
+					opp-hz = /bits/ 64 <1026000000>;
+					opp-microvolt = <1150000 1150000 1150000>,
+							<1150000 1150000 1150000>;
+				};
+
+				opp-1080000000 {
+					opp-hz = /bits/ 64 <1080000000>;
+					opp-microvolt = <1150000 1150000 1150000>,
+							<1150000 1150000 1150000>;
+				};
+
+				opp-1134000000 {
+					opp-hz = /bits/ 64 <1134000000>;
+					opp-microvolt = <1150000 1150000 1150000>,
+							<1150000 1150000 1150000>;
+				};
+			};
 		};
 
 		idle-states {
-- 
2.39.2

