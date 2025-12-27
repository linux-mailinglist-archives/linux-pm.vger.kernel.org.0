Return-Path: <linux-pm+bounces-39957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E75CDF264
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 01:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB89630019C6
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 00:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C1EEBA;
	Sat, 27 Dec 2025 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJskyn/p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC6A41;
	Sat, 27 Dec 2025 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766793899; cv=none; b=i6M7J7EgtewF/QbsVqpL2rzULVufbYbI2ms9ANP2ZFT2SwY4OSJycbv3FSQNwH+/VpIIvgGA3OFdBPfFBI6EZ6IczWB0jZUwNLBTju2aAzx7l/cON8MF8zX/eG9v62Lv60QYpNVom65P+V+q/p7NR7YnsAEpig6f1CSG/X69QX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766793899; c=relaxed/simple;
	bh=E4vpV8dA24wd0RN1Q8K2x3/E2u3fzxRNDtwrsUcSQZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9RSf/GiXCq2Ym8EcFfWDFw1ZDbWp5TS6DifkmZAoy1iUTl+45Y1Ae/AWYO0wf4DIy3g7PBoBgAWsSNafawZYBcCAbp/WNueewVo7l2pHh9/nA2CyHJmGqX1m7673hvcsdf0sgm+jysIgkU+lCw84aHm/LsF+aZFfujbF8cAv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJskyn/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4621C16AAE;
	Sat, 27 Dec 2025 00:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766793899;
	bh=E4vpV8dA24wd0RN1Q8K2x3/E2u3fzxRNDtwrsUcSQZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sJskyn/pbXkPbDeuRR0IV8SemUpXikGEgwtvU47/CK3blT4HMOmHkm7ImGWQwmB7/
	 n/yqJvKxQKw7shHJ+tSlvBG9/VCNrCiG9azJYVT3fy0d6cDmdI+5r/6/cyNBtWb7la
	 nQQ012ycZT1JAb+M8hCjHdgD7siY4puJWlgYQcn2Wro/eVlDYS2GGz79A+cC00DxcN
	 lUIw1u7ZL+9jJiN1Ra2jNytQg7ICYK+4Zjie9Bx5Aj8ySyxWlo9P8cOjm05e4BOItb
	 sBr1P64Jnh2O8ajzMompMDoEAKK3t6l3uK9/AXLXHD/3N1e+L9EhPAY6oBktIamMki
	 HgHh9m8naGocw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC4E8FDB8;
	Sat, 27 Dec 2025 00:04:58 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Sat, 27 Dec 2025 00:04:21 +0000
Subject: [PATCH v3 1/5] dt-bindings: mfd: maxim,max77759: reference
 power-supply schema and add regulator property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-max77759-charger-v3-1-54e664f5ca92@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
In-Reply-To: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766793897; l=1768;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=CE42oYoNrplygMzTNiDxOQcFZJE+nR+C9cWKUNNQJSk=;
 b=3nHfaOeMdXmyDbES/EYFEJxDUlJj2ia5MIfjr0bLC+pSPc0EWK092aBUiqFECkLsrCkAWIY1w
 emdyn7UTQPWBl3en0Mw+atF/37pzsBdficyx2WgQ+g+EZDaw/GBylYV
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Extend the max77759 binding to reference power-supply schema, so that
PMIC node can reference its supplier. Also, add regulator property to
control CHGIN (OTG) voltage.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 .../devicetree/bindings/mfd/maxim,max77759.yaml          | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
index 525de9ab3c2b..42e4a84d5204 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
@@ -16,6 +16,9 @@ description: |
   The MAX77759 includes Battery Charger, Fuel Gauge, temperature sensors, USB
   Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
 
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml#
+
 properties:
   compatible:
     const: maxim,max77759
@@ -37,12 +40,18 @@ properties:
   nvmem-0:
     $ref: /schemas/nvmem/maxim,max77759-nvmem.yaml
 
+  chgin-otg-regulator:
+    type: object
+    description: Provides Boost for sourcing VBUS.
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - interrupts
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -59,6 +68,11 @@ examples:
 
             interrupt-controller;
             #interrupt-cells = <2>;
+            power-supplies = <&maxtcpci>;
+
+            chgin-otg-regulator {
+                regulator-name = "chgin-otg";
+            };
 
             gpio {
                 compatible = "maxim,max77759-gpio";

-- 
2.52.0.351.gbe84eed79e-goog



