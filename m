Return-Path: <linux-pm+bounces-42033-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIHwOSHYgmnCcwMAu9opvQ
	(envelope-from <linux-pm+bounces-42033-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:24:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE5E1EC1
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64F103015CBC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 05:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D50356A1F;
	Wed,  4 Feb 2026 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbdQAlnn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749698460
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182687; cv=none; b=PfimyKmI8FKsHKDFQiHIVYELMf4R65kWGxvQTy5QWvXuPT4Ba+Ccpo5FDd0u42gBjJTKD1cunw7Hx0tXIP/lSjXW3cddWr2O+gZkyVzHLJXKMEu1aoZDI0X/NaR5Nt5r0DWIqPiirlqsqzf3zwQgMjjR15i89Pm7pGY+Lc00IDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182687; c=relaxed/simple;
	bh=t3oYOCMAKNy/jvMS5ijQcnoTQlBaCUL9PygzYteYCQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffYn7bmUgeiWujzaAQz7HHeUpuHXiszMaNYBDcn5Kw3VEEfAzwAcj+7CqQ6aaiV5rvZZmrITvC/z25eqd8N6NvwbKCCjgiHtpjD1n9iwrGbHg5im5SG5P50qkcqjopOK/LTfTuaJHH5e37B88d1eywV5gSyyL2ctrlIfW8PJYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbdQAlnn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770182686; x=1801718686;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t3oYOCMAKNy/jvMS5ijQcnoTQlBaCUL9PygzYteYCQo=;
  b=FbdQAlnncU9V0C2+OIpAX2hr4uBbnUT4WBxKuNeMPNBqi4pbFSrZkR/L
   b/g9EYPuIvXfkrifdf4RiapHMPUeGzcDOqizUD0cHylu7JRMRR3RnTYlc
   Pyx0IXNzXeHKSYbbHD6ooqc8Qx1gh9wO1zUHSCDPBjaXbkKbmXSBG4PYm
   S+rVIyC0Wmr6zgKS6NTn4/7RA7a57RCboxkuNq4m0T0CPOexqhwlbeWz4
   5x0lbCRrtWp+TflNjbvQCtTOs0i6R+cEY6vjCKHThHnZ7THSoQFOqTHfm
   Qi0VvUmaQ1xfNIvtjFpakH/fqDcKbz3Ai4TPhQR8/hHeo+v95YyHCGPKP
   w==;
X-CSE-ConnectionGUID: uL//9elSTROYIvzd6ww9tw==
X-CSE-MsgGUID: NKsR72FuRPGVRMHvwuc4dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82795489"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82795489"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:24:46 -0800
X-CSE-ConnectionGUID: 0YN1SzQpSUC/z0D1NJ/Vdw==
X-CSE-MsgGUID: W8c67mPETpi0MtJz2OQ//Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214543197"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 03 Feb 2026 21:24:44 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH 0/3] cpupower: fix resource leaks and unit labels
Date: Wed,  4 Feb 2026 10:51:39 +0530
Message-Id: <20260204052143.3281063-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42033-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 3FBE5E1EC1
X-Rspamd-Action: no action

This series addresses multiple resource management issues in cpupower
utilities:

- Patch 1 corrects swapped unit descriptions in powercap output where
  power_uw and energy_uj labels were interchanged.

- Patch 2 centralizes cleanup logic to ensure bitmask resources are
  freed on all exit paths in the main program.

- Patch 3 fixes a memory leak in print_man_page() when execlp fails.

Kaushlendra Kumar (3):
  cpupower: fix swapped power/energy unit labels
  cpupower: Fix memory leaks on early exit paths
  cpupower: fix memory leak on execlp failure

 tools/power/cpupower/utils/cpupower.c      | 25 ++++++++++++++++------
 tools/power/cpupower/utils/powercap-info.c |  4 ++--
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.34.1


