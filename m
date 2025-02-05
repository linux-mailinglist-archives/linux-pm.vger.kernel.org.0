Return-Path: <linux-pm+bounces-21407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251C6A29556
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 16:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507F3168A40
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9511991DB;
	Wed,  5 Feb 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8IU24rd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0519B586
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770738; cv=none; b=TJTeY0r0OhNihWgjld3eA+macoEJgPa9qncQehLAV3rVnidvdp2V7D00uhZ1/iAU3upQ0CbS8DjTCrfhssE8yo756BBT3ffcbQ0Asyuo3zzvi6xb2DQQnGY+0cLQfmDJj2iJE+NxzQbiOgKASnJQXOOpW2R4OXR/h62O47LzP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770738; c=relaxed/simple;
	bh=Ep3KxQW84HV8rYMPbHZELFYQXO/6bkdPZwOZjoMVg6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACpyVdG5TMprbJksJsr6h08bhtSHltKKlb6GSJrYW3575YblJXtQFWP889QQpbBqLYXb4BrJvo+jsTQDKf4alD+iLZ8fWs5rjgDl6ATylDQCQP6MH0eHZy+EJHcF+DwOyuQGFUBpGQFH2mvvTBsoabWn5LA1uPuuC8w1t0Nvz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8IU24rd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738770737; x=1770306737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ep3KxQW84HV8rYMPbHZELFYQXO/6bkdPZwOZjoMVg6M=;
  b=J8IU24rdQqqATUUuZl3P8BhZMIZpwN1TK6S3gGkpO5gao6PgtMirYHIu
   NyFsIE1SXMhu9HEeZ9qpxs+hizP/Sbcu/lds49t5841EaNJFBD6c+ImvE
   O7Or8w9joINkoXk1OJdYS3qqaT71cWZawClJVqMd19/zbXpZLsECuTyS9
   uz9IaAwfxpTtsspQXQrvoYWK0nm9xJwetrbQb4js6MxcI/ZrEADaoLv6a
   Horg98wyBibF1+qM7F24oPZFvaUlpKWXlJAtnQyF8WKdCihFKi+nq2S7i
   //FMgSLcLadrjLy56AUhL5/T2WkEqeh5gj6X6U1cNAOoTJKtDVs+ObuRs
   w==;
X-CSE-ConnectionGUID: cnFFA9jjTliqL25HgJDfIQ==
X-CSE-MsgGUID: UWxK74tBRayB/oWEyv/HEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50330963"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="50330963"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:52:16 -0800
X-CSE-ConnectionGUID: 7FiOWH7sQKizB38M4rIhTw==
X-CSE-MsgGUID: F+bIVEN5QzujI21oVbeW1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="111516288"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa009.fm.intel.com with ESMTP; 05 Feb 2025 07:52:13 -0800
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: x86@kernel.org
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com
Subject: [PATCH v11 0/4] SRF: Fix offline CPU preventing pc6 entry
Date: Wed,  5 Feb 2025 17:52:07 +0200
Message-ID: <20250205155211.329780-1-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sorry for the traffic, did not get the tags right in v10, fixing. ]

Code for determining the mwait hint for the deepest C-state by
inspecting CPUID leaf 0x5 in mwait_play_dead() assumes that, if the
number of sub-states for a given major C-state is nonzero, those
sub-states are always represented by consecutive numbers starting from
0. This assumption is not based on the documented platform behavior and
in fact it is not met on recent Intel platforms.

Changes since v10:
  * No code changes, only fix "From" and "Signed-off-by", also add
    an "Acked-by".

Changes since v9:
  * Patch 3/4: remove the '__cpuidle' instrumentation tag from
    intel_idle_enter_dead() to address this objtool warning: call to
    cpuidle_get_cpu_driver() leaves .noinstr.text section
  * Patch 1/4: rename 'hint' to 'eax_hint' in the !CONFIG_SMP for
    consistency.

Tested on AMD Milan platform and on a couple of Intel platforms.

Patryk Wlazlyn (4):
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


