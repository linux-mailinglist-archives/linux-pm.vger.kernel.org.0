Return-Path: <linux-pm+bounces-29201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F58AE2C73
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 23:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E4918992F4
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 21:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC5270571;
	Sat, 21 Jun 2025 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bf99f81M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF5211F;
	Sat, 21 Jun 2025 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750539936; cv=none; b=mO3dzcXc28CskE4deuFmBOil5BGmX8bNLQOLAeYmcB/505R5we77P0MHxJUgDK3OzxfiEKcXSy/kCO8Fwu9yo0XfKuD1AFS1s9ENx58EDvG7S3waW5MwYbpJ0lT02zPSQ2Pr2J51wepq/YG+C0auINJqZj0UYlB0mYJY7NQ62rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750539936; c=relaxed/simple;
	bh=uHXyp3Zng1zPWvFAZPvcN7Y3LKBB44r8ugHzcvP0qSg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uicfD6VbnzbpuP9jqZByggRAI/xb3rBHqOeWhSsvLrfg2pvNh8h0vnVPvtrZY9bzmZO1h3dnhCzKWzqi8gpkAQK9F49Kj+yj9iRsQSNlr82KEDLKDniP10nvgpMrOspZV+kzocsRaM+e11szQslLzAxtNkUqJ1mmNTHxxVzTs1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bf99f81M; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750539935; x=1782075935;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uHXyp3Zng1zPWvFAZPvcN7Y3LKBB44r8ugHzcvP0qSg=;
  b=Bf99f81MyJ7FZ5EyUm5JFFnX0N2hVo4ug9aqXFfFozk7DkstychLetnA
   QNfYOmAyOtAyVQIyLAM6SHJo1sLzJYOgmGDS54YNBUr9aO5w/q1MetLnr
   A1Gy+JHr/oVq6VAK6u3wMBXqhw5jw4jttZdNp64K6vWrlo4QheTjh5JD+
   6NN+1dpnJDw3MAjqKNbwY1s2JqEKwIJ+FoPrTEiFQ1UDDlv/Oo4tXIvgG
   jDkWpXSJDqSz7uuNlQCdJkOQTsBVWnf9wSwq/cuRHYA92xgf/K/ZuytLB
   kyjmK1iUzvHLXdhJGEG4M/kI/OMkrYkKKNidTDsyjxQaduwpgKRt/CJQc
   A==;
X-CSE-ConnectionGUID: pKW4L6v1QgiHnZKZjqCW8Q==
X-CSE-MsgGUID: UJinG2JkSLSOPkI9gqXUPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="63826245"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="63826245"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:05:34 -0700
X-CSE-ConnectionGUID: vYJoPVrsQjiJRkLoUA3TjA==
X-CSE-MsgGUID: UlFMvWQqQVWCHV4hCakmVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="155775310"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.74])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:05:32 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 0/5] Enable SSRAM support in PTL and LNL
Date: Sat, 21 Jun 2025 14:05:20 -0700
Message-ID: <20250621210529.237964-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables SSRAM support, including achieving PMC information
and low power mode substate requirements from telemetry region, in Lunar
Lake and Panther Lake platforms for Intel PMC Core driver. 

The first patch enables SSRAM support for Lunar Lake. The next three
patches introduces a new table in telemetry region to get substate
requirement information for platforms starting from Panther Lake. The
last patch enables SSRAM support for Panther Lake.

Xi Pardee (5):
  platform/x86:intel/pmc: Enable SSRAM support for Lunar Lake
  platform/x86:intel/pmc: Move telemetry endpoint register handling
  platform/x86:intel/pmc: Improve function to show substate header
  platform/x86:intel/pmc: Show substate requirement for S0ix blockers
  platform/x86:intel/pmc: Enable SSRAM support for Panther Lake

 drivers/platform/x86/intel/pmc/arl.c  |   1 +
 drivers/platform/x86/intel/pmc/core.c | 163 +++++++++++++++++++++-----
 drivers/platform/x86/intel/pmc/core.h |  14 +++
 drivers/platform/x86/intel/pmc/lnl.c  |  17 +++
 drivers/platform/x86/intel/pmc/mtl.c  |   1 +
 drivers/platform/x86/intel/pmc/ptl.c  |  30 +++++
 6 files changed, 194 insertions(+), 32 deletions(-)

-- 
2.43.0


