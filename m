Return-Path: <linux-pm+bounces-40136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE784CEF20B
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 19:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD4D93024E4B
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089F72FF16F;
	Fri,  2 Jan 2026 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="LsuKRvRS";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="psG28K4t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70227F015;
	Fri,  2 Jan 2026 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376859; cv=pass; b=FrvQAYLWOcwE8HGlh7sjPNwIWqxRmKE7VtDdCvsjrFqupV+zDgC71orWRkLpp4+8a5vqGtq/fsXaojejYWJuj1Y/wnuI8C9lORvO2CTEwOhuMWnJGhg/YAIeol1OG5CltFXk9BxXJn5/22rZLzOSquNCSZveW0W0PUh+3H1r0tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376859; c=relaxed/simple;
	bh=szy0BQhDjcywmXfulHjMRZvP35HfFdHm9ZR3Giy5mxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jI/XY1y8aZL1++HB0Otj8L3EQ/doyG0N5HdSSOiwrjvJ/+w0ajThg1hMIAaCg+kgL+99L82aSkt/TzYkUxv1qxxx3EqGRxitfhZqTidKpisvMSNM450PknD56TadaAqW/z3+gwpaiNA/AI7aHfZcvFXFtHwBZRHHvyTYMNrsfps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=LsuKRvRS; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=psG28K4t; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1767376837; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fjuv9XzpkJV0m+YIpx2Od1BAjRZ1jGGTgER3a6WHcVd3FcoBn1KGCeiOiBgwnQ7frs
    7sH0JvM57xVJXgwp+h1ShpdZBmhvzg+kckSwlfufuVk+cclsItIZ1zEjsU9ZhEh3/Imz
    dbqb3z3Ju6XDs8WnlxHxqj1RjypBq9qu88uD0HL7YpJONChiVWqO52UICYYthBgWlB97
    LsjKdupRoj6Hk8HZY5xTxIARqspM9ZFzESh+TN5PXZEw7Zvh9l3SQYU94a7Z7CYWkDDJ
    P1SqKWDj8aHF3xeiiNrzL/QMGzgTnnbd3WOo4hUWiKgNFBflm9LAVerXIolid0CUHa+w
    TsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767376837;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=IMRntDBW+5EWU7Eup6lBpFcTSPp+X8qdra3fy4r81Tc=;
    b=tQ7FIJa99YLaLjlHScq8399HxmmQGVX6ZZ6V5bK9lkmxfTb8VIbxpc2+lSisrFE/aG
    j2vIHdaP10ZkfcIF19vQNluTMGbyp6QpUH2mbtgCpPD185XMCC3cG9USQ60kP2f6R9YA
    1TH1wx7qORiaXeJKOLpeWHaSyITnWmFXCkloou0oKNIYvxWMvThmsyAA+J5bE2a0eVNR
    MG/HakzLNwNFbxeMaBy/yHtPKkSIsLAiqhSiCyfR8WVao6A/jhvsk5B1Ce6mAmi7o422
    wFQ/YSDKYEBD836Lb7kQBDikMF/MIO/nyje2wvnCSXtrDbKRo5cRWyMUgGSOKxmfX7An
    APjA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767376837;
    s=strato-dkim-0002; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=IMRntDBW+5EWU7Eup6lBpFcTSPp+X8qdra3fy4r81Tc=;
    b=LsuKRvRSLn82MwSl0jhEcMvPIK/VhOtVm6VKB1snaepBDnGSdm3GgoCfvhxJ7wx1sl
    l6gSq5EN4lfDpxguuxKGw8RsRabZBwr/Lmgmnh1MqfZhiodLYfbys7Ojg5FSgcEE2D/I
    FruktwcmVyZZOWDZVa7pAnLp5S/lOS6UhKQay6NGrsL7KfnSlFhryJKmuCzoOq19qF4+
    HA1olmwxv6W8BbUEIvo2gXqnR4kV+8e0r4SOStuIhlpOBEMEdClj28q0VEglZCmCMDS9
    WRNJsmi/nSMbMJFqgOL+lu3wUIUcVui4YB1VKyeSvRE4Z57TRCZkfM3Pg9ojq/Ke0J22
    PhJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767376837;
    s=strato-dkim-0003; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=IMRntDBW+5EWU7Eup6lBpFcTSPp+X8qdra3fy4r81Tc=;
    b=psG28K4t1TAuJEvmoOZ/tJkkjEgh/sj0GKZrC1EXdhgIKoAeR8jYEZdBxrwnLWZmDV
    T7Phw/ZtKVJO8ACS+4CQ==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPTeoCaRth8YQivJ4sfKeu9QyRDNI="
Received: from Wablet.localdomain
    by smtp.strato.de (RZmta 54.1.0 DYNA|AUTH)
    with ESMTPSA id z0d4ec202I0aEU9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 2 Jan 2026 19:00:36 +0100 (CET)
From: Josua Mayer <josua.mayer@jm0.eu>
Date: Fri, 02 Jan 2026 19:00:30 +0100
Subject: [PATCH 1/4] dt-bindings: mfd: netronix,ntxec: add reference to
 power-supply
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-kobo-aura-battery-v1-1-501f2a8fa575@jm0.eu>
References: <20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu>
In-Reply-To: <20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua.mayer@jm0.eu>
X-Mailer: b4 0.13.0

The Netronix Embedded Controller supports monitoring of battery voltage.

Voltage monitoring functionality is self-contained and requires no
supply- or battery-specific runtime configuration.

Battery design characteristics (e.g. voltage-min-design-microvolt) are
useful for users to understand the charge level and are commonly
provided by a separate battery node linked with monitored-battery
property.

Add reference to power-supply.yaml so that power-supplies and
monitored-battery properties become available.

Further drop reg property description and replace it with maxItems 1 as
is common for i2c devices with single bus address.

Finally replace additionalProperties with unevaluatedProperties to
allow properties from referenced schemas.

Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
index 37fbb953ea12..6599dcf0eceb 100644
--- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
@@ -13,13 +13,15 @@ description: |
   This EC is found in e-book readers of multiple brands (e.g. Kobo, Tolino), and
   is typically implemented as a TI MSP430 microcontroller.
 
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml
+
 properties:
   compatible:
     const: netronix,ntxec
 
   reg:
-    items:
-      - description: The I2C address of the EC
+    maxItems: 1
 
   system-power-controller:
     type: boolean
@@ -42,7 +44,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -61,5 +63,6 @@ examples:
                 interrupt-parent = <&gpio4>;
                 interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
                 #pwm-cells = <2>;
+                monitored-battery = <&battery>;
         };
     };

-- 
2.43.0


