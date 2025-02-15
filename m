Return-Path: <linux-pm+bounces-22130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B5FA36A3C
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEC516992B
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A8118DF73;
	Sat, 15 Feb 2025 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpeg5uVz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B79518D621;
	Sat, 15 Feb 2025 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580785; cv=none; b=c9DWtArTzb33Y47fRLH4lfFDN9JnMBFGxTx1pviGnw2LY/U50FsDxP3AqQJrT0DsEnDNciMlRj5uYrMKU4U8jTs0kekhcZuk7bj6jNTIgPoBtfcvfBbdS1aVZxvtR0akYnwPkesKl47t+A09HnN09L9sQRrPfiJ4aCbHwP62xJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580785; c=relaxed/simple;
	bh=rZnTJqR/mLsSGJcr1XZN1rPWL3Yz0qdpYqa0wrjmoOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF9h0uBHFFFe/z8T3HBEVYwBG/yZQsJ5OyPXemKbX7wfqijiZwrQ1c8VQPgIHprp3nS8GJDTs7m4YtkBH6PAwW+ITFo0vumRFcEeG4Za7bK1kOQELmr4zj9WoUwRGGEanS0c7kTq5UN9ha9VI1PX6LIH+dOZHq0o9VpBupqAOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpeg5uVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4808DC4CEE7;
	Sat, 15 Feb 2025 00:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580784;
	bh=rZnTJqR/mLsSGJcr1XZN1rPWL3Yz0qdpYqa0wrjmoOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qpeg5uVz0scxAEAKm7LovHsauAYc1vnkP+kPVtKQDxnUDo11og1uuI1u+0PFErXYH
	 pu6h+vi/b3mwSLuezVBQvKTj8Qq/WHT47BeC/cZUowncj216b8q90iHk/RZB6blzcr
	 L7potArnqG3vWZpEpYw5FDMemlMCS226FmKkmesWuWO2Jn4uKjimf6zylHA9O1nIf/
	 pB/la3OBuxXGi1M5DfQEMqV8HOSLzBrAETsX9FkkvLODNaE0Bky31BuKt5lE3jyMUY
	 IBDLL72FXxtV1vHJLGlKiLn4s6HE+GPLvm52DudlyMBssRpRah0AP3PiDQjG/Si6gz
	 8e4InjhZr0yww==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 09/17] cpufreq/amd-pstate-ut: Continue on missing policies
Date: Fri, 14 Feb 2025 18:52:36 -0600
Message-ID: <20250215005244.1212285-10-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005244.1212285-1-superm1@kernel.org>
References: <20250215005244.1212285-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

If a CPU is missing a policy then the unit test is skipped for the rest
of the CPUs on the system.

Instead just skip the rest of that test and continue to test the rest
of them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * new patch

 drivers/cpufreq/amd-pstate-ut.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 028527a0019ca..b888a5877ad93 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -121,7 +121,7 @@ static int amd_pstate_ut_check_perf(u32 index)
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
-			break;
+			continue;
 		cpudata = policy->driver_data;
 
 		if (get_shared_mem()) {
@@ -193,7 +193,7 @@ static int amd_pstate_ut_check_freq(u32 index)
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
-			break;
+			continue;
 		cpudata = policy->driver_data;
 
 		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
-- 
2.43.0


