Return-Path: <linux-pm+bounces-13084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1149634BB
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E651F2284B
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E21AE026;
	Wed, 28 Aug 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gc8ixFTO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7541AD3F9;
	Wed, 28 Aug 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884180; cv=none; b=XBfU36vpXdFMrNdI56z/78pUu461jHXquTsoioMR6bOqxb6H2FvnlQ0z8k0AmplO7LPeJbTTMW0nf8/5w2YB1cg2aEsW5sj/Y4LnfjfLEh0X2ESOrSWYHZjl/WYS0K1gAnYnqCFOuhjpmUfFM4JZdOquLloTwWNRRq2+WM3IEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884180; c=relaxed/simple;
	bh=XZF8k7eCun4zotrrmnqlMMODPR9I2C3i8SOGuwyzO+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGhJ3OFU/q7RdHny1xtVdxI0/KNl6PUQvthhGYJV+QP8eccgHQGySnK0eKiRqwW8OoFnaE8ICJ8FeywrrxM9UYhbqY5oWhAYJciZCyrpZ3VLRIjzxJiPyy8x8lAuM3VShqT/ByNQv9yiCLWVH9QCt+ty2khkfp+0F9TAcYGL4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gc8ixFTO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884178; x=1756420178;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=XZF8k7eCun4zotrrmnqlMMODPR9I2C3i8SOGuwyzO+A=;
  b=Gc8ixFTOgfEYPAj+s43Av7VrgDHcUETHpNyIGCMXgiVE0DOjoUJDlXwz
   zq62PMjgL6AYDQTM+quCNPeoIxCdfh3d6V9UBapWUsbTGu2cpGDISkZpO
   OqrAbhuQhZMyEZfM9+20RF8NaN+yS3/XaSUs8G9KAVSvTKz3a5FN0aYEj
   VZsDuAsGa2TX6SfGRQQJUlhjW3OrfZcFUwrhu3gIU7a8bc5US+i8W+Zu6
   c5oi6KgXKApYBquuWRmiq+L6SHVnOdpVQ1ND7+ScjftgPgZSs40x0+aKR
   MqYXXLbygNBfRF1Nac6cjZsbqW5koX3ApdgWpl7Of8qEgws9pws8YNCHc
   w==;
X-CSE-ConnectionGUID: n57lmhIfRZ6HVPWTYauCew==
X-CSE-MsgGUID: WXRuvJnBTLOicRXlmRrbTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406461"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406461"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:37 -0700
X-CSE-ConnectionGUID: j7ehXTOfR3Cu5Su5R9n3pg==
X-CSE-MsgGUID: nfOlbJXFR7mfZCWyI0QD3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271793"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:37 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 02/11] platform/x86:intel/pmc: Rename core_ssram to ssram_telemetry
Date: Wed, 28 Aug 2024 15:29:17 -0700
Message-ID: <20240828222932.1279508-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename core_ssram.c to ssram_telemetry.c. This patch is a
preparation step to introduce a new SSRAM Telemetry driver
for the SSRAM device.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Makefile                         | 2 +-
 .../platform/x86/intel/pmc/{core_ssram.c => ssram_telemetry.c}  | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/platform/x86/intel/pmc/{core_ssram.c => ssram_telemetry.c} (100%)

diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index 389e5419dadf..4dd9fa93f873 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -3,7 +3,7 @@
 # Intel x86 Platform-Specific Drivers
 #
 
-intel_pmc_core-y			:= core.o core_ssram.o spt.o cnp.o \
+intel_pmc_core-y			:= core.o ssram_telemetry.o spt.o cnp.o \
 					   icl.o tgl.o adl.o mtl.o arl.o lnl.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
similarity index 100%
rename from drivers/platform/x86/intel/pmc/core_ssram.c
rename to drivers/platform/x86/intel/pmc/ssram_telemetry.c
-- 
2.43.0


