Return-Path: <linux-pm+bounces-42847-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLIrG5U2lmmlcQIAu9opvQ
	(envelope-from <linux-pm+bounces-42847-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 23:00:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178F15A815
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 23:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F7530624A6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 21:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D374C33507A;
	Wed, 18 Feb 2026 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npqdvTDc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81B329E53;
	Wed, 18 Feb 2026 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451963; cv=none; b=LknT24CMSLjdZRp2xPiP9lqFR0DarSvlJWae2VqUomu+z4FDKZS86AatvHbQgbe+eN32S0VJZ0bgBjtDT3Ik3It5Od16RsUgy+V0MPpHS+Lo0XE8UvXVlLvdWl6Ldu6QCrGvpsiAb0XJs+Qbd/g8fNSxlmLgiKbQDz8vqQnUqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451963; c=relaxed/simple;
	bh=x3MSxPPiAQzrpW8S8tocji0xTxlKoglgHtkqvwONCMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tq220/l342i5wDMHtADADoTsjrzQsvLxkhgrcaouGfTpg3uFnMnjgSN9qfI8C0V9OkGvUEQtgf46WB9ynf2cnSx164MG5FsjaAo8/3D41jY00P4p/rVKfd5q95egnVV+aBCWmkU5Rdo499RcAM+mkOqLzEcw9deBUibduKFDgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npqdvTDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E05BC19422;
	Wed, 18 Feb 2026 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771451963;
	bh=x3MSxPPiAQzrpW8S8tocji0xTxlKoglgHtkqvwONCMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=npqdvTDcw6cBD2B9//DZQWv2UhdSZlFgQ9Bi3BC933todqgYuQZGhJ6FSEDYZgvvq
	 cupPRNCKPuSV6Hf6aaaNuC14TjX4a9UEfJN2iD5A1hZGlk/SG2jibDPHPfFWSuZ7LA
	 o4WKGLcGN1oW2l5WrXOvWSkWEJeryWoshtyctHplSak14heDBFRr3bNWVlRRfpxfRg
	 0Z4oHkWWrDvpIvPz7s30GsnTfiLtfOYjFD75NHA35ta1Wz9nKPakdKZDoV7g6q8kIO
	 gahLe+QXwASfNNErXddqWy3LzzaRob60+Mp5uYK2eYKFK24hKt/St+vbyJnGBskEJt
	 At613eeJLmqzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C668E9A02C;
	Wed, 18 Feb 2026 21:59:23 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 18 Feb 2026 21:59:09 +0000
Subject: [PATCH v7 1/6] dt-bindings: mfd: maxim,max77759: reference
 power-supply schema and add regulator property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260218-max77759-charger-v7-1-e8d907ce69c5@google.com>
References: <20260218-max77759-charger-v7-0-e8d907ce69c5@google.com>
In-Reply-To: <20260218-max77759-charger-v7-0-e8d907ce69c5@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771451962; l=1953;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=wKn6cXtOjQRJU9Be07/BXhWg1aULQ813q+DzUXVKIVU=;
 b=wRiYAbfCf6ad9jYKZQr64vawzgO8UAIiMNDlzdxBPl+bSya+FEswJW9ZGsyQ6NsWLM0O6/UNn
 QwranywGfRbCraKcYat3HwB5ObJRSpIjc8tLJbDG32KHuu/J0aRb/yi
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42847-lists,linux-pm=lfdr.de,amitsd.google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,gmail.com,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	HAS_REPLYTO(0.00)[amitsd@google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 0178F15A815
X-Rspamd-Action: no action

From: Amit Sunil Dhamne <amitsd@google.com>

Extend the max77759 binding to reference power-supply schema, so that
PMIC node can reference its supplier. Also, add regulator property to
control CHGIN (OTG) voltage.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
---
 .../devicetree/bindings/mfd/maxim,max77759.yaml          | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
index 525de9ab3c2b7b431e48497330640857540625b1..42e4a84d52043c09bd073dec391a3bd76dbd359b 100644
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
2.53.0.371.g1d285c8824-goog



