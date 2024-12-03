Return-Path: <linux-pm+bounces-18408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC8B9E1485
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAAEB2599A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE55193402;
	Tue,  3 Dec 2024 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEiLMKgm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D517BB25;
	Tue,  3 Dec 2024 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211860; cv=none; b=oEdxRuP6tBICj4pNF7dIGuPnMRjEOOVA0HGbuEWEqcUHPux/d9mv3aqG+kSpuQ9FYKgen/gBk5N7I6Wdq6oYFxwukRFi8izZFkjDk1hcC6W9VS9v3b86KcQPAbb3xI0QJhZvU/egUluIgCwujiSo+yt1pBjuYJLmudzDLwfdJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211860; c=relaxed/simple;
	bh=kQf0MqbbVkLUPMOFU0yV/6UAqR1U8B+vsLcnpf8vL/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucGT9FthJhil2rXclZiraDONN91yuwOyexIBzS5fOAHoqTPCly9bWNQu2eHhFZ4LiQU5BWZcgSeYPWtUN2aXxA8atA6t8meG7BaiRJqamYN5LWkaxkydSERdlUPqBguocZ1WipxM8kniLFZkQDvbhts2hA+VqTILXRQKqeAjD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEiLMKgm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733211858; x=1764747858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kQf0MqbbVkLUPMOFU0yV/6UAqR1U8B+vsLcnpf8vL/g=;
  b=kEiLMKgmFRnP/sr5jjAHgxZ9o5jf64EZlVByC+/gsNV+gVfAgK2FxouT
   60Nnm2N9AlN8+cMFQE0q8xCXxpY/UjF2iKAJkJYebPdsxttGnyoYDEa9O
   /u8FHaxYOxWc3PnNyoPzz094AjdP6hF4Sz1v0TdZbnvjMGRTyy+8IcgD0
   aqY2X+hXRgleOuyysz/S+YVCLP/Op4eZtQSqPUlOdgB6U9B4QC7frscT/
   3N1np/sh062OjSfS/djW0Hh/PnMIDdo23TTEA8NfiSoV9tB6YNVCJFBju
   im3FsqCR9jHAXYvWNyO4IpMg47Zc6tkOYzgrqzYi/8nKeJdXIB8XaMGGh
   Q==;
X-CSE-ConnectionGUID: IO0j2XFBQYGQHp81QH+cGA==
X-CSE-MsgGUID: EePMi5e5RdmFIs5TkLcAiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33541416"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33541416"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:44:18 -0800
X-CSE-ConnectionGUID: IyP0Fb6wQRe2Ua2DGO3czQ==
X-CSE-MsgGUID: 81fSo1D1RtqhnZZsnyOYOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="97423577"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by fmviesa003.fm.intel.com with ESMTP; 02 Dec 2024 23:44:16 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] tools/power turbostat: Add initial support for PantherLake
Date: Tue,  3 Dec 2024 15:44:17 +0800
Message-ID: <20241203074418.583457-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for PantherLake.
It shares the same features with Lunarlake.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 58a487c225a7..540336138ce9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1024,6 +1024,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_ARROWLAKE_U, &adl_features },
 	{ INTEL_ARROWLAKE, &adl_features },
 	{ INTEL_LUNARLAKE_M, &lnl_features },
+	{ INTEL_PANTHERLAKE_L, &lnl_features },
 	{ INTEL_ATOM_SILVERMONT, &slv_features },
 	{ INTEL_ATOM_SILVERMONT_D, &slvd_features },
 	{ INTEL_ATOM_AIRMONT, &amt_features },
-- 
2.43.0


