Return-Path: <linux-pm+bounces-23110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF471A483F4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A53C188EDA6
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D519426FDAE;
	Thu, 27 Feb 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cj6NaJ/0"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67926F465;
	Thu, 27 Feb 2025 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671594; cv=none; b=VhDhC2vGviJhi+7/flx22jxa/t/goCwM7XC1s98SFZAmiZH6ebhMzXK9MsYpkOXP4UxH780TBdzV2zdPI8wyrFWc2ARTuSVlSx94a7nO/ec8064NWw8tQPI+qs8nRz4dsHd4NHEb4voDjG/b0QdotdYWLUxIIyMLWzv46a6gI80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671594; c=relaxed/simple;
	bh=xTx5wh3DLWkZDyZ37nnm/R93yMNnkrcFvkblSIgFki4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnqeBLA+z8J0mz9SY+ikFEBOXtKZjqkSCiUAV+G/uZ2ehEHdT5IhYQ1uRIhQkpmFoixizNsV/ygqLNH3eE4+CHsGNY7ERK0uA8L+EnHgl7U9wqz/q+kvZJJoqrDB9VKsKs8Efc+z/a3z/IOniwmKSmFXjNsB1kd7uLf6JVClLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cj6NaJ/0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671593; x=1772207593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTx5wh3DLWkZDyZ37nnm/R93yMNnkrcFvkblSIgFki4=;
  b=cj6NaJ/0LCIoHwGdgtlJ8MWYx+6KLiqhPilhCWEFDSUe3q4vHRdxaOBq
   u4eXni8tUHBtFP3SCTjRooc0aVremHH2bdVG3TuH5d2Xvd9fOaMTYLXz2
   VpxWw0YIDC2x8Yk0P3/xXCBBQbLEdbj4199I0UsJs448vKoJfgghqfIRr
   NgL56OcK8CHeuxu4qb71SWcWIiw3IHj/aRu/rquH4T+19csd3Hvi3a2pr
   Wc94lh0AWmhNKecKh8goKFeWCQkLamglqco8ZcMKIxL1O5u3ykGC900eb
   DGtOvCa/9YWdGkwA4XMHKvfQfwP99TXRuUUktKpk/RJYPVOMNKUmCl8Sl
   g==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: VfNqJMEyRMeS0YCa5htHdg==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638185"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:53:00 -0700
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
Subject: [PATCH v3 20/21] ARM: dts: microchip: sama7d65: Enable shutdown controller
Date: Thu, 27 Feb 2025 08:52:07 -0700
Message-ID: <c31c40eb388b2fc0ad6ee17ed2e23bcd04e8e1c8.1740671156.git.Ryan.Wanner@microchip.com>
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

Enable shutdown controller to support shutdown and wake up.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index 93a1b0684eb9..30fdc4f55a3b 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -148,6 +148,15 @@ &sdmmc1 {
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


