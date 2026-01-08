Return-Path: <linux-pm+bounces-40502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594FD05EE6
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 20:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F16B830109AF
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83532B9B1;
	Thu,  8 Jan 2026 19:53:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFCA2E9729;
	Thu,  8 Jan 2026 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902034; cv=none; b=kZNcqopiifzitqO8Rlu0HvVTd91bVvfIQy/gEwvoh78aGk0ievIJFmm4yR5iNZs6rdBKBKQAKgWts/N1wYYBVbP/3+YgYyvV0hP5WOCBID98TWUN3iuxpKTZlOdpYBhfvkLbtIOAvem1RicxUlJWaVjPs4QaTCR2q46AX1Q7fhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902034; c=relaxed/simple;
	bh=qLj1QaAWP2VeWl2zBU2ldUXeT/ISdiDB3FEOrFQCG0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arehvFR/G7J8eTr1syF7e9K7CHA5iMj4hX7SenhX4wOeX5iX0eVLuj5fRCcJBf2IIOJt//8ZlI7maHupI0M4cva2gkVv9f6XXzC55KAgRljIBAQV5CHUgO9QCzjGuKQqNgNKYp+aJ3iq3K1yTTG5opofwxkhXZJv7+0byNfGLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: DzSBjrZAQzyRTU5czJjO5w==
X-CSE-MsgGUID: yv/MPTG4Rd2N85dXF5FfLQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jan 2026 04:53:47 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.68])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3A7D74008A2E;
	Fri,  9 Jan 2026 04:53:41 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 4/5] dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
Date: Thu,  8 Jan 2026 21:52:22 +0200
Message-ID: <20260108195223.193531-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

Compared to the previously supported RZ/G3E, the RZ/T2H and RZ/N2H SoCs
do not have a reset for the TSU peripheral, and the OTP data is exposed
via ARM SMC, as opposed to a system register.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V5:
 * no changes

V4:
 * pick up Geert's Reviewed-by
 * pick up Conor's Acked-by

V3:
 * rebase on top of [1]
 * conditionally add `resets: false` and
   `renesas,tsu-trim: false` for renesas,r9a09g077-tsu compatibles

V2:
 * merge two items into a single enum

 .../thermal/renesas,r9a09g047-tsu.yaml        | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
index befdc8b7a082..a04e5048eadf 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -17,10 +17,15 @@ description:
 properties:
   compatible:
     oneOf:
-      - const: renesas,r9a09g047-tsu # RZ/G3E
+      - enum:
+          - renesas,r9a09g047-tsu # RZ/G3E
+          - renesas,r9a09g077-tsu # RZ/T2H
       - items:
           - const: renesas,r9a09g057-tsu # RZ/V2H
           - const: renesas,r9a09g047-tsu # RZ/G3E
+      - items:
+          - const: renesas,r9a09g087-tsu # RZ/N2H
+          - const: renesas,r9a09g077-tsu # RZ/T2H
 
   reg:
     maxItems: 1
@@ -63,12 +68,31 @@ required:
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
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-tsu
+    then:
+      properties:
+        resets: false
+        renesas,tsu-trim: false
 
 additionalProperties: false
 
-- 
2.52.0

