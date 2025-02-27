Return-Path: <linux-pm+bounces-23089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C98A4839E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B636188FE0E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4361A8F84;
	Thu, 27 Feb 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x5xvjYxb"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66DD1A8F63;
	Thu, 27 Feb 2025 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671582; cv=none; b=eTO0t216cR259EHDRTYf2YHLhKyqd8ZJnSSEQJXr801tEkG386jU0VanbB2Y2YFUXG01diJFr/hGIlCyFkMCURcfLyzy1Y4kdRZnLWJdFO4SE9lxLI1qNdGjEz8yB++L6zeftVGaXe003DgwC6Sb7pyd1rC7Bt5ZtIOEf6omAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671582; c=relaxed/simple;
	bh=uwvaQhpL/ryj7UfrdD3+qReVR79lU5INxwAw4Zh+LZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVxo9h7PgaRLMw0Grr/K7lZqW2ul6TD4r46RjQnCftvQdnDr5H7FKZXRGBJYnmqeussOdHjiS1UJ9Kv7XrB/apqvxP1TLzleQ96LIXxbUP0x7plxkLleY0qSRH44EEuF8If9tyTxPEY7EoRX31TFm1tJArbmNHzsLuo8vNIznZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x5xvjYxb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671581; x=1772207581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwvaQhpL/ryj7UfrdD3+qReVR79lU5INxwAw4Zh+LZ8=;
  b=x5xvjYxbWgWdqBcxF1C7yb0A1s4ziBVYqJguYRRTNyJe6yL+Yw4VT4Lv
   Qaoik89HX2tLnDs6lQxnzjj5V3csbDM9jLqe84WAopv+j3cW0/XWKs+ra
   HeRKYhzJWHA50ZanFd70Ok88XNq1d/GjYphgtt7/iNF5/r57ZiGbFtAxr
   XrGO6FMJPS3L1zE5w4auIlLfpANTgM78ehVwJBsmIOhP4fFL8qpB+DIeo
   tFLtfWuMB3QjPlvVcDHIKNOS9+Xe8rNjbUyRX8kT7SkvRxm6OPDSZIGur
   RewGi2P+Wh6mGzHl2L0EhBeKuP+zn+lwCbh3wGD1UlTPXAdF2dV5bsVFM
   A==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: Nu2RswKDQFOU7TU3XGo13g==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638160"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:44 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:44 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 01/21] dt-bindings: mfd: syscon: add microchip,sama7d65-ddr3phy
Date: Thu, 27 Feb 2025 08:51:48 -0700
Message-ID: <c5d602b7d4c29333013ef3f75544c2eb7e4b8dab.1740671156.git.Ryan.Wanner@microchip.com>
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

Add SAMA7D65 DDR3phy compatible to DT bindings documentation

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 4d67ff26d445..769dcb096186 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -90,6 +90,7 @@ select:
           - microchip,lan966x-cpu-syscon
           - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
+          - microchip,sama7d65-ddr3phy
           - microchip,sama7g5-ddr3phy
           - mscc,ocelot-cpu-syscon
           - mstar,msc313-pmsleep
@@ -189,6 +190,7 @@ properties:
           - microchip,lan966x-cpu-syscon
           - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
+          - microchip,sama7d65-ddr3phy
           - microchip,sama7g5-ddr3phy
           - mscc,ocelot-cpu-syscon
           - mstar,msc313-pmsleep
-- 
2.43.0


