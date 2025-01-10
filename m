Return-Path: <linux-pm+bounces-20167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE76A083E8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 01:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1B716870A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 00:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263893FB0E;
	Fri, 10 Jan 2025 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWnvIAj3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF42224D7;
	Fri, 10 Jan 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468781; cv=none; b=uWKuOaQslMs+QSRbx+SDX398qnbDq377GwrAwCuDBfvUi7HR4pcLzGfeCZwkK2Mdrls5NgeU+EmY4kAZoIutg8Sy+XP92PRIni6jiJe5l3DeL3rTp8jja+xKObHTXhdI+cQ+Fu3sBTyZOI8O6PkXLvV0aR6YK4y4QiB1koFe3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468781; c=relaxed/simple;
	bh=yNjKm0ryVmsmgF8cOHIgjNV/kYzW222nLIGfjCHjwdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FokdLnFRgttKu2uOUWpcR1XNJ/07WZXzvINOO4+juC91mggi3l5kWvNUQu51STUrzaqBcX+DwR32D2BD5BKsNaSLo/skfwjfZvTqzPehFaZ6OtvZC9n1wuBSq0YRvW9yFSxPX7ePoN34EIIGLhF2zDNt9PRnTM8buRtvy0vuka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWnvIAj3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736468780; x=1768004780;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yNjKm0ryVmsmgF8cOHIgjNV/kYzW222nLIGfjCHjwdM=;
  b=mWnvIAj3ugPHH01qydF8l2nJL/4sAXRAlTueRrG17jCbcZc/ZMw8TnHY
   Xoxvu98Y6C8E72lXaDKjWsYtWHIa5PRLAataNAzB1jc97s0BaXTR3OTV3
   kA6DhIYVYcvnwibBJeiTqN/hF4/jfljNxMW8V85ZG7nVzwLYAdUva0o7N
   UH1woRUjjsciK6r41rzga2DGUm9KQpMk4cWNgX+abfhXkVV/kBAXdbu/H
   ZqznD6cMbR/JtaDpJoUynH8guROwXVZ9FH9dlo6ODJim8jwd6v9Kopk2m
   WiIvGxyiVnvhaBqgUTqJagBsvZ3smlCkwmqCnmRWIZUAN5NvslCap+umK
   g==;
X-CSE-ConnectionGUID: bdDPjLY3TDyplRRo5YzmmA==
X-CSE-MsgGUID: Z+rrUc8sQVm7cAETgyZB0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36653483"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36653483"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:18 -0800
X-CSE-ConnectionGUID: Tb/z4IQ1RjKj29QVsIxeGA==
X-CSE-MsgGUID: K+paz7DoQ9K9vcvf2fV0Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104097026"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.222.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:18 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	rajvi0912@gmail.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 2/6] platform/x86/intel/pmc: Remove duplicate enum
Date: Thu,  9 Jan 2025 16:26:04 -0800
Message-ID: <20250110002612.244782-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250110002612.244782-1-xi.pardee@linux.intel.com>
References: <20250110002612.244782-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate enum PMC_IDX_SOC. PMC_IDX_SOC has the same value
as PMC_IDX_MAIN. Replace it with PMC_IDX_MAIN to avoid confusion.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 2 +-
 drivers/platform/x86/intel/pmc/core.h | 1 -
 drivers/platform/x86/intel/pmc/lnl.c  | 2 +-
 drivers/platform/x86/intel/pmc/mtl.c  | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 05dec4f5019f3..ad976cc83ecae 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -693,7 +693,7 @@ static int arl_resume(struct pmc_dev *pmcdev)
 
 int arl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 	int func = 0;
 	bool ssram_init = true;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index a1886d8e1ef3e..a0f6cc427ddca 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -430,7 +430,6 @@ struct pmc_dev {
 
 enum pmc_index {
 	PMC_IDX_MAIN,
-	PMC_IDX_SOC = PMC_IDX_MAIN,
 	PMC_IDX_IOE,
 	PMC_IDX_PCH,
 	PMC_IDX_MAX
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index be029f12cdf40..09b13df90d685 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -553,7 +553,7 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 int lnl_core_init(struct pmc_dev *pmcdev)
 {
 	int ret;
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 
 	lnl_d3_fixup();
 
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 02949fed76e91..07687a3e436d5 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -992,7 +992,7 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 
 int mtl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 	int func = 2;
 	bool ssram_init = true;
-- 
2.43.0


