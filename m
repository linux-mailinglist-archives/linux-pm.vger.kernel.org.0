Return-Path: <linux-pm+bounces-10682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC6B928628
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709C6281D0F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 09:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89B149005;
	Fri,  5 Jul 2024 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGPmBrhb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EB16849A
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173156; cv=none; b=e6eIztDycwqLHyjywXUpTW3GB3/XH5XS5Ilb/Nv3KH0yZDwj0Iiucc4e/bpA+7hEBo7bTnefQxOGGNHmrNGAIjHHdXqY8pU9fpKZRM12aG9PFakx+EnjxnNmTFriCmmMvGV+dJTV4trRFtvt7E0kNsOg4eEW1h9e+LqJK99nshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173156; c=relaxed/simple;
	bh=XNyfNCGFScy9mZ8hCS/9iIypk5k0G+Ilo2PzHccYoHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMbBngBmHKbtjuu0Irvlz76h5JfMfdXAOWpKQd+1HUzKvyHEX+cCJr6kYtAlpr7w2bfaFZ1Tm6bY08JzhZ0eQjgwd5uAq4gIUcux0f5M8dars2CVYbiuLzjLp8t8TabK5jchggXscaT7si1r9XaXNdvk63+rWoNB+bBUEzWz+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yGPmBrhb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so291156e87.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720173152; x=1720777952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHK/qxjThTBQx3yAiyF3Z2q8vhY+c5nKTIQAaD+D4oY=;
        b=yGPmBrhbwfhZZV0EOBTZlEqGVed2h4EKDUUa9gB+7NqpVttAaHdfDDMB/RUSUqzKm/
         l52p2t/jK59crCt/SX3TUpst1bhdaeGYuUdFJho6pBslW5xvDubycPzuvSJeepRo5Tc/
         eHAy1tcvTKvQyacy5ZCzrdUSkThMthNpHQ6GQ+fRRIBC0UfJn17EnBjZe9K5Q4J4P5r7
         NGfUAMa+eYMjus20YLC5jUUMSNtDZd7SzgHl2OFBl9lSDh8oaRZsmdoUfVZ3G2EvGDwU
         BiZd8TV/HjyBfBvvLlBT//5yFW8Pb/NKwEzh3lLGMxglZhCcW3NNzsZaWznBeEaIzw4B
         UYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720173152; x=1720777952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHK/qxjThTBQx3yAiyF3Z2q8vhY+c5nKTIQAaD+D4oY=;
        b=YRmXDAFKaKvo9aRBynQVdLjSfxcG8LQke+hPq4Ay56bnk+NdnVjzm/RS4ERbJwc2vO
         qqwl+Ts3FMYb5k4L9+hWxMoujE1kQ/K5eYiTXX6vHSId4X30FoMFa65fdDrIj1HsFDj4
         WLOBWCwdTwk1vPDxWf3O6FgIaGTrJj0aCCZ/Zrk28n3JeyGP0qOqF6zWBgNc4JiH48X+
         OeS6n41flNRs5QK4yXAOxiyHcz4UOXouvQGmRHlQR72DU/peRKqli1mIDZMUX+8y/RnV
         WX1qBFMs1vstGgpGUKMg+HF9IiktG0H6OlJdYiKaLMTGcC22VSjZZ7TvfSfolz/5BSkM
         ezLQ==
X-Gm-Message-State: AOJu0YyKATjwr4RUKMaYCqvd6t4VbroFH+WXMC4O+YgEAWUToevNkjBV
	BZCTCacRQX914Ry+x1/eonoFpLUXyI4hXn3bgB5vkzVo5em9kA5G2sjIhCkKbLM=
X-Google-Smtp-Source: AGHT+IEK1KKdTzbDztsnn+12R3zWG+9Jig/tlf9CjSDpwbnzRDyxiwqr84PK3eJ7qPGx/h4/oxG65w==
X-Received: by 2002:a19:f01a:0:b0:52c:df8c:72cc with SMTP id 2adb3069b0e04-52ea06bb625mr2380698e87.43.1720173152244;
        Fri, 05 Jul 2024 02:52:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1650sm55528995e9.2.2024.07.05.02.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:52:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 11:51:40 +0200
Subject: [PATCH RESEND 21/22] dt-bindings: thermal: simplify few bindings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-dt-bindings-thermal-allof-v1-21-554061b52fbc@linaro.org>
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
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5012;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=XNyfNCGFScy9mZ8hCS/9iIypk5k0G+Ilo2PzHccYoHA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh8I2NN3X7IIsqrtIAyFnYLzq5eiKU2FODdAu8
 m9zE/RImbaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofCNgAKCRDBN2bmhouD
 11edEACVWgk06f6mBBoU7ppKmkICVWMkDHqhZC5XD4tsFEwEeWIGR3i9N/ehawoJlf81x4kZKoB
 m2+Ny3Lj0kk7pgw4g9zyXaGpdcoLuO6A9C+uH65ryVZIvClp65c3qVptOrtnlOWKSCI/cJwlo1X
 QE5WNsru4dj7xatBg774QL36pO4P5tsBDKEpges7jwlaDM1iKEC3TI935frpKvWRmS6b2JOTHOR
 njAs0ota2n81UZZcSj77goFxYTG+lGTG+2Agig6skKaZrMVvM3m9Dd3tEbYrIQPWSAaEXfRTYIT
 A/2y82Mf0UOlcYBMLrgcUds2Ntbx7vUOjExoOUsqbte8yyorWyu2OzYPc/zlkxSIq8gTj9knSHD
 /+wHokENvv7198RXplN30RIjc17e7n1RlWltCzPmeCB3zPwU2i1Y8DvDXGq5LnnxmeoT2E2MNlH
 PfH33sW0BEgVKI1gtXh2TIFX36/KFjQasf/Uitd6/5bRv/lXW0o8DmbyEhBBu1j6maxzKQe154y
 TsPoDS5ppoa4Z1JLQstMJzilHeQ2OPtUFmYr9EBqUYha4r92tpGW+XCBW8HpQc3iBr3Cx0/8ytk
 bjJaL5+cCMbFF8LF7lxgD4WSxwh7mz84dUgamDnNx4DT0txwejUAnJka/ck7TJ7n+iaYcQyN+bD
 RpN1eJkt201tlFg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify few bindings which already reference thermal-sensor.yaml schema
by dropping unneeded requiring of '#thermal-sensor-cells' and dropping
assigned-clocks properties (core schema allows it if 'clocks' are
there).

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml          | 1 -
 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml   | 1 -
 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml        | 1 -
 Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml  | 1 -
 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml  | 1 -
 .../devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml         | 1 -
 Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml | 4 ----
 Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml   | 1 -
 8 files changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
index 267a0f423504..32730211e15b 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
@@ -42,7 +42,6 @@ additionalProperties: false
 required:
   - compatible
   - reg
-  - "#thermal-sensor-cells"
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml
index 2b6026d9fbcf..ddf0f20e5285 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml
@@ -34,7 +34,6 @@ required:
   - compatible
   - reg
   - clocks
-  - '#thermal-sensor-cells'
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
index e02d04d4f71e..ceef318668bf 100644
--- a/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
@@ -28,7 +28,6 @@ properties:
 
 required:
   - compatible
-  - '#thermal-sensor-cells'
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
index ca81c8afba79..79e691b08341 100644
--- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
@@ -38,7 +38,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - '#thermal-sensor-cells'
 
 if:
   properties:
diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index 331cf4e662e3..0259cd3ce9c5 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -99,7 +99,6 @@ required:
   - resets
   - nvmem-cells
   - nvmem-cell-names
-  - "#thermal-sensor-cells"
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
index b0237d236021..19bb1f324183 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -197,7 +197,6 @@ required:
   - clock-names
   - resets
   - reset-names
-  - "#thermal-sensor-cells"
 
 allOf:
   - $ref: thermal-sensor.yaml
diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
index 972d608ddf95..63a29a1f7fe6 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
@@ -48,10 +48,6 @@ properties:
   "#thermal-sensor-cells":
     const: 1
 
-  assigned-clock-parents: true
-  assigned-clock-rates: true
-  assigned-clocks: true
-
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
index 5f08b6e59b8a..30b22151aa82 100644
--- a/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
@@ -42,7 +42,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - '#thermal-sensor-cells'
 
 additionalProperties: false
 

-- 
2.43.0


