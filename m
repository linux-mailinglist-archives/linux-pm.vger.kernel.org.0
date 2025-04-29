Return-Path: <linux-pm+bounces-26393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F5AA1CA9
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 23:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE411899BDB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 21:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD19126B2B1;
	Tue, 29 Apr 2025 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZNev/tF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2926A1CF;
	Tue, 29 Apr 2025 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960835; cv=none; b=TtKFnxs0g2viV65QBUF32Vp28OFaHVtozOcO8sfvKK4//9ZiZulp55I/uFalEWN4aM65bUVohB8VmI29os/fhcasJ5xBj3vyK3PgBSlxFtJSZ2QHk1LvzTZUW9DoYjz3HR0gHofsPNA6kS9e5Be/1h4xCNCa/7SZmCvHyD+LmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960835; c=relaxed/simple;
	bh=h4MHEOtVAPe0EKg+ia3xAD0U97c9p61TQFT9WGEXj3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXKlTHfxGXwzqj7Gvp6mPolDBoTmidpCmyMPakhxw8vpZNOF6dVuPSTZcF4f9QFwtFr1uIl7RnJkjC+oTXRUjHjq9x45eCqukzYodC4l1edPBxwnxUzSElH+hbiOcfXMghGo41ZTm2IY/LjI8YkONgltxtBJwfaK/4LJo7lbeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZNev/tF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745960833; x=1777496833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h4MHEOtVAPe0EKg+ia3xAD0U97c9p61TQFT9WGEXj3A=;
  b=NZNev/tFO12qk6QLVabcuu0HqCdkVxhW745MFxytRqnttoyXeF2n1gKb
   HDzMIQYMJR0dq63HH2c6qYSpwbNh6t4AtSZIWJmf7y4sBxEatqpmatfCe
   kpQk6/dPtROTEdawRnRjMZXApoEZofdmWCLEvlxBi+cwSDthfNXLH1SmY
   f53aIkXW8HT0eJ+a6bKNSq5uJggQsvy0gqM329uGnlzE+X1Y+FmwkoeRv
   u+9q5irlkLU90+TRozJhb5SumfLL9LlgJr+IoW4N8HqUSAUNHGhWLTD00
   4yDuPsMc/TRdPFtnjEoAQvp/3s5pGtQouGo5FVb8D4l2WezX/x+KhzQCa
   Q==;
X-CSE-ConnectionGUID: 8qSY/Xf0QXOld/3+D+A9aQ==
X-CSE-MsgGUID: GHK8nw0YRDmctabP4prZZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="50260959"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="50260959"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 14:07:12 -0700
X-CSE-ConnectionGUID: YklolNELTnWcT0QB1z6VkQ==
X-CSE-MsgGUID: r7aJJeZ6Q72Oy+gmLUqqQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="134925019"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa008.jf.intel.com with ESMTP; 29 Apr 2025 14:07:13 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode
Date: Tue, 29 Apr 2025 14:07:11 -0700
Message-ID: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When turbo mode is unavailable on a Skylake-X system, executing the
command:
"echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
results in an unchecked MSR access error: WRMSR to 0x199
(attempted to write 0x0000000100001300).

This issue was reproduced on an OEM (Original Equipment Manufacturer)
system and is not a common problem across all Skylake-X systems.

This error occurs because the MSR 0x199 Turbo Engage Bit (bit 32) is set
when turbo mode is disabled. The issue arises when intel_pstate fails to
detect that turbo mode is disabled. Here intel_pstate relies on
MSR_IA32_MISC_ENABLE bit 38 to determine the status of turbo mode.
However, on this system, bit 38 is not set even when turbo mode is
disabled.

According to the Intel Software Developer's Manual (SDM), the BIOS sets
this bit during platform initialization to enable or disable
opportunistic processor performance operations. Logically, this bit
should be set in such cases. However, the SDM also specifies that "OS and
applications must use CPUID leaf 06H to detect processors with
opportunistic processor performance operations enabled."

Therefore, in addition to checking MSR_IA32_MISC_ENABLE bit 38, verify
that CPUID.06H:EAX[1] is 0 to accurately determine if turbo mode is
disabled.

Fixes: 4521e1a0ce17 ("cpufreq: intel_pstate: Reflect current no_turbo state correctly")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f41ed0b9e610..ba9bf06f1c77 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -598,6 +598,9 @@ static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
 
+	if (!cpu_feature_enabled(X86_FEATURE_IDA))
+		return true;
+
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
 
 	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
-- 
2.48.1


