Return-Path: <linux-pm+bounces-9402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42590C291
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 05:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516A11C219D7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C7E1F945;
	Tue, 18 Jun 2024 03:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKhl6YT5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF24C6D;
	Tue, 18 Jun 2024 03:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682687; cv=none; b=CMTtRPVlFqpZq5pOQnZWxjg5/qAkjYgEnPH36roeTD6atvmlnVzrp5SHiv4zVK/5vBzz3xLr3qiN3RwRp/8+DbXQ/4UVkRovpzVm4Ixg4AgYfm/IYr17Bz+gs54mtHB6v8U3ydDAMiZVxpT3D448jD+9JvLx5Hy+wfVU5fmGm0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682687; c=relaxed/simple;
	bh=JvPgI74SdVU6FuwH5VSMfmRpXFtZAyArAeCYZLvAMG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QYrtONK659KH2jIKwJiIo83nVs5Ozx9JqoeGbL/LuhIL9onXSgFXN6B/TF9XLjNY8tr/aMo9ExRhFvU58Ei+saB+v2BRyCSjxiBrSrDK8Pu8rcnF6S2weGze6PioQaoN29twlCyjLfBJcrEK4W6Ze+9UkJgVF1qCLqLX58Pue3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKhl6YT5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718682685; x=1750218685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JvPgI74SdVU6FuwH5VSMfmRpXFtZAyArAeCYZLvAMG4=;
  b=eKhl6YT5jeSc7+p22Yiq5zI2395hSg5P/YMZwAveLtW3kMJzfHgwTbNO
   PVOkOpSClhYsQzS0wnl7b4vzUfCPNAovfZJnGseht3WiJb5LjJh0aex6g
   p9ubtBdGygY3vPtt//TGMcTUpLrogyB+E5beeu4k6j0sboGPK01S75vNk
   8enshJD0/DAJxBx8GZdrzkoJrI9fDdGsLRckrz009dA9zDdWLfCJIxQt5
   6nTKQpsFNE7PRa+mNTTDABqgSeQTOEgeIIKwRbR3YGUxNju03zw1YFLdJ
   7Xj0BAdjIAIKCen0+7EbRtHX5BrKWld0rf/p/ocDjB7WRxji6rTCNhuFC
   A==;
X-CSE-ConnectionGUID: djTkORnWQI6GPVkTxZD7Qg==
X-CSE-MsgGUID: xPxD/aKfTiWmsZJOYzGFxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="18449831"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="18449831"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 20:51:24 -0700
X-CSE-ConnectionGUID: PIZ+IaktSj+sNULCG/AwCA==
X-CSE-MsgGUID: DVTWpzDvTkmlI9IrB+y2fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41522550"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa009.jf.intel.com with ESMTP; 17 Jun 2024 20:51:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] Update highest frequency of a CPU after boot
Date: Mon, 17 Jun 2024 20:51:19 -0700
Message-ID: <20240618035122.438822-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Xeon servers, which are capable of dynamic performance changes,
are unable to achieve the highest frequency when the performance profile
is changed.

The highest frequency at which a CPU can operate is not fixed and can
vary after the system boots. These changes can be initiated by switching
to different performance profiles using the Intel Speed Select Technology
interface. Additionally, adjustments can be made remotely through a BMC
(Baseboard Management Controller) interface. Administrators can select
various performance profiles to align with specific performance
requirements, as these choices will directly influence the total power
consumption and cooling requirements.

Whenever an administrator switches to a different performance profile that
alters the highest frequency, the hardware sends an interrupt and update
the new highest frequency at which the system can operate. This interrupt
can be enabled via the MSR_HWP_INTERRUPT register, and only if support is
indicated by the CPUID[6].EAX[15] = 1.

To enable changes to the highest frequency, add a CPU features flag and 
enable the HWP (Hardware P-states) highest performance change interrupt
when it is supported by the CPU.

Srinivas Pandruvada (2):
  x86/cpufeatures: Add HWP highest perf change feature flag
  cpufreq: intel_pstate: Support highest performance change interrupt

 arch/x86/include/asm/cpufeatures.h |  1 +
 drivers/cpufreq/intel_pstate.c     | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.44.0


