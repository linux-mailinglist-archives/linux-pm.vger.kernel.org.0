Return-Path: <linux-pm+bounces-17268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B2A9C2D4D
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 13:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF411F21C96
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6D819939E;
	Sat,  9 Nov 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdpH/MY6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD734199248;
	Sat,  9 Nov 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731156295; cv=none; b=jr6EklTBVS87VAwwHg1Ph2sxdEEfWlLjZ/qbUXbwdZPkbcdqA93GWLgxk4BC1VnzjRDqtTcJypOw5cmt0mTi4U6ZV/ADPlclFTEdHq78PJKBI8n3vXYXIKfs0N0ZMCgixOwuxua8IL29WFZoPfFm4qd50XO5+8BLAkXUCF8zCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731156295; c=relaxed/simple;
	bh=Ll3+VdQ0C3YJ+cNuw/9xWFDuApiijksTxgD0D7LqbW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lgk1VrbakRBVWzitU5vjArRJ1LxKjAXTS5Fh8BXgjZrmwu/97YOQYSSvWUA4ybYbyIOs82GNug7syvAJCM9713fe7FyeX3K6TTvi2U+LWvfTH9Q2ImFBw+REoMBJwCTQMaYYdJUg81RJCSA5mfsNeIVgOxQq+1HpgSNgQG+5YAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdpH/MY6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cedea84d77so4139348a12.1;
        Sat, 09 Nov 2024 04:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731156292; x=1731761092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59tEYZAbxZv4QLtXinFrkb5WBvn6BEbQem6S6TXlOJw=;
        b=LdpH/MY6EfsG950NmF0hi57ZAyHpmufR6hfiQJmyIiuxf8FUpsp6IuTrR3zQp5xqUb
         Yda9q0g38/R6R1kwok+mW/H08C0G1yY2mbYITiLU6Tb6NDmDl/y0VY4vwkIoR6O0hRcp
         L2qYQvlBJqGkPN1/6ZThxdD/M4mtEIZXVruUO9v5/EhJh0xsFtz0PYyoAkYFwPQl+UCl
         j6u/mYKreBPdilU7BV0t8pCrkXrQxAqOyMQcBWnJqV0lMgOfGhT7EbNd6iixf2bJefqk
         9MS8Ww0l76Dqjkvxy1HqM4xcD1d7Gya6XfE8u90xKgyEbX1cCWqEctN9kYWAbr6WPMP/
         qkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731156292; x=1731761092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59tEYZAbxZv4QLtXinFrkb5WBvn6BEbQem6S6TXlOJw=;
        b=mKWeV8XNJ8yJrC6aovdOePt88yJScTf+J6ZKRA2EZVHRpwzuYEto3zDSk3Bg4A8qhx
         nM4wgwXFfifQxMPRsIZMebGz58oqjcOlZ+4t7pvdubF5f8nsYk165gqDCJlRxsFke7zC
         lX5ANClCRn1drHYB5TK8Cu7KRHgysiUTN8Bn0Tdf6+kkxW4BZ5/SGQwnmvZE6o4YV7Fx
         H25Os7WOPguDMFIymeVZzSPOjzbEaFSxk3ni5AyLjk8Olhglk6c4PWqABfb3zJN5EB99
         mNET8oouMJ/kkrO0bCe7K/PF+Z//GInwv5PWHUrAxjJHC4HbW9MR4tmhxHP9/13Ebs39
         Ex9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO+6HZpak2ytMHct2OnIFiYTQIm0TmMI428DK8oq/vcyaTt7Sfj4nNGpiw3KqeIS4lJCNrjP6qwMb+2yav@vger.kernel.org, AJvYcCVB8k9RPIbx+kp3jvhC4sUqHHIuELHSo6yx4SyqkcMixHOs5+iFWd5n1TBErEILmWKG55umx0qAWOhL@vger.kernel.org, AJvYcCX9bwzf1uxkg0OeNwRCZB47aG/RXBzGB2ikBaMpFd2SD9zXY5uWtcGXe70YlvxiSScuSB+qDyYlSv4GDCAJzg==@vger.kernel.org, AJvYcCXMR6YO0b/NVaHF1xIX5DXKhjZTaMbLwBw/Xct+On8rjGLCXNC3dcFEyX6gkbqovJltxpkYRaTcdb3T0UQrDF8zq0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQs3rVm/zme0HR371aAqePvC4+q/6iNADKy5dic0YqWLLI6f/
	APuxreoAZPwEX/4R2A2VAmsD+ZLxAo+gJQtvtX07zqccpbi26I3jRXjZ3Wxt
X-Google-Smtp-Source: AGHT+IHsmH3XqpW0E30HnDtDXqrPkaKiznFfyNU3gMMTiByURLm3AmURnfa20tdQ+1DxMfZF6+oL9w==
X-Received: by 2002:a05:6402:3507:b0:5ce:d6b0:85c0 with SMTP id 4fb4d7f45d1cf-5cf0a444283mr4838208a12.22.1731156291637;
        Sat, 09 Nov 2024 04:44:51 -0800 (PST)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d793sm2940166a12.17.2024.11.09.04.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:44:50 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 09 Nov 2024 15:44:36 +0300
Subject: [PATCH 4/4] power: supply: max17042: rename maxim,rsns-microohm
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-b4-max17042-v1-4-9e2b07e54e76@gmail.com>
References: <20241109-b4-max17042-v1-0-9e2b07e54e76@gmail.com>
In-Reply-To: <20241109-b4-max17042-v1-0-9e2b07e54e76@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731156277; l=6311;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Ll3+VdQ0C3YJ+cNuw/9xWFDuApiijksTxgD0D7LqbW4=;
 b=CgxjsX+bAIDHBkOI0SqP8ZHxW2061yieieg6R6BPSGwA0wkM6muqq3JM+UwOpuN8nMBZE8qH+
 JYXQoELs5oIAJUPqdLaPEzqqmnhBaJeJjCaLjK07S7pPTZRU6D1PucY
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Rename maxim,rsns-microohm to common shunt-resistor-micro-ohms.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 5 ++---
 arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi                   | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts                | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi                  | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts               | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts               | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts               | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi           | 2 +-
 drivers/power/supply/max17042_battery.c                            | 2 +-
 9 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index d1ad597e0837..754d9ad3d94b 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -29,8 +29,7 @@ properties:
     description: |
       The ALRT pin, an open-drain interrupt.
 
-  maxim,rsns-microohm:
-    $ref: /schemas/types.yaml#/definitions/uint32
+  shunt-resistor-micro-ohms:
     description: |
       Resistance of rsns resistor in micro Ohms (datasheet-recommended value is 10000).
       Defining this property enables current-sense functionality.
@@ -81,7 +80,7 @@ examples:
       battery@36 {
         compatible = "maxim,max17042";
         reg = <0x36>;
-        maxim,rsns-microohm = <10000>;
+        shunt-resistor-micro-ohms = <10000>;
         maxim,over-heat-temp = <600>;
         maxim,over-volt = <4300000>;
         shared-irq;
diff --git a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
index 3d52aa25c83c..0b08d23366d6 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
@@ -173,7 +173,7 @@ fuel-gauge@36 {
 			pinctrl-names = "default";
 			interrupt-parent = <&gpx2>;
 			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-			maxim,rsns-microohm = <10000>;
+			shunt-resistor-micro-ohms = <10000>;
 			maxim,over-heat-temp = <600>;
 			maxim,over-volt = <4300000>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
index 33f398b48119..99023f302a05 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
@@ -11,7 +11,7 @@ / {
 };
 
 &bat {
-	maxim,rsns-microohm = <1667>;
+	shunt-resistor-micro-ohms = <1667>;
 };
 
 &led_backlight {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 90beefaa644f..6f6ce14afbdc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1142,7 +1142,7 @@ bat: fuel-gauge@36 {
 		power-supplies = <&bq25895>;
 		maxim,over-heat-temp = <700>;
 		maxim,over-volt = <4500000>;
-		maxim,rsns-microohm = <5000>;
+		shunt-resistor-micro-ohms = <5000>;
 	};
 
 	bq25895: charger@6a {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts b/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts
index a02ece82ff5b..f5d636db33c8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts
@@ -22,7 +22,7 @@ battery@36 {
 		pinctrl-0 = <&battery_alert_default>;
 		pinctrl-names = "default";
 
-		maxim,rsns-microohm = <10000>;
+		shunt-resistor-micro-ohms = <10000>;
 		maxim,over-heat-temp = <600>;
 		maxim,cold-temp = <(-200)>;
 		maxim,dead-volt = <3200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts b/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts
index f567b7ffb613..35343b1fd737 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts
@@ -33,7 +33,7 @@ battery@36 {
 		pinctrl-0 = <&battery_alert_default>;
 		pinctrl-names = "default";
 
-		maxim,rsns-microohm = <10000>;
+		shunt-resistor-micro-ohms = <10000>;
 		maxim,over-heat-temp = <600>;
 		maxim,cold-temp = <(-200)>;
 		maxim,dead-volt = <3200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts b/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts
index 45ddd17243e7..855f8a554a9b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts
@@ -22,7 +22,7 @@ battery@36 {
 		pinctrl-0 = <&battery_alert_default>;
 		pinctrl-names = "default";
 
-		maxim,rsns-microohm = <10000>;
+		shunt-resistor-micro-ohms = <10000>;
 		maxim,over-heat-temp = <600>;
 		maxim,cold-temp = <(-200)>;
 		maxim,dead-volt = <3200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 2c387c8b6344..0ab64154dc77 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -103,7 +103,7 @@ fuelgauge@36 {
 		compatible = "maxim,max77849-battery";
 		reg = <0x36>;
 
-		maxim,rsns-microohm = <10000>;
+		shunt-resistor-micro-ohms = <10000>;
 		maxim,over-heat-temp = <600>;
 		maxim,over-volt = <4400000>;
 
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index ea212cb10360..497cb6f14bd9 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -916,7 +916,7 @@ max17042_get_of_pdata(struct max17042_chip *chip)
 	 * Require current sense resistor value to be specified for
 	 * current-sense functionality to be enabled at all.
 	 */
-	if (of_property_read_u32(np, "maxim,rsns-microohm", &prop) == 0) {
+	if (of_property_read_u32(np, "shunt-resistor-micro-ohms", &prop) == 0) {
 		pdata->r_sns = prop;
 		pdata->enable_current_sense = true;
 	}

-- 
2.39.2


