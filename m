Return-Path: <linux-pm+bounces-11523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0461A93EE1D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 09:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7381F24410
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 07:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72112D1E9;
	Mon, 29 Jul 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S8sTudYG"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8A12FF70;
	Mon, 29 Jul 2024 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236961; cv=none; b=kSlU7qyp/Og1xxogcuzEMqdmKUnBABJP+qEB40xtUPGWKN472ly8Khw3WefuQZhqEOTd4IpBmjylJecbHulPWfnSapsrFlXnZ7YmwPLxOQxrjl7JbJiEvWYeHnjWmF0ZNXZ8OYfAYc8bkFHMlVKIqUi1qMKhWMP0fQZqhVyRsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236961; c=relaxed/simple;
	bh=YTCSQwlakjV1yDkngsDhAcJOYk4NOtlZ8FWSyh+ya88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzPn1zhIfvvJMo8T6LgVYwPEuc4/ccUrsEnrZRzBTPRh+pAW9LcVqVoVUpGY5ojJ5yHwx9Xyh+JgujG8qyMXbYSLdcOtEUOxAZwNmNzYfA2GfXExnBjA+YH6M+xrjwr52hT4BZVL78F1e1QonAoB4M/E6MZ4dEMZmY0WHgaqrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S8sTudYG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236960; x=1753772960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YTCSQwlakjV1yDkngsDhAcJOYk4NOtlZ8FWSyh+ya88=;
  b=S8sTudYG7q0rppN7jEMftZSsvsYuzOOAwRNi1yH0iRTftejSb/i4ftFS
   swQ6dHXws3F+oW+Ocf7/Rcua6X0dnLqvSkjLuZri+YqoWv+moP5ZeNtxl
   L21sY9RW2KPQ9jcN2Y0IBSc9/xVXykzGEeLC8ytW3e0Qi3XkbMORh0eV1
   RbOBZv7SHIHjvribVaz+QHeP5jjnaC4o7x4laA/BXAZhsm3rK8j6rk46W
   Oqj+LzcFqwWwLfjEcu6nt/IQ950CC/E4RsMxaQKwfZiaFPih5kJwPGq9j
   U7p/2rarsAJlqd6NRmTD8bE7SquYaJUjYzv76MI6mFxJ0rEolj5bNx7kB
   g==;
X-CSE-ConnectionGUID: ysGf804zTF6Jk/9HVsTmhQ==
X-CSE-MsgGUID: qwP/+f9DQ1iDHa1VzIZ0IA==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="29796785"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:09:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:08:49 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:08:46 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v6 19/27] power: reset: at91-reset: add reset support for sam9x7 SoC
Date: Mon, 29 Jul 2024 12:38:43 +0530
Message-ID: <20240729070843.1991162-1-varshini.rajendran@microchip.com>
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

Add power reset support for SAM9X7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v6:

 - Updated Reviewed-by tag
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


