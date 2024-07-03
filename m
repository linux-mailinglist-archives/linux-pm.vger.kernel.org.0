Return-Path: <linux-pm+bounces-10525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA43D9258AD
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 12:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44EBB2990B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0E316C6A8;
	Wed,  3 Jul 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J6bOeN93"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293B16B3A1;
	Wed,  3 Jul 2024 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002552; cv=none; b=Ksd68LUGShiV/gVe7CkKI1PbmeX4F/c6khMYhxA4jfKHCIKqG/a3Vk6twj9gcnTTXGc77apLl5CMJwHR907a0C5Sgx+Ow0g9SZ0AP3HL5V0PMBtY3vJ+qOk4Et2IZPErsxP7ME8Idb0jkXXTD1VHf30qfUgSIfQGftSpxaBlUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002552; c=relaxed/simple;
	bh=OQ3DquxxckfkYxfIhdDEQe/+9PiGWGIXHlCGBn7IixI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBJ9HyjbDlWFWwUOtzqQ9JiOwEmwV90EIP14k/5z01SP8iLc+y4awqF2MFd3rRCl+lBsz/zLV6Ik+MJ//tRz3rFgrgkQblwKSBs06I5vZyHHUbTs6ZkzRQxTgdQaLoC4f6wzLEND30kj9fTKju4Gt2Jq9ZklRc8CrNT9XOc7WPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J6bOeN93; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002550; x=1751538550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OQ3DquxxckfkYxfIhdDEQe/+9PiGWGIXHlCGBn7IixI=;
  b=J6bOeN93MgSTuX67wLO+e+PqSFMobynPxVfxGHTyv316Cmv6a+EWnlnf
   bMfalvzc0izmm9jPxzG7dlaYwQg3v3QCCcupI+55mIt5N/+0y9hZ76KXI
   5gEIHDPfpmkxtcvN89/DEEi8hR/fQwB+v4H26U8pc9/88a+OdomvYOIeE
   hLeakidnNXTXVK11MrjhQ4eZAe+1UXFoETMJwMuaX7+Uwf0QOaCkYRdA6
   S7yqbO6bx72Wl1D4/bhnjAcdgV7bAVeEA5/2LJidZFNXb/xuEfI1LLtq5
   n42zWmQptvhrYmg+ef9DGpCu7fUHD68oWf4v04tI1MyMPhxDvnu+D4qTc
   g==;
X-CSE-ConnectionGUID: n3BwhiapRjCNKuOiIdXemA==
X-CSE-MsgGUID: NmNsCLHURH2IguhwouDY+w==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="31414906"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:29:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:28:49 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:28:46 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v5 19/27] power: reset: at91-reset: add reset support for sam9x7 SoC
Date: Wed, 3 Jul 2024 15:58:43 +0530
Message-ID: <20240703102843.196257-1-varshini.rajendran@microchip.com>
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

Add power reset support for SAM9X7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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


