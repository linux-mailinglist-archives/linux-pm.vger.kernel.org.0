Return-Path: <linux-pm+bounces-38407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88282C7DE07
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF08F3A9A27
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A922C11E0;
	Sun, 23 Nov 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK8wbjiu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB1273D66;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763886984; cv=none; b=V9MITAQM/aPLArrcj7BRasPvvXUiDdZ2tQRZIdCafGabXIY+hEFQ5A9QvulX3rWhMKQS2ZV3ZYihVm6+ub69Cw5OkZrAFjJRqvFmiN6I5wVkScJrquzdHYL23Utquop9JyMh5zWgLQCka3biafBu5OQgP2pQpngz8s54M39mMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763886984; c=relaxed/simple;
	bh=r5AXU9CyKQzJCp1wGf8E69DJrr7/2kmGZppRmQDXWQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdTdKA7RvhhTKpHlEHohQBliZjHR4XxpViwuAjz59puyaYxfBOR/8zxXf4LcnJ4X/EWXCBpIo9OaoEByn5EGhLtIGktV3EmFqpOjXk/8ulfjf7syC2sx6JN1Vfj2boVehMpc8Ny1G0UjpyMXQp4isQ2dmODBs5U1J/eHHJG8vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK8wbjiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 708B0C19423;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763886984;
	bh=r5AXU9CyKQzJCp1wGf8E69DJrr7/2kmGZppRmQDXWQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hK8wbjiucVE5Lyw7Nw47ddXi0ltGzV2NlA1rr54UKhwSlVHvjQsd2FIOGFxAGOY3Y
	 Yjw2xOLyoo6lJUcXdbsD3++A6PRUJuxAzXHAtFktr3FN+UiCsGiG6o2VVgEuP4imX9
	 WAod9g3mNKML9t5ZgYvIQ0b8rjB4dBzYcSDtO003RzV0VaupNChph0fDJZjdZt7+nj
	 G/wLc1RUC9QfPdv2yqLMHHVNhf+m+LlDxZV1LYddwPdheZYRWnn4Q9mYtzQMyCu7WH
	 OEcgzVm9YVRKjWgN/rzFvreeHSzCADtn7WCZldc7Z3m38u15u+GF46pJCYo5vLlgdg
	 XfCxiYviKRyug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F91BCFC518;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Sun, 23 Nov 2025 08:35:49 +0000
Subject: [PATCH 2/6] dt-bindings: mfd: maxim,max77759: add charger child
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-max77759-charger-v1-2-6b2e4b8f7f54@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
In-Reply-To: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763886983; l=1264;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=qOK5jNVcnx5bjegC1dKWr0w0HMDBjskPRuyCz3Ci8qg=;
 b=qM5W227Kwrbrd0isfNpZBNhXmIQ8NbswaD5IYEMdymoheJrpiELbZYNT2HWxJ2SRpSo+eXcXG
 MwinsnfaCqxCyl++OgYXy2PKQWkgwjfJjmK1q419ZJ3qDZP8wc8PQ0m
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

The Maxim MAX77759 MFD includes a charger function, hence add its
binding as a property. Also, update the example to include charger.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 Documentation/devicetree/bindings/mfd/maxim,max77759.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
index 525de9ab3c2b..29132f73f2c8 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
@@ -37,6 +37,9 @@ properties:
   nvmem-0:
     $ref: /schemas/nvmem/maxim,max77759-nvmem.yaml
 
+  charger:
+    $ref: /schemas/power/supply/maxim,max77759-charger.yaml
+
 required:
   - compatible
   - interrupts
@@ -95,5 +98,14 @@ examples:
                     };
                 };
             };
+
+            charger {
+                compatible = "maxim,max77759-charger";
+                power-supplies = <&maxtcpc>;
+
+                usb-otg-vbus-regulator {
+                    regulator-name = "usb-otg-vbus";
+                };
+            };
         };
     };

-- 
2.52.0.rc2.455.g230fcf2819-goog



