Return-Path: <linux-pm+bounces-9573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D97590EB61
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13D3283854
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3FE1474AD;
	Wed, 19 Jun 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyXrgvPP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5BF143881;
	Wed, 19 Jun 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801172; cv=none; b=A1Ahx+tIxnRZBUlqPd7hKQl79TJBNb82HClxhhz+8Xlwebv+qEB1uRvSSaSIMpPFvalbsLYUDmW5EITAhH7sJ8BuLK5MH48bH/477DwVXEM5i8q9fJVjDZjVtU8kgXXBMK0vYLOqmO3jXSmQoA2V7TPZqxYrmYliliDluow0x4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801172; c=relaxed/simple;
	bh=J8cmEBJjdYlKazSoGnZIbk+FfXHSa+X4MTcD7rK1X5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCeX7pqypZDnG75vyrnMOShnUwFo4R7CghR+uixvugOPOZugoNFxIQ1l6ZAah6j/2Tc2wJ+EmA39Vrmo3AxQOfvIMfJzoua0fhB2+pdnqTDK3NLgqLJ4LE0Nz0zg24aDd9IH7pAUJ071ju5eXaB7mjXj1SIwlzeAKa3omfM1sSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyXrgvPP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718801171; x=1750337171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8cmEBJjdYlKazSoGnZIbk+FfXHSa+X4MTcD7rK1X5g=;
  b=TyXrgvPPxAB9wWSkrA1zrl91FSQMMrjOsLujHebA9bbwslTEDPTDdlxJ
   Q98FARBj+PvXDUctH07px1OX2nNZ3puprakAqAKW3jK24WuF8v8K+zf9/
   s8tAtF+5pQZ2AcpJgc95SUiwgn1MDxuUlI5amwhQ4yuu3Pp7wCo+f3gn8
   vMtIU47vutrA395NJtIQykj0z1bc3sISqIBSCjoCIRZNfJIRNOpQUCgje
   oLu7qU/4GEBTKHvcbE5FM0eIu2G+lI8P7wjQIPBksLWZnBdfYqo7PEjr1
   lhbpwlk1l3j49cXPoMzvQY7lOME7kJOqjSx31aPb1RlFe/p/w3lcFjPd9
   Q==;
X-CSE-ConnectionGUID: v4J5tPvRReyRCXIIMt8XcA==
X-CSE-MsgGUID: EHekYsg4SCORV9DkyvLdPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15449935"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15449935"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 05:46:09 -0700
X-CSE-ConnectionGUID: p0QTpTw3ScujcdtkhWiMTA==
X-CSE-MsgGUID: w7Fg36oBQtmB2y3KGIcc2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="46344341"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa005.fm.intel.com with ESMTP; 19 Jun 2024 05:46:08 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] thermal: intel: int340x: Cleanup of DLVR sysfs on driver remove
Date: Wed, 19 Jun 2024 05:45:58 -0700
Message-ID: <20240619124600.491168-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619124600.491168-1-srinivas.pandruvada@linux.intel.com>
References: <20240619124600.491168-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When only DLVR enabled without DVFS, during driver remove,
proc_thermal_rfim_remove() is not called. Hence the DLVR sysfs is not
deleted.

On Lunar Lake DLVR is enabled without DVFS, hence this issue can be
reproduced.

Check also PROC_THERMAL_FEATURE_DLVR to call proc_thermal_rfim_remove().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../thermal/intel/int340x_thermal/processor_thermal_device.c   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index d75fae7b7ed2..7c46dd6bee73 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -440,7 +440,8 @@ void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *
 		proc_thermal_rapl_remove();
 
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR ||
-	    proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS)
+	    proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS ||
+	    proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR)
 		proc_thermal_rfim_remove(pdev);
 
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_POWER_FLOOR)
-- 
2.40.1


