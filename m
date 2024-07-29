Return-Path: <linux-pm+bounces-11522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851FB93EE1B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 09:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28C81C21555
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962612D210;
	Mon, 29 Jul 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n+JKt2WP"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8412CDA8;
	Mon, 29 Jul 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236947; cv=none; b=ZVBCqvscjHXYuG1kJOuMWBBu5QzGohc3ZimRaCFuIzkQhjFdDLIvsFVcH4NwLqoeZoF0gxOgnqcCxUGgKtzgmGjZMubARl/Y+Bg7m5xwIFmZEB4aQsYnYxwTQHJ1xptaVeedrUIp26WtATPksRSzfuIjByITE9to/nDq1L2A+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236947; c=relaxed/simple;
	bh=BzTEA3Dxexi8rFU4MfxSYMVtXqlXc7ZjRgdonvqmmtc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzrGsCQkQVFjwTLouU/OHTSCd3juKAdAD1xE1Sv2/cur465M2BPEZa+1NBPbfpKx1hLQdc6MyXu9oyGDPXQwsE002mUB/7evMyOLnxKklw6ULOQfo7we2fv2epl/locaHoBi6BykB/YNhh0LaJZSyV+nbzvn/kEkkbgLz0KDu98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n+JKt2WP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236946; x=1753772946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BzTEA3Dxexi8rFU4MfxSYMVtXqlXc7ZjRgdonvqmmtc=;
  b=n+JKt2WPLoZfZW1+CZi988vc9nvMfGYCgAdMID5lPoyU7tx/RgHuOd6E
   OfWEnMo9zEmyTNkAQGJtSPH+w9BVs2/8dxPc6g4sAGNlYK3rYpKPy//x3
   l2mz5v6SpzWwgKRhkKDb6m8q/b8ykvlviG+aAiqlUUJe5Yuk+nbctyVDT
   ueSlnXepkPEwByaMxptqIUo9jGzFESj2u+2/dWcs6jXUVTsM8izz28BWO
   cCWNsidZA4cnRnELRemnmudqRvE9X1e2v2x6U/OqVMOm+c1Bouj4z9+KI
   TS3Cql/m8zT8GJfY9GWeGuhn7Pdwpd8Me+4bjv93c5R9q1Hx1ASLsQCan
   Q==;
X-CSE-ConnectionGUID: /xcbkqlfTo+UjYKU1jzHkw==
X-CSE-MsgGUID: UkTiYLO8SHGFs+FxkMGR9Q==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30454161"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:09:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:08:42 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:08:39 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v6 18/27] power: reset: at91-poweroff: lookup for proper pmc dt node for sam9x7
Date: Mon, 29 Jul 2024 12:38:37 +0530
Message-ID: <20240729070837.1991113-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Use sam9x7 pmc's compatible to lookup for in the SHDWC driver.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v6:

 - Updated Reviewed-by tag
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 959ce0dbe91d..2121d7e74e12 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -326,6 +326,7 @@ static const struct of_device_id at91_pmc_ids[] = {
 	{ .compatible = "atmel,sama5d2-pmc" },
 	{ .compatible = "microchip,sam9x60-pmc" },
 	{ .compatible = "microchip,sama7g5-pmc" },
+	{ .compatible = "microchip,sam9x7-pmc" },
 	{ /* Sentinel. */ }
 };
 
-- 
2.25.1


