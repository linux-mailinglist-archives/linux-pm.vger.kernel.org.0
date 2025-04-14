Return-Path: <linux-pm+bounces-25412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E9FA88E09
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 23:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E111617BCEF
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14511FF1BF;
	Mon, 14 Apr 2025 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E9bpsr3h"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF81F63E4;
	Mon, 14 Apr 2025 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666930; cv=none; b=bFgRP5s9AHSVIwCX50F+aoIZkbYwvevAsd7oROAyXIV8tNwFpHF4U4RV3KZFWgyEeijKCzUvPkkU8DP5xp+0vmuRelhfrASBTpc8q1/J5Knmw97FeLVEXZjm06sbvHkJ22BwnVFryJHmCghE3iNNK62npJNRCjBk55I5MPhWR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666930; c=relaxed/simple;
	bh=vnVUWi683eLAl6E3rzjUozBpg+T+n1g51iJhW+AjjsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcpL1hQNVUVV7zs00Q0B4XQ/g7CWUruNKr5JXwk8N9md/ehWOjzN11Z38u9o9BNsfywxxK2eZ5zrEdB2dDaNysGV/53FMnmZ/6UKCUSUK+JyqxlR1yAcfNhf/0PH9oL95MHfZiRAklXHvSSaIVXyQ3IHc8auojvYqxVfoz2gNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E9bpsr3h; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744666929; x=1776202929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnVUWi683eLAl6E3rzjUozBpg+T+n1g51iJhW+AjjsE=;
  b=E9bpsr3hlhOomy9Jtk6Z2UlKJPtdnkg36bzaOWMJQUljNOHufFwMMQ2R
   lPFkrgEuYj63VK5MOOFONiPGX1SAzNQ8Q/ofmrEnflUnQlCamxBu5cEZO
   wQXvkImHmYgpQjo+O8N+iXW/znAjSXf8PMhiXEoVd72Qa/zvWv2qg3QaK
   mji9QSH47zDIkpaPTdkXVLTLyOMvTLsYS1tZof0YRwCPA/EfX6DacJkcS
   +HosITs5A9c92xCnr5QNSR3SwUEBFQYzM49b7PS8hcWfr9zyXnwx3u9Gb
   qosEd/j2bvEjz7Mo/4zUIyXCCw94akYi/q5u8x3HMsKnomROnIS/h0rDD
   w==;
X-CSE-ConnectionGUID: jf75aQsXSneWELgtntpGWQ==
X-CSE-MsgGUID: P6YyYl5bShyxINJv3ViNTQ==
X-IronPort-AV: E=Sophos;i="6.15,212,1739862000"; 
   d="scan'208";a="40006676"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2025 14:41:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Apr 2025 14:41:06 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Apr 2025 14:41:06 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 08/11] dt-bindings: mfd: syscon: add microchip,sama7d65-secumod
Date: Mon, 14 Apr 2025 14:41:25 -0700
Message-ID: <2fdd14313d9cf008dbc4a63a91ba0cb5cf372ad6.1744666011.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744666011.git.Ryan.Wanner@microchip.com>
References: <cover.1744666011.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add SAMA7D65 SECUMOD compatible string to DT bindings documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml b/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
index b1f766e333d4..ad4a98a4ee67 100644
--- a/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
@@ -21,6 +21,7 @@ properties:
           - const: syscon
       - items:
           - enum:
+              - microchip,sama7d65-secumod
               - microchip,sama7g5-secumod
           - const: atmel,sama5d2-secumod
           - const: syscon
-- 
2.43.0


