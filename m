Return-Path: <linux-pm+bounces-8775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FA29000FC
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 12:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9429F288684
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3DB1607AA;
	Fri,  7 Jun 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwEVTxDj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB715DBC0
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756370; cv=none; b=uPxIuqsCYNNXGomuNmjnjmJOCB4LfcxVXFnSuwuUE3chR5GxjRusb+XOHgl6sPQF5cEzQrHf0klXchzT/RJUBuNopfX80iLvU+E4HQ8i33aDPIeYN57aKl75UcP9YM50VRS8nhPdmtQvlth4CWtfaEfnGQVpyoY6NQZOs9sLFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756370; c=relaxed/simple;
	bh=ohK2sslGjClxr9kCmY/gW62DMEkgvC5Tz6xsCMKB8Kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtHeNmvb37C5e3DtOF1fUsAyl2V5EchZHIh4ZeZExJWZspN9TeH9yPFQLTh6elg8pC+qlAHvHo8KtizYZeoMBUhqnMlWCS8GsveykUN5hsH7oIa/reMOA6n7UBKMNwVrvCy0oJhX+oZ1yEC5ANWvaEudgAOjgALQLncQoaycBRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vwEVTxDj; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b7e693b8aso2879716e87.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717756365; x=1718361165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+nA/cIlT4hl2if/i6DmrZViDpHELl0xAbf5HX+dSsg=;
        b=vwEVTxDjOtNjwJGD7kcMRd/i2OZTrvoxzGUxu9cV7odLPixhjmF/p+8E+dzzX9XaDo
         WEw+cnqglM1XfG6u69nNHclhobbQLYXBy6NeZJrSl0XWLLGedx8CZOHjdZdB5yD8D/k/
         MMfWeyUq5vFEqy0Wy2JmfP4G/JjnKksToZ3Qs52TFbTCBNRpMsG/GPsUtsye1fQFWgGM
         6ro7MkbFjyva0/FBwrxBacc8eL0IJl1llH/O6z2bB9h5SpfNcLQYFUO2sTNimX7ZAZyB
         bnjLmAGDaHtKcIa2DoADJN9TSqhH1Ep9B6v5Q171aDN+Te0SaZAghrCDj9uGa1PXZz9a
         uEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756365; x=1718361165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+nA/cIlT4hl2if/i6DmrZViDpHELl0xAbf5HX+dSsg=;
        b=I3cX68ypHJL5cJV+c/UGfKXn6Cdo27giGplObeHwrlnPQCDgjA7r+31648HeEJ7VLj
         dzs4Ikq56bajTSp+QF8IyL+9Um6ARuwhfwuctH7TknFAwBTmu2AjaRJ/HKidDcgIJXgv
         9aps04ZnIMlfCBjv0hc6Qjxchplob+ioFE7qWRGwxTdcykEgXLn3Uvc8dTmj18q6tO7A
         XOp8A4I2JQabi+E3HiMaConLidon1aZo+DtbDRI9I3b0nYxuWA19sb2ahRpwCcJw3mfT
         7x423CxE8AJiw2mjNKBE9pY7KV4nI2c7xW2jwIc2RbtBJS2NBG5JOzleQoVcU8l/OGrI
         QTIA==
X-Gm-Message-State: AOJu0YxRFqRDTV52o4Zq+IMs3/MFT0H7pXdqjD8fvL2jelYhWSzT83A7
	ZUw/sq3+WLdKV9IJVPFmEA/3NoS+rdr+0Urv41pkDdPYbK4sKzjEPnDEAgdOu+g=
X-Google-Smtp-Source: AGHT+IHwMriQsM1CMt6lSUr4ex+0paISgflwuPSKyxa2InvrwFrwht9F2G2f6bxRlZR19OZ5frotLg==
X-Received: by 2002:a05:6512:252c:b0:52b:c2b8:b1d9 with SMTP id 2adb3069b0e04-52bc2b8bd19mr72709e87.26.1717756364765;
        Fri, 07 Jun 2024 03:32:44 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433ccdbsm483448e87.283.2024.06.07.03.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:32:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 13:32:41 +0300
Subject: [PATCH v5 6/6] arm64: dts: qcom: c630: Add Embedded Controller
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-yoga-ec-driver-v5-6-1ac91a0b4326@linaro.org>
References: <20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org>
In-Reply-To: <20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2519;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ve9c78TTAFS5VXzgVyLUhE7e1KCToRb1yljm5NLcL8s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYuHHRI+9rHUj3nUv35thy/7x99PxS55VdUsZv
 SSnHxDIRyOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmLhxwAKCRCLPIo+Aiko
 1TwKCACyq1kzwkRnJ0/z1CWjVmvAKVwpj73htm8NuAtDYs7+KnRjCoh7ywTxmvYv+PbHdpXmBC+
 lx4KrHjIQzozMzb83fv/2JX2UXbEVDlMj3+f5Z33k41J3GUqcZokk1w6jytKKR4TAN90px/q8F+
 y2CQsXluHQ6KMFPnq5om0SGk5sqSvHy9F2ZNZvXsRliw7nzE4XY+fmJSwhWLElgvmxFqlB0HNVs
 u0PdTEQMVUgxrle4of0kGSBB1c+iS0XYvXG5ocbrD6PGZA8WYPWgDg8ZZfSwsVv0VdVk5PzT3iB
 IpWSTG2MbPJq/SycoaNZIpT2m06L7gbN2gGPeZtZ++uXVw5V
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

From: Bjorn Andersson <andersson@kernel.org>

The Embedded Controller in the Lenovo Yoga C630 is accessible on &i2c1
and provides battery and adapter status, as well as altmode
notifications for the second USB Type-C port.

Add a definition for the EC.

Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 8402ea2d93a7..f18050848cd8 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -370,6 +370,66 @@ zap-shader {
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
+
+	embedded-controller@70 {
+		compatible = "lenovo,yoga-c630-ec";
+		reg = <0x70>;
+
+		interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ec_int_state>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "host";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					ucsi0_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					ucsi0_ss_in: endpoint {
+						remote-endpoint = <&usb_1_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					ucsi0_sbu: endpoint {
+					};
+				};
+			};
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "dual";
+			data-role = "host";
+
+			/*
+			 * connected to the onboard USB hub, orientation is
+			 * handled by the controller
+			 */
+		};
+	};
 };
 
 &i2c3 {
@@ -695,6 +755,13 @@ mode_pin_active: mode-pin-state {
 
 		bias-disable;
 	};
+
+	ec_int_state: ec-int-state {
+		pins = "gpio20";
+		function = "gpio";
+
+		bias-disable;
+	};
 };
 
 &uart6 {
@@ -742,6 +809,10 @@ &usb_1_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_1_dwc3_hs {
+	remote-endpoint = <&ucsi0_hs_in>;
+};
+
 &usb_1_hsphy {
 	status = "okay";
 
@@ -762,6 +833,10 @@ &usb_1_qmpphy {
 	vdda-pll-supply = <&vdda_usb1_ss_core>;
 };
 
+&usb_1_qmpphy_out {
+	remote-endpoint = <&ucsi0_ss_in>;
+};
+
 &usb_2 {
 	status = "okay";
 };

-- 
2.39.2


