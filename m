Return-Path: <linux-pm+bounces-21145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96559A23326
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21004160D08
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE191F2C34;
	Thu, 30 Jan 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UeHMWG0/"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEA21F1521;
	Thu, 30 Jan 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258587; cv=none; b=dm0VMeJOyvpxHqjWz1s3fd/lqt4W0Ls7FUY8j2rKoV2p2e8jk7BhiAwyIEm+ou1Ro2NwIjKcdlbq8G2Cln3qXE8wyL9G+Vl0g/cbcH6C+H0Ak6sl//WslxRbdFXs0EsVIIfXF5C15VLRbM71bZHT521FhlSbO55PxfAI/3pIpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258587; c=relaxed/simple;
	bh=+iUScvpZ7YkCRssh6lzoVEeH/EksnEiE7G6D1yHSHRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jje/x62U+lI57f5CiVaYn4aNLEroRXbA6Y+IlMclwy6vktNxShIuYxTAUatM2rqW+aluzuxZCUk8nL2Lid8eSpxJ+BNPGxpSzCH/Y/ogach4z2qDdNgXNqSwbx6WAqr6T/hn0E9sEI+3vLMV8G0krrhAhmNDVucYZsetVyWettY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UeHMWG0/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258584; x=1769794584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iUScvpZ7YkCRssh6lzoVEeH/EksnEiE7G6D1yHSHRI=;
  b=UeHMWG0/Iv8X5j5x3nxl7CLy/szeNBU58vezSTYe0qtIJRPXUUUPu4wo
   Yk/euYM4F5qXioYM+oiSGeEVhlObGdAqcrN1iglP6uSKpaMQBr4a14mJr
   xcvACgmOYeb17wXta5MbLadvq/a7diwNIOWs1+rmod7tCylgxx+gaqgK7
   scEms6Y+0JVOmdm9BJQeA+ZH4dKeRgkGDZtoANSJMd9QIe0OGCRKLWwdH
   BPwGlwF/pS/YknQw4uI8J7mLRfDTvEbK7QkEttPu7Xloy3k4/QIvKp8RE
   8xM8C1ZRHyZeQfs8hdLQODNTO1428x5V2zggz/9ttdSHDPcFpffQ9gq+0
   Q==;
X-CSE-ConnectionGUID: Qux6TnwtQkq+U6Cg6JCAlA==
X-CSE-MsgGUID: 3YdoWKTPTdWqkkI7huaAyw==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="204623011"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:36:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Jan 2025 10:35:40 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 30 Jan 2025 10:35:40 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>, <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 05/16] dt-bindings: reset: atmel,at91sam9260-reset: add microchip,sama7d65-rstc
Date: Thu, 30 Jan 2025 10:33:45 -0700
Message-ID: <2350540fd22b181875d3cce272fba87fff924670.1738257860.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738257860.git.Ryan.Wanner@microchip.com>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
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
sama7g54-rstc is compatible with the sama7g5-rstc.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/reset/atmel,at91sam9260-reset.yaml   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
index 98465d26949ee..a1c21c3880f9d 100644
--- a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
@@ -23,6 +23,11 @@ properties:
               - atmel,sama5d3-rstc
               - microchip,sam9x60-rstc
               - microchip,sama7g5-rstc
+
+      - items:
+          - const: microchip,sama7d65-rstc
+          - const: microchip,sama7g5-rstc
+
       - items:
           - const: atmel,sama5d3-rstc
           - const: atmel,at91sam9g45-rstc
-- 
2.43.0


