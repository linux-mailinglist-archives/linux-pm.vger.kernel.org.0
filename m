Return-Path: <linux-pm+bounces-42643-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FCVAp26kGm8cgEAu9opvQ
	(envelope-from <linux-pm+bounces-42643-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:10:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7D13CB23
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36AED30095E2
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F8130FF29;
	Sat, 14 Feb 2026 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODBjkYYD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD73009E2
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092622; cv=none; b=E7pMLKydXbIK/XU3fq4LVc8ARbUseXROwvQr7qrltB6WPylLra8838sGNv4Day1kkVXm0S4acPnGccwI2rRfo09syiq6131lGRQXXGeRqxcLHNo4EQFOKy2lsvW1Kh/rOvfx5Vrdmov1WMEwsMD2iK2XfChm4fP+j1w1Q+bZ41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092622; c=relaxed/simple;
	bh=QZTJEwKYzV2sVRqc06XpTa0kqL6atv45Fiv22ciLWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5FAPmm/HVg9n0PaFTVBIZMVDtJjlatF0mLn+WxL7WxRnzbV9z5jo/CiJSighZC1kvSylq7gUhlf2j5wULQr9iPuecYBP9YymVsEkr2oWb8oIe6Ho6J6hsufbYhsB6a42Gie5KBzHeaR/VY5UWEdqqIRiVRS95uuLHRUOReEi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODBjkYYD; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso2488211a12.2
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771092618; x=1771697418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWhSjDBNQ6gvdK4qfNH6bG1uloMhrN0yff4wPN7T5UQ=;
        b=ODBjkYYDEsgb4K3M/ZMvkTV37qtS4lO/SwQOY1Yqp3P2KEo4JxBtRoL3vlVx7ihLmZ
         ejQWJM3xnSeCNxtNTFj4BsxXbMw11quDSoAqKlmXYmoisOaCRoNdHMUvLTvJhVMClfnY
         Zy/o8BNzetho3EQlhNW3iqwIADDNX93B1nwMyFklZfLdzcDEQRzw0dXLfUzNFlK6cKKp
         TsjSxpCsIPl4IdMydx3J+bIVTEIl4YZfUygUVqMUihVfDvIzyXuEuD1phL/p51DTZKwk
         stFDeo5qMSFfrmt7lXlWpOigotIYRbsYmAuP2AyXvOIKqqOZ7lCG25BiHoQCSow1Pxqk
         +3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771092618; x=1771697418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWhSjDBNQ6gvdK4qfNH6bG1uloMhrN0yff4wPN7T5UQ=;
        b=MRFrY6WcZh9tS2w+/kckAVI29Lr4TLkr2H+sA+/3kdCO8hTJ2RSL/3fGCNvX14zM2X
         Gw5rSWxZ6/SL10grrbaC9TZoqUbjBjK4LWI1iYuQxbt2olVXgjTV/Ac78ok5bEP+kgsg
         E523QAx3r7nguo+MRfJ0QWqc5GZZdb/HbM/9Jew3zSwolTV/DT9CILMT5cD7aw7YQDru
         /N4tWvwCSn71qbPoWb6ybelsFbJjcCRR7XGWnYw+W3BC74oQbNBYn44p4dtzpYmguM4i
         Xm7EdJ2+5lmDfgGN7FOm9aKNbua9aBGUjDPaEb7CqvJKRB+umpkGgdJ2t4rC+0Xdz9mp
         5T0g==
X-Forwarded-Encrypted: i=1; AJvYcCV93DSoFKezROqhBg1zFhj+J4lReJBvfomBLcgFiip3EPCP4Cx6Bd3vsp4ZB8jY6vyqjrTefwthOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwfIgdjTOyqf+gJQKmx52HOTLVbX37osWLYkG0YY+bJIhS5Vd
	PMEGV5UAW2NjV+Q4Icm68fOclgSN8BIWSKypF1CljTI/YfGxis2Z4NlF
X-Gm-Gg: AZuq6aItPHCelLTV/GsvJ7WfmAQ6U/r1tVolXJCqWTvbCegC4gpoGuZGtc3tfm6rBg7
	7hmisCYs1XYoITaK+kKR4Od98St9AVr2fME2aBqd8R7m5wJ3b0uMudKwr0etyRJASo8L+YJay/d
	Xpx6YacH6pPn2RoE/oPIaSl26uVAICrGOBdNzCVeY+Z6eXcMImSyTXSl1zjf0n9xBnmPcBRsw/5
	ch4fSUPPrlgQVjSJm4COQNypbaZMLMvxjbtnj1Q9SrUpAs8ONI1PrtWhvhctByQwElpCc54jykB
	YSEGd8wAkO0+g80OqrGmNVbNThiH8/6NCT/r3PAswklS225jNLaVKtFge/bqdI1LAySihv+A46H
	jHwtfdGlAFQ1LbRu5ZrCgmCeS5Eu9VNoVRBV+8HM8WTnYfMFBN3cJCZD6s8cORZ8Cr/szt8YazI
	U5XTEaBhgoVuG3YJrsbIjigPc=
X-Received: by 2002:a17:907:3e8d:b0:b8f:b32e:e1b4 with SMTP id a640c23a62f3a-b8fb44a8219mr338323866b.42.1771092618132;
        Sat, 14 Feb 2026 10:10:18 -0800 (PST)
Received: from xeon ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735e506sm88122066b.11.2026.02.14.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:10:17 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Sat, 14 Feb 2026 20:09:53 +0200
Message-ID: <20260214180959.30714-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214180959.30714-1-clamor95@gmail.com>
References: <20260214180959.30714-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42643-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_PROHIBIT(0.00)[0.0.0.19:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18D7D13CB23
X-Rspamd-Action: no action

Document embedded controller used in ASUS Transformer device series.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../asus,transformer-ec.yaml                  | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml
new file mode 100644
index 000000000000..670c4c2d339d
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/embedded-controller/asus,transformer-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASUS Transformer's Embedded Controller
+
+description:
+  Several Nuvoton based Embedded Controllers attached to an I2C bus,
+  running a custom ASUS firmware, specific to the ASUS Transformer
+  device series.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - asus,p1801-t-ec-pad
+          - asus,sl101-ec-dock
+          - asus,tf600t-ec-pad
+          - asus,tf701t-ec-pad
+
+      - items:
+          - enum:
+              - asus,tf101-ec-dock
+              - asus,tf101g-ec-dock
+              - asus,tf201-ec-dock
+              - asus,tf300t-ec-dock
+              - asus,tf300tg-ec-dock
+              - asus,tf300tl-ec-dock
+              - asus,tf700t-ec-dock
+          - const: asus,transformer-ec-dock
+
+      - items:
+          - enum:
+              - asus,tf201-ec-pad
+              - asus,tf300t-ec-pad
+              - asus,tf300tg-ec-pad
+              - asus,tf300tl-ec-pad
+              - asus,tf700t-ec-pad
+          - const: asus,transformer-ec-pad
+
+  reg:
+    description:
+      The ASUS Transformer EC has a main I2C address and an associated
+      DockRAM device, which provides power-related functions for the
+      embedded controller. Both addresses are required for operation.
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: ec
+      - const: dockram
+
+  interrupts:
+    maxItems: 1
+
+  request-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - request-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      embedded-controller@19 {
+        compatible = "asus,tf201-ec-dock", "asus,transformer-ec-dock";
+        reg = <0x19>, <0x1b>;
+        reg-names = "ec", "dockram";
+
+        interrupt-parent = <&gpio>;
+        interrupts = <151 IRQ_TYPE_LEVEL_LOW>;
+
+        request-gpios = <&gpio 134 GPIO_ACTIVE_LOW>;
+
+        monitored-battery = <&dock_battery>;
+      };
+    };
+...
-- 
2.51.0


