Return-Path: <linux-pm+bounces-19782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09319FD683
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463701885EC7
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2031F8F1B;
	Fri, 27 Dec 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf/x9X0b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E301F8919;
	Fri, 27 Dec 2024 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735319752; cv=none; b=dQVNYFt6GskvdXEfNO/3jdQy8BwMk/a67GItOgMdl0SFFbiHwVlEeEmnZXYrf1hfh+txwrwuW6vs3kmeZSTnSgXgMSrp4/X0ZeCopbjNl1xPM168y5JZ36fiGvA4QvpUOSXItyMyakWz4WI09Yjx6W2F1rwt7ZsApcsU2sAebbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735319752; c=relaxed/simple;
	bh=VaewzLqkmqFo/f+oJtEz+5NTANhkoqFsICApE8otI84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnGd5UmlBpkgUWUffVVOjofvClya3MKQcOtdqYvxBIo07fSE+s/p+w4ZWQkEJK155daW0AANLjwa2mhQOTaxwr2gaVodh1mypTFbeeTuL+RbBtos3o3qLn+nzaZ5u4Y3mCcBHDY3t5tm0AKufIS4jstF8dOyDZfUAonSZsUhN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf/x9X0b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21675fd60feso119068515ad.2;
        Fri, 27 Dec 2024 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735319750; x=1735924550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dk+gmR74J3HsavyfIN7Wsm/Odwamup2HkvCFCW1rfCs=;
        b=Qf/x9X0bnvRVmqvbZJm8oqUZmg8xjnqfIBewogy54POvBTvc78V3wKDbLnnT8Qtx6d
         gNuK/GPGj8GEtkyiqXGGHOfUa3KYLeP6i8fEnkF1nYzZG/of8vNjelSz+8v9wN7l9a10
         zFpNX8bT34fFfiNLP7fWe+0YIE8gqTkBh2cUT7xGhSv1csqi6yrdtR37OTs8JrjMacfF
         wxt5uWnNe42jnQ05PJrUnFOm6FXiSaG9BnBTFcrjiHpP/iCN30IAqC7+q0LnoSAfjy4A
         1xeuVu4c/f4sSEyKSwXldSYgv7a8xCYc9/TGOIBqh7Ec4GyHYYieqB0l8ONynad7HodI
         9KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735319750; x=1735924550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dk+gmR74J3HsavyfIN7Wsm/Odwamup2HkvCFCW1rfCs=;
        b=h1Hf6GyVHUlXCxfKe8m6HOmqF64ffQxu5ksrQD16FTpINLvDxsLs2zKU4ZO4jT1gCP
         Jsxn3dfpkMDbb+KdkpKw7Onym61ubUIvbSyNtXeHj7NHd7XbaTyBoqBWpiRCfK0g1B6q
         ShIbdjqVkaDu25wzZjbq1KSCiAeNAXsyl+/+cfTp0sd2Pa8QpY66iIW2zQFVJ7vbsiJQ
         7+1LbdrB1Sof94nCyzy+4YsSCAVSGegDkolwymG3sSkTZed5LgzydJqKCc9PO8/0JWaS
         ojyjp00K5EVYy5xyy5+lYo860/jYW4bthuYs/JMf/qjUjejZxdFrC3fzGgWC8Wi0Vf6c
         cmpA==
X-Forwarded-Encrypted: i=1; AJvYcCV9HdY/lL8w02ucdWAlSmEJE9PDk5AMnhFznyEW+UFK5+rWAcTnqHFHZzbZfZn82PAhW9oL8MI2Amj7QH5n@vger.kernel.org, AJvYcCWFtl9q1gpnfvzd8Vn/COYghZ1VuKnGHmri1n3CVYllXpxFGlDrTEek9arUAfa19OmiK2KLuHUxSQqiXK6s@vger.kernel.org, AJvYcCWdZolycibtX8XihMAQO3wx2qw+oYebNd7IAGdpT2AZD5PyybMLgNOpy4IgWiJwSKPhKHKVQrdlXAm6@vger.kernel.org, AJvYcCX5GjFIwIm+TJcIxMsrpWWD/v63u3BCusqmjQzdiEmx9pVamE8JQZzqG2C9tuQok/NLlxa09WitU1c=@vger.kernel.org, AJvYcCXdMBitplJAvondlahlGeOqeN6LW05z1EBwKpBzZnv0/P+vxIa590CqCrrVdOvekS/9tJhlmcOsNj5ANzx81zwe+CZx7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR0C3DnLKusu6E7LdjfMJo4sphrbM2QbOHYehq6ixXpgnKTkHv
	b9945V4T6SUCr3yPhmedDiCNUxayopdxtM5jLS81BE6CEOHS0xQL
X-Gm-Gg: ASbGnct5kmXHCkZWT9+2bAuocOImWc4nAeoofMthTzMg1dOYR9bhmddlO0xIN6G1Y2t
	/3kVHohsAfZISl/MNdEHkpxXwhcrCsqdle1uMszwhzt5rZOBRpSpVuj8WFbFQtNNsiXX00rWnd7
	8n8FOrkHEwpiNq5NI7KidhTORpP0Y/IztrShiGBoRaBxsAFuHzoSD9ZpCQx47pSgYd5kFbDT0iI
	sIRk8b1b82zGuKLT39MQn0yyS/2xSw0bwJhnh0Nqoc=
X-Google-Smtp-Source: AGHT+IEq2alO2+I/3NjlfOpSaYnmZW/d5WnDYgErefaWKmQMuLwgCzdhT++/c4Hhx3rC9+CzpSfqQg==
X-Received: by 2002:a17:90b:1f85:b0:2ee:7870:8835 with SMTP id 98e67ed59e1d1-2f452f0164cmr42277869a91.33.1735319749931;
        Fri, 27 Dec 2024 09:15:49 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5227sm138566925ad.185.2024.12.27.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 09:15:49 -0800 (PST)
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nikita Travkin <nikita@trvn.ru>,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 5/5] arm64: dts: qcom: gaokun3: Add Embedded Controller node
Date: Sat, 28 Dec 2024 01:13:53 +0800
Message-ID: <20241227171353.404432-6-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227171353.404432-1-mitltlatltl@gmail.com>
References: <20241227171353.404432-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Embedded Controller in the Huawei Matebook E Go (s8280xp)
is accessible on &i2c15 and provides battery and adapter status,
port orientation status, as well as HPD event notifications for
two USB Type-C port, etc.

Add the EC to the device tree and describe the relationship among
the type-c ports, orientation switches and the QMP combo PHY.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
index 09b95f89e..09ca9a560 100644
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
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb0_sbu_default>;
+
+			orientation-switch;
+
+			port {
+				usb0_sbu_mux: endpoint {
+						remote-endpoint = <&ucsi0_sbu>;
+				};
+			};
+	};
+
+	usb1-sbu-mux {
+			compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+			select-gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb1_sbu_default>;
+
+			orientation-switch;
+
+			port {
+				usb1_sbu_mux: endpoint {
+						remote-endpoint = <&ucsi1_sbu>;
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
+		compatible = "huawei,sc8280xp-gaokun-ec", "huawei,gaokun-ec";
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
+		bias-disable;
+		drive-strength = <16>;
+	};
+
+	usb1_sbu_default: usb1-sbu-state {
+		pins = "gpio47";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <16>;
+	};
+
 	wcd_default: wcd-default-state {
 		reset-pins {
 			pins = "gpio106";
-- 
2.47.1


