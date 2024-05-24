Return-Path: <linux-pm+bounces-8099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463398CE2EE
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 11:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E05EB21BD7
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B12F12BEBC;
	Fri, 24 May 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cc4UAocn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69912BE84
	for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541495; cv=none; b=N5Lk5cVsRC/uKyi0S9Uy85bvA1ufaKBLw7UKCSucSxxV3X/9FizxxpwtsTDJPssiDvueyAbTLLz3K0fUGxLXOGQ71wOSZMDC5Nq1gx/eLz0xl9Wpi0MJ725LtVBFJYNw0FLgZsfTO8MzLAaIYyfSH2iagOgxe/odYv575b8dk0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541495; c=relaxed/simple;
	bh=D/CwYxUrwRDdDg8e5n5iJwa+Yitdxw7jjgv7JizLHlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3qsDbpdbOblCBQPRZjG277FGbcbN9wxBPLakkyjh3o0WMGkxA0Rx1ZXg+EwE2IYfG4Np++pgm4Cmhz64sQC4hTOWjDx1pWIFhDfquMJQj2HCuv88OoUQ+PpHvKsF9qJTzwrppqqMuv9pWFhzJO3+hUTpIJEfX97A64izE6OjEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cc4UAocn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4202dd90dcfso27890255e9.0
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716541492; x=1717146292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwXTa5ISuv1Kx02m8OOMsEkndfJD0rih1gKoinHaSN8=;
        b=Cc4UAocnzfGky03+4Ql6zUploL9dsQY+cbCk8XAGepBC6ZQCKOUAZ5hDHcDpTrcSNX
         eMf1T07UkoZL8L/HyoeAhpq7BOd6rT//hzSCg28PHojonF+5KS8SZGQP/oHg01EizKJ7
         s0/o1Dtzmcxv9z1IaHlbA1QZs+hvupgdlp3zfF3m8YrNoz50QrlCbBRIytSvBa4sEH6q
         LtPcO3b7g8QrQhKwtz3LA/QBDsO1hOMlr7Q9OSJ6Hu3hm4H+Tjj/m1rbDwBAiMMByRDU
         7ngL6bEidfn+wtdAkWzN+DkaEk/c0Bn86XnY4nWxjM7sQ2zh7FAhqkOD7r+12aQ+2q9f
         HTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541492; x=1717146292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwXTa5ISuv1Kx02m8OOMsEkndfJD0rih1gKoinHaSN8=;
        b=UWluO7iiCrX9XqqVuY+jQNqRbLaXvimD5KU+C7n7S62ZoEaudelKA6SB4RmoYcjD7g
         lo634A0rOquBCkL7iRnvOCgRzKpJdS3uzFbpu1EpDHqWt0EWy3JmqGyZgGAONlRRCYt+
         j7Eo5glasM51LSO52grerw8YPH5gzN518rIjqbJ1ztOo+H45KBkROgemRPYA5FB5ChOc
         UyHoDBug1kOPy1CTwAFWSq566HDpwZqzYXis79hjEOeMdi/m9UNhJZIAFpAONosjchuH
         2e2rFGVGmv0bfEd1AsvUtFLEc+ZnwFS94xK7fQL52fr/boPmyR8mIOSTq103aqpoghoP
         zfSA==
X-Forwarded-Encrypted: i=1; AJvYcCWXyMBxHmKOls7vKjMpXgIrw4DRnfKMCFB+bQIJ9z+9V25uSWaWX/953yrqJVj1CPNT8Gp3YKNnaKNpeWvq5pmnOwL35OwpJuE=
X-Gm-Message-State: AOJu0Yy3noR18ofcJxaTP43bNoiJX7wHL1Mn4J7WfHdKAPTBQl+owvsS
	q4+aTLsKjQ1XtSk7ypQDw/kj5Z9aPjx4c90s/g6vkyuZUI+gjfPWeQ8uDSFlUlQ=
X-Google-Smtp-Source: AGHT+IFenMcuhS9OsEyd+h7AaddD2iy90CZR7BBfUN10hVId+maydXEPDYGko74NzdBb4Y9rrZNbKw==
X-Received: by 2002:a05:600c:4690:b0:41b:f3b6:e5da with SMTP id 5b1f17b1804b1-421089f981dmr13646005e9.36.1716541492077;
        Fri, 24 May 2024 02:04:52 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f163a8sm47273045e9.13.2024.05.24.02.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:04:51 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Fri, 24 May 2024 11:04:38 +0200
Subject: [PATCH v5 5/6] arm64: dts: mediatek: mt8188: add lvts definitions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-mtk-thermal-mt818x-dtsi-v5-5-56f8579820e7@baylibre.com>
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
In-Reply-To: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541478; l=2934;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=UpRqfVTfJj/4HAmfkOjlSQQqb0p0PX5zc+/lgsWNhqY=;
 b=Gx+63BRCjTxPhtYHJO94l+rLZO/giNvzvSPnRBXAOb4fiO0zkouPa+UhiVToPGnfja1IeLBsv
 S8PaOVfWQWRAdfrvCg8GMOaIdgVkSFYOVvrvc50uQVKXzwylwaIGpSm
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

From: Nicolas Pitre <npitre@baylibre.com>

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Link: https://lore.kernel.org/r/20240402032729.2736685-14-nico@fluxnic.net
[Angelo: Fixed wrong nvmem-cell-names]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index b4315c9214dc..a9f1b9db54a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
 #include <dt-bindings/power/mediatek,mt8188-power.h>
+#include <dt-bindings/reset/mt8188-resets.h>
 
 / {
 	compatible = "mediatek,mt8188";
@@ -357,6 +358,7 @@ infracfg_ao: syscon@10001000 {
 			compatible = "mediatek,mt8188-infracfg-ao", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		pericfg: syscon@10003000 {
@@ -491,6 +493,17 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts_ap: thermal-sensor@1100b000 {
+			compatible = "mediatek,mt8188-lvts-ap";
+			reg = <0 0x1100b000 0 0xc00>;
+			interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8188_INFRA_RST1_THERMAL_CTRL_RST>;
+			nvmem-cells = <&lvts_efuse_data1>;
+			nvmem-cell-names = "lvts-calib-data-1";
+			#thermal-sensor-cells = <1>;
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
 			#address-cells = <1>;
@@ -604,6 +617,17 @@ mmc1: mmc@11240000 {
 			status = "disabled";
 		};
 
+		lvts_mcu: thermal-sensor@11278000 {
+			compatible = "mediatek,mt8188-lvts-mcu";
+			reg = <0 0x11278000 0 0x1000>;
+			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8188_INFRA_RST1_THERMAL_MCU_RST>;
+			nvmem-cells = <&lvts_efuse_data1>;
+			nvmem-cell-names = "lvts-calib-data-1";
+			#thermal-sensor-cells = <1>;
+		};
+
 		i2c0: i2c@11280000 {
 			compatible = "mediatek,mt8188-i2c";
 			reg = <0 0x11280000 0 0x1000>,
@@ -827,6 +851,17 @@ imp_iic_wrap_en: clock-controller@11ec2000 {
 			#clock-cells = <1>;
 		};
 
+		efuse: efuse@11f20000 {
+			compatible = "mediatek,mt8188-efuse", "mediatek,efuse";
+			reg = <0 0x11f20000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			lvts_efuse_data1: lvts1-calib@1ac {
+				reg = <0x1ac 0x40>;
+			};
+		};
+
 		mfgcfg: clock-controller@13fbf000 {
 			compatible = "mediatek,mt8188-mfgcfg";
 			reg = <0 0x13fbf000 0 0x1000>;

-- 
2.37.3


