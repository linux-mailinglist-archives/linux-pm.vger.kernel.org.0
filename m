Return-Path: <linux-pm+bounces-36698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7304BFFDAE
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C8354F824F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 08:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955E32F5A17;
	Thu, 23 Oct 2025 08:20:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521122F3C02;
	Thu, 23 Oct 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207637; cv=none; b=VVwzol0L2Rh6NjVFkJ7ZzMYe6W0rpsfZsg/Kdp1+sJx0gDWS/naWZSq+eI4e91cU/oDeVO02CcGKdHjJjV6vBemQhROnfnyeAfx8TvDXxkje6mcjIvJcZu2nI4SoAAj0Q3WdpsKbEyR+mP9NCg8tRATIEWMqkpbpCLYX4d97HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207637; c=relaxed/simple;
	bh=NIBKgKhv9xAfByUXnE0EheWDX+dBSuLYB4n/gpkUHZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wru1TcYOgS5ACf4aGwXPrseSxwLJ0yxMq2Y3SPmoV9vk0lI+83EG+eu+GoNsk0X2YTIV4VVhL86C/b4BJVX16GtC/U+eiRnZq9/AUK+2mbdPMwCeWeLyxj1Nob/49Q0Xd4O0V2awE7uNESp0iVSkOnGKDa3usQyIm7ka8hJWlKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 4ZjpXm+SQrOM1FWBtn5m4g==
X-CSE-MsgGUID: CXQsNf+OQkmoXlNNbE58fw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Oct 2025 17:20:35 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5BA07417CA94;
	Thu, 23 Oct 2025 17:20:29 +0900 (JST)
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 05/10] dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
Date: Thu, 23 Oct 2025 11:19:19 +0300
Message-ID: <20251023081925.2412325-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
 .../thermal/renesas,r9a09g047-tsu.yaml        | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
index 8d3f3c24f0f2..3cb66b51831d 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -16,7 +16,14 @@ description:
 
 properties:
   compatible:
-    const: renesas,r9a09g047-tsu
+    oneOf:
+      - items:
+          - const: renesas,r9a09g047-tsu # RZ/G3E
+      - items:
+          - const: renesas,r9a09g077-tsu # RZ/T2H
+      - items:
+          - const: renesas,r9a09g087-tsu # RZ/N2H
+          - const: renesas,r9a09g077-tsu # RZ/T2H
 
   reg:
     maxItems: 1
@@ -59,12 +66,21 @@ required:
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
2.51.1.dirty


