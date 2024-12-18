Return-Path: <linux-pm+bounces-19414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F549F6031
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 09:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2357A1B43
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5292117A90F;
	Wed, 18 Dec 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIs9kwNs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261C16A92E;
	Wed, 18 Dec 2024 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510907; cv=none; b=V/Zd1JvH85bIICIIXTzVggD8GZJVg/rq4lYsz5HnaC3Q6UXLPRdnHuzFyCcLsRryraFnseXdczeOG89LpXQnnEzsKSZ7UCi23LDBzBrwZ+1s4FCIPFAyAovkwc4wcDvL1+bVqJIJqFdfovl0E4sDLkaR4Se5+9mZukmZIj4LKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510907; c=relaxed/simple;
	bh=it8tnYGCa+Muv91dSWxcxqadp5VusIw+15FrGes9ePI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdhVaEWLLEJNJ2I9AFfdNHKDqxMx09Gpa+0+Yzqi6youl5JwdgLVWyGadRgiq1MIqWpKBz+EYIHKA9Hgo1gBWAdGUNtYUQyW08bTZFp10TxYHbrWw+KhPcG5df0oCV4ZK3hNcO7IkyJ7L4J2IRtT0jbzi8V9hTJkwSJuzJjQgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIs9kwNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB49CC4CED4;
	Wed, 18 Dec 2024 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734510906;
	bh=it8tnYGCa+Muv91dSWxcxqadp5VusIw+15FrGes9ePI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GIs9kwNsEMt5HGNwK31DKA4XiV2jQjOx4AmdyrTN5yCf3YVdCptONFK/IIuuTa4Ka
	 TDd9Ja/QvX8IGWZYSxKXc+mFzPPKRjtOt2o+b6V942SWu7uCTMb6JZpE2+eEuKQnep
	 UoGBsuCRNUL2s0zR6jDk1cjw+aA8SD+MvQYBGaznBNF7ze4N2dYr8B0t7eYooLm4hM
	 J2+V9hxscRLRiQWEC1h3z0nBlNRghs7s7K1GZp5wKrZa5j3XC9SJPx2MI0FOZsp68k
	 TuRIA9Mm2a1ps/eu/Fhznf9/r9uL61fBgxd3F4KJjM4KX6648i+FEF6rUu3Kwca+3t
	 oRoUYAfolKKzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46E7E77187;
	Wed, 18 Dec 2024 08:35:06 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 18 Dec 2024 09:35:00 +0100
Subject: [PATCH v3 1/2] dt-bindings: power: supply: gpio-charger: add
 support for default charge current limit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-default-charge-current-limit-v3-1-b26118cf06b5@liebherr.com>
References: <20241218-default-charge-current-limit-v3-0-b26118cf06b5@liebherr.com>
In-Reply-To: <20241218-default-charge-current-limit-v3-0-b26118cf06b5@liebherr.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734510905; l=2130;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=2q5GV8EMl0sfSm2ZGPWeIF1Jp2pHQa5oOgDB+AtoPSY=;
 b=j0TSn+iRF/6M3+yrgNDKIOv6HLfnRBYJvjDbCAIyCVbDOjY9Thes2n4OEfO0eDpTHa67sgRCt
 0Dd42ziCRWiCOK6MupHq2dcCnhy2LjAGIcHzATwgi97HRHhBf/Dq8Rb
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
This is helpful when the smallest possible charge current limit is 0uA. The
driver defaults to the smallest possible value at the moment, which
disables charging on probe. With the default its possible to setup a safe
charge current limit.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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



