Return-Path: <linux-pm+bounces-26249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4089FA9D25C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7B71666BE
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0792A217737;
	Fri, 25 Apr 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9Jaochh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFB21CA0C;
	Fri, 25 Apr 2025 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610786; cv=none; b=B/jbT/fPb+X0zWO5kmtT4U/xd/nFNY+rJVdcXzg6wZQMDalY8i7CQcxn5haQdAJDmNHmF6YIF4R2hBCWUO3bziTDItpSoEVLDppCn0z6HFstgVYtDA/VYJC1L9DqVfA7J4vxoyUnqSnRLzEMSS2iXruvIiJD16wxkXdANx2KE8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610786; c=relaxed/simple;
	bh=PcMt8Jp0f62RG/rNVrmXfgzvG/ZGY+L39bmdXiveS2I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bc4OSWUUOwsPYsywja2089/m29+CKk3wpNRJ0JWMMPKujJpwsdO8RVFvdeFWW3GxnRL63Lq4x2W/3q3ZHCahHjFWhwqBAa7ne8SHJue6zczKfOweuOebpsKNmbiaJQSLYaGIhnls7bHDIwi6ASEqAr3/SkkqGV3zfwEVhm8BlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9Jaochh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745610785; x=1777146785;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PcMt8Jp0f62RG/rNVrmXfgzvG/ZGY+L39bmdXiveS2I=;
  b=b9Jaochh4FyXxy2Qq2PkagLx9oLstd4ezcq9muGiEX4r3PW1lNfw9Dcj
   qLRw1BJIq3N/Kw0F9i+pUtIfhMxHV/tnU0dR/U7+ioReBaXaXAgXS9hEr
   4tHWXwZaakjLyqxdzixNxHJ30UGd94EvxMTes6mAzuKKQ6dP+feeVLyUS
   e2LDejDP/wGnY4PR4J2bWlLL7S0zUYs3PN0vi1KXN99WUZyncmwyYz7xd
   fUGdkQaU+scvXu0lDSSmLtI6eEmlfmqfxTz8UxMZEbbNs+M8S7Ah5A1tk
   LVJyJ1+GfdKhKy5XrNP8hYsQ4wuTJFsmDl5Y89q4MOdsG43ExvSxzwH9K
   A==;
X-CSE-ConnectionGUID: Un3oET/iSV2MGXF9ZeIXug==
X-CSE-MsgGUID: FQkadsA6Tp+RpepHB4PuXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="69776216"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="69776216"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 12:52:40 -0700
X-CSE-ConnectionGUID: Z9y3xGV5S9KLdLmZM5zHPw==
X-CSE-MsgGUID: edPbIq70SceU8CXDoVWdZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132897642"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 12:52:40 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 1/5] platform/x86:intel/vsec: Change return type of intel_vsec_register
Date: Fri, 25 Apr 2025 12:52:29 -0700
Message-ID: <20250425195237.493129-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425195237.493129-1-xi.pardee@linux.intel.com>
References: <20250425195237.493129-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change return type of intel_vsec_register() to int. The current
implementation does not indicate if the register fail or not.
Change to return error code if it fails or if INTEL_VSEC config
is not set. This is a preparation step to introduce a new SSRAM
Telemetry driver that will be using this API.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 9 ++++++---
 include/linux/intel_vsec.h        | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index db3c031d1757..055ca9f48fb4 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -332,13 +332,16 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 	return have_devices;
 }
 
-void intel_vsec_register(struct pci_dev *pdev,
+int intel_vsec_register(struct pci_dev *pdev,
 			 struct intel_vsec_platform_info *info)
 {
 	if (!pdev || !info || !info->headers)
-		return;
+		return -EINVAL;
 
-	intel_vsec_walk_header(pdev, info);
+	if (!intel_vsec_walk_header(pdev, info))
+		return -ENODEV;
+	else
+		return 0;
 }
 EXPORT_SYMBOL_NS_GPL(intel_vsec_register, "INTEL_VSEC");
 
diff --git a/include/linux/intel_vsec.h b/include/linux/intel_vsec.h
index b94beab64610..bc95821f1bfb 100644
--- a/include/linux/intel_vsec.h
+++ b/include/linux/intel_vsec.h
@@ -139,12 +139,13 @@ static inline struct intel_vsec_device *auxdev_to_ivdev(struct auxiliary_device
 }
 
 #if IS_ENABLED(CONFIG_INTEL_VSEC)
-void intel_vsec_register(struct pci_dev *pdev,
+int intel_vsec_register(struct pci_dev *pdev,
 			 struct intel_vsec_platform_info *info);
 #else
-static inline void intel_vsec_register(struct pci_dev *pdev,
+static inline int intel_vsec_register(struct pci_dev *pdev,
 				       struct intel_vsec_platform_info *info)
 {
+	return -ENODEV;
 }
 #endif
 #endif
-- 
2.43.0


