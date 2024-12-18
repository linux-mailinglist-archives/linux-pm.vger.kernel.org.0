Return-Path: <linux-pm+bounces-19461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE72F9F6FB1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 22:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B85169403
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 21:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B7E1FCFD8;
	Wed, 18 Dec 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AF/wlqyq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E51FC11F;
	Wed, 18 Dec 2024 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558303; cv=none; b=EiWbdyv7vT2QFtMo6gVaTITVhGcU2NYAqRZA5HhEvMV88wa+yfb8XHV0h2nekBDy4DwehMWbamIkikP07GhqFa0tIZgzNvGMQLuAcewjN5cad2/UMIBsXoBD+xRn9BusHd4LY23GNPYVu4as62sxB06pFIy/hsZPFYiG/mH/+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558303; c=relaxed/simple;
	bh=IrrU9PHVz1azGyNM00roEocrX/REpjhTwhqU4ZOGtys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSz3Hld4u0LoOf2UDpSgLtqolmvDbeAXmdkusR/Wm0Yvx6jgBTDsoDEJiLBrLGA00DxC4+TWa4lkCh9HaaoZNmEFpJXfMcWyM8Y5EPALBFAV2MaOSMqr8RMyuRQYAaY6yJzoqnNPUau7KEI1PPDjwZtSxmEUzMYPWO5UQ+7zUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AF/wlqyq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734558301; x=1766094301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IrrU9PHVz1azGyNM00roEocrX/REpjhTwhqU4ZOGtys=;
  b=AF/wlqyqRlLEwGOqfmQSa8B+FDjFUnli6gYzRdCa+RSosjLWWcA7gH6N
   7tvrGMrfObZq4d7JvWWpUrFb21185mq4IpYi9WkAyP0rAZI/RXhLk3TAm
   DASKBKIYDhbdkQudbnjHtsKu0UBXg6JR5SokuUmIkUnHyzkD4gTMqj9m7
   r5mSSa8y+bB9C3I/9Gt6dDnWmZ4t2X3m6QfEEywk+/rmNzcr3yG/cbeCU
   5sczQ2ouaEypzVm8ih/+9m+jfDXq+rrOBnPNUPhbtNc46xT6LylWzOZWa
   GTz1IYSoJkEKPLgRE/lYX+XHgPhPrHNJHMMrAkMjPd9DoAENaiR4icpA6
   Q==;
X-CSE-ConnectionGUID: on5jWY1mR0eb7dvgW027dw==
X-CSE-MsgGUID: prGeJQAvRgGhW6qIN0fJIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="52463743"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="52463743"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 13:45:00 -0800
X-CSE-ConnectionGUID: 6u4Y/B2QT+i777IwIaolBA==
X-CSE-MsgGUID: cQAtWgqXRAuQ2INs5B9H0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121248063"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa002.fm.intel.com with ESMTP; 18 Dec 2024 13:45:00 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH linux-pm] thermal: intel: Fix compile issue when CONFIG_NET is not defined
Date: Wed, 18 Dec 2024 13:44:44 -0800
Message-ID: <20241218214444.1904650-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_NET is not defined then THERMAL_NETLINK can't be selected.
Hence add dependency on CONFIG_NET. Othewise it will generate compile
errors while compiling thermal_netlink.c.

Fixes: 4596cbea0ed2 ("thermal: intel: Remove explicit user_space governor selection")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
This commit ID 4596cbea0ed2 is from linux-pm bleeding edge branch of
linux-pm git.

 drivers/thermal/intel/Kconfig                 | 1 +
 drivers/thermal/intel/int340x_thermal/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index 9c0f66f9defc..e1973c0efe0c 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -22,6 +22,7 @@ config INTEL_TCC
 config X86_PKG_TEMP_THERMAL
 	tristate "X86 package temperature thermal driver"
 	depends on X86_THERMAL_VECTOR
+	depends on NET
 	select THERMAL_NETLINK
 	select INTEL_TCC
 	default m
diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index d9a74424c29d..6a0203eaa7f2 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -6,6 +6,7 @@
 config INT340X_THERMAL
 	tristate "ACPI INT340X thermal drivers"
 	depends on X86_64 && ACPI && PCI
+	depends on NET
 	select THERMAL_NETLINK
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
-- 
2.47.1


