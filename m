Return-Path: <linux-pm+bounces-40859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F578D1F5B3
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 15:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A58DA304BB5D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374962F1FC8;
	Wed, 14 Jan 2026 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6B+ujYV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC042DD5EF
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400232; cv=none; b=tcNo2pOr5H7nOKS1L6wa41oP2FCMtnIZuII7RT+7wp2l5qn56pNsEEiDZeZgZVN/L94WiwGkrlbLw1tB2WI38vXklM+tlekfvIIAaDOHcHXhpLjeWpwMVLhMdZroYnkeXfK9EFb8FZM/IgruXFFVIr5dl0cRkxcSqDtaLKeSHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400232; c=relaxed/simple;
	bh=Y+qelmK4bAlyv/krT1u3T7mbMOZyLus+NJ7siKthjMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t75WCuVS2kV4dwYENwT0xecvrOQVTID0mFQaIXAS58rju8CibzZRwxjKHsKJms9C1Q5Iw1I3cpL3j0vSBCBRyyWqr/+V7JZu+AHIt7NL3iTUrGuO7GfVp5XtE5GM8iJcSk0Oe2JtqUA7c7pJnfG2rzNNe4dMrshJZjqR416f3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6B+ujYV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee974e230so1005265e9.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 06:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768400229; x=1769005029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YO5IPtO5cdGkzvneXRvi+dlXdyTwC85OfiFr6xfp5RY=;
        b=l6B+ujYVKM1sBblbNAMJCTC70KkS2D6EZxpInI8m5TBmcdckqVhkYCM4Vr0rk3EDx6
         BsY/9KGnUThwD/foFJER3XuEEexoIDAwHBDsePKSNf0phTuxjnPA4obqoNFSn2yHzsN8
         4Uu2hCfrMojRFH4CKOLuQRJxTYRnThz8s0L/fb53Xstj1KP1Wgld44gGJ5yBSQMIG+iv
         SML4SsOoWTobjtV+cRFy6lZ8NSCFzlDMkFYgINR83W16bcBnFScjnIcux4lKXIpEh8SX
         TOW9UyvyenBMbzePgouSlZKTFCvdKTo5QKI69rxxwgBG69G0h8/boJSdaE0u6b3KRJug
         2OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400229; x=1769005029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YO5IPtO5cdGkzvneXRvi+dlXdyTwC85OfiFr6xfp5RY=;
        b=QeXH2bjqdHx9C9y4ZLNA6p46Nc1EUWnyEcPOeSy96NutSLPshpwlH9fqGGmmS3TTxa
         FQmfeGmNwUpLyu1auArrHHZaFzjT5N4Iv2g99hG3QWogwi8Sxr/s+WhPnL0X+brJhGKg
         H1qRk+YGoyGo+bbaeAI5MwCzDbd9v/wTX4X9mJks8FYqabYFXZqWHt2YVTJo0djDXIpB
         yVx91AvHcAMAWjjrOctHx8gw3nPwu+cpteZCZiwkZE9GZ7B7YKigchPcaDcCpGt790yg
         IZ8b5tRH1uYKqg/NP9I+HXhQzL0O7ln9oaxP8NbY5flEgkTxTDzBo7uhDMDlFkngrSUW
         QokA==
X-Forwarded-Encrypted: i=1; AJvYcCWUcqigOr7UHoFlj/s33HMRtk+UOpOlRJ+koFFQ2xKXRmAjBfcb0jCwZ6GT8I2w5sdIKbQse/3tiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dPsUFbTihhNU0DLVtZrVByJAxoejR3Mnc4LugCet2CbJkkKL
	Ro3Z/1tjAS6PRjpthjH2hZ7MnF5pyshX1Toyc3tqiErhRE71q+UkoDa8VnBDQQxbyNMKxzurmDu
	VAp5HGNJKzg==
X-Gm-Gg: AY/fxX4TYG9CU4/waW1jEJU0jfN3OV6kkLODF97au15eygD04HuxwMSIwQZCz26UhgG
	waMaJNNA9qtIa57sbOLhxWNuyPlZtjf8IQfZLdnSeDuPM0UBoRVvHsoIo2WYSsuuGrKyf3UHYKY
	S0d1Nwr5EFLWAPFEhbZ2ECDnPJrfsPXQa+VnznamOFDTZcmi8KITkg6qdzQCwNcds4TnM+w3vnp
	FQqvPVK7b5jqOuaNzqomicsWX2CCyaNNvY4rot7EczGlEcSjxJoKcX6X3BFtsVY5+FXK+GO0gi4
	AKOdk2IojkGsjF0+ocmS94yeykqCypqj4Hxz2yFlDebqyYdzHQPwmt0WD9D5Y7iRHAaZurYqycG
	Pmd3tP4pIMpVEDiDZ9t8vVUvOb4mkvEVoiHPhXiHlc+1WTwVqHMfyslTt5faTR9gIW/2Q3J71B2
	4W7oC2Naecp7oAbUbMHe1shk/BWfFAjik1xPGdBc8AYntOI1ppp1+gVukB+TRW6b2m5NOa3A==
X-Received: by 2002:a05:600c:3555:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-47ee3363c12mr38044285e9.19.1768400228580;
        Wed, 14 Jan 2026 06:17:08 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee57a2613sm29595445e9.6.2026.01.14.06.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:17:07 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 14 Jan 2026 14:16:30 +0000
Subject: [PATCH 2/8] dt-bindings: firmware: google,gs101-acpm-ipc: Add TMU
 child node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-acpm-tmu-v1-2-cfe56d93e90f@linaro.org>
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
In-Reply-To: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768400224; l=1633;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Y+qelmK4bAlyv/krT1u3T7mbMOZyLus+NJ7siKthjMI=;
 b=C+ZHlnpywyNkQkIYeZeMHaDsZBGpz38Vgp8+GMBcn0/FwlaNnjHtHkxAETXB7iXLe1n+GG1Bf
 Y6UwZZFTUyAB9FjKozYqzSJoOTCshklD/jjZIt4actl242H/wICUhN9
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The Google GS101 Thermal Management Unit (TMU) is a child device of the
ACPM (Alive Clock and Power Manager) block, as it relies on the ACPM
protocol for configuration and initialization.

Update the ACPM binding to include the thermal-sensor child node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/firmware/google,gs101-acpm-ipc.yaml        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
index d3bca6088d128485618bb2b538ed8596b4ba14f0..4043a6453a9897b9e1d0e618489f79c19f32f247 100644
--- a/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
+++ b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
@@ -52,6 +52,15 @@ properties:
       are used for passing messages to/from the ACPM firmware.
     maxItems: 1
 
+  thermal-sensor:
+    description: Child node describing a Thermal Management Unit instance.
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: google,gs101-tmu-top
+
 required:
   - compatible
   - "#clock-cells"
@@ -93,4 +102,12 @@ examples:
                 };
             };
         };
+
+        thermal-sensor {
+            compatible = "google,gs101-tmu-top";
+            clocks = <&cmu_misc 71>;
+            interrupts = <0 769 4 0>;
+            syscon = <&tmu_top_syscon>;
+            #thermal-sensor-cells = <1>;
+        };
     };

-- 
2.52.0.457.g6b5491de43-goog


