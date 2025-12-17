Return-Path: <linux-pm+bounces-39641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D672DCC595B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 01:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4BA53020838
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648771B6D08;
	Wed, 17 Dec 2025 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5BQf4T2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7019CD05;
	Wed, 17 Dec 2025 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765931030; cv=none; b=eIuqXFiN8Ym75zZOtqY3fNtVOcZRAhZDxwPpvMmmakwLyL53x9hFKTM3yzHAy01D9dF+AMeJScAkI5mY5yxwG9L1yqeP8aLLovahJ0pHy90cICSzalxRLtz4080OCe2ELMHZqJ5Kbj92xzBbVSaCZG1u6mv5mzCgDyny61tlaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765931030; c=relaxed/simple;
	bh=r2y4uihDv7ddbAOsjdPRCDR143qPo65HR4PD8NwBtoQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d1+1A8LnHDr1LvGkv2KoPCoLRZ3RbVfLlcpU5C/AJpnVVvPxaDVX3+wlTlIVUOmvOChXnOmqUlCGSlL4sRwkjFsuk86kiqX+3LYutmDp/B/5xrcc0Mg8VRtsAZNoV63pem51+v62IVBv3F5nzsD9bBFQT/3j7VK6oUhnOxW5EKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5BQf4T2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765931028; x=1797467028;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r2y4uihDv7ddbAOsjdPRCDR143qPo65HR4PD8NwBtoQ=;
  b=d5BQf4T2ywsRhsj4zucds/Ny/BQ1PihHyNRQ0caqOkr/zy7cD9V22uCk
   wcIYyF5U3Ahjkg6vP/3e395O25TAF3zSTIBgomnACWW+LG+1l3zXSgATa
   0NeXu+lkTRxMlcRRPAIEvbviIRB+p5aeBS/btTUVO26pIRzCGMBZ2DSDE
   lsSCTYwsGHP+jEfvtd9eKsy+Nf0u8MTVy2xS45wjHgtHfD67wzNTJ+mxd
   LOIIWLguYMGPu444y+q0BAulW7OW336oWwSeDfjgc5pFxtU6llXDCf6e4
   d6c5TMnWEaJS0SykN+Cb0SN4LGGv6vO22o7jQVI84zKg/mzE7aGgNW1RZ
   g==;
X-CSE-ConnectionGUID: dX4Xh8NfQjOqOSIv5bnOKg==
X-CSE-MsgGUID: DFAtJmxkQM+319brsajS/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="79228264"
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="79228264"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 16:23:46 -0800
X-CSE-ConnectionGUID: bMJkbgCvRv+rNrORPTB6Og==
X-CSE-MsgGUID: E4f5XyS9Q/WuEcynyP3U1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="228858105"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.225])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 16:23:46 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/3] Enable substate residencies for multiple PMCs
Date: Tue, 16 Dec 2025 16:23:37 -0800
Message-ID: <20251217002343.2289577-1-xi.pardee@linux.intel.com>
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
The final patch enables the substate residencies for multiple PMCs.

Xi Pardee (3):
  platform/x86/intel/pmc: Change LPM mode fields to u8
  platform/x86/intel/pmc: Move LPM mode attributes to PMC
  platform/x86/intel/pmc: Enable substate residencies for multiple PMCs

 drivers/platform/x86/intel/pmc/core.c | 79 ++++++++++++++++++---------
 drivers/platform/x86/intel/pmc/core.h | 15 +++--
 2 files changed, 60 insertions(+), 34 deletions(-)

-- 
2.43.0


