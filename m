Return-Path: <linux-pm+bounces-17540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939809C8481
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFAD285266
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856C1F6690;
	Thu, 14 Nov 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mpr56vOJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9C1E8857
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571411; cv=none; b=ROjoAld1o/LAvwzl6cnIoClQ/fAgmHY4L2wXMK2tbizI4F1jIbQR8ev//Wgg8P57lG0Y3jzIE2S6wZNmzgRBVQwW40VJefwSBKCfXQUeNwIkqcm43IUowU3wNVVF9SRUoxSa+zY/wfacJo0JSduD6BH5zTBZSMOnGUrd4cB6ZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571411; c=relaxed/simple;
	bh=Irfwz6f+CCffVc4a2X3/8hjZ28G+Gyv2lmT80b3w2wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPWY0srfhJbDvJmIwe+eP7A9vm2ZD7DvjFTrByfk0PXJJJw1R7zpdVNYu91FgwiAtS02LWprTZ4ADYXmNOIED5bXR9XOiN0stz2FdSHGvt5EFB3K0/dCPwX5HIDgr5aHK5XOf1a87EW/YrLpGAuXeauDRnscaSeRRgs8dWobpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mpr56vOJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571410; x=1763107410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Irfwz6f+CCffVc4a2X3/8hjZ28G+Gyv2lmT80b3w2wY=;
  b=Mpr56vOJhRIoyY6xXbApaqmLYrMuKC7kDZT6NLD3Bki8Rv4jDJwrpITU
   ljAJKr37oO3IyXxl957wJlf9znISHHvNRWmLwHjXws9C+7h5nKzCmRRyD
   rSg7w/U8kjz31gsGc9DTryID4kZYE+LuQBlMKtT1IIbAr6dGjMp7uxg82
   Shkfts9CQcMeOlJuV8lm1hZsVbvKy06RPy5xpr9T/JjC9VwwL0UR04MiC
   nlOxp+TjgtHbBYpM2a8ylDVEWOndjeQhwqyK/J+I+e65q4emOnUfbHc5Y
   3VuJvz3BGW1DpTBS4R6g0KlunEr4wbkcy0pRlhqw3c3OqNG7XdV+J9mtH
   Q==;
X-CSE-ConnectionGUID: TUU9aEM1QhKiZke7PjdqwQ==
X-CSE-MsgGUID: mCOnnN/+QH2vHqzdF1bxlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600433"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600433"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:16 -0800
X-CSE-ConnectionGUID: 7/gel0/GT5GC+XtbEcU/2w==
X-CSE-MsgGUID: k9A9jbp/R82MAmgSJf+4Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627444"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:14 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 01/10] tools/power turbostat: Remove PC7/PC9 support on MTL
Date: Thu, 14 Nov 2024 15:59:37 +0800
Message-ID: <20241114075946.118577-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114075946.118577-1-rui.zhang@intel.com>
References: <20241114075946.118577-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to ADL/RPL, MTL support CC1/CC6/CC7/PC2/PC3/PC6/PC8/CP10.

Remove PC7/PC9 support on MTL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 089220aaa5c9..bf1b5fe1f00d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1003,8 +1003,8 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_RAPTORLAKE, &adl_features },
 	{ INTEL_RAPTORLAKE_P, &adl_features },
 	{ INTEL_RAPTORLAKE_S, &adl_features },
-	{ INTEL_METEORLAKE, &cnl_features },
-	{ INTEL_METEORLAKE_L, &cnl_features },
+	{ INTEL_METEORLAKE, &adl_features },
+	{ INTEL_METEORLAKE_L, &adl_features },
 	{ INTEL_ARROWLAKE_H, &arl_features },
 	{ INTEL_ARROWLAKE_U, &arl_features },
 	{ INTEL_ARROWLAKE, &arl_features },
-- 
2.43.0


