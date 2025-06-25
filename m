Return-Path: <linux-pm+bounces-29455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3B0AE749D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 04:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D025A26E2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 02:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24320190676;
	Wed, 25 Jun 2025 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWnTgW57"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355A3074BD;
	Wed, 25 Jun 2025 02:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817127; cv=none; b=KdOBG9W/SgSyVZLr2gTshHiFiJaGDxYF4vIIVruCOoz4SeDKvfIexrna5SSZ+p6bTBjWI8u3Lxp0bpWGhVE0lXiPGaTvvD13GsYDfUbpro/k+ClbfnpOHTkQBhqbsIeLdbd9iCC/AyQyoprEbSeJQ3EfyRZ1fs+JGLh85pV7438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817127; c=relaxed/simple;
	bh=uz398/O8MFlL6ZTxSmiwjTRrpH00nvePOXE1T6Ls/Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgKyXfHXo56C48FGq1qUaax3nhLVra/NdP/k6kKY8OSNa+0CNHNOY1JA0f3eADltAco47m3BMO5T/nevfHABZ5tKAlp+pv4iowTYZaRqwz+NMoiYU/CAwGevWCEFSo9qztqZQVQrsPHhXgUv/qvDhH4+Eb+YyK6S0BixSJITEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWnTgW57; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750817126; x=1782353126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uz398/O8MFlL6ZTxSmiwjTRrpH00nvePOXE1T6Ls/Ak=;
  b=mWnTgW57krk5MCirLeCl6NNr2raOdsMpUQGj4ZPBCKUBUZiJau8MHIej
   JaRLRqQ2f3QQOuBFXxsGLm5+8xEYcADQ3IvDxNwTeW6LStvz3/QheDUei
   4FHoejIKgX6RWLI59X//9Cq+63FwEqG8PErJSTzATMikTI72yrR522h6f
   Jg4bUUg7ocAOYT3VvQI9zfJ7nTI9bFUw6o7Z9HkNvcVkYwqpYj0Sok0ML
   e035YSlGp5Rcg5KrLXbPkcXWYim+IzcL71e1kAD4hCticiq1CT0kPomow
   1QQS2QRlP5968HfKUK8hXwKc1hzZ022SbfxJWo3WtOJhmIFmghs9xYrns
   Q==;
X-CSE-ConnectionGUID: HbvNarfYQkm8J68rwQhW3A==
X-CSE-MsgGUID: 5i39euBCTuW2guHjZcNY6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64131434"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="64131434"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 19:05:25 -0700
X-CSE-ConnectionGUID: I8hji7zwSi2KHa3Szx8wQQ==
X-CSE-MsgGUID: zJVSt3y8TiGCbWUq8t5SVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="151587281"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by orviesa006.jf.intel.com with ESMTP; 24 Jun 2025 19:05:24 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH] powercap: intel_rapl_msr: Add PL4 support for PantherLake
Date: Wed, 25 Jun 2025 10:05:22 +0800
Message-ID: <20250625020522.253548-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PantherLake to the list of processors where PL4 is supported.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
The PL4 support for Arrowlake-S and Lunarlake are also missing for now.
We will add them later when there is a real need. I'm also checking
internally to see if it is required or not.
---
 drivers/powercap/intel_rapl_msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 8ad2115d65f6..4ed06c71a3ac 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -150,6 +150,7 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
 	{}
 };
 
-- 
2.43.0


