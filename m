Return-Path: <linux-pm+bounces-4005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C0185870B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Feb 2024 21:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9EA1F262BD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Feb 2024 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243E14E2E7;
	Fri, 16 Feb 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xzHP3Y9o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894F14C58D
	for <linux-pm@vger.kernel.org>; Fri, 16 Feb 2024 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115608; cv=none; b=ja24uoNVf79NDXsBCGz/wdeTo6GpB3pV5Gi+4oIPWbTZVSsH3OscY0YLRgY2pXuyvblYLd/Z9VMxvTvrN4fAqbHlcSZ1staMYHV2TTFvacgfoQFv8KM7BPmRDc0jSgGpgqLw9T61D8siIsGfxEcxKtvOyVqLqrSMYQDNhpirNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115608; c=relaxed/simple;
	bh=wwd3Xij+rOHq/CWdFCeH+2K4nGFWVnX35W8A6dmUUSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVN6KRW4bcfnZQdaog1kL99bGOIE0zD266cjv+JJurPJJ4nWUSSFFo4CmS/ayVm7z+99quyj7qmMbP9sD1uICrmASuSA0yKGrghdtpcg+sCfutLEB4w6iMdMcUkFnaz9rHodt5Igb2E6DFe77alG6HDIFjlty6NQ4RpPA56tfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xzHP3Y9o; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41223e0777dso15668005e9.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Feb 2024 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115603; x=1708720403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi8a7IDbsc7NWjITXvW8vzVKHWVwk2jKqzcZASrP8yE=;
        b=xzHP3Y9ofocgeq5RhsS9vy5SmKIlXOnikKLURkiBqIDkswYtPU+ZOHO+xqTxrumgZI
         iSxWmFouzFCfQggfrm5uJyd7JkaAiKoVQaJOv6GsNZGM8ejhlCzZ/NCUinLbKoD9pDYb
         jZm8ggLrbYfCHQbsXkI1VB3m24xFFYfyZXsoJYFIEiK+XqZqNQoTe34/94WGnOdMN8M2
         WazihsqiNR8+jHmA2xrhF/b7dNI8IDamGTm2o8OQ8uIIzE0hSmduvffcLd7m+9ZWswxh
         BHwMqulHu4zPvc8+vi+/8xTrktuKontRPqDR7w8icl12DtdJWM/1qA3Gz+4PIDjFvrkY
         S3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115603; x=1708720403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi8a7IDbsc7NWjITXvW8vzVKHWVwk2jKqzcZASrP8yE=;
        b=DJbb8jEC2FKUzESC2JvC3qWkDJFEambl7d6Q1LJSZbh8RQxGC7Pgs0yd+UtZanUTpS
         gY6ZS1JjKc7CZPwF/4BRuoyLOJLvrNq4q/ek6WDyfQYlcx+39+2rKQhaojlCS8qXtFzG
         BIsSnxi2Ldty08Io0floW2Ij8D1U06HEsn0J1cN/afVbxGYDwhIghfkDHonv4rc/PytP
         jwMsBIJnkOtMUDdWfuME4krWxsjFV29mzHO3ByphzWBxf2+i8LOuBiO1YNOyokVIpGrG
         dptCj3xrVky7eeCdvwkuB/TinoCXELno0h3tN1CNyDOypm6dXIEDp/l/iLasaWKOJpn4
         jS8g==
X-Forwarded-Encrypted: i=1; AJvYcCV9A8KaB1VYwz/ieo5Dw4qCnvbKWiEK6vRQdIZ4lEhbeJ1MjY9r02JGUX3eSPUoPULv4Oo8XVNTdcvqcVhZohyFZ0CaX2v86kI=
X-Gm-Message-State: AOJu0YzKPjxCe1gsHD/QdFLEA+C4Psw5JmU2UrUE2SrCuYdBYay5JKZn
	nyuW6yj9WKywxfgaF+WP705dW/JJSaguW8WP2s98ImTTqdJKnd7nx5bNEDIIeAo=
X-Google-Smtp-Source: AGHT+IEdNFiS4jqjTMwr9bbhFoBmmcjEmHiM7ik8UO5vPc2X24r/EQeJTolFoj1NizIPC6YHWTEuWQ==
X-Received: by 2002:a05:600c:4f0d:b0:410:7428:1fb5 with SMTP id l13-20020a05600c4f0d00b0041074281fb5mr4348569wmq.27.1708115603697;
        Fri, 16 Feb 2024 12:33:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:23 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 08/18] arm64: dts: qcom: sm8650-qrd: add the Wifi node
Date: Fri, 16 Feb 2024 21:32:05 +0100
Message-Id: <20240216203215.40870-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

Describe the ath12k WLAN on-board the WCN7850 module present on the
board.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
[Bartosz:
  - move the pcieport0 node into the .dtsi
  - make regulator naming consistent with existing DT code
  - add commit message]
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 29 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 10 +++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index b07cac2e5bc8..4623c358f634 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -845,6 +845,28 @@ &pcie0 {
 	status = "okay";
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1107";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en>;
+
+		enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&vreg_s4i_0p85>;
+		vddio-supply = <&vreg_l15b_1p8>;
+		vddio1p2-supply = <&vreg_l3c_1p2>;
+		vddaon-supply = <&vreg_s2c_0p8>;
+		vdddig-supply = <&vreg_s3c_0p9>;
+		vddrfa1p2-supply = <&vreg_s1c_1p2>;
+		vddrfa1p8-supply = <&vreg_s6c_1p8>;
+
+		clocks = <&rpmhcc RPMH_RF_CLK1>;
+	};
+};
+
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l1i_0p88>;
 	vdda-pll-supply = <&vreg_l3i_1p2>;
@@ -1139,6 +1161,13 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio16";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
 };
 
 &uart14 {
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index d488b3b3265e..baf4932e460c 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2293,6 +2293,16 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			dma-coherent;
 
 			status = "disabled";
+
+			pcieport0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				bus-range = <0x01 0xff>;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
-- 
2.40.1


