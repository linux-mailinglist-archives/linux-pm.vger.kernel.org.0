Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0502FA3CA
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 15:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405325AbhARO4h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405319AbhAROyH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 09:54:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D37C0617A2
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 06:52:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o13so24488634lfr.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 06:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYwmrtz/QU6RpO5QbrehkEFuAsa7SlsbStjo8EQedtw=;
        b=ujDw7idogA7ubtCSw3Pua5Bqbvx9JmkO80LBhL8vrBdDBdrx2urUN92KMUlBkqNsFo
         JuCu6wGdT+6ULvsB1a/3HtgMykEatbSXqLmMNYOXJ5miRdG7Vr/Hi2yJYw600WxkoxWo
         c9Q9fy/GXO96GDapcaioKyZZNLtzgGYy7zVubgy5gobhXh1R9B9mhUcLYJW8y5pYajJH
         hSaFH5fkPeJ3w0+LHmM7vI9U28GbwiZJ6Gge57oqS1fsX5HwsRgP856wjf1LcG4eALVs
         2lR3SvP7jzbm1py4EyPrn8C12I80tr9ps+nZ71mo5/vJUHCP1BxHYZTe1bQlHK6EP07K
         kixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYwmrtz/QU6RpO5QbrehkEFuAsa7SlsbStjo8EQedtw=;
        b=Bxh9b2TbXy23VkVFcnO8smOuo9wz9iHulHXuzOQZmTzC9W1sXOv5IQRvj5Bn1Mh9fu
         C1avzG3oMr1+eSCunt97rW6B4roJ+aFhNaxLhWzIkkeWBSPNPx+ucURYJNxJdecToDzf
         M2Jrgu4sLu39rO+MzAww5+s81wD0KF9O7yVXgDcPjaUnzUwlgJZ9bj10swZRqGR5bRjh
         89ZVnxyjqxP+6/pGnlMit7sqvZpG+rdGjKq1WkEeFsyAX7Ke+Da20XbhhvH7dK2eCYUj
         BYJg3o2Br3nZmxY83WaaTFZGg27Mng/HSS9bh9XeErzSZeNspxtZzuUeQEtmIYdXWj21
         re7Q==
X-Gm-Message-State: AOAM532yvnVZi4+8TuPjOKXGzFjhPNtI9yZqtWC+Kojl51UoTEKiqsjN
        sdkz7eo/iw2f5akgpI+Qg7SwgJJ9b1LUKd4i
X-Google-Smtp-Source: ABdhPJy12rVVQHuq3bXXn3UoG9OVnbgEgrR1ZyjIQRrQLx0ljxi9lbTbiNHXZhF0K0WKtUDYHYIOtA==
X-Received: by 2002:ac2:43a4:: with SMTP id t4mr11750936lfl.197.1610981532713;
        Mon, 18 Jan 2021 06:52:12 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.4])
        by smtp.gmail.com with ESMTPSA id h13sm1969697lfj.110.2021.01.18.06.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:52:12 -0800 (PST)
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
Subject: [PATCH v11 5/5] arm64: dts: qrb5165-rb5: port thermal zone definitions
Date:   Mon, 18 Jan 2021 17:52:00 +0300
Message-Id: <20210118145200.504951-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118145200.504951-1-dmitry.baryshkov@linaro.org>
References: <20210118145200.504951-1-dmitry.baryshkov@linaro.org>
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

