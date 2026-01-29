Return-Path: <linux-pm+bounces-41710-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGsEK9Woe2m8HgIAu9opvQ
	(envelope-from <linux-pm+bounces-41710-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C0B39C9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB72030182A8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905D52F90C5;
	Thu, 29 Jan 2026 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPqaN0gL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BBA2F5473;
	Thu, 29 Jan 2026 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711826; cv=none; b=KPUOmkrZh2ddE/5y576ndN+7aira15a5SeW50VJPr/trUgeYRVEpBt8M0n3pP2krq8aXoRWgBKz/IVzbr1HWNTXLOLqf24bDzfMFH29mwx8lKHtVushFB+t2o/xx+bGDbOt+SW29C888JegfUlvbs8squ+ABGe2daOcv1f7RUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711826; c=relaxed/simple;
	bh=Rg4fy5FFI2O+xvbX3qYzupHqjI1rPbUtjeHqNSmS8gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mSrIG+eJpbSNX5B5iZ6QRkt/n/jO4IER+WETG8ymFHl4kCs8vLw2AXJakFdiYBMwlB0FXqJ1QuBXClVPZYqqctsBLg9jYaQoh/Geh3q8j8KiCBVMybBVPUPvxqRBKpk2/TbPZ1//AnL95pXtV9ivM3o2pC/qpLWl7fkQ3h2f5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPqaN0gL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769711825; x=1801247825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rg4fy5FFI2O+xvbX3qYzupHqjI1rPbUtjeHqNSmS8gc=;
  b=mPqaN0gLNtmrI2uHUa/iNlahZsetM560PoowWs2JaQh3O9aiaOFvq0M2
   MvHqJ/npFAfTThT521BTD+kq2brYlkOYvTcJbr0uLo8JgluuMP0Ry/2zz
   iVS3QQFfSVyyguUN5StgbPIW4wc/kAA9iOU35j7gwRjOwvi1QjMEN40YP
   HVpHujn5Ipob1zC/du/2NgdYC8Q+cz/Eu3wzU4nibzh5EJz0bhWgFqKS/
   ACx+/jWaj6ydfVrQYwx1BhBybDmk3chWZ+6ZT1nwT+owh2EHae6RXqwot
   gdGgjusOz91HVuwSbikTYRaSpqOy1tIZqdvu6wTg9XaT2h5z+7Ut/pOeO
   A==;
X-CSE-ConnectionGUID: De0BzRrVS0+Gophxw7xbAA==
X-CSE-MsgGUID: mumHd3HnRJ23zniJNVYDgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82388338"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="82388338"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:04 -0800
X-CSE-ConnectionGUID: fYh59/ipTrSt6VWz0EsAeg==
X-CSE-MsgGUID: PEQrKjJqSbaeNoFm1NchfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="209070950"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:03 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/9] Move RAPL defaults to interface drivers
Date: Thu, 29 Jan 2026 10:36:37 -0800
Message-ID: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41710-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA2C0B39C9
X-Rspamd-Action: no action

Hi All,

The Intel RAPL common driver has accumulated a significant amount of
interface-specific logic over time. There is very little common code
shared across the MSR, TPMI, and MMIO interface-specific defaults.
Keeping these interface-specific defaults in the common layer therefore
provides no real benefit and instead increases complexity and
maintenance burden.

As a first step toward cleaning this up, this series moves
rapl_defaults ownership from the common driver into the individual
interface drivers and allows each interface to provide its own defaults
directly. Additional interface-specific cleanups in the RAPL common
driver will be addressed in follow-up work. This series is a
continuation of the earlier cleanup and refactoring effort initiated
by Zhang Rui.

Patch Summary:

Patch 1-4/9: Preparatory patches that do code cleanups in intel_rapl_common
             driver.
Patch 5/9: Preparatory patch that renames/declares the common functions.
Patch 6/9: Move TPMI default settings from the common driver into the
           TPMI interface driver.

Patch 7/9: Move MMIO default settings from the common driver into the
           MMIO interface driver.

Patch 8/9: Register the PM notifier only when a RAPL package exists.

Patch 9/9: Move MSR default settings from the common driver into the MSR
           interface driver.

No functional changes are intended across the series. This is strictly a
structural refactoring to simplify the common RAPL code and prepare it
for further cleanups.

Kuppuswamy Sathyanarayanan (9):
  powercap: intel_rapl: Add a symbol namespace for intel_rapl exports
  powercap: intel_rapl: Cleanup coding style
  powercap: intel_rapl: Use GENMASK() and BIT() macros
  powercap: intel_rapl: Use unit conversion macros from units.h
  powercap: intel_rapl: Allow interface drivers to configure
    rapl_defaults
  powercap: intel_rapl: Move TPMI default settings into TPMI interface
    driver
  thermal: intel: int340x: processor: Move RAPL defaults to MMIO driver
  powercap: intel_rapl: Register PM notifier only when RAPL package
    exists
  powercap: intel_rapl: Move MSR default settings into MSR interface
    driver

 drivers/powercap/intel_rapl_common.c          | 755 ++++++------------
 drivers/powercap/intel_rapl_msr.c             | 251 +++++-
 drivers/powercap/intel_rapl_tpmi.c            |  48 ++
 .../int340x_thermal/processor_thermal_rapl.c  |   9 +
 include/linux/intel_rapl.h                    |  17 +-
 include/linux/units.h                         |   3 +
 6 files changed, 561 insertions(+), 522 deletions(-)

-- 
2.43.0


