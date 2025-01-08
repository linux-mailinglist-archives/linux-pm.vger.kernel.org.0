Return-Path: <linux-pm+bounces-20093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE01AA05E32
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 15:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB81621EB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 14:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBEF1FCCEF;
	Wed,  8 Jan 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp2Yw9xr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421211FCD11;
	Wed,  8 Jan 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345655; cv=none; b=qOkdJDL/h5f1aUPjT0Rtig1h9JTXmiXEYDfbfcvqVXEP3gYod8630c4J6oHMnsfnSqBYGwsVTqcEwlzhYeNjot4yOFvl701cL3D6Xx4dPVejmaHr06H1kifTLvdWqHH95frhrIjZRQBIodBd3sN5seyrlHRq2MVoHZQAPuyl2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345655; c=relaxed/simple;
	bh=ZWC4hTW8OX+rf9YyrITr/fbrivvcEKd/ZFRltutvR5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIqkMsMK3NyvS6GJhhWshQxJNOnDCWe6/ZAewsEpu1IzJuJj2CLKEApImz0U+Lp3i8vtqKmqYvo/KEqjhrRf2S2ZOoWUqTxp8Z230w9ujzFJazg3KR9gj1GHRG8X5ooV6R+RHruLK46Vwtt04PRx5c8GttDuKWf/q0Tqmv1j6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp2Yw9xr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d84179ef26so5412975a12.3;
        Wed, 08 Jan 2025 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736345648; x=1736950448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXFt2Epd/aqgYjad/PpLtB0pMU+3tYAiirkAkrUh6A4=;
        b=Pp2Yw9xrUv9MCYxyy63/pkvYiS4xr2/HaPdzvJVslxq21uXHdFG0xnBupPy0vnv3ls
         mSBFdURXJYMIYBxgPM65tjp9XQK+JaQftLGEMH05kc+FH28/kNApuHKevkwLI4JyCHcN
         W4LIVFSTJh+JslmSEkzEwCkTaguCulzjYUNYlai1ZHfvPp6Z39DyRatZZ149GkeIqeky
         wq05VwcSCpiKGuqUeOKWRpl7kh9/PcycoflI6jQfd/ITfe1hSzN8FLZAGdtssWDG/+z4
         JV4Gw6VVSat+mS9f8RpvoaTbJ843ToYlioYSy6Es9XSCg0Wnje/Y4OD/te+Su5yNXDcK
         9E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736345648; x=1736950448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXFt2Epd/aqgYjad/PpLtB0pMU+3tYAiirkAkrUh6A4=;
        b=QhWpWJX32YDLw4S0UsgPK5z8aHfhsbgoPDVAZq5cJA1I7vSPAVlc1QcvjpmyQLLcRs
         eLW/U50IFY4LS46DWmHPTtauFpvXnz0Oi8gv4SMs416vCd377V8TBw9UdF1Vt4iev0Lu
         WMh1DgP8zwRdFNrNKxonKuId8gCBsAu54tLIlE8qIHWcH2J+PGTi3US5FXzYzhyXq2iy
         hY+4KRUTgmlkemqUBBqJ+oJxku79ZDhNNYzp0Eca7o1ES+Ojr5mkRizu4DWh0arKXqpd
         9BSlzFXpyYU/vd8eZ/alWkWU+cRjZiZ1Wvm4ltalbc9blxWI10RgNX5qJyhfWRz4WoPf
         LZpg==
X-Forwarded-Encrypted: i=1; AJvYcCUzWPSAKcOMzZBsiI+huWnCiqjfTxqZFseno9pUytjX0rbyyqOVCSZpB7RYc4cZilEzK9KTi7lsDkDM2QU=@vger.kernel.org, AJvYcCV8GlCXcQecZdfmLeoeO1Sebec9N4uZj9YIyF/Tyk8f0PhvbZ+ce2BsUjqQNItsJuIADTB4ymtMprOl@vger.kernel.org, AJvYcCVQbiVxZkttTQAvWaR++9cghJyg0vwM3exfYkWJORbSLZ0DHvMWKJlVN+AAM3xIFlF7XsFXYagt/rRGpA==@vger.kernel.org, AJvYcCVZbljxmwmR3k251CcGg1pRkATCUmh2ERBgMHuLzfVlKt8SmD34A0VS1vmRixDuvVp/eINIkwR+fiOJU9Q1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18gT5tcNOjWDPvdLolRucuGTjy2EqqdYps0aK5kUqlAFaBe0q
	kAZIoAgvFh8peJjzKu/PezrA8GqbeSuLmmJx5HS4dtyER47HUvRo
X-Gm-Gg: ASbGncsNbke3OAJtNQoNR1dSyqeemPeHIFPU9J1GTxRksoYaRA43nE8fHs4yob5d9SY
	qAnLGV5ryo/Hpei/NeJEItulWYhW1MGTbOQsoJ7y1Vo+mCUigNfG3aLoW9Ks9Xug+vvgT9jMPB3
	eopp7nnUl26LPDyRW3WlQnaK89nhoGAWI2u+3bToRUzWQombotVbpifj7474ktQRwPh4CTn4wLi
	9u9/aP5AxrzKA0WFQW8ltjTGqi29UmyT+oSmaIOHXnDnN3PdfTSyoc40ms45v51lalVDLUFOxsP
	epsB4r8BpOVUhBFDyIt7OU3q/A==
X-Google-Smtp-Source: AGHT+IG3Kdf6Hk/o2xhM2NHt+WeTs10qrH1U6A2ByuMfCl2hVPCNJfRITwq7J7pdaS7qSNeb8DylDA==
X-Received: by 2002:a17:907:1c93:b0:aa6:894c:84b9 with SMTP id a640c23a62f3a-ab2ab6a4da6mr245084966b.23.1736345647836;
        Wed, 08 Jan 2025 06:14:07 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe4941sm2500562666b.95.2025.01.08.06.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:14:06 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 08 Jan 2025 17:13:47 +0300
Subject: [PATCH v14 03/10] dt-bindings: power: supply: add maxim,max77705
 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-starqltechn_integration_upstream-v14-3-f6e84ec20d96@gmail.com>
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
In-Reply-To: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736345640; l=1879;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=ZWC4hTW8OX+rf9YyrITr/fbrivvcEKd/ZFRltutvR5I=;
 b=Yp9BvFsy6X/ehLRHRe+ZTvpV9JGyjxykHA62wBfF5/7LzyMor8qepyD9tO4VQDjFTC+3krsZF
 LU7osdrotMyBf+Gaz6xYQ6FDlG7kkzYirBjhi/4CnIHuhIQz57Lbd6p
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 charger binding.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v14:
- fix required children nodes order: reverse reg and compatible
- add reviewed trailers
---
 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
new file mode 100644
index 000000000000..bce7fabbd9d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max77705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX777705 charger
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  This is a device tree bindings for charger found in Maxim MAX77705 chip.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,max77705-charger
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - monitored-battery
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+        charger@69 {
+            compatible = "maxim,max77705-charger";
+            reg = <0x69>;
+            monitored-battery = <&battery>;
+            interrupt-parent = <&pm8998_gpios>;
+            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };

-- 
2.39.5


