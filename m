Return-Path: <linux-pm+bounces-19972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE50EA01B29
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 18:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E89188390A
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7381CEEB0;
	Sun,  5 Jan 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6JXcFxz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722351CDA2E;
	Sun,  5 Jan 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099111; cv=none; b=QphMVmw2QbYbQZkImrb1FD6S3+2EYBd1HvPXwuas3LeS3BW1Sr3aLl5CwxaEuurJWOU1oLUmrfwMNE5V5VRqH/m9zStIPF0wKTtmSwqWv1gewC3KTJTKEjpvAXQLlVRBQKpmEN0VhF6esEJOuIlfG8fiHgsxdoEJVcquljlVf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099111; c=relaxed/simple;
	bh=aHxh6mXQm2Pomntp5Apy+gfeS3bWH/sypTFPY9It4WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwofaReCjTYRWf2Oed6v/z0+ZTT0HbN3kdXWdcaKZeeQm4s9D+KDA+x0d4w10D9bnc2jCaZH+9fdSl0IWQTKyB1/lP/sQqOBWU3fheMu1mub/imRHj3leVeQW7TRrBBb3XEAEQypUutdytGfiEHHyJZ1SUvK4h9aGQOc5N3icUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6JXcFxz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21661be2c2dso175958745ad.1;
        Sun, 05 Jan 2025 09:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736099108; x=1736703908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keJpUCOZO1G6z7AqbQ0oWlgGpxQddW7HrAwABR04sv0=;
        b=b6JXcFxz3duKIR1E6JNFKhQtSQwjdx3pvo5WZvfbqHTjEjXEOmMESvHoHrNLjY7sov
         COiqODh6CGxd7sR/urQM7wvxfk0DrXlRpmFlCfchA/jO3iBHN1EeWntRSqpmG5ZzffwE
         JqecJYPqkLKY32UMeJmpAzKUjwvYt4CDMgBEePcdIVWj+BEOnUKrse5FGMhVJ2+KqpBG
         9IRTaHk1cucO9JC4tGlzNVtftQKGSPbg4wFDFhxPDVnNG8bLZ547TZV4+iMQ4o1fbo9p
         Qjda1rcDw/9zpEss723fUQyTfzm42+ppKchz6uiRWvAGnAZhD8uNF2+eBOUehv+EJgXn
         AMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736099108; x=1736703908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keJpUCOZO1G6z7AqbQ0oWlgGpxQddW7HrAwABR04sv0=;
        b=s3486e++39sjzGcZrOa/eqXFftdoumkRA9SRErACZfcboVS/HpS1jpgYFbLTtGUlJa
         JrGlDklvvKW2oflAi8hXP5CWiZEuea8xNnV0mUewcZldvRhLdTY5vZQXsUKhx2z4QtWJ
         VRsjvFfmWo9G2n1zgyqTUENXBWt1feySJZqi5SJLhDM8p9nFoX94jkSEjCyZWtsqu17Q
         yjjDz1WRryrsbTRI0WrhG9ClOAyvS276KH14A9CZwxPoM4S/2xmpah1eCJqTtwa3wOhY
         bkbSHVbS8TNH1h0NuiQnNYgYZZP6JHXbBCbEpXMVKNJ+gD7StZbxQj5UNtzPeHEQH7ab
         906g==
X-Forwarded-Encrypted: i=1; AJvYcCUBs9RJU8AqnaJRJZ2ZIsbic0GeuY3H+AW26hQZJA7uMn2VNS5JCYNjl4hQ8wykrVq8lIR+L1Jgy3+yN9ls@vger.kernel.org, AJvYcCUP3SlOD63ftes+YDNB8QYBazhXkE+aDZQzL/5fxBlzUHREFnB5xYjb5i2gvdvL+tl7iVau+zfWa4bhHkKv@vger.kernel.org, AJvYcCVBCVjUhanCMUi2FVChZqOknrHzuMRNkqmrt0imdYDZKzAAuVA47OvlPmXTVxwRldD9Q2q5HTd6PVc=@vger.kernel.org, AJvYcCVf3cPSDZWegnGHRnXfl7bLA3Q5yBSNW7rAqYJyp7lqTZQPQiaQx0mE7q1GFHHYVdUoUuWmo//9AVV2Si725rKcXMydOQ==@vger.kernel.org, AJvYcCVmoQcRr6MrInIgWLapt8MDYiOcThi5zbQUfieajtBOpMbdUy9H7GRM0L0Jbqnt5c7VNTM/gkUbYcmGlX4=@vger.kernel.org, AJvYcCWnlDscV4feUVuGlO1OIaWdvZjVK6znaMAR/MHrL/3D+AGMbHrQDCZeB2wMSytBUllx/aa3nbPtOe+T@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2acbmFhQfQMDV9+7XDncJ2KQxtRh9tpQd8ZwaLLM5k+0r8s2D
	gzSXzqJamdk7pAuy5GS8C4r7ZOwv/YziC5n4NiAYOYS3H0qVopj8
X-Gm-Gg: ASbGncsu4+RrqHRhH5Z3630l6aBTI/mTOa6O6RdCee8Wv56dlsusqUaXlBOVDcX/jkn
	I96BFSj600NS9rKbcYJPhbIdvtY8/0bKgWqYEJ48AyUdBmBvqJxTEVj4sqYa8/iObVzffGhC8KW
	O0eCYm7gufKYp4WFerw/xfw5N4LtdwagarVsF5cZJK4P7FvvYuIT/rugVIVdq2QA7VM7uOHX3B5
	hWEm3DAeacaAE39xDCpiokS2/+2R5aBa6ZNkzKqlJaYOjYyOxR0L24=
X-Google-Smtp-Source: AGHT+IF8HVsTW5i+utryOgn5ztd9UTIpIO2jnXnIbnTi49ubQnVwoyiKkRH9bWUyzLDJ6jx/N2MgsQ==
X-Received: by 2002:a05:6a21:158d:b0:1e0:d89e:f5bc with SMTP id adf61e73a8af0-1e5e046155fmr91302343637.11.1736099108489;
        Sun, 05 Jan 2025 09:45:08 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842abd5927fsm27375046a12.10.2025.01.05.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 09:45:07 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 5/5] arm64: dts: qcom: gaokun3: Add Embedded Controller node
Date: Mon,  6 Jan 2025 01:41:59 +0800
Message-ID: <20250105174159.227831-6-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105174159.227831-1-mitltlatltl@gmail.com>
References: <20250105174159.227831-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Embedded Controller in the Huawei Matebook E Go is accessible on &i2c15
and provides battery and adapter status, port orientation status, as well
as HPD event notifications for two USB Type-C port, etc.

Add the EC to the device tree and describe the relationship among
the type-c ports, orientation switches and the QMP combo PHY.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
index 09b95f89e..ff5db8f63 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
@@ -28,6 +28,7 @@ / {
 
 	aliases {
 		i2c4 = &i2c4;
+		i2c15 = &i2c15;
 		serial1 = &uart2;
 	};
 
@@ -216,6 +217,40 @@ map1 {
 		};
 	};
 
+	usb0-sbu-mux {
+			compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+			select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-0 = <&usb0_sbu_default>;
+			pinctrl-names = "default";
+
+			orientation-switch;
+
+			port {
+				usb0_sbu_mux: endpoint {
+					remote-endpoint = <&ucsi0_sbu>;
+				};
+			};
+	};
+
+	usb1-sbu-mux {
+			compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+			select-gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-0 = <&usb1_sbu_default>;
+			pinctrl-names = "default";
+
+			orientation-switch;
+
+			port {
+				usb1_sbu_mux: endpoint {
+					remote-endpoint = <&ucsi1_sbu>;
+				};
+			};
+	};
+
 	wcn6855-pmu {
 		compatible = "qcom,wcn6855-pmu";
 
@@ -584,6 +619,81 @@ touchscreen@4f {
 
 };
 
+&i2c15 {
+	clock-frequency = <400000>;
+
+	pinctrl-0 = <&i2c15_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	embedded-controller@38 {
+		compatible = "huawei,gaokun3", "huawei,gaokun-ec";
+		reg = <0x38>;
+
+		interrupts-extended = <&tlmm 107 IRQ_TYPE_LEVEL_LOW>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					ucsi0_ss_in: endpoint {
+						remote-endpoint = <&usb_0_qmpphy_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					ucsi0_sbu: endpoint {
+						remote-endpoint = <&usb0_sbu_mux>;
+					};
+				};
+			};
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					ucsi1_ss_in: endpoint {
+						remote-endpoint = <&usb_1_qmpphy_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					ucsi1_sbu: endpoint {
+						remote-endpoint = <&usb1_sbu_mux>;
+					};
+				};
+			};
+		};
+	};
+};
+
 &mdss0 {
 	status = "okay";
 };
@@ -1025,6 +1135,10 @@ &usb_0_qmpphy_dp_in {
 	remote-endpoint = <&mdss0_dp0_out>;
 };
 
+&usb_0_qmpphy_out {
+	remote-endpoint = <&ucsi0_ss_in>;
+};
+
 &usb_1 {
 	status = "okay";
 };
@@ -1054,6 +1168,10 @@ &usb_1_qmpphy_dp_in {
 	remote-endpoint = <&mdss0_dp1_out>;
 };
 
+&usb_1_qmpphy_out {
+	remote-endpoint = <&ucsi1_ss_in>;
+};
+
 &usb_2 {
 	status = "okay";
 };
@@ -1177,6 +1295,13 @@ i2c4_default: i2c4-default-state {
 		bias-disable;
 	};
 
+	i2c15_default: i2c15-default-state {
+		pins = "gpio36", "gpio37";
+		function = "qup15";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	mode_pin_active: mode-pin-state {
 		pins = "gpio26";
 		function = "gpio";
@@ -1301,6 +1426,20 @@ tx-pins {
 		};
 	};
 
+	usb0_sbu_default: usb0-sbu-state {
+		pins = "gpio164";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	usb1_sbu_default: usb1-sbu-state {
+		pins = "gpio47";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	wcd_default: wcd-default-state {
 		reset-pins {
 			pins = "gpio106";
-- 
2.47.1


