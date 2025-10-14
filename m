Return-Path: <linux-pm+bounces-36096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7668BBDB6F6
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 23:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AAE188F746
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 21:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C502EA173;
	Tue, 14 Oct 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTthmD62"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE21FC3;
	Tue, 14 Oct 2025 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478382; cv=none; b=WBXqsxV98f48NWjWX8ejCx4vKwrjv3fTjpMMc5ESvgcu8p9bv3DTi7rhGUSRHOymzb9ffQy9Xepg1xQoHJ3w5tiCevdlzbK/PLVwWowUc6UhcQUqMubs9YJ54ttWNAMMj7MgKP0kEHazy5RQQaPKWaIo6NBON1IiH3jFuOV3Fmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478382; c=relaxed/simple;
	bh=AHlYYVa0PMPbNm5l5VSaMdqIRIUjjT7JizLHywZe0bM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZsYD5tBcLnDt441p46uy6fi6zF4jFDqYkQ5H2fe00Y9ylUno4kCmmETBcCL19NO+8eKnGHTcmroLHUiHcPyCWZHy/PPK4A9TFTNHY84Tei0a0od1rgnpzBtSIYbR8AJ0T7N0/sVvQv8CfU1LpQx/PwpZNy3ttSU5yGmTWNSm5cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTthmD62; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760478380; x=1792014380;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AHlYYVa0PMPbNm5l5VSaMdqIRIUjjT7JizLHywZe0bM=;
  b=MTthmD62Ap7iQ+jBWnZJhD5XNjFJUeQR7elFZb/FfRSxd6xWfyV2MVjR
   V/bRE5dKTNjsNVPStPiAJ7osUnTbL6mPbGQ5fzOjqesz9UDDHGSVl9879
   03zsPHepVDoFjr2eCgDSnHlFDO/ZqlKflziPKpExmdEgF+wyw1Y6j82z+
   dI8MZigfrZrgkiuZBkF7bFsLWunVA3e1ywemMr8+wJm25dJkzH9EQdeTk
   4Cyb1m9bfrvK+6PWUiEwsFMp8SbQEs3mp2Gds9bl/BKGOqrqEa6L6AUOM
   Nxmr4TTmXpbgQrTBbLEPX4d6jf5DQ1aiS49LIe883sFuY+/RZFB7T4GPO
   Q==;
X-CSE-ConnectionGUID: bJXuC0WzSRWTgpqn+Loitg==
X-CSE-MsgGUID: NzlGMQLBRgKdNeAm3ZH9sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62682436"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62682436"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:20 -0700
X-CSE-ConnectionGUID: TXjJl8f3QcycRJhLETeo+g==
X-CSE-MsgGUID: UjJTXJ/TTUeVridYWt63uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="187300315"
Received: from kcaccard-desk.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.111.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:19 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/6] Update Arrow Lake telemetry GUID
Date: Tue, 14 Oct 2025 14:45:28 -0700
Message-ID: <20251014214548.629023-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series updates the Arrow Lake DMU telemetry GUID and enhances
the infrastructure for managing lpm_req_guid. Additionally, it includes
two patches that improve the intel_pmc_core driver.

The first three patches update the Arrow Lake DMU telemetry GUID and add
support for multiple possible GUIDs. The fourth patch standardizes the
naming convention for PMC variable indices. The fifth patch enhances
lpm_req_guid management. The final patch removes an unnecessary variable. 

Xi Pardee (6):
  platform/x86:intel/pmc: Update Arrow Lake telemetry GUID
  platform/x86:intel/pmc: Add support for multiple DMU GUIDs
  platform/x86:intel/pmc: Add DMU GUID to Arrow Lake U/H
  platform/x86:intel/pmc: Rename PMC index variable to pmc_idx
  platform/x86:intel/pmc: Relocate lpm_req_guid to pmc_reg_map
  platform/x86:intel/pmc: Remove redundant has_die_c6 variable

 drivers/platform/x86/intel/pmc/arl.c  |  12 +--
 drivers/platform/x86/intel/pmc/core.c | 150 +++++++++++++-------------
 drivers/platform/x86/intel/pmc/core.h |  14 +--
 drivers/platform/x86/intel/pmc/lnl.c  |   2 +-
 drivers/platform/x86/intel/pmc/mtl.c  |   9 +-
 drivers/platform/x86/intel/pmc/ptl.c  |   3 +-
 6 files changed, 97 insertions(+), 93 deletions(-)

-- 
2.43.0


