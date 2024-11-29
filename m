Return-Path: <linux-pm+bounces-18256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6FD9DEC09
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 19:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F3B16358C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D2E19F430;
	Fri, 29 Nov 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYgfnOLz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E6148FF5;
	Fri, 29 Nov 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904569; cv=none; b=J2TSG69JJHs8iWyzjQ1z7aph/wLKCI8nfbURmPdtsDBgyfZi3lTdJoxpnBbm1YDU37bTfLVENHMl1iWoTALW5wAa9Pm9okQ91NGjrcutyNa7nHdLurNxF+qoebDWTsaxBNQvX9emWpttpoXtW3HU/rUbz7KjxuJ3+5yNGXJG6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904569; c=relaxed/simple;
	bh=fcCPEofYqr6f6bmzqmvzrFXO1j3FX5qg5fPMGI3JtXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmYSXzvlNiokG8MKWi0aHKF/syXWckEdKqXklCATqkWuMQyJ/6CDqQS38QbxgvjvYyVg9e/wo4bWN64zStlF1OOpRtKcKvYdH+viAofLqXoNZP5V41UnI++4XxJch96KAosPYYRP9KyI6JWpqMjF9zCvq5QOFyc7LFCDPwWYLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYgfnOLz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732904568; x=1764440568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fcCPEofYqr6f6bmzqmvzrFXO1j3FX5qg5fPMGI3JtXg=;
  b=KYgfnOLzrjP3L01pk+ZH7QRFmpRsFuqRwrK4Of470bzloYEgf/dWc3O1
   xg5dM9w1HbSdsaiXecLGIzITLz5kjeDl1HVSsJ7pxZvqyV8NcHLQvpOrD
   bKtCtOZEPpMAqspWnfjHYrJ4NOw+DNeBseC45sh8qaGgQZkeaygsemdG3
   TYYj/QmYz4DPQ2rYskIz3iQ3wezTTz9s4rFFBnPT5y4GCffe4gGlFTK+x
   PeeDyoY+rPBUtB+wEx/KyADQ8ZPTk0nVezNmx6YhWsDTQQnLZTUhTo9C8
   aIhD2en4YjWLuaZD/8+MRiSU1r3JYszJmAg5A3OxbNnLmaEm57DCi/6kN
   g==;
X-CSE-ConnectionGUID: 8SC2V+dnTTqbacieFjl2mQ==
X-CSE-MsgGUID: no6yBNV0QiKVBylNfvW+Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="36811929"
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="36811929"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:22:47 -0800
X-CSE-ConnectionGUID: Bm7gjGxZTgOBzJ5Eqxy1hw==
X-CSE-MsgGUID: htCeUixpQHCEVDMQUN3ZHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="92422105"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.203])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:22:43 -0800
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
Subject: [PATCH v7 0/4] SRF: Fix offline CPU preventing pc6 entry
Date: Fri, 29 Nov 2024 19:22:28 +0100
Message-ID: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small update, after Gautham's review and few changes around comments that
referenced old mwait_play_dead code, that I noticed after submitting the
v6. Some places referenced the old mwait_play_dead() in the comments, so
I decided to reuse the mwait_play_dead() name, so that the comments
don't have to be updated.

Changes since v6:
 * Renamed mwait_play_dead to mwait_play_dead_cpuid_hint in 1/1, so that
   mwait_play_dead name can be reused for the function that takes the
   MWAIT hint as an argument. This leaves the comments around the
   smpboot.c file that reference the old mwait_play_dead() unchanged.

 * Moved the old comment above mwait_play_dead() to
   mwait_play_dead_with_hints in patch 4/4.

 * Added missing include of asm/smp.h in arch/x86/kernel/acpi/cstate.c

 * Removed empty line added by mistake, spotted by Gautham (Thanks!)
   in arch/x86/include/asm/smp.h

 * Reworded 1/4 commit message to better describe the changes the patch
   is actually making.

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


