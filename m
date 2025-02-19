Return-Path: <linux-pm+bounces-22491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8010CA3CAC0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C3D170B3E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E4254AF1;
	Wed, 19 Feb 2025 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfwFldB1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED02254AE6;
	Wed, 19 Feb 2025 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998997; cv=none; b=WW/qxVgKPjTu1u0BJU7A+gZA4538m3LUDl5DaUwLMuBwXDlxwcu3c8L6LuWMIy5xkEk0YT+aUWPQpy/nDrb6feMFQmOa5L+0aBelP2Pk9l/VLmFWnssoTTcFb7tovjDULFvqRpaxck187csSA2yjWieLbF8+tQxmVTw/+48x82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998997; c=relaxed/simple;
	bh=k+HFaT5jkPeAjxY5OGyFCobMAN7g40O2kDoAfi0OX30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvxcT71/BX/DybCFTQ9qUn2ZN6MHWeD22Y7cENOww4p0SzC9/wwnlTf5T35sRSpsjzlVrdDtIlDRm6+7y5Ojbz8Uf1N31+lAmYcroqMStpt214SAlN2mSpZGUe4LaXzIbLW7+QsFwYp1ZmQmAZse7dklfLjw6HcRPXQ01gQb4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfwFldB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6ECC4CEE6;
	Wed, 19 Feb 2025 21:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739998997;
	bh=k+HFaT5jkPeAjxY5OGyFCobMAN7g40O2kDoAfi0OX30=;
	h=From:To:Cc:Subject:Date:From;
	b=tfwFldB1Lq/tcGbWxq3MK8fIkf63tsZYqJN0Kke379p+6GWwR3X5ka5MBlHXvm9wa
	 O4NxCxNDK4f3N7CTy0zwSnnfSzMWbwtdgefA3v4TLhPWOItwr+QW8PhYBusFkw976Y
	 t3sHH6oB0aB2Bw9kE4XUONk3uHysVf/bQQqQcvsiY4LHfiavXn4a/R7f5zuQTwTdwp
	 MQTE1JKpTVknvthSiCHOQt+eFHWbMErGjZZa+7VBNVDHTrl7VJKW0eyGXIY8bNP14H
	 fL23loazmNlc3t2VB1VkPUIx9RW0sGsDAPNSKOG45V4KjwM3uQNGI4YA8apC+YnGGJ
	 1snq+rJN6+0tQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 00/19] amd-pstate cleanups
Date: Wed, 19 Feb 2025 15:02:43 -0600
Message-ID: <20250219210302.442954-1-superm1@kernel.org>
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

v3->v4:
 * Cleanups from v3 feedback
 * One new patch to drop unnecessary extra call for setting perf on cpu
   offline

Mario Limonciello (19):
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
  cpufreq/amd-pstate: Drop amd_pstate_epp_cpu_offline()

 arch/x86/include/asm/msr-index.h   |  20 +-
 arch/x86/kernel/acpi/cppc.c        |   4 +-
 drivers/cpufreq/amd-pstate-trace.h |  13 +-
 drivers/cpufreq/amd-pstate-ut.c    | 209 +++++------
 drivers/cpufreq/amd-pstate.c       | 580 +++++++++++++----------------
 drivers/cpufreq/amd-pstate.h       |  61 +--
 6 files changed, 410 insertions(+), 477 deletions(-)

-- 
2.43.0


