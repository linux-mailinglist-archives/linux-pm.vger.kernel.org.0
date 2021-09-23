Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4787F416765
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243363AbhIWVYS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 17:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243321AbhIWVYK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 17:24:10 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF4C061766
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 14:22:38 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 67-20020a9d0449000000b00546e5a8062aso10402366otc.9
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 14:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ElSmUHA5tSuw64eBsWSEwxSDKoBXfjWoeEi2P04SziQ=;
        b=WOQ+M4oz67aaD9T7TWMu5DlF15PQvuH4E7/Cw59s3SzS7weFqR7spsm5L10YoLqJdj
         X8ty/IMzTjCKMIsyffUnReb26rSYInF5fLBeFMyEAHQwqr83T0IGOeNSQud+IKJh10Au
         rVxv5dkmNlZ7XcQtmnu1ktacN1KS39afaFA/SGAX8aSvW/HZ4zHYLqyDI2j7gdpf15BN
         RzqxzDrnhG84LBNIOliqzbhTy+3Kfi1ED7QIMvymz8rWYrLRLubMgpzc1qmEUkv8qgHH
         Sg5HQfeqIiOxRNPKuwxJysigqBfoDMWkpsiFSPokmhhVcBmUJg6T4rNIiSK5aHjkPvXR
         +7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ElSmUHA5tSuw64eBsWSEwxSDKoBXfjWoeEi2P04SziQ=;
        b=K4BL36PKslR36wu6KU3BtjKceSuKMOxHGf3J6gEN0u3ehm8RJAgGkmiIZn9bxKvAbK
         OUAbmvEg3Q8Cu/CtVYyApiKAwSQxszTczM0av36XSBImO54dtey3zP0tLzemzkorOf+h
         yeSIJ9ns/c8sHDnyrJHOYsXfQ1ZYrGw06NLzij4/QqkoPcw39mnKyKdY5DL3GakmQh/T
         M0vk0PTmUm0qpH0DI6ixayF2T7dU7zVCLOSoPJCP1vNkxM88YVaNS6MK9zJtn15DXUuy
         60TF6Bkh5JmMRB9o0CdIadE4FlQnC6gFm82s9zaswNaTcgMXVCHqh2cIt8iLoEWEV5fT
         Ynlw==
X-Gm-Message-State: AOAM532aX4OL/9czLw0RJwmKBBBYd0fzlTVDwbXpml16XnYtK4a7u9mp
        /X+ExVxcONu0Li0Brh3EppMPqg==
X-Google-Smtp-Source: ABdhPJyVSM8UxVVJQ8y7N5bhTs+GUx9AYDM4ISabCojtg5OUEh9wz64DBpsZRgmAYMIu7UDYi2WxMQ==
X-Received: by 2002:a9d:7091:: with SMTP id l17mr740020otj.309.1632432157675;
        Thu, 23 Sep 2021 14:22:37 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e16sm1586820oie.17.2021.09.23.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:22:37 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: qcom: sdm845: mtp: Add vadc channels and thermal zones
Date:   Thu, 23 Sep 2021 14:23:11 -0700
Message-Id: <20210923212311.2877048-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Downstream defines four ADC channels related to thermal sensors external
to the PM8998 and two channels for internal voltage measurements.

Add these to the upstream SDM845 MTP, describe the thermal monitor
channels and add thermal_zones for these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

In addition to the iio channels exposed by v1, Daniel wanted thermal_zones...

Changes since v1:
- Enable the pm8998_adc_tm and describe the ADC channels
- Add thermal-zones for the new channels

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 128 ++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 52dd7a858231..e3b40daef801 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -10,6 +10,8 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
+#include "pm8998.dtsi"
+#include "pmi8998.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SDM845 MTP";
@@ -46,6 +48,68 @@ vreg_s4a_1p8: pm8998-smps4 {
 
 		vin-supply = <&vph_pwr>;
 	};
+
+	thermal-zones {
+		xo_thermal: xo-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8998_adc_tm 1>;
+
+			trips {
+				trip-point {
+					temperature = <125000>;
+					hysteresis = <10000>;
+					type = "passive";
+				};
+			};
+		};
+
+		msm_thermal: msm-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8998_adc_tm 2>;
+
+			trips {
+				trip-point {
+					temperature = <125000>;
+					hysteresis = <10000>;
+					type = "passive";
+				};
+			};
+		};
+
+		pa_thermal: pa-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8998_adc_tm 3>;
+
+			trips {
+				trip-point {
+					temperature = <125000>;
+					hysteresis = <10000>;
+					type = "passive";
+				};
+			};
+		};
+
+		quiet_thermal: quiet-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8998_adc_tm 4>;
+
+			trips {
+				trip-point {
+					temperature = <125000>;
+					hysteresis = <10000>;
+					type = "passive";
+				};
+			};
+		};
+	};
 };
 
 &adsp_pas {
@@ -469,6 +533,70 @@ &mss_pil {
 	firmware-name = "qcom/sdm845/mba.mbn", "qcom/sdm845/modem.mbn";
 };
 
+&pm8998_adc {
+	adc-chan@4c {
+		reg = <ADC5_XO_THERM_100K_PU>;
+		label = "xo_therm";
+	};
+
+	adc-chan@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		label = "msm_therm";
+	};
+
+	adc-chan@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		label = "pa_therm1";
+	};
+
+	adc-chan@51 {
+		reg = <ADC5_AMUX_THM5_100K_PU>;
+		label = "quiet_therm";
+	};
+
+	adc-chan@83 {
+		reg = <ADC5_VPH_PWR>;
+		label = "vph_pwr";
+	};
+
+	adc-chan@85 {
+		reg = <ADC5_VCOIN>;
+		label = "vcoin";
+	};
+};
+
+&pm8998_adc_tm {
+	status = "okay";
+
+	xo-thermistor@1 {
+		reg = <1>;
+		io-channels = <&pm8998_adc ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	msm-thermistor@2 {
+		reg = <2>;
+		io-channels = <&pm8998_adc ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pa-thermistor@3 {
+		reg = <3>;
+		io-channels = <&pm8998_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	quiet-thermistor@4 {
+		reg = <4>;
+		io-channels = <&pm8998_adc ADC5_AMUX_THM5_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.29.2

