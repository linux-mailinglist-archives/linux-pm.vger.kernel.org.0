Return-Path: <linux-pm+bounces-34386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047CB51D84
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 18:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD9417BFF0
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B390334714;
	Wed, 10 Sep 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XpsrgZLw"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865A327A04;
	Wed, 10 Sep 2025 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521356; cv=none; b=OgMJFGIz6JTLxP8HWQ4jE8Ks1k6YX/EO9wLGpKJ80dzSykG9iA/CiOkMLwhlZWDyCK09B4PYKETjvBkoi5NBAsyKwYBf9r+2GtR2WP8hFFx6JTcmLWaHJt9nxy88UwACWg5q7l5tqW2tB4vH5gOLu6JR9OWMQR06vGbp63lJFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521356; c=relaxed/simple;
	bh=5pieibsRPJo/V0RuJcEOBHWPfpUwqYwCzxf8IMfkT2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7QBkOxQzR25mMl8hx6KnuPXN8OtMyOOQYhS5DULtvUmZ+OineMsT//bssqR+jVTaUkUpkGN9Jr0qeBrGaSHTFIzXisAoBocQAsY8CKg+K4gkXoz7FWx+M7pkeN8uP6t77zrDp6bIUfFaU3GftnNm0jXLWskD2j0/2BSAbxPT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XpsrgZLw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757521354; x=1789057354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pieibsRPJo/V0RuJcEOBHWPfpUwqYwCzxf8IMfkT2k=;
  b=XpsrgZLw63C06QJN+AIdW4Sje2XsuVahjVn46u2dw4xwzRAjg0FUcSWj
   RDfNhgDfhRdzSKl+KvyOGkdDv4SGR/95j0/Axq5NLzzDuzjhPWQMXRrmA
   BkGi1OZ6b86AUqK8m4qHgfSTczUIXu0vOiOiux3WjTLCR98DwbrAdNQSn
   z8mxLvhPhcQWVwPvnNcQI+In1tV3JlzKwvposEdYBzOy1xKlhthyNFgsb
   cttBOgBvFxoJNosB2rHnjK+g4cNQ5uo7wWx9lv5HntvW+R4kMfS6hQGwr
   hZB87I1T9x/m0nmo9JbssGD3X+bOCUkY1ugDJgZuu5B5OWW9AvBUHZySu
   g==;
X-CSE-ConnectionGUID: tPE+SbpaSyCyxVMbhLqdoA==
X-CSE-MsgGUID: f2/xiDzdRj6Lx1CeFsmEmQ==
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="213715733"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2025 09:22:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 10 Sep 2025 09:22:11 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 10 Sep 2025 09:22:11 -0700
From: <Ryan.Wanner@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ARM: dts: at91: sama7g5ek: add microchip,lpm-connection on shdwc node
Date: Wed, 10 Sep 2025 09:20:39 -0700
Message-ID: <ded286a183a5111d8165727111577b088f5d67f3.1757519351.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757519351.git.Ryan.Wanner@microchip.com>
References: <cover.1757519351.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Add microchip,lpm-connection binding to shdwc node. On SAMA7G5-EK REV4
LPM is connected to GMAC1's PHY, 24MHz oscillator and PMIC. On board
PMIC is not listed here as it is only treated on BSR mode
uncoditionally.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 3924f62ff0fb..50e9a5a5732a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -872,6 +872,7 @@ &sdmmc2 {
 
 &shdwc {
 	debounce-delay-us = <976>;
+	microchip,lpm-connection = <&gmac1 &main_xtal>;
 	status = "okay";
 
 	input@0 {
-- 
2.43.0


