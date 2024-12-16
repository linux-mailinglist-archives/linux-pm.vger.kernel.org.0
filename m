Return-Path: <linux-pm+bounces-19347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB29F3CA0
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 22:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078F71650C7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAB61D47AE;
	Mon, 16 Dec 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQksDd12"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938414B94C;
	Mon, 16 Dec 2024 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383894; cv=none; b=M7K5XK//As7xTNZfMYVmRfffUwEF9FMGrSAPAKQJldGm77vBoalg5Lxj9PCnAvda/rnb8021F4oRmqz9Z2Ng4MIqPMn5Dm6ut6KPJCkbS+94QwZVuRiSDWeI/e79RaBpT4wMBvwvHzx4Rxo7ymzh5cED1Z+X2A3eWh/NaxwZZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383894; c=relaxed/simple;
	bh=paOLajdEu9vycL6UvR1V3qrBl7DqDxbhyJBR8TB76RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oezZDhhWgc1SXKcZb2Kk4dWtHN0K9o6lWI8rkRz2nitKfP7gzlg/XFOKA2OIlUV1wWUsgT0gLazb8Oq1SfnwnmrPNGW7wE9C5OK6M+A2yVsXfa8I1jK15Q3hF+wkxlW9S/9mgoCqlsmSrykVAKwEsUCs14HcbBdpI+Ymeht0Yx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQksDd12; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734383893; x=1765919893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=paOLajdEu9vycL6UvR1V3qrBl7DqDxbhyJBR8TB76RU=;
  b=WQksDd12YT7WSnJVmjbsf7VTABX+50KBTX95Othn2WnzvB2N6/4HddyR
   DzWFsVphPk68jJOEXdXmKC76WjEohTZXRLgjFMNOe34WaEKJ8aQ6Ati/L
   uNMX7Z3h0rNcxXWeLXPM0B+leB3mHPiHcRG8/Ga9jsiYYsiEuMijSAmvr
   kaOPwGcJ+0Id96bRKIJLI5rv6g7fVQtyB1KMYkmJS257y26Gj6qV6iZTA
   hg0PzE40CEXjbe61TZLS5+bwbYBXgmRxZbII+R1JXDaHqhR5Z6Ts4R93r
   aw41SYjuSO77IIZoZ6sijtTD7enaWbuYKGfEJI1yBdeRCRNXye0gnvLr8
   w==;
X-CSE-ConnectionGUID: RuXpPW1/RU2cJFroyJLGuw==
X-CSE-MsgGUID: 76NDIWI7R/KCdESbYaIQpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45484871"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="45484871"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 13:18:12 -0800
X-CSE-ConnectionGUID: Uba2lp7qS+mJHzVGrAwPFw==
X-CSE-MsgGUID: Cg+8coEYQGexBbr2LkTVJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97781261"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa007.jf.intel.com with ESMTP; 16 Dec 2024 13:18:12 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] thermal: intel: int340x: Panther Lake power floor and workload hint support
Date: Mon, 16 Dec 2024 13:18:10 -0800
Message-ID: <20241216211810.1207028-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216211810.1207028-1-srinivas.pandruvada@linux.intel.com>
References: <20241216211810.1207028-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Panther Lake follows same register set as Lunar Lake. Enable feature
flags to support workload hints and power floor status.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index fb3820e72c11..1b8ee61cb924 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -496,7 +496,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
-	  PROC_THERMAL_FEATURE_DLVR) },
+	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_MSI_SUPPORT |
+	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
 	{ },
 };
 
-- 
2.47.1


