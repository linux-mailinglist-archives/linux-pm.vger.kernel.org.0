Return-Path: <linux-pm+bounces-25036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E218A8301F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2883B7266
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738327703C;
	Wed,  9 Apr 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsWfKANM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967DB1C5D63;
	Wed,  9 Apr 2025 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225864; cv=none; b=BJaZj4McLzz16rNKI0FjSM+ZTEH++d6D4xYvdFuhYZCmO8U+tOG1SvM6NJy2RDGgiDrsoCewPM5XlpiLgvMZ0fzhdwD/xaqoo/wneWDQ8PYaCGd3Da83WoO/n0dxo/jNDZ3Qev5vMts2ySDHaBEvA60tVMAE0ztMhgxBZIsEDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225864; c=relaxed/simple;
	bh=6mMrDo9Cf49gvw6bR1Szma/66Mi5qs3+DiyVk29NokQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y06FhLNqZhb7tgvwcSy9KfiVrZr/GeoOL9hx+5Oj2PyXvnrAyp+tdjcVP/moe4YBjULilF88eSljGbym6K9LOw4rQVALe5Bw0WkJkv3Y9db4x/bFFKZ5s+ju+snMMbMJHBSWg3wbsuNW36yK0ChahC5pxqIiOJRacGVRUI2Vf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsWfKANM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744225862; x=1775761862;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6mMrDo9Cf49gvw6bR1Szma/66Mi5qs3+DiyVk29NokQ=;
  b=CsWfKANM58Rl1Gk0KmKbVYtV075y/BiOlQXebKFDyuVEN7FqdKgapxoB
   6pK4UW1I/UsbXQHsP4uigkElu4yGGrWJU3br+wQ7/Kk5BmWFch/3JkLOA
   v/j2p72cKn0Tf5E8G/eytwJDYi5BQABWPl5mmEnSsKoL+kQVVZkICt4wU
   dE2zK5idNDlR79CiRGG2oVLAMbfPSXECKp8LW5VJwERQOVjC4bXYZ/div
   5jjvPr/Gpq+pBBeua68pq7iDGe5zXWd+UBBEtPDwDxZW0GdDb0LbZVOG6
   +EXI8+8126JL4JinUi6vRTzH/6FFVy2Tz3CM+m9dE8xTXI812tRbNuEa/
   A==;
X-CSE-ConnectionGUID: s7ckzIDwR7qMQMCJv1U8EA==
X-CSE-MsgGUID: shpQjbBqQsuhGUh8re3q/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56386757"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56386757"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:01 -0700
X-CSE-ConnectionGUID: HrgKuIVSR+qqy9C+3g+XqA==
X-CSE-MsgGUID: UUiZdih+RXSrjJ28o7kipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133401205"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.250])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:00 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/8] Create Intel PMC SSRAM Telemetry driver
Date: Wed,  9 Apr 2025 12:10:42 -0700
Message-ID: <20250409191056.15434-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series removes the SSRAM support from Intel PMC Core driver
and creates a separate PCI driver for SSRAM device. The new Intel PMC
SSRAM driver provides the following functionalities:
 
1. Search and store the PMC information in a structure, including PWRMBASE
address and devid for each available PMC. Then Intel PMC Core driver
achieves the PMC information using the API provided by the new driver.
 
2. Search and register Intel Platform Monitoring Techology telemetry
regions so they would by available for read through sysfs and Intel PMT
API. Intel PMC Core driver can achieve Low Power Mode requirement
information from a telemetry region registered by the new driver.

The above functionalities was previously handled by Intel PMC Core
driver. Intel PMC Core driver returns -EPROBE_DEFER when trying to read
data from a telem region that is not available yet. This setup may
result in an infinite loop of .probe() calls as Intel PMC Core driver
creates child devices. Creating a separate PCI driver avoids the infinite
loop possibility.

v3->v2:
- Add memory barriers to the new driver to ensure write/read order of
  device_probed variable.
- Minor grammar changes: add needed white space and end of life new line.
- Add patch to move error handling to init function.
- Remove patch to enable SSRAM support of LNL platforms. This patch will be
  included in a separate series. 

v2->v1:
- Rearrange and restructure patches completely based on feedback from v1
- Here are the patches:

Preparation for the new SSRAM Telemetry driver:
  platform/x86:intel/pmc: Move PMC Core related functions
  platform/x86:intel/pmc: Rename core_ssram to ssram_telemetry
  platform/x86:intel/pmc: Move PMC devid to core.h

Minor bug fix:
  platform/x86:intel/pmc: Convert index variables to be unsigned
  platform/x86:intel/pmc: Remove unneeded h file inclusion
  platform/x86:intel/pmc: Remove unneeded io operations

Create new driver and convert PMC Core to use the API:
  platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver

Enhancement:
  platform/x86:intel/pmc: Move error handling to init function

Xi Pardee (8):
  platform/x86:intel/pmc: Move PMC Core related functions
  platform/x86:intel/pmc: Rename core_ssram to ssram_telemetry
  platform/x86:intel/pmc: Move PMC devid to core.h
  platform/x86:intel/pmc: Convert index variables to be unsigned
  platform/x86:intel/pmc: Remove unneeded header file inclusion
  platform/x86:intel/pmc: Remove unneeded io operations
  platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver
  platform/x86:intel/pmc: Move error handling to init function

 drivers/platform/x86/intel/pmc/Kconfig        |  14 +
 drivers/platform/x86/intel/pmc/Makefile       |   8 +-
 drivers/platform/x86/intel/pmc/arl.c          |  13 +-
 drivers/platform/x86/intel/pmc/core.c         | 238 ++++++++++++-
 drivers/platform/x86/intel/pmc/core.h         |  22 +-
 drivers/platform/x86/intel/pmc/core_ssram.c   | 332 ------------------
 drivers/platform/x86/intel/pmc/mtl.c          |  10 +-
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 195 ++++++++++
 .../platform/x86/intel/pmc/ssram_telemetry.h  |  35 ++
 9 files changed, 501 insertions(+), 366 deletions(-)
 delete mode 100644 drivers/platform/x86/intel/pmc/core_ssram.c
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.c
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h

-- 
2.43.0


