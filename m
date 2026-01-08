Return-Path: <linux-pm+bounces-40514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B22C2D0670C
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 23:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F8AC3061B34
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3646332AAB3;
	Thu,  8 Jan 2026 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zw6lJFAg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2432B990;
	Thu,  8 Jan 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911518; cv=none; b=f8w0akDfEHZ0d7lNVV75IWDEjSuZwGA1TQFBxWEQZ/DO64Tk2tYWIA6uDhqopr5HM9rNtRHWhFmWSYlh1fT4xr9UkRR03iJi29IpLUoq1yglA5TM5ZVYMqg72QPGQCtSw2FZ/XOQ+EWU/R4EZzRSjgxTJhTAbv82vylzb0Rv0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911518; c=relaxed/simple;
	bh=MKd68gLvofFlcm/e7KLTW6rtgDAnj+NN2mRzNd+Vn4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxv4HU/udicN3X8w8SQig3Oesrs/gTdg+PioxpGXFYUz027xZ3L5eyAGWGD5CzTpPJYxOcYlLePAMWPAcWLQjqU9jbVGXfwGAqeCrh3OQTifVPhRgx2Ulv3moesF28MzdDgi/yYuVcd1luIFyZ2PulkRk2QykAIrMve/PmHgaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zw6lJFAg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767911510; x=1799447510;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=MKd68gLvofFlcm/e7KLTW6rtgDAnj+NN2mRzNd+Vn4U=;
  b=Zw6lJFAg5wI/T6hGR70eBIyDiEYfkgMIaxBGMs0JfwyhHO0Di/FdBLz+
   s1moDaKPQKRfCNyBuQZ/GsPV0wyhVRzjhISFbRixQ/gzxmS6BUhLgNiHG
   LN0Hyz9L0yCTq9SzfyPqdnohZaBE/We+mUshd8kYKaIk8i5T9jFhy6/9x
   wav0ExtmZKZ1WyjBjdeoCoEWz6iuVLq647kusyLU4oezbomlzh8acPkGg
   1Qhd0TD7QSjQzHnhK91O0Q8I99WGk0yMc+lGJDXGaX1ixE3UQoeoNPXKM
   leyjYxv0+nGrPMFdsw+3a+xfcgGnAy1zdcc+wnaLyyWl0tjy4uAJEEbUM
   A==;
X-CSE-ConnectionGUID: 69o5a7laSFeRJjNB+HLMBQ==
X-CSE-MsgGUID: mlwQMg7SS8ejFSUQLo76ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69349140"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69349140"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:31:49 -0800
X-CSE-ConnectionGUID: 00AdFt2NRES7fI5w5tFiPg==
X-CSE-MsgGUID: 43u1hqYWRqS0BQhlD9RxDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207797175"
Received: from msatwood-mobl.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.109.238])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:31:49 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86/intel/pmc: Remove double empty line
Date: Thu,  8 Jan 2026 14:31:42 -0800
Message-ID: <20260108223144.504267-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108223144.504267-1-xi.pardee@linux.intel.com>
References: <20260108223144.504267-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove double empty line to improve readability.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e16f9630b908c..02b303418d185 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1248,7 +1248,6 @@ static void pmc_core_pmc_get_low_power_modes(struct pmc_dev *pmcdev, struct pmc
 	/* Read 32 bit LPM_PRI register */
 	lpm_pri = pmc_core_reg_read(pmc, pmc->map->lpm_priority_offset);
 
-
 	/*
 	 * If lpm_pri value passes verification, then override the default
 	 * modes here. Otherwise stick with the default.
-- 
2.43.0


