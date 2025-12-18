Return-Path: <linux-pm+bounces-39691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0954CCDDE9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 23:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6375C302CF52
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 22:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDD03164A8;
	Thu, 18 Dec 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yrx++GXK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBBD25A357;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766098183; cv=none; b=f5HARm+OBov+zOc68U/YhD/VqEecagex931G01UDfOZkQIIrjb8qxXvkPP2eBvDlmsjqj6HWkR2kJvF+vNNTQQlwj766ed3vVrN/VhSXSEvK+v+vwWiWNvvtsHe73hLWh7szp+HlVo77/Rk0/sbdJ6uY6a6TXAWazTwV5Smvm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766098183; c=relaxed/simple;
	bh=h+Oj+GmhwVLMyj/xPOzrX4BfbZVY0fVlC79Y/eTnLdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfozJ41i5rHkbhpG56jS1g93cBupfi40oNb9eXn3sy6WuR8NzRx34X30iBRx/T2BUxjdQ4XtKSnBjqu7xvDdsS3vEN+vSCGRf+/4euJYFSiqRvoMwRyr2yxI+lWKeIJUbotyw1FtMwlWcR36tBbfYTjJDu01s/x62Rq9Iyjih08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yrx++GXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D259C116D0;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766098182;
	bh=h+Oj+GmhwVLMyj/xPOzrX4BfbZVY0fVlC79Y/eTnLdw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Yrx++GXK3LIluNhbMCH1kUMlB/bu+DpxKGBGaxApqRdfKYy2WVNQjKIa4we00IxwZ
	 h4rw14+timn532s8b2m5x56DqFSaBWJSZVBBRX/1LiiEfC6p1YSk0OoLZb4MezG8j+
	 08ELM7rKNl8ACYN7Zwsujnq7VqoUrlLBi5Oni60mrVrQD5Wh9RLAVM2/+ijYkXMLGN
	 IER0cKbEqfjkEEcSi3WK4zRjRgv0Nt9ziOEVr4zs4WiZe3ej/+52g+MPAZhN+G37Ub
	 vvwgoFB1RQphLQ/N1L/gtdRdelHeu2uSU5KKmNk2p3QKNquKfTkjA+EFhRizFbk+6u
	 iCsFTMYdV/gCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D125D711CC;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Thu, 18 Dec 2025 22:49:07 +0000
Subject: [PATCH v2 2/5] dt-bindings: usb: maxim,max33359: Add supply
 property for vbus
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-max77759-charger-v2-2-2b259980a686@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766098181; l=1202;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=p7/alz9n6y05bnrfpD6b5qhK9BuaF/sZOfVYP+jZ/qo=;
 b=vrq1PXYO3QcKLtCjS9n9Xl4iqOZhsHY/5s68gSfvm5Q+2jvAMZiMU5o28BFOUx5PLMvT1+r2I
 7s4F5a8xlptBzmMuYUJU0sZ5wMGtR0on38StpNNcaTQvTSfST5kZmiV
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add a regulator supply property for vbus. This notifies the regulator
provider to source vbus when Type-C operates in Source power mode,
while turn off sourcing vbus when operating in Sink mode or
disconnected.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 3de4dc40b791..e652a24902ea 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -32,6 +32,9 @@ properties:
     description:
       Properties for usb c connector.
 
+  vbus-supply:
+    description: Regulator to control sourcing Vbus.
+
 required:
   - compatible
   - reg
@@ -53,6 +56,7 @@ examples:
             reg = <0x25>;
             interrupt-parent = <&gpa8>;
             interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+            vbus-supply = <&chgin_otg_reg>;
 
             connector {
                 compatible = "usb-c-connector";

-- 
2.52.0.322.g1dd061c0dc-goog



