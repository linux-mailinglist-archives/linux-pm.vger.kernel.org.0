Return-Path: <linux-pm+bounces-25819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B079A957BF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 23:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB633AFF26
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 21:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697F20FAB2;
	Mon, 21 Apr 2025 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdqEtx6r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539CA20E711;
	Mon, 21 Apr 2025 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269867; cv=none; b=AGarREpEvObUKP78veipzzqutkrrACTqUimxDaBnbD6JK03OLDP/ksM6Vai3YvZl8oKSpPsnHJxGHmHWuvZQvSrz0IywEJL3duvipu//4n5CmMc2h0WqboAH+tbI2SoAQBiSg9oERBaeTKookben40MVRlQg19CeQR0aBP2EVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269867; c=relaxed/simple;
	bh=A+QXCvekbww/SlLYl4ayQjYhJtQtXcwSTl7a1uUUzG0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CBDZVRE+7eKzzscCM1srC9qaIMUUk6OP7HsH8XAm5XSHE9LUud1dZ805gzi9dI0XIWdAft0eP4MxrQxY5N0F2uJOl24X7QmdaTLjVQvA8oJQpqQ89/6nDr9h7PBvSGaD3gzNgXIL+AyBThn+ROMlXKjeYophWldQpp1ALUXvM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdqEtx6r; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745269866; x=1776805866;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A+QXCvekbww/SlLYl4ayQjYhJtQtXcwSTl7a1uUUzG0=;
  b=TdqEtx6rqDyPNZljEQSiewD3xzt4S8ORIxCY+XnhLq0zesrurW/Zc219
   AaXK0z0Tf6Wcy+xie4ej472ifWr4LwxEqvvFDMc9gRWA7bsgObRWtI+9M
   /CtvNRRzR1jNaD5KPdxSoyyiG/3GSnfT8fhu4aM2XQnOpFjb38U0OT+x3
   eesCn6pbtwnsRd0f/rxQhzK/Fwr6k8/S58qXUEkTnD6XyDQ0cXkWCbAst
   NhBUpdcB9QWS47c0eR0pROmaXrYzAHlAGv3JV9Vz9TdmFx+bSoks1j/nr
   z3Fla2w4Ll3EIu7y6fdCCNSUaT1OZLNEzY4r/yOwi+PDNHix8Sryj5M3y
   w==;
X-CSE-ConnectionGUID: bt001XuNQUWwuP84VHCmJQ==
X-CSE-MsgGUID: FH7LhST1R+WyGmtQYa609g==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="58189444"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="58189444"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 14:11:04 -0700
X-CSE-ConnectionGUID: tAfMQPzDRE+5d6M7o5s2Og==
X-CSE-MsgGUID: vYTl9OtGRrOyqOPAySOnOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="136912131"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.165])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 14:11:02 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 0/4] Create Intel PMC SSRAM Telemetry driver
Date: Mon, 21 Apr 2025 14:10:53 -0700
Message-ID: <20250421211100.687250-1-xi.pardee@linux.intel.com>
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

V4->v3:
- Remove the first six patches that are accepted.
- Add a patch to change the return type of intel_vsec_registeri() from
  void to int.
- Change the return type of pmc_ssram_telemetry_get_pmc() so the probe
  function of Intel PMC SSRAM Telemetry driver will fail if
  intel_vsec_register() fails. The previous implementation hides the
  failure.
- Use __free(pci_dev_put) in core.c.
- Move pmc_ssram_telemetry_get_pmc_info() function comment to c file
  from h file.
- Add a patch to improve pmc_core_get_lpm_req() suggested by comment
  from last version.

v3->v2:
- Add memory barriers to the new driver to ensure write/read order of
  device_probed variable.
- Minor grammar changes: add needed white space and end of life new line.
- Add patch to move error handling to init function.
- Remove patch to enable SSRAM support of LNL platforms. This patch will be
  included in a separate series.
 
v2->v1:
- Rearrange and restructure patches completely based on feedback from v1

Xi Pardee (4):
  platform/x86:intel/vsec: Change return type of intel_vsec_register
  platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver
  platform/x86:intel/pmc: Move error handling to init function
  platform/x86:intel/pmc: Improve pmc_core_get_lpm_req()

 drivers/platform/x86/intel/pmc/Kconfig        |   4 +
 drivers/platform/x86/intel/pmc/Makefile       |   8 +-
 drivers/platform/x86/intel/pmc/core.c         | 191 +++++++++++-------
 drivers/platform/x86/intel/pmc/core.h         |   7 -
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 147 +++++++++-----
 .../platform/x86/intel/pmc/ssram_telemetry.h  |  24 +++
 drivers/platform/x86/intel/vsec.c             |   9 +-
 include/linux/intel_vsec.h                    |   5 +-
 8 files changed, 261 insertions(+), 134 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h

-- 
2.43.0


