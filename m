Return-Path: <linux-pm+bounces-10679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189FB928615
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA781C22AD5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2335A161326;
	Fri,  5 Jul 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qeK9vaOv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7615F41F
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173151; cv=none; b=O3iyrst11GzoFGEM9fq9XDJv/6LATobFTgxLot6ckU0VIum0WseiqYlwIzI0152fsKMofBK+EtTxIbM75XDvz9v4ZGxMXXm8YH93Oy43eyZi4lp7TmjAMLbyghNTkPweL0mkbMLFJcHImlHRL+uY5I8MOrZi8ji6xuXtwCzLsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173151; c=relaxed/simple;
	bh=75N+YagfjHTq72mKsUwSWer5IrId1tl7O0sy7rhdM/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghQyEfbj2loBNy9Vw2ZNBfH29TAXKAzETvDEHZel12G+Bp60dDPRvoke0As+Ifr3ZJHZXd2pUZt8jD9o3jQ6a+gfryOt2CNXMleE7VktP+j62m6IZzNZDyQzjVjIkcEzWMiuZ2OzNvfC1JtkbsPD1YQmY7Map+RBU3n7VidEsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qeK9vaOv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so12757265e9.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720173147; x=1720777947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuHHBQ3x8j+r0vn0WL5Gv5Q+wv3ro9XtUSu/vLsatmI=;
        b=qeK9vaOv/Wj6CeHPEFWdXNfo5QtObSS/VO+Z/s2/a2rvRrFJP4JuGjCv2MGjIXRTJ4
         H9zYgl1PjCpKmqSGDKydm4CTN4tIIZMQUTfKXdDZd9G2M1YG+YLMJ7gwld4R1s57G4XL
         9bOKWERkT5pQnnx4oqGIeo6M8wL4e7wLHBsXFD9DhmHFLdSrWqSi6RQajS1ci5ekZ+XU
         YUI3s8HyQ6L2ABI1tRyXAKScJc01e2DpVoMxdsQAskHbqfXJZYSTPh3/dPXD8zj1NG/J
         Tl76yeSQqjhzotwEWQp17k+gaNY9xr2wXIGMnCE1g5zpCehBFkC4oBOx8h+fkemXTcfQ
         KgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720173147; x=1720777947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuHHBQ3x8j+r0vn0WL5Gv5Q+wv3ro9XtUSu/vLsatmI=;
        b=M87jvLuo2sIfA1jUF+mxtlhNRRVCXDuTl9reBRsY+TDpT1kuKaL3co+UMy7oYOJ6Uk
         EkwqmyJd7/KZad3m928wDXhPh+RQqSO3OhECLffRZliFnweCle3LpPNvxmxT7Q59vYfF
         Tkvz0AKaR5FpWFu8TcBBrtnWFmYbwpurfC6mfJ2GL0OtSbPCNTIja35Rbg/mgd892Cuq
         vpiku3VcIoShU/sF6ztK6Y6V/jtK+EsbQCR2DZ8PUy5lYXzd3jACUWnUSvYLpYLNo9U3
         qFB2Dwocd2qxkT8RCYRwkpjccGxssk3sxJSDVciHRVSttZBoN3UPJn9q1WcDR44+JVD+
         2KQg==
X-Gm-Message-State: AOJu0YzBsfm3osIX6yuNDJYM3pgu9Y0FooW22RRHx/z8CfkCYU/Jfrjc
	XY2JwHCZWhGUz9AKRnUct/I1Z7AnuzRKSeae4gn4Y5R5AwFi47g+OtkkFBPmXnI=
X-Google-Smtp-Source: AGHT+IGtiZW5kmWQCddksFiLkJ7NLWn4GnHc+gFB6U9WJuOeTpAWLYG47t+3PEzP4kFD/CgwHcu+8w==
X-Received: by 2002:a05:600c:b43:b0:424:a659:c169 with SMTP id 5b1f17b1804b1-4264a3dedd4mr36118215e9.24.1720173147084;
        Fri, 05 Jul 2024 02:52:27 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1650sm55528995e9.2.2024.07.05.02.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:52:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 11:51:37 +0200
Subject: [PATCH RESEND 18/22] dt-bindings: thermal: st,stm32: reference
 thermal-sensor schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-dt-bindings-thermal-allof-v1-18-554061b52fbc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=75N+YagfjHTq72mKsUwSWer5IrId1tl7O0sy7rhdM/8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh8Izbil3cUyAHoOJ1kZMbs3aE0dEw6Y2tk1gy
 NEb1tU462WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofCMwAKCRDBN2bmhouD
 1yD0EACVU5Ga0Qcjk2Fq3mjRRSojMjyY41V+YDOx3XK5fCBF0oNvA1rTr0v1CJoGvWERXxAK1h7
 WCGg8YdOhLZ9Y8E4RAII8mxttBUX5/vM0g8x3jMxcpSWcVg4ZzpxDSCjlmhOqF+UwJEvU7bakhl
 PU0VLj+oO5FdpQZY7aHKXdSvo5qSPHfK1lDe6Fb8APHkCTSwPyuN/9j5FKRNXVuRF4lPNFj2nr3
 c2vsX5GUfAb63ctTYD39a57yTpWr0niK+vi1O8h/FvlRrUm7zor1BvDQDKwiKMszV1+YSkENjDn
 BacnePry+tKPxV6aiIogHG1XJp4/u/Zum8aSwRfThEIGFqaPg1o/9WMNdj/GjxX+KHKITVHP4s7
 A/JSOsxdxkfsLAtUpma7Nc3xFnDuRSgjuVzes9KVBcnPptddMB+SXUCcAxIlCBY88FZvPrJEoQ+
 C861uT3h0T46CechOycWu7onZjHx4E7q5ZGL+mi6ZvNIVDX1kjOHoN12VjhWTVGnR58B5iiaHet
 Ry/HDQUbP9wAbIPi8MuBcvfWeeKxBlanFrWT5lT10E+b/0vZ+EYnPOzi7FL43Nv3jUsLZ9h9s2X
 wIbik/HSCMyp1mQ3AllokuQwhDFcyaYAFkoyyDkg664V+8lpx1vLSTfDUp0dRIJpZGv+2IJwFl0
 YGJHO4sx4OcOUsA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device is a thermal sensor and it requires '#thermal-sensor-cells', so
reference the thermal-sensor.yaml to simplify it and bring the
common definition of '#thermal-sensor-cells' property.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/thermal/st,stm32-thermal.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/st,stm32-thermal.yaml b/Documentation/devicetree/bindings/thermal/st,stm32-thermal.yaml
index ab043084f667..1c01a80a0cdd 100644
--- a/Documentation/devicetree/bindings/thermal/st,stm32-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/st,stm32-thermal.yaml
@@ -9,6 +9,8 @@ title: STMicroelectronics STM32 digital thermal sensor (DTS)
 maintainers:
   - Pascal Paillet <p.paillet@foss.st.com>
 
+$ref: thermal-sensor.yaml#
+
 properties:
   compatible:
     const: st,stm32-thermal
@@ -30,14 +32,13 @@ properties:
     const: 0
 
 required:
-  - "#thermal-sensor-cells"
   - compatible
   - reg
   - interrupts
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.43.0


