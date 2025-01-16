Return-Path: <linux-pm+bounces-20565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462D3A13F57
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA2B1641DD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19222CBFD;
	Thu, 16 Jan 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kmx8qAMm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337322C356;
	Thu, 16 Jan 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044777; cv=none; b=FmqhHL1Ve+y8bES8p/mMtB1M+lNHjnIlkQGTvnXGhRaLXv+g4TXssApKVIduMl3BeCfn43BLIxcvTvNt/47sDMJbI3fsnfZVn4g163baOoW8b4kOe1y1Cy8VQQtPb4bd/NYUiXObygbpbCIYPC1t8Gb4OB2Rs6Jg/OWQZtnxbpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044777; c=relaxed/simple;
	bh=ZWC4hTW8OX+rf9YyrITr/fbrivvcEKd/ZFRltutvR5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FF3hgEuVndOvV6RRq9aYJUZMmLwq+CejSLWXx5Lj5Lz3L+IT5MLyjmFj1qUP1/ZscYO9W1D10tik8RBfBq7c+zzkGQmNlw3vLxQPQd1dfMGk2OImxDbgI5PmdzskLo1ADtWVRHHy9japUVwIbHJqJXafDLeiATfvZ03/8bmqAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kmx8qAMm; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso443457766b.1;
        Thu, 16 Jan 2025 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044774; x=1737649574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXFt2Epd/aqgYjad/PpLtB0pMU+3tYAiirkAkrUh6A4=;
        b=Kmx8qAMmoFehAyxMraraQuaePXjkGudJ42CiHM95JsH1UFrTcjmBc/kJ+zhfhXdtSz
         w1DjVROIQhyM4yJTccHUinPf0rMYJvP6PYRLrWxBW7coHqXIkVVfSWUgfFyWLOZy/yTq
         bDg9cCRTI6+NmwWd3o8IA8j1/PjGRqEfnKtUInpPCf3HaqZjUfSqADv2tsZ54ochef7/
         33iGEPPxPwU+o0r05axDeuAmyPxqcYeucqUr9B4HXqW1yn6Ru1X4KGMsfUG1ND40OHRA
         sNg6ZyVAzOjVylab+pBS02ZepvMarUyipPtLUOBzb8S+f0fsbaX71y4MOzDhs8LD8gRs
         V7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044774; x=1737649574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXFt2Epd/aqgYjad/PpLtB0pMU+3tYAiirkAkrUh6A4=;
        b=LXdvWh1AzoTBxn/jC6kKyf97+nzjgTKCFRf5OztaW/RwIGa7kaLiFTpTYO5qO6aZ8V
         YZp2qUUjmqgUz17QfVZlFIynUR0VzeLwqKObG1u3VkzJ7KgMuD1ID6kwG5pYDEIicrm+
         7ieFYyzdGl/TZJlwFS8Gcc+qaO9rF1fdTh2FLiAMl1jUYZ3A4g0x2Yr57wY6LGbGwe03
         4kHN62GdPGgf4kGaEAatGWt3k4xiz/ZecBY4bAcu+VbFLOJ+8iYmbmI2HUU6/i+1pe9m
         0oV6x/MuawIr8A6AcN+WFjhSmLHbL356aAynDJwySxbGU1icE5nAqlX3hdHoX2LM5mLG
         bP0g==
X-Forwarded-Encrypted: i=1; AJvYcCUEFW+jrIGqta/T/lcv+AZlAN/AZDWLOxUkEWnqRqMewK7J7mDsL6BpbdPdunkcqgfEDX/XDlW7EE3sQg==@vger.kernel.org, AJvYcCVnFUsmX7tkS/BlkCviv3Cf6ouYbbGMMoGe0tqQH6XqA35xjPDbOPC+xq1wjPb6QTqrDDpvPOloXnpz7BM=@vger.kernel.org, AJvYcCWN6IVr3jAxbdVanx+gx/qn6PmGZYcGOlqVV3p9+q0IT5TxXSEho7rBI5GQWyrvmHhMZZUUnD2Thurq@vger.kernel.org, AJvYcCWibkOrVpoU9+WNrgyfec50xryaz4lw5iJvmmYXpiCrmG10LSRVdYnKU7LygisEmtYDjQh7upPDaImYe+2w@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6KHkQGAawhLLS5UMwxmm/6yFmtcLBTfF05JJKaGgo12KmM1t7
	j+bIBtko7fGJG+NSIvKI02/aA4XxUnU+gK5dPAWARg92JOvL2YeX
X-Gm-Gg: ASbGncuVyKUYGgR4tmhfpe88HxVega3zn84MQbukV/7papQRnDlUxCi8niloHhAEmNZ
	vsr+PgylMpU0Nx9K/gCGsc2q+V7cGLvZmNpE9PnsaQMH3UAp1EIqmchrK7mEqVxb/FqAXyMVU8H
	9adYkg4lw49NZZWfK/UmxiPlJNtEU8y6NbILMFFKDMbSmT1aVWE4V7GQJkGsgfSU+jt/+mCD9DF
	NlM2yVAdAntvoYQoREto0Zsz9reuPdvPhhESDblkbuwu1j9QY/EqGhs30948x/gfFla+NQXiW9W
	EaKkKnhzKOX3IZI21gTjmiMsag==
X-Google-Smtp-Source: AGHT+IFw1529xtXZ3ZEhNX7u6jdg10OiLHBCTi8Q9lkBNw9+YNtelskAAMCn6Kgf+Cz1KGnxL7Amng==
X-Received: by 2002:a17:906:3b47:b0:aaf:1f6:7423 with SMTP id a640c23a62f3a-ab36e3cd5f2mr280401066b.18.1737044773844;
        Thu, 16 Jan 2025 08:26:13 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f29260sm16411666b.94.2025.01.16.08.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:26:13 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 16 Jan 2025 19:26:03 +0300
Subject: [PATCH v15 1/7] dt-bindings: power: supply: add maxim,max77705
 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-starqltechn_integration_upstream-v15-1-cf229de9f758@gmail.com>
References: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
In-Reply-To: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737044771; l=1879;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=ZWC4hTW8OX+rf9YyrITr/fbrivvcEKd/ZFRltutvR5I=;
 b=6p1xJMPLgPJPO8O/56VSL0lJr5ETi/KdU6+IugQFOoAZHP4FIu+evJ7XtO/ADc+vmHF3tKSID
 UDaA18tE1FsAMOOt7W+/z8kwWx9Uclb1dDaKNfZBahb8IhuSSPaYBps
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


