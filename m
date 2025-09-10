Return-Path: <linux-pm+bounces-34417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA745B52334
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 23:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD81D7A3F1A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 21:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231BE2F6196;
	Wed, 10 Sep 2025 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eth5lI/c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6F1A01BF;
	Wed, 10 Sep 2025 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538396; cv=none; b=ELC1Az6JF2I50Ntf48CB029uaAfERAj90M9g4cBR9LcupqWL3rmmeVRJJu7Vv3sYnZU0vJjiIYTWexMukEdwK2b3SCqC2uO3ZU3rlrEdHWQuNZmieJ58xSPdCGIUmu5ZAd67QBbbkXGzpxwiP3B6MLk3srjf5siZVBRaQq2mlNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538396; c=relaxed/simple;
	bh=tq2CEdp3pIGdWZnYQcR8Ntp+2ltBJCE2s8NiFqGS/wM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iB5/FQ5NIjrg+poR5oCtdfJA2ctHTLsCgIBvQChINFrDSOTdjvsN/VTxL6ocTCyWjyjSEyAoxq2/Hus33fODXYBz11YFvYntAqbzW7kKk9IKSE+bys3V5GKCZa739AtrVMLv0tVbWfS3hCivv1SPmr6ztRs+5DEUEgrQ+UpmwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eth5lI/c; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757538394; x=1789074394;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tq2CEdp3pIGdWZnYQcR8Ntp+2ltBJCE2s8NiFqGS/wM=;
  b=Eth5lI/cHalUKZ982xBa0y0fAQX4//YuPKyZf5cGPiFDWptWY50ltg6v
   329TaoaZ6SV9qY3hr1UsVgaIBYVs3vPusqSzILkExdgfIDoxkwFWMAU8u
   qt/sMPDSNlYXAqSPbyKOny4GjDBtHYuSSkZQZY2jBlkyJnuR/9hGHp59Y
   i9Fmt1dZiOf3pEiSnhqC6/fk24M8eH78FCrD97EW/FXcOw3yDmwkJHeHR
   SsOLKO0Nx2PZ6sAiy62vnzB7qj9B5Lg0mob1uwCesc8fKfur9fLBXueko
   UrSkkvptkEU+u7HLD4vLFCp4ypIpcIy14E08F2PxcKR9PBQKbTiBoGNQD
   A==;
X-CSE-ConnectionGUID: WMLRU9dtSniDn0Dpvqt4hA==
X-CSE-MsgGUID: +K/IgkhwSh2LngCFd0yz+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82448474"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82448474"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:33 -0700
X-CSE-ConnectionGUID: uM7EBbtARMiolm7R+9HhrQ==
X-CSE-MsgGUID: /IH4Ll3vSv+qcl16IiUpSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="177842748"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:32 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 0/5] Enable SSRAM support in PTL and LNL
Date: Wed, 10 Sep 2025 14:06:20 -0700
Message-ID: <20250910210629.11198-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series enables SSRAM support, including achieving PMC information,
low power mode substate requirements in Lunar Lake and Panther Lake
platforms for Intel PMC Core driver. This patch series will not modify
the functionality of Intel PMC Core driver in previous platforms.

The first patch enables SSRAM support for Lunar Lake platforms. The next
three patches introduces a new table in telemetry region to get substate
requirement information for platforms starting from Panther Lake. The
last patch enables SSRAM support for Panther Lake platforms.

---
v4->v3:
- Drop the patch to show device and function number. This patch will be
  sent separately.
- Add a comma in enum definition.
- Use %u for unsigned variables.
- Remove unneeded variables.
- Remove unneeded empty lines.

v3->v2:
- Add a patch to show device and function number.
- Use function pointer in struct pmc_dev_info to determine which
  substate requirement table to achieve and which show operation to use.
- Fix alignment.
- Move variable declarations to appropriate locations.
- Replace char pointer with enum as function parameter.

v2->v1:
- Change to only check ret variable value when getting substate data in
  pmc_core_get_telem_info().
- Return immediately when devm_kcalloc() fails.
- Return 0 instead of ret when succeeding in
  pmc_core_pmt_get_blk_sub_req().
- Replace devm_kzalloc() with devm_kcalloc().
- Add telem_info field of arl_pmc_dev variable.

Xi Pardee (5):
  platform/x86:intel/pmc: Enable SSRAM support for Lunar Lake
  platform/x86:intel/pmc: Move telemetry endpoint register handling
  platform/x86:intel/pmc: Improve function to show substate header
  platform/x86:intel/pmc: Show substate requirement for S0ix blockers
  platform/x86:intel/pmc: Enable SSRAM support for Panther Lake

 drivers/platform/x86/intel/pmc/arl.c  |   4 +
 drivers/platform/x86/intel/pmc/core.c | 182 +++++++++++++++++++++-----
 drivers/platform/x86/intel/pmc/core.h |  16 +++
 drivers/platform/x86/intel/pmc/lnl.c  |  18 +++
 drivers/platform/x86/intel/pmc/mtl.c  |   2 +
 drivers/platform/x86/intel/pmc/ptl.c  |  31 +++++
 6 files changed, 217 insertions(+), 36 deletions(-)

-- 
2.43.0


