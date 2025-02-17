Return-Path: <linux-pm+bounces-22265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D920CA38EB8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C811736A3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B11AA1E0;
	Mon, 17 Feb 2025 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzCQqQiV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A55019E999;
	Mon, 17 Feb 2025 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830055; cv=none; b=azDKvdbJxI3XfR4k2mbgjlpPxlTX4iKj0fpHIr2gdgKv/ucLid/YjNboqc7xG0A+il5dvQ927pGtvmncXs4GqUSFCGV8GtMjMTFNR3W9paztJZB+8j+eg8r7cdxLi//Um0LtgJGEx9qnlH9JKovsbzFhSxpxoHvlOmPae4Wyueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830055; c=relaxed/simple;
	bh=3eet+SfkjGmFMFBdttMU7uwQEMBf27tn1bjASmuISaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CntWeQzWfPHIAeJsVv3uo6KW5P7wjz6rUj2gShAlBGErzf0ZooMKxJz0RfMpcjJBIUxQJKBZpSqvKNixK0l5ocTYeZwo4DVynvelaxoYWQJAVpM/JsrxpC7I+Gz/G7jpHw1u8bxrENNc63+IrexT60OM7JrYcE2AxbStMeW1bR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzCQqQiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE378C4CED1;
	Mon, 17 Feb 2025 22:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830054;
	bh=3eet+SfkjGmFMFBdttMU7uwQEMBf27tn1bjASmuISaU=;
	h=From:To:Cc:Subject:Date:From;
	b=dzCQqQiVJ0fg/SaQQw70Lpc/vUfcp7XHvs6jG87IrhZZ71TB825iTKWuYiphENqxi
	 M2qNOs9XcsftK0OWlqU3eXgXKhyY5NstGDS9+7xuzIt5E2F8vQRpbHOHmunr8UuUgU
	 J9sA94jJeoP1188mPNPxm8swEUDvJUQhOffZ2bWZJs2L8TL6RhkqlnmQ5uySSE+9c/
	 8qKjIKvwSL6RBAlj89fAauYu7taBfJUTKNORCkLBebXpEJHFGqOmzWfF/oyevM9KW9
	 Bl0kMLJH8GqY3vzkYyK7gbee7N+b04siTc6B4fSQ099Ote9mtTxHWzckT34MXqlQg2
	 mAQBWCjBXV9xA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 00/18] amd-pstate cleanups
Date: Mon, 17 Feb 2025 16:06:49 -0600
Message-ID: <20250217220707.1468365-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

This series overhauls locking and drops many unnecessarily cached
variables.

Debugging messages are also dropped in favor of more ftracing.

This series is based off superm1/linux.git bleeding-edge branch.

v2->v3:
 * Mostly pick up tags
 * Add new patch 1/18 that fixes a KBZ issue (see patch for detail)
 * Fixup for min_freq issue in dropping cached values patch
 * Fixup for unit tests to only run on online CPUs

Mario Limonciello (18):
  cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend
  cpufreq/amd-pstate: Show a warning when a CPU fails to setup
  cpufreq/amd-pstate: Drop min and max cached frequencies
  cpufreq/amd-pstate: Move perf values into a union
  cpufreq/amd-pstate: Overhaul locking
  cpufreq/amd-pstate: Drop `cppc_cap1_cached`
  cpufreq/amd-pstate-ut: Use _free macro to free put policy
  cpufreq/amd-pstate-ut: Allow lowest nonlinear and lowest to be the
    same
  cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL enums
  cpufreq/amd-pstate-ut: Run on all of the correct CPUs
  cpufreq/amd-pstate-ut: Adjust variable scope for
    amd_pstate_ut_check_freq()
  cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
  cpufreq/amd-pstate: Cache CPPC request in shared mem case too
  cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and
    *_set_epp functions
  cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
  cpufreq/amd-pstate: Drop debug statements for policy setting
  cpufreq/amd-pstate: Rework CPPC enabling
  cpufreq/amd-pstate: Stop caching EPP

 arch/x86/include/asm/msr-index.h   |  20 +-
 arch/x86/kernel/acpi/cppc.c        |   4 +-
 drivers/cpufreq/amd-pstate-trace.h |  13 +-
 drivers/cpufreq/amd-pstate-ut.c    | 209 +++++-----
 drivers/cpufreq/amd-pstate.c       | 592 ++++++++++++++---------------
 drivers/cpufreq/amd-pstate.h       |  61 +--
 6 files changed, 428 insertions(+), 471 deletions(-)

-- 
2.43.0


