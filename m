Return-Path: <linux-pm+bounces-28530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D8DAD691B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 09:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D067A579B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678A51F12F6;
	Thu, 12 Jun 2025 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cyk1yl1e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6961E487;
	Thu, 12 Jun 2025 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713580; cv=none; b=RI55YVZuSCPbnSq6nRVXJFZRkm54CTVOwh1kHkzbHfvKf9YQ0I+ZA2VbzsM+RBH+cFfTK2/zAMevewU4c9vyoGjlC5vstJt/yAtZXAiQ0mPrXrq7lddbNjQ/z1BH16gy6RF4YeDMrnb3JqBbFvBTvueabCNeh1AjxQq0Tiw0NUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713580; c=relaxed/simple;
	bh=tZCcnl/osurP6iT2PXIgUw4w7LPGhfuYD+FmFH/xzzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hy7ykRBE6cDUaVm1xfUdn4scApNqF5OxZx5jYWXBslJZPkw49kmE1sFSjPlrNtEm3BH6GBt3ire7lYWbV7G46iVbxXaU00VgWF/EqhyNRvPE8GVqRXYpbOV1u75HZZFC6BY1JxNYg2S0//Ex6ZCZbUCewqP/yvG2ZgyiJGdkyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cyk1yl1e; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749713578; x=1781249578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tZCcnl/osurP6iT2PXIgUw4w7LPGhfuYD+FmFH/xzzk=;
  b=Cyk1yl1eTOollM+bRvSdmqCDD0ZuQdDI06Q+nYpGPfI9hymj8B4hgHe6
   JxGDdb+eQS/vddZwN/ZLR0OBmbu59XaMc2l7u5ynaNR8qlGekn27V8Kd+
   ogX4TguEpvjKKdjCfUbx1l457+yreyhAkr0QIYsexJiRMIWn2w8u6Szde
   sCSn4cSdafxrZ4Z7EzCQQvHmDrQiw+xHVI/VwSlQVEycUOzr5jvm6DtSJ
   sjJIJBDp3n7snCjrjEOnHCjHDkicybF73d4G6DF/3mTWReXtrjN/Isyx4
   1R1sX5r4EserXsPp29Qjo2D6FO5zxaGmzqm5zVkpRNcV/eMeFZpjKjBjp
   A==;
X-CSE-ConnectionGUID: hN2Fz9BlSb+voeglWm+b4Q==
X-CSE-MsgGUID: SQdxwChBRZqdVxzcfggw8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51795010"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="51795010"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 00:32:57 -0700
X-CSE-ConnectionGUID: WKhWkXWMTA+8j+Hvxxiglg==
X-CSE-MsgGUID: ogDBG0D+TtmrsGe5eXKKOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="152201840"
Received: from wqiao.bj.intel.com ([10.238.158.145])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 00:32:54 -0700
From: Qiao Wei <wei.qiao@intel.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rui.zhang@intel.com,
	xiange.pi@intel.com,
	lili.li@intel.com,
	furong.zhou@intel.com,
	Qiao Wei <wei.qiao@intel.com>
Subject: [PATCH v2 1/1] powercap: intel_rapl: Add support for Bartlett Lake platform
Date: Thu, 12 Jun 2025 15:06:13 +0800
Message-Id: <20250612070613.2995756-1-wei.qiao@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612044538.2970661-1-wei.qiao@intel.com>
References: <20250612044538.2970661-1-wei.qiao@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Bartlett Lake platform to the RAPL common driver.

Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Qiao Wei <wei.qiao@intel.com>
---
Changes since V1:
- Remove "[linux-driver-review]" prefix in the subject
- Add Acked-by tag from Zhang Rui
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index e3be40adc0d7a..c0789df34b2f7 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1261,6 +1261,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,        &rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BARTLETTLAKE,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_METEORLAKE,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
-- 
2.34.1


