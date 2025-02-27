Return-Path: <linux-pm+bounces-23109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A91EA483F2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F99188819D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07C26FD9A;
	Thu, 27 Feb 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r7yUsj3P"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607F1D5AD8;
	Thu, 27 Feb 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671594; cv=none; b=BEO4ZzI4JaysgoRVwR+jKx47tI4lujKU0qPSGF8bCpV0hzBxBWr97fFrBrzi3Typ11ev0HwhlM3QBjqcr7mygtYZOfFmGKiew/GWV5Zwlxt4cnU22OV0dRBa/h8PdUSqoozrB0CRR/FqZ0FUDTO3CfeQx3XBMR6eUZcq2JJkLgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671594; c=relaxed/simple;
	bh=YTKmnoBoJKJalyZ9+wnMP6cOqS4GPx8T77stiH9ewgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfSjiTH7Epkefcc2k4u09qhnPyAqQcWdi1t/fvxQjlXJuJwnArgWBckQmhN+GOdycgqQHJ7ilQ/OcjZHa+m7ZzJzdL74SDs1hYmYlwVNdd1DculPoFrhjQuU500DKM250lTDlIxrp8o3UCBmgJLATyzGNuGYjgS5t29L5PL5yos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r7yUsj3P; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671592; x=1772207592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YTKmnoBoJKJalyZ9+wnMP6cOqS4GPx8T77stiH9ewgc=;
  b=r7yUsj3PzITPC1a+kxmes0ar2HOaSjxifbAPqLYUZwMPkkeuX4O+Ghrl
   t1mempBTe2ERKSWnExm2qNKmcUr1pt6RLo4+qkx+tqjijXH0Rhooqw3+T
   r8J6CoA1k2szlK5SZOIPB53R1KA7cTFI0KAa7jwRf3wN9Smfrtv1oxYuU
   UMuji+WdZWFODUwWFEO4GC+Zls77zqLz9SM5+NH4emUS1xwwwhdwLVzH/
   hUXKH73muA0sPB9rhb/kiNdht9EUl81ZGlm5m1N5WLgstT8W9wBqE8Yiu
   eFe3Iz4JC6+kkwbe5ePmOf/bCica41CmSmADyHPXagScMFn+Qq6U8Zuqn
   g==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: L6MQVkjMRV+EIvF8OWYFtQ==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638184"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:47 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:47 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 19/21] ARM: dts: microchip: sama7d65: Add SFRBU support to sama7d65
Date: Thu, 27 Feb 2025 08:52:06 -0700
Message-ID: <dbc51f95f301c106c031fb93f84d0d847e818d91.1740671156.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740671156.git.Ryan.Wanner@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add SFRBU support to the SAMA7D65 SoC. This is required to change the power
source for backup mode for the SoC.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index e623f9d22f36..45037fc95adf 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -78,6 +78,11 @@ secumod: secumod@e0004000 {
 			#gpio-cells = <2>;
 		};
 
+		sfrbu: sfr@e0008000 {
+			compatible ="microchip,sama7d65-sfrbu", "atmel,sama5d2-sfrbu", "syscon";
+			reg = <0xe0008000 0x20>;
+		};
+
 		pioa: pinctrl@e0014000 {
 			compatible = "microchip,sama7d65-pinctrl", "microchip,sama7g5-pinctrl";
 			reg = <0xe0014000 0x800>;
-- 
2.43.0


