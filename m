Return-Path: <linux-pm+bounces-24518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBE6A71AC3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810267A6E71
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF831F55FA;
	Wed, 26 Mar 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cIlCiZi0"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803DE1F4716;
	Wed, 26 Mar 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003401; cv=none; b=W8Oac5Jnd5mx1bIEP+OPL54mnxn39YluEYCyyOYtemfvCifYxGHoERoNFgUsAcQlOEZ88il5nMxP/ogKjN7z/YRJ7u/BcIj9ptdpYy3ScHJ9xXqnx4MwY4eW2/S8CiXbYsm8V+4RSaVS+Ph+z5ez7IiC0VpcQ5wJsk6cqffK/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003401; c=relaxed/simple;
	bh=lRUUsu68yjl48Dfc+/ph2mpUFrsqqJQ0TwHXN3jGP6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmPV4hXapFi0wBo3bpvvNg2vbEhMW5kUiSKQr5WxzFWI8xaCv2qipFuetZKqq49w0Ks2+/qdF+pDQLgR3uBxDCA/Cvs5yjNl0WVbqZKeXD03/ek1eBFUWPQI8972MwXUzvZdazTTYsWT5Tv2rvwA1VF+yOPkAzDebEt17BuRE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cIlCiZi0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743003399; x=1774539399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lRUUsu68yjl48Dfc+/ph2mpUFrsqqJQ0TwHXN3jGP6Y=;
  b=cIlCiZi00Dgx/BykbB/MRVjod+CWCbsaue0EL8yZjHpherq9ogsGWdB3
   gZS9CQzi3dzDmjfc0F9yKopkHIIObyyWip0LYzkxbjLSHKgXGdN8xuGEo
   lgYpfBEyUCWKXaM/2ZIdHgYdlwfmsFWv7YthG3/Jp7AqrTufDW1SVWDx7
   3MxuYhb9hjJVVC/8JBtTN6WsL03iKndDcLX2k74Q35FZg25R5+lNkrkWk
   K8gESey2r95sq/nglPywif4PzmkmGOmeEyNj1MQeWsfc5ZjS6Uj9zeUqh
   I7v1uB3DMpoZMCgOxfh9rLxdRSaxek4pMcuunbESVuCbMfml6/bRfGlXw
   g==;
X-CSE-ConnectionGUID: NRxSiTFnT3ucBnaYj7CaZg==
X-CSE-MsgGUID: TYQz+qm7RzimNv1S2hPivA==
X-IronPort-AV: E=Sophos;i="6.14,278,1736838000"; 
   d="scan'208";a="44096101"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 08:36:30 -0700
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
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v4 04/11] dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
Date: Wed, 26 Mar 2025 08:35:37 -0700
Message-ID: <a274485331628be0bcf382b1ba489d4555fa49c8.1742936082.git.Ryan.Wanner@microchip.com>
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

Add SAMA7D65 RTC compatible to DT bindings documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


