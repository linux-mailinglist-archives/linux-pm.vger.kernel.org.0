Return-Path: <linux-pm+bounces-40569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B38CD0BE71
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 19:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78477304065E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1ED29D29E;
	Fri,  9 Jan 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agf9BaFn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97252242D97;
	Fri,  9 Jan 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984086; cv=none; b=i1pR/s8frAd0oWiQUx0E+zWVQVNM7ch9+gFxa4WYYGQAHhEO8li2/s9qS57Le9M+GF4NjQ4ujyw3NwZvWS8nRzUwbajBSI7RELdJojKx0EDqUUw6osUUhEXXwthk3EDFgGabMV2RYuy/eYAYsvX7uisiGEIha+iQxXYzdgsGDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984086; c=relaxed/simple;
	bh=+JkkifTOJxSCpXoV2BVeXaPAEiFajo9VzT3RGBLCJoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/C6v/dg6wu/o9cUNNkqza5vopK0LRWke/AJ9ssP8blsWugdA9E5KBiiasDa7whQOJUIFRVNlObdm61TTDvbqVVZELbTZ7Fn+tgPFfXLw4nNMUUHMMn8MZDEEg6j4fIJObYuIytQERqKmA87PewMjIDDhn4nG7UxKJDG/qXDBLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agf9BaFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 482D9C19422;
	Fri,  9 Jan 2026 18:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767984086;
	bh=+JkkifTOJxSCpXoV2BVeXaPAEiFajo9VzT3RGBLCJoY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Agf9BaFnZXdcg0wPOSSvOJYxffw+1s65w6yAEnJOVJE0TpTzsILdDZYrgzFVBDGAc
	 TH99YCZAym34MDC8E70HqZAzxe91vn+jkR2xJrxFWJJOGkZRg/PKfhGJ4/Uf+evCEt
	 eLINhzw/EgYyU3Oj7Lj5yPfrcyhuG48SB286KGOsqVOnOGh54dQNxHUYnHJY/9Bbmd
	 WZgqxcMG3LsUhaDmBLHx/HPEcnd+mJ1+RZ9tc9AR7wkDCNw0Z2JCmK/4ppL4tOM8tH
	 Z+xXh3B0IBJVRZf88ZUaWumET/oaP8MQQv96+S4iZPujh2b/6UcmCpCfa38cq1j1GA
	 zqbxkHWVykqJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3409BD26D94;
	Fri,  9 Jan 2026 18:41:26 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Fri, 09 Jan 2026 19:41:19 +0100
Subject: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: add
 support for fast-charge timer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-gpio-charger-timer-v2-1-63fd1ba75830@liebherr.com>
References: <20260109-gpio-charger-timer-v2-0-63fd1ba75830@liebherr.com>
In-Reply-To: <20260109-gpio-charger-timer-v2-0-63fd1ba75830@liebherr.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767984085; l=1476;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=iQZT3H4QbthJR7XgNMzV+OsM4tGWzdI0GFJQLgU7bk0=;
 b=h2gn5xZzegIl21uvYWmVePlzgBTuKD2naV0Sr/uFrdXzN4B+309QaSQ889ueNXPoAGKHAyiBO
 IfKjd3NpF0iBHEQpmw9dPofr0c/+BYec4aytaD4xHd7SmqmQaXOig4X
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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



