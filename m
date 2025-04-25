Return-Path: <linux-pm+bounces-26244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A69A9D1E2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E504D3BC373
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027CD2222BE;
	Fri, 25 Apr 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="JzvsDtN8"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE72222BD;
	Fri, 25 Apr 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609745; cv=pass; b=ebw1J+ds/pR268XtPXSnj78p1bEyK4JHLWXFq5f5YEklSMYd/B3Si2CNORx4Ze+SVRBbbPURzTPmOxCMO7zM+5VwCmnyH1KjCBfDvuMyoEH37tHBnnWR7vhGyxyZQoHXwOtluy90ej3smvuFfjJnhpS81QD9+t0doAXQ5+UluLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609745; c=relaxed/simple;
	bh=FoWMjDmO2aKeoAixKfxZAoOSSDCvWyZ86m4+dMoOY44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6VQ4nF65l6GU9Wp/8qGCMBi/Zv8kBF2hIz09AQN8XgSu/BQa8ErPqYoqiCNoHJB/T7I+BYGNPZ3TIHkpvTYZsJtNjFdMRMCrxsu+0trpNfwAi7Ie/bItxeMTVtH7vLoj1XeMP2stj70ZehPZ1H9ZE1KhFX9CdKGeTkseDnHPok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=JzvsDtN8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745609722; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mHU0CCagEqcLyER1i8UTBozh0amY9wTGdU82aLoMKBtdLTX9Mqe7cI9fHqEvs7MsmDLX9/BaTrcaF43UlPAPoe4B4klIJ1CRiDXwyu7k4QR/KkCH8GWTphwo0O78WvRHh7KgfwX7f8tGgXwccjJyV1B8VAG0UHIqq6k+aqk8vKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745609722; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P1s5SW5XXy2Nmw/a2myc1LsBMYI2XBbGAAdPmoWnhN4=; 
	b=SeHFRCfNSyPyav3qaoxIZLXHey4xrNfJUDPf7yMFIf7wKWAeB1wPrYSOPwGaJ/qRDJID5bPntWl4EPCoc0pyaqHiLkF/AkQz6QYV7Xcgx+yIZh/XCy7qzh0YmXoHMQXZqOjIFkzf51veAaiSxne4JS6jINKDCAmKlrih2PWF+/k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745609722;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=P1s5SW5XXy2Nmw/a2myc1LsBMYI2XBbGAAdPmoWnhN4=;
	b=JzvsDtN89NXv80lr/+qJUJOMdOFbwwJDnH2pOJ2uvTN/0lS9ScV+rFd78cAuQpRw
	L8/2dZifCY6Fc5+uwCXg1zN5xKqg8bZOeZgLLb2ydBm0np5MlC7F9ASRUCwWhsA+pTi
	ifdbp0NfiqEXlVPk8hewnmJ7SiMB2/OetYhAtkdE=
Received: by mx.zohomail.com with SMTPS id 1745609719487687.5398432950291;
	Fri, 25 Apr 2025 12:35:19 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 25 Apr 2025 21:34:38 +0200
Subject: [PATCH v5 4/7] dt-bindings: thermal: rockchip: document otp
 thermal trim
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-rk3576-tsadc-upstream-v5-4-0c840b99c30e@collabora.com>
References: <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>
In-Reply-To: <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Jonas Karlman <jonas@kwiboo.se>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/thermal/rockchip-thermal.yaml         | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index 49ceed68c92ce5a32ed8d4f39bd88fd052de0e80..573f447cc26ed7100638277598b0e745d436fd01 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -40,6 +40,17 @@ properties:
       - const: tsadc
       - const: apb_pclk
 
+  nvmem-cells:
+    items:
+      - description: cell handle to where the trim's base temperature is stored
+      - description:
+          cell handle to where the trim's tenths of Celsius base value is stored
+
+  nvmem-cell-names:
+    items:
+      - const: trim_base
+      - const: trim_base_frac
+
   resets:
     minItems: 1
     maxItems: 3
@@ -51,6 +62,12 @@ properties:
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
 
@@ -72,6 +89,27 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1]
 
+patternProperties:
+  "@[0-9a-f]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+        description: sensor ID, a.k.a. channel number
+
+      nvmem-cells:
+        items:
+          - description: handle of cell containing calibration data
+
+      nvmem-cell-names:
+        items:
+          - const: trim
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -80,6 +118,29 @@ required:
   - clock-names
   - resets
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: rockchip,rk3568-tsadc
+    then:
+      properties:
+        nvmem-cells: false
+        nvmem-cell-names: false
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - rockchip,rk3568-tsadc
+                - rockchip,rk3576-tsadc
+    then:
+      patternProperties:
+        "@[0-9a-f]+$": false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.49.0


