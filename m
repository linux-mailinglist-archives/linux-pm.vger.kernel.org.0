Return-Path: <linux-pm+bounces-21134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1332A232F9
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD7318873A9
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692D21F03CD;
	Thu, 30 Jan 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vxB916qk"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517D1EF0AB;
	Thu, 30 Jan 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258555; cv=none; b=GIsMiKwJVXyjq+WTIz/yv2sK9BCYWtmorX7iASJK9RAHGo2gIFaVvsRhakpv7BG+3rsOqPMYPLN/I0ouKYiKUzLs3Mc9ugOC9Wv9uM0EJ82uc6Yi3v/9MweMz1Mjd8YGmLM0QdEPsydVgGbk66Nrdvp8Cuj9hOhnwmOlsKfvN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258555; c=relaxed/simple;
	bh=Q6EhuaD18bf95yOzyUc9NiJbUcTYlA0vWWENLIJPl9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n45JD7r5Qu3Ytys/2xK+SjTe9fQRRRMucbcJnO1MaUngFJjuCwfVFwHNpdlqsNPE7qONPxGWQpboZustlx/XiRmsmfUWN0W2jSoV4BmfPwxmdjSU5YCRwodHsLoE9/OkQ/Yd/Oc8m0BWBr7L80n+3ajiegfAEJIu8xQTqFzcC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vxB916qk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258553; x=1769794553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q6EhuaD18bf95yOzyUc9NiJbUcTYlA0vWWENLIJPl9s=;
  b=vxB916qkqaxznuru9cm2tJBOZJZJNaI7afFwIFm7Q7d0/KVB1HrKZPgv
   NOdXyl4+/70EDmy60avXPj6IM2da2v8oXH+EkZsFWBKxFFt6mi5niEj8l
   y+ydkGp3NVaDQqoPgczHjgNTwI11b2cUBMfJE5Rig8Gzz8ViK3CQ2aUgW
   lCuknytecAcThE9AtO9a0WQ2FHKJigu/tEYY7eXqnXwUu/63ubrXPRwHI
   QRfBP8vPftqIWd1ZfvXJwGhI7FK0Ty+YtMrpwUpxmqBbw6bQxvkT53NRy
   TrLZAZjpbdpZCQGbZLZiZ4Pxz1hqkocmecRu03my5defK5xOjj4vSTS2f
   A==;
X-CSE-ConnectionGUID: X8noN3xrSZmPEckyVo5bzw==
X-CSE-MsgGUID: sNfM+dQtQcSRiVUIUf6Mlw==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="204622973"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:35:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Jan 2025 10:35:41 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 30 Jan 2025 10:35:41 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>, <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 14/16] power: reset: at91-sama5d2_shdwc: Add sama7d65 PMC
Date: Thu, 30 Jan 2025 10:33:54 -0700
Message-ID: <bdf9259be651517998481f1518b2129f65841d96.1738257860.git.Ryan.Wanner@microchip.com>
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

Add sama7d65-pmc compatible string to the list of valid PMC IDs.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index edb0df86aff45..0cb7fe9f25a07 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -326,6 +326,7 @@ static const struct of_device_id at91_pmc_ids[] = {
 	{ .compatible = "atmel,sama5d2-pmc" },
 	{ .compatible = "microchip,sam9x60-pmc" },
 	{ .compatible = "microchip,sama7g5-pmc" },
+	{ .compatible = "microchip,sama7d65-pmc" },
 	{ /* Sentinel. */ }
 };
 
-- 
2.43.0


