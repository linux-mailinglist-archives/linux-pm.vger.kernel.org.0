Return-Path: <linux-pm+bounces-23682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88619A57D44
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 19:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B93D18937CA
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7262046BF;
	Sat,  8 Mar 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTuPFvxP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB94202C44;
	Sat,  8 Mar 2025 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459115; cv=none; b=sZIiMakl3X0caB8/tTQ8T/x5VAektbcNYcqjBbBIETUvLVpd8SPGARq3XJV2nDo8MO8v5VgWv9StL3SUkhFmDGTKoOvmK6b+xWR7opraCCkKX8kRBXDNYE+bp0dfpvC3qMaZhltbXu4axbP4Mhv609su+2+6TElj4ZfZOnPT/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459115; c=relaxed/simple;
	bh=ICxQvEvaELWXWRTD7ERZkdpAUoDpnDms71ShTxZILq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dexZw5PYUxvpF6GFKfbmR5wHPysngiGnsCc5Lxov6UV0jgmAeuhsNG6uGKyfsMsGwnqEAtpGV1s45ShGlxyyIZklUkTSanuhzbkU3F5l/LYU1zzs0mdP7APBqhYULVDHqvkm8aAaBM5jiPtbbXAI8CNhTJ9GXw7QwvhW8G0vC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTuPFvxP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741459114; x=1772995114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ICxQvEvaELWXWRTD7ERZkdpAUoDpnDms71ShTxZILq0=;
  b=hTuPFvxP195bbJtFUQSoViwP6IZiLuL/kFzxeNHozojK0YK7pdIbUv4H
   Zwk6z6OyH4rL1ePopBAn2MBAKklEs/WDfLtwXl2MKkforHVk7IQWAgzEN
   zpRTh42Sa34+PdZLMsK+GOrOb73jT2g9FRuA0sV4Re2wzcYI2gVJF6+aV
   6/NEwzRy+MQbiyVvXxEDrEx7tjUjX8tQpCQkFZzV6uT5282+wfMSjsRvn
   eHmQ9MeH2FNebdsggL0d5G+laJgi/0flwEcKfqnntFGMcZpXloYlUNNrS
   /cqS0v2FnHfRpLtvXE14GTHipYMt2DE28YjC0qMxoKabZG3DOraqWDmfB
   A==;
X-CSE-ConnectionGUID: B4XpsmnyR6mYYGE2esW5oQ==
X-CSE-MsgGUID: 6D3hwoi7TH+LEvp+1LfMkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="46148327"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="46148327"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 10:38:33 -0800
X-CSE-ConnectionGUID: 93+1aL03Tc65t2WKh4ha8Q==
X-CSE-MsgGUID: bQmRIgPcSO+ZMlrZjoGcUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="119584462"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa006.jf.intel.com with ESMTP; 08 Mar 2025 10:38:33 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] Platform Temperature Control interface
Date: Sat,  8 Mar 2025 10:38:09 -0800
Message-ID: <20250308183812.118311-1-srinivas.pandruvada@linux.intel.com>
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

Srinivas Pandruvada (3):
  thermal: intel: int340x: Add platform temperature control interface
  thermal: intel: int340x: Enable platform temperature control
  thermal: int340x: processor_thermal: Platform temperature control
    documentation

 .../driver-api/thermal/intel_dptf.rst         |  15 ++
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../platform_temperature_control.c            | 181 ++++++++++++++++++
 .../processor_thermal_device.c                |  15 +-
 .../processor_thermal_device.h                |   3 +
 .../processor_thermal_device_pci.c            |   6 +-
 6 files changed, 218 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/platform_temperature_control.c

-- 
2.48.1


