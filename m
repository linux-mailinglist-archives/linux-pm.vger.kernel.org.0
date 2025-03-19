Return-Path: <linux-pm+bounces-24325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD3A69C36
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 23:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCCD881145
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 22:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E63B21CFF4;
	Wed, 19 Mar 2025 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awF+H281"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33CD21B9C5;
	Wed, 19 Mar 2025 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424256; cv=none; b=PEYP3Q7CwUq32iMunt7YtaxB4eDC0tftt2vsZ26yBx+nyqgWoTAYBJjOmxv/zfGYHFOBhSi48CBCZ6YgryXYb9aKmgVaqnJjcSeLKMFiBszen43GefaEnz8UdPZitdIanOjJHEegWWeqgDFQKU2qDqdnZBSoE+BVN0RAsUKHsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424256; c=relaxed/simple;
	bh=0ph8TWg4i5QPlJyTQE6/THVW5Vuy8oxKuuPiP1VUq0M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WBacti81Agx1ywW+JnLffU2bze5Hc5vSOKu0VNs+H8kM5sW0BQNGyvq6ouqqoTr8chnljzQmMeYziYe64Hu8DQc26ISaf87BDYwumcQeXYb2ZtsUp52thPdRvfQG08JmeUgh2xy3bomkjmGny5MjBpCNn6MGOxDY/etuESIjW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awF+H281; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742424255; x=1773960255;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0ph8TWg4i5QPlJyTQE6/THVW5Vuy8oxKuuPiP1VUq0M=;
  b=awF+H2810p7XcDpN8L9PuMiyKU/q937gSX+lMMKmj3M9ODt42/8VjNZZ
   XJJ4xojpPcXMfCxeodQPOXCe+kEExTQpiwnK8hjHPqH4rhIofoxROUHoq
   WYh5el1mFEmzSn+pkcDVNN+7rwDRIPXEn6437pLd+i0dC/bsMibuBjVZn
   14nmHGooWF9EZJk2fue8KwcNxqsyFL4wZkXdDSUHvPxfGDAe40IcnqxSd
   pOSEU3GHJ+xCGxqtA1uEBfrInI8FetM9+6KtpVVrEsBnObli6QFUUkeQr
   WdcWoEagEKWEaU2klecMEtNAJJBWmUZkHGmqun7tO5FLF0Wwx17n+Fac8
   w==;
X-CSE-ConnectionGUID: XnddF+i/R6eG9NZKqg3YHA==
X-CSE-MsgGUID: zJfGCtJCRleSIzdXfUKrAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="54304189"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="54304189"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 15:44:14 -0700
X-CSE-ConnectionGUID: ZBcqqMlPQICiWzd42qIzQg==
X-CSE-MsgGUID: R90ltUHNQwCo/v4avMAsOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="153723685"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.220.177])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 15:44:13 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] platform/x86: intel/pmc: Fix iounmap call for valid addresses
Date: Wed, 19 Mar 2025 15:44:06 -0700
Message-ID: <20250319224410.788273-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmc_core_clean_structure() is called when generic_core_init() fails.
generic_core_init() could fail before ioremap() is called to get
a valid regbase for pmc structure. The current code does not check
regbase before calling iounmap(). Add a check to fix it.

Fixes: 1b8c7b843c00 ("platform/x86:intel/pmc: Discover PMC devices")
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 7a1d11f2914f..de5fc06232e5 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1471,7 +1471,7 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
 		struct pmc *pmc = pmcdev->pmcs[i];
 
-		if (pmc)
+		if (pmc && pmc->regbase)
 			iounmap(pmc->regbase);
 	}
 
-- 
2.43.0


