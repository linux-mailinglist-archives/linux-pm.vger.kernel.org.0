Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474B925C35E
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 16:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgICOuV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbgICORO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 10:17:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B75FC0619CA
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 06:21:39 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d2so1913313lfj.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7/RoZUDbSidbaVmS9FeqN+fWeyUR1JKVWNxeicmHMg=;
        b=zEWstPZ31aBryWxYNemcI3JoczurqsIM+kowklx4XBCk00IVh/93S1NcSLqpa8dESZ
         iIyASHxbXJswE7RfL5pxrCIFdVShNGxkSCTpYifIDBG9byHWzuDDJwxOuAP25A2x/EZ7
         yyDic2OOU7DpPvzVjfeEX4wAAhWZfZ/vKO/0xhaI2Wdhx3CAVMUpu3zHPtLe0+SSdQhe
         ORBQo6jKrVIMZ4Eyk/B/nfD4PaETNV2pEDSIc+XHroBqNiGmxlY82t8PmnxS0E5mmQR3
         thibgp7bjY7uHBPJ2sM8nBg9kMTRAW3Tfz9tz85nhMbyP4oe2w96+4I8//6+5ECGgKhn
         zGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7/RoZUDbSidbaVmS9FeqN+fWeyUR1JKVWNxeicmHMg=;
        b=DL0dpcjzKOu6VadYZXxNcFiFBinh/F0TLUHZ/fx8LGaAnf3uPkIgVkRyzVlL3m4Eww
         919BLrJDHIoxZ6rXgw9N84RShmuaAUnci/GcityN/ysugf1A4aM97Jhb6SOoeEYxwfug
         bBSU1YZknLwV7a+f1SZqxe+QGB5GcWdm6GrrQqmlhvzdO3qHAxGGi8MlNLCsgPbYXMrS
         nDAByYIYOl4MWlmxwP3x1wSw9qNKYyPP85T5x+t+5m3ZmilpTsNNwIzHmShXelj+CNyE
         JSGbVB8FWfjXqpcJy0lsIvkwQ7djrhqqD5WWUw9dOY2340ktVZ4Z3QEZaN0q6g+3Ala5
         An9g==
X-Gm-Message-State: AOAM531PVs+2YuZdUuB/pzqAichVuCjADetxWDNxyw+On4EYuuvISZQu
        rjkuN3a/h5btNyk5+FBrt+Qn6g==
X-Google-Smtp-Source: ABdhPJwJHC6RwnosYTlCNIMZruGq97X9zWxdMV8v4PXrUw4KhG99TMUWZdIe92dYoflftgWkWzCLxA==
X-Received: by 2002:a19:4ad8:: with SMTP id x207mr1273135lfa.73.1599139297531;
        Thu, 03 Sep 2020 06:21:37 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id e23sm584220lfj.80.2020.09.03.06.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 06:21:36 -0700 (PDT)
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
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: dts: sm8250-mtp: add thermal zones using pmic's adc-tm5
Date:   Thu,  3 Sep 2020 16:21:09 +0300
Message-Id: <20200903132109.1914011-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Port thermal zones definitions from msm-4.19 tree. Enable and add
channel configuration to PMIC's ADC-TM definitions. Declare thermal
zones and respective trip points.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 217 ++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 6894f8490dae..4db5c1e4269e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -24,6 +24,104 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	thermal-zones {
+		xo-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 0>;
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		skin-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 1>;
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		mmw-pa1 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 2>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		conn-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150b_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		camera-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150l_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		skin-msm-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150l_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		mmw-pa2 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150l_adc_tm 2>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -358,6 +456,125 @@ &cdsp {
 	firmware-name = "qcom/sm8250/cdsp.mbn";
 };
 
+&pm8150_adc {
+	xo-therm@4c {
+		reg = <ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin-therm@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa-therm1@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150b_adc {
+	conn-therm@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150l_adc {
+	camera-flash-therm@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin-msm-therm@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa-therm2@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150_adc_tm {
+	status = "okay";
+	io-channels = <&pm8150_adc ADC5_XO_THERM_100K_PU>,
+			<&pm8150_adc ADC5_AMUX_THM1_100K_PU>,
+			<&pm8150_adc ADC5_AMUX_THM2_100K_PU>;
+	io-channel-names = "xo-therm", "skin-therm", "pa-therm1";
+
+	xo-therm@0 {
+		reg = <0>;
+		qcom,adc-channel = <ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin-therm@1 {
+		reg = <1>;
+		qcom,adc-channel = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa-therm1@2 {
+		reg = <2>;
+		qcom,adc-channel = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150b_adc_tm {
+	status = "okay";
+	io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
+	io-channel-names = "conn-therm";
+
+	conn-therm@0 {
+		reg = <0>;
+		qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150l_adc_tm {
+	status = "okay";
+	io-channels = <&pm8150l_adc ADC5_AMUX_THM1_100K_PU>,
+			<&pm8150l_adc ADC5_AMUX_THM2_100K_PU>,
+			<&pm8150l_adc ADC5_AMUX_THM3_100K_PU>;
+	io-channel-names = "camera-flash-therm", "skin-msm-therm", "pa-therm2";
+
+	camera-flash-therm@0 {
+		reg = <0>;
+		qcom,adc-channel = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin-msm-therm@1 {
+		reg = <1>;
+		qcom,adc-channel = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa-therm2@2 {
+		reg = <2>;
+		qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.28.0

