Return-Path: <linux-pm+bounces-18539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCFB9E3CB6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EAECB28B14
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099A01F756C;
	Wed,  4 Dec 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8z7JPPU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190551F707A;
	Wed,  4 Dec 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321322; cv=none; b=fWbdwDRsbIMfU8SGIXOBCHQet6iK9fpMGjhMT5XEeOgwzGc6Ezhqs+wGpVV3/eFjMAfrZ7LRw5izQm0pp7i00383bt9yrQZNwCdj2lRdTsw5Lf1h2kTbBEduDgaATXHkqOxcmtjBE8DDx8Olj7++6P2WL8YrGkxQVgna2vicyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321322; c=relaxed/simple;
	bh=Ymy7pkPzVdCjEAV9k3xTXqWa9fnRsdXkeTtBczKEruU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBwySFRBTNhCBrWDK60OtHavAbeRCkTD5ArF/Z4XhgoyijsY+Eu/IFraE1laCzxK9DKQlEAf2sIP8dYK8Cm9EJw5M6e0c2do0ipkk6AC68iVyr2kQz7s87nt0U05GPOFweVtZPNqL3B4cpxCDY2Ju388eIQNHTids74FV+9FubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8z7JPPU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733321322; x=1764857322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ymy7pkPzVdCjEAV9k3xTXqWa9fnRsdXkeTtBczKEruU=;
  b=M8z7JPPU8W0VVoKo/XAgc2/584+VX3BFF7cnBT4JlmgeO5xuJbLcRyR/
   K66TiFo2grmXwjqgyv1dbIXDsMlOKGwQI0CQvTk2migzRtZZsUo2r9oMZ
   8a85ICUUMiQGk+mPIgQsMZuDD9tpHMZ0keRfBJ3Z93Y2BVXBa3TuSKmVV
   Moh4Mihxv2kzRNJNuJL5Qv+aGevxA8NOC/VDkiCFQ7b3cMQW/X0gK4yzL
   dF5/zxizWc7ObjeSibAEzyqKO5JMDtEZiq8PnxNpK+OU+t7oOPQP/SUFP
   2xTIHj+CmNFIULpAxKbThsjb7YVDAAwK8GbZT8ZS62dvpyKQP4zcyGI/R
   Q==;
X-CSE-ConnectionGUID: 0rgCMq8fQnqdNJySxVbuQg==
X-CSE-MsgGUID: LG+qmnSkTl+JfQiT3LDlIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="56071331"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="56071331"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:08:41 -0800
X-CSE-ConnectionGUID: noZ5gi/gQ+uhNxQYHXmxjA==
X-CSE-MsgGUID: WsZsc33PR5mC8ZiZUZmSvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98202761"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:08:38 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com,
	tglx@linutronix.de,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v8 0/4] SRF: Fix offline CPU preventing pc6 entry
Date: Wed,  4 Dec 2024 15:08:24 +0100
Message-ID: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v7:
  * Doing the s/mwait_play_dead/mwait_play_dead_cpuid_hint/
          and s/mwait_play_dead_with_hint/mwait_play_dead/

    as suggested by Gautham. It was a left-over from previous patches.
    The function(s) got renamed in the patches and I forgot to update
    the changelog accordingly for patch 4/4.

Patryk Wlazlyn (4):
  x86/smp: Allow calling mwait_play_dead with an arbitrary hint
  ACPI: processor_idle: Add FFH state handling
  intel_idle: Provide the default enter_dead() handler
  x86/smp native_play_dead: Prefer cpuidle_play_dead() over
    mwait_play_dead()

 arch/x86/include/asm/smp.h    |  3 +++
 arch/x86/kernel/acpi/cstate.c | 10 ++++++++
 arch/x86/kernel/smpboot.c     | 46 ++++-------------------------------
 drivers/acpi/processor_idle.c |  2 ++
 drivers/idle/intel_idle.c     | 18 ++++++++++++--
 include/acpi/processor.h      |  5 ++++
 6 files changed, 41 insertions(+), 43 deletions(-)

-- 
2.47.1


