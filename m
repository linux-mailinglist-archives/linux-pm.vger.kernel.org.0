Return-Path: <linux-pm+bounces-38710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D81C89EAE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 14:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8798C3586DA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D698226165;
	Wed, 26 Nov 2025 13:05:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952C20B212;
	Wed, 26 Nov 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162313; cv=none; b=pNpjG1mZIS+H4q1R/gBlIOoVBr9s3UB130ir+jPeabCJsq2eV1PA+5zGt83STOthZj/oX+rmRsvvQXR1WYs+4uRovzHuFjhNEs/Ms1iE0R8hsN6nFBb4ZeXEsXtLfOM6gm7xxtz4n72hlCaNmzAvltbEYvA0WDeBTypcG9q0+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162313; c=relaxed/simple;
	bh=4SiWj9a1d7toS3gwQAjuL4oqqXFetkhqtGEYTIZAt6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foAwnHWFamOaaq/DojfJjv1NYkq3Tr9bOPW5m62/b4ODR8yDrGahuu1QlrDx/wn8dCMz1j/mzqDHkgJJJmFA0V3e+ca2BXI7yEpQivZNZK4Dj92/BUbIeNBtA3Dk9qRgsbVkBHh958QjyUYDLCtcuroX4KZvg6RAQPaVO46bdKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: BetQJCRUTSSDtfgZ3N8hPA==
X-CSE-MsgGUID: 0RCFpmENQbee/dnzMQpK4w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Nov 2025 22:05:07 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.98])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4F4D9400EF6C;
	Wed, 26 Nov 2025 22:05:02 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 4/9] dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
Date: Wed, 26 Nov 2025 15:03:51 +0200
Message-ID: <20251126130356.2768625-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
V3:
 * add more details about the differences in the commit message
 * rebase on top of [1]
 * conditionally add `resets: false` and `renesas,tsu-trim: false` for
   renesas,r9a09g077-tsu compatibles

[1]: https://patchwork.kernel.org/project/linux-pm/cover/20251020143107.13974-1-ovidiu.panait.rb@renesas.com/

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


