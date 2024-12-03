Return-Path: <linux-pm+bounces-18454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886309E1E9D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 15:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12151B25038
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D4F1E0E0C;
	Tue,  3 Dec 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNz2uwYs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F79224F0
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230995; cv=none; b=K+hH8usqAw5jYdsMP1HRIrmtGcF9Po1icMvEcrn0euM920i0d9HCcYkfRQMRAUxWLT54OPfJZlCK0Jt+6AmBK5uqYV0TVnHZ6Jls1K0r3Hg8V8Fm2plccUjMqK+vY5fBOqFl9Bi0BNUHngGEaOHmq7gqer46kxGAtvJ+/1yICEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230995; c=relaxed/simple;
	bh=HmhuEgvI3G1fDAwp//O6mHyy7iS37ogl3iDWsgEbDUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXF6G3VUeTbaM6GWPmcBpKlPw5E9PzoXb8D7ga7/d0FaVBwoLOp+K/cYOSLgnt+Vyf/py3A2RrvBqtT+K2nE/ghUolPY9aD4rd1q4Xy+EGlOuBwcB684MIPtoocjrvjD4gnW2CICoK736n8+4KkXKfmy1xmQv748IVez7dbasec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNz2uwYs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733230993; x=1764766993;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HmhuEgvI3G1fDAwp//O6mHyy7iS37ogl3iDWsgEbDUM=;
  b=NNz2uwYs9imaS7k61bMTRE4jTm8JMQdEan2hw9JFDci3ocRWnxj6uGL7
   HSELJsridM10vLb8kP9AzR5xHd2yTm5sNXYpJB5MfkL1K+dirytkexDFB
   Npa+mFV4a9tOO3ZXWz/6oNYrVPViqEExQ+5cncVWd0/KGEE9em2zQDlaZ
   HlMK9RdPhxkfbeWC48PNFGS5CLVfFbcukxT+t9dH87BBqddtxhNurWFnL
   gUKDDXSSM6ZYwZRBbO4nnfGL01ypPw/KkBDuB5b77bEMeSBxdCngC0wCp
   ze4x/Ya1+ScpAUXo0VvbhiW63i0G2+roWRokVQ6pU0WOw2EDEDxoKIymy
   Q==;
X-CSE-ConnectionGUID: ZF0n0tN/TVOTBdlWNvVnUg==
X-CSE-MsgGUID: MaFX2jlRR/qFK0RNW1S8EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32800545"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="32800545"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:03:09 -0800
X-CSE-ConnectionGUID: 6N5wxUjUS2Gz1KvHKAdQPA==
X-CSE-MsgGUID: Rb1DQwAxQlOhWXvK5v1ONg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124370267"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa001.fm.intel.com with ESMTP; 03 Dec 2024 05:03:07 -0800
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Linux PM Mailing List <linux-pm@vger.kernel.org>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] intel_idle: add Clearwater Forest SoC support
Date: Tue,  3 Dec 2024 15:03:06 +0200
Message-ID: <20241203130306.1559024-1-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clearwater Forest (CWF) SoC has the same C-states as Sierra Forest (SRF)
SoC.  Add CWF support by re-using the SRF C-states table.

Note: it is expected that CWF C-states will have same or very similar
characteristics as SRF C-states (latency and target residency). However,
there is a possibility that the characteristics will end up being
different enough when the CWF platform development is finished. In that
case, a separate CWF C-states table will be created and populated with
the CWF-specific characteristics (latency and target residency).

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 1 +
 1 file changed, 1 insertion(+)

Note: the patch is against the 'linux-pm' gree.
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ac4d8faa3886..23d0cd27a581 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1651,6 +1651,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&idle_cpu_snr),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&idle_cpu_grr),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&idle_cpu_srf),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&idle_cpu_srf),
 	{}
 };
 

-- 
2.47.0


