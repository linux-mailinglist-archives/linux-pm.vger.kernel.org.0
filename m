Return-Path: <linux-pm+bounces-38324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D45BC76B3E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 01:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4718A4E2295
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 00:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56ADFBF0;
	Fri, 21 Nov 2025 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJQ/cS1B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16F6A33B;
	Fri, 21 Nov 2025 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763683634; cv=none; b=BDfbaNa5BIlrqpwuy0Pk+O2mcEgAqpzRz95N4Xw0+PVPkuAbVZvHlFb2AWMC13N5FPkMLONMLrMXvpfEAhUghxtmdA4c4xscSZpH/v3vC2eoYxaLSb+CUzOcVrN+u3oQZGj82KX3ks9ip4rxLgDAoYVNT1Zqk+yRGV2pvtddffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763683634; c=relaxed/simple;
	bh=ykTH+hp5CC6Ig2TijdzBolxEmfuAjW0mLPjGR2i280k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjz7jSb8+OlhKNRe/fGacUiGgrXuQ5RILN5fJ7GervX5vNomlM9mSxCBTZrc7z3A7H8OR63FYB1AVeutbHAgPAaNqhVD5LR6F3L4+27Kox8FMSaGvYtTFbA1AEizPgvrQR320Ke3XqnxcySTvqHWbxInTWhzvhV0tt1sH+6hX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJQ/cS1B; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763683633; x=1795219633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ykTH+hp5CC6Ig2TijdzBolxEmfuAjW0mLPjGR2i280k=;
  b=kJQ/cS1BPJ0dIKE8CcqZJd07/D17wwjBmuH/RbQ5IGoihwr+NtmqyIAl
   BDshgEL8SUK7u0/bS0BUmzOY5TpzYSt6Qp0D7T7Rc5vtPBEocahCouCy3
   z2QDAZtu02uwJa4i4tDIBTRVLXsp3qJmEmQBD6dhAs7Tuq2qRew/nVIzd
   VjtKDTpj9jii8HtxHW5z2k474Ku/AhnwPCx3JiDuaMb6crOpVDwElPHSe
   OXxqlQ901gpH3PAM7ckPTlNOxT+5nXUFiqSKi/RMJ9khQpC6ie4gaxnB2
   zqwg+YmqH0GcMulVJ6mwzspVqWaBsmx3IzYUqFOghXf61gJY7hnSv5aPN
   g==;
X-CSE-ConnectionGUID: gFZpUi0aQ0iX/K6HbqJBVQ==
X-CSE-MsgGUID: U0h0kcgUSiulRpuIs1JYmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65718686"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="65718686"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:07:12 -0800
X-CSE-ConnectionGUID: aB825KJfRWaevocpUGwjkA==
X-CSE-MsgGUID: 498tekIzQASc+Y1V9EHT8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="192298624"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:07:12 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Add MSR-based RAPL PMU support
Date: Thu, 20 Nov 2025 16:05:37 -0800
Message-ID: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series enables MSR-based PMU support for the Intel RAPL
driver in the Linux powercap subsystem.

Following are the patch details:

Patch 1/2 - Preparatory patch that updates the read_raw() interface
            to allow atomic-context callers.

Patch 2/2 - More details about motivation of this series and adds
            MSR-based RAPL PMU access support.

This series has been tested and verified in the Panther Lake and
Wildcat Lake platforms using perf tool.

Please let me know your review comments.

Kuppuswamy Sathyanarayanan (2):
  powercap: intel_rapl: Prepare read_raw interface for atomic-context
    callers
  powercap: intel_rapl: Enable MSR-based RAPL PMU support

 drivers/powercap/intel_rapl_common.c          | 36 +++++++++--------
 drivers/powercap/intel_rapl_msr.c             | 40 +++++++++++++++++--
 drivers/powercap/intel_rapl_tpmi.c            |  2 +-
 .../int340x_thermal/processor_thermal_rapl.c  |  2 +-
 include/linux/intel_rapl.h                    |  2 +-
 5 files changed, 59 insertions(+), 23 deletions(-)

-- 
2.43.0


