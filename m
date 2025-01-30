Return-Path: <linux-pm+bounces-21147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D3CA23331
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CC81619CC
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D0D1F37B9;
	Thu, 30 Jan 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="L5hJ6r+O"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B281F238E;
	Thu, 30 Jan 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258588; cv=none; b=nKoSkQ/dB5MUVU04pNbSvTPZH/bOiPATJX63kDMDqnDEnhTHs8O92cLeNdfEbJ9VMgrhgeYcXaTzM9X7iUJ/40eCR6PPH79rdoUgtvqIulKcwFI8bJc0KCXKjKJjh0yQ0pzkOHc8+1jQxdZgQ5ad/Mzk2HmbMVprHUDRkNQfQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258588; c=relaxed/simple;
	bh=py/yqNx13hsIQ9lYRrDtu9qmIYc+M8dbM6qysRjVXU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmuHUIv4HBDyruWI+HcUzVOM3vxATG+K2rX19RJ7HpmZ6BeYY2QkTPGAxtYxtw/esfoYNm5Hbwjx4w9UiI1SdPS9VC9tdZXvgJQdyz3swBB/ziur5NWkx7C9Wth2jeg8rn/P71eqUrSqWjCZ+jj7iw58Bcy4V7z3kWwiEmgZYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=L5hJ6r+O; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258586; x=1769794586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=py/yqNx13hsIQ9lYRrDtu9qmIYc+M8dbM6qysRjVXU0=;
  b=L5hJ6r+OqbHfOBnaef+WWaH47YTwrI6J3SoXbt7M+zu4xClGu/fL1t7+
   0hPOeH11SmqgWffqykbethg/gJFd1/9bbD7kyCFF99JnWpLOIfC7bMFk3
   /sGgnkjmJ0pTxaBsOgPHunawmhQCMdrIhKiRoILWdiH9q57qQIr8iNp0a
   qPj0trqE5atJV1eEpLy7L88ixhjH7rGIJs9AFl7cZbi6FunREldV6DmQ2
   PGlLSMI5bOw3lW2hNU7hXDV3F0ODo9cgVgbsRuEeZ8Is5m8hmRzS+I/zc
   voiB+5JK/ia2EA8YPW0F5wFrfcGuOdjjrdfX+n6zX3Sr68FRQweyeL9vr
   w==;
X-CSE-ConnectionGUID: Qux6TnwtQkq+U6Cg6JCAlA==
X-CSE-MsgGUID: 9Uc2kZpQTSKP4t4SzjONhA==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="204623016"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:36:22 -0700
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
Subject: [PATCH 08/16] dt-bindings: at91rm9260-rtt: add microchip,sama7d65-rtt
Date: Thu, 30 Jan 2025 10:33:48 -0700
Message-ID: <f5642fad5d7a97772ae22c76840c5c51ee79ec0f.1738257860.git.Ryan.Wanner@microchip.com>
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

Add SAMA7D65 RTT compatible to DT bindings documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
index a7f6c1d1a08ab..078b753f453b4 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
@@ -23,6 +23,11 @@ properties:
               - microchip,sam9x60-rtt
               - microchip,sam9x7-rtt
           - const: atmel,at91sam9260-rtt
+      - items:
+          - enum:
+              - microchip,sama7d65-rtt
+          - const: microchip,sama7g5-rtt
+          - const: atmel,at91sam9260-rtt
       - items:
           - const: microchip,sama7g5-rtt
           - const: microchip,sam9x60-rtt
-- 
2.43.0


