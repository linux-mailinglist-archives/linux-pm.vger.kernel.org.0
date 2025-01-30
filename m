Return-Path: <linux-pm+bounces-21138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25E2A2330B
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A00164C1E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218561F03E9;
	Thu, 30 Jan 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kZBp0Tx4"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B51F03CB;
	Thu, 30 Jan 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258576; cv=none; b=YPZovOyTnMmmizJn+JTfkZAIu99bkKzcANrY6SE1GvN9PwWiwRrrdtyrxpeOIrBU4n/KULy08lraOCLBpuFxSaqGIjo5NAhfjyyIbMgzmNsMy7DjipfZeJisrNcqcfr/DFzntcIoUqC7kfVfLFfQ9JkWVc+E92CUGa4WyEM98mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258576; c=relaxed/simple;
	bh=saqK4kIsZxI+5DQ85cuDmpYxXTWmAMmJjllcEfKrsSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+oLKzS0cuM1fT+DMLGJJ/sovvJIEHRlCy+TpTYf1g2BMLu6OQWM6nSMcmx/xrUvoZeOBeDdc9nR6m0y4oG7uFLchnG+gjJtiitHZ5kdK9srPhHrBeInbSlSpuDSZDklFYdkMl5RE8FptRGW9na3lpSNy1ExOO6/zBvc9pxljKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kZBp0Tx4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738258574; x=1769794574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=saqK4kIsZxI+5DQ85cuDmpYxXTWmAMmJjllcEfKrsSY=;
  b=kZBp0Tx4VLqnJNdhDld1kdReCcjv+59xdrGnDdS8D9blgELdik1JV12A
   y9KDgUxzHlMgN2o/O63JO1SaUsf9MOIhs/yWlPrv+x1jJb0irFPppgkwG
   n3pJGv6aBePiz8oEX0UT9zF0ekMZK8Jtdoirx58/kX1Z2mgD/N3d12Saj
   kN8K1q05vupUYebpPqz7f6zrEaXpKZiX4IUnIF/iYLMjdRnHP1G76jfGD
   +U7jOEQ1gIfj3/K0IqiIINYRo2t83lGuJxiGDtkOQhl6ozxs2ugPtlF7Y
   4eWz61iuDdyh5n/mD5f6gM1Mj9H2hTTjI4fr/PBaCGzmZlekZ3hti2AGm
   A==;
X-CSE-ConnectionGUID: 7iQ0c/B2QHylE8DKLR4q+g==
X-CSE-MsgGUID: ehYY8ZpbQe2lcmyKveAkSA==
X-IronPort-AV: E=Sophos;i="6.13,246,1732604400"; 
   d="scan'208";a="41090048"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2025 10:36:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
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
Subject: [PATCH 12/16] ARM: at91: PM: Add Backup mode for SAMA7D65
Date: Thu, 30 Jan 2025 10:33:52 -0700
Message-ID: <c627ef4928eeec72e63406adef31bd740ad18106.1738257860.git.Ryan.Wanner@microchip.com>
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

Add config check that enables Backup mode for SAMA7D65 SoC.

Add SHDWC_SR read to clear the status bits once finished exiting low
power modes. This is only for SAMA7D65 SoCs.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/mach-at91/pm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index a8cd1300a8f33..5e458254e1f1c 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -706,6 +706,9 @@ static int at91_pm_enter(suspend_state_t state)
 static void at91_pm_end(void)
 {
 	at91_pm_config_ws(soc_pm.data.mode, false);
+
+	if (IS_ENABLED(CONFIG_SOC_SAMA7D65))
+		readl(soc_pm.data.shdwc + 0x08);
 }
 
 
@@ -1064,7 +1067,8 @@ static int __init at91_pm_backup_init(void)
 	int ret = -ENODEV, located = 0;
 
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2) &&
-	    !IS_ENABLED(CONFIG_SOC_SAMA7G5))
+	    !IS_ENABLED(CONFIG_SOC_SAMA7G5) &&
+	    !IS_ENABLED(CONFIG_SOC_SAMA7D65))
 		return -EPERM;
 
 	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))
-- 
2.43.0


