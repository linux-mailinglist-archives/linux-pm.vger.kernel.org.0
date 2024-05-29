Return-Path: <linux-pm+bounces-8332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6EF8D2CC7
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 07:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430EA1F2827F
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 05:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3978115FD19;
	Wed, 29 May 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Je28Y3DJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137715E5DB
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962291; cv=none; b=Hltjm8p0HklS4OM/uZYKUum1W+EBfTlmSUh0+A1geQmDBvi0OC5QnVw/EzCjTTzhR3dJI4U4FXB/ccH7s+gANWayQeq/1tAM3mOPbXv/nF5PrDnm3qExPdBnUN3oYTjEzaGneYZm2FrmEMfp/IT8eJDtLwl3DJtn+k0ni31ucuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962291; c=relaxed/simple;
	bh=hIvA39TYPLOif8A8RvknSlSb848U6P/fP6pMmPEKIo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+1D6qzIWdkLkRi/c1+2YrHICSOLabNQyaBXVUkdbh68Z9x+Ue0ynjBv7PR6kBfxH+B/RhYEFNo0PHljsZbT78Awvj6lHM4MaY04TkLQIzsjqPOhD4iT8uCfkWRWZpJHpRs+rsr/hxzkxKXZy6+I+FoTRy3/NrSo5J5CGUphS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Je28Y3DJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420180b59b7so14615065e9.0
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 22:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716962288; x=1717567088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KPQvvAhw/QNVA2rWSAmQjx+yY2X/Ig4NrPz7gPkeZ8=;
        b=Je28Y3DJipKUGChDae/YTe8M02WPrsKa+S6tXHsXuShaSWT5a0RsNeIdEmDSnPYwo9
         8Wqm8Z1wA+R0nTlo/fLDmKjq0hFyENrZmfROejmi1NTpxVoac1U0q6aISIdRwEYVCU53
         SxWnR5zKcoVb8FewTwUmJbxbuD5jUGNvmuXo3wOQNZ1QyVqMeGhTuzkP4UvPng+wOyLw
         0LW5XTU4FaFeaml3tBjYetmcao6460KxzOpIrH+TXogYT/pXMo2hlAxZW/4yU9cesK9K
         57SGzSk6Uzh95WQ3qmskBZoZ39sTPgTo3t+aNMlnnC8Jvj2Gehe4Zm7CCR36oA5dY+53
         0XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716962288; x=1717567088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KPQvvAhw/QNVA2rWSAmQjx+yY2X/Ig4NrPz7gPkeZ8=;
        b=X71OSN/3IodAaOqmvIoamotyzr6FL3NgMtjEwTUuhvyVXhFYyg0g3rAtS09EuHgt18
         OhoCk65v8m1jd7aLO1Q08VObQSn/015KcL/GsHv63sR+fpay21Z0agUWlFAE84vIR7Mk
         qPjLS4Rth6LmA5Kf7qqlybiitTvO6YCp32NE4miv1YKGZZnzRdS/miw79i4C3cU6G1ER
         +EAziUrybs92zGN0OPuTbVnotI7/qumUlmaT3ZXy1ciI/27gwRJl3GkrdaNdG4toaVqu
         BRWlgMsFHFvO43nWsDhzldhcoV688VCOrKdZcU1lHIqYz05XI+drQPPu+pyYQKYhiFMX
         d09Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPhP0n0/jnBlqPOo9y7ucq1O6LuLMxyMEFyP5EIEUNIl6IDkZQU43FAAc/Aldyro4QCKJLDQhl8n3j5fmj02bjEQrHx0TU3Yw=
X-Gm-Message-State: AOJu0YwVQv59dJqojTM5WiEVWVtGONbcIjkpnA13y1laqx9EunbY61L2
	2j+7vT+lmssmHSxo/WvU/hc4p1CfLCUO9Kubv/hBxLtRA+aa+RYUyxG05wjX1M8=
X-Google-Smtp-Source: AGHT+IHRHeV/DqymbcQrp2sjzmirZJZlNgRDnEJKkc0ZTQJHByJvNmBGPhTAtrpx/elL6NKld9VpRw==
X-Received: by 2002:a05:600c:5719:b0:420:173f:e1e9 with SMTP id 5b1f17b1804b1-421089e97bcmr98181745e9.21.1716962287803;
        Tue, 28 May 2024 22:58:07 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896676bsm169075435e9.4.2024.05.28.22.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 22:58:07 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Wed, 29 May 2024 07:57:58 +0200
Subject: [PATCH v6 3/6] arm64: dts: mediatek: mt8186: add lvts definitions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-mtk-thermal-mt818x-dtsi-v6-3-0c71478a9c37@baylibre.com>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
In-Reply-To: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
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
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716962279; l=1717;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=ZXPmUPXXFa1JCVfBMk9FrptEjzZlcdWN0z1cSMSnOwA=;
 b=OK85Uj3rrGZKhM3JHH4HH37bvvdgaZPlri/dH9Ot2gzRF2PTxp3xVfjp4zaOTnBta+MXzcw1t
 V4Oh/qlSE9oCfjLLpHptTWE7PqNg4Q/NHo5lMhCIc5HTvkEf+y35Bto
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

From: Nicolas Pitre <npitre@baylibre.com>

Values extracted from vendor source tree.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Link: https://lore.kernel.org/r/20240402032729.2736685-8-nico@fluxnic.net
[Angelo: Fixed validation and quality issues]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 4763ed5dc86c..caec83f5eece 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1361,6 +1361,17 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts: thermal-sensor@1100b000 {
+			compatible = "mediatek,mt8186-lvts";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8186_INFRA_THERMAL_CTRL_RST>;
+			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+			nvmem-cell-names = "lvts-calib-data-1", "lvts-calib-data-2";
+			#thermal-sensor-cells = <1>;
+		};
+
 		pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8186-disp-pwm", "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
@@ -1676,6 +1687,14 @@ efuse: efuse@11cb0000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			lvts_efuse_data1: lvts1-calib@1cc {
+				reg = <0x1cc 0x14>;
+			};
+
+			lvts_efuse_data2: lvts2-calib@2f8 {
+				reg = <0x2f8 0x14>;
+			};
+
 			gpu_speedbin: gpu-speedbin@59c {
 				reg = <0x59c 0x4>;
 				bits = <0 3>;

-- 
2.37.3


