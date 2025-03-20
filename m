Return-Path: <linux-pm+bounces-24328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A0AA6A06D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 08:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5BD422954
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF80204096;
	Thu, 20 Mar 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5G6o5zK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90230A47;
	Thu, 20 Mar 2025 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455825; cv=none; b=CF/s+ZU3lX/RK8b5+M9EdjMgTEhY5ka/+tpIjyIW1ipBWRXXNduA7gsbnwwrRsq52ms22+Mi5e1I2v/JZkQBGHcjhgJHbn6NAbcaUaAggw4ymFr4RfwIo/spyUOSWKb7Xy7ovkfxSI2m2MPUvhtCN1bDHjRwZqoF1eLzg6Hjd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455825; c=relaxed/simple;
	bh=hbyAjHLbBjqr0VU9niJ5oazmJV9tzGU7e6O8esJ6oe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thseyqHh60zp4qP3T4cIokenu9RrCed9i0ObLiqE6Bw65Z16yT51VPT0HH1snECPmkNmTQl52oycVAFA3ei/MNpyayBta6tInKioP8NuqLlrV5fd9rxafS97iGhc97Zh6ywqa8axeGJOD3Jf+dNJe0PS8Su9dv+RrILBno1YHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5G6o5zK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abbd96bef64so94466666b.3;
        Thu, 20 Mar 2025 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742455822; x=1743060622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH4XVjvmSOeJ56MEzJia6DNHDQ7WVeAKt9WlOAudWYs=;
        b=L5G6o5zK/hEuhK+LONYQQQk+gW1FmJa81zL2VdCzmFhZV4BEun27IsxK3lhr7Nqty9
         TBg7sHvLE9NnOOYgk2g1n+ARoWvzRXY7hCAae7gG1fCvgmGENnbB3VtRxKO0e5Y/8LBO
         YZSPDC+Y7Xt3QA7utpJhuk3V6NALPek+boPszyh8ZaaTNcu1/P+wCL+lMBbZR+akYG0T
         hJkkPBwa9C93cujdLRWJKt428f7UdSgzU3U0ZTKeE9ZZ5RNGW6S3IT7AqDuAjbhXZdQF
         uI8LQWE6+mDB2arf9YA8z9wb1NZ38+ItIsamTqW3SrIk17GWIhUtNL/sSUjJdreF740A
         EgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742455822; x=1743060622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH4XVjvmSOeJ56MEzJia6DNHDQ7WVeAKt9WlOAudWYs=;
        b=s5UZYaBoKRT8i2FpQqNPVErhCMrSwEuJzb+US2tsJS+/CXJcXa0PrFt84Tm+KrfWPp
         v6bfcPwGidWc4f/dtjuMzy30NsvO7l8lqJKFTy5c/qohyFJ+X00ZqWmuhZdvTdlDPGRl
         K2g+z04HcST0kS9xIOvhope920QPKouNGxrAeMw12oUVgcb6kErAbWaLD1TZRNf1KNQh
         2yYnD+cPD0D6V1sx+QR5oqNNctUu1e07A8fjusapyWA5dEt0xTE0sKJSibRMJDWKlxcs
         ndltpAz750U4wc1w0S4AqAV8blZauR/sjRCxy25gYccyhKQd8yT4f5ZEGVxDrMciR/rf
         PD+w==
X-Forwarded-Encrypted: i=1; AJvYcCUwPX0S431hy7iUl1InpbOZ1BtRpJJZSlICyIqD948OeUrtz34OuCQblzdnEXiMA5AqmVDisY2J2APt@vger.kernel.org, AJvYcCWZ51baRyjw563b7WdG51k3EhxFDZCtjm8OakhMOTogUsYBzdH2Nyy7BxAI0pseKUGPgkiTeLQw3mvaEdTs@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjgSp8V/rtrBuhgQph1tWaVvfRivkNzncYr84wattHVK1H4z7
	62NqPlrdT/OhWL6AxGoRcu/rKUiwN5Zt6JWVy3JaTXhWpU5QkMPk
X-Gm-Gg: ASbGncs/FlBWvRQol7VVpwTQmz0AdWVOyoyY3DbL+PpQBDY1rt//vZgcTf6bZMvCkHc
	WC/zasn6ZraiGupLH+PxNrAtEa8DTcHx9u1xO7bChtOeA5t5t7yTdm9oa7mfcTigO9ZBDi5wq1b
	70eY8TAvMHDuOpk111sIG4guhUdQyCBVCHgB8TDdC2XB2rTau1zvue8e4pA1C+fcYyyUre7tsRC
	sqP7QfPdSv3hm2wmOwOPrOc91DyznCE085RtAAZjYdGKQj/HXQzn606r1rMTkJhH1dzK3Gwp7yw
	xMmQNcH/VkSbjwfPj8FOO4OprSPwG7sIjdAd
X-Google-Smtp-Source: AGHT+IFTXBGn/x6chxICU5EtsLPZp9H2FEP5/3hrHaq4aQgzpHNAfP/1DfnREO5GKQVs2OdVe8nwWw==
X-Received: by 2002:a17:907:7daa:b0:ac3:115f:453a with SMTP id a640c23a62f3a-ac3b7f63606mr592812766b.36.1742455821456;
        Thu, 20 Mar 2025 00:30:21 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aef69sm1115638466b.4.2025.03.20.00.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 00:30:21 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
Date: Thu, 20 Mar 2025 09:29:46 +0200
Message-ID: <20250320072947.8174-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320072947.8174-1-clamor95@gmail.com>
References: <20250320072947.8174-1-clamor95@gmail.com>
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
 .../bindings/power/supply/maxim,max8971.yaml  | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
new file mode 100644
index 000000000000..2244cc3d45a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
@@ -0,0 +1,68 @@
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
+  monitored-battery: true
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
+            monitored-battery = <&battery>;
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


