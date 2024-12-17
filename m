Return-Path: <linux-pm+bounces-19383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A2A9F5416
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880E7173084
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4C1F9432;
	Tue, 17 Dec 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL/OO8Vn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731381F8F01;
	Tue, 17 Dec 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456644; cv=none; b=oGleuuo70ZGHHkz4XRH/EvGHjor3bYYiEr2DVL5GktPmCNCVINu6JuOvvtcYL+B5TC4/8lIai9zd68TDQMhFiblhrPVjmZL/sndAOMvgsCvN+5hJtUtYq0Ej+tPJiNkDSM8DUSv6f0IVWvckzOyL4/YgrkXv+dFv8HZoPGZqlWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456644; c=relaxed/simple;
	bh=HLrHYIHXMkyG4Fwgr6WuFYzxC5tdGkSvazBo4iDni8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhpDfi/bxR+4heHoz7ivft/Y2HwuowrojZMqcW++lHSh4svOT9VGtcz/TO/SHEkmwzhATwwA+BMp+k5Db1y3KVTuGIBWNxj36q51GB9iSkVRoLTQAspn2rdPCxFOGtEpECZND8XCaKKYgVrQtE2AnKOXjo4g2j2y39oKfC89S/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL/OO8Vn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa696d3901bso1073576566b.1;
        Tue, 17 Dec 2024 09:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456641; x=1735061441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AnNgcY5ekZdw7uqYzFEU9H2mYEP8P6/02tOjay8D1Q=;
        b=nL/OO8VnMaK+p3QrNGAXkPo7IU9du3CjY8fouVL3262BDBgspRNzJmuOX7rk+LbeGX
         koXRWyi3fjNKGpYcKkBwFof8h3EuHwvgIJofCjwXcz7gy+yhZUUsWCiAe3pVZ1JWcAhN
         bXH/9/XhuLdPzk90JbOH1oR72Up+wkdHEOjiEd0uckxdpTrKgIDWlM95p9e9OueiKnO+
         pdDNlSGPTtGXfdg/YLBHI62wnhjRJ1uzYCNjvR61fSGtLvjTR2BOAdXgkgR6Ok6C4fD2
         v2Hwjt7rwwzFT+Ffpy8Rhq4GKjWFBEK/A4H475ozmMTvNdpq+GKGIPB9d05Sy3WJMpuu
         noNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456641; x=1735061441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AnNgcY5ekZdw7uqYzFEU9H2mYEP8P6/02tOjay8D1Q=;
        b=kqIapH3rC8z8KMog6UsIdlRu/g1iM20N7I7n/JMRoYU7MzA8mZPBnDCYop49gp+1dq
         BJ6Dn/AuJ+c/2FPMecVAnjXIJksIyey5op6hqb51vxXZ4NLSiD7X0J5aLxc78+AHFJhk
         NkvXLy28vZICUdTtXD2G2sWUufo3QLvo9IfZarjrHOlDs2qUp0yfGAc7oie/DiMWZwdU
         nV6k6kblUFoaCVWk/QPz8WyPheJxGimDXpv3sjIUZUItEOdnXDqAALIb6CP75zZEbIty
         B9EguQ8slTYGPawLvwdJEGNibrQhIayPRdJxGbmak7IaTWD4QoC0V0834LUrpYhAqdZg
         gitQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm4+E+BCjJ8hJZPryd59Nw1uQwlYlpWArmzuvD2BgCPGX8gK6l9KZIA3ypHqBauSX6M70kCPVitqynfFrK@vger.kernel.org, AJvYcCWpwbMDsv8/438mCZLKcAppxRJzqMQmZPZ5J8aAthrpU1iN3qoy+moI0YqfKJodkG8dT3IVxeC/GWyWfwM=@vger.kernel.org, AJvYcCX+og+HYMfLHbfmynOhx0xfTjjH/aRwq/ID8JQu9wm1wqtmX9tCJQkcsen3anwxR9nhiC1hGolR172B/g==@vger.kernel.org, AJvYcCXGVq2u7+HdY2XJThxp+lo5tF0WiNRipP7wyvBqBcjYdAy48jpYzCpoC7v25h/GsvOlUP37cGAYoKJi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt6T0V4VRFEItxGHVIhJU4DX11LHhQtIoU0xidPm1Bq09Iw0Mk
	Pm+i9uIwb64XNmDvYSek4S+x1P63+duyYT0xoGglq1kP6suSe8vL
X-Gm-Gg: ASbGncvluZ89e94xU9ZvnEmN2+LdivlMBArzJD1mlmN5KsBI3mKmzkIrbFYuwSqRfcE
	L3YYXfTNGwnXTKS023cz8oAZiq3FmGutvI/xR03Jcw6x2X/oiEMsGM3yo638aaWZnYwVMznO90U
	ZxsrUup5JXHA0/g2XMXkdyCmxBm8AI8tfwuKwoxtQHvOKzTAxuPK0dSYl7deg2p90X6SpR8HiaB
	TuXtIIJrgj8ZwIFKNSrfnvpgFlNx+AS7z7wcXXs9wNTjlo/T+8c2/0=
X-Google-Smtp-Source: AGHT+IG4Edmfcef/dr0yYLNFr+03s5FAfwTfyIJ0kgNSIF2POJmxSpsxI6ZjruxttETQW8VqH0+6YA==
X-Received: by 2002:a17:907:9491:b0:a9a:9df:5580 with SMTP id a640c23a62f3a-aab7792d75cmr1457401366b.19.1734456640555;
        Tue, 17 Dec 2024 09:30:40 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm470444166b.0.2024.12.17.09.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:40 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 17 Dec 2024 20:30:03 +0300
Subject: [PATCH v12 05/11] dt-bindings: mfd: add maxim,max77705 sensors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-starqltechn_integration_upstream-v12-5-ed840944f948@gmail.com>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
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
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734456632; l=2261;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=HLrHYIHXMkyG4Fwgr6WuFYzxC5tdGkSvazBo4iDni8I=;
 b=Zvbf/rv/sL68cyHnSXZqMjs8FHEP26M9Gh2YkhBdiTDi0HRMzmUmhl6cwIheaEvE32+gU38FB
 /sxiQ1XOF4ZBzrmmNm6tTnUq/iU0/pbBYxGuwOpEX1TZLDTgHHvA4fm
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 sensors binding part.
This includes fuelgauge and voltage/current sensor on
chip input and system bus.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml
new file mode 100644
index 000000000000..738ce30ca72d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77705-sensors.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77705 Companion Power Management IC sensors part
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  The Maxim MAX77705 is a Companion Power Management sensors part includes
+  fuelgauge and current/voltage monitor for charger input, and system bus.
+
+properties:
+  compatible:
+    const: maxim,max77705-sensors
+
+  reg:
+    maxItems: 1
+
+  fuel-gauge:
+    $ref: /schemas/power/supply/maxim,max17042-common.yaml#
+    properties:
+      compatible:
+        const: maxim,max77705-battery
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensors@36 {
+            compatible = "maxim,max77705-sensors";
+            reg = <0x36>;
+
+            fuel-gauge {
+                compatible = "maxim,max77705-battery";
+                power-supplies = <&max77705_charger>;
+                maxim,rsns-microohm = <5000>;
+                maxim,dead-volt = <3400>;
+                maxim,over-volt = <4350>;
+                interrupt-parent = <&pm8998_gpios>;
+                interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+            };
+        };
+    };

-- 
2.39.5


