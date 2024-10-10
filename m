Return-Path: <linux-pm+bounces-15450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9046998586
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 14:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EFB1C23D80
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC791C3F34;
	Thu, 10 Oct 2024 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GkEh6PcB"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F71C32E1;
	Thu, 10 Oct 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561892; cv=none; b=aCsNTGV8VamME0zgKr9sZI1PmEvdWfKo39tRpkFc0gQlW7plyvh1mNCT0M5y6uzL/yDSpl1aDla2/DgVp7tOwzOVoG/ae7/Yfwkp2U8LpnzPfTxaQI7frT2xs5ig9ppqj+N5zkCOBvK/dOT35EmBzqp68v4WwRKsPMPZrMZ1vTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561892; c=relaxed/simple;
	bh=yUcQ0ZEyongp+UxISXeLzvhZd4sbwkjQc1piPm4hlnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVCegw9OGAjb9XoerkceXXesVJh/1GRm04SKtzdO74Dsvg1zEptW/aCRcgOdaECLGudYgsfsL28FHpGPrNb+ql4/bq6T9DaWv3CThN2u+LzRJJreOsnxwFYtCMZUxYYUxUnp02d/S0e5K80wRlyDMkApyMVynq3otUpfkgqZ2Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GkEh6PcB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728561890; x=1760097890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUcQ0ZEyongp+UxISXeLzvhZd4sbwkjQc1piPm4hlnw=;
  b=GkEh6PcBi9x71wFUIkTlB5ONOzpguZ5FzvwxEBj3jBEFcc0DsEyIYZA9
   RFJtRsFIXdqQxh2446zO/xlgrgcIO83kCMESQ/e7mmadqoRusU8oaOlhD
   D0djJ4/4irRHtWQ6m1y90fYgQ8kIiAylct9xLgFA5UEg9MVjuG9rAv9xW
   Ct/VefemdqeOrhBhfy08oPnd4J1LkgN6ItVJr+13UAyfQOfnHE1pF8JEo
   DEwEwMurmoJlGYnFplQScWH5gzbGnsLRHbi7wy6udzak9Ao64Yj0cm1i3
   ybDAUxsD3zjcAivzWh/yKwC1HYQdOz3qZ4t22sR0vDBTB++BlbrVtg1wN
   w==;
X-CSE-ConnectionGUID: ZxWAeWSCQ2SoQSSTOPbs1w==
X-CSE-MsgGUID: WomuFcCBQmyriIPh3L7eiQ==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="36169761"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 05:04:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 05:04:09 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 05:04:06 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v8 2/9] power: reset: at91-poweroff: lookup for proper pmc dt node for sam9x7
Date: Thu, 10 Oct 2024 17:34:04 +0530
Message-ID: <20241010120404.92893-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241010120142.92057-1-varshini.rajendran@microchip.com>
References: <20241010120142.92057-1-varshini.rajendran@microchip.com>
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


