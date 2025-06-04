Return-Path: <linux-pm+bounces-28096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5831DACD98A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 10:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9345E3A4B10
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC0928BABB;
	Wed,  4 Jun 2025 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UdMDkH58"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418128C845
	for <linux-pm@vger.kernel.org>; Wed,  4 Jun 2025 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025156; cv=none; b=YPoK5sQwxm4BExP07GJPp+2tK8yPvkGh/oNl+gCAhYr4453u93YZMhMc8N8kevhuBikW+4OXYcrv1TDv41S+7dTr0fVzUsgZlPM7cXQMKO2NJBsioCy+f3OESxptrTbEvrxdHT6T5Cdj7uGVD015+ytGA0wFRQZW/ZrbFOkYjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025156; c=relaxed/simple;
	bh=wvvlp9WnPiej2Anmk9dmrJ3Lso/FnNxNqVT6TYuZtPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e83lVMj1zPZVuuQNYMA8oSYNBcQuYr2OfjZv7m43BspU1NevoYHWGCHBUgBtPtkAPpY7q+NNgJbtjrEwA64cGBD7Gm512+b5gDO02OjHfL5V+SDLmcfviPmNwQvketZN/dJ/uQFe2W51TmI8Redx7N4eXAN7WSg/vM/ZaU9g5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UdMDkH58; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450d0526132so3659945e9.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Jun 2025 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749025152; x=1749629952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Qw6Or+h58oEqCHUts11rbHDAhUeBOhLVESvBfOylgg=;
        b=UdMDkH584eCRFiafCT7md8NEFGzoIgoU9TmUVU3OCQWbonA5LIp0KubaflUvTV01V3
         5XEEI4SOuukuFqqQ23Xer8CgUqD93Nbn+N//TG4pYGUa6CQ/TXD92uaiEabICRW5FRs1
         miQSQK+sS7EEI+RNOnPSpG75cm5BsxW052xgIjRFcr3WlhHGZzBVeuTl/cHyA1j3/2s3
         fWeNckIDU5Gy012/8mqwAEg9yALEh48SICtp2A6vvxVKV1cyn03OjpIcjNO9+mEtou9V
         MrYmO4yEdGOf2lHMryXrf/36uz6FoORPfZoZMWyUCNZ690OWOAlpTN3/hKXDnSr45dus
         rk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025152; x=1749629952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Qw6Or+h58oEqCHUts11rbHDAhUeBOhLVESvBfOylgg=;
        b=K638/cskhUEs6GNfMT1g8BF7DZQKGQ0+Pcmsu5KYCBCKdhwL3ULBMhM7780EzsSlt8
         +GitpJRAIBz0N3E9b2KEV87d5lfNItR9GHzKVyUJ05lmqeL1Ec2txGo825vfcKRxeOxV
         oBsVL6SCBKmoPO/DfDwQNpFT4zPQQvO1Pp1H8Td8lH/Ga/Xh/KP9EPrkQhLqbE0oS+oT
         g0yuXgY+S4yADikbfHGFHNi9mykln78W5BsuJF1HYmLmg3ls87R6BT2XUDQdHZtqVmcM
         ppEQhd5RalW2Paw9hhtyLTSVftPcpnmOToEYYZbNjN4Ba/14qwjhsRBK1iiFqTHuh6A4
         iH4g==
X-Gm-Message-State: AOJu0YxpRaJ3hNlVqTQ+3iUiThJmCTnypdiR4X+ojatgxXtuGfvmIcZO
	ewmpYsaKD9/w1I+i17wdXvsxJMv5OW6wQjzoFpdPCCzazlrtFl3tzUdKzlS10l8jZFs=
X-Gm-Gg: ASbGncvlY3BAG4R3sYEY6c+nksF8f/P2BphiYC3FNBuwubibvpAKni1B/kWgdNC/wQn
	dK0WcUDp64/Cdkc979EKSLggVjHI5HZxAT7hSaQI1XMGqLdVTUY0Ar9hp1virperw4QkIoefUYp
	2oU9NyDgEBC+zB+ot8wXROOBd5RnIDuuDKNoXc4njgaGm+SlVhGDMhSmQ/sMcsq6FALpgZLU+vd
	4YYxxjGPxx7fSXeUpJuj5pQ588gG1V1i1TYoI64BoauRPE0SU5qFCJEz2U5dNGAWKLr4VcoG7TU
	Br6umXHBTtzqMAG2HR55Zqrn7Tl8j27ugzT/+H5STIqScbSGt/STriiw1dOoo6F3OLgvgXHiN1M
	9O8xjzW/u6igyHNx9S9Q6PYWTFL2toxT5
X-Google-Smtp-Source: AGHT+IFr04K63KesyL1eSuBlFeSsSCgX2EYimyEdtYTmwL8awlZ/SxKC+A4RpZuttfPn0Lix1L6w1A==
X-Received: by 2002:a05:600c:4691:b0:439:a30f:2e49 with SMTP id 5b1f17b1804b1-451f0b0f3femr5244845e9.5.1749025152063;
        Wed, 04 Jun 2025 01:19:12 -0700 (PDT)
Received: from [172.16.23.13] (adsl-84-227-104-5.adslplus.ch. [84.227.104.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d80065e0sm198301215e9.29.2025.06.04.01.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:19:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 04 Jun 2025 10:18:26 +0200
Subject: [PATCH 6/6] dt-bindings: power: supply: Drop redundant
 monitored-battery ref
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-dt-bindings-psy-monitored-battery-v1-6-7f755ff75218@linaro.org>
References: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
In-Reply-To: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jakob Hauser <jahau@rocketmail.com>, David Heidelberg <david@ixit.cz>, 
 Dmitry Osipenko <digetx@gmail.com>, Tobias Schrammm <t.schramm@manjaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6847;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wvvlp9WnPiej2Anmk9dmrJ3Lso/FnNxNqVT6TYuZtPg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoQAFwzXo8cYyUwoabmBWLvefsH3r3ispQ9KKAT
 wkXG3wqen+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEABcAAKCRDBN2bmhouD
 16/TD/46tx0MTxmshL3kHc2fwaCy01Hx7gI5qWSrpLmh2rERkCiC01bKAEBaWXgQNIbcndgxvKF
 qS+OaP8Y72+WrttJSDx5LXv0hna18zgX8HS8jmspWPRKfMtm1VEH7QXAWN4E2UvN0Em6x7nTmS7
 BCPYUfBapEETbXtRsFMp+kemH9XGIGxhf+HgJ4RWr7IvN6d3vupMEPPVluronD4CPK7FcBELEI6
 WEgoJ6bOsE1JTrevhKLVDZKzb0WoI5cEA9dy4p8YD/brFPeFerFyiTuw0nec9i7ZEDFU6gquhcr
 4M295gIDHDu1shtw8sHB4p/NSCRcHeaF46mpwf2rbHrtO1dLTXum+EwbpJyx8/4fdtU8J30xzHd
 imC2rwIiZq/8QJFVv7B0PhdP9hYT34ElImTbwNr44heprzn/HzXXfRLIhme0CqwoM5h8MKvMAXJ
 WBSjT+8oybDKVpsOsMiCg4saHZUYTneILVT13KRt0eQu5vgTXzUyqap8p+QZz1CWlW4+9tNWM2g
 00USR4tZXBEHqCkpbCVBV/yT7786P6ScZlT2oPr+39E5N0MiAB55oZzKYSN22D1Rg599RPdcCSS
 XDRb4YO3P47pEofbt6eQy0nM7wU977Q57V/VxkK1GBkDbfLhUVdPNvyMW7yez+xTjdQnYHI9MLp
 xXiJ/dOygkmAr9A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Bindings reference the common power supply schema, which already defines
the type (ref) for "monitored-battery" property.  Drop the redundant ref
from individual device schemas along with obvious description also
duplicating what is in power-supply.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/power/supply/bq24190.yaml         | 1 -
 Documentation/devicetree/bindings/power/supply/bq25980.yaml         | 4 +---
 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml  | 5 +----
 .../devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml   | 4 +---
 .../bindings/power/supply/stericsson,ab8500-chargalg.yaml           | 4 +---
 .../devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml | 4 +---
 .../devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml      | 4 +---
 .../bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml | 6 +-----
 8 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index 307c99c077217ab4b5fac30694a4a316dd51f8e4..ac9a76fc5876bef101bfd5c44e4a759288cd1c58 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -48,7 +48,6 @@ properties:
       battery device.
 
   monitored-battery:
-    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       phandle to a "simple-battery" compatible node.
 
diff --git a/Documentation/devicetree/bindings/power/supply/bq25980.yaml b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
index 256adbef55ebf83f00181d07696c2182787195c1..0b5d005dc7809418073a4d8925fc4937c3a38dcd 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25980.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
@@ -73,9 +73,7 @@ properties:
     description: |
       Indicates that the device state has changed.
 
-  monitored-battery:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: phandle to the battery node being monitored
+  monitored-battery: true
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
index dc697b6147b2130d6b234c26d19edbbcca5a1dff..f7bde324153d8b2144cf90dd850165c2e8d8088e 100644
--- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
@@ -43,10 +43,7 @@ properties:
     minItems: 1
     maxItems: 8 # Should be enough
 
-  monitored-battery:
-    description:
-      Specifies the phandle of a simple-battery connected to this gauge
-    $ref: /schemas/types.yaml#/definitions/phandle
+  monitored-battery: true
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml
index 525abdfb3e2d456bb4afc8e8890cf86be2545ef7..c464aa82255a6839e8416ab84b3f6fdbffb7ec1e 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml
@@ -17,9 +17,7 @@ properties:
   compatible:
     const: stericsson,ab8500-btemp
 
-  monitored-battery:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: phandle to battery node
+  monitored-battery: true
 
   battery:
     $ref: /schemas/types.yaml#/definitions/phandle
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml
index 10bbdcfc87b68feacf2f420cf0675f6323e9dbfa..39914b9e0cf58adffc21c28aa6bfb50e82c04757 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml
@@ -17,9 +17,7 @@ properties:
   compatible:
     const: stericsson,ab8500-chargalg
 
-  monitored-battery:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: phandle to battery node
+  monitored-battery: true
 
   battery:
     $ref: /schemas/types.yaml#/definitions/phandle
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
index e33329b3af6196c8d66f0b32f57cfb14e38f22f8..994fac12c8da0632c05626caa0201524377a7a6d 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
@@ -17,9 +17,7 @@ properties:
   compatible:
     const: stericsson,ab8500-charger
 
-  monitored-battery:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: phandle to battery node
+  monitored-battery: true
 
   battery:
     $ref: /schemas/types.yaml#/definitions/phandle
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml
index 6a724ca90e9965a8a0bceb6d262ecb283e1af005..92e4eb08fd6101936cf74e8aaa34760ed483cb0b 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml
@@ -17,9 +17,7 @@ properties:
   compatible:
     const: stericsson,ab8500-fg
 
-  monitored-battery:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: phandle to battery node
+  monitored-battery: true
 
   battery:
     $ref: /schemas/types.yaml#/definitions/phandle
diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index 3504c76a01d8df2daaf12d91bd86379807a718bd..a90d558e7f864eb8dfbf49490945fa227c91f0d4 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -26,11 +26,7 @@ properties:
           - const: x-powers,axp813-battery-power-supply
       - const: x-powers,axp813-battery-power-supply
 
-  monitored-battery:
-    description:
-      Specifies the phandle of an optional simple-battery connected to
-      this gauge.
-    $ref: /schemas/types.yaml#/definitions/phandle
+  monitored-battery: true
 
   x-powers,no-thermistor:
     type: boolean

-- 
2.45.2


