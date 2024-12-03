Return-Path: <linux-pm+bounces-18416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D9C9E14CE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4AC164653
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491DE1A4F2F;
	Tue,  3 Dec 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hn3q1VgW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB71A01B9;
	Tue,  3 Dec 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212683; cv=none; b=qSSJz/st7zGz14q6lA1tQCMx9EhqSgp8RKECuVHwuxudCjEnXz9cuFkWupUOUQOu4XDZDrZx7jMskR5VyEsF1paOViYkKsX6sCPmSOYVagp3tI4W8t6Dqtk7Bln3lB1n7eFoh7fJmRJMFs9IIljl2gW6kJaMKMrrXnNsaijoN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212683; c=relaxed/simple;
	bh=RNrauZ03gbhL439ylRK6V/lHHYG5ntkXf7AtvkPxyEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6Yg3lQoL0XV/oBsMVKGbfz3c8SkmCgRAb5MuzFznKUMESiiDKOdt0zw+Q5nLyYwycvwmosDrLYhT/NnMY6SjTgvb/t7JslJgB0D9CahFBAMsRr5hnsnAI2uJC4PEhkuzCR4ixiTKuqc1yjPOJBk3RKG+nbdutkg0Li9q8U0Gd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hn3q1VgW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733212681; x=1764748681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RNrauZ03gbhL439ylRK6V/lHHYG5ntkXf7AtvkPxyEc=;
  b=hn3q1VgWdAV624pmOdNA49iOakqeD1B0pEGne7aveu5GOCSbGpic8gF+
   5kc/vzK3B1Im12tNlyPQSXkf8BjSp480pQuhBe2hxgac1/7jh2qU2PDRP
   hHKbaQPzj8wnq37ivgYoY70pEBzZ5hJS642Li+biHtcdBDfxKUYFaoCIe
   YvcLkPyxN8ayLTHfFxoBTrtJhxKuNT8Jfq8U3rB7zXMotKmXaS54u+j++
   7hLFgmXoEMnOm6XFsDE5XJi+IOouSj1yZwYA+2yapq3p4PIQco+ZWB4cQ
   sWxp/5Emq0KTr2NVEGKJEONJ1XuFQOb+73BZqiUh2aplcP8YI5zOHzBGO
   g==;
X-CSE-ConnectionGUID: 5huOrXuQTMKRn/0Myz1bfA==
X-CSE-MsgGUID: E9gkD1vAQg+OLh/Ljh4BHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32758206"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="32758206"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:58:01 -0800
X-CSE-ConnectionGUID: 7wz6IbXvT2y0dJrnDzRjtw==
X-CSE-MsgGUID: OHj/MQefQyKmPDaGH7mMCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93759594"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa007.jf.intel.com with ESMTP; 02 Dec 2024 23:57:59 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 0/3] Add RAPL/DPTF support for Pantherlake
Date: Tue,  3 Dec 2024 15:57:59 +0800
Message-ID: <20241203075802.584741-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an effort on going to avoid per CPU model ID enabling for RAPL
support. But this takes some time and requires sufficient test to make
sure no regression introduced. So enable PantherLake RAPL support before
any rework.

Zhang Rui (3):
  powercap: intel_rapl: Add support for PantherLake platform
  thermal: intel: int340x: processor: Enable MMIO RAPL for PantherLake
  ACPI: DPTF: Support Panther Lake

 drivers/acpi/dptf/dptf_pch_fivr.c                           | 1 +
 drivers/acpi/dptf/dptf_power.c                              | 2 ++
 drivers/acpi/dptf/int340x_thermal.c                         | 6 ++++++
 drivers/acpi/fan.h                                          | 1 +
 drivers/powercap/intel_rapl_common.c                        | 1 +
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c     | 1 +
 .../intel/int340x_thermal/processor_thermal_device.h        | 1 +
 .../intel/int340x_thermal/processor_thermal_device_pci.c    | 1 +
 9 files changed, 15 insertions(+)

-- 
2.43.0


