Return-Path: <linux-pm+bounces-33019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4239B34095
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A921A845B5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31997271448;
	Mon, 25 Aug 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhF6RABk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC71F4CAF;
	Mon, 25 Aug 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128203; cv=none; b=pxayYe+bukAN3R+e0AWshCjVBMpDTBEGZsZAFuBWEiqNLhto+RnR2SHOqF8o0PcckPb9qtbiuHmxFSmNANE8uKNzOr9FZa71Rdy7LOGhFGJFUPhYbg8h3Nj4bouOapUr93abjedgD5YUW6org+qvInSkQspMHDfNSN0ST7Fmdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128203; c=relaxed/simple;
	bh=4LQdlvrviPqpRYcasxXN05G9N8Xmoc1Rl+Jzae5Eshk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzzpIsxF4fNOSyxPjHWOMBholGWP+ghGaQbR6wpwkvYEfBPE+xUYAFWhVTt7CYJt1lComtD+nGHAtJg6Uq3QxirXo5HxD7xdgoVGz01hTSVmtRqy/q5P2Ef0mWhTuN3rlQnlvXHpcilXQNu6pkqwCjkNuog+zWHmyYBsm7EFDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhF6RABk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756128201; x=1787664201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4LQdlvrviPqpRYcasxXN05G9N8Xmoc1Rl+Jzae5Eshk=;
  b=jhF6RABkOUtTGEilW3dJEShlWdPNNKRmCQeAahOKRlXmijwVwJtfUHGr
   WdHUnmzU/sJ31BEG3S929914oLL9y6x1vN2kiNEnLPOMFsDJGwLnR10ea
   9L26PoLI6yMa3WoKVr/E8XKUL9aSFASVwS8blicYSik28rjUpOqqhZrTQ
   bPE1hslKXuz97dFbFJYfWL6pYSEwTSqSlcQIaptbPfLmIjsPonF7rs0Qf
   TmMYYXuR6prsmx0kDR8mMpRLCYJIPUgVMlnQCzPXoEIKreIwC4QHQS6Gi
   FiDWqXnRSGMGM6JPjbTCo0XlF1xAoweFCbcpKg0kfxUASoCyHBpxemmOI
   Q==;
X-CSE-ConnectionGUID: CQLTimxUQTqujNrD0op6ww==
X-CSE-MsgGUID: L3Wk425PR26l6sqw6uXlyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58048394"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="58048394"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:23:21 -0700
X-CSE-ConnectionGUID: jWuIzmwnRv2EWqxpGSgovw==
X-CSE-MsgGUID: ChziJ6TgRBmWWOnj5ebbVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="169485274"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa008.jf.intel.com with ESMTP; 25 Aug 2025 06:23:21 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/4] thermal: intel: int340x: New power slider interface
Date: Mon, 25 Aug 2025 06:23:11 -0700
Message-ID: <20250825132315.75521-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the Linux platform-profile API, add support for system-wide energy
performance preferences. This feature is enabled for Panther Lake CPUs.

v2:
- Merge patch 5/5 to 1/5 (now 1/4)
- Some minor code changes

Srinivas Pandruvada (4):
  thermal: intel: int340x: Add support for power slider
  thermal: intel: int340x: Enable power slider interface for Panther
    Lake
  thermal: intel: int340x: Add module parameter for balanced Slider
  thermal: intel: int340x: Add module parameter to change slider offset

 drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |  20 ++
 .../processor_thermal_device.h                |   6 +
 .../processor_thermal_device_pci.c            |   3 +-
 .../processor_thermal_soc_slider.c            | 283 ++++++++++++++++++
 6 files changed, 313 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c

-- 
2.43.0


