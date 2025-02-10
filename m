Return-Path: <linux-pm+bounces-21739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60150A2FB9F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6A8163224
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A822505BC;
	Mon, 10 Feb 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B5KWqaaM"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542024CEEF;
	Mon, 10 Feb 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222055; cv=none; b=H7JUAlR0tiFqjjjCnHYkdkbq2gmJ+O/s5eNzWiTvGQpgFzTTURsNwT0X5KN0CrgtAyIiAo5U203Z3+v3hF3UcwnsEuIea7Fj6aVtCS1pcCAY28MxqSpVku6Sw0nR6sRqJyn+22egAUBU8GAFhIvEwepP5Kv3/m441nsfB30VaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222055; c=relaxed/simple;
	bh=fcOtmvaFsAS0RMEtizoTtGHisQpDgUijGPl2nL2ZIPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnSeZzO/XcMZOVE2lhNpiMFRPAoqQw94F7BeNmRGoBGJ+s/wzHKTmhm85T86RsU7cZDIm+yefNZDKP+IjIPW+OiYtqMeYq+kZqh5WHJOE0V3QxdYzIC1kiL2tBn3dIQuiFNfOGCSL/rAHpIFpvEaA7Ll/IK1uuZ+aZ4NobXDXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B5KWqaaM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739222054; x=1770758054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fcOtmvaFsAS0RMEtizoTtGHisQpDgUijGPl2nL2ZIPU=;
  b=B5KWqaaM5nv6RCQkgCLltN99GLGi3JcZqe9Lrwmr5N1EOcW6jy3SfIvg
   Fv6uz3n23OV4IojSiHNoysYA7dkLOKdXuLEgh6lGhqMP8Cy7J2niCDnbv
   1EbyF+Ys+ljx/mlU4jfosDZBlEfqkkEIABWivy9tmRHpZ5x5VFRwYkNeu
   V27BWhIRbrWvPRLvJK2ODB7aAiPH4Wv5qhSlAgiZklKubEeTWGipRp64T
   +UWh/jsMm7fWf9nVSK3pdinGPWpPTSxAakGelwSHTsTuy5AV63/z9poFc
   jUEBwfwLKfgpGL+Q3MY9Whlnn7Jz1fHhAgzCtU54ym/Nuu/POOcoJbSt6
   Q==;
X-CSE-ConnectionGUID: AYqW9AG9RbOJ2Xf8Pt97Yw==
X-CSE-MsgGUID: GJ57O7poT5S9OO80eV2peQ==
X-IronPort-AV: E=Sophos;i="6.13,275,1732604400"; 
   d="scan'208";a="205027972"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2025 14:14:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Feb 2025 14:13:45 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 10 Feb 2025 14:13:45 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 04/15] dt-bindings: power: reset: atmel,sama5d2-shdwc: Add microchip,sama7d65-shdwc
Date: Mon, 10 Feb 2025 14:13:04 -0700
Message-ID: <f7d7e5fdaa86c61e586978dfc11014cb45c32cd7.1739221064.git.Ryan.Wanner@microchip.com>
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

Add SAMA7D65 SHDWC compatible to DT bindings documentation

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
index 8c58e12cdb600..2930607480ea2 100644
--- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
+++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
@@ -16,6 +16,11 @@ description: |
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - microchip,sama7d65-shdwc
+          - const: microchip,sama7g5-shdwc
+          - const: syscon
       - items:
           - const: microchip,sama7g5-shdwc
           - const: syscon
-- 
2.43.0


