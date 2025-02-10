Return-Path: <linux-pm+bounces-21741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173BA2FBA5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC53E18850D8
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB87250C0D;
	Mon, 10 Feb 2025 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uFROxsAG"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8424FBF8;
	Mon, 10 Feb 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222057; cv=none; b=nBbBzICsrO8QsIlUgtdeZ3nC3JUiTa0I9QIUSCxfGabUmgvuyXNrfGBfheIpp/7f7UDf/BygLpYsmoGnBFzmzUbn6B1SsiKe1gz8XgC1QcZbV19FIN2O1SFHCctA1BdpicoT6KinfKqTkE+RPx7XEWwJ519/bntYAWwjB5js3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222057; c=relaxed/simple;
	bh=knmHj9Bcj4Yvp/EQxNnRvlMYu2rnMigY+aERKel7pvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPs1iE6fbgwjvIS9VXZ5/5OZVmE9PYUVqTOwpir1QHy7UGUi3wWt9OTB6ubJ5fbd/QwISUop8bK/u/7ibMfbggNR65PKbQjqGn3VRN6nOoZjxXQjT6ZolSWzP3igm02tQbzWoc9lEYLtUEevvRW2MkE+Hb8TNhwUYshVQvuHlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uFROxsAG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739222055; x=1770758055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=knmHj9Bcj4Yvp/EQxNnRvlMYu2rnMigY+aERKel7pvk=;
  b=uFROxsAGArMDWitzbLFQGL6UD4NFrMkR05cAzmInGjwrr8YwjECVmeDw
   Atlk5QpK7g5sm6VPt9bqN5a7c19R97gkCJKZwLMd/qhuOKCtCNMjj1RyR
   eiiJcLgw89cpfmiRNTvnNP6U2ZMOs4eu1zN/w4pIClCtyCiAAqmCxo37U
   otjeVVb4vVp/PkVklx0Oo+39QPSx5O7T2TJ5yl6Pf5uHyCk9qOEWRaGMV
   09Ld85ephjV1YWGq8TcJ6XwVSSdsJliCnemY7+Ocj8D3dvH0XM3GvsWEA
   udlxxkX3gyKghZLWYfmiDVBvV1lnzDwU61BSReXGPnrEfW+E7FC/mEgeK
   Q==;
X-CSE-ConnectionGUID: AYqW9AG9RbOJ2Xf8Pt97Yw==
X-CSE-MsgGUID: bXPPyR86SfKUyhxlHyNVLg==
X-IronPort-AV: E=Sophos;i="6.13,275,1732604400"; 
   d="scan'208";a="205027974"
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
Subject: [PATCH v2 06/15] dt-bindings: rtc: at91rm9200: add microchip,sama7d65-rtc
Date: Mon, 10 Feb 2025 14:13:06 -0700
Message-ID: <a0338f3d05ed43eeaf2121dd22a9f0dbf25f2fc0.1739221064.git.Ryan.Wanner@microchip.com>
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

Add SAMA7D65 RTC compatible to DT bindings documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
index c8bb2eef442dd..0c878331170b4 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
@@ -25,6 +25,9 @@ properties:
       - items:
           - const: microchip,sam9x7-rtc
           - const: microchip,sam9x60-rtc
+      - items:
+          - const: microchip,sama7d65-rtc
+          - const: microchip,sam9x60-rtc
 
   reg:
     maxItems: 1
-- 
2.43.0


