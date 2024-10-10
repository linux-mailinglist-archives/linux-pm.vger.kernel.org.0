Return-Path: <linux-pm+bounces-15451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A1998589
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 14:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5EB1F22A24
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A271C4609;
	Thu, 10 Oct 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tPHQSt0W"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B531C3F3C;
	Thu, 10 Oct 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561901; cv=none; b=LXvWyszRct0xYGLmcwyvlLyni0h8zxaQr/n4D0IMPuOGY1BrkxILTgauZ0oSFwzGIm3znVikucNYxCsH+ufgL6U2+3PLAXk5+VEzg1sGWt0tAjTABGY6pkGBToopy0yH162riz7I9apFr/t4Y+ntzGZ2OM8whm5T1+RAuAKAHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561901; c=relaxed/simple;
	bh=PYY7HbWS2/iy344q/VmYu01+VTW/EtBapdxiFaa8M/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4D/UIm47nJWwt9YEoOuBRmTa8HAlYg3SHNWBqYc3Bdeqac7dybfZ+ddwizHzRTm6lMnqu4WZt/HZg9XVoPTzG6YEAwpKa2/d0i7wt0iRVoy4JxEWoirhjXRTDo6QVEqMoV/B19f6xqUzCpbvijhqYJjXCCIXpodskPUlDzVt8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tPHQSt0W; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728561899; x=1760097899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PYY7HbWS2/iy344q/VmYu01+VTW/EtBapdxiFaa8M/o=;
  b=tPHQSt0W7f9jrdcZzyf/oxD/MJ9IC/GF7+7VFE9ny5MgdEXFKvu1Vvce
   OpghJPRdpnBirv37wjuW5dGfxbrqkrdjLD2rHG0Xxefbec/TLuNCQw7cV
   sxVYEizJKNUIYnuHou8fnryJhVGaqkTt2MancJICQdJLd5nXcJt01eDY8
   KHVm63cadzfAMX6UGxQ5fiBIAQ06cn7IvBzkWg5CKxLDnhVZPxiNmOtcj
   QuesevXpqDpViEsI8nn6plWoBQrZJs8j2NDR/TY3UE76nxE1bvj36FG5X
   UJbo25Mhflop4UEaGAdf6/FuzrnxNnqXhPfUX+lVneiz4NI+KImNxDVnc
   g==;
X-CSE-ConnectionGUID: gR3ImswTTSW4aIPxRveY+Q==
X-CSE-MsgGUID: wqqq0m9TRPyaqBPo0W+7PA==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="32664372"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 05:04:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 05:04:18 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 05:04:16 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v8 4/9] power: reset: at91-reset: add sdhwc support for sam9x7 SoC
Date: Thu, 10 Oct 2024 17:34:14 +0530
Message-ID: <20241010120414.92993-1-varshini.rajendran@microchip.com>
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

Add shutdown controller support for SAM9X7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 0c7cf3ef64b4..960717eed17e 100644
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


