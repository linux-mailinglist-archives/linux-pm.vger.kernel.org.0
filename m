Return-Path: <linux-pm+bounces-17267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE89C2D4A
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 13:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16BAB2185B
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10EE1991C2;
	Sat,  9 Nov 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyTggn1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27781990CD;
	Sat,  9 Nov 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731156292; cv=none; b=Kz5zX9IQW7zZKe1zoqOGMjLWG3KFxwXnopl/J/9b+cP5ly8gM4nGD3NXw+VZmS1TCncguEmA62MVNnidhr/mIafze9/OWh60BdmW8K+LA5vLoRx4z1c5JNOicIerb17SPDe+tEYUPhVO02+7zN/8y0bQjUpJ+O9N/lsGWB3WPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731156292; c=relaxed/simple;
	bh=oX98cqsu9ezhoyh3zMCsqzngVH4022JCLrceQnb5H7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CfjGAMcYQTipO+RwASIv4MpU/zberdwCHIpmScMoFPDYhCJynHV5+1KU+pK9gBfZ+7iHNJrrNbVbPqppOHj6qgWH0y+OfM/ynRRkiTU9Yj1ZyXLW/MybpkLZMVHbcyjL0lBpZTuWbCPhk25cmptQE/8y9Kndu81I3IFhnwA7dqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyTggn1g; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso4002188a12.2;
        Sat, 09 Nov 2024 04:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731156289; x=1731761089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQ9NSVxNmU2bLIFXUwQFB7anXf5+cHYcjGaMIkMwGmQ=;
        b=AyTggn1gooi1Nn6hv4jgWcz7rKRm96xrI1LmhYUVNc6YKgXMR9refCvXO1kxRHNNB5
         qRA0peLRq6FPeqqVSFGGxGOHtUOltO4oLZcAmrkmUJAxQMJuct65dTzISjzRbJ+1J5qb
         o9zDr8xTxRyvXfghSdpqv1d/iV1Ch8wTvm1a+qinsCI5P2GbpPc4X45t+goCjqMgrLmX
         wSliSXwPbgPZ8DQDyHW4gKbA0GRbPGwf8detZaxkZgTKiPIsqMYpaNZSrJR+iIeC+BOy
         8XpuOQvjKV0nqrsnQfLL+u1JJ1Ashhzw7bQ2+wM0NYJEHgrPQZCY/ARH63Xaz1Hxv3ph
         Q+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731156289; x=1731761089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQ9NSVxNmU2bLIFXUwQFB7anXf5+cHYcjGaMIkMwGmQ=;
        b=L+XzmlU00SbMg+R0AvpjgWT+X1SccCZHqESgjmy1W+5lTw/V36EwMPHW1o4C9EqSCT
         Xq4JaiVQGDDPi/y/hF+yCr2LhAJu6rJy5/ifEDYH0F4wQEl5DSaszxAo+TlMpaQz6fxh
         9XVE8k19PxpTuYYDe7kA1Jy+XxS5ljhaOpFzQ6yStK088ARDvxvB2Lo6CixldisIg0jO
         Ic/bD7dkIErizR+FP720cBiEthJkWqN5iCnAo3y6FlQP6cm7G7Isr8aOfEBopJby8n7v
         rvU/0WVreIMbiVYI7rQC8VfzTQsjG8WCOxA02BIAjK1QchVjJTa3+9aMygyxrRqXHL+8
         u7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUqtfn9ALTHRgVY2jBurx+3ESsZmeSj2KlYUScg+LnU1oT/2mN/+F+OiTYLIvPdo/bAQGodYzhBgyyYFbLQGmVMNSk=@vger.kernel.org, AJvYcCWfBt9C5xLDHKKIaP8A5kSKUKdEORp1NQ7/l93qMpPZL2FiBCADeeXhFcXA/ixa3ziIejDmVo/IBcTU@vger.kernel.org, AJvYcCWqPR64MfaBmwTyqNERE8C2yoP6UsvLciCvxVgK8COd0BxDPh9IkaA48/sLiVvA/ldI9c/R7iMj1wu6t7ORug==@vger.kernel.org, AJvYcCXxKhy665MFCoI4souNsAJyE/uuC9rGoovXe5h+HW1du3qJ+h06QMeJUuKOhtdlp2EqZc/FEyL0XkDNcDG6@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6lf/aWgPGMgD1Ib8H/buWdkJXikx2Aeq2JmvMsRo3SHm5RWf
	GQP971WJRt79wkpbW5JyIfUoBh1M7S8RERZwtCSAzHtMybqXEm34uUcj2Mqi
X-Google-Smtp-Source: AGHT+IEava32G9LkepDqhNF98BHoT2kEpMj/WzLFM5B1x5SUXXliyjsQMEGMpaCuJJcC1rJTYXaoqA==
X-Received: by 2002:a05:6402:d0d:b0:5c2:439d:90d4 with SMTP id 4fb4d7f45d1cf-5cf0a45f22bmr4810410a12.30.1731156288669;
        Sat, 09 Nov 2024 04:44:48 -0800 (PST)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d793sm2940166a12.17.2024.11.09.04.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:44:47 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 09 Nov 2024 15:44:35 +0300
Subject: [PATCH 3/4] power: supply: max17042: use microvolts for voltage
 comparison
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-b4-max17042-v1-3-9e2b07e54e76@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731156277; l=7169;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=oX98cqsu9ezhoyh3zMCsqzngVH4022JCLrceQnb5H7w=;
 b=fSAus6hdbJoEivY1qvsqsA9L4OfkV3c0pEcQviAyQ4PUq6GytjxonoqhMMGpCSqQMVG158a0S
 DYpghObEXyZBGANGKXeOJNanilreWXaqeQaSScPgTm2cV2w089dJsIP
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Do not convert VCELL register value from uV to mV to compare
with vmin/vmax. Rather use uV for vim/vmax, since that's a
standard measure unit in power supply drivers.

Convert "maxim,dead-volt" and "maxim,over-volt" to uV.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 2 +-
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts                     | 2 +-
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi                     | 2 +-
 arch/arm/boot/dts/samsung/exynos4412-midas.dtsi                    | 2 +-
 arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi                   | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi                  | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts               | 4 ++--
 arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts               | 4 ++--
 arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts               | 4 ++--
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi           | 2 +-
 drivers/power/supply/max17042_battery.c                            | 4 ----
 11 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index e98ffdad1ec3..d1ad597e0837 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -83,7 +83,7 @@ examples:
         reg = <0x36>;
         maxim,rsns-microohm = <10000>;
         maxim,over-heat-temp = <600>;
-        maxim,over-volt = <4300>;
+        maxim,over-volt = <4300000>;
         shared-irq;
       };
     };
diff --git a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
index 0d8495792a70..0ca755160bef 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
@@ -150,7 +150,7 @@ battery@36 {
 
 			reg = <0x36>;
 			maxim,over-heat-temp = <700>;
-			maxim,over-volt = <4500>;
+			maxim,over-volt = <4500000>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index 9bc05961577d..758bfc10826f 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -186,7 +186,7 @@ fuel-gauge@36 {
 			pinctrl-0 = <&max77693_fuel_irq>;
 
 			maxim,over-heat-temp = <500>;
-			maxim,over-volt = <4500>;
+			maxim,over-volt = <450000>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
index 3d5aace668dc..c744907b7c42 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
@@ -263,7 +263,7 @@ fuel-gauge@36 {
 			reg = <0x36>;
 
 			maxim,over-heat-temp = <700>;
-			maxim,over-volt = <4500>;
+			maxim,over-volt = <4500000>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
index 28a605802733..3d52aa25c83c 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
@@ -175,7 +175,7 @@ fuel-gauge@36 {
 			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 			maxim,rsns-microohm = <10000>;
 			maxim,over-heat-temp = <600>;
-			maxim,over-volt = <4300>;
+			maxim,over-volt = <4300000>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 1b39514d5c12..90beefaa644f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1141,7 +1141,7 @@ bat: fuel-gauge@36 {
 		pinctrl-0 = <&pinctrl_gauge>;
 		power-supplies = <&bq25895>;
 		maxim,over-heat-temp = <700>;
-		maxim,over-volt = <4500>;
+		maxim,over-volt = <4500000>;
 		maxim,rsns-microohm = <5000>;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts b/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts
index 8380451ebbf6..a02ece82ff5b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts
@@ -25,8 +25,8 @@ battery@36 {
 		maxim,rsns-microohm = <10000>;
 		maxim,over-heat-temp = <600>;
 		maxim,cold-temp = <(-200)>;
-		maxim,dead-volt = <3200>;
-		maxim,over-volt = <4500>;
+		maxim,dead-volt = <3200000>;
+		maxim,over-volt = <4500000>;
 	};
 
 	/* charger@6b */
diff --git a/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts b/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts
index ec5589fc69bd..f567b7ffb613 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts
@@ -36,8 +36,8 @@ battery@36 {
 		maxim,rsns-microohm = <10000>;
 		maxim,over-heat-temp = <600>;
 		maxim,cold-temp = <(-200)>;
-		maxim,dead-volt = <3200>;
-		maxim,over-volt = <4500>;
+		maxim,dead-volt = <3200000>;
+		maxim,over-volt = <4500000>;
 
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts b/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts
index eecf78ba45bb..45ddd17243e7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts
@@ -25,8 +25,8 @@ battery@36 {
 		maxim,rsns-microohm = <10000>;
 		maxim,over-heat-temp = <600>;
 		maxim,cold-temp = <(-200)>;
-		maxim,dead-volt = <3200>;
-		maxim,over-volt = <4500>;
+		maxim,dead-volt = <3200000>;
+		maxim,over-volt = <4500000>;
 
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index fbd2caf405d5..2c387c8b6344 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -105,7 +105,7 @@ fuelgauge@36 {
 
 		maxim,rsns-microohm = <10000>;
 		maxim,over-heat-temp = <600>;
-		maxim,over-volt = <4400>;
+		maxim,over-volt = <4400000>;
 
 		interrupt-parent = <&tlmm>;
 		interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index f3d89d4d5c42..ea212cb10360 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -182,8 +182,6 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 
 	/* bits [0-3] unused */
 	vavg = val * 625 / 8;
-	/* Convert to millivolts */
-	vavg /= 1000;
 
 	ret = regmap_read(chip->regmap, MAX17042_VCELL, &val);
 	if (ret < 0)
@@ -191,8 +189,6 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 
 	/* bits [0-3] unused */
 	vbatt = val * 625 / 8;
-	/* Convert to millivolts */
-	vbatt /= 1000;
 
 	if (vavg < chip->pdata->vmin) {
 		*health = POWER_SUPPLY_HEALTH_DEAD;

-- 
2.39.2


