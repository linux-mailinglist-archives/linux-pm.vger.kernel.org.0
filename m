Return-Path: <linux-pm+bounces-25820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77081A957C3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 23:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868DC3B3873
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 21:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B12135B9;
	Mon, 21 Apr 2025 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAOaLTxx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498F21018D;
	Mon, 21 Apr 2025 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269869; cv=none; b=eGGmbfQpAKI/Ns1F7ujeuSBTclm39tf5m0LwQHlF8TC9pwttfE/u+vnAQGxp5LXrzr+HVSzPh5s1EN4Isw+BaQhFJWZ0d6r9cAKRHx3rzq46t2l1Qj3yAcRLKJxUVZfuAMpoVzJtmbZUg8hukaW0ciS+8DiZ1PNTpOH81qchKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269869; c=relaxed/simple;
	bh=PcMt8Jp0f62RG/rNVrmXfgzvG/ZGY+L39bmdXiveS2I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCylulgYvmoGHoPFWdeAFNuvpi5odXcJUFIwOWQw8QUW8WcWEeL+YgWuZiCZOh/a80y0uB1EY1CuuFyv35xXQOydRk+hQtItlZAdzYTGj9h84EM3MsdVYLy/tMGwme3lzyaQpdNNksKy+5qRR+eHOJwtja4M1ZnayTekIMotGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAOaLTxx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745269868; x=1776805868;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PcMt8Jp0f62RG/rNVrmXfgzvG/ZGY+L39bmdXiveS2I=;
  b=fAOaLTxx6OgHhqtU0GYwEP6kEhs5oRUyIcEwONjVc4J1rHwk+hxZd1Bo
   zgzg/qgBBTqel3CQegu+6XDlCThwdZvC7pbyOI3rg7xnb4BtkatOL0tWY
   dzRkSOHpG2G0E1IFS/kVlc7dxdyUzclGeMDBw/zQMhOmgHFjOptD2eebW
   EKJtK7pCI2luGHLqymq/ROPLP8EFPhPoybDLnJeXYfm2pBEcDxorsHNwU
   +4Wc4KJll7Cx/uzS7zu5CgHUTEgBrXgNQZeHNGrzaHKI7kQs0lQmGFjvJ
   dKba8jV82LaIF6WntixNwiMUfQJ/uSTZKw7ANV+XCc7k3B5RDduWU/FFz
   A==;
X-CSE-ConnectionGUID: kDlOx83vQS6IOHZRt0pC3A==
X-CSE-MsgGUID: dNcaSP8PSuCZdR+Obv931A==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="58189449"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="58189449"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 14:11:04 -0700
X-CSE-ConnectionGUID: ml2kHgtGRJa0cNwKJz/XAA==
X-CSE-MsgGUID: YdaVBJTFRm+f5vE03W1fVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="136912143"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.165])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 14:11:03 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 1/4] platform/x86:intel/vsec: Change return type of intel_vsec_register
Date: Mon, 21 Apr 2025 14:10:54 -0700
Message-ID: <20250421211100.687250-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421211100.687250-1-xi.pardee@linux.intel.com>
References: <20250421211100.687250-1-xi.pardee@linux.intel.com>
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


