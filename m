Return-Path: <linux-pm+bounces-11525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C0093EE25
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 09:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1CDB21791
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE18D12D76F;
	Mon, 29 Jul 2024 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FNHd2VhA"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7912C7FD;
	Mon, 29 Jul 2024 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236994; cv=none; b=ToTnv2eT00hFy3LIon1qdF6yCCd9PXwOAcQKac6s6N4OxjYbPQlUd8e5nZxHERISWm9/r9ESzrsVL53Ky7yxUTlKXL7TFqPD4uSCfX5plx3NRz+anxuSIK7sEJ/+tPlBQ5dW8RtulJOF6aGVRIsDkNdF4A5f14N1kc989HgvM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236994; c=relaxed/simple;
	bh=flQEluk5hLljQfPymWhZA5C4pdYlqlYSYYtSaCbnjQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1ePLnPf29MXUeIjHCkyHykGZFb6B8tOeF+V7/Lq3rZ1KFhnQkzJWEzGfH+BPRDDvJqCaVBq4A04YM0RM625emVcv53LIWvQ8gEMneXxMYDu88X1s5tjeh3s4FZLQIyor6sW+V0WDgHB0H7XUGS60xaG413idjOFT1L5zwupsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FNHd2VhA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236993; x=1753772993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=flQEluk5hLljQfPymWhZA5C4pdYlqlYSYYtSaCbnjQ8=;
  b=FNHd2VhAyJr4uZwhs6jGEawpZdkcuHSERBnC3DcoHizbPieqCu4GQfB8
   80aBN2BvT7d9+lGqQT/PP+Nx65YxmO41ZnY/LlXt1jO82N3zRkcaUlE06
   fKKVITViqBjXlAAV7WX4CgB1BkbD5qwB1XKmrVdXQ9+AE6SH181qfVkNQ
   CWQV5lV4pj2WS5G7f9fojysaeDrhl88LOC6hfBAh77hBgLJSDgTsuCQ7M
   PYyY8AQcqjBn8phLMiU1AlWqBWi3kHp6apGSBZ95WF3VjUGToIeA3g2vT
   g10OHVA7K9XYBqW3FoTRYAXiBKjhlze3GHcOgB1Cs7pp2WXoZakiag7Tl
   w==;
X-CSE-ConnectionGUID: YmCZXuD3Tai4yHyg8vJh5A==
X-CSE-MsgGUID: htNuK+SpS2CqwLB2J77/3w==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30454179"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:09:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:09:16 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:09:11 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v6 22/27] dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
Date: Mon, 29 Jul 2024 12:39:07 +0530
Message-ID: <20240729070907.1991321-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
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


