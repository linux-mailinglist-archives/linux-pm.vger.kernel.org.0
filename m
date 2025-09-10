Return-Path: <linux-pm+bounces-34388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 137E1B51D79
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 18:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7040E1B28005
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706313376A3;
	Wed, 10 Sep 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NyWFEwzt"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98268335BCC;
	Wed, 10 Sep 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521359; cv=none; b=cE+CoubnNaxXee4Q0x82fB9zV+NEm1sstIv8N5IjXFFlwQV9MHuyGgHeYY5aOE/GUSQC/lxtpxVJe6qlWyvbHWpn+AEWVbxWrChzz3gL/yWnI1hc4/3VtvdL1TmpS/GR7vJBCVU+rkbSZdcy8Q7EA+vS5X29T+TeDujTMX4pzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521359; c=relaxed/simple;
	bh=scNnRW/xaf/hHxWjoSyQk47lXv/bg4g6PJeBtBDImSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3Zi1A70RelZjz5LRH37AkYlC3LCG1DNQHLjNUSFc2j7j9BU7xzzG2y8o2G6HlHAcImyU5fTXB/gJEOVk1WdqoCAwq2k3zhwOgQAmY4pHxIfuTf88mIO4T2BCwe/rU3M0XmBqoy8DD4w6QZ2IAEx2yr2pmuPd4vqTlMLut9rhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NyWFEwzt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757521357; x=1789057357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=scNnRW/xaf/hHxWjoSyQk47lXv/bg4g6PJeBtBDImSg=;
  b=NyWFEwztc0pffGYRUZCeWZHga6AYxtWkY+sidc9Pe5air/a2Diaonkre
   SgdNrAKUN7C85//78ED4N5KJcwQpWfmm3/UGjrHl06fRUgIG8Nu3aY7IL
   s0DotAV/14ax4dOVOiPDTVzb0vnx7OzHNqviL6Ivus0ww29P2qj2tESDg
   E8GvsUcigeHQu+51FKRjHIiT7E+kalsHbfKxE6doEogwsLTisuw7OIGZG
   3u4A7HDnePUNdA2FMOYYKMQZPw/hqMxAJvARS416xvM4DWDBuWIQZIoH0
   yxjp4SziKgEp+YnyyPv4U/01UKfKV8v8sRz282GPALJQMsuOpT85oPJ/C
   g==;
X-CSE-ConnectionGUID: yOp9HMF6QSeW0ZytE26RNg==
X-CSE-MsgGUID: iiaFCm9vSaC9R8K+buWEdQ==
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="46875548"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2025 09:22:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 10 Sep 2025 09:22:10 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 10 Sep 2025 09:22:10 -0700
From: <Ryan.Wanner@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>
Subject: [PATCH 1/4] dt-bindings: power: reset: atmel,sama5d2-shdwc: add lpm binding
Date: Wed, 10 Sep 2025 09:20:36 -0700
Message-ID: <71c7d25f64612ca9571aa544be8f2651be8fe33e.1757519351.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757519351.git.Ryan.Wanner@microchip.com>
References: <cover.1757519351.git.Ryan.Wanner@microchip.com>
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
the SHDWC's LPM pin is connected.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
[ryan.wanner@microchip.com: Add sam9x7-shdwc SoC to properties check]
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../power/reset/atmel,sama5d2-shdwc.yaml         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
index 9c34249b2d6d..b1a8ccd0873d 100644
--- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
+++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
@@ -56,6 +56,10 @@ properties:
     description: enable real-time timer wake-up
     type: boolean
 
+  microchip,lpm-connection:
+    description: list of phandles to devices which are connected to SHDWC's LPM pin
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 patternProperties:
   "^input@[0-15]$":
     description:
@@ -96,6 +100,18 @@ allOf:
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


