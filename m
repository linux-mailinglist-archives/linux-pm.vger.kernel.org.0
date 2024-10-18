Return-Path: <linux-pm+bounces-15955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C799A3EC5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 14:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3404F1C237DA
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 12:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C611DF26C;
	Fri, 18 Oct 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YXsWEtSE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262A1D1E96
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255786; cv=none; b=YqPqTJSeuqJqElerUU4TEqu0JrbUBUcVJ5NJ8eKFxnao4IOc5HqSPmZzTtc0wXSXh5J99CiyzN9OdDtvKIpoU/EVGce972ANO6zD5ldVRjPYHIXsey7vhixgVZUbVLzrIL5n6H57R2yEUU2oJfFmDavUE+PQI51bCpqC5VXgJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255786; c=relaxed/simple;
	bh=ALfCKFByYUDVrZkxzCoUjBlHbP+GuGdy/oMAze7XwKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+dQrfQQnccl/D/mksMA9IWQg4OoMRUk3Q0wQlbyFLQC9Az1hjLak4v8TkqlSOE1/hrciFf56qcdsd7UVSnCG7fNn+sOEfpwNoLdLY5/B3ZPKOK9fGcy7WPxRKxdH8ejNyvh79/7uuxKYzFfzLnNtRcYTk3heexx7boCdVZT29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YXsWEtSE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431137d12a5so21068125e9.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729255782; x=1729860582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SXk1aP0FJCXvypNsnh25z1CFtl/7LUgjPK1RLNlZfg=;
        b=YXsWEtSEzq+/X2aKudIgcEvy3Fb4ufUoCNW5bLQLXmo4CtnKPln/BMGBvk+Iboybdw
         LSX76h7ktlY0gg2OZedGmAnM92sqib3xPmiMkN2PkwpeS7XvzS3q94/HFSa+GxCeborH
         MoXwJh56YOPh3/WeunYQBb2UJlEeLKKCARq+Lo9gM0wDDsyAav/EAAoscqvoCQoyxtj4
         QzA4F3qBAPBHkEp1a7GJ8a9gFkhkm+eMb7d4vb5w8jbfLswHGU2jdi050SCLT0RodTcN
         zrbIUHTFjQiYXnbr4VyMjch7B4FDHu+TYYRJ2Qt1rHoazWzHLjYHqROLbA45IZVtGfdp
         bYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729255782; x=1729860582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SXk1aP0FJCXvypNsnh25z1CFtl/7LUgjPK1RLNlZfg=;
        b=C77+B00HIimDlBcImgb/fukIVaLkXZri0bSrCRP7P7KYOamS8BtoMogo2PSbGQufAF
         1i0TMQpfJGmcMk69KLxiAZWfXu19vqRET6q2vWlJOUbWQ3tZWtU2yWcp05BLcT7h8Tnl
         BIwp6X/TRBr/CvqUtRG9joby4tYZYMlRWwIs9BjLNSI5FF56IsDVlB2zeuaMhNjzRTIp
         3GA4ok9uMvVGi0XtyoHh2/n4GuUaaCjS7mKQL52gresvlj583YPrwykL7BHu+JUqtlYE
         khGaVcsOeYYjIxGyz+X0YXsCYQSCndUaxkiyIOdJJjR5cBgbYH5K1ojvWsk4+9aJRIyk
         8kPA==
X-Forwarded-Encrypted: i=1; AJvYcCXTe0AuOakOnrbuMJHHgcpPd3sUlGoYnQsfSa0iP6L/StJ2ymIvBAx1yfulvGopPJxn1JcNRaAxlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyval3i+aK2M8ZHSDMBbtFtmbBLMqR+W7y1YpiXLvVjIVNDA6GN
	lmTWREufwWjhXHJtthLr9Po7hA0pPdZ4cTKNnpIA3QiTkRlt/nJnv1J/Bo16kpw=
X-Google-Smtp-Source: AGHT+IF7i5ijJ/PBj+rVVE90wGBGkUbs+Qau7bPR83w2OKEfud7HPlsA4a1baxa0bmZ7IKUkM5cLpw==
X-Received: by 2002:a05:600c:4f15:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-4316168ffb3mr20259385e9.30.1729255781722;
        Fri, 18 Oct 2024 05:49:41 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160695d8fsm26640835e9.27.2024.10.18.05.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:49:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2024 14:49:13 +0200
Subject: [PATCH v6 3/6] arm64: dts: qcom: sc8280xp-crd: model the PMU of
 the on-board wcn6855
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-sc8280xp-pwrseq-v6-3-8da8310d9564@linaro.org>
References: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
In-Reply-To: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4498;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=z5k/Qqi73I7Ez24Ck4rdkv9VCt9Ycv56x4hxpvBQUWM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEllfEMACrK1WN1Db9NkLo+75YO6OWKDZMpOGN
 nNzGKXdvV6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxJZXwAKCRARpy6gFHHX
 cl4iD/9v/vJiABNNQviNzBQ10JNb6iik4lfxcUYjiTcfwoGbXeXmMi/3l0J8P8QvfcN44smeCNU
 Xn1jRCO2aNZwHVrR7MclNC2JzZ3dptqsfsgfKpSl35lIqAyxB0MTgjnpzpUKJlzdN8PuIfFUWQm
 1PjK3w0mFixu6Z6gfCVHZrlQAb37I9HrPnDAKYvrvIBmBEzCPOdXctdz8gtr/Z6lhyLlkBAxvzs
 EAKDEP2JpAvDhsnLv2z7hP3qZmMVY292cuMxfrNrEV3KmMD+GkczwNRumxPI3fKJOi6jUA7h9NP
 i19zJW5vpCcoVj4NLKfTAtJhgMqwQm95ICbXf00VT7Tb2X+C1MqHp3+uZj5W0ArCUybJd0RUhWI
 HE6x8N/eLcBnXYT99gPZ7jMl3Cy0Cs/sTJPXuhnZRWF+CUHs59HBI3O9fAjCrFl+C52tgoYEDMS
 xYVgM7QWqZY3INaKCk7x4cxkcO9lYw/PHMkXsZVZCs7IutWTN/CIrGbZAiyAinYVeqmv0wZQ+nu
 LfRmpp/2SYhaVjjgVBoFFPu77UdXN0pWaujoKwnwDvo7DO4FiRBYvVHmgBSYQIimj6KDm37ohQ0
 UzlX58HK04UXo2JmCkrf0X+eSFmIA0GF2By0bYNRc0VAHHaHNDqb6+iFpXlrvNPQ3k74ctsDwh6
 9N3OdtZI9po96rg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add nodes for the WCN6855 PMU, the WLAN module and relevant regulators
and pin functions to fully describe how the wifi is actually wired on
this platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Co-developed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 112 ++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 6020582b0a59..a02d8029ac2d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -260,6 +260,69 @@ usb1_sbu_mux: endpoint {
 			};
 		};
 	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6855-pmu";
+
+		pinctrl-0 = <&wlan_en>;
+		pinctrl-names = "default";
+
+		wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_s10b>;
+		vddaon-supply = <&vreg_s12b>;
+		vddpmu-supply = <&vreg_s12b>;
+		vddpmumx-supply = <&vreg_s12b>;
+		vddpmucx-supply = <&vreg_s12b>;
+		vddrfa0p95-supply = <&vreg_s12b>;
+		vddrfa1p3-supply = <&vreg_s11b>;
+		vddrfa1p9-supply = <&vreg_s1c>;
+		vddpcie1p3-supply = <&vreg_s11b>;
+		vddpcie1p9-supply = <&vreg_s1c>;
+
+		regulators {
+			vreg_pmu_rfa_cmn_0p8: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn_0p8";
+			};
+
+			vreg_pmu_aon_0p8: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p8";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p8: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p8";
+			};
+
+			vreg_pmu_btcmx_0p8: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p8";
+			};
+
+			vreg_pmu_pcie_1p8: ldo5 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo6 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_rfa_0p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo8 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo9 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -269,6 +332,15 @@ regulators-0 {
 
 		vdd-l3-l5-supply = <&vreg_s11b>;
 
+		vreg_s10b: smps10 {
+			regulator-name = "vreg_s10b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
 		vreg_s11b: smps11 {
 			regulator-name = "vreg_s11b";
 			regulator-min-microvolt = <1272000>;
@@ -276,6 +348,13 @@ vreg_s11b: smps11 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_s12b: smps12 {
+			regulator-name = "vreg_s12b";
+			regulator-min-microvolt = <984000>;
+			regulator-max-microvolt = <984000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l3b: ldo3 {
 			regulator-name = "vreg_l3b";
 			regulator-min-microvolt = <1200000>;
@@ -304,6 +383,13 @@ regulators-1 {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
 
+		vreg_s1c: smps1 {
+			regulator-name = "vreg_s1c";
+			regulator-min-microvolt = <1888000>;
+			regulator-max-microvolt = <1888000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l1c: ldo1 {
 			regulator-name = "vreg_l1c";
 			regulator-min-microvolt = <1800000>;
@@ -583,6 +669,25 @@ &pcie4_phy {
 	status = "okay";
 };
 
+&pcie4_port0 {
+	wifi@0 {
+		compatible = "pci17cb,1103";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+
+		qcom,ath11k-calibration-variant = "QC_8280XP_CRD";
+	};
+};
+
 &pmc8280c_lpg {
 	status = "okay";
 };
@@ -1030,4 +1135,11 @@ mode-pins {
 			output-high;
 		};
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio134";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
 };

-- 
2.43.0


