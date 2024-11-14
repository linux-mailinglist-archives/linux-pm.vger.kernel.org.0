Return-Path: <linux-pm+bounces-17538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A8E9C847F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03B7285324
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC09C1F666B;
	Thu, 14 Nov 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhfGjtvM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C822611
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571410; cv=none; b=cTk2dEMISoHMy0zlx9Um7bVm8FRu153e6mf4apzM0TqfavquEUu+m0quklSlLrryVGwDdyKKPRYY6aN9monAdhiqwBkWWnS+ugXHrCj3Ks1i1F0yWK+k2YzYd+DRk6VB0HaZBisVd4b3RQGb3AX9P2Qq61f/ovU3qoJEdr43R5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571410; c=relaxed/simple;
	bh=GQBIc9cNmBVfSCy0H2v7jCxrHQRrUvAhVov6nj7t06Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrzJ4ssfRHSNF/Pmthp6iubAoVAHQSP1faxg0aAgCm9e8ZfeH19gyq992BwzzZz280PSXAgMi5+1UIP0chRNoAB37G3eldHrV8jBIIwilN5fQtBPEq91Z4pKaxbU6d0rtsRBI5y/5/4wTxTnDFcoOk3Xwbj8oQRM5TTVf6RW/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhfGjtvM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571409; x=1763107409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GQBIc9cNmBVfSCy0H2v7jCxrHQRrUvAhVov6nj7t06Q=;
  b=EhfGjtvMzwhixFDjmiqmEoS5JP+3tyFHjRLbOA1lyrOxxgrnAh7GVpEP
   H2kkkt0zBPaJ1YEKBkn2e70d4D3v2HOHQTLev76OUofG5G9BU3hykHWjm
   /du3StRH/r2bHID5fnYjz6oeuthub6RWAVq3doZkezGtAYOBpk1ECmc/s
   N+NmjpzwUH3U8abvxuRZ2Hi7Vhy0vQNnEWT1VtMAzgyJd3ap2+Jy29Ppk
   VBk1a+DyKsZBZRcmBjxPE9RW3Frfpq496Na8qHk4o4tPlxU5dNsdFUMQS
   sdMMwscCys8ZzNGgg/GyML1dnqm0YxQz+P+Afp3Gh239KABnlRqBxgJ8+
   g==;
X-CSE-ConnectionGUID: leDVKGx+QSS/vfzAObMhiw==
X-CSE-MsgGUID: KXG96DgQQ9mRZ8CGcSNs+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600439"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600439"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:21 -0800
X-CSE-ConnectionGUID: UOle5x4RSlyjdBNOxM2B4A==
X-CSE-MsgGUID: hZbHitiUQv6+bV3+JsGZPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627469"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:19 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 05/10] tools/power turbostat: Add initial support for GraniteRapids-D
Date: Thu, 14 Nov 2024 15:59:41 +0800
Message-ID: <20241114075946.118577-6-rui.zhang@intel.com>
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

Add initial support for GraniteRapids-D. It shares the same features
with SapphireRapids.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9d76329e108f..d8338458d031 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -997,6 +997,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_SAPPHIRERAPIDS_X, &spr_features },
 	{ INTEL_EMERALDRAPIDS_X, &spr_features },
 	{ INTEL_GRANITERAPIDS_X, &spr_features },
+	{ INTEL_GRANITERAPIDS_D, &spr_features },
 	{ INTEL_LAKEFIELD, &cnl_features },
 	{ INTEL_ALDERLAKE, &adl_features },
 	{ INTEL_ALDERLAKE_L, &adl_features },
-- 
2.43.0


