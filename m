Return-Path: <linux-pm+bounces-22680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C21A3FC98
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4A5189128E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570822688B;
	Fri, 21 Feb 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmRfNztR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC694216389;
	Fri, 21 Feb 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156884; cv=none; b=ukUf8449rXnxs/Lh3UUSRAqv6woU15dlFgPAHGDmYwBlX2U7gqIbniLy6HilrEAVlwaiecRdH3qBoJ5gUU2rt1VQTm6Y5qTZo99e7UDoWRxgK08N4UskvUW9vcOT7eriiGWJ0dP4Oj/OLcZnQW8zb3r3uX01+8CXAcRkpAcrcQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156884; c=relaxed/simple;
	bh=B3xrc/pLQJ5ss49IeFjXDa74Yu0HGjjmnZRSh6JToXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8bx9DqTfBf1l/Z4OwI3DL7zcZ6BR1yvb27o3YRifi4MWTRxWEOJ8FZZlv3bjo09OhByy0PEKz8nlV1vHKfbKF43A61Gyaa4u1+0zfRyM8M37wx/TeceQiipxgN+i+nD6vZkBGVN26wO+5m37UToOIZnBAwhXQDb2DUA8OJBN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmRfNztR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156882; x=1771692882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B3xrc/pLQJ5ss49IeFjXDa74Yu0HGjjmnZRSh6JToXk=;
  b=cmRfNztRFpHXpXhVxMaEvujG/ZI7Io/uDWntQK7NzlDRDsgqnQ9DAYMH
   lCKR1BLlRXJznujXTbUFnOki66ACSwpbALOsFXdpJJhmF8WdRnLamsKMS
   tq5VbB5D88jaxjRDWEAHwwLO5qbakb+jYuEpNuoXne19dOR7sNBFNtZeK
   MSmtF3TTKonLQUPhyIdaMIyzsCle3BqLi/xKErJURrrr9fq95LCOD+XHo
   cKw1/J9holsu7PY3AtAhHxF0fczOQAWmxt+3wZV2BNvN8JVC1qmic0lIl
   GBKOVZ9/NOOUngd+B1rpU0RdwpgKpeWt4YfzeMhtco6vg6MNkYZF4YSBD
   Q==;
X-CSE-ConnectionGUID: wjah4XRBT2a3YPD1uT/ZYQ==
X-CSE-MsgGUID: IiQR1TBGSiyYCabxSCFkAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41187042"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41187042"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:54:42 -0800
X-CSE-ConnectionGUID: N3IHa7gFRbOZS2y5wnG/ZA==
X-CSE-MsgGUID: TGeqnU0SRQGFcrPePoGduA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540707"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:54:37 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	deller@gmx.de,
	andriy.shevchenko@linux.intel.com,
	sre@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	jdmason@kudzu.us,
	fancer.lancer@gmail.com
Cc: linux-sound@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 12/13] media: stm32-dcmi: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:32 +0530
Message-Id: <20250221165333.2780888-13-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221165333.2780888-1-raag.jadav@intel.com>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() and while at it, make the size robust
against type changes.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/media/platform/st/stm32/stm32-dcmi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
index 9b699ee2b1e0..eedc15b30edc 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
@@ -1682,18 +1682,14 @@ static int dcmi_formats_init(struct stm32_dcmi *dcmi)
 		return -ENXIO;
 
 	dcmi->num_of_sd_formats = num_fmts;
-	dcmi->sd_formats = devm_kcalloc(dcmi->dev,
-					num_fmts, sizeof(struct dcmi_format *),
-					GFP_KERNEL);
+	dcmi->sd_formats = devm_kmemdup_array(dcmi->dev, sd_fmts, num_fmts,
+					      sizeof(sd_fmts[0]), GFP_KERNEL);
 	if (!dcmi->sd_formats) {
 		dev_err(dcmi->dev, "Could not allocate memory\n");
 		return -ENOMEM;
 	}
 
-	memcpy(dcmi->sd_formats, sd_fmts,
-	       num_fmts * sizeof(struct dcmi_format *));
 	dcmi->sd_format = dcmi->sd_formats[0];
-
 	return 0;
 }
 
-- 
2.34.1


