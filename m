Return-Path: <linux-pm+bounces-39967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4C7CDFF96
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 17:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0A07300BED9
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F42314B73;
	Sat, 27 Dec 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="RxzYg0RY";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="PsvsXm9u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2308D1DA55;
	Sat, 27 Dec 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766854355; cv=pass; b=R5tvHPuMoo6QFRCrnsX4BplkY6NJPNqcmdZ0pAKlj7qXsMvps3ScXsWzg4MUb+FUiDdLQcXKKCRB//E3ejsfox43rtCbDlia+HNDwU6RhDl2unPfh3NQM0pCr6Wvg3RdWw4kcDN0WOEzffpW313+AOysPDGNDoXKqkef8OovX4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766854355; c=relaxed/simple;
	bh=l4f+b8rxW1OoheD1H4u/RGOHJuhhcel4qeyOFe/gIOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=io3kc+sScr/AFEUWmlv61/WCQ8+VMNcCG0hPATdPIJKDQyI5I/KuimNUNlJjIsl7wd4L4CbBXzwTqiQIf6WIvmQFkjwPqoTUw8IKkS4SHf1X3cjh+j4u5WvRK1524c06t4Dx7AavtQRFgL2i2FCAZMPeQDpboQDIa9xgh8hCPoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=RxzYg0RY; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=PsvsXm9u; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1766852905; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AmaG8lufEcHfcRdXndOvpSwo7MhKysgjdAStJveVoxKeZHG0W7HwuHvf8KgmiFyILs
    f4MFOOWItUTF1aBg3v8hAkOZ7W7viPEySAM9FzR5vU3PBWs+UWc38HcwQi6Jn+EjT1dK
    dssFYXPDGPEkSulcfMbOziQ/VqKr0c2rU/XIUeFrqGTAskDVeuN0YNx1xnfsmrpsX7Yg
    2//xicsmjjSC5bELzMvvvhZE4TvpKwDEckjpVWDhGXtbG3dxCrYYXm+B5JGNGF7J2LRV
    b5bJcBB45Rqn2jc4n+u36tXTm/rFihGHoG42GYMvKCMkkqsbA2sotSAdMKdirmLjEhG1
    g9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766852905;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=8LxlG+pLsH21v5FwAitBDXQijxuqWknyeGn1K+XbPv0=;
    b=hHrDyJ5nsX9sSX+EtcxgRUSOvBhe91RTHOiJ5fXNnG32Nnv6DGAyiuw8LYMPpsq9qH
    M3g98vTojfNlZ/s8pRItFXk3Tj69ErX07XmyVgx3TZCqS8bqGBx7OpjfB8kkQ/wPwpfl
    KRs/PM/TWFHtAEJqIh5I57NEDx4ywI1lcDrrOWNwYQeclZfhwylxBVtoqvMviBS47CDR
    3uNhokTSddYMDnVWz3wbif94yD2G9AZ64NDUy9ZqWBjeWUNZhrj3bxUS+iouZZJdB4zk
    JYOns2yOJHIRGaECtStz+SO3DR54l//jTnqJmEQHZl1OXBBo483K24HM5ISkXdafnQku
    yFnQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766852905;
    s=strato-dkim-0002; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=8LxlG+pLsH21v5FwAitBDXQijxuqWknyeGn1K+XbPv0=;
    b=RxzYg0RYJmuu63TovFOOieC4G1i5NRskuUlFyiDzy6mZ3QDhyAj07MTtOQEWYRc2JY
    vPygyJeYuHeRSpdq8tOzHuX0eZH+zmA33V8ABFljYVrrUUE6uau1qf6Z0wcXUtKXyBQt
    4qkKHZ1YiatCnuQ1LpYX5btPgKWGa5ZdMcMFp680xm1PC87vAPN8nH9cCedZoCWDMIH7
    j67f4zIBQwOopwLTtMczaaDfvsUhYwDPDJyoWe8VbCvNvM7MEN4A+2Rp213qLFsWmYjH
    2r2hqLvp1mkuMdzW/se+RrhmtyO/1YjFc3hGG5uVSYCLVWisR8gzOWwQLQmC3NnOT25B
    xu6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766852905;
    s=strato-dkim-0003; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=8LxlG+pLsH21v5FwAitBDXQijxuqWknyeGn1K+XbPv0=;
    b=PsvsXm9uKtmHbLziW9jJfgJDDricGlFLTO6P40ztCnPQLZzIRH0Hmtpm0TOdKm0+av
    KUBMUq+R2GoEfwRGcWCA==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPTeoCaRth8YQvpoIkZXd2bnfIrOV7Mbk="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 54.1.0 DYNA|AUTH)
    with ESMTPSA id z0d4ec1BRGSOtuJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 27 Dec 2025 17:28:24 +0100 (CET)
From: Josua Mayer <josua.mayer@jm0.eu>
Date: Sat, 27 Dec 2025 17:28:14 +0100
Subject: [PATCH 2/3] dt-bindings: mfd: netronix,ntxec: add reference to
 power-supply
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-kobo-aura-battery-v1-2-328a90ef5122@jm0.eu>
References: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
In-Reply-To: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua.mayer@jm0.eu>, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3

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

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
index 37fbb953ea12e..6599dcf0eceb0 100644
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
2.51.0


