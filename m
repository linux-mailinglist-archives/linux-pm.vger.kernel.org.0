Return-Path: <linux-pm+bounces-9407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE1790C33D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 07:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600E81F22977
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 05:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF1428387;
	Tue, 18 Jun 2024 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlLNYlgv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C881CD1F;
	Tue, 18 Jun 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718689956; cv=none; b=uA5pyf2PuEgbcbrStgi/HDfgvblT0c2mAF5nbJqQGmKSWQE3W9DGzqPoM7VjESgiGO3zBOxNaMtkpkVTWnSu8wXJH2pJOo/7ce3pIFUz79466qemeJ4og+JqJecDZzBDQqYSFKye+uAcM50k6jUS0wcCJP6TQvi77CDILaLcZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718689956; c=relaxed/simple;
	bh=lCKxJrGHEI7wjWUMHp4GH/QVQJh/sFx55ztf0tmp7eY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t70SiZFubCJFQX5/fAJzUaSbEzSDPIm8QII54KX1bNOFQ2hX8Tq89KsCnsvAAp58P6LxFHjGUDiEDyG0JbQo2tqloOZeteXfYeSZ54gkMDULJQMegPtqqMxoho/6qUFsyVdTxHkYp/DEHlxJNNYFezCqtKivtrjwCHiKqdk+gpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlLNYlgv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718689956; x=1750225956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lCKxJrGHEI7wjWUMHp4GH/QVQJh/sFx55ztf0tmp7eY=;
  b=JlLNYlgvIGjeLI0nfnbPElSI/LDxVQezYqzzkA5bmvRxVL8KSunz8oIL
   5XkUuJ/eTk4EYaaiIcJZ4wAqrsew0pFBPBW4w7NrmJ4zUQw5OmYRHOmUb
   h4FwqvXeY+UThyEnn8OPjlZQh80BIEddcskI6k9leJyI8G1lg2u20hGHF
   rgM66/l1hZFnVGfIo9OIQGxUgauLpglSyFKbOMFbu8TZOhKNIdZ+WBngf
   oZUuQ7cIV5lktwQ/ZrKEcDPIPjMyt9RSyI0RHAgsiTXT1Cq72YCRVLRFU
   g9WWRr2FMzc/ZhlfItkIP2BGBgaKpvbeGZANPXc8/9UtlhVo4xyp3rya6
   w==;
X-CSE-ConnectionGUID: AyVlCOosShiX1xcKBYJixA==
X-CSE-MsgGUID: Z8G1YD8+SiCJQ3PvdrKFGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15685676"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15685676"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 22:52:33 -0700
X-CSE-ConnectionGUID: qbBc5Q/+Q0Se6rso2eEU3g==
X-CSE-MsgGUID: 2jOuAyRAQVycTC8Z/1CFiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41352841"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa010.jf.intel.com with ESMTP; 17 Jun 2024 22:52:33 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Update Arrow Lake hybrid scaling factor
Date: Mon, 17 Jun 2024 22:52:20 -0700
Message-ID: <20240618055221.446108-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arrow Lake uses the same scaling factor as Meteor Lake, so reuse the
same scaling factor.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3dc9b82c43af..72d9e60369e0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3401,6 +3401,7 @@ static const struct x86_cpu_id intel_epp_default[] = {
 
 static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE, HYBRID_SCALING_FACTOR_MTL),
 	{}
 };
 
-- 
2.44.0


