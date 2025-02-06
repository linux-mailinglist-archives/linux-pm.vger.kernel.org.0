Return-Path: <linux-pm+bounces-21504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87A7A2B473
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59A91889F98
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7E237166;
	Thu,  6 Feb 2025 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7I85GHo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4EF225788;
	Thu,  6 Feb 2025 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879038; cv=none; b=uuinjt7GT69JRHvF76T60hZGeBvGQ4Ragz/wh4nomLlqi13wv0+cHm+lAl1752h4sFQGcn16p41phkZWtVLsp0UnviPiwRApoPErGpnHoHztNnMcRqoiXLdhrZKhxiIm9gXEbeZV6IeExMTHI1iGZmtxfeCUHQjeISo1DKBDpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879038; c=relaxed/simple;
	bh=qyJVdQ+9t+VSBqEWpzaB4weHTSvRdQHND/+7+Q+2sl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhbGLRdDdnqezoLYLOuvIdCsI6CgxHSZ7qnih7giF3Ht19Uomc/ItazEgBsbT2j6VYjijmYsXHgcBzW8YXMoAmV7g8DnqDxQgNTPwIsD8XpJQtM93Q40KRwUAtNHx+BIUqhCO0+QvFLMolbTQuhvjKnGp4HjoSN7dUDrp2TZmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7I85GHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CC8C4CEDD;
	Thu,  6 Feb 2025 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879037;
	bh=qyJVdQ+9t+VSBqEWpzaB4weHTSvRdQHND/+7+Q+2sl8=;
	h=From:To:Cc:Subject:Date:From;
	b=B7I85GHoHIM80++j/vRkd8VuS1A4hMJSjcDt6kER0QdOwIUOWAOKIJGogsEXthEbk
	 n/RIyhoLEcfJ8cql0IJosE/Q/RAvpXPvhrdEhYlpL1WtJ08LOrqcd2siMnlH2GiMvH
	 Fp7cpjj3IfaB2WyqFvFQFvzDn54VKwrYjFro3Qolmz2sOMGqhq5aZwQpOSIlXK4j7/
	 rwaPmsbfZTCjuln3ZrcubATcv1FBBsLkz0FwNm9Vv24pY+5IdNmTAMkPlK2ekbQxFL
	 01aQD01fi1UilDEs+r3k3YXSydnhJfcP6MHSJLPNcO0HlaQFWI32V6OaDk2swm4Ixr
	 NgFVYLn2PKTRw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 00/14] amd-pstate cleanups
Date: Thu,  6 Feb 2025 15:56:45 -0600
Message-ID: <20250206215659.3350066-1-superm1@kernel.org>
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

Mario Limonciello (14):
  cpufreq/amd-pstate: Show a warning when a CPU fails to setup
  cpufreq/amd-pstate: Drop min and max cached frequencies
  cpufreq/amd-pstate: Move perf values into a union
  cpufreq/amd-pstate: Overhaul locking
  cpufreq/amd-pstate: Drop `cppc_cap1_cached`
  cpufreq/amd-pstate-ut: Use _free macro to free put policy
  cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
  cpufreq/amd-pstate: Cache CPPC request in shared mem case too
  cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and
    *_set_epp functions
  cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
  cpufreq/amd-pstate: Drop debug statements for policy setting
  cpufreq/amd-pstate: Cache a pointer to policy in cpudata
  cpufreq/amd-pstate: Rework CPPC enabling
  cpufreq/amd-pstate: Stop caching EPP

 arch/x86/include/asm/msr-index.h   |  18 +-
 arch/x86/kernel/acpi/cppc.c        |   2 +-
 drivers/cpufreq/amd-pstate-trace.h |  13 +-
 drivers/cpufreq/amd-pstate-ut.c    |  72 ++--
 drivers/cpufreq/amd-pstate.c       | 632 ++++++++++++++---------------
 drivers/cpufreq/amd-pstate.h       |  64 +--
 6 files changed, 398 insertions(+), 403 deletions(-)

-- 
2.43.0


