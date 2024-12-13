Return-Path: <linux-pm+bounces-19213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D009F15DA
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 20:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673F218882E5
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136B1E5710;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T37gwhN1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805E41AAC9;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118361; cv=none; b=gJbNnwRJ6NnUwHR+GjP+g3XWuIDZY6HGG0KriF1q2TnN7nXiDcnZnPnvU62jC/+2HnaWDw3lnK5FqkS/AvwcyGkTQ78lPIN58/VZ4phVLR48zIC7bJQHzLlKNEhk/oojlygFExf+Rhca7vPHcUSlUDPuNZP6OJYqT6eeIr8vsRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118361; c=relaxed/simple;
	bh=zBrEFzRF+ONq5p8sseXfBiRUhAhzsiBvv6Fdk5gxorU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLQcuN+5oWiJ2DtJMOfsuDhRC/KYoJbvIrmQkvKHiBF3FpaykZVpitj+xGDBNOpv/1qrC02+rlyp9CuvhOL39rbF4h3ziI5pUmNwc5kS/gJLpJxP6VAy7aQh8IC03t/yKEwl9X8n/QmtSqHQ1E1WtfpB+XD/8/i12y+CBtlRBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T37gwhN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44B6CC4CED4;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734118361;
	bh=zBrEFzRF+ONq5p8sseXfBiRUhAhzsiBvv6Fdk5gxorU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T37gwhN1bWNQaHq3HZZN5AqU2jesP8K7thL5w1pDTl7OPKsxG84SwhfBmIawdUvdh
	 JD5QXvCINvDMfsV3YxwouKi74wAOnTZGy3akih433lrG+XrX1aodKdK7rGYg65IVN0
	 XGBJnXBj+0FuOrYZwm1T+1TEIxUIgjDTYTOsHqc7KxIZKo5Q3J9ZhVqPZZU9lZCcOn
	 8xl0Tv54Y7Q3Tn6KOnabw5mVfAIJxZ0hBJQ/K3lxhROeIdx84aOHeUbjknQvmOkWKF
	 l+vUjdKBY6iVcxjVv0chXxzExu9gqAx4mBSlkEqrcYvnSc3mOIOiP5v+ZlaOn/LRAN
	 QLndXZ9xmz8rg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3481FE77180;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Fri, 13 Dec 2024 20:32:33 +0100
Subject: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: add
 support for default charge current limit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-default-charge-current-limit-v2-1-45886fce905c@liebherr.com>
References: <20241213-default-charge-current-limit-v2-0-45886fce905c@liebherr.com>
In-Reply-To: <20241213-default-charge-current-limit-v2-0-45886fce905c@liebherr.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734118360; l=1819;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=xPHOkmBcmrFBN+We7GCFKkiwe9/M3dsKAbtmh/lwHFg=;
 b=a+kt/CXCxO2G8iYjWRUeIlxyp5qEnMyFfbg1FB9SJkhRxCdfad4zpt/3dNHTWpXhvm8ml5QsG
 srVq9UZCk+BAodJ7SixLke3s+JwrIS3GxI1XGDBwLDfqROTbeIQOdqx
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

With DT properties charge-current-limit-gpios and
charge-current-limit-mapping one can define charge current limits in uA
using up to 32 GPIOs. Add property charge-current-limit-default-microamp
which selects a default charge current limit that must be listed in
charge-current-limit-mapping.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/power/supply/gpio-charger.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
index 89f8e2bcb2d7836c6a4308aff51721bd83fa3ba1..25826bfc289c1c00c338fd0cee2ae6932529cfc3 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
@@ -58,6 +58,10 @@ properties:
             charge-current-limit-gpios property. Bit 1 second to last
             GPIO and so on.
 
+  charge-current-limit-default-microamp:
+    description: Default charge current limit. Must be listed in
+      charge-current-limit-mapping.
+
 required:
   - compatible
 
@@ -72,6 +76,7 @@ anyOf:
 dependencies:
   charge-current-limit-gpios: [ charge-current-limit-mapping ]
   charge-current-limit-mapping: [ charge-current-limit-gpios ]
+  charge-current-limit-default-microamp: [charge-current-limit-mapping]
 
 additionalProperties: false
 
@@ -91,4 +96,5 @@ examples:
       charge-current-limit-mapping = <2500000 0x00>, // 2.5 A => both GPIOs low
                                      <700000 0x01>, // 700 mA => GPIO A.12 high
                                      <0 0x02>; // 0 mA => GPIO A.11 high
+      charge-current-limit-default-microamp = <700000>;
     };

-- 
2.39.5



