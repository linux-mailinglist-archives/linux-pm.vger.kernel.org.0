Return-Path: <linux-pm+bounces-22885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B6A43FD3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 13:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7251C3BB119
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F027268FFE;
	Tue, 25 Feb 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="LDDLBueT"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3166C267F60;
	Tue, 25 Feb 2025 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488280; cv=pass; b=kyFz9A3ADrqx1LYjglcspLXezFZMDpH+x2KTPOKWfmjQ5QmGPJbEvyk9yUST0dFmKvH7pLniHhoLGu/8kEkQhtiY2UMEuhHlCbI/J8z+zs0is5HHCmEUX1zJR9vCf3c37jiBT4aZ7ZE2kLKVMGGv3F+lWe7egPc6RDP2spiwhAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488280; c=relaxed/simple;
	bh=FHpU7Ec01Ojx7D2vegFscGmmsa26QNRtwRTr/jKSj3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fr+rr6K/6IUXFIVVbS0+PMj9GxGBMLw5Zp8A6S08W9Jp9nO7DN2dIoC9OBcAWhppAaE33fqC+DpFZ+I7qomVZ/ZOFLtcSMd1/pMdc5jnKzYfSd1CJWACoOTeesWIHeP0Yd/V7jMBWIjtstxYfiJRGLoO9RW/MD6RpkytDFsyJMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=LDDLBueT; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740488262; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b76d1za7PGuMmTiBSOOcQuKGH0L4l0xPBLPyzFWNJ/HDODeaxW2Pbl8OYyWYl5kfOZxFyVqkKpogH+VLeKkOgZSsSnntSv91d6QTYqj+/jlNHkLj59HihMw3np05SouOCZiD1dD+ArrU7RhhPYDexYv/9ho5Utkpwz0BuQjW+2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740488262; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x9lTs8zXN5HalN7kcYVDsFMxl6BV5hMT6pLsKxt4ZeQ=; 
	b=i5MQ/jG0WbjeSlx1+elh82vdKUO6vh4a7/nPWuA6XvR4dJ5Ejt+FHr5caa37D+By5BrRFGt88m8SJWQ2Uplhewvrb5hsfyrqtwODuACQqG7h3/RCkTgrfS8VGc/vxiBebb3fXFUr9NnzvRhwhBD0OTVgkGFY+65VMaxfLa5zoyI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740488262;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=x9lTs8zXN5HalN7kcYVDsFMxl6BV5hMT6pLsKxt4ZeQ=;
	b=LDDLBueTingfhbtiiCg7jZavcUthN75wUA6IGG24cjKURtDnz33+LeCmBS1PAKS1
	f3cR/YHskcmad/8CdvvLrOhaKyO6/6QB9kKHmruCIo/wGiY3BvtPQzJmyiATLgnXKIw
	Hs9ONg7CAT/WvWVUwkNrVroUNv3WMBZkDEQvyZE4=
Received: by mx.zohomail.com with SMTPS id 1740488260869522.3234869504469;
	Tue, 25 Feb 2025 04:57:40 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 25 Feb 2025 13:56:47 +0100
Subject: [PATCH v2 4/6] dt-bindings: thermal: rockchip: document otp
 thermal trim
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-rk3576-tsadc-upstream-v2-4-6eb7b00de89c@collabora.com>
References: <20250225-rk3576-tsadc-upstream-v2-0-6eb7b00de89c@collabora.com>
In-Reply-To: <20250225-rk3576-tsadc-upstream-v2-0-6eb7b00de89c@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Several Rockchip SoCs, such as the RK3576, can store calibration trim
data for thermal sensors in OTP cells. This capability should be
documented.

Such a rockchip thermal sensor may reference cell handles that store
both a chip-wide trim for all the sensors, as well as cell handles
for each individual sensor channel pointing to that specific sensor's
trim value.

Additionally, the thermal sensor may optionally reference cells which
store the base in terms of degrees celsius and decicelsius that the trim
is relative to.

Each SoC that implements this appears to have a slightly different
combination of chip-wide trim, base, base fractional part and
per-channel trim, so which ones do which is documented in the bindings.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/thermal/rockchip-thermal.yaml         | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index 49ceed68c92ce5a32ed8d4f39bd88fd052de0e80..eef8d2620b675fe2f871a03aebdaed13278e0884 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -11,6 +11,23 @@ maintainers:
 
 $ref: thermal-sensor.yaml#
 
+definitions:
+  channel:
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+        description: sensor ID, a.k.a. channel number
+      nvmem-cells:
+        items:
+          - description: handle of cell containing the calibration data
+      nvmem-cell-names:
+        items:
+          - const: trim
+    required:
+      - reg
+    unevaluatedProperties: false
+
 properties:
   compatible:
     enum:
@@ -51,6 +68,12 @@ properties:
       - const: tsadc
       - const: tsadc-phy
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
   "#thermal-sensor-cells":
     const: 1
 
@@ -80,6 +103,47 @@ required:
   - clock-names
   - resets
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-tsadc
+    then:
+      properties:
+        nvmem-cells:
+          items:
+            - description: cell handle to where the trim's base temperature is stored
+            - description:
+                cell handle to where the trim's tenths of Celsius base value is stored
+        nvmem-cell-names:
+          items:
+            - const: trim_base
+            - const: trim_base_frac
+        cpu@0:
+          $ref: "#/definitions/channel"
+        gpu@1:
+          $ref: "#/definitions/channel"
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-tsadc
+    then:
+      properties:
+        soc@0:
+          $ref: "#/definitions/channel"
+        bigcores@1:
+          $ref: "#/definitions/channel"
+        littlecores@2:
+          $ref: "#/definitions/channel"
+        ddr@3:
+          $ref: "#/definitions/channel"
+        npu@4:
+          $ref: "#/definitions/channel"
+        gpu@5:
+          $ref: "#/definitions/channel"
+
 unevaluatedProperties: false
 
 examples:

-- 
2.48.1


