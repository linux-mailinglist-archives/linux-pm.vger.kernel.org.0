Return-Path: <linux-pm+bounces-21742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D70A2FBAB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5705165988
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE11024C675;
	Mon, 10 Feb 2025 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="i5+O+11F"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B892505C5;
	Mon, 10 Feb 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222057; cv=none; b=GaT1GPRl78rc9cXcz9ygEYvgSUx1xRUvxop3NK80P4nveii/vqHZmJc7aJI6XEkRBOGpyzy2LO47TaOt39I9pQSOAvk+jd8O9NQIlLdLbmvm+YBD34vJzKDZHBmheUueKMLWkYgV8brp/aHfyLMDvEpKY7TdSnuLmsZvftqhxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222057; c=relaxed/simple;
	bh=vVcwZO42JPNUOdcIsOkBSUgYQfQ7lZG5absw3HX57CE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gu/AVTPCP03ZnCU2tsGBQbcVK6HRuAtgmoezY0vJ7JkA+2EuFB5OBtNFtRQvMrHqgc7Ll0V3rYlbZZNSFq18XbypO+UZA8FFtMj1KCdC35r3ouMrRbZorw+AYsJKkoFkvvpu7SyooYFGKZ4f9/YddTTNf2tl/4+S/zt5v0cA9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=i5+O+11F; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739222056; x=1770758056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vVcwZO42JPNUOdcIsOkBSUgYQfQ7lZG5absw3HX57CE=;
  b=i5+O+11FdDiGDgz8/JLHizzQ0Uqdx0R/t0KXgCAXFwzfwz1bkGd/fPiL
   ocxjffT+pb7nNb5GI8TtTiijTshrr9zbEbiuZtSn8l40SiDeCADaIMbMq
   12qxZKxF1ogjvNuIpw0uz5vIj2CZb6cURCev8I76ME7GY+FqhsuxM1FNX
   hkDEtxc9kzXcxDZJapoo7wRidKc29xJIJ2UodqBLhuxn8mLuOidXK3n19
   H2VNPgQmp4f/mS3K+wfBJFQp3KxHJe2xFYs6qQrbNjpyssEKT2OnxQZEx
   lbk0/qOLwvN8O88KpFD4nukB1iZB1J+pHbL9PSkSHYap9Ye+eouTLNoNV
   Q==;
X-CSE-ConnectionGUID: AYqW9AG9RbOJ2Xf8Pt97Yw==
X-CSE-MsgGUID: wAxkISw7RgW1cXiYsTRZ6A==
X-IronPort-AV: E=Sophos;i="6.13,275,1732604400"; 
   d="scan'208";a="205027978"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2025 14:14:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Feb 2025 14:13:46 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 10 Feb 2025 14:13:46 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 07/15] dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
Date: Mon, 10 Feb 2025 14:13:07 -0700
Message-ID: <b437898b518910a2f94f7d827608db35e82c5828.1739221064.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739221064.git.Ryan.Wanner@microchip.com>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add SAMA7D65 RTT compatible to DT bindings documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
index a7f6c1d1a08ab..48a2e013a6b24 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
@@ -23,6 +23,9 @@ properties:
               - microchip,sam9x60-rtt
               - microchip,sam9x7-rtt
           - const: atmel,at91sam9260-rtt
+      - items:
+          - const: microchip,sama7d65-rtt
+          - const: atmel,at91sam9260-rtt
       - items:
           - const: microchip,sama7g5-rtt
           - const: microchip,sam9x60-rtt
-- 
2.43.0


