Return-Path: <linux-pm+bounces-22672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40083A3FC6A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBF419C6123
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3421B1AC;
	Fri, 21 Feb 2025 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyaLA0qG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA621B180;
	Fri, 21 Feb 2025 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156843; cv=none; b=KYErbd7+MybVRuvCN1nrAlHatXHMNIgXaO4eLyPMiGf0UY2RIL/3tMcBCHBSbaFMnSoWCZ+it4jOLRncCIvlyOYosqNE91ftoRE0Yo++rM0R1rnX/deoW0GzSOOD/9SbFyGTmmNn0wcaSo5i4dmULbtLCJjDRoRWQfTHj01T+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156843; c=relaxed/simple;
	bh=e7a2cCCwX7XNrpGn1XdJxR3IeQTxmfvf2zp8jE434LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQIgprK4+risd4hCDRZAjaDH/uPU45MfX9evHzCSduFEPdX31bbMZ41XA+HeuWh7A04UyD0KcGFwvpEQMY8xPReCXSOUcbD1jN60Lr2QNO3ye5yAJt3S9qe2eisTo0VsBcAl/lKtoYKy9xnp1bLc9rxVVBIOyXUDHbUoDVEQfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyaLA0qG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156842; x=1771692842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e7a2cCCwX7XNrpGn1XdJxR3IeQTxmfvf2zp8jE434LA=;
  b=DyaLA0qGPRX5F1e6+BUzZ38Fj0qLF/cdc5JKqfFqw0cwKx/2UZlLgE18
   gjKf4DyfJxpMVz5Z6brmSpedWjr7LcMnC0vWjWLnF7y9AYUUIhjUAanby
   2ublj2jPQ07G6K/47WU7gWrvzGSwDraPi0FKVGYWfLtdmiB3VnJHkToEr
   mJb8hYlFkJ8XMbTD2AB9RQYAph9qtyV94soSFTiY4EeHF/cfrJZ/ShLCO
   BoKAe2J4a/QuMomnKpvqik37qZKqbtBLeniGuBohfzs1CX6wgpGyZprTQ
   +bFNCzD/kKwGGSpC2J8esZk7zR/QTq/bcqZqRz9MLTam2bv8q69uDxKSO
   Q==;
X-CSE-ConnectionGUID: XwqY1Q3ESh6EeIqgTHCmAA==
X-CSE-MsgGUID: 4/9ffXL8Q4OX6fApiJJu8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41186857"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41186857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:54:01 -0800
X-CSE-ConnectionGUID: 4Rd8SFYeRRyfUbmmMj/FNw==
X-CSE-MsgGUID: s+TfBlrWTh2W26IAdqBIEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540619"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:53:57 -0800
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
Subject: [PATCH v1 04/13] ASoC: uda1380: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:24 +0530
Message-Id: <20250221165333.2780888-5-raag.jadav@intel.com>
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
 sound/soc/codecs/uda1380.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 4f8fdd574585..c179d865b938 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -766,10 +766,8 @@ static int uda1380_i2c_probe(struct i2c_client *i2c)
 			return ret;
 	}
 
-	uda1380->reg_cache = devm_kmemdup(&i2c->dev,
-					uda1380_reg,
-					ARRAY_SIZE(uda1380_reg) * sizeof(u16),
-					GFP_KERNEL);
+	uda1380->reg_cache = devm_kmemdup_array(&i2c->dev, uda1380_reg, ARRAY_SIZE(uda1380_reg),
+						sizeof(uda1380_reg[0]), GFP_KERNEL);
 	if (!uda1380->reg_cache)
 		return -ENOMEM;
 
-- 
2.34.1


