Return-Path: <linux-pm+bounces-25737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A80A9411E
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 04:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FE48E069D
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 02:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655C735893;
	Sat, 19 Apr 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDdzYByi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBD288CC;
	Sat, 19 Apr 2025 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745030990; cv=none; b=guCnfZBNZuN74pBeUYqg660LWkq8ae/Gyld6oTRkZod6x2Tze6CaXXlUe0Ph/N8H/6yIw7vs07IR1RFE3zQ7++ZlIM1TgQa9kzFiIUG8AftleV31ElpFEIInL/B1uS7likklJZg1cQki2XHVcS+F4rwea3LkhQCmfNwEIV6fs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745030990; c=relaxed/simple;
	bh=BKjdCpQP5HRZ/1EEUnIej+ttFx/pSeE93kbclBz3y+I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uRiIRukMo5iBSRcWd50YpY6l7rbDLvlOppQbGMK4nwjY4zdWhV6CJLXDYKg/FNbzjD3AdpRK3VWNJiXfcMmwwtT1XJlYaY7rsKBXP9v+PM+3Sd8wyytk2i00VvHEUGgTQMbtPc6w61Qtp8CvoHZRM4SRZtQd2h8ERO8x8cCcqzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDdzYByi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745030989; x=1776566989;
  h=from:to:cc:subject:date:message-id;
  bh=BKjdCpQP5HRZ/1EEUnIej+ttFx/pSeE93kbclBz3y+I=;
  b=DDdzYByiqWr6D7t+x/Ao+gMl8nwh12A6rkdTBZKhI1auguIOoh4JXN17
   M9p9WD0Y5gilQimljwrPZ82k58SSZVm9ONTm+/RL+VKgZtuSTrXirtKou
   jmUCd801R5EnkORIy+PwxGset+Rxy8cVK+MabogQgJNDrafZ9IIk+uCO9
   odYck+gAwunCEPrAupPKGmh4bp2IJM1EaZoydG11dZI/a7FHHmaAstKkM
   JAzNos50UzfBCPYP7eqaVEY91+OSKwi9BSdj/u2CKKwFzy6sYqvFMjOUx
   L7BBwCePgXpZ1P6jLUR/7J/b3BJeeR0hcLJOE/KRvtqvYSj+usYEDqlFN
   g==;
X-CSE-ConnectionGUID: NfFdU4niQyilVdxeDcv2vw==
X-CSE-MsgGUID: pziXTcM8RniinK7+g0Zu/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50490433"
X-IronPort-AV: E=Sophos;i="6.15,223,1739865600"; 
   d="scan'208";a="50490433"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 19:49:48 -0700
X-CSE-ConnectionGUID: xrpVH6pcSJqmYAymina/wg==
X-CSE-MsgGUID: +jdrZeeoSmuMyqBlqSqFaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,223,1739865600"; 
   d="scan'208";a="162308318"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa001.fm.intel.com with ESMTP; 18 Apr 2025 19:49:47 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/2] topology/sysfs, cpufreq/intel_pstate: Populate cpu_capacity
Date: Fri, 18 Apr 2025 19:55:02 -0700
Message-Id: <20250419025504.9760-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Hi,

Capacity-aware scheduling is now supported on Intel hybrid processors. It
makes sense now to populate the interface /sys/devices/system/cpu/cpuN/
cpu_capacity. User space entities can use this information to implement
policy such as utilization clamps.

This interface currently lives in arch_topology.c. Rather than implementing
the interface again for x86, we can move it to a common location in
topology.c from which other architectures can also benefit and populate
using their own mechanisms.

I tested this patchset on Intel Alder Lake and DragonBoard 845c. The
interfaces are populated correctly.

I'd appreciate any feedback!

Thanks and BR,
Ricardo
Ricardo Neri (2):
  arch_topology: Relocate cpu_scale to topology.[h|c]
  cpufreq: intel_pstate: Populate the cpu_capacity sysfs entries

 drivers/base/arch_topology.c   | 52 ----------------------------------
 drivers/base/topology.c        | 52 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/intel_pstate.c |  2 ++
 include/linux/arch_topology.h  |  8 ------
 include/linux/topology.h       |  9 ++++++
 5 files changed, 63 insertions(+), 60 deletions(-)

-- 
2.43.0


