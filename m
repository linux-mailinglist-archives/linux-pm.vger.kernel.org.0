Return-Path: <linux-pm+bounces-23101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848E9A483C9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A6A3B4CB9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D926D5D2;
	Thu, 27 Feb 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c+8FzSm4"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C93231A4D;
	Thu, 27 Feb 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671590; cv=none; b=oybIa0WJwdYNfIMwLQVrIExvNSQGC6EOn7VxRSTUJYKlRVlqVmpTqRssxXqZ/YOVDq1ql0pp7OCFB+uTkzII8voprQm6DpnhBhM6Fxa5dfAZ0gCpH8JQ/k4uWzSL8j5Anx++UwEGh1shZcdJ5V1PSii0AK1uyfD1p+v3u8bqN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671590; c=relaxed/simple;
	bh=gq8reH3mD7tgB1Z9GKDSj1VoHFIvdhBe1awqmCVMNV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpRgOAJd3KpffGZsRT1RPoLp0ZaQUPFi4DsPmd7zfVCm9aHahL9iYeblk38DlYwY7PuaFmUdVB7axTe2l5gr7Ka668on0gDqFGnOodErtkEbnmjMmCel7mtWZRCFhU9BAHYnjuvhwS9eT0MIQeOBRxpZmsg6CcA0inQdoih2CmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c+8FzSm4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740671588; x=1772207588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gq8reH3mD7tgB1Z9GKDSj1VoHFIvdhBe1awqmCVMNV0=;
  b=c+8FzSm4mFMOZ5wILPRtfnh7B0+fIBYka033Nna2Av/00Z6tQFHixsxf
   SdIkfdiNp90uqH+dp+u+E3SwLwhdUS78k8d98jLZOhw5M+ywxNdQmziuc
   A9ggm/xrzN5Q5oVOZOnC3kxgcAUaJOoRboacqAVHwxqwzuPYENQY1ZmXn
   +kJeSWg3jUcP39FHegZG6fJOiulc5Bb/vgo1g2+AM4pMKCDSIZrhpTbhc
   a6xaywY3PvM72Vr5CAYZE5irMgE4uNi7ttul4/H6dB8CjaEgq7jyibas4
   OrzxjD8G+abQqqEBxsedUcLLtBocHb7pEgCZ5Byg3iScBshm+rVmydVNn
   Q==;
X-CSE-ConnectionGUID: xBkIAngZQVSwQhIMCQbtUA==
X-CSE-MsgGUID: WsC52RyHS3+SAnTAZuhWxQ==
X-IronPort-AV: E=Sophos;i="6.13,320,1732604400"; 
   d="scan'208";a="38638177"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2025 08:52:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 08:52:46 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 08:52:46 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 13/21] power: reset: at91-sama5d2_shdwc: Add sama7d65 PMC
Date: Thu, 27 Feb 2025 08:52:00 -0700
Message-ID: <c5fa1d88a072d79db4f1a6b99ad69632a83e8f8d.1740671156.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740671156.git.Ryan.Wanner@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
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
index c2801bd6384d..e9fe08ee3812 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -327,6 +327,7 @@ static const struct of_device_id at91_pmc_ids[] = {
 	{ .compatible = "microchip,sam9x60-pmc" },
 	{ .compatible = "microchip,sama7g5-pmc" },
 	{ .compatible = "microchip,sam9x7-pmc" },
+	{ .compatible = "microchip,sama7d65-pmc" },
 	{ /* Sentinel. */ }
 };
 
-- 
2.43.0


