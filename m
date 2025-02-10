Return-Path: <linux-pm+bounces-21748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970AA2FBC9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061D73A5688
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27279257457;
	Mon, 10 Feb 2025 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p53bhYCY"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A912512D1;
	Mon, 10 Feb 2025 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222062; cv=none; b=lGyWUzCvWd+fhxSDDlj8sPwYy9RN0lNtNB4H4S9iqaABrvsrLn4YhcggMYYneq7lSz8gXjHMat1Y+NexTeSdYPxd1BriW5zNMfgkT110gszHdevpY0yJckq2ymulnGfnqSKQrLn8zXPQEK3ysnaqqz5Abx2/Vdwgr+pVjFt5pSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222062; c=relaxed/simple;
	bh=Q6EhuaD18bf95yOzyUc9NiJbUcTYlA0vWWENLIJPl9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVEpw/z9+Y8lVECxhsnh3Ll/CHY1KsUjtrCMDowB7VaHWHAy7H16jTnZYiShGe4LHAkIH+BcsXj1w0psB2+wnhnxXwXh8VXbgJWXKV9XdbhA6NeT2hOJTJzrc1z28uwqCrWAZAyotMIsRnEpFOUXSTQ/7Qe59MG1KqiqabtMrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p53bhYCY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739222060; x=1770758060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q6EhuaD18bf95yOzyUc9NiJbUcTYlA0vWWENLIJPl9s=;
  b=p53bhYCY4isZxmeqhVY3rbD6Vw21Fm3Uy7QB3S4JOot9At/3hbVKb+Px
   Q4zmTRoJun6IkyXTWz8RwfwnrOCZNc0tQqsTJ0rKehU+adqhjT+qBd4MR
   j44HJwqbYUQXTUIf8UtI3+6fqKqzpm5aoy3ZpjluhBEq1K3SxP01W+cP4
   DMdT/a+8FZPG5YmVNCRKRVv5R0w77C6TwP3WPdnGHLywEMZdojUp84qun
   lBubRNJibZ/t6EFNnCwRhOFPcfsuOuT6fUOsfujminM0T9myqKiPNr3zv
   8az1gRG/DYa4M6ue66VGO5nfcwft0UP6dWrWG6Swok864N8faxNxaG0iV
   Q==;
X-CSE-ConnectionGUID: AYqW9AG9RbOJ2Xf8Pt97Yw==
X-CSE-MsgGUID: TtqIL6VfTqq+6rCYBPi7Ew==
X-IronPort-AV: E=Sophos;i="6.13,275,1732604400"; 
   d="scan'208";a="205027991"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2025 14:14:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Feb 2025 14:13:47 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 10 Feb 2025 14:13:47 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<p.zabel@pengutronix.de>
CC: <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rtc@vger.kernel.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 13/15] power: reset: at91-sama5d2_shdwc: Add sama7d65 PMC
Date: Mon, 10 Feb 2025 14:13:13 -0700
Message-ID: <e3bde200e4b8efe69656f1ecc9e8e7c5c6f631a5.1739221064.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739221064.git.Ryan.Wanner@microchip.com>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
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
index edb0df86aff45..0cb7fe9f25a07 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -326,6 +326,7 @@ static const struct of_device_id at91_pmc_ids[] = {
 	{ .compatible = "atmel,sama5d2-pmc" },
 	{ .compatible = "microchip,sam9x60-pmc" },
 	{ .compatible = "microchip,sama7g5-pmc" },
+	{ .compatible = "microchip,sama7d65-pmc" },
 	{ /* Sentinel. */ }
 };
 
-- 
2.43.0


