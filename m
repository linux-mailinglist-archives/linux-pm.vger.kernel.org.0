Return-Path: <linux-pm+bounces-23197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1DA4A3AA
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB507A45C8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715B27C15A;
	Fri, 28 Feb 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="k896J3Vq"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63D279328;
	Fri, 28 Feb 2025 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773267; cv=pass; b=imMaTt+pcTwnGzTARxTBkgvlQvP8lYJaSBFECI8DPQW8uEGVaevPbIlpXuK29rRG3LrP0iBT7GrFyz69pkVOR6oD86ydiJpwU05kVtGdJtPhKEvvexisfM6GkGy5I2UpS2Cbm3ThG/h6bNVJ1dsJTGe/KKOeDJjPY1R7RbLzpz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773267; c=relaxed/simple;
	bh=DtReip6U4XN3sSXNJhgPWFN1oQ5CbENtg2X8SuudkZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8KUYvyJeG8hwM6XI39tzawS29dx/roA6UHAI9gkVil1O4QHn2DsXADzV3L0IHOOxHk9OA2pGiq6jkyOlINYlvjuTcEbB/qFQStOsgZckI5xmyLHEDlLS9REfEOaPvoSTTEYFI7h9uB91UkKiodAqpbeYX6SiGSTvo7jkbgWEJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=k896J3Vq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740773248; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B2VvnYR7p99Z/FRBV/uCqpgeU1cr1Hclbd0EsEJtpMds/+3/JgPNLNlS8fH/tIfjXlgjIGNbwllBFAd4rHvB36OEo8vQtQCyCvTWuOhsSAyluXMDyqI3LLCIONtj9HrgUBWZZwnZuA+yMQC5t9ZkFDxJV/HzLG61q9LkD5uq0Hk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740773248; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TgBqH7rUaFMbK1ldKLDc0I0GBrcJc+3ZZYqVQ3rPs/A=; 
	b=G2GVxEywJ9p9jITkbo9dBVRXgsoe0lgat2SHGtkYFHmdn0HspecsHz5Ldcu+07ScWG7076PEE9yN/3+1FNZTzysNXPS8ADm5RgRLn9VlfYnWhvNXLG5bQ/omgGfLxc3RWrxspQhHMgVTjagID7IrveWvyRgDDb+HHuL2lFls9kY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740773248;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=TgBqH7rUaFMbK1ldKLDc0I0GBrcJc+3ZZYqVQ3rPs/A=;
	b=k896J3VqAZ6YLxIhJ6gVqNm2vGpQicQRZUVtz/gmhxiSHJfRIryyqjhasim1ry+6
	De6KfzBC4cQ2BFmzsa7ZpBvJGCG7YWQgrLSPLTYtBYMj+gs0fOURRgEatxIsing3Nbf
	QWgzwQoX92Xo8fNp2r+GgM8dKPgql7nz/dNF39aU=
Received: by mx.zohomail.com with SMTPS id 1740773245418143.92950731334724;
	Fri, 28 Feb 2025 12:07:25 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 28 Feb 2025 21:06:54 +0100
Subject: [PATCH v3 4/6] dt-bindings: thermal: rockchip: document otp
 thermal trim
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rk3576-tsadc-upstream-v3-4-4bfbb3b699b9@collabora.com>
References: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
In-Reply-To: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
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
2.48.1


