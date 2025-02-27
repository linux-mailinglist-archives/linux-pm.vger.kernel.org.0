Return-Path: <linux-pm+bounces-23095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467DEA483B0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA2A3B82BA
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416601CEAC8;
	Thu, 27 Feb 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p4t9CrBj"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1C1B424D;
	Thu, 27 Feb 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671586; cv=none; b=RKiw683ShUfuOJqB4Z+zWg5bw4ZPOm5Z2MaUBXEfUcMJLDrDI0TOfVN/rSUJCBZn8WPaXnSByBnvDHeqWc4coSUqKQOVFwClw4sJa0hkNTLXeIuTzVJjep9jyx1/0PVA9dQpc/oswxh3FtaEnfD9qbnh7h1wEluW4+yL9kReunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671586; c=relaxed/simple;
	bh=hRdyyYzhcP4NUii0TNQFW8OotTcsthHzkmqSXvcB7NY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IW60we9dyoG59Y1CCzVcQoloqeItrWuD4L9kt4WWh3Tzdn1giLS1R7wtoFxx/o5QZ9UXWse69V5ObP/M2136dUVaj49izre936HAgYwu6Wysn0vOXW399D6B5dfQDx4Q6grJgiCq9hpZo6067aJenhWhOvuwo4biWs7YEOl7Tn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p4t9CrBj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671584; x=1772207584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hRdyyYzhcP4NUii0TNQFW8OotTcsthHzkmqSXvcB7NY=;
  b=p4t9CrBjQMCTtc3rBgbKcIFCOibXNoACsOwmR2Jm6mbBABX8esKq+qN4
   E64NogRwT+0cODS7gqFqISVKFEwpuUkF8JjMRZNoRQeKZfiuFEwqcPnIk
   gnJsxzFzBn1JcMlwys8GPx1I0TXLZNuBfl/6ddMKF74NBkIVZoqCbeaCC
   cekY00f0NdEDtlCWxpsDqhMCIgI2R8fKgE0ppmb0U5zkrAciiuglH6gyD
   gaaD2eoZWSSBjf4yzyR1sg90qEcOyL1xoh+2JkDQhGmMWMo6hrKFoWhsF
   UzQFuUweCl2S3wxi8vuLYuLtbqL+ZPI1ShnpFIeDDKCqDWu3+T336zdSo
   A==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: TJdTlsGTRqqYfLqHWjYU1Q==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638166"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:45 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:45 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 06/21] dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
Date: Thu, 27 Feb 2025 08:51:53 -0700
Message-ID: <27c5b177a41b89c5c983e7e292eb4b321a258991.1740671156.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740671156.git.Ryan.Wanner@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add SAMA7D65 RTC compatible to DT bindings documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
index c8bb2eef442d..7c5b13caa40b 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
@@ -23,7 +23,9 @@ properties:
           - microchip,sam9x60-rtc
           - microchip,sama7g5-rtc
       - items:
-          - const: microchip,sam9x7-rtc
+          - enum:
+              - microchip,sam9x7-rtc
+              - microchip,sama7d65-rtc
           - const: microchip,sam9x60-rtc
 
   reg:
-- 
2.43.0


