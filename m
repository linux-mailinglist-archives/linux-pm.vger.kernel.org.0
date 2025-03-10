Return-Path: <linux-pm+bounces-23739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22020A58D8D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 09:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C5B16B1D6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6640223311;
	Mon, 10 Mar 2025 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH9UeXdD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47B1D6DA1;
	Mon, 10 Mar 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593774; cv=none; b=WqvBmM/1TkTA9KEMiZMEKsdWTsC2YPN9Vrrr4ryp9ldbFV4O2oTGsMjDkyR8mo+qfuo9h+1eUyStEXvZLMEI4RRvPUnSHZyoAxL+hsmjzyjTF2u27HjYFj+AY0AmHosmo7SZBLGWzckUBxTyqDQdlTghwmPBnzHfB0Ho/7IQcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593774; c=relaxed/simple;
	bh=vebbK1HlbPcYY3cC1K+GheimZMKDxgouQW4T8x4o5wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZjJDFUcEUOgCuYH0HQO+Uo78hU3aKnmLI08EBklKUVxGzDU9pw5/jRb8lWZgm8wv0ojVAusx8iqAaAC6fZ1RiRLTwZjBG0lg2WddUcS5j3WrJuQif060hz0sLyyajqdMRHISyQLEZXuSBsBhJubVgtPBOGF4hbSBq/aSPcUKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IH9UeXdD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac29fd22163so104286366b.3;
        Mon, 10 Mar 2025 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741593771; x=1742198571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtqM/kxYdN52sLAkC/9s8kD1Bh0X8VlSTevH54RSjOE=;
        b=IH9UeXdD70eHOpnEjXn0pgHbGGWhj3POauiuH2jAUmKN0f+YJmAJI99AudRlxalnUs
         XMo5byKlb7xHeTIgfk/8tlbi0HrqB+HRCFRMrWgMiF7Gwv5Bp2srBSPPiBawuKAAYQa7
         EfTUyq1vROddqvKMqXTrIzKeby0KMcnhnSlS7k3LjJhjAxy90TYwgZe3K8riF20a6wl9
         Ss9dBH72UleUmdM+RnPvTVmwGIu3wfhQvw5vzuBpzTTyDb0PRZ5wXfI9x4KZYlKEZBb5
         maY35muU3iMDsPH7i/QDBVNwTR7KiM6ZsneaFj0fo5yiGyIrUxhxD7yie8vIml3YJOlm
         UKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593771; x=1742198571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtqM/kxYdN52sLAkC/9s8kD1Bh0X8VlSTevH54RSjOE=;
        b=frcsJ3zoIu72MabxyvLlXqJFtTr73QlkckTeMo4cqx6jLFW2sUyanf7a+EbGQZsBOA
         O+OC+pmmxZ0wAHcfDpnijSAWMMV2nV1DyqSGpPif70NuAthsR577VrUOMorN9wR8iltN
         apaGEdTckTB5UA/n6rQyriAUAos8hWF3mPfsHkiaguboMkefUt26rPm/jgdYggQ31iBO
         JGfhbeNTXt/bxynZXDcVxsMoF+E+nzl8oOC3Uw2oucN2RNuAh/SgK5yWz1s1Lf4qv7iW
         BUv8lUzec5BqN9OogNIpjs+FHp3vnmoLCMZPGPkaUquSb6M72pMYZc9YbMNldhxKhCFU
         g0+A==
X-Forwarded-Encrypted: i=1; AJvYcCUfy+R0FoCYcltAUseHFpwOih+veXDHrgSXrdIZMGPlKuxFEOaPHIWRrAywcv7y40n+mYhxbVkHl4cB@vger.kernel.org, AJvYcCVl/VSHFp4EWXcQfCG7494ok9pV688CDz5x8yB8Koxia06Vo69GMszOBqL+7TNVcAHAJAD2L7prL+pqPQRX@vger.kernel.org
X-Gm-Message-State: AOJu0YyLBUlOhLCSRLZZw5vSK22Q5Xyyi8rvZFsSp/WqOxzc/o+v56oS
	uPT4TmHCQkHvZDP2jx7d7NzJ9oCEjsAS0mgv/yux+YGtr53WRL5uD1Z7+A==
X-Gm-Gg: ASbGncuiplLZzOC1GnmS1V1Jhc88DRmFuQtZkG6kp8FOctMGKzjpR7QOw6N+e1tQboO
	Yp0snu4MiytRHYxEqWRgo8kF4uj0LfhRb9gWbNZfbsRDcDwdL6daiJPr3x8exEIQ14OK09G1+HU
	66jMDFtn9M3kVkEz0lEkNY6F36Z+yzPMdAx0UsnYd/jictJ/vtL9xxe4si+9WDkWjrWPVfmeSS4
	uPemKQeAbTqQClpYUld67bKg8S0pHIlpsGs5roTkZDhJ+XAt45Ctvz9zPKhNX3S0WPkN/IJaRB8
	up+UfC6kRybPn1QqDEQeImzqjUd+OOBqyGNmp+ftWJioVcs=
X-Google-Smtp-Source: AGHT+IEI8oAmirxWFNb7t6skrjfu7Y2D6D64uj+3tckAPyyS4X8sPzyL3YoA+GCEnBXLgy0zsX+NZQ==
X-Received: by 2002:a17:907:1591:b0:ac2:a50a:51ad with SMTP id a640c23a62f3a-ac2a50a52a0mr111211366b.14.1741593771140;
        Mon, 10 Mar 2025 01:02:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac28aec7ba1sm263917766b.37.2025.03.10.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:02:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
Date: Mon, 10 Mar 2025 10:02:36 +0200
Message-ID: <20250310080237.7400-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310080237.7400-1-clamor95@gmail.com>
References: <20250310080237.7400-1-clamor95@gmail.com>
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
 .../bindings/power/supply/maxim,max8971.yaml  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
new file mode 100644
index 000000000000..d7b3e6ff6906
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
@@ -0,0 +1,64 @@
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
+  maxim,usb-connector:
+    description:
+      Phandle to a USB connector according to usb-connector.yaml. The connector
+      should be a child of the extcon device.
+    $ref: /schemas/types.yaml#/definitions/phandle
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
+            maxim,usb-connector = <&usb_con>;
+        };
+    };
+...
-- 
2.43.0


