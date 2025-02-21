Return-Path: <linux-pm+bounces-22679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB0A3FC72
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187F31692AA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE8A2253BC;
	Fri, 21 Feb 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fu4n1qTn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86B224AEE;
	Fri, 21 Feb 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156879; cv=none; b=Fzp7yepBvwYwCuyMRq0N9dNfwFv0PlyljosUm1QwohvJsdFxY9BanI80qhhRGK6nB6SVL75Wwwphe62ZYlOFLZ6e4mDAge6btOGWXmy6KekUt34T9SfvKBSFtyWiFS8aG459VtbhG4MoUnuS1q8yJDioTHURohdaQAeN9hEDjRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156879; c=relaxed/simple;
	bh=ed2DCzqGuQ7oYA4KGyuQboEdsEgBubtYVQfuHacbSo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FoGC515vXijC6UbaG82eks7HlCB8pFFlvPx9bS82Um1QgulqlYK4a5iWOV85hD5868A6SghfPJD0j2Yw1aJw1d+WSml1jADtuJ8hrqoXkXSw68e0WMNrskl2EY9nSs3cwARJSG3JQzRlqWcfcMuETU/0c2B10cICdo76pZKdz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fu4n1qTn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156877; x=1771692877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ed2DCzqGuQ7oYA4KGyuQboEdsEgBubtYVQfuHacbSo0=;
  b=Fu4n1qTnVu4Pbp9w3A/RKz72iouBn4FCSL+ThpxX5tsaUllk0+HoNBgz
   tPRX0zjrlfrEH2LjmL13901vQqPGujkUeJst63SZE8/iXc8P5IJBPRxLV
   m6e6+4j6LTA9Oy1n7DVUEKIXb7dWPmLRQ4V+tApzZSviAwEKptvuUdxge
   /5yFjtDqEeD+fOksBXo1mO6QUCtzO/s//V6xeq/fgGvTV3FkcaVHLhml5
   N9swYGfBq3G65rLhJK7YgYpisgTpu/X0PO6WnE3lu/gu9wGL3shBSw1iM
   4xFYch7XEPvc1Wn03M2jCX6WHWvnwV02aLnm5tcX1Oe4lOBXKMs42Liya
   A==;
X-CSE-ConnectionGUID: T3hxf9DFRUqMaRfn0we5tg==
X-CSE-MsgGUID: /mo8YXPtT2SOMy4XD147SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41187027"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41187027"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:54:37 -0800
X-CSE-ConnectionGUID: MPoog1KgQ2qkbS/wt55gJA==
X-CSE-MsgGUID: /ovU0+hCQTSflOLcEbQCLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540684"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:54:32 -0800
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
Subject: [PATCH v1 11/13] media: atmel-isi: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:31 +0530
Message-Id: <20250221165333.2780888-12-raag.jadav@intel.com>
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
 drivers/media/platform/atmel/atmel-isi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index 0d1c39347529..7d8bec46af89 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -1072,16 +1072,12 @@ static int isi_formats_init(struct atmel_isi *isi)
 		return -ENXIO;
 
 	isi->num_user_formats = num_fmts;
-	isi->user_formats = devm_kcalloc(isi->dev,
-					 num_fmts, sizeof(struct isi_format *),
-					 GFP_KERNEL);
+	isi->user_formats = devm_kmemdup_array(isi->dev, isi_fmts, num_fmts,
+					       sizeof(isi_fmts[0]), GFP_KERNEL);
 	if (!isi->user_formats)
 		return -ENOMEM;
 
-	memcpy(isi->user_formats, isi_fmts,
-	       num_fmts * sizeof(struct isi_format *));
 	isi->current_fmt = isi->user_formats[0];
-
 	return 0;
 }
 
-- 
2.34.1


