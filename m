Return-Path: <linux-pm+bounces-13376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C09693F7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29481285308
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DED1D54CC;
	Tue,  3 Sep 2024 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PHSb5u7A"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D31D54D2;
	Tue,  3 Sep 2024 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345815; cv=none; b=PcKq9k+Obj6RwaQ0BMavgawDz9X1WW47bJ2bHoXB+JFrTidBFEhdiZrRUZAR23kD/t0Gh83R8omVfdmKtNS8bFDofK15kH/OPHC/vbNwO9QJepMhw71kM+mAX5zJOql2Nogly7zHkssCnLeQdZkp7a2N3oG8tTohX29biCvu3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345815; c=relaxed/simple;
	bh=yUcQ0ZEyongp+UxISXeLzvhZd4sbwkjQc1piPm4hlnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RifMDFvkB9iHodSX8UKh6MCAOBLpGluSpNqgy1NpvZqw3nam50zwAeAuNDpvGZwWpj57uI3wen6UW4YKH5WZOCYqMBw5hKRT4a1xRfA33njFWdTb7K6Q8ajdxQ+Zf9/CqVxYa2XQSjVDjWg5BfOiz45tvBFJF4E19wVb2sVCAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PHSb5u7A; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345813; x=1756881813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUcQ0ZEyongp+UxISXeLzvhZd4sbwkjQc1piPm4hlnw=;
  b=PHSb5u7AvH3gSpoiekjTnNOqjrp6fv0YwbJINADWC3/hcSoyjFXADTm+
   TitxWcgRYtVdg3ciKs94f4OecFzHyP4aXYGSTFH8Doe6dq82nGNH0wtrx
   fnPRy7w3kSGKlp/bX0QL+Xp6K4Y3xGMXXLNaX9S25FW9bm5akTmvPmJnh
   lwkMaNINtGRiCW3vSYx6xUTIi5vW6PdHcyYuwURlagAldJ66Q1+qTh9n2
   7jbDoKdeS3PGD636+fq9zGqTBls/i1LTZiepV7aHbJTUxAiSf4lK0+J9c
   RLcoSSvzCegP2ciYRn74JupLHloXb2FK+dcqVvSkMy2XT7r3aWBIMVlDf
   w==;
X-CSE-ConnectionGUID: lHuJBXFVRKq7Mozyeyt1yw==
X-CSE-MsgGUID: /VwWH80ATamRRbsNGBBXvw==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31877377"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:43:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:43:03 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:43:00 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v7 05/12] power: reset: at91-poweroff: lookup for proper pmc dt node for sam9x7
Date: Tue, 3 Sep 2024 12:12:59 +0530
Message-ID: <20240903064259.49580-1-varshini.rajendran@microchip.com>
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

Use sam9x7 pmc's compatible to lookup for in the SHDWC driver.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
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


