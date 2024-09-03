Return-Path: <linux-pm+bounces-13377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2E9693F9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28ED21C22E6A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C61D6194;
	Tue,  3 Sep 2024 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XP70fSbh"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B91D54D0;
	Tue,  3 Sep 2024 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345816; cv=none; b=khrJ4JpZrKm52qhiz6LbyYXCQnRzsBaenFNDrWeof2JAK+Wzz2zGbmkzRGEcZS2QgGdDluTolKH/00H2ijnJ7omb1mII+Zs3sg6zEhxmRRTXmg8MXaKxoFY7ftQDtpwoe3U2shtrVw3m+lJGZqIomQ1x1WcAK+D39nu1QnwHq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345816; c=relaxed/simple;
	bh=/mWFDaWRq2GZ4n7XU0bnxeFOBI7HIo3HCLBzu1R86fI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfBJE8UmDEIZ0WWAj+Vp4Cf75XHnw+b3K+5zVwAChhInEFSono7C20+WHfFW/fd+81hdR8ISiixMXXuiGHyF17mbEGqI+pBYt9B7Kp3TyFfWVfoCkMp/e3+7ivMmzs3e9RWusHYrdnMyd9CRm+MfYWMhT3HIoScWZ6Jxhkn+kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XP70fSbh; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345815; x=1756881815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mWFDaWRq2GZ4n7XU0bnxeFOBI7HIo3HCLBzu1R86fI=;
  b=XP70fSbhs67QRQvT8SIcLOqmg6KlusJ13dYVC8tYBdYzf5M63QHaUS7B
   uf19tVzuloXrOu6md1DrwJvwvi2Vrc4QMzSAzimK4lXv9zD5S7V/4FOk4
   V+M+lODE7Pz+eORS/UycBYMm9kpThPvn1QAJlxaBkmnnO4HniZKKrYSHK
   tRkbCDCOyMg25/x1ozjxQzuE1dk9dAfOgZKfOSJ90MPHtH5QxIi96wiR9
   KDXDClWtsrWR8EyDIKut/hvMeyMZKvz0lMeD2K8SsDgkRLgyyNRswlVrg
   55KsHXfGSPxf1ilRBJBlEbuQmjIvz5VU0mepRKoUbG70MeqN8Zr3GJTGU
   w==;
X-CSE-ConnectionGUID: lHuJBXFVRKq7Mozyeyt1yw==
X-CSE-MsgGUID: jWSkA5t9SWOm9R/PHbT9kw==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31877379"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:43:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:43:28 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:43:20 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v7 07/12] power: reset: at91-reset: add sdhwc support for sam9x7 SoC
Date: Tue, 3 Sep 2024 12:13:19 +0530
Message-ID: <20240903064319.49702-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903063913.48307-1-varshini.rajendran@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add shutdown controller support for SAM9X7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index e3ebebc1f80d..dafb0126f683 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -34,7 +34,7 @@ config POWER_RESET_AT91_RESET
 config POWER_RESET_AT91_SAMA5D2_SHDWC
 	tristate "Atmel AT91 SAMA5D2-Compatible shutdown controller driver"
 	depends on ARCH_AT91
-	default SOC_SAM9X60 || SOC_SAMA5
+	default SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
 	help
 	  This driver supports the alternate shutdown controller for some Atmel
 	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.
-- 
2.25.1


