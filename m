Return-Path: <linux-pm+bounces-33020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8963AB34099
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FF91A84C1B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EDA2749DA;
	Mon, 25 Aug 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKHFNu2y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A42727F9;
	Mon, 25 Aug 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128205; cv=none; b=O3kfzluLnpbldv0iC0qBGn3Kf4eRdPEd/n1OsDjTlJOfcOaT2VUwgFAes0DEFJX9CEm7e3pKKRTpY2uG3OYThi4QWStSNytD7//KAnnzGXqOTgjeJyBNM8kc0ETyU3WH9eNiHIr4C+VUPbl6C/bXlvh7JOVOPnKYpxxTfULd94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128205; c=relaxed/simple;
	bh=tYIs86E0WF9abR3jj8G1FDvDW6aeVENFNN9gTh43cAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0Vux6S4UuV35rhIoKzdTv0dFPzqvHbEOSOdEaqJa8S9usmW58f+JxXWgYpzNt6nuKWQF4q2rxrbiaxiVIQ9nk4P2OJD/gXvdwH0rntqyqcFm57JI9Hpdvp5dWUn/k/CXcmbbIywAK9ozqC+tqhOisVeJWMf8RRCXiiDw845uVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKHFNu2y; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756128204; x=1787664204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tYIs86E0WF9abR3jj8G1FDvDW6aeVENFNN9gTh43cAc=;
  b=FKHFNu2yjaE55X9Q6ChaiH3oZjN9NM/b2Qq4F8EbloOGlm2rTLdo7oru
   cMHmzbsNtSrbeleRI/WWs/pyWFmG3N1aBUKyLZLDgxEGBbNTF+tWI0ZZl
   yLljrMK8TbTyBiRij9cYtyFB3hNn1uc9vnq7644+0DlVRzJ7Mex6jMKhR
   z/bi29xZHkAgrglkqnVYNaAkPuUH4mqj8L+NJF8SuJOBEznb8W5zv+BU4
   tCwkcW9+y9PuAHvsj9SkfEGc6UCVB232LTzwbg5mR5xJv4GMZW5QiE7qU
   d8hco3zRl/Tb+au0/J0tyKFtEpnrATq2c4Tl+xk47YpUbDTJ46TgMYZHF
   g==;
X-CSE-ConnectionGUID: hE3b3zwSRX+Y/o8RHX9quQ==
X-CSE-MsgGUID: GwnaSCknTwm/iZeVelzOLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58048401"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="58048401"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:23:21 -0700
X-CSE-ConnectionGUID: qnhYEOj6SASEOWdIwH+pMQ==
X-CSE-MsgGUID: 8FQ6OM01Qf+Rs7VRK+Gt6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="169485278"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa008.jf.intel.com with ESMTP; 25 Aug 2025 06:23:21 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/4] thermal: intel: int340x: Enable power slider interface for Panther Lake
Date: Mon, 25 Aug 2025 06:23:13 -0700
Message-ID: <20250825132315.75521-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825132315.75521-1-srinivas.pandruvada@linux.intel.com>
References: <20250825132315.75521-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the PROC_THERMAL_FEATURE_SOC_POWER_SLIDER feature flag in
proc_thermal_pci_ids[] for Panther Lake to enable power slider interface.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Change header to include "Panther Lake" and edit description

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


