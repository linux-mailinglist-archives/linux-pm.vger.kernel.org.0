Return-Path: <linux-pm+bounces-39689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4F9CCDDD1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 23:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBED23025FBC
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 22:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A8530B514;
	Thu, 18 Dec 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB+P3Kri"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB61DB54C;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766098183; cv=none; b=Nf0bHoonr66tl3gGJtEweVyKBKzuSty4wD+Ras/3yEZR0o0BSDzCXKLvWFpnjsFy46CX6k5nvqvUdO7bXQwjJiaJSRBHS8o8HJa8AzaxFP+Uie7ixJXYMy62gvVXeRiCohHirNgu/+sLdw0UrDQYB0FUs2nhOHH+4sOHm7NFkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766098183; c=relaxed/simple;
	bh=etnOPKtYKB3s4gRzuPiCpjilG+Q6bKbMiIq4AECF5d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ak0F7EqgIzewbhbcPOPfbXrwcsDAwRjJJ0q1ZE7QtUyElsIzndLT7HcdK2WECvEYRwlA6NpRYuD/d+64HTRW/zafvLFcIPIhlUsC4sGhMfNyI6NwIPBxKcYaI6yeiPAXGGK7ZLuTV0q3qpbK1fZpcZC5XdldMtUgvO2ikV8a/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB+P3Kri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CC41C116B1;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766098182;
	bh=etnOPKtYKB3s4gRzuPiCpjilG+Q6bKbMiIq4AECF5d4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WB+P3KriD02CQyZ3xQ+z/IYgOHp0OjXpDcMNW3ItY/xa8YklEV63y8ojDVvtQBET/
	 8fpQwsY6JKr22OsLlhmFJz3dubNS05DHJyocErhY9NyswSWRcrX9AZs2HZZUlMX46B
	 LrY1KQXz61P303X5lV8gzdzj+ZYi86PySmwHEAp9ep6N52tsdE6x57N8HDgSc4hOTn
	 dGBcjSVv/0RZ4gbV4cYrAnyMkF9A0pX8uUcMOz74liesIvlf43d+r4d8gr8OrQWICZ
	 KkKA85uHrIeY55pl+X2xz+elbxCwwre3EQantL5t+SyOOY+MuEWElsXXdWbQMA7j+9
	 wmxjQlZIG7kFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C74DD711C8;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Thu, 18 Dec 2025 22:49:06 +0000
Subject: [PATCH v2 1/5] dt-bindings: mfd: maxim,max77759: add charger child
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-max77759-charger-v2-1-2b259980a686@google.com>
References: <20251218-max77759-charger-v2-0-2b259980a686@google.com>
In-Reply-To: <20251218-max77759-charger-v2-0-2b259980a686@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766098181; l=1858;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=7Z+OfAwjbAkzdqPSTAxyljLhXicf0T4G1279sUdm3LY=;
 b=NYQG8juDPo2XeqgvzUfn+5NDPn30xfqT6cDA5knYDKoPM7jhRybeGeNk7u4BE08n2rSr/z1BA
 laoPDdVtOFZDPHqk+OpHYd57jiWUyBcj9PxmtevU7BhZHCTP3QVMoJF
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

The Maxim MAX77759 MFD includes a charger function. Extend the max77759
binding to include the charger. Also, update the example to include
charger.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 .../devicetree/bindings/mfd/maxim,max77759.yaml    | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
index 525de9ab3c2b..1cffdf2e5776 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
@@ -37,6 +37,30 @@ properties:
   nvmem-0:
     $ref: /schemas/nvmem/maxim,max77759-nvmem.yaml
 
+  charger:
+    type: object
+    description: This is a dual input switch mode battery charger for portable
+      applications. It supports wired and wireless charging and can operate in
+      buck and boost mode.
+
+    allOf:
+      - $ref: /schemas/power/supply/power-supply.yaml#
+
+    properties:
+      compatible:
+        const: maxim,max77759-charger
+
+      chgin-otg-regulator:
+        type: object
+        description: Provides Boost for sourcing VBUS.
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+    required:
+      - compatible
+
+    unevaluatedProperties: false
+
 required:
   - compatible
   - interrupts
@@ -95,5 +119,14 @@ examples:
                     };
                 };
             };
+
+            charger {
+                compatible = "maxim,max77759-charger";
+                power-supplies = <&maxtcpci>;
+
+                chgin-otg-regulator {
+                    regulator-name = "chgin-otg";
+                };
+            };
         };
     };

-- 
2.52.0.322.g1dd061c0dc-goog



