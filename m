Return-Path: <linux-pm+bounces-22946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D9FA45197
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 01:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B577A287F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 00:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF514F9CF;
	Wed, 26 Feb 2025 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZq/lGHn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99913BAE4;
	Wed, 26 Feb 2025 00:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530206; cv=none; b=PFVr90kLLiFcK7F9ZEjSAIDIrtGnWclx+zVpeNEdrYUWw1UCpmZnnlIU7AMD4RBzCgOtUtwCpb6ioDAzN1VvGgQIdYu+XUfwCdosIhwyMPi3yUoQlHQv3aQXjei1lSCYgp83uGDDicLPidUhvG6T3d8aSxZZ7Xyc8UtNWc0YeTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530206; c=relaxed/simple;
	bh=3GTL6/XiXHLBc+pi/NQr736XLvjL/yUNeREEvEKV0j4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aKmrK6icuJ6GG8GeNS19Uz6MAughzzxfB5JTzzQiQqukHFVa7/s0Gj9+vgaDRjugbkKD20A6DVXaB2ItHyV5pOoBgcLFDd7ps3+Vm4oOxRaceLodcdCNcBRAe099IqBX6GWKIIBFOg6lY803IeU4ydVmIJdfa0otIzYI3lKCXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZq/lGHn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f3486062eso5205135f8f.0;
        Tue, 25 Feb 2025 16:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740530202; x=1741135002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JNoENxBoZrBe91voXVn7bHkqi1XSekF1y+baxrAi4K4=;
        b=gZq/lGHnZqSPAlDcO4rTUFtamJMrgWNRECTj3unI/tS1kGiMm4Wv2enyECJCuRhr6L
         kpPwQ2QS3WTclPp6LhUwRtY9sp0x0pz/QQZ4RhKmt+gwR6HJkz7rjsgyXotY4KZHJ8pQ
         uz/hztna6PiIP8Cr2hM2OmmwelZ986Xezn0apoxbC0FcfYPrBcNgeJS7LH1le/ge09Y6
         bGX/hA2apmB8ZTWckdwWIuEWBlyL0DcINIpuiAtohYZ7Z6MTetmSKZSQuXfP/WCQuKP8
         MFWa/3L1mEDGxD/p6dLWYg5m1sC6EpL7lZaYrSacnW/CbmkWHsAMXQNps0lPawfgngAg
         oltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530202; x=1741135002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNoENxBoZrBe91voXVn7bHkqi1XSekF1y+baxrAi4K4=;
        b=pdsn+866sddOsYb/weVPtTlGPSUKnKKQFjDiu8yVEoWss8KtywPx9tFvCRTr0K2smy
         qWGGL9L6AopFHV9Jh1qGtfkia5o38ctm0ZwI/W8dwa6VLxfFcy1/QaO84hgazWkVQSut
         L8Fl0a9CaLSv4tyyilxOoV3yAKU9L8K7MmhSHASq17PVHUB2NlcMhnJn4LwSZzX8uAzX
         USGQ3Xv7SeQBffpuu8qme+w2dJ8LoUP6fc2qAW9J0dI6zGmA9p6I73NGIA1UlHCgu+1w
         2Vgd40WnNYdch3bMUEoRTM6TuvizzdZ24uzFZfyYQa5p6m4uwQJok+H2YJgG7QD+dZ0/
         NYWg==
X-Forwarded-Encrypted: i=1; AJvYcCUhPFqc4XKb5hO4wCYQhF/uUBTb4EMJMMTyISaTyBPP0i8drFI0wsapBcHheXD35YYxeCSMONxt0ZJxTwUY@vger.kernel.org, AJvYcCVddkOGCzxkFJqwVSUyPeoyDe2UVf5Af9/1Efpb94kiyjVQVFoLzs7uBxgDfUYW8kxsoEkHkhOO9iU=@vger.kernel.org, AJvYcCWCV0GxdpDDm4tjJCVq/kuMzvR09+qSrLz/C6feL5hg8dP0kVodu17dic8j2ax+abBs4d52MaP060aU@vger.kernel.org
X-Gm-Message-State: AOJu0YwtdeLw81Ugx4gD5hv/BNTzD+4Z/oki+uo/510ZlHdSuj125e3f
	Gsr0+8dmu4lrgVHx7F66WIwdBAogROmCAyeXnmgqubqtO7BN/Acb
X-Gm-Gg: ASbGncvugR7RdQwv+uze9U0Qr9Dirk+Qj/iP/fxR3/NcenP2c0L1HZymwlML6NcQv1d
	nw8LNWLKeEe3M8Va1AQ3YAAz+tdenGLLfb8bwa87YZ2HAfpqyHsAM3NXnVMh58OvtiEDQwXLBPt
	KT/QzI4/XrlWfLuI1Euh31JZf2rTS0Qv+E8hNYGkRulyVBXg+i1mzqwwsXZZCnVqYje69hBl5xI
	LWxI+6G+4rYIzFlGgSCqm5Mc9VIs4ugXEFtWT85nfODRI23SuBAAs3vF0UeHrZ6N8F/VL2a/abK
	hqo8jcMYI3urM4uJMknObC/PDhwgI7X4JodFnCkizJnQKSg1rlxb+AJMc8Uohc+Ak8Jtoq8=
X-Google-Smtp-Source: AGHT+IHoUenVQevbu1Hu0plq1UuGDyGoosPSjWjJ67mAix46nfmWkEyXPB8VngMgXYyL+1dZTn/kBw==
X-Received: by 2002:a5d:5887:0:b0:38f:355b:141e with SMTP id ffacd0b85a97d-390d4f378ebmr963479f8f.3.1740530201503;
        Tue, 25 Feb 2025 16:36:41 -0800 (PST)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390cd866ed2sm3877595f8f.16.2025.02.25.16.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 16:36:40 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor
Date: Wed, 26 Feb 2025 01:35:57 +0100
Message-ID: <20250226003608.8973-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha EN7581 thermal sensor and monitor. This is a
simple sensor for the CPU or SoC Package that provide thermal sensor and
trip point for hot low and critical condition to fire interrupt and
react on the abnormal state.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes v2:
- Add Reviewed-by tag

 .../thermal/airoha,en7581-thermal.yaml        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml b/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
new file mode 100644
index 000000000000..ca0242ef0378
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/airoha,en7581-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 Thermal Sensor and Monitor
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    const: airoha,en7581-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  airoha,chip-scu:
+    description: phandle to the chip SCU syscon
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - airoha,chip-scu
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    thermal-sensor@1efbd800 {
+        compatible = "airoha,en7581-thermal";
+        reg = <0x1efbd000 0xd5c>;
+        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        airoha,chip-scu = <&chip_scu>;
+
+        #thermal-sensor-cells = <0>;
+    };
-- 
2.47.1


