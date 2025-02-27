Return-Path: <linux-pm+bounces-23093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9463EA483AB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BC616A7CB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB11B85DF;
	Thu, 27 Feb 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X+jwBg8f"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E81B07AE;
	Thu, 27 Feb 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671584; cv=none; b=KqzDbeKJiIo0BtYu+tzqylEsSjS3uscoV5exrX9Dpl3xF5xRIh3lh67xOA9jTTbqfJNJCxpB2fqQIk2Jh/T+MH0XwyXG57D/40EnDmZfNScAhUeNMavwWZCz8TZ91k7HGOMLlmZdOKQOWf/Y5VGlOc+sz86b15SwMVPXv2C+3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671584; c=relaxed/simple;
	bh=QtZL9N8JnzdiSxrQgqOdrgyJiMS1ffqau28eqfXsCas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEm+ueWdtiRC3Vr4kzGRgpuIALc8kzS9Qglnl3faj1dG2jdynZ+dlxdNi8LePBuiRggtfIQzvo3yzY6IbNUkF6tL/fj+UYBRdpXyKX6yUe4pHi00opbqF6Zt24FDoT7S1O80pdiQxe59udq00HE1LuGGvEqrlLJphoVKdStGyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X+jwBg8f; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671583; x=1772207583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QtZL9N8JnzdiSxrQgqOdrgyJiMS1ffqau28eqfXsCas=;
  b=X+jwBg8fd5iwvIXM6iaIdlIvgPMBNk/Exum1WmEEn/BGj2C7MGIhe+WI
   hs+6C5XvN7RHYTco2LDqMdVEZ1J0CO41zEntkMgkwASqljx2R/1JJQnj5
   O+8avrHNbK1xnAfT+QIthLki/vw5PgKhwoPfRiut+5XtCn/SNgLL0BfHX
   oiikZftwYkM9ZtQPZT4Brm/eHRq3yhwLHkLxRlsSPSymJ9NawSWJfOi3y
   r9aDQe0dQji0vr3XEMwWdiPP40L8/4/c+jBed4tiE7Gb7H+hWaxgImqTL
   GWqtGE2iceODCG0jeSg/PK64PI0c4k6AnBLKxkEtjL+8/ee+/VDdqOE4W
   w==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: dfcixra1Qo+oLexBdYUyKg==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638165"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:44 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:44 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 05/21] dt-bindings: reset: atmel,at91sam9260-reset: add microchip,sama7d65-rstc
Date: Thu, 27 Feb 2025 08:51:52 -0700
Message-ID: <410a509696c32c683c98cab31247e68fe6dbb414.1740671156.git.Ryan.Wanner@microchip.com>
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

Add SAMA7D65 RSTC compatible to DT bindings documentation. The
sama7d65-rstc is compatible with the sama7g5-rstc.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/reset/atmel,at91sam9260-reset.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
index 98465d26949e..a2ab7f8a11f8 100644
--- a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
@@ -23,6 +23,9 @@ properties:
               - atmel,sama5d3-rstc
               - microchip,sam9x60-rstc
               - microchip,sama7g5-rstc
+      - items:
+          - const: microchip,sama7d65-rstc
+          - const: microchip,sama7g5-rstc
       - items:
           - const: atmel,sama5d3-rstc
           - const: atmel,at91sam9g45-rstc
-- 
2.43.0


