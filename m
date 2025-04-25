Return-Path: <linux-pm+bounces-26250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9AA9D25F
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705C03AA327
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2435821FF29;
	Fri, 25 Apr 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8PKuBTI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D1A18DB02;
	Fri, 25 Apr 2025 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610787; cv=none; b=icP3tXJQk3Rrb81GBGgdLhQ5IrtSzZbm5KRtLD3NRP5l8Z4U/k6qh6E6DyLoH1K4ekrOEGRGEcTUkkWQs7MbpGjmJeqOnibBt2Jq6D5bOECAmPL+8awdiBEZc6Z+LGgP0lmAZvaztFqUIa2guugH7crs906fflzZUIXHg6+/Xz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610787; c=relaxed/simple;
	bh=+U7mfNionqaziIRwSsiRuUYCyFeS/Go5S59SyviznHE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tEOHX41/c8FXLX56ow4jg0vHhFTWvwpIZ+4yUZgMP/OfqbF8tsXlICt5DyuzN08kh4pt38Xy10BELfIBLnwDHWBTPJVQKgdVvZIXGj8mdHDaF5TI+Vna650QvRGeKdEH6lrfsr+MGxpqMVIWSvr3CrT81gzQwVrxPXKuqBMw1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8PKuBTI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745610787; x=1777146787;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+U7mfNionqaziIRwSsiRuUYCyFeS/Go5S59SyviznHE=;
  b=H8PKuBTIlNrj6GbI6q4eIYlSt5iW3BlEumaAaYjPGZPpy6XNYSAJdIj0
   a7BgeIkV2o2BmKSgoMGTcQaKOpGQ4wFJt6LIFkEc2mn50qb5BfnDR5rx1
   UpMkIZpDuj7ICyR/hxTzV7e/zQeT4Odiq1rvEkRs+6WLjk6vQ3ujOGx5A
   UmRhhRd3wSVRudOYvPaI+68szf/PGsQ8BnVxsFlEimUSLhS4uoqJ0kBpI
   cvje1+yvC2nevg1lhPaVdLa11uToCemcRsDsCLqwm0/+cdE7TkLDzD0Ip
   DIeI76y5+dDqpElFqqWqT/utZ8dz751CGyFlzaoAlQ7+gjBo/OfCSaf9r
   w==;
X-CSE-ConnectionGUID: 6U19qg7iSHGGIFpPja7zwg==
X-CSE-MsgGUID: t5AYOfWyRRGafj7pyf0nhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="69776215"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="69776215"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 12:52:40 -0700
X-CSE-ConnectionGUID: FXmDh9JOTQKnVVOZeWoLEQ==
X-CSE-MsgGUID: lTDeGlyTTo2kI6/o2/I2Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132897638"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 12:52:39 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 0/5] Create Intel PMC SSRAM Telemetry driver
Date: Fri, 25 Apr 2025 12:52:28 -0700
Message-ID: <20250425195237.493129-1-xi.pardee@linux.intel.com>
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

v5->v4:
- Remove unneeded changes in pmc_core_ssram_get_lpm_reqs()
- Replace mutex_init() with devm_mutex_init()
 
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
 
Xi Pardee (5):
  platform/x86:intel/vsec: Change return type of intel_vsec_register
  platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver
  platform/x86:intel/pmc: Use devm for mutex_init
  platform/x86:intel/pmc: Move error handling to init function
  platform/x86:intel/pmc: Improve pmc_core_get_lpm_req()

 drivers/platform/x86/intel/pmc/Kconfig        |   4 +
 drivers/platform/x86/intel/pmc/Makefile       |   8 +-
 drivers/platform/x86/intel/pmc/core.c         | 189 +++++++++++-------
 drivers/platform/x86/intel/pmc/core.h         |   7 -
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 147 +++++++++-----
 .../platform/x86/intel/pmc/ssram_telemetry.h  |  24 +++
 drivers/platform/x86/intel/vsec.c             |   9 +-
 include/linux/intel_vsec.h                    |   5 +-
 8 files changed, 260 insertions(+), 133 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h

-- 
2.43.0


