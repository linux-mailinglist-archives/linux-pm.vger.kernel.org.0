Return-Path: <linux-pm+bounces-15452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B163998592
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 14:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D483B245B9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 12:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462B21C7B63;
	Thu, 10 Oct 2024 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t2uBbRyy"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63451C6F7A;
	Thu, 10 Oct 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561912; cv=none; b=YJeTHQA2COMFFoyuI2eErEdZRbYfzXqeL1AXv6yoaovn0fw27sMmxqi3fTqj7bAtBSuL0iuCZJKtxv++dnCHXViPTaYzerEPJUdf7yFJFlS80SI2pmA9FYu8joEV3hmt0w2/js340x1KLs9qbmCrhRZL+S4Jg64gl9AQUb7haD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561912; c=relaxed/simple;
	bh=flQEluk5hLljQfPymWhZA5C4pdYlqlYSYYtSaCbnjQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftembV5LG80FQCfosmN5Tb2Bp5dvg1wwcA9tHv0ifxSn/gSa6NrUBFQGukXdvzsXrGnMec5+gwzVR92utTHAyzTlIilNImfY88U7E5dWzmBcu1BoRi4rdq0JMeolBx+/O+1GFrjXylSqu+yjAyLeTl29t4n5SrlcW7FiYVDZnEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t2uBbRyy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728561910; x=1760097910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=flQEluk5hLljQfPymWhZA5C4pdYlqlYSYYtSaCbnjQ8=;
  b=t2uBbRyyRLePpoVF8WTd4itS2En3N+sBvWzgevUrrq/71Swm2IY1VJ9B
   Z//lBpBZX/0tfaq45REGOfEfHo5wIWjz1jMvhs++Q4NpCCpD51dXRQXKY
   1epFAOfQqdYF/GPfCZ84BZxAZmFoO5TMxSMMTwO2fyMmX+lecEXdeO7zb
   eqLh/dxOvL/bC0R34DKo3oc1udj6iozRlqDcWAaK3M+g/Dvvfrkb7hoEh
   KtEFek+Pa2BcgL/PBizfgRQRncNLWOjWmv57BUq42utyfXbpvOei50Cpt
   wFXqtSoWQGraM/LC5jzKlWVFrwnPGqPJ1d2yoHsxhqKyuF6o8yyE+gpej
   g==;
X-CSE-ConnectionGUID: 6vPdQ8NYTmWaYmDn0yd8Nw==
X-CSE-MsgGUID: 1WdRkE9yRD6MFDyWMKXKuw==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="263902615"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 05:05:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 05:04:31 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 05:04:27 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v8 6/9] dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
Date: Thu, 10 Oct 2024 17:34:25 +0530
Message-ID: <20241010120425.93102-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241010120142.92057-1-varshini.rajendran@microchip.com>
References: <20241010120142.92057-1-varshini.rajendran@microchip.com>
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


