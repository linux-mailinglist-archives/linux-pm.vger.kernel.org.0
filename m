Return-Path: <linux-pm+bounces-36673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB260BFE152
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 21:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A456C3A76B3
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 19:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C62EE60F;
	Wed, 22 Oct 2025 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7c1txuq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7627462;
	Wed, 22 Oct 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162474; cv=none; b=YXiQCsEcKT1AtG1uslFXzdx1kpQJZSo3hUKU3oE4Ez3+4rcAyFPBy5dV6I/o21fPH5tiCGJawANu6lSCjfQF5EbF1U/Qrd7JpRqDCHZ1W4MBFQ+MhtJs8xvj91mvfztVn5js8UZoCDclmy8SNw5geA1H1L21DeG//e76xzVFg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162474; c=relaxed/simple;
	bh=xQ+BUaYA9+sDnux4cMTAPJKVbRgpy1rp0kViDSJoH8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nb5dyLNWebvABFzEOyYKeNGaxfg9vcwWGsil8t98qFKUE4+dAmAI/sdJQDTlij5/4FW2IxnabhyXXNmT+YVSkXR7JgaJxCshEkaFzqUMq+WiJOQKKiporEiW2rHM0OvSJFLezPfMJEqwIMNIoHJKWtH/eaou8VbKx+iBGBdO1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7c1txuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F5B6C4CEE7;
	Wed, 22 Oct 2025 19:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761162473;
	bh=xQ+BUaYA9+sDnux4cMTAPJKVbRgpy1rp0kViDSJoH8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K7c1txuqtbkR1DnEtuYETX6ACY9vTrTWm2YK8IpicehjnG9TSkhWwZoyP194FCRL2
	 YraqTo3X5fOFqIkpVSJeIP2xY+8gqn81YFBJ2pYWufMEmsIVzFrf91340J6GuXR8Nx
	 y0rY+n/oQInJCCkTzV5CQjmSypmkBia7DLl+679k5UA4fiD2aXwgmS1m2l77pd36T2
	 vRwirkzLJJwPKbmaL2H1F+KhGKj/Y/+XwoQCSvzbsfz9G+pVykvU7LGfgC7zIEF7mP
	 RXtjrkIpUISDW2D6cqTtsyUk2RnGDPpA4QaIuNIWHPCoualj3nSwmaVzy0jsjY/DF9
	 Rs6hls4GQ1n1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B3CCD1AB;
	Wed, 22 Oct 2025 19:47:53 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 22 Oct 2025 21:47:47 +0200
Subject: [PATCH 1/2] dt-bindings: power: supply: gpio-charger: add support
 for fast-charge timer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-gpio-charger-timer-v1-1-b557409400f2@liebherr.com>
References: <20251022-gpio-charger-timer-v1-0-b557409400f2@liebherr.com>
In-Reply-To: <20251022-gpio-charger-timer-v1-0-b557409400f2@liebherr.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761162472; l=1423;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=ajr1Bhnew2d+8SEwahiJrcr8lGScQzBku79JG1XD9nE=;
 b=EbKil6gHNtCPvQq7QlU/s/o4Q/ljGbZTtEI51tMdUowtCJReRu89E9V2OiOkZWmaR+01fU767
 fTQj21i8v7gCBIhSQBI0kC/yzJE8aQ3bGQRSfr2vMEWCTeEZU5i2FKn
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

On some devices like TIs BQ24081 battery charger it is possible to activate
or deactivate a fast-charge timer that provides a backup safety for charge
termination via GPIO. In case of the BQ24081 it is a fixed 7-hour timer.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/power/supply/gpio-charger.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
index 25826bfc289c1c00c338fd0cee2ae6932529cfc3..0edacc104186497118d4ba41f80947009a9aacf6 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
@@ -62,6 +62,10 @@ properties:
     description: Default charge current limit. Must be listed in
       charge-current-limit-mapping.
 
+  fast-charge-timer-gpios:
+    maxItems: 1
+    description: GPIO used for enabling/disabling the fast-charge timer
+
 required:
   - compatible
 
@@ -97,4 +101,5 @@ examples:
                                      <700000 0x01>, // 700 mA => GPIO A.12 high
                                      <0 0x02>; // 0 mA => GPIO A.11 high
       charge-current-limit-default-microamp = <700000>;
+      fast-charge-timer-gpios = <&gpioA 13 GPIO_ACTIVE_LOW>;
     };

-- 
2.39.5



