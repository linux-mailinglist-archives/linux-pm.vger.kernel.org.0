Return-Path: <linux-pm+bounces-22121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E0A36A2B
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E27164CD1
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB02A1BA;
	Sat, 15 Feb 2025 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovwI50sY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD31373;
	Sat, 15 Feb 2025 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580776; cv=none; b=kVVJUGfmp8TqkV/eQ36DXIP7lnYM/hLkwF8kz5CaOymhTjMDznlGV/TqsiI1t2g1iTOSoPLjmTJ4y4o/a7NXKyRfUKvfr4dK2Oaq3l7v/5wOo7yBTuL2xHgxWSfeIsfZrK4vKEkJQNdkOuxLlqc/1fRW+1y8ysrXy6hv472DOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580776; c=relaxed/simple;
	bh=18gY+6DNEY6pm3vWq+D6ujWxKSDxDmMWkCpBg3C4kX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/kuHhcWxgVl9bdxodX32xyoDNou/W2sEbR6ymbIq2iv/PeGSom4xBrCTj8PUig20GV/21pD9KVjYI3geOsZevTkY+4Tu/T54VJsNdVG4WCLkgjlZAzmbxrnqERLLqoIp92GD92jN4NjCHizO8CVM+UZMoCkyah4I665VU6RvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovwI50sY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52048C4CED1;
	Sat, 15 Feb 2025 00:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580776;
	bh=18gY+6DNEY6pm3vWq+D6ujWxKSDxDmMWkCpBg3C4kX8=;
	h=From:To:Cc:Subject:Date:From;
	b=ovwI50sYHPvDuCNdAtmm/diy3+7sjRnAxjQvFxRltR2vSR1aK9SwhufnXSs08c1bY
	 SvGyE+sbayWKiryq61Pdzt4p5c5wCBYEn/stlbFt322ZnM3tgcReeWlA1ZEvFn9SmB
	 A5lClx5fgRT7VI5S77KE/eR8f8i1upQ++qC2nnIt2Zr6nX1R1EFU8BvzOOTlIToJyB
	 DRMSCqPzNRrKp1guhqn/K8TPITflmd/47YYP0019oAR0SbcIBXQliijmNwVA/vWfO4
	 aBbqzjBo4sIyE012lO1g4eMUuqIxj9DBYnF/yMFn7RAP1XO2hJhoD/Q70ohjS04iOy
	 ZHu03G5EEzVIQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 00/17] amd-pstate cleanups
Date: Fri, 14 Feb 2025 18:52:27 -0600
Message-ID: <20250215005244.1212285-1-superm1@kernel.org>
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

Mario Limonciello (17):
  cpufreq/amd-pstate: Show a warning when a CPU fails to setup
  cpufreq/amd-pstate: Drop min and max cached frequencies
  cpufreq/amd-pstate: Move perf values into a union
  cpufreq/amd-pstate: Overhaul locking
  cpufreq/amd-pstate: Drop `cppc_cap1_cached`
  cpufreq/amd-pstate-ut: Use _free macro to free put policy
  cpufreq/amd-pstate-ut: Allow lowest nonlinear and lowest to be the
    same
  cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL enums
  cpufreq/amd-pstate-ut: Continue on missing policies
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
 arch/x86/kernel/acpi/cppc.c        |   2 +-
 drivers/cpufreq/amd-pstate-trace.h |  13 +-
 drivers/cpufreq/amd-pstate-ut.c    | 204 ++++------
 drivers/cpufreq/amd-pstate.c       | 589 ++++++++++++++---------------
 drivers/cpufreq/amd-pstate.h       |  60 +--
 6 files changed, 414 insertions(+), 474 deletions(-)

-- 
2.43.0


