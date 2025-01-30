Return-Path: <linux-pm+bounces-21136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F78A23302
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94867161D4B
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0DF1F0E2D;
	Thu, 30 Jan 2025 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z99odr8B"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE51F03D0;
	Thu, 30 Jan 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258557; cv=none; b=Rg+gLaLODN+fIrJsFHDaCCsaiBgn2GKA7y8ySv2C7LW4QOCBd7RVf0Q52eMrTX93hEEKKsv0mIdr4u0k8EPgMKpKP56bn0Jm6S0g4TLixTFqttAMLiarkKdA23ANzrAJn3ziPg6EdrNc7VWkqgUBLdY5mvWsnHJmapoZoXuCb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258557; c=relaxed/simple;
	bh=unETEqL21PPGjcJ+5ThZ5Xx9TlKma2kepF5jLOEMdPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTvqIQbQtVQoR231Tska7O/P9ZTEZd7WRvZPnQC2fi3HRxRlDIwFRM2fRouo0COxlJJNqGO8RQShz6NCwhM75QWSkE//WZ5TIiE3+3ruWo1Lc/3lR7xElB7wvRRmfsL/CJABK4RGEQdLz3omAnA5WgTcGJmvzXd+N9osV2OqDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z99odr8B; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258555; x=1769794555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=unETEqL21PPGjcJ+5ThZ5Xx9TlKma2kepF5jLOEMdPY=;
  b=Z99odr8BRIhRjsbEiHmTs+6NWd557LmtFWcKsu6Use50C0wrStqm45eQ
   QHvvF9V45CtxyRBBSIYc+r69b6kWYJZWHSM2KVWm0rsYqn+Qe5FWeMwGm
   TCYw+Il9GR77iUY0lW5AQyA6lJKyBKf3l3+2gT9tgcf0Qlgzh0R4R5ztl
   WVZ35nB9Pat0yTdKI6hOCYfXM77fwpHiouFvy7vBQNKtLBVWuoh11dpLH
   39BQCqu+XiadZqY3pN86lMvauAY7ETQyyymoM2XvOqug7+KTve/ADdcBd
   z8yw4E1WNQPVwBde1kF//+LtqGdY0SW1KqeQ0qa/efIV5h9a1YD0LIW88
   Q==;
X-CSE-ConnectionGUID: X8noN3xrSZmPEckyVo5bzw==
X-CSE-MsgGUID: OxtnvTyxSmKbP44RM9+2HQ==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="204622975"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:35:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Jan 2025 10:35:42 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 30 Jan 2025 10:35:42 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>, <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 16/16] ARM: dts: microchip: add shutdown controller and rtt timer
Date: Thu, 30 Jan 2025 10:33:56 -0700
Message-ID: <f003d5cb209fbda0064cc593bedecd7bff46c86f.1738257860.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738257860.git.Ryan.Wanner@microchip.com>
References: <cover.1738257860.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add shutdown controller and rtt timer to support shutdown and wake up.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../boot/dts/microchip/at91-sama7d65_curiosity.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index 0f86360fb733a..d1d0b06fbfc43 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -77,6 +77,11 @@ pinctrl_uart6_default: uart6-default {
 	};
 };
 
+&rtt {
+	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+	status = "disabled";
+};
+
 &sdmmc1 {
 	bus-width = <4>;
 	pinctrl-names = "default";
@@ -84,6 +89,15 @@ &sdmmc1 {
 	status = "okay";
 };
 
+&shdwc {
+	debounce-delay-us = <976>;
+	status = "okay";
+
+	input@0 {
+		reg = <0>;
+	};
+};
+
 &slow_xtal {
 	clock-frequency = <32768>;
 };
-- 
2.43.0


