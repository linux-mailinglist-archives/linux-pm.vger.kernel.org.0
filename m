Return-Path: <linux-pm+bounces-36975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F031FC14D6F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 14:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E103A5E725A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C886D331A52;
	Tue, 28 Oct 2025 13:26:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3E8331A50;
	Tue, 28 Oct 2025 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657984; cv=none; b=ZL/DVmvY/GTZCrilmITIFDgt4OztfxjbERWGye6OYt/eUoS5Sr+Rn96n/VgAqJJZvvyOXsLJSIS541xNGzzAw6UFgGFWKh3NTo7SmjFnMPipDzO4jQOtKcCje70GpDCNxu+vplpOIQmxtcas6pMYmaFdmq9HZoUjmoDgOnejtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657984; c=relaxed/simple;
	bh=VK0xFORqjD9GsfjyNOt5wgOVhJIojWJEty+3Iu0v7gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqECn1doDXAoBBdiZU9yzkwHFiaDndTnZ2P/96jniZU3MVtPftLzoVyUYX6Sm9F4LUeRtW7M4Jk9Bpd0vENyw3ERs6kPQZM/btUxLtylIA08/xwUvamUdZ8OqXGk8d/ThVs2DhpG39kk3qcMUFmAYC4Oo1XClOfi8ylwuPmcYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: nHY/pupiS/2S0gTU/RH5LA==
X-CSE-MsgGUID: uuzbHpBUROSqoABQOVMDpw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Oct 2025 22:26:21 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 72F2A4005631;
	Tue, 28 Oct 2025 22:26:16 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 4/9] dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
Date: Tue, 28 Oct 2025 15:25:12 +0200
Message-ID: <20251028132519.1472676-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028132519.1472676-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251028132519.1472676-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include a
Temperature Sensor Unit (TSU). The device provides real-time temperature
measurements for thermal management, utilizing a single dedicated
channel for temperature sensing.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

Notes:
    V2:
     * merge two items into a single enum

 .../thermal/renesas,r9a09g047-tsu.yaml        | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
index 8d3f3c24f0f2..e0ce7d9da877 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -16,7 +16,13 @@ description:
 
 properties:
   compatible:
-    const: renesas,r9a09g047-tsu
+    oneOf:
+      - enum:
+          - renesas,r9a09g047-tsu # RZ/G3E
+          - renesas,r9a09g077-tsu # RZ/T2H
+      - items:
+          - const: renesas,r9a09g087-tsu # RZ/N2H
+          - const: renesas,r9a09g077-tsu # RZ/T2H
 
   reg:
     maxItems: 1
@@ -59,12 +65,21 @@ required:
   - compatible
   - reg
   - clocks
-  - resets
   - power-domains
   - interrupts
   - interrupt-names
   - "#thermal-sensor-cells"
-  - renesas,tsu-trim
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-tsu
+    then:
+      required:
+        - resets
+        - renesas,tsu-trim
 
 additionalProperties: false
 
-- 
2.51.1


