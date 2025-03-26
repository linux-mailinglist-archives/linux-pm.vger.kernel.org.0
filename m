Return-Path: <linux-pm+bounces-24517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62E0A71A8B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8770F16516B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E291F5402;
	Wed, 26 Mar 2025 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nECR+Xd5"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99B1F4289;
	Wed, 26 Mar 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003400; cv=none; b=hU5333CHuSEOsKdjm36q7mZ/Bxr5+dThnhFVr4yeFnAPCjygMDnWVVp+4GoNJxwjpEdoK8OnJHfBavxv5PYKS4H2cmazfjOu5S94GtaMYbydXaNLinfE66X+MqvChVztTIMy/CnO8D69FfKcAv+Bd/aN5/6ENgIAlmBLweyYDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003400; c=relaxed/simple;
	bh=QtZL9N8JnzdiSxrQgqOdrgyJiMS1ffqau28eqfXsCas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFtUrOhBW1/78u/CDsOt/ZlRpkm7M+C3fgbg1WNn8WwQ2dMiuehOxaaV635TJfB6movf8ZgfKAH95aQ083Pxys+oixKqAMkNzGDVxmwDBXze3nVL9qrEQUIE9tR4M7fD7SVyDyeEc+KNZ2Vy17G+5zziEzLiqke7GNYMEPxjfUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nECR+Xd5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743003399; x=1774539399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QtZL9N8JnzdiSxrQgqOdrgyJiMS1ffqau28eqfXsCas=;
  b=nECR+Xd5Izv8mXvYzWXoDcwgQJ+OEHMa20SYCyhgTVl09ttbXr4b/ZmU
   Mm5ZTtnefY81Di3aw9zgChsITB6VnENOw3MAT/WlYeE5QJojP6QODQPJi
   XEdlhYvXpbiPAMyhoM//ccGB34LE9Lub+qbYt8+Bbp0t8I9IRVCkU8OpM
   gcAN1obNIVxn1M7Au0SEb7vPjhgimpWRaXgn39KhyV8+VeT7B8jRoY4VJ
   JvJr+eyuEJDhnc9fK86uy4HtYK+0H1F1WmWRld/IPqqGoEeZ8JLQAXxDg
   k+F7goQhwuSXdg+1mchxWToCP6bLQuLenH46xa0j+b7t5Fe58+aFX++bx
   A==;
X-CSE-ConnectionGUID: NRxSiTFnT3ucBnaYj7CaZg==
X-CSE-MsgGUID: /LP9pAixTZGnJFSg9ej2iQ==
X-IronPort-AV: E=Sophos;i="6.14,278,1736838000"; 
   d="scan'208";a="44096100"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 08:36:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 08:35:51 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 08:35:51 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 03/11] dt-bindings: reset: atmel,at91sam9260-reset: add microchip,sama7d65-rstc
Date: Wed, 26 Mar 2025 08:35:36 -0700
Message-ID: <b2bf907cebc2e251f6d8bebade864372e3dbc1eb.1742936082.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742936082.git.Ryan.Wanner@microchip.com>
References: <cover.1742936082.git.Ryan.Wanner@microchip.com>
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


