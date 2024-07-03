Return-Path: <linux-pm+bounces-10528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEAD9258A9
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 12:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ABC1C2384C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 10:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120BA17A5A7;
	Wed,  3 Jul 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tnKzEs+e"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E21741D0;
	Wed,  3 Jul 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002563; cv=none; b=oSiQnKpaR/8+wfCYarGUTSc4I5BGqsjj3wxl+vB/YXg1G1czyZ1PCMTEhMrEt+L9tljjD/tmql7Wu/D0miwG+2yFRWYU3T3VMz4eqtTGm+tWv8vQWlAMlYo8fFiTzdp+exOOcgrg+1ByHcdABTGPtZoTLZrX6RH9HXwtucJb+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002563; c=relaxed/simple;
	bh=f48C0WPPIxyQ/j5gPukOm6INa/bMMCH6vCkVjKj3zZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mN1ap4gQ4xuFk7IwpGtlb6N3Lw4ehLGLMIOWkFYphUI1bTJSx+QWZ5rzcM9PHGe9jq6kMETtFTm/KA4zmInhSmriBwvY/SiQFD3jR9ymfwzPz/4tZwIx4CZoqEqmreUiU4jajK1xlsfXamO7r8ukzXnbefz4AyUhedIRZf+VeU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tnKzEs+e; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002561; x=1751538561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f48C0WPPIxyQ/j5gPukOm6INa/bMMCH6vCkVjKj3zZA=;
  b=tnKzEs+essMT/1CTF/eXuiT5LovX2b+ZlgOWbVQHp0q9J2luxW7JPR/+
   I6rtkNh20rbJWbdqaxLnkCzj9pF7Xp2eCBeP1z7ksHvfXAxbnys5d/RWt
   p879ZxX4jxtgYBlrI5KE6YsIdYiTM5l4xVq1lvsBTYlTx0SOetGfsK0gs
   YkmWi3hgtaZb+M2YNoiT9JFWVLjIq+2isxMhb6RItTzH4JK0bsczd44KK
   cnuyewH5Ki3aUWNvi0Wa89UpfFxLifUYHk8P4Gk+sQ2X0WZVbwGIPd7xp
   pvcB6Xy0OfZa+pZFI++muuTo36EBW0d+1XB8ipbxnCEAHCU/aIVuQZZno
   g==;
X-CSE-ConnectionGUID: fwe4YiXZSfmRHS8m80mboA==
X-CSE-MsgGUID: ubwmUnY4S2OAISBYSf6Dnw==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="31414918"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:29:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:28:54 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:28:52 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v5 20/27] power: reset: at91-reset: add sdhwc support for sam9x7 SoC
Date: Wed, 3 Jul 2024 15:58:49 +0530
Message-ID: <20240703102849.196305-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703102011.193343-1-varshini.rajendran@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
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


