Return-Path: <linux-pm+bounces-35258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F00AB97898
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 22:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649D01B2192D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 20:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC430ACF7;
	Tue, 23 Sep 2025 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YonINOBA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05F26CE17;
	Tue, 23 Sep 2025 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661005; cv=none; b=aGgUNRl+l6Ndy26luKcdMEMrtCiVGBG3bwNSjgmGAtld26qkXmNW69Ywfq1PlXMBL89Cnqgg5np001Lo1hgGX8rOguxDGpy5wZY/kog6OjulWgb7nIlmdOsm8oASLqG/GSM3MEZsE/XB7YzHNbV5dW5wwaa6SFskl1T74eiEVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661005; c=relaxed/simple;
	bh=d6GPjnMpcwjkTEpaWyXOfxv6HFvmffXq9FXRMUSn54k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tj3DMVlAGylCObFyK6W0gdgO+qEjhV5+giXt48wEhumzIgtqmPl7QUmtxyM7H3q1NlgwphX8HKEI3GGFImBzHsypgjt9DF/NO9lSyK3ROZj5yODayHtL7Iu3v1NQzLTOe/L+1HcbuV+w1YeUpWfC/K8YxzNsUWE7spukAk2EqF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YonINOBA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758661003; x=1790197003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d6GPjnMpcwjkTEpaWyXOfxv6HFvmffXq9FXRMUSn54k=;
  b=YonINOBA2FjGNI1sErbLGiH+hXzhEmxN/bbpsHHIHzUapheT6RPuEk6o
   /k2Fl+fHFK435tRvFnTwCTvZNWiBTrXWeFjFf2G4lrLIoPZZYVr9IdgsP
   sNCoEYaVFiRn8Rzq8Gr8UuTGALiUljJBrD+7foxvblHUNobZRY935hziS
   iA3HYwswXtBd3be+yM5m8iAs2rN9XFMTrbD2Kid0jeEhHK8a/LVBOVYQS
   btGUB3AfGHtrbUKpdDYvcM4ys/7peLQslZ4E7i5o0Pdtl6kNuM8WCE/ag
   +lgrsG6i1hAeBVB4SiXBW3hXZAO611Re+Dar/4iqSrQXsoezbMOXp00QT
   w==;
X-CSE-ConnectionGUID: l/GyEPJtR0SkBbxTOqgEPg==
X-CSE-MsgGUID: HDqcuY9QR/2gDAFSpcfnwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="59992234"
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="59992234"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 13:56:42 -0700
X-CSE-ConnectionGUID: tJEo7geLSFCWoHWoGdeQtA==
X-CSE-MsgGUID: tMRCUyA5SnCVQ33pSaUhsQ==
X-ExtLoop1: 1
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa003.fm.intel.com with ESMTP; 23 Sep 2025 13:56:42 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel: int340x: Power Slider: Validate slider_balance range
Date: Tue, 23 Sep 2025 13:56:31 -0700
Message-ID: <20250923205631.3056590-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the module parameter slider_balance is set to the performance
slider value of 0, the SoC slider profile switches to performance mode.
This can cause the Linux power-profiles-daemon to change the system
power mode to performance from balanced mode. This happens when there
is only one platform profile is registered as there will be no conflict
with other platform profiles.

Same issue occurs when the slider_balance is set to the power-saver
slider value.

Prevent module parameter slider_balance from overlapping with
performance and power-saver slider values by adding range validation.
Return an error when an invalid value is provided.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Rebased on top of bleeding-edge branch of linux-pm

 .../intel/int340x_thermal/processor_thermal_soc_slider.c       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
index 20d70cb01542..49ff3bae7271 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -67,7 +67,8 @@ static int slider_def_balance_set(const char *arg, const struct kernel_param *kp
 
 	ret = kstrtou8(arg, 16, &slider_val);
 	if (!ret) {
-		if (slider_val > SOC_SLIDER_VALUE_MAXIMUM)
+		if (slider_val <= slider_values[SOC_POWER_SLIDER_PERFORMANCE] ||
+		    slider_val >= slider_values[SOC_POWER_SLIDER_POWERSAVE])
 			return -EINVAL;
 
 		slider_balanced_param = slider_val;
-- 
2.51.0


