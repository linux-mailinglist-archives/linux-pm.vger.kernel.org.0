Return-Path: <linux-pm+bounces-39537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C24C5CBCA85
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 07:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CDC03026A95
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 06:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637330C625;
	Mon, 15 Dec 2025 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYeRIKLa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61D30C62F
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765780585; cv=none; b=qc+vseGlEUvZpzWtb8Reet1BqnoKXGpbmICjlhQqoird0USB+0MYDFK+PD7Encp+vNGOYUlgTj7qL3mGBfE4A52wzo065oY77mAKnxRpHY/nq1YYvfXHpWQqd4DPkuOv0YpMJzm01wn6NYkVxAUHCCuqJ59XOhAO/DtjBe4XJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765780585; c=relaxed/simple;
	bh=nZCVYEbOLj7JyNOFkyAKYxdV8DZTaKfsUPuQBEzjmjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g2y6M7CI1WYk/cyMr/N/NcvT8tsoSkvOe8VTGzf4EZpHyPIiQKL6ymaieg+uWjbdPg3I2rdmVzwGTnN1PjJ39XRDdDShjcP7/rFuDSVrgUcLzak9wRjMaqRdU2fuWsbu8Xu/lIOQIO105V/Qd2EltgiZwLhLS4ZNldIJNgdeoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYeRIKLa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765780583; x=1797316583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nZCVYEbOLj7JyNOFkyAKYxdV8DZTaKfsUPuQBEzjmjs=;
  b=GYeRIKLakJqbKnBqLQ9WwP9AZ0moVpsd6rreE9sTYr3DO5uVFGDyr//T
   ACmJ3oRBG9+iE7xS0q5VFWzfon69Bq043q97QUcQFOW7gPJZvlJWdkX16
   PkocLamWe4qXURuKexGd6p5OqmiqCcA+9DQ6LHhd3vViN8xwpDAz5Qiil
   Fwm0JqXUF7kdT85+i7LgvJZto88FZcqhDqmEdHvxvvgqekJZ5jFyOCe76
   tUgkhcDShOzHnLz7GU0OoFVDyaMVMZt4/j7G/jkU0b5uWRylJTsUJYSV4
   AYE1F18+GiCasxmla38Mz5yOjGBy8Pp+O0Yjpr27H3HQVsaDZZnuD37He
   Q==;
X-CSE-ConnectionGUID: CbJwEVb5RkSBua17T12NAw==
X-CSE-MsgGUID: lxjkhkbvSy2ATSZ1gGPLLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="67713985"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67713985"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 22:36:22 -0800
X-CSE-ConnectionGUID: 5G63l7tNTYOKrxt1NB3k5g==
X-CSE-MsgGUID: h853mq4tSnCOrwSgk2koVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="196909750"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa010.jf.intel.com with ESMTP; 14 Dec 2025 22:36:20 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] thermal: int340x: Fix slider_balance param get returning wrong value
Date: Mon, 15 Dec 2025 12:03:47 +0530
Message-Id: <20251215063347.3521513-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The slider_def_balance_get() function returns the array value
slider_values[SOC_POWER_SLIDER_BALANCE] instead of the actual
module parameter slider_balanced_param. This means reading the
slider_balance sysfs attribute always shows the default value
(0x03) rather than the user-configured value set via module
parameter or sysfs write.

Return slider_balanced_param to correctly reflect the current
module parameter value.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 .../intel/int340x_thermal/processor_thermal_soc_slider.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
index 49ff3bae7271..96307dcb4812 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c
@@ -80,7 +80,7 @@ static int slider_def_balance_set(const char *arg, const struct kernel_param *kp
 static int slider_def_balance_get(char *buf, const struct kernel_param *kp)
 {
 	guard(mutex)(&slider_param_lock);
-	return sysfs_emit(buf, "%02x\n", slider_values[SOC_POWER_SLIDER_BALANCE]);
+	return sysfs_emit(buf, "%02x\n", slider_balanced_param);
 }
 
 static const struct kernel_param_ops slider_def_balance_ops = {
-- 
2.34.1


