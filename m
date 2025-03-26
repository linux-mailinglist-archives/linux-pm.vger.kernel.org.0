Return-Path: <linux-pm+bounces-24524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D3A71ABF
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675E616E082
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D022F1FAC49;
	Wed, 26 Mar 2025 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pxrQS4GS"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B771F8721;
	Wed, 26 Mar 2025 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003404; cv=none; b=CqiIFWo6PQMKsQaeCA42+Rpdykz0BXTt7+yya1XeI89JU4uEK+JT1dPjMylOMPYDAU56mMXE4ujJ3gD5UqhEbOLkJx/1iaqarDgqeDHm9Tpjw/3AyDeGtdVkRFIG4kqqUJlPviIwIWlTqhavwezV3T2O4kKjkDkrg0p1OyEl2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003404; c=relaxed/simple;
	bh=0dSNQmt/pmj+2I2/ldT6fVmUOsoQVpjXvWZBYr4mUX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtuZ0Lnxzz2DpvEnWVCWxhHXgoe9+BOIquvvnYiBzdZLYbANNI8OxLtyyRDgIKUJuOaqkyue0wQ26lxNtGdgJBDPkfuk5OIjPZ59/BhgVb1TfE56y79oetoEY8QJFuD1WDQS4i9GTeIepBy/fLbNzpAWfyvhR7UWWiT4e82n0sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pxrQS4GS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743003403; x=1774539403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0dSNQmt/pmj+2I2/ldT6fVmUOsoQVpjXvWZBYr4mUX4=;
  b=pxrQS4GSjIQ+l02GyLabbB21034/kiYJrS4QJFnPXJEeMf9ULC8mdMbc
   K42ftI5HwfrWxVmLUgvrnBFYc+AN2EoDHmRrI0n+Mz3QzcmZM/db/O3PK
   y8k7H3DUA2dkmXeYwI1TiiRarDmyBDnJbVK4Ez0u4YPMKwI1LGJbUbfI/
   OyjjybZ12Uav6wVi3fkVkmCYNncwXNoJKe/AM9C2bJa3glrYkmkEURuOw
   ar41U0P09Y3IwoO7uqXJJ9tz2RTeNkOnKMjkuOdY/H8Zc4VfYVox9+SOw
   dHoowkSldIiiEjyyGmhB6Ewqx1zIeyaAQkkE1dVaHpqPP3NX1fTxJ0xR8
   g==;
X-CSE-ConnectionGUID: NRxSiTFnT3ucBnaYj7CaZg==
X-CSE-MsgGUID: 1gufScu5RJGEEVRHYn0edQ==
X-IronPort-AV: E=Sophos;i="6.14,278,1736838000"; 
   d="scan'208";a="44096115"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 08:36:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 08:35:52 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 08:35:52 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v4 10/11] ARM: dts: microchip: sama7d65: Add RTT and GPBR Support for sama7d65 SoC
Date: Wed, 26 Mar 2025 08:35:43 -0700
Message-ID: <0a6ac5965a4422e82768579ee5a0540bcf15fa5b.1742936082.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742936082.git.Ryan.Wanner@microchip.com>
References: <cover.1742936082.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add RTT support for SAMA7D65 SoC. The GPBR is added so the SoC is able
to store the RTT time data.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 7d71e7326e3a..59b43a633aef 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -132,6 +132,13 @@ shdwc: poweroff@e001d200 {
 			status = "disabled";
 		};
 
+		rtt: rtc@e001d300 {
+			compatible = "microchip,sama7d65-rtt", "atmel,at91sam9260-rtt";
+			reg = <0xe001d300 0x30>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk32k 0>;
+		};
+
 		clk32k: clock-controller@e001d500 {
 			compatible = "microchip,sama7d65-sckc", "microchip,sam9x60-sckc";
 			reg = <0xe001d500 0x4>;
@@ -146,6 +153,11 @@ rtc: rtc@e001d800 {
 			clocks = <&clk32k 1>;
 		};
 
+		gpbr: syscon@e001d700 {
+			compatible = "microchip,sama7d65-gpbr", "syscon";
+			reg = <0xe001d700 0x48>;
+		};
+
 		chipid@e0020000 {
 			compatible = "microchip,sama7d65-chipid";
 			reg = <0xe0020000 0x8>;
-- 
2.43.0


