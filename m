Return-Path: <linux-pm+bounces-38686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081FBC88E63
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 10:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94773B080B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 09:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BE425F7A4;
	Wed, 26 Nov 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIxSspS1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3732D949F
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148722; cv=none; b=jfBoyW+a+miBv6PbmVg4k5MtUnB9qoRqG+BeiiIGlDARMi1jDeZYrHE2vJ4n35uhqPKDMpjhz/hQzQsCcC7ngiUbU1QHeVtoFSF+qikmLTF5C0V3wbpg4LClZbaIRHmNLTZpLCTYTFPPkyn3VR0fVFhir34Net7p6FK13Uk87uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148722; c=relaxed/simple;
	bh=Qvwm7WzlvxgTCVxCq4/yI/5+ShehEKnb0MC6h1H+hPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=raJXnmsieqacWuXfzWQBXlHjWekp8bBGPygyvG/MumF9JYT07YgGAG7tGiGQEdd+6EmMkxExdN4t0gZOlEAOfEOrORvFFJ09WnmrcBkzbFzl+mkJErnKlP1G55MKzSrN6h2FtwkoYYqsImsX+rFOiTcKP2iAEDGnb37TatmBIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIxSspS1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764148721; x=1795684721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qvwm7WzlvxgTCVxCq4/yI/5+ShehEKnb0MC6h1H+hPg=;
  b=ZIxSspS1c96HuN0H5jRX4Vb5/7Mh9luBNJoIW7Y2vc255WSbAxWBVXMc
   0/APhsIAo96/95cD0bk1AcuAvrDtNCLZUMImxQp4kYZttDGNA1WY8j3lw
   UZjlsEdPTjBHCL4/NslbBPSubMVBSePg2Tly2WP5I8Rfgyou+AAbOK694
   bBnNO7Kw+Bkod0l7qS1v2D06TZOxNKYfNXyr5RVxZ0zwRp2LobpEUL3hQ
   d5oyPyTRfKphvg4XlJAqoiAqfMbvhMSS03Q1dLeSh4KhldBHcY4gb925l
   p3YfB/nKhIkj0U3tB3DLTrf0Tfvxkk/LliFcPulmBrzbF2KoHX1T1ktkf
   Q==;
X-CSE-ConnectionGUID: 7zLikufFQAuY9fYFAyrnCg==
X-CSE-MsgGUID: NwigVT7MQ++x+pPxDdZB4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66138138"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="66138138"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 01:18:41 -0800
X-CSE-ConnectionGUID: eIW87VVBSzO6bD4Q5QHJQw==
X-CSE-MsgGUID: vsRtkqUlQtKS7G36yN//Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192677669"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa009.jf.intel.com with ESMTP; 26 Nov 2025 01:18:38 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/cpupower: Fix inverted APERF capability check
Date: Wed, 26 Nov 2025 14:46:13 +0530
Message-Id: <20251126091613.567480-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The capability check was inverted, causing the function to return
error when APERF support is available and proceed when it is not.

Negate the condition to return error only when APERF capability
is absent.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 7d3732f5f2f6..5fe01e516817 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -270,7 +270,7 @@ static int get_freq_hardware(unsigned int cpu, unsigned int human)
 {
 	unsigned long freq;
 
-	if (cpupower_cpu_info.caps & CPUPOWER_CAP_APERF)
+	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_APERF))
 		return -EINVAL;
 
 	freq = cpufreq_get_freq_hardware(cpu);
-- 
2.34.1


