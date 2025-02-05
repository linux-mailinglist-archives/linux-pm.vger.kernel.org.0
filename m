Return-Path: <linux-pm+bounces-21401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD08A294D6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 16:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067423AC7FD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A20E18D656;
	Wed,  5 Feb 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UM1yQk72"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177518C93C
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768862; cv=none; b=EtuejUHABjxtt4AqVmClCKz8/0dDWj3pF7SuXJwWnleraewqitgniMYW9Hs0MKEirWZjZtrKSMs49wY1DdyxbkUCaTdRZ2z9+ccyPqr3jUQS3nZFemxtt/NyyxuUUZPLAEgwFtlyyfEdQZnDJH6fplJ63NFXGcsQdfRjVe/Jee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768862; c=relaxed/simple;
	bh=B/D4yWMPdKecLnJEG3834xTCfvTLZFTQCy2b5FFu7fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIoqshj+OigRVPrCN/jB7tcnUPTuLvsqiyzk+ugMu6KYBA6qXs+/pmq7PkGNHG6sJaehD4vruB9QplVeHFNOxVHse0730K4aDq9TKTkCO+EEF+NXj+gp1cyNRDdQdEI1sGpVn+93GB4iIrIGBJtK8psF7dFrxWV47HWZr87b/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UM1yQk72; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738768860; x=1770304860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B/D4yWMPdKecLnJEG3834xTCfvTLZFTQCy2b5FFu7fc=;
  b=UM1yQk72rY0vvGdaJTp+g4nINaEW+5s0rZw4ssOuBuytL2sNuc4Zan6e
   zSWw90JN+PB/c8LlvlzQ08jaqwEDn27r58q9EpAjIWkpqonWLPFIEOiFQ
   JoHitrStOnq9VN5MRP6kinm/v1CnzHxG+gcWzv9U3hjVoFrRVdYxKXB2P
   /jnjrCgdov5MQHyAe1NUxE4Q9m4mZcLMA3r/rydd2Z+1Vf6m819eqGArh
   aYincWHrW9ffpIoc6C7ebuLn14jPbtcuIhnw+lU7gnTreD2SlBukCAYoD
   nPiafAsD57oSwJKr6GzaCPPDQGLLhlcWAEriq5NJJSj0N9+Z9NN8JPI+O
   g==;
X-CSE-ConnectionGUID: TiKEdsXeSpaHA7sbHZE2KQ==
X-CSE-MsgGUID: wmSqwt0gQcGyyfSJ9sKVRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39498145"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39498145"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:20:59 -0800
X-CSE-ConnectionGUID: LzikFhuJS1K0N33zlsQiyA==
X-CSE-MsgGUID: xD5xT4rLR96HU/q1D7IWDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="111109479"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2025 07:20:58 -0800
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: x86@kernel.org
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	dave.hansen@linux.intel.com
Subject: [PATCH v10 0/4] SRF: Fix offline CPU preventing pc6 entry
Date: Wed,  5 Feb 2025 17:20:52 +0200
Message-ID: <20250205152057.171030-1-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Code for determining the mwait hint for the deepest C-state by
inspecting CPUID leaf 0x5 in mwait_play_dead() assumes that, if the
number of sub-states for a given major C-state is nonzero, those
sub-states are always represented by consecutive numbers starting from
0. This assumption is not based on the documented platform behavior and
in fact it is not met on recent Intel platforms.

Changes since v9:
  * Patch 3/4: remove the '__cpuidle' instrumentation tag from
    intel_idle_enter_dead() to address this objtool warning: call to
    cpuidle_get_cpu_driver() leaves .noinstr.text section.
  * Patch 1/4: rename 'hint' to 'eax_hint' in the !CONFIG_SMP for
    consistency.

Tested on AMD Milan platform and on a couple of Intel platforms.

Artem Bityutskiy (4):
  x86/smp: Allow calling mwait_play_dead with an arbitrary hint
  ACPI: processor_idle: Add FFH state handling
  intel_idle: Provide the default enter_dead() handler
  x86/smp: Eliminate mwait_play_dead_cpuid_hint()

 arch/x86/include/asm/smp.h    |  3 +++
 arch/x86/kernel/acpi/cstate.c | 10 ++++++++
 arch/x86/kernel/smpboot.c     | 44 ++++-------------------------------
 drivers/acpi/processor_idle.c |  2 ++
 drivers/idle/intel_idle.c     | 14 +++++++++++
 include/acpi/processor.h      |  5 ++++
 6 files changed, 39 insertions(+), 39 deletions(-)

-- 
2.47.1


