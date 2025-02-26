Return-Path: <linux-pm+bounces-22982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFCA45A36
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 10:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5E11894A7C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08DF238143;
	Wed, 26 Feb 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwrHL9vp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD3217F31;
	Wed, 26 Feb 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562655; cv=none; b=kS94ZKaz7wlz8gb+9sy+sg+hhtQimRw2ULwfiD1jHlKkupoXCYyme9RLX3JONcQkbylsH6DN4y+v5hWSQQPKZld0QnwvAln/AMg0m5mEN/jACeVRYoQIBMde6mkX5PbQ2RIsh32oAreN0HmbSjW13PdY3AvafZxeeBaAE7EwZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562655; c=relaxed/simple;
	bh=MusHO0ZaWXGB+mcDcphpRMAoAXpqq5VIoT0pdVJJK34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M38/rkLCDUKpKbnhE+hdiCfA5f2gyNRTLtXLFWYpc+kknPMR5ihHML/xQsHX/wJM9bPmgW146Li7Iclnu6EXkMqfwWxaEC9lOx7LFAn4uAdVOzKPAsqi0JtJMrD/R4B8IYG8BGT7ioKe/INUcrQeObv4GV3b++nUjUYAfP20yzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwrHL9vp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abba1b74586so962300466b.2;
        Wed, 26 Feb 2025 01:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740562652; x=1741167452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muRGSQbZM3gGLhgFDj9V/ouivKcQQBfjDHf51T7p3Ko=;
        b=gwrHL9vpxCoS2HYjRgH6p1DBoKXC2OGI8/Gdy+sFm6A/2QjTpJBS/+xjtpJ8gn0HMG
         Sy5Na3Zt0jtCj/5/j/L7QGVPBNmvh7X0zr8gCNXU+ABy4OUWwHAheEV6rvsqM4eFN2a1
         x4VkkuyVR7g8v4ul4C7hfwlG1CWhf6vc1+AreExZ1+aGD5RrQ6+3g63uoUlRECulOaS4
         y8RAplVYIAlHuTvEOdpO6xw30hWRdFI09CZvobzecl1pjbd8KGCZn1nvqOYdWTDvDJTy
         kHr214GZf+ZBeo6x8LpsCLhaTt21KOsRYO77FyCSb8V0uGNu9/vvbtokMeZBDuSGDxIc
         a9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562652; x=1741167452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muRGSQbZM3gGLhgFDj9V/ouivKcQQBfjDHf51T7p3Ko=;
        b=CTtefrDT5Eh1DEyJeTj5tNTn3F2cRxRezHsmxQnmp3rMiGz1+MumTbiXlZfEZn2v7z
         BDQlZKuxs8DcvFtxLFMiNeZebOHJ0xLnbxPbCITJ22M+FMou5CGBYCR/jNmx1iMtBMw7
         4ICx/kGxaODl81iiEDpllP2VMcHds+cC3I8mUOJrtfr+7AvkLxXDp/7H/lgTRmksOoEI
         2nzNUU7b9HXwViJzjEvCrqbm9mFjZMcISDZD9NMWj0hDR3Wcm7fYcDtwmx1U0UKu20Vj
         BUCCESin2l6Dn1u1Z9ur9fqCeeTmZefNQKKy4Um/lUcPXVdI91ibVZ/TV+XF551qAuKy
         Brhg==
X-Forwarded-Encrypted: i=1; AJvYcCWkleDXR8W8CVRP7mWeBH4ET7/ko50bN3PFeMhT9kaPeFSxnIsISnRq9U/x8+RXVHYSnVlLtBKndqMC+sFK@vger.kernel.org, AJvYcCXjbbLeEe+Ma0HNJYnM/DeCG4e6SQq1PJNIDkPoetUQAMvtzmzqTKL1dcbeJ6ZnU61OZ5yRjXIKFOKM@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKjKmZTtUF8rRgq8JTqt86+TE2LwiPQRhHjTUg7qN18879Xpk
	MGqxdvonmh7BQ5bTQQ1RAVa/UxNj4RGYJx5sb90hYTt+xNz5zYB8ttt5Tw==
X-Gm-Gg: ASbGncvyQtvRgTb9aommeDVf3Y8AD8XYBK1Ob8hXaEw+VA8O7G90rbxuTYjFDLMPp/p
	zk4diPVZviuRLasGBLhP2y6oFesinUNFZL4eUbntD1FEacSlbeE7wkhoqK5Ww1fiwaZJuNjzpJq
	RbMpPS03xI8MOfI6K8YjW2qDp1iYUZDVTOgAQOSci811LAoGbHPny/NDtuVWZW4e7Ky0OhIjaNt
	FcsKIwdeBEdtKqGHHAZyfKJh7PptKIfZxh2B9NJt7MJO0giapAOJFesYbkEZIIJJshBc539b3/M
	xUVRJHq1EuoC29dX+w==
X-Google-Smtp-Source: AGHT+IGVZUOXr06HTFxsE9e3jonmkjRMLcXIngTyP4VcqpN0OwwPBRBqalFiRL8gl6/gNgjO/rvuRw==
X-Received: by 2002:a17:907:7856:b0:abb:e967:a6c7 with SMTP id a640c23a62f3a-abed0d3ee9bmr618703466b.25.1740562651718;
        Wed, 26 Feb 2025 01:37:31 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdc669sm294366266b.26.2025.02.26.01.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:37:31 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
Date: Wed, 26 Feb 2025 11:36:59 +0200
Message-ID: <20250226093700.44726-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226093700.44726-1-clamor95@gmail.com>
References: <20250226093700.44726-1-clamor95@gmail.com>
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
 .../bindings/power/supply/maxim,max8971.yaml  | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
new file mode 100644
index 000000000000..91d9fec1d46a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
@@ -0,0 +1,140 @@
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
+  The MAX8971 is a compact, high-frequency, high-efficiency switch-mode charger
+  for a one-cell lithium-ion (Li+) battery.
+
+allOf:
+  - $ref: power-supply.yaml#
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
+  maxim,fcharge-current-limit-microamp:
+    description:
+      Fast-Charge current limit
+    minimum: 250000
+    default: 500000
+    maximum: 1550000
+
+  maxim,fcharge-timer-hours:
+    description:
+      Fast-Charge timer in hours. Setting this value 3 and lower or 11 and higher
+      will disable Fast-Charge timer.
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
+  port:
+    description:
+      An optional port node to link the extcon device to detect type of plug.
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
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
+            port {
+                charger_input: endpoint {
+                    remote-endpoint = <&extcon_output>;
+                };
+            };
+        };
+    };
+...
-- 
2.43.0


