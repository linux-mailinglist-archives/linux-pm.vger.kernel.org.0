Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27EF2FB17B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 07:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbhASGXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 01:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388309AbhASFvJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 00:51:09 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF9C0617A0
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 21:49:05 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id h205so27356313lfd.5
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 21:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYwmrtz/QU6RpO5QbrehkEFuAsa7SlsbStjo8EQedtw=;
        b=K5nRtS2YbYv2AHTcD6IiyY0LEV8YCv3+rrTBZQwGfrHwDV/775v+Ib+KN125PbV1Jh
         GgmzTQ6VsRsHqvkyXXLX8I5u667Utq9muwl680eBcSHJ+Tx9ZhkqmWY/27q446SJj0mK
         OitGxB0lyj7j0VFIESPZj+wWVStV8rqxVk1du8WqXdrtehxOCR2ri8M3/N5Yti3xr0/a
         PupKf6En4VUyTGpysIHa7aFrU8tXiZVuuNr0oiVjWFAdqnTsLDVZigYnng5g7ppGGfEb
         42bCuLBhNm4vG3bQZUvjDJmCWqtieefeVyS0S7YC0ED9BJaFYZVvEEqNYVV8JZsdKCM1
         h6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYwmrtz/QU6RpO5QbrehkEFuAsa7SlsbStjo8EQedtw=;
        b=nzTFoNnNK8U1wVgl9ubsSGAXN5fz7unW/yeXzmk3XdticZvFHe+NVEkKnj6V1jprcJ
         4eKF3hAqtn3K6FMizl441rwMjba8QZ/vqD1z3WU+PAmZlAiWckQjrnVL1osWdPqAG+Yw
         f4q5+p0Nfcpa7Nio3AE+lMSsAGXEXO6Z52++Vy7wWu3Rp8HQ2C5evZzuA1snkOX4BHu7
         wD5D6bfsAH5LAehwgjN6LFCzOA7yCiN3sWpdE8xbBwLfrytS/TOU4RY0tKpr79ZB8PK1
         wmdqITDpnoyN2YdI3Ie0VKZkVAhDQC8dm1MsnsvqddsLaZmN2PILvwBnyLRM+TYq9F0V
         IiLQ==
X-Gm-Message-State: AOAM531OwPSEurDslz+fP1vVgQFXA7HAk46JVomqZ9DD93UgP4VXyWDu
        W4e5OwkDoze/50Nlm/4Du1/SKw==
X-Google-Smtp-Source: ABdhPJxOUFWuJjxtgA4RJkI+3nAnyCJTdLUlY2O13hgBpHgnNAwnxnjiEeq84nhmbs0BH/FArtoWTQ==
X-Received: by 2002:a19:e34a:: with SMTP id c10mr1221052lfk.476.1611035344263;
        Mon, 18 Jan 2021 21:49:04 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.65.64])
        by smtp.gmail.com with ESMTPSA id j3sm2168207lfb.29.2021.01.18.21.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 21:49:03 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: [PATCH v12 5/5] arm64: dts: qrb5165-rb5: port thermal zone definitions
Date:   Tue, 19 Jan 2021 08:48:48 +0300
Message-Id: <20210119054848.592329-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119054848.592329-1-dmitry.baryshkov@linaro.org>
References: <20210119054848.592329-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add thermal zones definitions basing on the downstream kernel.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 155 +++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index ce22d4fa383e..ef9452f0c6b2 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -66,6 +66,78 @@ bt {
 
 	};
 
+	thermal-zones {
+		conn-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150b_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		pm8150l-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150l_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <50000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		skin-msm-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150l_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <50000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		wifi-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <52000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		xo-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <50000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+	};
+
 	vbat: vbat-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "VBAT";
@@ -420,6 +492,38 @@ &i2c15 {
 	status = "okay";
 };
 
+&pm8150_adc {
+	xo-therm@4c {
+		reg = <ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	wifi-therm@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150_adc_tm {
+	status = "okay";
+
+	xo-therm@0 {
+		reg = <0>;
+		io-channels = <&pm8150_adc ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	wifi-therm@1 {
+		reg = <1>;
+		io-channels = <&pm8150_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
 &pm8150_gpios {
 	gpio-reserved-ranges = <1 1>, <3 2>, <7 1>;
 	gpio-line-names =
@@ -435,6 +539,25 @@ &pm8150_gpios {
 		"GPIO_10_P"; /* Green LED */
 };
 
+&pm8150b_adc {
+	conn-therm@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150b_adc_tm {
+	status = "okay";
+
+	conn-therm@0 {
+		reg = <0>;
+		io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
 &pm8150b_gpios {
 	gpio-line-names =
 		"NC",
@@ -451,6 +574,38 @@ &pm8150b_gpios {
 		"NC";
 };
 
+&pm8150l_adc {
+	skin-msm-therm@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pm8150l-therm@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150l_adc_tm {
+	status = "okay";
+
+	skin-msm-therm@0 {
+		reg = <0>;
+		io-channels = <&pm8150l_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8150l-therm@1 {
+		reg = <1>;
+		io-channels = <&pm8150l_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
 &pm8150l_gpios {
 	gpio-line-names =
 		"NC",
-- 
2.29.2

