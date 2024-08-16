Return-Path: <linux-pm+bounces-12355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF0954843
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 13:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC431C219AC
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 11:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D81198A2F;
	Fri, 16 Aug 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYTajlCY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1D513C695;
	Fri, 16 Aug 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809065; cv=none; b=H1DENREqbImALCDT+a4ieEe9gOOe6e/jJ6OAoMlcLY9BP+7GAOo/IAXW7TB/UXlQz5iu6oCLBLdD8vd++LyHtmrnljyqSIRsHvkb82ZBz6WeMuJDzim0WzkRRGXGdeQCXCDSD84s4Y4fxWfTjEVRYwD2Z3Z1qzpin8ixf9gaXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809065; c=relaxed/simple;
	bh=NrVEL/jvKAIkwZ7hiWKTzBpE8gMkUB9020s/Zy1+woU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MBUf807Z7/MSoizCd6jMvW8dz9P2dP8adcOV7ZZ2ADPQMN87UtQl22T60ssORhVk8lvqvPKlufHKtxg9wW0FpUGNeq6RDEiSdyr/hiqjKgxcUgZbJkJUEcluzrxwObiOMHyfzoBwhhCbnJN05J7+gCVRud8CPC+CSLlNuz0qkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYTajlCY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723809063; x=1755345063;
  h=from:to:cc:subject:date:message-id;
  bh=NrVEL/jvKAIkwZ7hiWKTzBpE8gMkUB9020s/Zy1+woU=;
  b=BYTajlCY4czXKA/43LGpxt7daqKbfdpL7Pgh++QngKtY3nG8+73GrksO
   3Q9YRnYZ4pPbDA+5HjLCB5EIimmtyq4UNyTqgzo1hX2f73L8ASUSZRlY6
   cRm9GT2ekX5sMBLWGZrKOyjl+11dLClB1AFrL9/6TVAwi0AWzI35Hp3O+
   pke5nOWQcRQ3Plcd6IzxmLMfYL3688tcIkLF5cH+zC9X0HInA+/1f7VY7
   cQx14lbksJsLuvOdJRGTaUZzvRrnTlzj3AT84FNtHtzB+BH2EKxu6LYqE
   mxXgb4QIoBFCZQ8d0FIdX5ZXSGmRWTTP0KWWiDon9Xb2UzPTcdbqUtOhP
   Q==;
X-CSE-ConnectionGUID: H4x4cvQPTfW8PsdGlXwD7g==
X-CSE-MsgGUID: Z+UvGeLCQoaWgycsmlNuAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22260836"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22260836"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 04:51:02 -0700
X-CSE-ConnectionGUID: r71F//mUSBKT7cnpe/V7Ng==
X-CSE-MsgGUID: h04FQV5cRQ+Jar4ePCXH0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59670929"
Received: from srpawnik (HELO localhost.localdomain) ([10.223.165.204])
  by fmviesa009.fm.intel.com with ESMTP; 16 Aug 2024 04:51:00 -0700
From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: sumeet.r.pawnikar@intel.com
Subject: [PATCH] powercap: intel_rapl: Add support for ArrowLake-U platform
Date: Fri, 16 Aug 2024 17:03:32 +0530
Message-Id: <20240816113332.7408-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add support for ArrowLake-U platform to the RAPL common driver.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3cffa6c79538..3edf8decb811 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1267,6 +1267,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_LAKEFIELD,		&rapl_defaults_core),
 
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&rapl_defaults_byt),
-- 
2.17.1


