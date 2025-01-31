Return-Path: <linux-pm+bounces-21195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB5AA24598
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 00:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD04E1887A68
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 23:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0E1F2C21;
	Fri, 31 Jan 2025 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJYWQ6va"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961861B0430;
	Fri, 31 Jan 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738365445; cv=none; b=TybGidOt0aGeiQNFlWO/vUlP3OMe9Ap3w0GoHGkStzwyqDMwXP0BvA6uVM/ChcVQDrK49FeGHvBlzwKSoKsFEMkTy7cx2YhAi+9fS2Tz0wrVMkPjbKU9TpBL4WNHOjexVIrQg0bGlhcBVZlh4ejvBvAFMMe3E+gWBpx7c5clpB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738365445; c=relaxed/simple;
	bh=OheuIsXal5ELPtW/MGuDmGxWvHjuF3GuZlgFTGOYNcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQtSwn+mlpwv986IHhTcgGiXJdryg4fTF/QWH6AGjoGqQxC83eYeEuDTGpdKnaj/v7VWRJGWVca+m+0QVbqMIxAymDQDR6DDOH5ji1n13PfXTWtej6QyuHE1T+OwxN5YR+MERNoAc9oaK6qV20UnXp4hnrUKiO9qzHPXscBgYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJYWQ6va; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e3284f963so1316506a34.1;
        Fri, 31 Jan 2025 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738365442; x=1738970242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0AvaeYEwbl4eYOtBZm1BZYUzls9/jU76Z0u4jhcL2E=;
        b=jJYWQ6vabX0oTV3B3euY5OJPJPdWLQL5Wx+V5mjCNZ0QLoq8GPzy9eJuFlrYk06TSH
         ak5998kIPlEt9QWwy0oHRxxD8OBG7Zu6/Y7w+oh5vJJH83ChAoCYnib/TPQJRwsEnDWi
         phqPr9n2RvTifVR+D/q/ghfxYgVrXrbogozVBfZnpHhOAwLjBRmZ8g6nsHkqp3BKh/PZ
         72wFhTpx5wNiGaZ7PtkYHYxPJ8XVErnTcfs406kLXOxdwuAKZlQ0xWg01t/aDiAyiRpG
         v5zbH047vjiFVwzbo6LglHmTiM7EmGne5J6FulqwyjTexgtamAD0SFQ8Wzmi7+4z6lco
         G/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738365442; x=1738970242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0AvaeYEwbl4eYOtBZm1BZYUzls9/jU76Z0u4jhcL2E=;
        b=cp+6QLs4fIGgzVL+kTM6h8NXGKVcn7kFSmC15hzoc5K0mhFS0XIwzYe/sOYZskPe8q
         YlLahS2OusEP8Sn6kNSPZdbN25fmDD+p8WiRx88ZCOxTCgazLVimA+tTQviD5XomxWVT
         o6WW4OXLefunigb2KVuSktvXPn1kwT9n/AafiDLeCErXuZ9PvwHOfSIB27ShU2d9qPSy
         lJ6rfcXKxIQKP6XkTPQSUBumtg32wF+63Ztn8xlFgADODeaIgbGhgvzbZ/jbGY9dbwl9
         3Y2J6BVgq/umsCRV0H1QzRQdKVuKkyiWcDrOtKt1MZt6No1POSDo/eViT5aU+oPVZceS
         /zEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIwZyolUhFgpZ65OkDbv5NmJGYR7c8LTSKkwnFaFxJvXUWmKHkTd5CPiuIP4XmNnjs2v6OP3A1vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoOHSJAOcrC3X6nahT+uTsWZ1fGMyjZdLn25+YmogVHEbRulwD
	p0LojgpUJRfGf9lFqVSenoJ+kTm+KhTjGhdimmlzVZkSa3GLmhGo
X-Gm-Gg: ASbGncshB3gJlyANPNBwexc81AdsOOyb0mOsO4RwutKtIYMnWjT1P/WnFgLxsGSlv/M
	VM8SFv9Wj2gKaQsacTmsR5hmRaW2k9+eKqTVsh7BXL90q6Mj3LN6pwfJwJu+5Cqqm9kEVTLQyTL
	OVSzJjncV31PveFpW/RUdnOw0EwwV5BUQwCQFvRjFzR53ss6V2eFtzYLtwhw37raJniz8q5HkrI
	E4XKkpTYEva8If19o5U7qybdWrDy64L0wOOdwaGiYEVG4baiumEciJojV15AnTDffcoc+56GnA+
	Ofg23QuOYLSD02X2wAUIWD/dKdGtWX4i9+0=
X-Google-Smtp-Source: AGHT+IFbQpcZQbXtAxI1mzIXIjxIHwluHgvFFoYQrutWhvWWVUgAGBuyeA2KduyyPKouqn34IVV5qg==
X-Received: by 2002:a05:6808:228e:b0:3e6:5792:2fb1 with SMTP id 5614622812f47-3f323a23307mr9610002b6e.10.1738365442481;
        Fri, 31 Jan 2025 15:17:22 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:d061:e6e5:c6da:b514])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365bf31sm1099128b6e.34.2025.01.31.15.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 15:17:22 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/5] dt-bindings: power: supply: axp20x-battery: Add x-powers,no-thermistor
Date: Fri, 31 Jan 2025 17:14:52 -0600
Message-ID: <20250131231455.153447-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250131231455.153447-1-macroalpha82@gmail.com>
References: <20250131231455.153447-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the vendor specific boolean property of x-powers,no-thermistor.
This property optionally describes hardware where no thermistor is
present on the battery and is specific to the AXP717. In rare
circumstances this value can be set incorrectly in the efuse of the
PMIC, and if it is not hard-coded the device will fail to charge.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../x-powers,axp20x-battery-power-supply.yaml | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index 5ccd375eb294..e0f134a13f7e 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -14,9 +14,6 @@ maintainers:
   - Chen-Yu Tsai <wens@csie.org>
   - Sebastian Reichel <sre@kernel.org>
 
-allOf:
-  - $ref: power-supply.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -35,7 +32,26 @@ properties:
       this gauge.
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  x-powers,no-thermistor:
+    type: boolean
+    description: Indicates that no thermistor is connected to the TS pin
+
 required:
   - compatible
 
+allOf:
+  - $ref: power-supply.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - x-powers,axp717-battery-power-supply
+    then:
+      properties:
+        x-powers,no-thermistor: true
+    else:
+      properties:
+        x-powers,no-thermistor: false
+
 additionalProperties: false
-- 
2.43.0


