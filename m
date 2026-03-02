Return-Path: <linux-pm+bounces-43450-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGmLHvYWpmkCKQAAu9opvQ
	(envelope-from <linux-pm+bounces-43450-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:02:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB2F1E62F9
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 685D23023DA6
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 22:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50FB31E84C;
	Mon,  2 Mar 2026 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwIrpcw2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92577282F27;
	Mon,  2 Mar 2026 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490739; cv=none; b=o+JZbvqJ6yrHE4ZZ5rMYRiRIO6/oUGapgtSv6fiWFPm2bxNR3Se4CAMpoHJwojjeftD4SBa0OBAxZJaUHYAuRAlBTgVyjd4XrG0O/YJnKoM1ztI6tNzBo5GJRXT3bCTTxF9qyJzAZiXObuSirsHaCsRkN+ZF7Krj4uxTcMtd1xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490739; c=relaxed/simple;
	bh=7shjL7vCykEmGwXLfMogj+pQx3QqpZJ5Tzh+aSx2p8U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cO4AF6YC867mAnXiXJcPag/Nu0mbt62bDCJSy8PMTI41wLNY9lzUqJQlFn2PtdwBU6vHoMhJ56rqkJwkVwJEzx3UMtd4qENIuAZdvRmsNxGOIi0Stp8flQfixTexWPeUPTuvzx3/M/bn9SwTyyA/NMYJmRiYK6D7KtGlkOA3E3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwIrpcw2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772490737; x=1804026737;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7shjL7vCykEmGwXLfMogj+pQx3QqpZJ5Tzh+aSx2p8U=;
  b=GwIrpcw2SORFyHYF0DGC2KWDzbQNztgNbD0Ykg3kIVyfztY5I3jnlUDO
   UvbV7q+DOTIILwtJREK8VrqOXFBg1DrzBoK1vspUL3jEZdTEqVotC2+XK
   sj3CSvdIzeRCtTf1NoBit1mc/WAuzuqIiNZGT4m/B3Dz/ThI0vtpdy6sD
   RJ/cy/aswGUjFiRy3Y0rUU6tT2omWBniCG0KMTrild23wz5vVeHzMGHsn
   10WCDhz28SoZxyRp6isnsbqYms9XzDWRXFt28iyOeJEbw9XTjJn43s7lH
   qhhiszwyIYWSsoRrIpGfDhIVHb2mkQqJhNvZkFtN3slLNtC4RNbG0cibG
   Q==;
X-CSE-ConnectionGUID: uURS5/+sQo2Tl8uT922iqA==
X-CSE-MsgGUID: kvBxLjKiS86bvA820E5xjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73554497"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73554497"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:17 -0800
X-CSE-ConnectionGUID: 0gHLMPaIQ4aOTN8RsaN+Qg==
X-CSE-MsgGUID: +VoQTKZCRhWmWwM8ckJWbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217793506"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.108.86])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:17 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/6] Enable NVL support in intel_pmc_core
Date: Mon,  2 Mar 2026 14:32:02 -0800
Message-ID: <20260302223214.484585-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0AB2F1E62F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43450-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xi.pardee@linux.intel.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This patch series introduces two new features, enhances existing
functionalities, and adds NVL support to the intel_pmc_core driver.

The first two patches add new attributes to improve Package C-state
debugging. The third and fourth patches refine current functionality
for better support. The fifth patch enables the intel_pmc_core driver
retrieves PMC information only for available PMCs. Finally, the last
patch adds support for Nova Lake platforms.

Xi Pardee (6):
  platform/x86/intel/pmc: Enable PkgC LTR blocking counter
  platform/x86/intel/pmc: Enable Pkgc blocking residency counter
  platform/x86/intel/pmc: Use PCI DID for PMC SSRAM device discovery
  platform/x86/intel/pmc: Add support for variable DMU offsets
  platform/x86/intel/pmc: Retrieve PMC info only for available PMCs
  platform/x86/intel/pmc: Add Nova Lake support to intel_pmc_core driver

 drivers/platform/x86/intel/pmc/Makefile |    2 +-
 drivers/platform/x86/intel/pmc/arl.c    |   11 +-
 drivers/platform/x86/intel/pmc/core.c   |  141 ++-
 drivers/platform/x86/intel/pmc/core.h   |   64 +-
 drivers/platform/x86/intel/pmc/lnl.c    |    5 +-
 drivers/platform/x86/intel/pmc/mtl.c    |    6 +-
 drivers/platform/x86/intel/pmc/nvl.c    | 1537 +++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/ptl.c    |    7 +-
 drivers/platform/x86/intel/pmc/wcl.c    |    5 +-
 9 files changed, 1743 insertions(+), 35 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/nvl.c

-- 
2.43.0


