Return-Path: <linux-pm+bounces-8740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C168FF49E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 20:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEA628C21E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A63E19939C;
	Thu,  6 Jun 2024 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flofqcaI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3985FC02;
	Thu,  6 Jun 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698475; cv=none; b=RQ2Lin8khK5DqFPXg8q/RbqIG/7pKTMGqgPFoerw20578AEzZRnEqQiGVEW+xC7RHEIriaoc4u8g/+REUEpnwSfTMN7V6apGaUtgbXFu/bBhbeeP1pM0MFdOL74avq4UARvGCF4Lc2cX3bpc1JwsYH537/0RzMEYplWqx7vVp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698475; c=relaxed/simple;
	bh=LXNQPRMRswnuw932IMtEEY0Xqo6f+JZKRHGWJnNHsmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzALAfqMjn4GkYR0tcWzv65BJAQIhL5ucFJClGdCsoyW69K+mRoSxpZij2eKqoyIAzkz9WSQavxTRWDwDcmnfU0LFCBixE306kSH0NGyUfUXbC+OPA3UI9PrJlElnMvhYQ4A9fdW8cdwgAdcJarvWNAyCk+0b99WobFrtvNb9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flofqcaI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717698474; x=1749234474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LXNQPRMRswnuw932IMtEEY0Xqo6f+JZKRHGWJnNHsmw=;
  b=flofqcaIIy/dGBNEaznl1Wa5wKtpfs7xx7kQZoab6F7VAqOW8kRxLHXm
   Eh7/TcF7MkZUajsDg0noj4ZnyrMwTzUmnoc744gTpn/zu3V0HVH1WnAN1
   AVpgUg7NUu6dX1dKin6OXRofP5XTslDGeoJLqwEdo4hltDvRIKbnMwNml
   nFsxEDrZsKZ+MoA8L9ZYihlQVV7LVyYcLkWJgB1KlJWBc1s/PPVj6UkP9
   gMJDOzfH9Irxm8COQ0lqOI32vdPhKFn0L9bElbguim8UBXmN8Swo2C9Mv
   npQtcdyyA1RiGxOFASHxm26JFFYlib2G8Cib57KJNNnuQlquJ5ZJkhLoy
   Q==;
X-CSE-ConnectionGUID: T0jl0cKFSeaiqfQbi6qo7g==
X-CSE-MsgGUID: RcrcLU1JQPOkwpjvbY80uA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25046049"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25046049"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 11:27:54 -0700
X-CSE-ConnectionGUID: BlOw9YOzT/ebSu/my0eG3Q==
X-CSE-MsgGUID: 41r1mtCnTUiNnulJbbOxdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42975103"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa005.jf.intel.com with ESMTP; 06 Jun 2024 11:27:53 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Update Arrow Lake EPPs
Date: Thu,  6 Jun 2024 11:27:48 -0700
Message-ID: <20240606182748.2457952-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the same default EPPs as Meteor Lake generation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8b0032d6a519..8550fae383b0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3430,6 +3430,8 @@ static const struct x86_cpu_id intel_epp_default[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
 								    179, 64, 16)),
+	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
+								 179, 64, 16)),
 	{}
 };
 
-- 
2.44.0


