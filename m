Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDED27E61F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 12:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgI3KCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 06:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgI3KCp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 06:02:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B11C061755
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 03:02:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so1044514ljg.9
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IlnfeC5dNMsfRj34KVveDWWiSX6big7HcGo7tOgQ3Ps=;
        b=eWO0F5gp7V8DSza5dh7RccwYowiNRo3RKTENbUioTQzilk8j3rY9vb5TSmevlE6yRk
         88jkXMraQhK/td2BMXxcrV6SccZNxx/g+aUAHyv7NeExbVqoL7jBvxoFhODQdgw6F2+0
         7SkNGdvgSzgb1t0rixg91W9G65XgTQB9/cGsYAapPXSRpdle8QO5XkmWhpSQpwBI+a3X
         CT/LvYxV1cZE3YBUMemUhsUjq+cyY0g9aZEGbzbkkFwo9GdanqjCeKmqwScHn/h4/rax
         ppm5wvFLvtQ5dCBN+2HgTq5mcfMrWsd8R89x+lNv3d1DN7jCyT0P3RVZbV9gV0C7wzng
         8I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IlnfeC5dNMsfRj34KVveDWWiSX6big7HcGo7tOgQ3Ps=;
        b=DFmIXT4+IlrZKJqMSBmUcNGGn0rUgNBqMmQpq0mAYqMtl/Lh66m45PSut75vVBINEE
         94LFc0zDiVoMx6HHt2GQZYy8aG3AWqc9mWuQhvZhPHbXE93u5W1Jsjo3sF3+BDYO9acq
         6Z5oJjIybS1SPGcXhtF6MZFgYCuG1eAvLF4n2VBSWa8bdlOKeaLLBXBZhuQfNoseAFKH
         T+Vo6yynQb1pDCuepejWzezkKJRXcY0b9CGWuatvhNTuPSLWVq6AtubOi10JVL/8NP98
         79ZiFelnhB3wmPRJr65qXabCrDLLsOiSMTxABmf51185EaVIkpUoms28FcWZPb+36Ezm
         uUAw==
X-Gm-Message-State: AOAM533LyadpsmLIw8TYe+MZ7Oco330g0x1rAKZbc0KkidVO2RkD/Ttj
        Ykf5WQnpYWHfH4BL+x7e6UAKNA==
X-Google-Smtp-Source: ABdhPJzfi4bBw4vo/ctdv/15FMoqvRgp7UjESmXkIsBjb6gftwarbOzCN9E63aG6qc2KBV+o0cs9gw==
X-Received: by 2002:a2e:8e71:: with SMTP id t17mr594550ljk.413.1601460163143;
        Wed, 30 Sep 2020 03:02:43 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id w4sm132479lff.231.2020.09.30.03.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 03:02:42 -0700 (PDT)
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
Subject: [PATCH v6 10/10] arm64: dts: qrb5165-rb5: port thermal zone definitions
Date:   Wed, 30 Sep 2020 13:02:03 +0300
Message-Id: <20200930100203.1988374-11-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
References: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add thermal zones definitions basing on the downstream kernel.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 154 +++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 1528a865f1f8..6cb8688910a2 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -58,6 +58,77 @@ bt {
 
 	};
 
+	thermal-zones {
+		xo-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 0>;
+			trips {
+				active-config0 {
+					temperature = <50000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		wifi-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 1>;
+			trips {
+				active-config0 {
+					temperature = <52000>;
+					hysteresis = <4000>;
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
+					type = "critical";
+				};
+			};
+		};
+
+		skin-msm-therm {
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
+		pm8150l-therm {
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
+	};
+
 	vbat: vbat-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "VBAT";
@@ -412,6 +483,89 @@ &i2c15 {
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
+&pm8150b_adc {
+	conn-therm@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
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
 &pm8150_gpios {
 	gpio-reserved-ranges = <1 1>, <3 2>, <7 1>;
 	gpio-line-names =
-- 
2.28.0

