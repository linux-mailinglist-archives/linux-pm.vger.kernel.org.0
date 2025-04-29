Return-Path: <linux-pm+bounces-26339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DABB3A9FE03
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 02:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7361A8705F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 00:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69068F5B;
	Tue, 29 Apr 2025 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcgBzwY1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859F367;
	Tue, 29 Apr 2025 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745884881; cv=none; b=LLxMVDxTfPSM7kFCnDP32MTWlf69WCai9Gdf/TVHVAvnedd81sZMDR2Oal81iavr7OIlBoIoicLcYbzZJ6x3uMgW5mQeuYXJY/vO+kk6Y6MnrzN6Wu8fHsaLkuwozXdHoTIOwjPAHdMNA+a0t4EfDDVemI2uu1TQSfaz6QhW098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745884881; c=relaxed/simple;
	bh=/YiLAJZkKuHAu12kWnmycSDcsBoib/Zd/RZKonvojT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m8+BXSW/0J4V//2wfnLsO6bMq3/XoVuidwIBwyOnN3edPTT6CYNk3pR/e4SrqZE38H7NgwZjyDYuyA2r+fgHMX3k4D0pVhsINHJPY9Z/yavSaQYmTzQO5WtMrovirjfUVVce4BPzUAcnHt2vWreMCYrMDwR1OQJJdPKkCMpZQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcgBzwY1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745884880; x=1777420880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/YiLAJZkKuHAu12kWnmycSDcsBoib/Zd/RZKonvojT8=;
  b=QcgBzwY1oZVxSnb5+p3Ewd9k1hZuUMT5MVpesU6tjQ+H8SNkuP9SqEjs
   /YGbD1HKqrunpkHOmTCfZ8Gzgd6bRuSOFMzVF4ydTWJeQTbVAc9O9SQ6/
   t6IF89YNLXCbMa93ILLNRFkTERNTZAnhS2+CrAlHRE9ft55yBR/Sc1DVn
   l9PvOSbiLEPgPbArfRqGR0vGbzdXHZ72O3p1bpx2UYA7fUYeqC76pv+Lg
   CohFZkjWHKfNb9wYFjikAvGduMrS9ExjrsNgv5VHtA70xqdnCrO+07a/Z
   KEtL4LaS3uJiEhFUmcOZAU1oAkDOhZYmkAqVz4RYS7M+Z1HTJXlbthCrw
   g==;
X-CSE-ConnectionGUID: qlyzoTkFTLe7wWQe0nLLXg==
X-CSE-MsgGUID: 5QfxuvPKRtiI/vGmtxtGMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58864048"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58864048"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:01:19 -0700
X-CSE-ConnectionGUID: 4td85lXmQhaUnvIVylcU8Q==
X-CSE-MsgGUID: eMV4ITh+S26ZxsuABrqMeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133386484"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa009.jf.intel.com with ESMTP; 28 Apr 2025 17:01:19 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/3] Platform Temperature Control interface
Date: Mon, 28 Apr 2025 17:01:07 -0700
Message-ID: <20250429000110.236243-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Platform Temperature Control is a dynamic control loop implemented in
hardware to manage the skin or any board temperature of a device. The
reported skin or board temperature is controlled by comparing to a
configured target temperature and adjusting the SoC (System on Chip)
performance accordingly.

This series supports optional controls from the user space.

v2:
Change sysfs folder name and other cleanups

Srinivas Pandruvada (3):
  thermal: intel: int340x: Add platform temperature control interface
  thermal: intel: int340x: Enable platform temperature control
  thermal: int340x: processor_thermal: Platform temperature control
    documentation

 .../driver-api/thermal/intel_dptf.rst         |  21 ++
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../platform_temperature_control.c            | 243 ++++++++++++++++++
 .../processor_thermal_device.c                |  15 +-
 .../processor_thermal_device.h                |   3 +
 .../processor_thermal_device_pci.c            |   5 +-
 6 files changed, 285 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/platform_temperature_control.c

-- 
2.49.0


