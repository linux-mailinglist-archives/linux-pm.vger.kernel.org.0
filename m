Return-Path: <linux-pm+bounces-22159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5802A37143
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 00:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2BE1893417
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5061FE46A;
	Sat, 15 Feb 2025 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ISc1ttd3"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE761FE44F;
	Sat, 15 Feb 2025 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662537; cv=pass; b=m1n/l1rMjm7QbyFAcjvfCgRwEz7Az/ewXBGJ6XKrxP7upAdXvdHrswyIUwiGAYqqaWKRSzuKE6+MKmq5qCWiOtN/bcy5Je9Qr7+gf4B0gYRiOzAUnfwNGjCKlj+90zv15K+93+cNKmyBzgxUMkc9liY//KyuRQ5HWxuC+l76398=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662537; c=relaxed/simple;
	bh=32zwQpZUGPL89MB5IZRbsMcBDdbJ4+3QRUlHUMQmInE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/8J5+4MGMc6xtP92s/SNAi2JyfCSoHqYxtMPxfSxvH9U0bMpCt2ioYLTjiLUfI7FYqD1thC4u5mhGJORhOO/tteEjFSeKQjGBBEQxbNsW4fk5GHWb5V4PK6XGZf/mXAvyqUNhAg5A/KWIbd1Ki/FGhlL5WYyo3D7oODgC9uC8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ISc1ttd3; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739662520; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZAOxQ7NEBSAaMaBLFhGz19v+OPogx+5fKT9mFiwaqrnZ78Mqgf3AJXcZfdnvvqhUvRsg424z+BnHSruSlA3/MQg8vdOADOJJeYs9FTohzgy6nNLGMhpK3wrHZQ241yw52PCcFQZGEhwDkVXDGjWkvS+cb/yvoTNzxctkUVJHKzk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739662520; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ykTHsvTL+qGG5v5/5FMPfK6N4hOl/V+kaltWfaRofSE=; 
	b=AoKXcPTCngMhPK2sTq5bPc0HbCxG9cq7VbYoyiJfIYbR95R4sBVoe/SdfMwsAte1VRuue59y+RtIwKvRXwggjjJoNMp2iufiEbHPxqOGkdqlhP+3qzckLSDCqDtQGrB5dsNBe3KuxAYm5r/XCeoeKJZH9/rdAWKxy5OHslCghOk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739662520;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=ykTHsvTL+qGG5v5/5FMPfK6N4hOl/V+kaltWfaRofSE=;
	b=ISc1ttd3t4Zjep98WFy0mkAl/V3p+1YBlSRUbXiixs9gNWDVsR41TS5PF8BuCr+2
	kZxilXTIXj7V/9UY8yxv66w1YkLF52Mv4ZVzJKuSdisByNKdy6IYoNMZjK34zWHxzlR
	C/9Q14QD4fnOWsSMTe2fUnOiSnS3NRSsWi1kdgNs=
Received: by mx.zohomail.com with SMTPS id 1739662519156579.278733592755;
	Sat, 15 Feb 2025 15:35:19 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sun, 16 Feb 2025 00:34:53 +0100
Subject: [PATCH 4/6] dt-bindings: thermal: rockchip: document otp thermal
 trim
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250216-rk3576-tsadc-upstream-v1-4-6ec969322a14@collabora.com>
References: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
In-Reply-To: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
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

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/thermal/rockchip-thermal.yaml         | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index 49ceed68c92ce5a32ed8d4f39bd88fd052de0e80..8d27ddefcc64e29f0faab059888805802c948b41 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -40,6 +40,21 @@ properties:
       - const: tsadc
       - const: apb_pclk
 
+  nvmem-cells:
+    items:
+      - description: cell handle of the low byte of the chip fallback trim value
+      - description: cell handle of the high byte of the chip fallback trim value
+      - description: cell handle to where the trim's base temperature is stored
+      - description:
+          cell handle to where the trim's tenths of Celsius base value is stored
+
+  nvmem-cell-names:
+    enum:
+      - trim_l
+      - trim_h
+      - trim_base
+      - trim_base_frac
+
   resets:
     minItems: 1
     maxItems: 3
@@ -51,6 +66,12 @@ properties:
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
 
@@ -72,6 +93,29 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1]
 
+patternProperties:
+  "^([a-z]+)@[0-9]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+        description: sensor ID, a.k.a. channel number
+
+      nvmem-cells:
+        items:
+          - description: handle of cell containing low byte of calibration data
+          - description: handle of cell containing high byte of calibration data
+
+      nvmem-cell-names:
+        items:
+          - const: trim_l
+          - const: trim_h
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg

-- 
2.48.1


