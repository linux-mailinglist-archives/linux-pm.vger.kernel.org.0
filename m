Return-Path: <linux-pm+bounces-14922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DE0989C81
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA981F2166D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B0D1684AE;
	Mon, 30 Sep 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vm2Kc8bQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4243156;
	Mon, 30 Sep 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684386; cv=none; b=Bj2LXQ0J2m2h2kQjqr4fs5Bvw05AYUEP3vZ26rlmFLPBzwfAg2OgNE6oOrgYsKiPbmwQaVLBMk5FAw7SNnaZsrJrwcD/nFSaesx11d9hUWp0Cu0k3PFhQQdOleG6hXadYUJBIhJ5gJcxlN96qhgyIrNwH3glX5CTZx7ijlfFiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684386; c=relaxed/simple;
	bh=n/uVYp3+EpXIcbqYoU65jO0k6r4IqZH14tOyYeW8mqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmiLUWXc/zACSXG3uDUdj8fyf7fDMqW5Gsbmxf79/f3rmRhGw+oKL/cPs9FI2pj8rQuxBgFz+uIUBEU3V+lsE3I5JncXYXBlBUc7RCXcMwvS3B9KnZvJu6YfRxNxZwz5iAp4lQQ+QmoNeVshaEMkiFq8ShePybDHyvfTfpmksXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vm2Kc8bQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727684385; x=1759220385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/uVYp3+EpXIcbqYoU65jO0k6r4IqZH14tOyYeW8mqE=;
  b=Vm2Kc8bQO/cioyEjdrTnMJIcocpgBF1XGDztEjgxMu1kUxz4jlFjN8JK
   AYpe76b+kxdcIMphtVQwRvtFSF75VM7Kv6TYGcKEvOdwQCjsuUSeNTiA5
   1WM0C2DwMPuXTAku/oRsSvptjN+tKmidc9MwPOtIzrFgklYBnp4rRP0EK
   obf7LUWficAT66sTfwUHc/EHYMyJRadjZAPvq2L+ZxJnU5/1+wpotVPUC
   4WiCMGw5NzrfZ9Vj5JERP16RgJ0GG3KIuytfjNeyxs6SACKj3Yh4ytOtN
   1pr8f3yjglSNLdC5aj+RFrDHU/AZCQeNlLnCZCRigI1MyYcqtLY9z7/fp
   w==;
X-CSE-ConnectionGUID: TvSxAEycSUubJX43tHucag==
X-CSE-MsgGUID: bw05r04UQ1qNI7mf3Xmgfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26638967"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26638967"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:34 -0700
X-CSE-ConnectionGUID: AKCRM6gERZm3Wdwo1MHEAw==
X-CSE-MsgGUID: 5Kn+K91kSVax32MzDH5gRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="96549451"
Received: from unknown (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.245.243.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:28 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 4/6] powercap: intel_rapl_msr: Add PL4 support for Arrowlake-U
Date: Mon, 30 Sep 2024 16:17:59 +0800
Message-Id: <20240930081801.28502-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930081801.28502-1-rui.zhang@intel.com>
References: <20240930081801.28502-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

Add PL4 support for ArrowLake-U platform.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 733a36f67fbc..1f4c5389676a 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -147,6 +147,7 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
 	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
 	{}
 };
 
-- 
2.34.1


