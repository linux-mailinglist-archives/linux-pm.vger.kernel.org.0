Return-Path: <linux-pm+bounces-9900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8850E915331
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C4C1C223F0
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCEB19D889;
	Mon, 24 Jun 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+k+QsWA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2412FF84;
	Mon, 24 Jun 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245483; cv=none; b=Ad7ns9+mPkOMOCRxad1kwhBupPlAGLGXkJ7MNGZg/c0v+wgT6E1RbX3xm1EXz5O/sf5B3WQoUzyJ/jA1DDMSo+IIBd8ARgC27pLrL4+4AkrOc3N3Mr8jLINkgsNs9WNoYsTQQVyGLHWwWMuzOoRh6K0/vpmobZ+cw8Sosaz1sgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245483; c=relaxed/simple;
	bh=WtWXxFaWtvAu1P6Qy5EKYrHiblAgOqi7I7UJNTMyihc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vn4PbTYrrsEVeZASPap3KU7YQOchwEvF17ZdCl7Cwqd1C06SEEo+6FemY1t8EDK3w4NxO97F8lirNqlNiIB8lIFwjkey8K7ukCVeMTuQEhiXdEH1wX6uBC9hbPpQAKUoFF0PNF/RAMeYtFbF6QfPAqrG31QbvN5VasaMSG6rWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+k+QsWA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719245481; x=1750781481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WtWXxFaWtvAu1P6Qy5EKYrHiblAgOqi7I7UJNTMyihc=;
  b=K+k+QsWASszeVuweR+ZHZeHO+gDZsQSXmTieFEQ3lfu9pcTGhq3lWmRp
   oOnf2TEpwQLOzo62F1io8ySWwUYwIWFRNLCBpJCHWbr022khoo/TQVNo9
   b/a11ZXWHs8eP3plG8VK06p0gm5gclGuViGkDkbjbyVGNnJ803HkB7cRF
   4j67OGaV6POr/m4dTmPJpdKQK2PpA3QJ1fKxk8qEu0igclZELwvNsFw39
   tKEF00ZSPwr2rae0icVy1jqd+tSahZXALy24u62UJrV+vDm7iWJ1qjI1j
   mznCKQiJqWebhjCOI8KI5ySuvCgv+sQv4njrzo1PvhI1w43Jbicid4hjw
   w==;
X-CSE-ConnectionGUID: LEOmNdYySmmiRqsToPKmEA==
X-CSE-MsgGUID: cZQ73e1ERP61VZNtVS7dxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12218598"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="12218598"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:11:12 -0700
X-CSE-ConnectionGUID: TT4znNWeQLi7O8vg7G44gA==
X-CSE-MsgGUID: 4w7kc8XGRvWvJMyynBorfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="44012673"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa007.jf.intel.com with ESMTP; 24 Jun 2024 09:11:12 -0700
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
Subject: [PATCH v2 0/2] Update highest frequency of a CPU after boot
Date: Mon, 24 Jun 2024 09:11:07 -0700
Message-ID: <20240624161109.1427640-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Xeon servers, which are capable of dynamic highest performance
change, are unable to achieve the highest frequency when the performance
profile is changed.

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

v2:
- Prevent display in /proc/cpuinfo flags
- Use cpu_feature_enabled() instead of boot_cpu_has()

Srinivas Pandruvada (2):
  x86/cpufeatures: Add HWP highest perf change feature flag
  cpufreq: intel_pstate: Support highest performance change interrupt

 arch/x86/include/asm/cpufeatures.h |  1 +
 drivers/cpufreq/intel_pstate.c     | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.40.1


