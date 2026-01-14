Return-Path: <linux-pm+bounces-40858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 485B3D1F5A5
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 15:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E41913008E32
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024A2E0914;
	Wed, 14 Jan 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDrD5tJY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88B2DA757
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400231; cv=none; b=tevVCTn8lLIrgyYDUpoY3M2/D5629ztOvPAGAGq+qnBJJQSO1D/nzmtNOMIDxwdfQihE845vG8BzA0FYW8ZMscz5CEk2/kmPGSuymodckwQkMu8Ed+je7ZyACtsx4l1hwFDNfF0prVl/E2C+gbbsuU2i3cTraD8OMzmuZicHn0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400231; c=relaxed/simple;
	bh=WBMqNxSxLS3g+O1kbvkoees1LyjIONc/6PlycT8B4zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VnDvLlv/ZLstUEbLlSnhr60WRc8WoQ++wvA/qV5ByyQ9MLq6GRZKmw4YFtfG/eXhURQh4JBhF9JNTVrrVQ5rgcWAVDxcQelihAp96S3R9GloJPucR2DI3lhB+oLqeFnRlYgl76oJREnZegCIUCwEDe7TgUkXQ9BqopZS+aZ0fic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XDrD5tJY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee9817a35so521115e9.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 06:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768400227; x=1769005027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrZpFfiloC03b+wp8plcjpvQHKhBs/B1qZYvX6HzNjk=;
        b=XDrD5tJYklmoAw4+yjB/cxnuKZIVgJjJEQS0kZK2nEdd5fefNA6m0VPIxy0YF82XTd
         uNkliUHH3CtfA48D0ridbtnj6ZFseWc7OcLK/nHuR8K60caAqtBwf9o1hgVtyKHalkXW
         E99KssLMlc4kDBft4DWX77wtNuL/5y5gFnt598MN3rcuNbKkO/K8Td2ddyNZLuf6+o2y
         yD/ThFXR+t9GFfKtJoyS+8TYAksW2G4q9iZ/V9kXQubxKQKrh/hR3qZS17IQaXFJbYQp
         GCgGNZ24ys6nL8XxWZ1nQW+XinepEc2LwI3aVyFRVnYpMkM6EDZQq0T1SCbmvyoUPMTm
         zO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400227; x=1769005027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QrZpFfiloC03b+wp8plcjpvQHKhBs/B1qZYvX6HzNjk=;
        b=CcaeLFE4+VQ9R9ICMakcn6D3G6ejKe5vO4IDlQl3V4+JXQZSHotS+T/psKLyu+Ndlh
         bsxBX/fgUu+Guiv3oR8mXkddpP/lEelHPSPq28hAn6CFyL4/F3RsLZh+3aerx3DisMCp
         melIBuhrkn9VPV0ygw6Xh7EZdw/qJy4tC+A4xYDU2nIt7oIzsJlJR92tn3i6vzrtM7Xu
         2jwo/HBXfrTubAMedSSf77WFpaVG5ZPApaMLwJ+aV5dRtz+DPyhVj+wCyd4F6WfbNuYQ
         PDe1sRJAN1QwF/3/uVfk8wp2EdeuG2kDZksaoENFieoyUsihbGWtMrNMPZqoNyLv3TPw
         9Azg==
X-Forwarded-Encrypted: i=1; AJvYcCXCFPuQo2/+zP267PjkyYhzjOt/yAqLCQF25elZXKfgw1Uf00mAmO7HyoTKBgrpp981GFe0HdMboQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwo4oUEYR5w50WA9oS9ycmcuLRRrfVd8ymCmRk2qehNRXC2deB
	AZ3hbti/sgvXW81TGql5ZzTHLw/LkXFluPiiQcw6tGvux1VypYHu3iWyP4+y8qINEoo=
X-Gm-Gg: AY/fxX73SWB9sBBVS1Zw8yGgSWEWBRr53IEEN8na/EG9siH7Nb9k8w1A7XLmjzGBWMa
	K+Y9lz3SHBbRnw6Zo6qHpH2fk7F/YV3PcRLyDt7SDsmocMlRg2XOZcYUxsk7ZLld8WXiKYds9jr
	0mKwt1ogNZrXrRK13zj5CdFTclEOyCGjImdB4vhaxT3GsHV7yRa6YzznFo7ID6nCIZkqzZjdwWd
	31yj8vOVFBA9hBxq7YkA0ySV9/BES2PebqfMT8GYDKFYoaaQS9d06B35C53RUpnoH9O2o2X2RJ1
	8f6rkdAv6W4yTiXOnlr55pWGOLTBkoZhJeybaECLBBzXk/TxxtxCIyEkADWgAgIzXrHJv89OB32
	yTyFngSeNh7Re97W7rvmgv2aMmAhqemL9YgI+wmIOP6CeLMW3u5wIVTsisXkflxUFaE6WmS8HpP
	VlSloFt4LjVAOLo1i9YdEzA6r33h7C7kwRHTQFwM+zNW/j6l1cQucCO9zYP/dotCyja3k+iQ==
X-Received: by 2002:a05:600c:1383:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-47ee3353f47mr32581865e9.22.1768400226755;
        Wed, 14 Jan 2026 06:17:06 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee57a2613sm29595445e9.6.2026.01.14.06.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:17:05 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 14 Jan 2026 14:16:29 +0000
Subject: [PATCH 1/8] dt-bindings: thermal: Add Google GS101 TMU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-acpm-tmu-v1-1-cfe56d93e90f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768400224; l=2960;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=WBMqNxSxLS3g+O1kbvkoees1LyjIONc/6PlycT8B4zY=;
 b=qkqinRurGCRKkQsa99SgSmLgMRLHVY4181hXS5vi68gr9cs3nBlqcOVvGvWCkuaEMoDEcqWQ4
 oUyu3DXXIcyDs/tQVSh/3vaUbcXxDGJyaoDJWatqNDcxcQylrw6kBle
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add device tree bindings for the Google GS101 Thermal Management Unit
(TMU).

The GS101 TMU is a hybrid thermal solution:
1. Configuration (thresholds, hysteresis) is handled via the Alive
   Clock and Power Manager (ACPM) firmware protocol.
2. Interrupt handling is handled by the kernel via direct register
   access.

This binding documents the required resources, including the APB clock
for register access and the phandle to the associated syscon node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/thermal/google,gs101-tmu-top.yaml     | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ecf4a315ecf1ea0649c4e96a207d531c696282f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/google,gs101-tmu-top.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 Thermal Management Unit (TMU)
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
+
+description: |
+  The Google GS101 TMU is a thermal sensor block managed via the ACPM
+  (Active Core Power Management) firmware. While the firmware handles
+  the thermal algorithm and thresholds, the kernel requires direct
+  access to the interrupt pending registers via a syscon interface to
+  acknowledge and clear thermal interrupts.
+
+properties:
+  compatible:
+    const: google,gs101-tmu-top
+
+  clocks:
+    maxItems: 1
+    description: |
+      Phandle to the APB peripheral clock (PCLK) required to access
+      the TMU registers.
+
+  interrupts:
+    maxItems: 1
+    description: |
+      The combined thermal interrupt signal (Level High).
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the device node representing the TMU System Controller
+      (compatible with "google,gs101-tmu-syscon"). This node provides the
+      regmap for INTPEND and INTCLEAR registers.
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - interrupts
+  - syscon
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/google,gs101.h>
+
+    thermal-sensor {
+        compatible = "google,gs101-tmu-top";
+        clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
+        interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
+        syscon = <&tmu_top_syscon>;
+        #thermal-sensor-cells = <1>;
+    };

-- 
2.52.0.457.g6b5491de43-goog


