Return-Path: <linux-pm+bounces-22953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A6A456F8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2AF1897842
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6FD26B089;
	Wed, 26 Feb 2025 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2p9gC8v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553981898FB;
	Wed, 26 Feb 2025 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556182; cv=none; b=k8Pa0J4+Tt6rmxQ5W+rPy9l77WWCk7eUWYZqIDX3jgol2oIIty99JJIsPAUyjPP8zNWoOO0azMARCkHTNlQHTmLhQAB7Oy5dUFh4oGVvyX0iPjiINPGt/xMkzsdZdovrK5f2JEiQ2ka0kaL/sKjPZD0MGxhGGe1uRcLGRfV/MfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556182; c=relaxed/simple;
	bh=/V3ZHo7uBj9PHC+wKXtMnji8efJpacOWurlYYkXuH1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvvxRINUeSdFed8qbZbNBat7jI7g2M32fwIRpmgGj73uxGIwVq0j/ZJQ4az7vJF4qQBw/XQAGpl9o2xJ+aq9nXC4Lb9ndZK7BIL/V9Iu5QfOgIfy0U+OZA0htfqS+RRS4MSt0wVtP0gL7IAft14choQXSVT8j8dd/budg08/Y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2p9gC8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA736C4CEE2;
	Wed, 26 Feb 2025 07:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556181;
	bh=/V3ZHo7uBj9PHC+wKXtMnji8efJpacOWurlYYkXuH1A=;
	h=From:To:Cc:Subject:Date:From;
	b=h2p9gC8vevvOKvVYf810f9caaRHqSfSXzE4DOwlcHE5G9M0RtY+TS0+peDuqc5cO6
	 ypL82rvRMxP8M7dVXhFLjw2cw+cmf46T1ICYEXwKp4IHESR215kNw827r8RRpaJt4t
	 4TX8jMXwBepJQZfISVPeaOC8idjGrBxBt+ecDHYr7YjqMJFmMPzN/pLRnXK3UuD57T
	 Y6OKTC0yvEUKSWQany+/YO0kp09wibS1JzGIjwGj1sBwbiX8mYpcvuYjEld+KigrdD
	 YZ8l0ulgnuvX87aveOKAmNr6kPlzhIjs9btB0knAwiOmnkuDCV/VNRW76Pu8V1eFyI
	 EweLgMVLEwVuQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 00/19] amd-pstate cleanups
Date: Wed, 26 Feb 2025 01:49:15 -0600
Message-ID: <20250226074934.1667721-1-superm1@kernel.org>
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
  cpufreq/amd-pstate-ut: Adjust variable scope
  cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
  cpufreq/amd-pstate: Cache CPPC request in shared mem case too
  cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and
    *_set_epp functions
  cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
  cpufreq/amd-pstate: Drop debug statements for policy setting
  cpufreq/amd-pstate: Rework CPPC enabling
  cpufreq/amd-pstate: Stop caching EPP
  cpufreq/amd-pstate: Drop actions in amd_pstate_epp_cpu_offline()

 arch/x86/include/asm/msr-index.h   |  20 +-
 arch/x86/kernel/acpi/cppc.c        |   4 +-
 drivers/cpufreq/amd-pstate-trace.h |  13 +-
 drivers/cpufreq/amd-pstate-ut.c    | 211 +++++------
 drivers/cpufreq/amd-pstate.c       | 574 +++++++++++++----------------
 drivers/cpufreq/amd-pstate.h       |  63 ++--
 6 files changed, 395 insertions(+), 490 deletions(-)

-- 
2.43.0


