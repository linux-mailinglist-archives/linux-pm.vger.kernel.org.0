Return-Path: <linux-pm+bounces-21750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B7CA2FBD3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328AD3A447A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC525A2A7;
	Mon, 10 Feb 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dDwEnlh/"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A5256C6B;
	Mon, 10 Feb 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222063; cv=none; b=eIXtepFhgDukadQ+xM6ohNcJA8ymlDZqPXNvNSldIDVBMLtcRg0pMnqeZkPQPeTgDHaK6UYht6IaXbJXayTPZA8k7AU09FeXW1OWGEFakp31AQFtg5OjEspuef79gxZg5RgbURXJ9Ko0DTw/qOo2qvw7pZAQXyhRwRd30xe19+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222063; c=relaxed/simple;
	bh=unETEqL21PPGjcJ+5ThZ5Xx9TlKma2kepF5jLOEMdPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJfWwL6xPeo/mHrkSnEdZqD5WbYnfWx5OPXdN+Z0rpgfzDeNkLKHROn/eAAHvyHNsZBTjbTgEoNe7SPgUzZZQ/4hcmxZaBFPeiYIT8OdjcGcGlz31lszBO7lS51xOyMAO/B3I3IYU/N/aiiU/JPNBRt+3zf7kFEHYBQKc0A/TMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dDwEnlh/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739222061; x=1770758061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=unETEqL21PPGjcJ+5ThZ5Xx9TlKma2kepF5jLOEMdPY=;
  b=dDwEnlh//fm9WkQOm9Th9vpn88QnBCfcrvol9jw9fsbMrbCqnd0tjMwJ
   Jm6WT03DbahE4haHRNbLeezHg1wrEDBc8PJugDKOTKiiROS5nX+5U6sZu
   fiy07Eza1ZIthNRpHIFU+yJ59xKuEn0+LQOoG58AeIU+0qVdE0cXrtnd3
   n300gu5mVDkzttFblyJ7UXdpLo8tx43CQRSiVNbQ8VjcdvFP4y951fN+9
   IghVvNLknX++Ay42d0Nr5rp5SMOsC1X8zXABt6IJlzdQkxK4Km+WaX/H6
   OdJFPSFsCCT9p0i2hUaQaeLsxMxwynmfjWpIkdKcVTrBg/cQH5UKqUtZB
   w==;
X-CSE-ConnectionGUID: AYqW9AG9RbOJ2Xf8Pt97Yw==
X-CSE-MsgGUID: 0agEuR3bS46pa3Vj3mw/1g==
X-IronPort-AV: E=Sophos;i="6.13,275,1732604400"; 
   d="scan'208";a="205027996"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2025 14:14:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Feb 2025 14:13:47 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 10 Feb 2025 14:13:47 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 15/15] ARM: dts: microchip: add shutdown controller and rtt timer
Date: Mon, 10 Feb 2025 14:13:15 -0700
Message-ID: <709f5268da63c123cc4eee9e47875324df81c454.1739221064.git.Ryan.Wanner@microchip.com>
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


