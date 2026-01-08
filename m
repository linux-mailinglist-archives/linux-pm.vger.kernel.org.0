Return-Path: <linux-pm+bounces-40510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F38D066E9
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 23:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15AEC3016927
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 22:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ACD2D6E61;
	Thu,  8 Jan 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mK9jygwR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69C1E531;
	Thu,  8 Jan 2026 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911509; cv=none; b=sv2kQLP+UpCO1p9Oima1QB4HIupm/O9YXpcrwIBjJl4mhCny450rTuTKxZxphI4pHWO8zwfHLcgE51AFa507Dygi22ehFMVptC+I3DVV0wvAid/I7DNFJiDyBtQw5mI5xBK9H5kFfDOQH7N05umycLO/7+xYvNJwMZITFPiSUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911509; c=relaxed/simple;
	bh=CqveTZgZbJzSU8fw9+y/7SDCMc7BC5wtpkeZJFB0C2M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IiTREG4hqoFJDfL/BgvTZqBOZEhjjMmX+k5HP5hGpewENL/RSYb6LoovAMvCEZxf6kOV4/BvaPIQ8MFCisWF/7c48sQN5ZjdqEnaT9ko1pg8XTXrjb4EgTEzBXcOaOWnGgm0t2V36P/b+4M5EjF8JfLz+CCd1jGOS94WVKbxIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mK9jygwR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767911507; x=1799447507;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CqveTZgZbJzSU8fw9+y/7SDCMc7BC5wtpkeZJFB0C2M=;
  b=mK9jygwRT1SlP/ILHQ1taIGGVhlpXtFUZxXc3xev50UgRPXlYMB/PZ8j
   RxPK02IMQpkqgNJnUeZU+36xoARA4ztJNZa//gf6GAc+LxuuWXL1qjqKL
   1S8SjmQVF3AIKieFLubwb4V+D1JYdj0sCrLNaenb1yPoV+MPz6qYczIqv
   ulHqnw+X4g9DGaT2nhAu4aZ1a7wS2c7/+wI+/WMupkZfb+Bkw589q6NSd
   LlD1BzP/US05ZuxpfCmSXhIemH8tndaVD4ayPb1MaHU9qiMct48nAKPTS
   69uU+S0bMukcnGODJGP7iF0HUPcG80ToY5nWDkFs7R4ZOW2MKYOTZYu9W
   A==;
X-CSE-ConnectionGUID: PSp4xQhZTtad8QK+iZqiOw==
X-CSE-MsgGUID: 6NOA5OTbR7eu4iqCkSGxAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69349132"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69349132"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:31:47 -0800
X-CSE-ConnectionGUID: gyU3HS/MQoy7WcauMsSHzA==
X-CSE-MsgGUID: NZDGnZTQQ9e8jNz871LNCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207797168"
Received: from msatwood-mobl.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.109.238])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:31:46 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/4] Enable substate residencies for multiple PMCs
Date: Thu,  8 Jan 2026 14:31:38 -0800
Message-ID: <20260108223144.504267-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series enables substate residencies for multiple PMCs.
The first two patches prepare this change: 

- The first patch changes the datatype of LPM mode attributes to u8.
- The second patch moves the LPM mode attributes from the pmc_dev to
  the pmc struture.
- The third patch enables the substate residencies for multiple PMCs.
- The final removes one empty line.

v2->v1:
- Changed the datatype of mode to u8 in pmc_core_get_low_power_mode().
- Added a patch to remove one empty line.
- Rearranged the commit message of the second patch.
- Used post-increment in for loop.

Xi Pardee (4):
  platform/x86/intel/pmc: Change LPM mode fields to u8
  platform/x86/intel/pmc: Move LPM mode attributes to PMC
  platform/x86/intel/pmc: Enable substate residencies for multiple PMCs
  platform/x86/intel/pmc: Remove double empty line

 drivers/platform/x86/intel/pmc/core.c | 85 ++++++++++++++++++---------
 drivers/platform/x86/intel/pmc/core.h | 15 +++--
 2 files changed, 63 insertions(+), 37 deletions(-)

-- 
2.43.0


