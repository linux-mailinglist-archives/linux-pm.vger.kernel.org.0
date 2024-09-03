Return-Path: <linux-pm+bounces-13375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 029189693F5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91555B20F93
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 06:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0E91D6194;
	Tue,  3 Sep 2024 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AOsgd10o"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2F1D6186;
	Tue,  3 Sep 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345800; cv=none; b=MjXtO2zYX3Qs4xq7S+Khrc30+HRyT7zkEpZOt1APUy+elfTDhwJJTJ3YeWnVtzTxPwaUznkRtknGJcDbLwBPJN3ZCKF9xGa8X+k0rKk37ySx+Dm/xM2//OYR9CqmdhklTUDs9foU+NkNsoPcxpG2gDyteN4lgYTjE4VX/o1s4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345800; c=relaxed/simple;
	bh=fkEsu5e+W0g5PuBIO5e+/s99ipzzOmLPi6O6RykybiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7r55uGdYCQN5oPBBbVrgnwyiZf3EIb0AsVUVUa6oWEyPQi0bx8ETemXGf3vHF+P6lHjE5T0wA+jgpK9RQvLzVV2lvgR9KJiFuc+aEJFoQIVXxZytsbjany/RYmUb00fZ4+XvhIKqwb3fXD9U5Vg/YYcb+N6MncRpcymmxXj/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AOsgd10o; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345800; x=1756881800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fkEsu5e+W0g5PuBIO5e+/s99ipzzOmLPi6O6RykybiU=;
  b=AOsgd10oOZ//Dvans6nP80CcxRRpwFsCTmlimmwh7pPsyrngufg6hb3E
   PnU4Js7Cx92yEPTEOGgi6CQK+exwhcr1mP2nW6LmWtQ21YF4j7Yc6DeMX
   oGugzPakW5WbZg/NyutDIxXTOfnqKS5UKA+vdUccnW/q4qaKlDCm9qpwN
   UdG/Ou/72Dabzm06cvcc+LgsS3mDcKsZYy/j/7p1nTINa+c5t5y3qYDb+
   KHWYLTAg8GDcKoduot2PEs08BcTfkaweD68HjyfrxnWrmWufSZ6J4bUgN
   9oKg47OvqomYwyGS/hQhmT7ToegszyVeHwonJ8QuAPMOXFynEaf9vVJLq
   Q==;
X-CSE-ConnectionGUID: nEnX5AnIR2mRmZUE6qFeOA==
X-CSE-MsgGUID: u/buCSLzRxOLeR10kZEBlQ==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31215790"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:43:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:43:15 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:43:13 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v7 06/12] power: reset: at91-reset: add reset support for sam9x7 SoC
Date: Tue, 3 Sep 2024 12:13:07 +0530
Message-ID: <20240903064307.49634-1-varshini.rajendran@microchip.com>
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

Add power reset support for SAM9X7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fece990af4a7..e3ebebc1f80d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -26,7 +26,7 @@ config POWER_RESET_AT91_POWEROFF
 config POWER_RESET_AT91_RESET
 	tristate "Atmel AT91 reset driver"
 	depends on ARCH_AT91
-	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
+	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
 	help
 	  This driver supports restart for Atmel AT91SAM9 and SAMA5
 	  SoCs
-- 
2.25.1


