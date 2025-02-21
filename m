Return-Path: <linux-pm+bounces-22613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA59DA3F137
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 11:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8F83B158C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54A52046BF;
	Fri, 21 Feb 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML53z++A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D0200BA9;
	Fri, 21 Feb 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132008; cv=none; b=moMyxvKPKkRQXAIGcfyTq3F5uCEK9mQrSv6PtGt1Wn9iOsUvX2UbH3lxhcMw/INHBY2Ta/6TCQ63Ob3HGTrr9Nx1iK/W5hIiGA+BITIbsiMC+5DeqD3BsYOOPbwBvBPnTbNAHgW3iS23MZXNTsh5J+eWwZIrZhI3DVwhL0T5wP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132008; c=relaxed/simple;
	bh=nIOFWVmd/JMC+3Ro7vTIV1UutBWeWQa+OJXIXkFTUs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdCWFr8g4zp4WTrEQSADttupavOrc19YwyhjlU5HNqBVLGS/6zxCU7Vf3WSQNvWk2uQy05vDWmIoLNTgawp8Ldj/zcOcyzbi7ERj8Q0qm+pivhTgRjpMXCUYr8k4mXvqwh/K2iq27Jm6wTf3ExX8Vxhi4GOd5rbwpsPMrEak8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML53z++A; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-543cc81ddebso2250705e87.1;
        Fri, 21 Feb 2025 02:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740132005; x=1740736805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfDXRahch+mGAb+5EJrG5qD8Zr/ha2xtLg2Rz21F8Ik=;
        b=ML53z++A2ST1JOg6EynaaxwvBxY1iEUl+wB5mJNvKuQv/zaZ++eyR33uolyjQsFg0H
         k2nkgjPGsfsHERdc2N6A2g+LGKJ0ZMIdtEAhog51BHueO3HXG9sSkR3VStg02kal2l59
         ehYgfopcINfYC2uDtnRevuXfwIeq6+gUMLbdx386dhTsB04g3Qv9G2c+PUa5R5o7n6v9
         HhdIpmcLP71lvRDyJHKOcYtpdusAPS2BBGOtvfeDwQnbJjOA2oiAIk1pKR91YpvR0DKy
         eCmy1t7hdx3KrVx0smOo9f+y4d9HTT4suIaie24lJk2Gmtc/bkmNBpn7lrUg9Ybzs8GO
         xTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132005; x=1740736805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfDXRahch+mGAb+5EJrG5qD8Zr/ha2xtLg2Rz21F8Ik=;
        b=jUJJZtY9d00wMpM9A9eWws3D9wxx63CtEuXafCi/VAhdwL21B/X2QmaHxuf7lnfUTY
         G8Z+eKTrl5dV81EVs/IoB7C8mUjDCehS13x3Q6z8LpRf0FvPcYfFE3U/Cqbto7MxzcyQ
         tDilMgEKnE4VNR702gmWLtC9ysl3F5PAPlXBQRt4Ja7iJGgKmJXdKKQNZUlSr1q5H0Ds
         oXgp9PkPYoJd7ZMLHSezcz+0ezoSdjA96NC4jrSdmSl5cQLuSXPtQpIQdmQRYgQ6DImW
         crpRYs3tjmhkht6yeg5R35ReavY0fO1R2YaSBaXTrhyazVtgNgnhLOESQE9RTEIYsif5
         wRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV15k7IZfNPiQfVUlKXQYC7StmeAZTbMuCD3JQ9V8Wk5vSBeDV/aYkXllifzo10L+xi4ImMVWGKPfKn@vger.kernel.org, AJvYcCV8TbPyH2ULthjidE55M9pEE4mmKBcs5ayX7JbWogn8zx/ApOMafpEiJFoB3Ok9i8Xn1kuIhZPS+sis7Sww@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/PJ7o5+IbjmdAvUv5pqlmONowlBmBDGG6QBrZjBdP7rxgLrJ
	WfNCxR/Lr0ln69ry5m3m1J3Lo5XiFKSlpfg6Z6kI+9QuKWU19xZa
X-Gm-Gg: ASbGnctrJO5G2UfyOeaUo1IY/qWVFlIQPdLmm2Pq6JD55H2ZXa6fr9te3cn7ps9flX0
	jE870kc5RpcByGs0I7T2BIgWGkDFlV30Bqd+XpvSNC/Ju8c0aTwNj+duijW0O8iIHf4IUcY7S+A
	DRSzKZyF040UksRBRQBRIc6zy0qmry0m6VCD6rBteRYih1x6KNwV2weWk5iLx7qs39gCKIR/0Qd
	3iwmrPoirlPLnCedmW8LfduGBf0ATGqwU/Df0t9GYRlp6cNZp14EviLTljfwKqHrKFaeerCkLji
	+xN1ntnooXDXqguldw==
X-Google-Smtp-Source: AGHT+IHJra5O2ccP467FIY3VWBXraGn81PtengwHmg5FMZr+SsSgF0cfuBBFF/i3H5FhUlB9o0LmSA==
X-Received: by 2002:a05:6512:ba6:b0:545:3dd:aa5f with SMTP id 2adb3069b0e04-54838f59beamr858436e87.36.1740132004472;
        Fri, 21 Feb 2025 02:00:04 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461eb04602sm1604805e87.68.2025.02.21.02.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:00:03 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
Date: Fri, 21 Feb 2025 11:59:42 +0200
Message-ID: <20250221095943.57297-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221095943.57297-1-clamor95@gmail.com>
References: <20250221095943.57297-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Maxim MAX8971 charger.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/power/supply/maxim,max8971.yaml  | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
new file mode 100644
index 000000000000..26b37e6f662f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX8971 IC charger
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
+  charger for a one-cell lithium-ion (Li+) battery.
+
+properties:
+  compatible:
+    const: maxim,max8971
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  extcon:
+    description:
+      Special device used to detect type of plug.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  maxim,fcharge-current-limit-microamp:
+    description:
+      Fast-Charge current limit
+    minimum: 250000
+    default: 500000
+    maximum: 1550000
+
+  maxim,fcharge-timer-hours:
+    description: |
+      Fast-Charge timer in hours. Setting this value 3 and lower or 11 and
+      higher will disable Fast-Charge timer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 5
+
+  maxim,fcharge-rst-threshold-high:
+    description:
+      Set Fast-Charge reset threshold to -100 mV
+    type: boolean
+
+  maxim,in-current-limit-microamp:
+    description:
+      Input current limit
+    minimum: 100000
+    default: 500000
+    maximum: 1500000
+
+  maxim,topoff-timer-minutes:
+    description:
+      Top-Off timer minutes
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 10, 20, 30, 40, 50, 60, 70]
+    default: 30
+
+  maxim,topoff-current-threshold-microamp:
+    description:
+      Top-Off current threshold
+    enum: [50000, 100000, 150000, 200000]
+    default: 50000
+
+  maxim,fcharge-usb-current-limit-microamp:
+    description:
+      Fast-Charge USB current limit
+    minimum: 100000
+    default: 500000
+    maximum: 1500000
+
+  maxim,fcharge-ac-current-limit-microamp:
+    description:
+      Fast-Charge AC current limit
+    minimum: 100000
+    default: 500000
+    maximum: 1500000
+
+  maxim,usb-in-current-limit-microamp:
+    description:
+      USB Input current limit
+    minimum: 100000
+    default: 500000
+    maximum: 1500000
+
+  maxim,ac-in-current-limit-microamp:
+    description:
+      AC Input current limit
+    minimum: 100000
+    default: 500000
+    maximum: 1500000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        charger@35 {
+            compatible = "maxim,max8971";
+            reg = <0x35>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <74 IRQ_TYPE_LEVEL_LOW>;
+
+            maxim,fcharge-ac-current-limit-microamp = <900000>;
+            maxim,fcharge-timer-hours = <0>;
+
+            maxim,fcharge-rst-threshold-high;
+            maxim,ac-in-current-limit-microamp = <1200000>;
+
+            maxim,topoff-timer-minutes = <0>;
+            maxim,topoff-current-threshold-microamp = <200000>;
+
+            extcon = <&extcon>;
+        };
+    };
+...
-- 
2.43.0


