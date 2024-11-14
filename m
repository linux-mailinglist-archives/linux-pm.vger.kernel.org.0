Return-Path: <linux-pm+bounces-17539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DBF9C8480
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6616285236
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9BE1F667F;
	Thu, 14 Nov 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBdXfmzZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226C1F5852
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571411; cv=none; b=bjoiebsCs6oRq5hDga44SrCG/YFJMNLYYHGdMiqkyy+d92ZbPPNFiJ4TyTM/JYBU53vw+7sxHrV/uxt8zIvwAeeD3i+I8JaA3GYBykBS7OBLK+5HWrH9wY5vdMB3DI8x5+uU8YHMgm74LWPokNxvuc60zfFcYQnrHaZyjxcxY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571411; c=relaxed/simple;
	bh=ZReP/VscnZ7hXhimMmbrzdZBToZXEG6J0V5UJDgz+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYENgit3cj88qP+vH4Y987SrhLSPcZH2bv1VRlALQooro+QDN6CJW6Aqo+h1Z3zt0kisN1HHZAbkPc09nhHkSQPEYDHEv+cfrIHIE/aezBez7bk0JMtzS0OWDTWfLp0R7qPFm6dVx3kYaIWHmTfvZhg/nb2wIc+K3altPaGj6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBdXfmzZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571410; x=1763107410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZReP/VscnZ7hXhimMmbrzdZBToZXEG6J0V5UJDgz+9U=;
  b=QBdXfmzZ8aokmZPP4Z7Nga/5SEIKAYwq4ES3bKVRh68EDWbA+zFtTafz
   XD+WxUYii2SnughEfw8ywtK6h11cKLwgiDjMr4fSRVPare6jK04+gIAu1
   ydRLCkLq5gPPhaDIyuObZvVieOIzd6flfOmeipPa0CMfg3NI+r6ghmjO3
   jjTQGhGc1RsoYZYsd6+ri31Gsr+VNMw6r9lhqJR9xt67J01RJPAjElAXR
   JufOrBiXyez18RpLLMnflC6JAuu5A+u3HW0AQJINLpLB+Gwz1peRqY+VY
   VqRsV3DzINtW85tNn08aIbU35P04PRyFBvdQf1pOBfuZy/VzZE1bbSV8h
   Q==;
X-CSE-ConnectionGUID: lQcRYG2DTpSQlqw0enh0MA==
X-CSE-MsgGUID: Km4NJ8V3R0GbFIWry4pf4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600434"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600434"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:17 -0800
X-CSE-ConnectionGUID: Z7GPxwtJQjyUabARrN/BRA==
X-CSE-MsgGUID: i68jMhuGQm+/wQ96255XfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627449"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:15 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 02/10] tools/power turbostat: Add back PC8 support on Arrowlake
Date: Thu, 14 Nov 2024 15:59:38 +0800
Message-ID: <20241114075946.118577-3-rui.zhang@intel.com>
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

Similar to ADL/RPL/MTL, ARL supports CC1/CC6/CC7/PC2/PC3/PC6/PC8/PC10.

Add back PC8 support on Arrowlake.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bf1b5fe1f00d..b35f63c2b206 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1005,9 +1005,9 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_RAPTORLAKE_S, &adl_features },
 	{ INTEL_METEORLAKE, &adl_features },
 	{ INTEL_METEORLAKE_L, &adl_features },
-	{ INTEL_ARROWLAKE_H, &arl_features },
-	{ INTEL_ARROWLAKE_U, &arl_features },
-	{ INTEL_ARROWLAKE, &arl_features },
+	{ INTEL_ARROWLAKE_H, &adl_features },
+	{ INTEL_ARROWLAKE_U, &adl_features },
+	{ INTEL_ARROWLAKE, &adl_features },
 	{ INTEL_LUNARLAKE_M, &arl_features },
 	{ INTEL_ATOM_SILVERMONT, &slv_features },
 	{ INTEL_ATOM_SILVERMONT_D, &slvd_features },
-- 
2.43.0


