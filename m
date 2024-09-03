Return-Path: <linux-pm+bounces-13378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C565969403
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597282850BC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 06:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195F61D6C62;
	Tue,  3 Sep 2024 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ahwDAFpv"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8E1D67AC;
	Tue,  3 Sep 2024 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345858; cv=none; b=fcDmSX3rmVulGTnCeBhBrNTp/HSLvEk36QpGMcWI+trD2iX5fLM+CVAbKlVR1oRZW/XXb1RQg8Bq1CZ6xmlXGliBCikcxpHZZcqiftZcCJy6UbWfbIGCI/gubxEuQSR/F+4W/ZFUBw2zbhabIMYr/4jXeZxeNxbizm3WY1pBUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345858; c=relaxed/simple;
	bh=flQEluk5hLljQfPymWhZA5C4pdYlqlYSYYtSaCbnjQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqFnyZq/qP92bVip+dbKqx/1RdxZ4DfIYPTPKfA5gIhBAYAYBX/REUqyWz1B1rq0lV5uPEAtUl2ByCrewAcHyuWDREHihg7z9CVs5ZPb0SZY8YANjhUFnyYTbYCgoVW18gDQjpd08KjGbEcB7swAIVFV4Fg3iM9f0SJ9pn+KD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ahwDAFpv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345856; x=1756881856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=flQEluk5hLljQfPymWhZA5C4pdYlqlYSYYtSaCbnjQ8=;
  b=ahwDAFpvvPCwSb77564PVxr1rigjjcbDUBNsWKcXzciTTKBBFc4rtc28
   4g8qbTN48Rh32fRphrIsfCkm0nrctYn+xPp8CMaJH8uL9np/AcumncRsB
   /ugMcaB2c4Rt4ZL1gI05uPQoZl5wppPPpwBPpY1hBky6U1icIyl22itnJ
   Rp7qevsUSodMdWr5gQpZ70SXTFFhkPaXl3q1yDEZLQTUamGsnLKEvg5x/
   FJwwGnx8AQwYEiNNrYcRDXK92YlJ2HtgUBhsOP47gH2hCrpTB0mh29IoX
   peVm9/eqkmNramq+x7USJvJYYfV50A2CbFeR5t52zPG02k00kfuFYjD62
   Q==;
X-CSE-ConnectionGUID: RQ/RpB+QRjexyFExAQsyWw==
X-CSE-MsgGUID: OQXgAnCTTtOTHobobvMsnA==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31877404"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:44:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:43:45 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:43:41 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v7 09/12] dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
Date: Tue, 3 Sep 2024 12:13:40 +0530
Message-ID: <20240903064340.49800-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903063913.48307-1-varshini.rajendran@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add shutdown controller DT bindings.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
index 8c58e12cdb60..0735ceb7c103 100644
--- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
+++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
@@ -22,6 +22,9 @@ properties:
       - enum:
           - atmel,sama5d2-shdwc
           - microchip,sam9x60-shdwc
+      - items:
+          - const: microchip,sam9x7-shdwc
+          - const: microchip,sam9x60-shdwc
 
   reg:
     maxItems: 1
-- 
2.25.1


