Return-Path: <linux-pm+bounces-9572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4790EB5F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A75B20E9C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F430143877;
	Wed, 19 Jun 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhP9O6+1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F247D08F;
	Wed, 19 Jun 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801171; cv=none; b=GJT4NBh5ZQAv0cz1qblPuGkUP7jjZN4BA+CqQpYWKpqjzygyw3zAZFoyHh+w9oCpxRjeokgqCQKkLlQWfdlL7G5NM+Vz5SjeuaJ1bfKfrG82CKv4yEAO17tUf2j7jBU9fZzGAnp2dqWDT1180aGzEDqgulyWWAiE2fcuKFb2l2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801171; c=relaxed/simple;
	bh=hebDv46b3MaHt32RS5hfRVVyysKj69AGJz7Y2WOspOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FvQzuGAe/eiF/MSD166c9GNua9bonN7BvrOXURQ8hwWQ/16Kx+hqlL/RUnNDd7EJMTS7qjsJgwJYVEqz39ZGlUHhburDvvCdSk/gWYqzx+3G1qsEb9MspnDmY2++u4kPja5Fb/MRihrIMTmQomshngsc/A1INTHa/3mGI6th+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhP9O6+1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718801169; x=1750337169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hebDv46b3MaHt32RS5hfRVVyysKj69AGJz7Y2WOspOM=;
  b=fhP9O6+1bsNnJ0JehHZfQXfQIQwzfbYlkiklX19BCH1vHpq1yOMvb/tC
   Wie4Mzy77yRJzqRKy5DY6ihgHX+6/bGsk3U4Kom2TYkRVDUk8aYVM2Gz5
   LXxqqmhv8pyyQ4I1XSuYC8ZZcxwp+O4dRvFoFbI9eIh9lc6EZZN3Vz7iv
   VVRJmWea3v9qL0QWkMWwAG9ARtW6zkwbhyeXTHqjCJ7gk1Io6YRrLKNE5
   AWCzl2idyklbOmLNhbcRyrXsnZAU7QfZnvjJawRmusC+eR2DAhW2y+Els
   2W35CeqrtHunsOtgHl+MeW7IQ3GV2avB5XBkfTcC8CBRqgIUJ79QAieGA
   Q==;
X-CSE-ConnectionGUID: X7LQFekcTcydFPURj2/4JA==
X-CSE-MsgGUID: 1zRd3ezFQ9OrqS6yznHDBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15449932"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15449932"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 05:46:08 -0700
X-CSE-ConnectionGUID: nP+7Bh8xR7imHl+lkWotbg==
X-CSE-MsgGUID: elB3EkApTuuQ6teGmDXy6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="46344337"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa005.fm.intel.com with ESMTP; 19 Jun 2024 05:46:08 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] Lunar Lake DLVR support
Date: Wed, 19 Jun 2024 05:45:57 -0700
Message-ID: <20240619124600.491168-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support DLVR controls for Lunar Lake. The first two patches are preparatory
changes to add DLVR support by the third patch.

Srinivas Pandruvada (3):
  thermal: intel: int340x: Cleanup of DLVR sysfs on driver remove
  thermal: intel: int340x: Capability to map user space to firmware
    values
  thermal: intel: int340x: Add DLVR support for Lunar Lake

 .../processor_thermal_device.c                |   3 +-
 .../processor_thermal_device_pci.c            |   3 +-
 .../int340x_thermal/processor_thermal_rfim.c  | 113 +++++++++++++++++-
 3 files changed, 111 insertions(+), 8 deletions(-)

-- 
2.40.1


