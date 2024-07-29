Return-Path: <linux-pm+bounces-11524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2293EE1E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 09:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2BF1C2194C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 07:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9864C131E38;
	Mon, 29 Jul 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="h0T2uBxj"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D73D12FF88;
	Mon, 29 Jul 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236962; cv=none; b=o9Rz/GaktTzi9NYQsr+PQCD1FbZGoaIQRlCa1iK+6Fn9KLkuTNrqDksgkAN6UNSQcPwTUQhMK0MsvTQhF5b10q6821yA+MsPHIZuZnn/9AwzkahXGWCcuqO0UaLbOFhAyxARlAY6id6oVvC39lX7bLTO7ZFJzyMvmi5jjGElYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236962; c=relaxed/simple;
	bh=iJBr3M8Ba+68qK1AqhukgdXo70chhq/RepYao7oCYFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNVNmfy8xm6LlHu62VoHdUD86MwTioSmFTDwPBVTYgJZLbIqK6FlOgQsJ3AEpacVuBofMc3HhXeGXrI50tS/41qI1OEi7bQTQrT8I4v7qEBLEkTUs7TUmzcHfCB+7bnSELY8xRaX15Nlc8SDglY0Gkw/uopPdIZhIdBsY2ewk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=h0T2uBxj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236961; x=1753772961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iJBr3M8Ba+68qK1AqhukgdXo70chhq/RepYao7oCYFw=;
  b=h0T2uBxjTRVuOBGnq2QA42pcHLWRjk+5rThn3yfsS65QnDXMVHQIucQM
   JyRWTfia4Nmou+C7yIh1nHsnzsV59sneQHCCWJVVqKdXi5WpNpf5B7luA
   75qsG/vPcjEB0+hozx7phu/nVk+1DUCHZfFxGj9LPXYHeX0FYCBeiiVX3
   R3krrU8bKyHNh7tJJNEDT7um8Re5S5JHm/F2N4H3X0BP31wYFzOj/HIrV
   b8Ono1MSIw2V7k/raP14BIMjN+GS80jt/N9jpv+D8KgE0aP+W4JRJOnCK
   Z/krB7UrlRTjGjDv42LfSk4yz0YSv9HDsnMkhwm3dt8H6CwA7o735qa+y
   g==;
X-CSE-ConnectionGUID: o1mEAA2WRF+mZwSZKkI/oQ==
X-CSE-MsgGUID: 2BZZWdVQTsOrDPd2py9XWA==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="197213997"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:09:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:08:59 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:08:57 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v6 20/27] power: reset: at91-reset: add sdhwc support for sam9x7 SoC
Date: Mon, 29 Jul 2024 12:38:49 +0530
Message-ID: <20240729070849.1991220-1-varshini.rajendran@microchip.com>
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

Add shutdown controller support for SAM9X7 SoC.

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


