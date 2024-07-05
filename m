Return-Path: <linux-pm+bounces-10681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F2928622
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCA52852E6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF01684A0;
	Fri,  5 Jul 2024 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F1W8YXfp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF01649C6
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173153; cv=none; b=GW7Ed4lK2BejoJ8OWlBoFD94bG4egvP9FezoDtqrbkXxwlUXp1ILRlpizqPkWkRl9RbOsHIfVc3FnSLfKmlSKOuQ2zScCId4H/ukMa7SWfp9dNiGWKXYXWQeQdv8r0kb5OnmV2d4gU8429ItOufvICP0JnlMAAkSsbkZmm4CklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173153; c=relaxed/simple;
	bh=v96r53csGO3DPv4xrCAiMuQ7NW/XqKvoTR8Ezj66dsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dn9h//I3p5IiEEJ/PTmc9P3sYIQq5K9+yWz5OdMYo4qGlTmGazDWll6Dytf/wG67hcq5li9GM5vCc+gGOtXJYpH9//+GePvCX4hQBBpf6ufenTG7gOCl942nE4FEJ1dzzRK6SjoG337cJ3njTJzNYfBVQVk/BuOtls5ESf4a9z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F1W8YXfp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3679df4cb4cso900069f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 02:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720173150; x=1720777950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiKGCqGBEkNBKp19buJrLY0hlEyZbTBwZzmTA6yx1KQ=;
        b=F1W8YXfpvFIRybOC1jkihRdbrXYLDevXbt9KDifc+hjaYrHHEpHrHIGqy4/WCGf65H
         5dM01aifwGxgojm/F272uDUyqkqzA2w73SIdDCWFkToxyTBO7Tc6JUHfoktksHQZFWlz
         ceG4e3Ovb5fm5HntgqGVjPXz9+mySJ1afLVHFjCndAaN3Ssfjmc4AFohwyev4RAgJPgS
         2eNt1hu5hDCaJsB4h10hiYTcUv5zl0HdGFGpsL1JgMWBaEPIXPnabbNGZuUBln6OE7Yl
         oJqCcn/ydMyhypElphB0WNWbstNkMgwC35LTisAZoAG6lZimTyEeaiaxKCvquMxjZ5eG
         hrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720173150; x=1720777950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiKGCqGBEkNBKp19buJrLY0hlEyZbTBwZzmTA6yx1KQ=;
        b=G7cjHyM7xiuYQXewm61IxI4yw615Rzx5GogEpV4OAAUVwBVclrm38UBAwudrqRWAT7
         b5IXuNLYCUJ8xHDXh5nbnwJgme6kjLtYmSUkAKZztSyygmLbF4MQTGo2vaMLJlDoija9
         VWU/3pzuet0Vym++hg9QM7vba5y9D6EfB3dLkPkZMmWsWV5DQlE0NWC4BCxlRUlGEzc3
         Yhqc32pATQt0mzZdSIXpKTs24AMX6rwR8w72JqAmUZkmBBLFZiktuMiZwbURvE/umS8c
         wUjyd4Mgf+ue3G/8a1OGjY2v1m+j8rwjQuxnBkxsG2jSd/manF6AdOxwfUQTwFlSvRRs
         ZQ5A==
X-Gm-Message-State: AOJu0Yz7rXzsnOkIVxipHyWvrzeoPSgczKcqgycV9RZcffbNrXKQ4fgM
	eH8KUQonvN+ScW4puDkyecWfmGoc9mxOxpGduwK19SAmty9sbYO82rnf2RfxBhRwZgRBy07ylXX
	Z
X-Google-Smtp-Source: AGHT+IHYmG0y89BYUT8vEw/rPou2Wxrzc7MA979LcnMLM0W/oRZ4IEsDq5fGw3QaLxwUE+6DoRA6Ww==
X-Received: by 2002:adf:e58f:0:b0:367:9048:e952 with SMTP id ffacd0b85a97d-3679f6facc0mr3592566f8f.18.1720173150478;
        Fri, 05 Jul 2024 02:52:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1650sm55528995e9.2.2024.07.05.02.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:52:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 11:51:39 +0200
Subject: [PATCH RESEND 20/22] dt-bindings: thermal: ti,j72xx: reference
 thermal-sensor schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-dt-bindings-thermal-allof-v1-20-554061b52fbc@linaro.org>
References: <20240705-dt-bindings-thermal-allof-v1-0-554061b52fbc@linaro.org>
In-Reply-To: <20240705-dt-bindings-thermal-allof-v1-0-554061b52fbc@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev, 
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=v96r53csGO3DPv4xrCAiMuQ7NW/XqKvoTR8Ezj66dsU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh8I1/z6BRU3/RDJC8Xbgcy2VEpXbmcaRH/gDq
 mIkZ8QIRNmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofCNQAKCRDBN2bmhouD
 1/uvD/wJadFN1GRpR1hWwHsbh4K+sDkAXduqOrxZRwcvlwLx17tZOnFby7jQRrbipfXERDlCFs/
 xZH7zWloJNAdi8CwbPcj+jYiSEeD9teFqhChIlLshTIvmfJ8tR4MJWizEr+koIoe2XXG4Io9WJ9
 6LwU443JAlf5eR+5jr3Q0LmzluMIglz70AhUYgLdZWm3lDmMdSAgCs3fnrCG8HqkHIuzePig2JL
 h+JIfqND6tjmDd6p7D6h7lOBgWErIE5a0gAzsCaxYK1aL4acUMhb4zefZ3N8Xe+I3SCR0D4jVLC
 JDINEcyIleVM9VRFQsPpqLvENvzTEsptt4dsfvcvwrvt2CqEgpmUaj1rhl7hXQ4ss7LNxOn1qIe
 NQxV1w67W++8F+D4TlFCwBrjbWLlz6JnrqP942DTNoNuZX59saIH+rNuCjHpt7vDMQ/v2e54SoQ
 UpuujUAMAwf6zCozSGEDTsNhTtFoE3M9aPhDQ8P+4iR1OQjwmMu4pYGDowh9CvP3YZOMjKW/MRO
 JpMxOWAKWnHbsfoWCVQjeInjQF+R5HhgEl57whHYOpjKIGypZxg0ECn3+gAMtanY2Q7S8uIkydY
 Gr950r9HZz/kfCG0CLZYzavj2qhZKkiJbOzLkA7TwfkRJ3cHx2wkHAEpDbilcOjGzdSj+EZflX8
 awhUAdm5Ubnrr8g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device is a thermal sensor and it requires '#thermal-sensor-cells', so
reference the thermal-sensor.yaml to simplify it and bring the
common definition of '#thermal-sensor-cells' property.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
index 171b3622ed84..82b77b9795a3 100644
--- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -22,6 +22,8 @@ description: |
   Temp(C) = (-9.2627e-12) * x^4 + (6.0373e-08) * x^3 + \
             (-1.7058e-04) * x^2 + (3.2512e-01) * x   + (-4.9003e+01)
 
+$ref: thermal-sensor.yaml#
+
 properties:
   compatible:
     enum:
@@ -64,9 +66,8 @@ required:
   - compatible
   - reg
   - power-domains
-  - "#thermal-sensor-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.43.0


