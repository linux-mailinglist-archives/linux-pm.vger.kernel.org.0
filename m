Return-Path: <linux-pm+bounces-37975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4320CC599EB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8752E3B911A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4A031AF01;
	Thu, 13 Nov 2025 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="j3FOhaFn"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BF318131;
	Thu, 13 Nov 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060777; cv=none; b=Ln6BnU7gLSFxZdKm5ZzuWp8riadpSuM0nTlBYgzXulc75c04SUiTEnVLSuUvO3DFECJnwpzeN6fNGqFjn6AYM25P8CPLaZiCYdek0pJCS4Q0UBw1X/2N+Kq4rhRU+U/UmQCwaQB0aiH7yQTiKx0jGGWSdKLZqqgYQX2+KTe9cNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060777; c=relaxed/simple;
	bh=5FNwlUMck66ibENDTF/wvOSl606brZH0+kglqdmd2yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/g7W+7uePLHPlmb54h6rTaJhJJSQD8SwhS2cBlEhQlFyzJid7j1FKQb8rUwh89hhprhQS2e28W+yFfzfcLPaPl2mpYs6nxkyS1mn8wj/IeMlxN/0CPGRnJmZGzTDDgwpkxhtvLVvqjHCeyhYpX82iMAZSuFkEc69i2A9LBquKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=j3FOhaFn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B2CBE26715;
	Thu, 13 Nov 2025 20:06:14 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OYT87sDU0UDO; Thu, 13 Nov 2025 20:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060773; bh=5FNwlUMck66ibENDTF/wvOSl606brZH0+kglqdmd2yA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j3FOhaFnd7kUuP+A/L8E9sTa0/h9lYUUoHB09oLDatUTMiBWzvQxrv9HWshAgaZY3
	 sJ3yux4UJmrzvjx+Hzr6KWSKkIAqJ4IH6LKKZ+K/Q0pfWBkGS77fCo9SOdc3F7J8h0
	 ghEjDtqaCqD/p0UO4waztjGgRwEIr9l6cQwMf74ynUHXYGj5lSzxdzfF3ghmGHLtoi
	 d/l3D0YCyAl+7jDg/Uml7QPr7F1ZcqnM+GiJvHBMCkkYgA96nVt7en8QsucXRquqs+
	 HRQEhahNTsC6bn5r0AQK9v7imz4un1AOoITBgtTMLgGn5NQrkQrdHJ11dMrsGyeouy
	 xpH/RsPmOJssw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:05 +0530
Subject: [PATCH 04/13] dt-bindings: power: supply: document Samsung S2M
 series PMIC charger device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-4-9e3184d3a0c9@disroot.org>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
In-Reply-To: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=1991;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=5FNwlUMck66ibENDTF/wvOSl606brZH0+kglqdmd2yA=;
 b=/rgPRmJbUWtoTa+xBitTvM7xRSzqUo4FD2voBD6lgnY1G9qD9+nlRGRuCqqcrVpbn+lIGIBio
 ISj27oCVGqIANZ35U6VCzSXldIGg+avmwqYXP1ggWPOkU2jpATTzk2Z
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Certain Samsung S2M series PMICs have a battery charger device which,
among other things, manages power interfacing of the USB port. It may
supply power, as done in USB OTG operation mode, or it may accept power
and redirect it to the battery fuelgauge for charging.

This driver depends on the MUIC device present in the same PMIC block.

The initial driver introduced has support for S2MU005, add its
compatible as well.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../power/supply/samsung,s2mu005-charger.yaml      | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-charger.yaml b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-charger.yaml
new file mode 100644
index 000000000000..80292d6e2562
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-charger.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/samsung,s2mu005-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery Charger Driver for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC battery charger manages power interfacing
+  of the USB port. It may supply power, as done in USB OTG operation
+  mode, or it may accept power and redirect it to the battery fuelgauge
+  for charging.
+
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-charger
+
+required:
+  - compatible
+
+unevaluatedProperties: false

-- 
2.51.2


