Return-Path: <linux-pm+bounces-38696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A24C899CE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 12:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9564D3A5B88
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331F3254A7;
	Wed, 26 Nov 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kzd2/VaW"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB12630102C;
	Wed, 26 Nov 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158216; cv=none; b=gWlY/AtpGAchAwrDJ42QQsm5GCndySTzDlYcC+IagMsIm5cJ3KelRr3oLI+fiZBrssRHF0LrIAb5Je2GgyM+FEh2JOnHsNv29N1laJoMdEchcxy2IjdvGin6zfY10yueUkeDO85Zc5hUg9ceZohOH4AZSf0ZCWQEfAFyj4uHhBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158216; c=relaxed/simple;
	bh=FL5o5y1/Twpcu8Mqfn+GwJ0PqQ90brtbtK8QQ2rfmuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eX43e/y5BfjK3o8vjWIwH5m60N0snaEuBeA0YZq962AY9SZUagNJB6z2IPcbLYV0een3QK3f3eAY5eFOsqt7xJkI48BCTaY34hVX035EpU3HYz3IQeZk4TdCN/QvRgTbBDIUcTj387jV7JeChRCFzGS9grvXipgyzW8R9QP3wzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kzd2/VaW; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=FsFZAa7mJuleKXtIm8+lL9WVy7it1dzq5lspUZWFQw0=;
	b=kzd2/VaW+u698FJU+P+tgqVd5Kr7/xilVyCY5jZAyHARzsGT4d3XZ6dTc88vHp
	eFJtjLlHaSWorpjUBZiUq6xiM7EwJquS7s4PJONFiFFHYU7Qj9ni6FtDGC9QJud9
	smm43nQM5PMyZ5gy01CxVWptX3ik7je4WXCQIBzQLkUmI=
Received: from [192.168.10.1] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBnveN26iZpJOi_FQ--.56535S3;
	Wed, 26 Nov 2025 19:54:34 +0800 (CST)
From: Shuwei Wu <shuweiwoo@163.com>
Date: Thu, 27 Nov 2025 02:44:07 +0800
Subject: [PATCH 1/3] dt-bindings: thermal: Add SpacemiT K1 thermal sensor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-b4-k1-thermal-v1-1-f32ce47b1aba@163.com>
References: <20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com>
In-Reply-To: <20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Shuwei Wu <shuweiwoo@163.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764182662; l=2456;
 i=shuweiwoo@163.com; s=20251125; h=from:subject:message-id;
 bh=FL5o5y1/Twpcu8Mqfn+GwJ0PqQ90brtbtK8QQ2rfmuE=;
 b=tC7J82dJezjNQsCZQVsA75NIKy+KngltMFnBrvPel/zXVL0GCVi2i2dA4Daa06GoQkm6eJttX
 akAhUWCgCAJBVNhHzpxN+3UfQL6nXbuixZUYFpv1EqfyK8qO+PyFiCX
X-Developer-Key: i=shuweiwoo@163.com; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-CM-TRANSID:PigvCgBnveN26iZpJOi_FQ--.56535S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17Gr4kuF1kZFW8Gr4kWFg_yoW8tw4rpF
	4fGrn8Grs7uF17Xw4SgFykAan8Kw40yFWUXrn7Ww15trn0gFySqr9Fkr1UZa48CryjgayU
	ZF4UurW2k3WDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRV6wiUUUUU=
X-CM-SenderInfo: 5vkx4vplzr0qqrwthudrp/1tbiNhcSjmkm3gD8mAAAsI

Document the SpacemiT K1 Thermal Sensor Unit (TSU), which supports
monitoring temperatures for five zones: soc, package, gpu, cluster0,
and cluster1.

Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
---
 .../bindings/thermal/spacemit,k1-thermal.yaml      | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/spacemit,k1-thermal.yaml b/Documentation/devicetree/bindings/thermal/spacemit,k1-thermal.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6057161b4b00c8f869d16199a1cc0fc964fed998
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/spacemit,k1-thermal.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/spacemit,k1-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 Thermal Sensor Unit
+
+description:
+  The SpacemiT K1 Thermal Sensor Unit (TSU) monitors the temperature of
+  the SoC using multiple internal sensors (e.g., soc, package, gpu, clusters).
+
+maintainers:
+  - Shuwei Wu <shuweiwoo@163.com>
+
+$ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-thermal
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Core clock for thermal sensor
+      - description: Bus clock for thermal sensor
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Reset for the thermal sensor
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      The first cell indicates the sensor ID.
+      0 = soc
+      1 = package
+      2 = gpu
+      3 = cluster0
+      4 = cluster1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - resets
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+
+    thermal@d4018000 {
+        compatible = "spacemit,k1-thermal";
+        reg = <0xd4018000 0x100>;
+        clocks = <&syscon_apbc CLK_TSEN>,
+                 <&syscon_apbc CLK_TSEN_BUS>;
+        clock-names = "core", "bus";
+        interrupts = <61>;
+        resets = <&syscon_apbc RESET_TSEN>;
+        #thermal-sensor-cells = <1>;
+    };

-- 
2.51.0


