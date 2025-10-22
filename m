Return-Path: <linux-pm+bounces-36679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 476D6BFE5AB
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 23:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18E004F58D3
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 21:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986732FA0E9;
	Wed, 22 Oct 2025 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k78uvr2/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0D26A08C;
	Wed, 22 Oct 2025 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170086; cv=none; b=SeK/Ug62RXzv3BAkgY2SdL8xdl8idZ2kJXfCOzJwYfQlHUvbMmI4VfPVRx7sS/cw2uJqLOaJy732UjvTWOaLqKwBK/3O5DWxBY4CwO5PF4eMGg6ereNKjjZXEr9Pyn2+IEx8+ULk3IgNFa1VMS2Ia/d0eGzocMmNpuxqzxC9QRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170086; c=relaxed/simple;
	bh=q2Z+aLpyjSEgn4k4zzWqLbE5nFJEaMxzt0ps4s5d9dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLFBKl55XXFqyGwtFLtkaDRjSXlk90Z5TnJhurdp+VV0qqXprud45Rp8/CbOgGyGWzgjNgYJBlnVjoQTj8MRBPYp7EXnetOr8IyTyx5laPSSyR7T4SHjYq3Aq9ofQE7ikFjK16YlCgxqCkEpfCfbNYoHBIe9VIwhqh+wA5kiaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k78uvr2/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761170085; x=1792706085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q2Z+aLpyjSEgn4k4zzWqLbE5nFJEaMxzt0ps4s5d9dc=;
  b=k78uvr2/eHifdu1aH1gMzHo7sCEFphx7WSIo1kXL1/W+CqCDCSnrVV5/
   2u0oWVonkF4Sg+2vmdQe1oZJlbQr+L8hxtcrThVOAX14jRuo8pQgsxODP
   3LaIiCQwIE8zSX95hvX3zwxiNiL0UorjWKd28QWYF9WQ7rpblEJm4Z8c2
   hZsRttRbZ96dsZjPU8x6IB3tWwD8qnvInIDcGZRETuXXBVcT8XAYIncZP
   cHSnNnS9fbfavGZdyaj9U9RwIzZP0wkSYE3InzXTpw9wS2ok1krbvGrIm
   nftHDl8KP2Khagg7NEQMmCjm81wt3yfhQ/ytVDAE3wDuvMJpL57BTjmKT
   w==;
X-CSE-ConnectionGUID: I+iGD2g5SIuALPZzAClZCg==
X-CSE-MsgGUID: Kxa2eV+nRE+ZYbRnJE7trw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73936338"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="73936338"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 14:54:38 -0700
X-CSE-ConnectionGUID: 1+vMHUN4R6iiEoLsDYsINA==
X-CSE-MsgGUID: IA8anjFKStGNIRrKBfWdSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="188026193"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 14:54:36 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Rafael J Wysocki <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] cpufreq: intel_pstate: Add Diamond Rapids OOB mode support
Date: Wed, 22 Oct 2025 14:54:25 -0700
Message-ID: <20251022215425.3566218-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent intel_pstate from loading when Out-of-Band (OOB) P-states mode
is enabled.

The OOB identification mechanism for Diamond Rapids servers is the same
as for prior generation CPUs such as Granite Rapids. Add the Diamond
Rapids CPU model to intel_pstate_cpu_oob_ids[] to ensure correct OOB
handling.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 38897bb14a2c..dd1ebfc7de28 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2761,6 +2761,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 	X86_MATCH(INTEL_ATOM_CRESTMONT,		core_funcs),
 	X86_MATCH(INTEL_ATOM_CRESTMONT_X,	core_funcs),
 	X86_MATCH(INTEL_ATOM_DARKMONT_X,	core_funcs),
+	X86_MATCH(INTEL_DIAMONDRAPIDS_X,	core_funcs),
 	{}
 };
 #endif
-- 
2.43.0


