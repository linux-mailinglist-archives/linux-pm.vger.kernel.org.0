Return-Path: <linux-pm+bounces-22678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401A4A3FC56
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FE07A5455
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED41223716;
	Fri, 21 Feb 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neAB8J0D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78067223702;
	Fri, 21 Feb 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156877; cv=none; b=Rc/7EgbslLPII9jgJwFs/9gjHW+baihO9eL+iNAPPxeYn2904+QAi8HSH8SHjZ3RDwnO98yF4rBBFFZb+vQjakBMqEcH3vj9UQZUKYbFgyCIUnMwFzP4U4fi1u2s6CT7EhCRVZC3ta4QetELGL+8dvnv/4bQxQY9COhz8vCdENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156877; c=relaxed/simple;
	bh=LiGS3+6W4VSmf7HQmdSuxLihLsGhBnmgTm1eWOTnPMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgKlqebm748qS6wqzfZxdf7XI+mQc8QTo82J3DYPxj6w6TCmmLlsxsPUS094X4IoYR28XN86OH++YenA2ZQCgb6xkahQP8L8wx6OqyIh5BQ9zlHYACrngSqOAzkTU3ls7La2+eX15QS0sNxcKZeckRt4QWs6+qs3o4Sdbc1rHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neAB8J0D; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156872; x=1771692872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LiGS3+6W4VSmf7HQmdSuxLihLsGhBnmgTm1eWOTnPMo=;
  b=neAB8J0D5Vqto4NAsxYCzLcLXQIgXX7s7A49DAZC5boPorAImvGU6syE
   hJZRAVj5tHjgeoXLxDibXiJ1D/DzQ8vHyLnNIy2yFOLyeXu84MX1vhkQe
   v8wnzENIEDaP5lp/wVVKuXa6zNEnkwr3I9G+C/GlGzvZKK1TrfV3p707M
   hRtyMBb15K8OG1qomnQ43W5UAM9vGQNzTyHQWxS5RJQP6ubMZkyL6Lzx/
   zSmXl1ERUNB8wXFcdlJsr5Ftj8OW2XqdfC1Q+VCRtxuIRJr3wI5PPnb5T
   qhiO1a/eygXZn0xlyyH/wQ5mYN0HZJyFzF8MCmTjNc06DQ3TKnOoAXuap
   Q==;
X-CSE-ConnectionGUID: N+iX/qAmQAqCzm2+Nvzljg==
X-CSE-MsgGUID: XGQyQ7YQQcaG5TDCLgU4RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41187011"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41187011"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:54:32 -0800
X-CSE-ConnectionGUID: UQNDZ6jDTz6OrrNvOwAsqw==
X-CSE-MsgGUID: KS45uG5yS42oczuMKzA0/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540662"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:54:27 -0800
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
Subject: [PATCH v1 10/13] regulator: cros-ec: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:30 +0530
Message-Id: <20250221165333.2780888-11-raag.jadav@intel.com>
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
 drivers/regulator/cros-ec-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index fb9643ed7a49..fb0767b33a36 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -138,8 +138,8 @@ static int cros_ec_regulator_init_info(struct device *dev,
 	data->num_voltages =
 		min_t(u16, ARRAY_SIZE(resp.voltages_mv), resp.num_voltages);
 	data->voltages_mV =
-		devm_kmemdup(dev, resp.voltages_mv,
-			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
+		devm_kmemdup_array(dev, resp.voltages_mv, data->num_voltages,
+				   sizeof(resp.voltages_mv[0]), GFP_KERNEL);
 	if (!data->voltages_mV)
 		return -ENOMEM;
 
-- 
2.34.1


