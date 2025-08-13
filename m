Return-Path: <linux-pm+bounces-32349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB921B25364
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 20:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB717B75F0
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 18:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70A302CDF;
	Wed, 13 Aug 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ny6o9SDi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F342FF15E;
	Wed, 13 Aug 2025 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111338; cv=none; b=cvCbPRi2Zmqr6lKaqBgUUDdIIQs6IJdOcHmvzW9nMCKb3o6upol96KRs/WOfgAy/PgRGHnGVS8FDeWpdkWQ5Spt5JU0vXw5wWNDvoyiy810W7R3KBrfPKrCDFmnfwQGEistebkXbVA7j7bgiLXHRbu4UMsMUVtxgipMQO4/bSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111338; c=relaxed/simple;
	bh=kLnHQ3zpn7XOHx9rL75UtBJGklUswj7YH4jIS0oKVIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khgNlN60BJAXOKmH1nbBOTeq6lT/7z89PqPtHSqyB9IkQgaXaT4CwkcQgpvti8RzWPadE5SrtEEybZ80tIxapoRrZgBgEWMloAcUDX9oYEluUJjWsXelIeQzJqJqGCYFDf16MwzElClGHH2XxX4hQLwkIC9Lmq/QulQrav+2Tmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ny6o9SDi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755111337; x=1786647337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kLnHQ3zpn7XOHx9rL75UtBJGklUswj7YH4jIS0oKVIM=;
  b=Ny6o9SDiyFc3XUCVhbJZRm2YlzgKsjo3h/CcUTY5YX4F/LE+sJlgnUE/
   VahxyyAhDfFdZ0mHjXzECY5qb5/1GTaBTh1YTWFt0pTa3PfngWeKIpRqL
   bEjiiWGhla7XzEpyJUUIZgGZfFZd9wQmy7m/nNBbV58T8M9g1VwYU6JIJ
   ef1sGUxNu7YBtbO+BZtY+/8WLTw7zm2pmDsxMP8QzGR6cEaW80/pO1zdm
   DZNrSn4WvT2AuL4eODGqrQwY7bk9ucan9sU/CED+KMVpqXjgr800bPrGc
   LO75tG9eTCIFMIZ0YUEz1tY0CxaJZsLJ6jJ8iAK32wW+vVFX9wFlxdmQe
   A==;
X-CSE-ConnectionGUID: PcqHpDS/TbGvgeSE0P2Jzg==
X-CSE-MsgGUID: Q8LC+t7uRDK6PAmv36pr8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56631236"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="56631236"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:55:35 -0700
X-CSE-ConnectionGUID: yaHAKAZYQt2/Aq6J6oGC8g==
X-CSE-MsgGUID: EuW1ZCQURmyi/4/syNCC/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170755037"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2025 11:55:34 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/5] thermal: intel: int340x: Enable power slider interface
Date: Wed, 13 Aug 2025 11:55:27 -0700
Message-ID: <20250813185530.635096-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
References: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable power slider interface for Panther Lake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index d4d7e8e147d2..e2471768d355 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -498,7 +498,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
 	  PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT |
-	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
+	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
+	  PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
 	{ PCI_DEVICE_DATA(INTEL, WCL_THERMAL, PROC_THERMAL_FEATURE_MSI_SUPPORT |
 	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
-- 
2.43.0


