Return-Path: <linux-pm+bounces-15456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8838B9987FB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 15:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F281F2205E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F2F1C9DD3;
	Thu, 10 Oct 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6mvVe/J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B11C9DC1;
	Thu, 10 Oct 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567611; cv=none; b=c6cPc4Vm/gX5f9Zd+wgeKS6jpE1hN2BhNo5LkU7RXl4Cho9CBqdgHMUkrAKsQuESJZ1Y4AihQ6kv2hME2g3TKBs5qjQyVgd6CEIXlW0A2HHHwRLKm//fNBVJ1igduYdrfFtptcL+SIRulwpHPJXnLO0/9LC7+QsZgesjl2jxynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567611; c=relaxed/simple;
	bh=n/dQBktwFVqrKxgnovAEk3fFnolb1PkxiAtuIMvs3KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=etuKWeMOKjMtPlNgQOXdQMCKwYPn3GH0Wf61/931olgKlMowhul9u2lW8CV3IghETUCufRQBguqF870xAob1N0sEFY9snfe6k88D5FSKz8Kxgvpbb/sODb9AdcCaH5y9OPUSQDI8NaBW3e4Ka6GFA7lLSgdI9lIWggYdjH9pLrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6mvVe/J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728567611; x=1760103611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n/dQBktwFVqrKxgnovAEk3fFnolb1PkxiAtuIMvs3KA=;
  b=c6mvVe/JidVs5hLGbpm3pWW3mhkx6thk/VI6WNIEugC9o0fhpvanpeBG
   USTuFxG4dSNXBO/So/fgJQtCmwtf6d1lAyvfh6zBMBtC/CRd5aNA9yeJw
   cK8XBOxqsLa+U5dF+bT8aBZZu12zxYo4IaJBaJgdl7Oum9/qdPUtTvnty
   z1w+IpRIgI+FOupy+6W0UxHD2m457NYzS9CFv1rxrtP0E+8enmKAsf7Qm
   mn9vXMEKHNCuB4GBiNdosFDFUr0SgfqC0hcQkUWXW+lFZebS+hOhoMWp5
   xMGUmno3ZwYLi5OihVA6vdEt2lLVLHcU1RrmLq2458wFtpUq7Ax4vxvhE
   A==;
X-CSE-ConnectionGUID: rxpHeRr5T8W3ZgQRqCPQng==
X-CSE-MsgGUID: nf4lZJz7RUCOl9dfLkU9Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31718272"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31718272"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:40:10 -0700
X-CSE-ConnectionGUID: TRxLachoTrahhBw9FFbh2A==
X-CSE-MsgGUID: CI0PdumRRDqPTdPnycgRVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81114913"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.12])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:40:05 -0700
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH 0/3] SRF: Fix offline CPU preventing pc6 entry
Date: Thu, 10 Oct 2024 15:39:52 +0200
Message-ID: <20241010133955.7749-1-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the mwait_play_dead() uses undocumented
way of looking up the mwait hint for the deepest cstate and using it in
cpu offline code. This prevents entering pc6 when the CPU gets offlined
on Sierra Forest. The solution is to allow the idle driver to force the
mwait hint.

This problem was first observed on SRF, but since determining the
deepest mwait hint is non-architectural, the hint is forced for all of
the models that intel_idle has custom table for.

Patryk Wlazlyn (3):
  x86/smp: Move mwait hint computation out of mwait_play_dead
  x86/smp: Allow forcing the mwait hint for play dead loop
  intel_idle: Identify the deepest cstate for SRF

 arch/x86/include/asm/smp.h |  3 +++
 arch/x86/kernel/smpboot.c  | 54 ++++++++++++++++++++++++++------------
 drivers/idle/intel_idle.c  | 12 +++++++++
 3 files changed, 52 insertions(+), 17 deletions(-)

-- 
2.46.2


