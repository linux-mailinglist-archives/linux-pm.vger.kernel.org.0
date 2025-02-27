Return-Path: <linux-pm+bounces-23092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDDBA483A8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929F51656D2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66B1B423E;
	Thu, 27 Feb 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hGTuxDCR"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7A1A9B48;
	Thu, 27 Feb 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671584; cv=none; b=sBV5S0X14t5mdbFoUhzpn+HVg2gU8pn05ZIfSOS8lfl49TRgKdDlL5NjtrGCSRC4GFrheCEukZ+G+t/1yuDa6l00iklWCzb25WwLNznkAvdVhNTpENo1kI+Js79DSkVUlXGxGZNRG4N3ok6WhLfpZPFFsrPa4qcRh7/OukGESYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671584; c=relaxed/simple;
	bh=y6zBcUQgWavANG8NsuRsZDucUUdJh5SHXwtzFjn3t3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tr4KyZpkPYlX+AiK5LZwyehhfzqTG1LeKvjKmafWMAWMjdPPSAEKeVUQLkStVunvkGZQC9rD6Y7BtwfOcUkYQ5JyWqHd3oMrJdevMCDDzeDiriVheBDYivQus7GRe+Ghwz7dx5xdvssxDrCb5QIlQMZUYyGJM60+9CkY4y5DFNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hGTuxDCR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671582; x=1772207582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y6zBcUQgWavANG8NsuRsZDucUUdJh5SHXwtzFjn3t3c=;
  b=hGTuxDCRbtMcFCcHYm3fGw2JSNdtB8M5Z8fMID2LMpbon6+GRdOiKvRG
   elp3j0zGfBSfb2YIF4vhUPd0Z2iEWI1TmlOyjcm8itD/awyYeJIzPM3rI
   UeikDYAD0eiyOnpkuQDHjoCQuzZpZimFP1X7nF0Ju+PYwhgoR0LUA0leG
   epanUCZ+1Ac5eNJ408ic0rdolehC7RaxLm+u3tVK/VQbR6TdCC+8Xda55
   keBRbcFr0L6Vcb+7OAX36rI8sargeTJZxD6UTVRCJXsHjhKhN6Eb//6IT
   xF61e+NPNiLm5XFqEe1RJQTGIWuTk0zxDfu3MMWVbaktHIPYTE0NYtJ22
   w==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: TSfk1f/VQZaZsJ8UblroGw==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638163"
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
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 03/21] dt-bindings: sram: Add microchip,sama7d65-sram
Date: Thu, 27 Feb 2025 08:51:50 -0700
Message-ID: <1f27526bcb63f611d2e14a0f1925b3106f1914c6.1740671156.git.Ryan.Wanner@microchip.com>
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

Add microchip,sama7d65-sram compatibility to DT binding documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/sram/sram.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 7c1337e159f2..3071c5075ee4 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -31,6 +31,7 @@ properties:
         - amlogic,meson-gxbb-sram
         - arm,juno-sram-ns
         - atmel,sama5d2-securam
+        - microchip,sama7d65-securam
         - nvidia,tegra186-sysram
         - nvidia,tegra194-sysram
         - nvidia,tegra234-sysram
-- 
2.43.0


