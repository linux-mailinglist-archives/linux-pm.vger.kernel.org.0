Return-Path: <linux-pm+bounces-32348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1929B25361
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 20:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21E25A5443
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB992FF149;
	Wed, 13 Aug 2025 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7TSS0jc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46FC2C2AA5;
	Wed, 13 Aug 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111336; cv=none; b=cQF1BxFftB3SzsKsSFQU6jNfm3fUk260Sp83E7X5bKfP9rL08SZsMUCrj1YlQ76ohzMrd807RPC2cJG5gCY/Lhdh+N7DD5FCsAO2pL6O+Eew1vp9/wK4UNjGFtYLuBJnI2dCnDmToJE2aI81Sl9zYoxVUv4t3Qenoox2HfvOhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111336; c=relaxed/simple;
	bh=x3C0TpLUsvjjUYKBXR3PvS7giBbzbnKd9gSnuFFxzSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WGPJ4ZTAcgMaD08aOHJTn+Nwz4xAFKClJJ/il4QBAJ93M8f3XOXMZh/ZGaJxL10clhnq1I1j7Qx3uXKdriLqiR1nm4q5xzFD2Id6iMbJe4yHCWcRm10vmaboyaqZN54tdDbq+l7MEh+moKgliTZMGAHFOMTIxCogY91giRj59K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7TSS0jc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755111335; x=1786647335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x3C0TpLUsvjjUYKBXR3PvS7giBbzbnKd9gSnuFFxzSU=;
  b=h7TSS0jcQtNboxjzW0SNLI9+Slp8KjNDykrqCrTBnjBnt9LAG7ZTXZcz
   2AKoZiu+PyeRtFwWh3qUUkPfA9ERkN0FFpMV8Zs20K7tKUaFCyuoCU0sF
   S/7RAWqhtxetfkVPvcgJs7grANfeWCreBKJqq0F8a5zS9Go61A5+ml8Q6
   7kt8vdWKEjvVQem+acJ+zi2BBAmaUHA+fM8eAyAyXCw0g1RkHt5Eejg5u
   nhhXHG6NGaspDp4vajzJPm8e7j1skiPJKUgSIL9GrOt2jsUJTHYu7aK+i
   k6VqMPModE/1EdbAFf4jiFYtXgASwBAM14e2DlcZPlyK/HwPniPm1vP0l
   A==;
X-CSE-ConnectionGUID: erKhH2c0RDmZEeBDOwO4UQ==
X-CSE-MsgGUID: 7dPaIvIzQI+pOD9vwx1GQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56631228"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="56631228"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:55:34 -0700
X-CSE-ConnectionGUID: WnMZ5O6/TveggKvnLZeZnA==
X-CSE-MsgGUID: Jr+HgU7zSqWRFd3KHDWRlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170755035"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2025 11:55:34 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/5] thermal: intel: int340x: New power slider interface
Date: Wed, 13 Aug 2025 11:55:25 -0700
Message-ID: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Using the Linux platform-profile API, add support for system-wide energy
performance preferences. This feature is enabled for Panther Lake CPUs.

Srinivas Pandruvada (5):
  thermal: intel: int340x: Add support for power slider
  thermal: intel: int340x: Enable power slider interface
  thermal: intel: int340x: Add module parameter for balanced Slider
  thermal: intel: int340x: Add module parameter to change slider offset
  thermal: intel: int340x: Add suspend and resume callbacks

 drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |  20 ++
 .../processor_thermal_device.h                |   6 +
 .../processor_thermal_device_pci.c            |   3 +-
 .../processor_thermal_soc_slider.c            | 268 ++++++++++++++++++
 6 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c

-- 
2.43.0


