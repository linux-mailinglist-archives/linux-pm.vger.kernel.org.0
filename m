Return-Path: <linux-pm+bounces-23300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281E9A4BF88
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B9916745B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FEB20D4EB;
	Mon,  3 Mar 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS33ZcsG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888111F17E9;
	Mon,  3 Mar 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002999; cv=none; b=oxWsbPEltU+gP4Ikmm28rSAGehF7G8zmmhJ83ATnDC23i5s6fXbRm35EJQCp4gW+nYvsaLxw6RRYSX7MO3xZQrlBptaQyflvZpLd9XwoLCtDToUqOn5jmuPMr5xM+TTAdIAhZD6ZJyetmTFhfEZBhboLFHDdSTyQegtx8tCs7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002999; c=relaxed/simple;
	bh=hbyAjHLbBjqr0VU9niJ5oazmJV9tzGU7e6O8esJ6oe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ke8iNskG8HFojahe3HcryDXmp3jxibsTmVDD7gV85ZOiBN/KnnpRO8gxPsImYn7fdjD2rgWxaaA4snAFl8amdC1QqeAcgFAW2AweNHcq4sS1/RbinOvoBdGml+LT5RXrRbRmMbgVnzypobL0dcjapYfOKgYAbvCCHhGn2gVAAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS33ZcsG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5495c63bdc0so2016883e87.1;
        Mon, 03 Mar 2025 03:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741002995; x=1741607795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH4XVjvmSOeJ56MEzJia6DNHDQ7WVeAKt9WlOAudWYs=;
        b=VS33ZcsGxOKTRDPCJip2Z7Er0FeKQzRhicxF9rf9h99A1rVP0HL3SA9EXQbC3p1Nwa
         +tkJpLW/LdFe5hdtbw04A9OlUKqbJvRnVpfgOLVQD8vWa5IYIODwctq7X7ehv5umIXRY
         yP7I/zTc31tZIv2FY5emXpaYZAeTL9fwLqaE1QdQh/c/HRKhaC59Bd4dcWkGcSF4LuYt
         NdxuG6JSgGgQuvLpcyKrjjvJueU07eMsyUk+BL+4IUOkCJliRauWmKweP+bHWgh42wDJ
         Fh5BkrapCPyO7/g82jHKBC0q9oKEGqARm6kJoC001u6bgg6KcfwHcxBTwRtbUpTLzq5Z
         BuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002995; x=1741607795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH4XVjvmSOeJ56MEzJia6DNHDQ7WVeAKt9WlOAudWYs=;
        b=wB1V5C3OW+RD7uZobuUQJ8iFQsBic2ho3JZII/AxnJMdiKbgONQPvJEgGPYPZdf7zy
         LCt9LJyc66rqQF2libikfqDW/ekfmzcwDK+8/9SKBf8kZfCZ5tS8DxpTmcVUxHBTq0F7
         AODTUt7diExW4eGIO7di1AgkySwzHJwC49lu14VhLMinv+KbjfiV0kymnVNZBY41QP9n
         tNgPICfS25XM1rik/tJgMm26aaUkMzVe+3BFvPTzU7TB0BpQVkUlWBTZyLECkx8Xlq4B
         8FGFJJge1gKe/5ECnLWjiUVslWmhvKUubtxKIplc4TCHoyfJEj8XqFutldGsrWo5hAiu
         kZCA==
X-Forwarded-Encrypted: i=1; AJvYcCU+VhEK3NLfHVbPofcBstDVrpNKHYu96E0DdjjuukC+XSIGTO0sujVd3gWgM8tRxvjAbVfsa/n81b6/3J54@vger.kernel.org, AJvYcCVEIl/s6hiJHbocK74KtiSLbI4oi1Guar9myBMD5iSQ/WbJdU6c7K3oBNVSezb3kPPms7kcwQgKIvuA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40dBdz0hFDxSzOtnFGppiqsf/OmeGHh89lhvoK3wjs27jhnh8
	CQ22p7AyrjHl2hB5Y18u+eqbk6Xkc7U5ycWCXr3HEIWNCs44HswOvt3geg==
X-Gm-Gg: ASbGncvAwJa38nq5+NKfctti9TIE1M1X6VQoM3qAmoZB2XzJQeUAGZyYFxNboicpYr/
	GngI1NEvr/QO3kz6PQsrX9rQdFjU+ZltMjaSyVsE+qJzYPII3+fJXBGUr1aXT9hhj0ONeBiieWr
	3i2NC4G+CdMMNLZWCiGuaA7COQBUzE5VLjL7lTqTQmvWhYS3X6LZWNrnIjNHTCM/OMB4uhDIhxG
	YT2DwQ6R/OQ0x/kDNVPdk1KLPKfsk9uTCPxJ5s+++38THuMBaOdyoTOTGkbR4RZOFANK1R9/nRJ
	cjL4xRYX2sH33hpjs4oij5Iwxy073fhaG6k=
X-Google-Smtp-Source: AGHT+IFjYVMB86+MDwCkR3H5IU8FJpmlY1Bdf1RuGlgIw++38jjfOXsoget0PwG22w2DNRnXADfE+A==
X-Received: by 2002:a05:6512:398e:b0:548:91f6:4328 with SMTP id 2adb3069b0e04-5494c11b516mr5596046e87.15.1741002995382;
        Mon, 03 Mar 2025 03:56:35 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495f630cb5sm511817e87.212.2025.03.03.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:56:35 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
Date: Mon,  3 Mar 2025 13:55:01 +0200
Message-ID: <20250303115502.89457-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303115502.89457-1-clamor95@gmail.com>
References: <20250303115502.89457-1-clamor95@gmail.com>
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


