Return-Path: <linux-pm+bounces-28902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7CADCBE5
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B313A189873B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820142E4244;
	Tue, 17 Jun 2025 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYkVxmwl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917F2DBF69;
	Tue, 17 Jun 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750164558; cv=none; b=nQljWXT5yvzb6vLXfKz050/CUWnGwsAeT8cpScoAlr3auLMu75L/L+A0mJBqfxvRtRh+XFtEg1MVfyzUlN5Sa3gCGDKFqCc5elOcYaatv3wYXIhIHqNF09mzPuIHc9tDkGHYOrcKfcjPFtdtGvblenZtQ0wcGmy3egwYRKRtj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750164558; c=relaxed/simple;
	bh=tGhygor0l+BgsarSmUjvGvw5JgnyQpjXVM+UY+ayPIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKNJh0D3pMOd0Odg8jveQk/ZqCsqDnvl3Xze+aX9E6E8s46g2a2MsuolLuFZjFmTrKG4siyfPk4dP9EgXOmes+aqra9LZ0e7kyXzxx5OgOYMbSQ2fviJLwFGOOVN73zSinmNWOBpwVGZC2fNjTVGJNAXWNhltk9eOBBbnayA8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYkVxmwl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750164557; x=1781700557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGhygor0l+BgsarSmUjvGvw5JgnyQpjXVM+UY+ayPIQ=;
  b=GYkVxmwlaIsV0LgH15eltOdup7I0NhswDNSAakUXQFdrxxEGX+C8ZmmJ
   NI5HNtq614KvVbDaL967QhxUG/pXQCjx0WvQu95pLEdltjILVFGgCfijq
   zLaV9kUSY2M5oanzVO4auKoP+OQMCHVdxBCvHgHf5U2y/hEAaBHGaP19y
   V4OAP1FVYziuDbksSGiukMmdRNPRXxWUfZhIS3sUxZIa2j8dywXxg2Jgi
   LKL1Gv4LI422GjGY0wJzt8+S22u96l0URqS0ZxeC8dTq4ebIABTwLXBnm
   aRFYtQCFmhHO/D9nCdCWs+UTbMDHPLBALoO6NfcaEojWBomcJmF47DcDx
   w==;
X-CSE-ConnectionGUID: x6t3juZpRRyYMa/NXcU+2A==
X-CSE-MsgGUID: PTKNVk3JTgOwnxeT8IdQzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52255008"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52255008"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 05:49:11 -0700
X-CSE-ConnectionGUID: DQcMpZnzSKCP8+f7GFqRFw==
X-CSE-MsgGUID: m+vPFJLuRNCXICCIqf2OPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="153661287"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO rzhang1-mobl7.intel.com) ([10.247.119.11])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jun 2025 05:49:07 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/2] tools/power turbostat: Enhance legacy uncore detection
Date: Tue, 17 Jun 2025 20:49:00 +0800
Message-ID: <20250617124900.186591-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617124900.186591-1-rui.zhang@intel.com>
References: <20250617124900.186591-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, legacy uncore probe is done by checking the permission for
/sys/devices/system/cpu/intel_uncore_frequency/package_X_die_Y/
However, legacy uncore runtime update needs to access
/sys/devices/system/cpu/intel_uncore_frequency/package_X_die_Y/current_freq_khz
which demands higher privileges.

This discrepancy can lead to situations where turbostat incorrectly
detects legacy uncore support but fails to access it during runtime when
executed without root privileges.

Fix the problem by checking the same sysfs entry used for runtime update
to decide if legacy uncore support can be probed or not.

Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5f8ab899b552..46f6a696b434 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6737,7 +6737,7 @@ static void probe_intel_uncore_frequency_legacy(void)
 			int k, l;
 			char path_base[128];
 
-			sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d", i,
+			sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/current_freq_khz", i,
 				j);
 
 			if (access(path_base, R_OK))
-- 
2.43.0


