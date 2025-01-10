Return-Path: <linux-pm+bounces-20199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094A6A08FE5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCD8188C004
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF1120CCF1;
	Fri, 10 Jan 2025 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJ7ZXteJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18020C49F;
	Fri, 10 Jan 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510405; cv=none; b=P5ePzpUsEUgPhwVxKmEF101c3aMh6ehVxM8Iy8hTBZyXjayE6oLIGgSEFo1ODebm7cgxVdDhbsNliR3QgY+M6hoePrmNmALc7+oLY5F8ZFGhdOdk0gn/HvcWw4o6mMHxws0/ILURqK2f0XbvVawMVzC3gaRq4FRG5aJdjBrLfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510405; c=relaxed/simple;
	bh=mKJkkdQ9+QMIZgD1+GWCMAW+8wNf7tuOyQapsR1kDEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYW4k8KBITgkj/ixh0BcbE/vhD6L+uNqNCW1jFSNY3R3ixc40NR5sE/IGxTMRUsvpcTA53XTRWB3XjigOIN7eX5bzYym68+/Kjtz2vy9wBrZL5tD9KMP0xRAc77RTSM/SzNMBTm9kBo69o93WNvxRGFfFjnMBP5MC9oIH1YGQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJ7ZXteJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736510404; x=1768046404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mKJkkdQ9+QMIZgD1+GWCMAW+8wNf7tuOyQapsR1kDEw=;
  b=oJ7ZXteJBiKQlXcr/kEsO3B8HlMVL07r+Obxb/WxgpBv/kx544RiJIf/
   KfG1PEGlwBo1Let6t+PS0JWZN4R+tTt/cMayWVmx7jXYx1k3Mrh/0O2pL
   y3Y+kFy6r40YC6vmP4GQS51sPpqlskPHalcKMVopQ+0MuW0vj1InADJHG
   Two8N729tq6bbRWTt6vNZvXZdEJUopTV/8cddhRuLyx4SRXXiDxfGKU21
   TrCTFL8N121v23ZzjAVRiDpF5mKTrthCTNGAQA6FfS9VgSXV5cJzrqr4x
   ApG6wEjlNmhyb22JAxRWU9K4ftnCaRV4yWOUV9jvj7MPFIj0Cd/l77jva
   Q==;
X-CSE-ConnectionGUID: brO8uj4FSByyS+7/Z74+9w==
X-CSE-MsgGUID: KdFzCOcsQ9y0PyE95+Xnag==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="40743767"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="40743767"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 04:00:03 -0800
X-CSE-ConnectionGUID: joYj5BTeSQ2uFQa+i3Or9Q==
X-CSE-MsgGUID: CYW3QDU7T1eFeCCGBuThHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="108635950"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.160])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 04:00:01 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v9 0/4] SRF: Fix offline CPU preventing pc6 entry
Date: Fri, 10 Jan 2025 12:59:49 +0100
Message-ID: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Code for determining the mwait hint for the deepest C-state by
inspecting CPUID leaf 0x5 in mwait_play_dead() assumes that, if the
number of sub-states for a given major C-state is nonzero, those
sub-states are always represented by consecutive numbers starting from
0. This assumption is not based on the documented platform behavior and
in fact it is not met on recent Intel platforms.

Changes since v8:
  * Revert the deletion of cpuidle_state_table check for enter and
    s2idle handlers in intel_idle in 3/4:
-               if (!cpuidle_state_table[cstate].enter &&
-                   !cpuidle_state_table[cstate].enter_s2idle)
+               if (!cpuidle_state_table[cstate].enter)

  * Apply the changelog wording suggested by Rafael in v8 review.

Patryk Wlazlyn (4):
  x86/smp: Allow calling mwait_play_dead with an arbitrary hint
  ACPI: processor_idle: Add FFH state handling
  intel_idle: Provide the default enter_dead() handler
  x86/smp: Eliminate mwait_play_dead_cpuid_hint()

 arch/x86/include/asm/smp.h    |  3 +++
 arch/x86/kernel/acpi/cstate.c | 10 ++++++++
 arch/x86/kernel/smpboot.c     | 46 ++++-------------------------------
 drivers/acpi/processor_idle.c |  2 ++
 drivers/idle/intel_idle.c     | 15 ++++++++++++
 include/acpi/processor.h      |  5 ++++
 6 files changed, 40 insertions(+), 41 deletions(-)

-- 
2.47.1


