Return-Path: <linux-pm+bounces-13082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEDE9634B5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49FFB227DE
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C11AD411;
	Wed, 28 Aug 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzSN7URj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921E165F16;
	Wed, 28 Aug 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884178; cv=none; b=ppo/2QSPrennXAmvcj0QO8NwazIIpY9hODNzNL1I7q59LrkpsuDL5sLaz/476kEGmKzwu0upqFwtonveBKccF+sqRjf2xnSwfpi0jRTMhmA3MBuMSKL9YicLp0pzYcMcEqilBeIwuAvTJOXrruOKHjw0BlprcRwI932WczW7dkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884178; c=relaxed/simple;
	bh=WusbA/vJjuZ2V8MgDG+Z6u6P7ZSeavWArk0uKL7MAK8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H+ZC4nDnjDKfGz+26Muu7i1QF1JxxI1YERpUrMRJAa2AHHVDVaDptKkYzW3D+s4bus9DJp8H6u0hr5wzrVMuqkON4ZeVPLcfcOr4RT1q/x3hOT+icr3lVdVjZkIc7n0tiaH/qswQV8OEEpJP0L5ZPfOR9xhcGY2cU8LIZgahSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzSN7URj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884176; x=1756420176;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WusbA/vJjuZ2V8MgDG+Z6u6P7ZSeavWArk0uKL7MAK8=;
  b=QzSN7URjKdd9XWU8q8A4BHA69LT0kXjV1dzKhdTHFfz3Q4Fd2/cTDGNW
   UeijoiPILzJLLk5LAAuiPLjwOZOT8hjUhdZXTY2o0QfZWOiHefcOyGGu3
   EqUsGEAwoWQksPvEHGSTy3cQ5WH0b1im2TEx01MBr5UIXAmL/EkImMbs4
   O18URpmGrlhheQM5K/IpYS2txBYz4H1vm1YG0Tv1nJCThsBFSXY8NZt0e
   qiESBq6mZ/yy6kujvw9xKAFAueiVsxBl6ERz/PvDCGHBLLVH7ZDqtKOTl
   CInfr4+GOX+l8oYHQmRy4JgEww2Y0s8xzKM+IUAnFooqIqpj5UIF8xgaX
   w==;
X-CSE-ConnectionGUID: zJXihTFBSg+K2aKyT0fl/w==
X-CSE-MsgGUID: NXnIvK71Tt2GWgHO2+H3Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406453"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406453"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:36 -0700
X-CSE-ConnectionGUID: +YsCC3qVQQaxaRlDmlLCqg==
X-CSE-MsgGUID: AwmtA1CfTbKgA39u26rd7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271789"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:36 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 00/11] Create Intel PMC SSRAM Telemetry driver
Date: Wed, 28 Aug 2024 15:29:15 -0700
Message-ID: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Changes in v2:
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
  platform/x86:intel/pmc: Check return value of ioremap

Create new driver and convert PMC Core to use the API:
  platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver

Enable Lunar Lake platform:
  platform/x86:intel/pmc: Add Lunar Lake SSRAM devid
  platform/x86:intel/pmt: Get PMC from SSRAM for Lunar Lake
  platform/x86:intel/pmc: Get LPM information for Lunar Lake

Xi Pardee (11):
  platform/x86:intel/pmc: Move PMC Core related functions
  platform/x86:intel/pmc: Rename core_ssram to ssram_telemetry
  platform/x86:intel/pmc: Move PMC devid to core.h
  platform/x86:intel/pmc: Convert index variables to be unsigned
  platform/x86:intel/pmc: Remove unneeded h file inclusion
  platform/x86:intel/pmc: Remove unneeded io operations
  platform/x86:intel/pmc: Check return value of ioremap
  platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver
  platform/x86:intel/pmc: Add Lunar Lake SSRAM devid
  platform/x86:intel/pmt: Get PMC from SSRAM for Lunar Lake
  platform/x86:intel/pmc: Get LPM information for Lunar Lake

 drivers/platform/x86/intel/pmc/Kconfig        |  11 +
 drivers/platform/x86/intel/pmc/Makefile       |   8 +-
 drivers/platform/x86/intel/pmc/arl.c          |  24 +-
 drivers/platform/x86/intel/pmc/core.c         | 200 +++++++++++
 drivers/platform/x86/intel/pmc/core.h         |  23 +-
 drivers/platform/x86/intel/pmc/core_ssram.c   | 326 ------------------
 drivers/platform/x86/intel/pmc/lnl.c          |  41 ++-
 drivers/platform/x86/intel/pmc/mtl.c          |  24 +-
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 183 ++++++++++
 .../platform/x86/intel/pmc/ssram_telemetry.h  |  45 +++
 10 files changed, 525 insertions(+), 360 deletions(-)
 delete mode 100644 drivers/platform/x86/intel/pmc/core_ssram.c
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.c
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h

-- 
2.43.0


