Return-Path: <linux-pm+bounces-34760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8949FB5A1A3
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 21:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C680528328
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362C2E0919;
	Tue, 16 Sep 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hdsKg0tz"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6CD27E7DA;
	Tue, 16 Sep 2025 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052251; cv=none; b=b/B75pJlfsJy+Idvn+/4mKT0Jy7I85UApjQ20hn9T2/6IJZXYStKorNXpsIAA6tNDn/PPf2I1lk/6GicmpANRi/1mVhW/FaoID5zaO9ROwzONeVw4m7oaNGa9N0TIidB+9XqUf4PCPrPWeTUZ/jVmqbynxt78mbeHyupUK5O8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052251; c=relaxed/simple;
	bh=WYEakKaGIgOHZEwp+8RyHz2DG4XYM1t05a+iyML1wAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJ2+IFra9Pu/6TrcpjplfhBBjOoozEWGNOAw1Op3p73hj42u/xeR4Dxwe0dSDyVa1TKYMxyg8vwEjzQWR/Hbrtg/PIrHSpth+RF1IxOUoWM5sdejTn2YMshv4ruWN+hN+8tfbF3Sy4c2RwGIymTUWYhKg+zFvqNknmioTOgubc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hdsKg0tz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758052249; x=1789588249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WYEakKaGIgOHZEwp+8RyHz2DG4XYM1t05a+iyML1wAk=;
  b=hdsKg0tzOJrBKc4m+gI2ZY3DKJWtYVe/oBQ7RgTpXVt3hWem8Z6QD3Ql
   CZ7IH8rkaqwgMgJPreQO2mf0OGLjBuszOtp+gVUxdC3ioQyCDnpfxzkFu
   JzHNfAvgGhmxvR7NfwUKJySgazRVU7TPhFlN2o3EU6MEkPcgxkLC0K/uZ
   fUDQfn382NU4k+af03nebySX57Xq5KY9AvgLX/Ax3S2+VhJjw09ZBaWS/
   lu1XnLbl5Sjq/S8ip+Dr59RFPKKVx9c32Sf7visEo7/Ly9uVgPa4xO7eW
   jYi28nLfP21a5mTLLCHwAijYE/PD4Tn5cAKN+n7kIesZhbKNTDp7kJKEB
   w==;
X-CSE-ConnectionGUID: OpVEzCAsSoaW6AVT1s3wKQ==
X-CSE-MsgGUID: +kdF4wBhR8+O8zYogwmtAg==
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="47129845"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2025 12:50:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Sep 2025 12:50:17 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 16 Sep 2025 12:50:17 -0700
From: <Ryan.Wanner@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: power: reset: atmel,sama5d2-shdwc: add lpm binding
Date: Tue, 16 Sep 2025 12:50:30 -0700
Message-ID: <d8fc40a97008cb0b4001684b3c9e1cc4bf3fb706.1758051358.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758051358.git.Ryan.Wanner@microchip.com>
References: <cover.1758051358.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Varshini Rajendran <varshini.rajendran@microchip.com>

Add microchip,lpm-connection binding which allows to specify the devices
the SHDWC's Low Power Mode pin is connected to.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
[ryan.wanner@microchip.com: Add sam9x7-shdwc SoC to properties check]
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../power/reset/atmel,sama5d2-shdwc.yaml      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
index 9c34249b2d6d..668b541eb44c 100644
--- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
+++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
@@ -56,6 +56,13 @@ properties:
     description: enable real-time timer wake-up
     type: boolean
 
+  microchip,lpm-connection:
+    description:
+      List of phandles to devices which are connected to SHDWC's Low Power Mode Pin.
+      The LPM pin is used to idicate to an external power supply or device to enter
+      or exit a special powering state.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
 patternProperties:
   "^input@[0-15]$":
     description:
@@ -96,6 +103,18 @@ allOf:
       properties:
         atmel,wakeup-rtt-timer: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - atmel,sama5d2-shdwc
+              - microchip,sam9x60-shdwc
+              - microchip,sam9x7-shdwc
+    then:
+      properties:
+        microchip,lpm-connection: false
+
 additionalProperties: false
 
 examples:
-- 
2.43.0


